Return-Path: <linux-iio+bounces-21319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CDBAF819A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 21:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382431CA1BC8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD402FA63A;
	Thu,  3 Jul 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s1f6IN/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEE2F431C
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572290; cv=none; b=pAogeD4ApcBkYKMjQtkdlk1zur5lUxgYFNf50aB/ZaxFOoaig6eATAXo+0Z8dQKzFEwMcT75mS0Um0yeqUXUUkzfFhSbenazBvI3a41Ee7vqiiCxatGWurNqdt+fGq3TKZoSooac7gkWLRhJDLSfUmSMD9jH4oFzujz6qcVc0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572290; c=relaxed/simple;
	bh=8+rfOhAZJ5zpDxo/gHwlDR+PyPMfFHPGV/0Evol3Ukg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p9u2gVW9opsFAgotibYVXKhBH0I7KFS20ZwOyySEayKPMPKF5CXfQxJbHisbE+W0DxJxB93fqktLh10g7n4iiqivdvFZE6N2P7lgYoeNToQO2zvc3u00x9Csv5HnW0SwZ2gQe1QzH1pEWLipPcYrtt+abz7DUx5OwGgK512kzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s1f6IN/J; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2ea6dd628a7so239629fac.1
        for <linux-iio@vger.kernel.org>; Thu, 03 Jul 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751572286; x=1752177086; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qqX46Ikvu2J8+FmRYWool6QuLD9cHW/4YH7HWsozgA=;
        b=s1f6IN/JT2V8N2QxbthMQM/69KdgCFlL/BUCtxSaLAEYG9y5LVLOzd6VPmC1x4IjvE
         hsJdRWY//9o2dx8EWWea829ulLarP3l1P+QzBqqS2lhQINdtGKxMbm9HaIOM2IO0+ffP
         ROHeAqlvZ14Ywu7MwqYzhEGWhDsXJEFxEyMn12h2QpN+OzkUvN1Ek3xI6EFKE+69FB+d
         wIP0VsEDc2taz6KJL7ArowZDXtf2APaituj7C50YwqLF1LbOkTA5kXmMZRpuMH6VJOQ5
         AhCWUsVdSl2zgFmu58fIsNASTOMdtqdiihSc2mCWVeX0TP7APc/AH3Cfd1M3Y5+EHdUJ
         wGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751572286; x=1752177086;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qqX46Ikvu2J8+FmRYWool6QuLD9cHW/4YH7HWsozgA=;
        b=BRDgaZzfpySzrQB24wDEekdzq33HQ8FAQ/3usJuXz3Ib8lsGWe8dmuekIlztqDMaCE
         ovL8dgreU9f4qZ5tadg32n5kJwk0lXZ01ryEVwOx2BhLJebTriHficMAPqHvkGcZ95KP
         RRrummTJPoh4OW3RFBL2dTraX4UnT4457bkN+hykxBqSVp3L7i+BP19giiVc37Hcjgt1
         XbC+zifjog4JXQR3izsqZf3wplCTm76XabGSWxSPInHEt5mOPn21qJ8WkkRBeYfdFh9O
         TCt44s/VB8puSKr+CJryLKD4p4voV9x9sxqX+Xmb7h3EIh8F1IkRYFN1qZQ/GZWf4pvP
         9UVg==
X-Forwarded-Encrypted: i=1; AJvYcCXZWiB7F3G+piousAieEpwUUYSqvnxHJ1C+44PW/reUqI97di69tduUBCXGQOvU9lozihUKermto20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoXlDxnONsTk2tli2/njpEhzqv1zs+ovVbgLrrKfBEgpSO1SR
	ug1dUSRlkh/oG/mU5ah7z0ZXqBKkdn4J3IVPE3L2UimsNZkOh0Vo3iiiifpJ8xgl2Ls=
