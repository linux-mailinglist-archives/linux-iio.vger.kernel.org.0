Return-Path: <linux-iio+bounces-27944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8CD3A440
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 546953029C71
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E406359705;
	Mon, 19 Jan 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SICmyfT3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70324357737
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817095; cv=none; b=IwVO1iWi9+C7wfen389WnwnfdoGTfIMgrNkb/FUcDE0/P/VRyl8o2J7nOZZB5brU5AnjkUG57MBUjiF+BZYU6Fv6230k6fZL6tCvYNlBjcblASMO/l5cfpyjbQkM4rzJbCD5XpqNnazyMTpJbL9mQ6rujCwrs1Eq++gFgSvAzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817095; c=relaxed/simple;
	bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HavzCps1KjwkL7sohNunCDGf/t+mnifMO3oTqCrV0biovCHVrIDSNxL7iIp9RMXDaHxgfYZkp7xTWopPUFAD8pP54c9yg/B/MXDJ/OT5C/q6YI2AR/sBqkJmDoS0B0JVW1JD8joaJ6j2UxVyr+fibnyAWd/Rqj4TJHeIW6xsffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SICmyfT3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8765b80a52so663785566b.2
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768817092; x=1769421892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=SICmyfT3WauIeYm1hdDlDKFBVwruQTeOZTc4sKAiSViWpuzUvb53aUK/kcz/bEOaWo
         Ut/19UCLOJvScMS0EnqviVdD2T7O4v+dQnAtV1avg6uq7eo3fkUuCd5Gh8PMfHjHCD/1
         dviBX9HJYAO1vBVoHMA1eXflAPJM7aBs/0F9OPYCsUrPDv8sLBEvik9DY6TpMJAyMx9s
         h33Jt5OCCptdk4hPE8IAIaJb3yao1stUUc3DB6uTewmw/8hcgSxCH3GBV+9+7+KtWBMo
         CQiLgQjrvAYDOS4LoH5PnYhwY6c+T+5RMSsMbOapY3h7OkOt0evQURosuxDpkUWuosZM
         ap1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817092; x=1769421892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=CTPoPDblB229ZOpspb1/youfx/M/4mDz/8P+eBRctpeU3429BxybCkjaxVDO/kHEKC
         +8Yx6gHWviEZ7PjLhApPfepq45URgNiK0+rIGhA7rwEuhFoQFaI6kxfykyFIyual3GmC
         zpgX4iKpSsseYbouTBx5hN00kSxxIjM3kUr+7EzYLnSyvm89Tfhf7niXn1EkKxjSMHj2
         Oro9K64N/KFqTUTWwf/Y7et/n1DCT761DY8dxoofs75O87fDv0lfpqxje7EzW5qfAPsy
         LRWe1S43WYwYdpVUIJoYI6HV9igCqlujEu9R9HmM0YCXuwSfaU7Rkfbp7Xenaw5wyKc2
         PVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUOVP/5CPnVUeQcjSlDhaiAPs/V4dYzZPRN9FkbJUKurTM3h4MdS5Fuybh9rT7j4SU0WQFOp7/NoMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpg7NGhAZD3cCvemdSS2rrSqJwIEXTmFtWwzNf7xrJ09oruU7H
	SHosN1ok+ZEcaI6x5EpOxkzOGERy24pWopVcfAw2lj4zi8dw37NwrvJUXmUouK5Y8EDIPj7g0DB
	Cf8LRdXw=
X-Gm-Gg: AY/fxX6I3ZK7aBSy+CaJSIr1Wqof0UzHaUQFpuNdYAy0fKxbdlCZZfp5Y568HFe2ZRj
	FtPC7YFPlCLfPFiUXCmJkg5dZNZdjDfZwt/ohLHxNwwJ/jS4nvT2DE/WPl5A+0w22ykOCXbqggC
	uUMxHSCFQCwyii0UH9RT/leznWqr9fDhE6yprpK4O/Jc5VSC8IL4k5Nok6dWXkKmlc9QGOMwcDN
	M06avmP7kt05TdrZr+3CQfUNMUB4ZoBTxIdOHuiYMb9hnZd2W2xEN//P8TsQ1x/m2v6Hk4RG3dr
	VrQqDyBbEpKnv7JN5tg/4Mj1PhvJGWcWYzlqljDs2M/5Gcqog5sn5+9JYcZpb5IMId6Li4Vod88
	uqEyD5hSqCh+fhDyWR5oF2AVCFRrMzDGMhwhEQs5dpXpgTuwAVIQJOYY=
X-Received: by 2002:a17:907:6d27:b0:b73:7b97:5bfb with SMTP id a640c23a62f3a-b8792f79634mr963249466b.33.1768817091611;
        Mon, 19 Jan 2026 02:04:51 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cda145sm9797493a12.9.2026.01.19.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:04:51 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] iio: imu: st_lsm6dsx: set FIFO ODR for accelerometer and gyroscope only
Date: Mon, 19 Jan 2026 11:04:47 +0100
Message-Id: <20260119100449.1559624-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260119100449.1559624-1-flavra@baylibre.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=flavra@baylibre.com; h=from:subject; bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgGowZOLCXnAHBgihNqEZpm9U7tlz7gxjSjf/ ONRRLt/DCKJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4BqAAKCRDt8TtzzpQ2 X4b3C/9T+3fo5duBrXG1i+844DEj+97f2r0YKyGOfC5Q9X4PFTJjMtq2tiFwKBZw6YyzuWtv9Rw kQkcCUphhHrbcMBtU2qf7dBNtvxTMnaQtkpVOG1jlknJy5+0gUVYsUOSElGhGqxp/e3PIuGDBOA xJNTKF2TH11yi5LxOtWGyKL5wFi5Qy4Qt85Yd+7f+gdy7K0p+yIxJH+y6a/56Oq3Eg6SypW9s/O BVyHqckVeDlAvI3q/qC6jVnH8tGvzQtxTkQS3kMcQRl5U++kQaPYnb8qOlW9A0GlyrCUtpoRF21 /rXaM/KVADCyY8mxNYzDXxUlJwFse84GHApTBAiGZzLkYA4HJcMewrVzerYsPsv9YWCS9B65STN Kvrku56MQY+Lt2RF1LGdckAaP8EnG+TzNfVA3KQQorJqAihhBhtmaV8Q2ng9lMBeMFZT0bvwy7C 7USbHep8CyMjfI2q4+6JVriI6+3SeV0lWv5+UY/nFeCufj+pJ84th+Zfa7VDpx2r6OWE8=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..1ee2fc5f5f1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5


