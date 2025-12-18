Return-Path: <linux-iio+bounces-27157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9F7CCB25A
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 10:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10459301739C
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098502F49EC;
	Thu, 18 Dec 2025 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+9F2JoL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEB2DF3CC;
	Thu, 18 Dec 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049688; cv=none; b=Qxmib1PFhY7U3aeDNPaFoLXYBFSBWHz7I5eljku4ZHMOfM4ugG58QafwPqZayoVuJR4SkNz99NRY+po93YikdhhLo6KLS1ATSIONN4edCd7aIIwLNV/6P6XpOHVtULqipQUhXlMDpyP8wQ8Ks6H+NwIL1pBIDYpr0tyI2J5zJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049688; c=relaxed/simple;
	bh=8wOqkmX7LkUaghR0SMNaUUS3rjNmoZbHhY88IFPI2iU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nySKNyhb5/+wCq0IGloaTVxB4DB7J/CgoLQrMKBWHUA4vIRq9Fjof6O1/tfwn8YK+/VHyRTgiig+U7Z/MwogFTYygdtFc+ywzLrt+5OwVXxV6aNr9AkOC9UnvZEGCc1Mx/++00wh31LwhGjfiq3IW0FbicNhtbYHOTkccR3nH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+9F2JoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36221C4CEFB;
	Thu, 18 Dec 2025 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766049688;
	bh=8wOqkmX7LkUaghR0SMNaUUS3rjNmoZbHhY88IFPI2iU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F+9F2JoL+3jq4gsKSE5ZM9bwZzjg8ixbPD0PoltKVd3WyK+sEACCcJD6dG/5mKwnH
	 +EZQiPPgpfdZyy8K4E+OAq+iuLc7TgLqpcTnKfe8K23jtoFqR/sYcLN8GYmJ8Zknyt
	 eef1DQn5AjdOBFHSt2Lczw6QlOmJukd+FzJgWRyjtoDFZ/WDuaz1Uy/+gjrV6Qv4P6
	 muqaotpzBowfoXILLw1wrm8PoWThZTdlulXf8J+EHGi25I6WO8V3ZgohycjT01TUDa
	 LUTKzxmA3jYJi5GcDfHMtptYamBgfadCUxKnv/IiCeEtzcqR1km16nCqYEr5pozW6o
	 VizvHMNVAZCRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2436CD68BED;
	Thu, 18 Dec 2025 09:21:28 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 18 Dec 2025 10:21:17 +0100
Subject: [PATCH] iio: imu: inv_icm42600: enable temp polling when buffer is
 on
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-inv-icm42600-do-not-block-temperature-polling-v1-1-909fbd4e240a@tdk.com>
X-B4-Tracking: v=1; b=H4sIAIzHQ2kC/x3NTQrCMBBA4auUWTuQHxPEq4iLNp3WwXQSkliE0
 rsbXH6b9w6oVJgq3IcDCu1cOUmHvgwQXqOshDx3g1HGaaNvyLIjh+1qvFI4J5TUcIopvLHRlqm
 M7VMIc4qRZUXvrFXOh8mqBXozF1r4+/89nuf5A7Em3ER/AAAA
X-Change-ID: 20251218-inv-icm42600-do-not-block-temperature-polling-6533056cb30f
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766049687; l=1221;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=f8du7ktVd1utCvuUW65hpIirqMUqmiPXKFlXcsmlnPs=;
 b=ZCNYy2rpUCxw6rObHvdBmygmmhqh6cvA9p/fHoah6C5d4KEC7oI0wBA4vKneYKveRBdIztIz3
 ARuX7tUQSklA7BLdxaksTEBK8KTcLDGPeXLfI1MTmD17irg00I1I0kG
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Delete iio_device_claim_direct_mode() when reading temperature.
It enables polling of temperature data while buffer is on and it
doesn't have any impact on the other sensors.

Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 30f6a9595eea2308ef9ab0660210fc14ca758198..727b03d541a58a27cc9d793da78d1f4a1c460297 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -59,10 +59,7 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (!iio_device_claim_direct(indio_dev))
-			return -EBUSY;
 		ret = inv_icm42600_temp_read(st, &temp);
-		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
 		*val = temp;

---
base-commit: a7b10f0963c651a6406d958a5f64b9c5594f84da
change-id: 20251218-inv-icm42600-do-not-block-temperature-polling-6533056cb30f

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



