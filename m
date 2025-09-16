Return-Path: <linux-iio+bounces-24192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D190B5A418
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6057B324A
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B937B2DC34D;
	Tue, 16 Sep 2025 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jn3PbtYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6131BC8A
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058792; cv=none; b=OHZa/mEbaa9i4siUVNWqy0IxbNDav0SHrqfNY+P+GdnrwYzfwadfrvXQwWR6pPcK6gf4/z98KeqwheFs+5xSgXH9olC6sfAsO5NPWCbQDlgBXdNlSgNesAXv65SClordpQIn2zu+tuzb4z9y7eBpQMyc/9/iYdLywJB4kXwse78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058792; c=relaxed/simple;
	bh=alWkRwRAHUDZB7EnggR/adBGG6zbmWfLbEJBfdYcj2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q2iubYDlef5CwEqZQ158PDnBB+ixSamx27uN0U+j6sVKwdz5QavNafL6bTVkPzRf7f1dPW+nnm11izE1wWBjirBnVjcU94L7ryPPsG8OyuRKrWGckqeLdDdPn5vsbIILn77GGlWg0laDngJOOIE5mHeN2XfHbiD9HmRmwXpWGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jn3PbtYV; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74ee68bd763so1823931a34.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758058788; x=1758663588; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zxLzz2OSGaMAYAW1znXjOojON6qtPgLCC+6TCF9gO8=;
        b=jn3PbtYVtg4bx8s4NMqfsKpMnpQaUQiHg/7D3pEIY9fQs/kz20WhFpIz7Xn2y3cUja
         402roG2cSJKR5Uyrf5OlDSRid1BXxJFy8QRiotlLFKyGr0C5q5KERuh/pR41xgkHjubs
         rQSfu4a4XDjqzNe7W3fsHWwaqORV1Bt+b1YfEo6a5nFUj2rqhQQhBMhjxdm8dpJIRPFc
         ovKH+LDl12KGUoR3zJLKkfcoJfVBHvLzPE121rtzOj/lQBU/NUrdQd6xZ+cHXABn/DYh
         wUFF2PVq59GoyebBWuNfhTPGrvIKdk5BqMa3xt5mFeeXTX2Ncl70QJBpJkCQ3mspBPkF
         9KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758058788; x=1758663588;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zxLzz2OSGaMAYAW1znXjOojON6qtPgLCC+6TCF9gO8=;
        b=Wj9+6bF8yLQxpKEZUgKKus/HgtLeQDI+Lq6+b5UVziXmoW0MaPYRK0319SUaNi08W4
         zi95nOXsIMaztmVNymWT5VPZX6mFQfR7IHvItRbEyjg7wTXwvd/ZV+tXmB9u0rBMaUUc
         ml3pZSlx58s7SjUaryAnIgfrGLg4J73sEjcFoDO0heMNVsyDMgxX/tJGxyzUqXMqY5+M
         gOtRrHhyNdG+YJ9iySJe/X0kx8KAMS4+IcSDNC8z4Y0yeU/N2xzr/sMIpz9cQyo1sS6g
         JVDQuT7UX1Ta4XXwEzuz535lF9lF4ddETBDxtvwzqImTMOQvlyIJbI3z7HlIWCVRqOFQ
         5ySQ==
X-Gm-Message-State: AOJu0Yy8TJwyxTQn8QtXZGFhTyGmzO89R0VNwEw0CtToIzduo66KFhtI
	sV8LDQ9dFFO96+zSVUqMJKVM17YxCbuFHo7ZPEwx8JqHvTBWByhh7tU/T49RQB0ml4c=
X-Gm-Gg: ASbGncvcMLAzM6R59GlABE09Je6peO2iY423uxPiE0Nxxi0kIkPbdeHa1gez7USvFe9
	6snbiOWPov8eOOcWBJbyxpVCSKps1P/dHQiOBTkCOwkCQ1i1X3r2oAQUcZE7Il8FuX1Dk87MQYs
	3Zhkn65kh2rtnd17X1iVI4JawfuScETb6PHXh2B6WwPABWauub3+24NbKcoSxfvwtBMi7ZGwH6T
	NNYQmZTORHhDXmYHfQzwaJWUYotI09Dw0GF4MNcM9i37zkAbiSuFct4YrmUpvXQMPOsu8BC/tQE
	espVOmKyJAI8s6T34yIYodf8sKE1qMuBnT1ZNYopLbugcJ0kqfEIx4vycjjxbR8FyOI558g5rDH
	qUQX+iICfejbnSmm1Uvuq+gd2tkky
