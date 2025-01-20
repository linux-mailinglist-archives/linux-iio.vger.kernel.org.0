Return-Path: <linux-iio+bounces-14499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D91A16E1B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 15:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CAF3A8331
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555771E1C36;
	Mon, 20 Jan 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aT29hZnw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537CF1E1043
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382047; cv=none; b=sLaxAmrdafJgZaB0M+ewAfzr4TPqAl6TA0yQnI9yH5rdddYTPAiSFCK/cSszMA/IQxYQVr6EgKHKJklqHPsOiuHLuLEOdf4uy+aSZAEF/4zSyytT5v8MKnDVbVwyf4qW/4qiTdePov/qfLcUENcsh2kigzcCdyq8nmBDjd0zKeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382047; c=relaxed/simple;
	bh=mpAejTqUjX5Bglp5n2bAYKSlhgN+b8qEFQQM5avMn9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5IJDIPjtzxeFBWOjuKVyLinYEZdQtt415KxG4AR+uQWvrrxIxiQLKVsA8wwwKj2DoE84yTJ4FSiFK29eHB6yK5ac0x3UqatGIOKHNikmvVwKvPTRw8LoFMFdzmRidfO52qQaqhJNToEJtMdQWlwFSv7bBdc+IgOp1zm16Vj29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aT29hZnw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11217007a12.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737382041; x=1737986841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ypm+zuetNWm7m3R6X5Zl3qocwsI0cof2KB68qxMB2L4=;
        b=aT29hZnwGLoca3NHmyQue8UibBZd+HDRf6NVHllE8QZyM4pXSQ2CHiEl+Zj+a/2OEy
         +hb2qhsKXjOwjnQUmTM1F9sFt9zLvvfwt1dVqwMh+NFAXnO1c7moJ+hwzEDiJ//iN9YD
         tDrq+EG2cQijbH60SoITn7EsdqUNJSYd253IW8IkNiBEW6OPmFNYGkFeKe6IYSBgYsZW
         HDmuyOe6jGu4BbNRG4jrFGVolgoFwXLsXPAEXOZZkU6mPKExTo7GgTYwdnhFstTT9hu5
         bggrjmbaYQZrN4Kl3DbV41pHZVWYUSkPN+iasEfwzImsoyH6QGRWBNGZCd6KzjrbNKB/
         gWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382041; x=1737986841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ypm+zuetNWm7m3R6X5Zl3qocwsI0cof2KB68qxMB2L4=;
        b=sFO0bSiL44nn5o8u2y85xbUE6SGFbBOKUcMnSmPFGWmmhhImgLAqc4vXjDbfng2wWX
         8L0dthn8dzEGAPOOSnrbWMY6mZOfdcNWczv36S1xsKAT8+wlnOX7Vr8qAN06XKcCppEM
         b4xEjj/ujZ2hk+Q/xfPScn+zS8+HMhVRQWs11FbwSEwKo9KsHPh6fe35HbzfY82i+qfN
         XFP3v7qxQjA2k3rLHm1XIrZdLbuAUHSOV7yQ74yY9Kud2hb+RGZcl3r5o9uNJ8qM8yUO
         K1y2AacUtglzv7CsL/1VI5OMVNxMnZ5fAB4xUq0VJ6xSo74mbCZctJBcsFQznYaWuETJ
         PX8g==
X-Gm-Message-State: AOJu0Yzg7fiir1w1brvFhodowC8yLJ7VUWDK/HbVrUtsHkZMkv88xAo0
	VbK78cUgRcQv1HY4oC+aWVW5WvqQ8jIOmrVV7IUPOBS583TOrAVdu7aqeXSjvuCLRwG9wPb/hpQ
	j
X-Gm-Gg: ASbGncsxYOHCORafyd0WH+fu30KphiDyFsJnjcd5R1gt8cUlvwF4C/4gsZod4WAnSyS
	a7fKdtLDBSzpcI/MTeJEbMcRqaygIpO2gpO6+HtnGOAUzf/WgQFIS8qNcZVeSQ3veUA3UXq1nF5
	bbzdBUD2GBMeQOURhUJ2p7wu3071Xukl2vQV41aGRfQCYgLxYjkrAnK/L9PoJbusWbgnstRSN9C
	xWWeHlwUaqMNitjofHgTygmVLnGYbESsuocSYf6XKnXXzvmCX2lwbqVwCffl8IIuMp7QsBlLQc=
