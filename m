Return-Path: <linux-iio+bounces-23802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0CB461ED
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A5F17C29D
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A977D31C597;
	Fri,  5 Sep 2025 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zzxglfxW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA831C570
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095970; cv=none; b=ducRh3lQmuGQZFT4u7PU9SmNyzCzHM1kyqzlF3DT5sA0EiDyhTOAxOXk0cbKpVYmDdUpuAefbVVCeVx0BS6DOGgxjEhw+78360JicAym1TsNythU7oscEaMNw8Q0vJGAxVWV79stGB/j37xYFQfM0k67rTmGOEukMD/qNGzScws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095970; c=relaxed/simple;
	bh=kx5uyvPHJnpni90op3iFGnjN7gyxEZMgcFaPdsde1b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAOXRjoIp6P6E9lcmg5yy4xoIIwr1F3uvnPq2nzkYRxjlOG8c55Fd0xu3tmqR5FFtF7Hoswv7IOxQ/9rC44ugx2v4VqUqs5yUEkll7/rj8jDrRahRU4GnOEJrv22aJR0m4zT+pwg+2RCKl6D8HWIkQapv98QfLZ3YXJgklUxZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zzxglfxW; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30ccec928f6so1168474fac.3
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757095967; x=1757700767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3g/UCnn4/ZEnTWGOYRS0g3qjMxVzhKkl5rubg7Uyi/4=;
        b=zzxglfxWCBbWOdD0YDKm7EczVYFcziADPIsMt/qgIpitJ10tES/WphbUrF7G1NtahU
         +iff3S8LXuXXQWDXsCRrHBjr0Ky4ocu8DB8AfLKNnM0dIf6yVRM39cPMPFg4nWIRYtxM
         IK8wIVTydgzaaRYGelKiGk5DzHfnei019MqfJdw5+gX+L9gKDQtmFm1UyKoHCIo8sTVC
         TasfLTaN6uk0yUgavdwWj2m5+aHJgc898R8k+3XX5UyVwwRpX+Yp3Vfxv/W45vgO4E8/
         8CRS9Wf7x3Occ6n4Hf8JtJ2d+EhNOQkPC3hfvvkh6bsLW4GbLbZaGc9s7dXy2TLbCLkY
         uCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757095967; x=1757700767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g/UCnn4/ZEnTWGOYRS0g3qjMxVzhKkl5rubg7Uyi/4=;
        b=CgW3FWuRx3Yds0VQOT/KfsOPato0Bj0qjmtk4UHZQXXXZVyhhKfA23ocKGaxvo0reL
         OvYzvM9jJDcXAlO85v2C0EfRD6XRzUwPZ/sKxmnUUGdOpB6HViWQYIZxHX/iV2oiIJ0n
         PXbKJcbap5MI36AXPm0G+eMlCalY5j1zekJm5ULPxGv46Ej1KS9a7db6Sow28CF+YLi+
         Kk9uhvklmX74UCEZtulov/WHR4VNlyEdlDDvPe+t22Bjk3ZQEL7187AMUXCoHeGb0Xgy
         LLSdUd74zYhDVskhR1qveVuGXGFKvgd7G7uDAmOrsH8TWqHTFymtVjjdYoS7lvfUhLnh
         zQLQ==
X-Gm-Message-State: AOJu0YxJb9s+QkutwlG7F7Ae323D4psGxbUxhCL1d2Qi5hzyX8/6KL2B
	4h9WdE7ImgRrc+G6DxpqXfSuyXKjQvrH7YCSIpW/hPyAPDbbz9OWnxG1uX6DjUHLYfU=
X-Gm-Gg: ASbGncvj6vpc3d66qRT0DaSteUlG1hdym98r3IAs7a4q4S/pPX674Hr/YRmT/FcTwDq
	eTZY9UyoPDbPkbwr9fWUtPYDW6vy8Pa3mmt59Ln3f7ru8vpVoDk8xeonYn05TFNMme711OMQdhu
	gzm048XpEdKiSh3BK2bFDFjstzwlbyU871deT+FK4QxjO5UpMm9XayF8qZ0fe3pqk9Kxh3pRzcr
	qN4KNG+skWedHwe3o6lSCiU9DRmYmHME6bfjoq5oC20YFLMulN91btTF/WIR9/TeJpR5BoGj4Fg
	g4bMoVoZ+KQbhF/UYxH9U6ZoEVdOPQQigb835/j2ayKi4eo3QAKTfOW3i1R1hagjGDwHZXn76sK
	PZ1NKCCtmMWgECquIGqEhdoTkpR0=