X-Gm-Gg: ASbGncvqHtyo+yipQQ0vd1c/ctsSVHQnVAcRqsRN8mHsZJFmFUjt25sDP1L8ML7pvzj
	9oC/fIVqRNMVD8/rdkgSVstRs3qATwVBikxYvYq32xg1HPJ96y1wqht1MK82CpAQr0hjbod2prb
	BSBsNxSzSOnfOSAcEDGMjzHpD9gRuP421YMZ49hWaBwrAypPtR7QCo7LB6F+a3Ke1loBAP6QUdT
	Xly9O+8t0Q3JU/pLl+10MQrbykUKKKyfVhcjEZ9Ez90mmslNvG1rCHL5GFISOFG2odZFmY0gxOo
	HQxJFZ7HYVDLVGRk50E507O0+vptvWW3Wm50Ksu6QIkofOma2UE7DVBazC3k5k6b60HNnBsF/m/
	H/hs=
X-Google-Smtp-Source: AGHT+IGEVogMmfIX4PhvWen00vY0nQ9rDbxfq9pneJ66y5sm0YOfwoo2GUn4GQ2tp656C4Ku5OrIXQ==
X-Received: by 2002:a05:6870:e243:b0:2c1:e9a3:3ab3 with SMTP id 586e51a60fabf-2f79200f771mr136377fac.33.1751572286178;
        Thu, 03 Jul 2025 12:51:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4f2b:5167:10f4:c985])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f790277918sm81451fac.43.2025.07.03.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 12:51:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Jul 2025 14:51:17 -0500
Subject: [PATCH] iio: adc: ad7173: fix channels index for syscalib_mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-v1-1-7fdaedb9cac0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADTfZmgC/x2NwQrCMBBEf6Xs2YVtGwnxV0QkTba6UBPJQqmU/
 rurhzk8mDezg3ITVrh0OzReRaUWg/7UQXrG8mCUbAwDDWfyNKJIxZiTxfd+xFk2/BULL4pSMm8
 414b60RQXme6vmhldmBw5DoEpgS2/G5v3f73ejuMLtxEHYYUAAAA=
X-Change-ID: 20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-49b404e99e0c
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Guillaume Ranquet <granquet@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=8+rfOhAZJ5zpDxo/gHwlDR+PyPMfFHPGV/0Evol3Ukg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZt82s9XxXvOtyNI7tjqprD0rw2+0QJKtIROQj
 sLZ5QbA3YWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGbfNgAKCRDCzCAB/wGP
 wFClB/49Fk+Y36IL7xIqufegNhdCaW1itta5xNGVmm9+fy9Z+L1Dl1nwsHi8bQL1V6waCytIF62
 2tbLSwDkmOylBtuGY6vtl4eEaPsQ1ZlL0vSA9aagcuOjcnIt9uDeMtl0kxLs+26yM6SqK/pDRXc
 4U2F1+PqKfe4iNxIcvHqFbzURCkd0NVaHy6lRye9gmUDaVwlhDMn6QdYxYw4bRU6WR23tcIOtI1
 CE4vQhUMSOjA9etS3eniyyAVvNRt27/CtoI4VOJ/JUpvaqNUQXksS/QpMdlnmluOeWR4/lypJKa
 CoLXT3uRqzPKGGLThwzx8/etYy+UtIzGb/56UEfbBG6ERe9D
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix the index used to look up the channel when accessing the
syscalib_mode attribute. The address field is a 0-based index (same
as scan_index) that it used to access the channel in the
ad7173_channels array throughout the driver. The channels field, on
the other hand, may not match the address field depending on the
channel configuration specified in the device tree and could result
in an out-of-bounds access.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c79ead5a1b88d1dc6cc3db122502be..03412895f6dc71fcf8a07d09eb9f94a3840f02ef 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -318,7 +318,7 @@ static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	st->channels[chan->channel].syscalib_mode = mode;
+	st->channels[chan->address].syscalib_mode = mode;
 
 	return 0;
 }
@@ -328,7 +328,7 @@ static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	return st->channels[chan->channel].syscalib_mode;
+	return st->channels[chan->address].syscalib_mode;
 }
 
 static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
@@ -347,7 +347,7 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	mode = st->channels[chan->channel].syscalib_mode;
+	mode = st->channels[chan->address].syscalib_mode;
 	if (sys_calib) {
 		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
 			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,

---
base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
change-id: 20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-49b404e99e0c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


