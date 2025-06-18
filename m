Return-Path: <linux-iio+bounces-20753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAD6ADE195
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 05:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A59A7A235B
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 03:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF401DE2DF;
	Wed, 18 Jun 2025 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgVIqmxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B81DD9AC;
	Wed, 18 Jun 2025 03:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750216653; cv=none; b=iDZ4EESghewLqX0VyokGMIbjWM/n9wl14ntgB4SwcuJzMNK1yDBBK00qPblpWy8E7hVNWC3Irm6NpFsDqpI5HV+LLJOfkVCBDR6FfVXYwPr8BFkU40RDatdGx194yAPiV5X0loI+G0I/GHQ0tW+8Rz6mSVHqdH9TIery0TubytE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750216653; c=relaxed/simple;
	bh=9WOaxE3LCm/+eHOUl/ASfJhT6s3N74YJM4Mwqqwh3rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkVci9IHw+BuUEBUjadnAthq6MnoGv69G1be7E/LRKvstnIDv59PmL1g6Ib5Y7ty6LkGzlrXBKRVpgD8hAKMl9ZLFyEluH0NkNdq3b8dp6LYBvqALBhAn8V3eCrZvotXjla7Q7xUHREolrnYQOf2bRsJqEpB5fSdJrVQMvxC5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgVIqmxb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23633a6ac50so93669315ad.2;
        Tue, 17 Jun 2025 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750216651; x=1750821451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL915nnifSKujTPSpiOOuMQduAOxvrKpwnj9qgnMTJ4=;
        b=jgVIqmxbu2scvCd7BFro0wd48chaTG/kBY88vgXacc+e3ZpMxH1BySvyRwfiQ+PH91
         T61+jpAko8QblbY66am8kL3lVpE57VAMjN2Ltw0UB0D2IHsHeWnrwcwaeCyMwwvqxrlX
         rWb8PYC7jpRRozz4nwyy28qeh6OaBZbTVP06/2SAb1GAEDNsq8F6hXJ5wLnzzdhUNRIn
         3h85/mSZW6ot8nEXmLhzR2OWxVga8hw/R8d67ZsjPUkqaV3ystIhgfyCr1stBld4ezQ6
         qribZyni2GouM1V4R0fJsV4qedSPmHMCtFVqzj/KG4/0k6ukXgAhAesXG++RSjL6H5hL
         d02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750216651; x=1750821451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL915nnifSKujTPSpiOOuMQduAOxvrKpwnj9qgnMTJ4=;
        b=NTsdgYKGOeLiq0eVtZxEStDVrYTs3DDsvqI2ve1dbgGsClcuv0fe3eTgkOCy89AFNd
         2H30AaTSS28Rm286YtB48sW6hd0kS+QKe27yBONnongTqm2SY61kXQN3r3gnKzu2zrjs
         H0V/6NBgiZ+MjlRYU/4bmfykEfAjmqHa9llG8ZLX5tqdciJYTtOyPu1Wv+vnL8NjyZ7X
         E5E+uWzcy7Y2H6Q+mvlRqsNmqiR6ciVeus/RPMctaRh2ng2qzBu5qOXg+/sVlseeGjEr
         Vp+IoJ+qzpHoq+2OzjzvG2wP48G5YePQ3SCLINMnQIOgA5IOBKtlPJRU2y+yoGGqCdRm
         6n5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNlXjwc50epzsMa6b0zTLvyuCyHdVK8iV6ATBG1rXX1NvxuM1T7pGNH+hs6vANT01EleNbZRjcQLl/4dDE@vger.kernel.org, AJvYcCWn9gLTHeA9k/vuEdAkzprHtfztouShgO4sCcsRCOr4HeziwUbD134ploFN0f6n0omPgg4QVn1+coM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqqR7J2uF5C6fovuOA+X0pKm2mMFaoINGAz588KOYgBr/GySH/
	h6NOgx66/UH1kZwM/Htnb67cOlM34rlOnto4HVRk50IAz9su6py7jC3I
X-Gm-Gg: ASbGnctMIC2GfzJ/gdTw6r2kBjKhAIgy1SILy8nZPfuuFxb4ktuvgCXHECwbGYkKH55
	U4v3zA7cqPGHbfTQCaKpdcalm5ETBvdIHWqVOrTWSb2mUcvkcRXiswglggIQcY9yYj/OE8+Sd1R
	1q8pAundPAJzjjBsaR8VcsnlgWXuOyDa99iKSIwI9nML/ZvvRQuEQyFfn2dT+Pe/ktv0lZoQ9Xr
	6D6TVOkVIVRh1kTq7s+8VcLRH9+ohNq9C2MZPC+iA/ErBKuz9a5DkVywqylesR3kwoRRBG/cjkj
	kyPOPqMxhu8FIBdaaW5rdWIfua42AUWlXCeeKLh3HG4gENCAF9c2NyTi0y9zthWG1A==
X-Google-Smtp-Source: AGHT+IGevqF23RYle86b3gblSZ2n1YkwD8f203Lu+qLcDNwukM+M7pNeux2fhYFE+uTv2RfU7e5NIw==
X-Received: by 2002:a17:902:ea0d:b0:234:8e54:2d53 with SMTP id d9443c01a7336-2366b3f8713mr237977515ad.45.1750216651231;
        Tue, 17 Jun 2025 20:17:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:31:2ce1::1005])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365dfdb9a0sm89179545ad.239.2025.06.17.20.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 20:17:30 -0700 (PDT)
From: Andrew Ijano <andrew.ijano@gmail.com>
X-Google-Original-From: Andrew Ijano <andrew.lopes@alumni.usp.br>
To: jic23@kernel.org
Cc: andrew.lopes@alumni.usp.br,
	gustavobastos@usp.br,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	jstephan@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] iio: accel: sca3000: clean sca3000_read_data()
Date: Wed, 18 Jun 2025 00:12:17 -0300
Message-ID: <20250618031638.26477-3-andrew.lopes@alumni.usp.br>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean internal sca3000_read_data() helper by removing unnecessary
arguments and return logic.

Signed-off-by: Andrew Ijano <andrew.lopes@alumni.usp.br>
Co-developed-by: Gustavo Bastos <gustavobastos@usp.br>
Signed-off-by: Gustavo Bastos <gustavobastos@usp.br>
---
 drivers/iio/accel/sca3000.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c85a06cbea37..7145b4541264 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -939,7 +939,6 @@ static const struct attribute_group sca3000_attribute_group = {
 
 static int sca3000_read_data(struct sca3000_state *st,
 			     u8 reg_address_high,
-			     u8 *rx,
 			     int len)
 {
 	int ret;
@@ -949,18 +948,15 @@ static int sca3000_read_data(struct sca3000_state *st,
 			.tx_buf = st->tx,
 		}, {
 			.len = len,
-			.rx_buf = rx,
+			.rx_buf = st->rx,
 		}
 	};
 
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
-	if (ret) {
+	if (ret)
 		dev_err(&st->us->dev, "problem reading register\n");
-		return ret;
-	}
-
-	return 0;
+	return ret;
 }
 
 /**
@@ -984,8 +980,7 @@ static void sca3000_ring_int_process(u8 val, struct iio_dev *indio_dev)
 		 * num_available is the total number of samples available
 		 * i.e. number of time points * number of channels.
 		 */
-		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, st->rx,
-					num_available * 2);
+		ret = sca3000_read_data(st, SCA3000_REG_RING_OUT_ADDR, num_available * 2);
 		if (ret)
 			goto error_ret;
 		for (i = 0; i < num_available / 3; i++) {
-- 
2.49.0