X-Google-Smtp-Source: AGHT+IGre/KCb6a1RdLu4xBexWyZJStZZ/+A1kmo1GEcLIld1R+mvNJEbZVCp1l/G0Io1jEPSJJ6Eg==
X-Received: by 2002:a05:6830:43a6:b0:744:f113:fef3 with SMTP id 46e09a7af769-75355ac0e09mr10835133a34.30.1758058788173;
        Tue, 16 Sep 2025 14:39:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7576393e95csm2683819a34.22.2025.09.16.14.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:39:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:39:39 -0500
Subject: [PATCH] drivers: iio: adc: ad7124: remove __ad7124_set_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-adc-ad7124-remove-__ad7124_set_channel-v1-1-aa7a2cbec8a0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABrZyWgC/yXNzQrCMBAE4Fcpe3YhifZHX0UklM20LthEEilC6
 bsb9TCH7zAzGxVkRaFLs1HGqkVTrLCHhuQ+xhmsoZqcca05245VE49BanrrTpyxpBXs/d++4OW
 /xYgHhwGtHA2kl47q4DNj0vfv7Hrb9w8ib8fsfAAAAA==
X-Change-ID: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7c6
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=alWkRwRAHUDZB7EnggR/adBGG6zbmWfLbEJBfdYcj2k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydkcshTt3rKPh07vfUj25Gmmk4zbnBQP0CdbV
 caC14z5M1qJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnZHAAKCRDCzCAB/wGP
 wO2VB/9lLJmpbop69c8faJfzJi6En5Nu0hHK394RXRbavKAIflgT3rMscwYEqim0vZ5ATfUW+kY
 hKQyOY7m00BN6w+YU/ycSh2luVmpQ8zuXr7XpNDcTUIGqXbW+i25fur3435sn5bnFsp9Bg5xCsA
 Elt96lWZx2yYHZobqeHQPFG7Ykb0CIdlngW4OHe5iWqps8V3d3ZpmDd8PtnSY+f9W+64nufh+M5
 RN+HDYxIDHjS2E50eZ1mrJNuSdxxSSLMHfPE0Lf87PvNJtNFdig928meNiREa8Vv7voKkJMDAhH
 lwjQ2stPwBU7chNRTWgjv+9A5JdoCl4sFYJO7P4AbZwEDCiH
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove __ad7124_set_channel() wrapper function. This just added an
unnecessary layer of indirection with an extra call to container_of().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Just a small cleanup while I continue to work on this driver.
---
 drivers/iio/adc/ad7124.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 910b40393f77de84afc77d406c17c6e5051a02cd..c24f3d5127cb83eeab0cf37882446fc994173274 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -657,20 +657,13 @@ static int ad7124_prepare_read(struct ad7124_state *st, int address)
 	return ad7124_enable_channel(st, &st->channels[address]);
 }
 
-static int __ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
-{
-	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
-
-	return ad7124_prepare_read(st, channel);
-}
-
 static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 	int ret;
 
 	mutex_lock(&st->cfgs_lock);
-	ret = __ad7124_set_channel(sd, channel);
+	ret = ad7124_prepare_read(st, channel);
 	mutex_unlock(&st->cfgs_lock);
 
 	return ret;
@@ -965,7 +958,7 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 	for (i = 0; i < st->num_channels; i++) {
 		bit_set = test_bit(i, scan_mask);
 		if (bit_set)
-			ret = __ad7124_set_channel(&st->sd, i);
+			ret = ad7124_prepare_read(st, i);
 		else
 			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_ENABLE,
 						    0, 2);

---
base-commit: df76e03e8127f756f314418d683bad24b460c61f
change-id: 20250916-iio-adc-ad7124-remove-__ad7124_set_channel-d8e5c30ec7c6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


