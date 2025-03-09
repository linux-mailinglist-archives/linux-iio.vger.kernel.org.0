Return-Path: <linux-iio+bounces-16611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DCA585FF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B26B3ABCDF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 17:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3251DE8B8;
	Sun,  9 Mar 2025 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlwJteqZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DD2AE95
	for <linux-iio@vger.kernel.org>; Sun,  9 Mar 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540027; cv=none; b=GWUPAF01GUJ2B+SBrZ3pvmSl2bN9Yw8w2827IVBvXzsfHsiN1wb8mALGiwNNRXRaeMJZQNM8e1DvkW/5zc3VvNIgwZ5U0bJWz4wXBIaOR9X5doxufNU/czEW1MI1PfZnUgkzWHGDComQOlo/SlVjiNmW2uU49KtWw+0YNROjHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540027; c=relaxed/simple;
	bh=qpRnEnZ4pw14sPoygXuw0RzYxTHO9SwgQbBqYm0YGV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUsBBA5mFzL16UK0/tmGTFEjaV6IoFXtPctv8OScbY/W4DKfxvfBrgPHO7OLFBILMzuVMG5d5eTYMRvvx8giA639lSfzXCTjOBoW6YuUVs+iHK2Br1NAzpY6q0vj2Gh77HGo6O6Si9KiwPyjPet3lQVj9fnuuQkBCk9Y6zPI6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlwJteqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52CFC4CEE5;
	Sun,  9 Mar 2025 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741540026;
	bh=qpRnEnZ4pw14sPoygXuw0RzYxTHO9SwgQbBqYm0YGV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlwJteqZc9+FDlaLotw2ob6CU9dGHa/tsyHBOP1AGcc1a27PfeusuvQon261foM9b
	 MrBIQKMmQteofqgawtGi8u8DZp6bloVcW1uPQ7jngDUKlL2soSWfnLjerJtnTG/hxa
	 NeLjhcsPZlBCDanCIM5d/YEvsJ7+pwvOlvLawMOjiL9K51s32PP6qtRHoJ7wfLzbOr
	 lwhxoASa1GF9AAItCwkhzDnd7O02/T3SsNKkBXzlXNwTKVV/plvAPdly2fSUKn0ZUi
	 MhjbpREE8bsytJ/Nw87lDQaFS39DEao5N9Xb2z/KeEEBqsTLJ0cUoxkGNqjc8o/PEy
	 Buy92IyYcF7iw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Astrid Rost <astrid.rost@axis.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/18] iio: light: as73211: Switch to sparse friendly iio_device_claim/release_direct()
Date: Sun,  9 Mar 2025 17:06:20 +0000
Message-ID: <20250309170633.1347476-6-jic23@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309170633.1347476-1-jic23@kernel.org>
References: <20250309170633.1347476-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These new functions allow sparse to find failures to release
direct mode reducing chances of bugs over the claim_direct_mode()
functions that are deprecated

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/as73211.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 4b73ce57a3d8..22422ca89e64 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -419,18 +419,17 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
 	case IIO_CHAN_INFO_RAW: {
 		int ret;
 
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
 
 		ret = as73211_req_data(data);
 		if (ret < 0) {
-			iio_device_release_direct_mode(indio_dev);
+			iio_device_release_direct(indio_dev);
 			return ret;
 		}
 
 		ret = i2c_smbus_read_word_data(data->client, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -614,12 +613,11 @@ static int as73211_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec con
 
 	guard(mutex)(&data->mutex);
 
-	ret = iio_device_claim_direct_mode(indio_dev);
-	if (ret < 0)
-		return ret;
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
 
 	ret = _as73211_write_raw(indio_dev, chan, val, val2, mask);
-	iio_device_release_direct_mode(indio_dev);
+	iio_device_release_direct(indio_dev);
 
 	return ret;
 }
-- 
2.48.1