X-Google-Smtp-Source: AGHT+IF+rqHcZ5O3Yblxuqf4xfUFIK2sHxy0Ay3Nxeoe7ccO+CaEOtqHKkJIL3+4idGeldtQaxIXlQ==
X-Received: by 2002:a05:6871:e78c:b0:321:2772:dd0 with SMTP id 586e51a60fabf-32127726a92mr2099568fac.10.1757095967642;
        Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-31d686398e1sm3052292fac.13.2025.09.05.11.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 11:12:47 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 13:11:58 -0500
Subject: [PATCH 3/6] iio: adc: ad7124: use guard(mutex) to simplify return
 paths
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-iio-adc-ad7124-add-filter-support-v1-3-aee3834be6a9@baylibre.com>
References: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
In-Reply-To: <20250905-iio-adc-ad7124-add-filter-support-v1-0-aee3834be6a9@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=kx5uyvPHJnpni90op3iFGnjN7gyxEZMgcFaPdsde1b0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouygBZy5XyJMymkrm8NweZsbQhQ0Xndor7I7za
 Q8eX38z84aJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLsoAQAKCRDCzCAB/wGP
 wBp/B/4gPu4pc+ZBtlILyEsP5zzyU4KMnhP0WwhaABU/YX4quSKwp9mZ0g5g9p99SFFBDMwgAR0
 yGx8nfwI8Ce40blr1ZaoF8tJQ58iKZeuPNKQ+vyHI7JldEAZ8eaDnqFy7qNI20H/U/PDROfpHV0
 neJ4LWiAdkMcJnTOyZMh9Q6kq8ftK6b+cElryBdX/xCmkFfQaQkOd9o7id5AdTTgR7xXGX/LaWQ
 ZMJnfBu8FYqZ2JyVSk/MR7vBL6Tpe65zQTYNG0DGdCiPDwQLumr6xJ+ds54bfcV0jWTdZSm+y81
 rrEja5NG69lyTfbUpz+NmU4865IyILZFFSn5xgdXhMS9Si2+
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use guard(mutex) in a couple of functions to allow direct returns. This
simplifies the code a bit and will make later changes easier.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 6c17cc59f33c6ddc241e94d1b0f43bceced1e719..d0c6462bcf410efcc664b602beb94a9ab6a869c0 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -741,24 +741,20 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 {
 	struct ad7124_state *st = iio_priv(indio_dev);
 	unsigned int res, gain, full_scale, vref;
-	int ret = 0;
 
-	mutex_lock(&st->cfgs_lock);
+	guard(mutex)(&st->cfgs_lock);
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0 || val == 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val2 != 0 || val == 0)
+			return -EINVAL;
 
 		ad7124_set_channel_odr(st, chan->address, val);
-		break;
+
+		return 0;
 	case IIO_CHAN_INFO_SCALE:
-		if (val != 0) {
-			ret = -EINVAL;
-			break;
-		}
+		if (val != 0)
+			return -EINVAL;
 
 		if (st->channels[chan->address].cfg.bipolar)
 			full_scale = 1 << (chan->scan_type.realbits - 1);
@@ -774,13 +770,10 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 			st->channels[chan->address].cfg.live = false;
 
 		st->channels[chan->address].cfg.pga_bits = res;
-		break;
+		return 0;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&st->cfgs_lock);
-	return ret;
 }
 
 static int ad7124_reg_access(struct iio_dev *indio_dev,
@@ -812,7 +805,8 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 	int ret;
 	int i;
 
-	mutex_lock(&st->cfgs_lock);
+	guard(mutex)(&st->cfgs_lock);
+
 	for (i = 0; i < st->num_channels; i++) {
 		bit_set = test_bit(i, scan_mask);
 		if (bit_set)
@@ -820,15 +814,10 @@ static int ad7124_update_scan_mode(struct iio_dev *indio_dev,
 		else
 			ret = ad7124_spi_write_mask(st, AD7124_CHANNEL(i), AD7124_CHANNEL_ENABLE,
 						    0, 2);
-		if (ret < 0) {
-			mutex_unlock(&st->cfgs_lock);
-
+		if (ret < 0)
 			return ret;
-		}
 	}
 
-	mutex_unlock(&st->cfgs_lock);
-
 	return 0;
 }
 

-- 
2.43.0


