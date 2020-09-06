class ReviewCategory < ApplicationRecord
	has_many :reviews, dependent: :destroy

	enum name: { コーヒー豆: 0, インスタントコーヒー: 1, コーヒー飲料: 2, コーヒー用品: 3 }
end