X-Google-Smtp-Source: AGHT+IHRa+DZKBmetUaov+7Kjtm9B8MeYtxruKhd3BOm6Df5ZrsrAhREjLkWFhsVJUueXJurmeU2Wg==
X-Received: by 2002:a05:6402:51d3:b0:5d4:c0c:70f9 with SMTP id 4fb4d7f45d1cf-5da0c27e591mr18895942a12.6.1737382040705;
        Mon, 20 Jan 2025 06:07:20 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edc913sm5788006a12.73.2025.01.20.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:07:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: adc: ad7124: Micro-optimize channel disabling
Date: Mon, 20 Jan 2025 15:07:09 +0100
Message-ID: <20250120140708.1093655-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=mpAejTqUjX5Bglp5n2bAYKSlhgN+b8qEFQQM5avMn9c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnjliNO6zBSal+WnA+vNmvQBXEXdrI1VApoCL8X MbhOLnj0RqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ45YjQAKCRCPgPtYfRL+ TsAcCACKg9grbfuGsV+Z6XMznfNG1qMe7qRi8qLfjTISt5t+NGIN4iqnEcRaoQ5wIk2a1sWkUML 21Dvk4qOAurPNn2jEigOn1JpxL2+EH0Dzexol1DdIGAgGSfQR9LSD7HovjLnPoQ4e62VRJ4VNRV mp4GKKA5bC8F+6q5qg4OI9j+ZH7/t4zU9pEvNeXBw38Yd0x1FFSAKnUdrLSKddfO3U2sFvRREn2 EDfQ8Z2AHkGk78pkaQTgve4x/sNweoWHahi+lVgDiRvEiIKKI0tev1EccmH77ev8hHfxwtLTjph tF0Sso3pbzG/AgHNkr8Y5pAzF1cA59DHO+1iNri3qOJ62XGO
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The key objective in ad7124_disable_one() is clearing the
AD7124_CHANNEL_EN_MSK bit in the channel register. However there is no
advantage to keep the other bits in that register because when the
channel is used next time, all fields are rewritten anyhow. So instead
of using ad7124_spi_write_mask() (which is a register read plus a
register write) use a simple register write clearing the complete
register.

Also do the same in the .disable_all() callback by using the
.disable_one() callback there.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

in (implicit) v1 I only adapted ad7124_disable_one() which resulted in
the very legitimate question why this wasn't done for .disable_all(). I
haven't checked because I wrongly assumed that .disable_all() used
.disable_one(). This v2 now makes the latter true and so .disable_all()
now also benefits from the micro optimisation.

Best regards
Uwe

 drivers/iio/adc/ad7124.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6ae27cdd3250..2fdeb3247952 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -540,6 +540,14 @@ static int ad7124_append_status(struct ad_sigma_delta *sd, bool append)
 	return 0;
 }
 
+static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
+{
+	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
+
+	/* The relevant thing here is that AD7124_CHANNEL_EN_MSK is cleared. */
+	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(chan), 2, 0);
+}
+
 static int ad7124_disable_all(struct ad_sigma_delta *sd)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
@@ -547,7 +555,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *sd)
 	int i;
 
 	for (i = 0; i < st->num_channels; i++) {
-		ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_EN_MSK, 0, 2);
+		ret = ad7124_disable_one(sd, i);
 		if (ret < 0)
 			return ret;
 	}
@@ -555,13 +563,6 @@ static int ad7124_disable_all(struct ad_sigma_delta *sd)
 	return 0;
 }
 
-static int ad7124_disable_one(struct ad_sigma_delta *sd, unsigned int chan)
-{
-	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
-
-	return ad7124_spi_write_mask(st, AD7124_CHANNEL(chan), AD7124_CHANNEL_EN_MSK, 0, 2);
-}
-
 static const struct ad_sigma_delta_info ad7124_sigma_delta_info = {
 	.set_channel = ad7124_set_channel,
 	.append_status = ad7124_append_status,

base-commit: b323d8e7bc03d27dec646bfdccb7d1a92411f189
-- 
2.47.1


