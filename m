Return-Path: <linux-iio+bounces-13863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285529FE77B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 16:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9CD188159D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDBF1AAA10;
	Mon, 30 Dec 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+KE0hsm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ED81A9B55;
	Mon, 30 Dec 2024 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571658; cv=none; b=nOT5iDKd+oXRaC3KFdzFQym4stFIO1tvgQFGxZUIU/8L5L6wfk/7b1ZEB1OushAN1Q8mWxK/pqhY8iStT3Rbd6oeaCInlZRCIFVH+Ky3+RO7SmiPoVDA6wsnlxbmxxrg4hHTJ3QvHZU76xDvn3vo/VxNbBsesTxBg3fDKHdLw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571658; c=relaxed/simple;
	bh=PcNKUDs3Bs8UHPyFQ7410p4p+V8hwMyriDKAr7C60uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Az+zSd5ZmzACmBCgeUn8urb/nZ6WblxYzMw1Agvsqs/fpY8G9SGEmAd7NEwmvyjsI12Y+U953RaRYX4q/TNdwGsp7P6J1GdnDxQnBMQzzn/5SCkca/e1vguYi7riVzaxcn8YV22lG3F2KbPFyYIhcpbW/G0nlByYeIR97pG1YbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+KE0hsm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso62769385e9.0;
        Mon, 30 Dec 2024 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735571654; x=1736176454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=159qfROq98cPkbFuU0SvsItHXSDJ/ujlzlE9sC9km2Y=;
        b=e+KE0hsmJ3w8Ccs4P9+XywcxZoZ7TzFp/SRtkh6ZKKwX+pRscl8XByTGFMrWK5gtDk
         gbJ1nz0g8sF8/GnD/NkZWBYKaFcO0tiJXbByusBpevuAGSq0kMczcK+XVWfFaY3ClHZV
         Tbe+pf8GxhCAIPFeBhqHXegj/n7fIwpz3auLUenBHQKWBa70VJsHI7IXZ1yyhasrBadt
         xGeByQpcXe3I81LJBEoWN+J6XyYSGcHYzr4nR/G9ONA0HyH5Q2/PVFHXCo9m6WtbimZd
         jx4sd6rB2b2qZMpAawr1w4AxrH2po3MfxHcwS6MO8GYMHbdFo+R58IhqgevO31wgjk5k
         6k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571654; x=1736176454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=159qfROq98cPkbFuU0SvsItHXSDJ/ujlzlE9sC9km2Y=;
        b=HH8crgrpNgvKJX4oNuwlGkRucJbEPBs5hhsZMcR5iuKXTleKdZc9j+jRJIQk1ssfNW
         zexcdiQoeeYFNfYpcfVfW7yly4mh0PpWMoibUWNcadnSfCAwU65HL91sXjY5VZfhxrnl
         e8uHNzvrAY8r+aIS2QUpovfXt7+0nc7iGfzaM8YZXyEVV8n4XVXM0lRvfk/XvAGo9lvw
         mrTjzitAVeKb1sQlODF+1ElHxLW3kQv2C9Ub/B++38ygH9Z6hgDt6xOk9B0XnTm9/iR6
         8rgHvLpe1kM8d8SXMZCYhLs4Eg4rwL5fFLm4QUa+mJSovSfIc9C3nBexZfRJv77bmxqH
         SOdg==
X-Forwarded-Encrypted: i=1; AJvYcCUwn0rn2gHmgvw6yNF9Pn5b81bYUkgwRHzwR2NeIbsL9bP7NEb4ti53p6tB+ERXjPrQfNIOrlziyYiyW/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9gNXfpUbhn6JKRoR19Auy8BIzhdfEiM3gCXYqDKAZhx1eRJmc
	GqsFvb7gN3XqgwLydEhVplTs2vd3LhLhi+dyGYUBDdQQVbtMaIda
X-Gm-Gg: ASbGncvxM05vENr4Uy7UstNicISWVNhzFin4HRHr2Ph32EERDg3uG3eEtwT2ovHnBrM
	K8aJ0KsGwsm6RL/AgpbwGSwpaPU7luyxhkF0WUfeS6och7bH8eFpi0e9S6K8URVHZk2iOJO9wRZ
	J32OoB10iEAjprPXwy0aHHImDR6Paj4+h7ntPq59oxIm2mp6SFfaWtf03KWQk01QFFEQtsSEI9D
	uzRSaSPAQr9/05tDNngDfq+PJ14WoVAmmQeFVycRYSwIupYdRvtxESvAAj/IcKENcgnAmBAmwjh
	OmX5/sTCU1Pk8q2OFWS1pTS7vRAN
X-Google-Smtp-Source: AGHT+IGh0XM9w1J1nsrRMyzNdY0EsC74cyoxa4ZJ3DeE9bqxVmInlyZ7M8Iy2/mUPvKB3Ll6vfDiRA==
X-Received: by 2002:a05:6000:4012:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a221f9fd4mr33760766f8f.28.1735571654396;
        Mon, 30 Dec 2024 07:14:14 -0800 (PST)
Received: from [127.0.1.1] (82.158.190.253.dyn.user.ono.com. [82.158.190.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea47asm358056485e9.4.2024.12.30.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 07:14:13 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Dec 2024 16:13:52 +0100
Subject: [PATCH v3 1/2] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-veml3235_scale-v3-1-48a5795e2f64@gmail.com>
References: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
In-Reply-To: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735571652; l=5887;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=PcNKUDs3Bs8UHPyFQ7410p4p+V8hwMyriDKAr7C60uk=;
 b=f3IgeruW9/PI2AVddWIWfmeKdBl2Hup+nwdCEhzYqsoUZWBVEEXqA3OU0XjQQT/NbNLc0NjWz
 Dk6Na614DeSDYt5rkh94LXtPeG1fGgIFeqmeUYCUCF0armraKMViUDI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This helper functions reduce the burden in the drivers that want to
fetch a gain and time selector for a given scale or a new optimal gain.

The former is currently achieved by calling
iio_gts_find_gain_sel_for_scale_using_time() for the current time
selector, and then iterating over the rest of time selectors if the
gain selector was not found.

The latter requires a combination of multiple iio-gts helpers to find
the new gain, look for an optimal gain if there was no exact match, and
set a minimum gain if the optimal gain is not in the range of available
gains.

Provide simpler workflows by means of functions that address common
patterns in the users of the iio-gts helpers.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 77 +++++++++++++++++++++++++++++++++++
 include/linux/iio/iio-gts-helper.h    |  6 +++
 2 files changed, 83 insertions(+)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 3b5a998150623ba43c2f015c2c5d8a757743b893..d70ebe3bf7742906960c6af22102682c5b8dcdfa 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -915,6 +915,41 @@ int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel
 }
 EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_for_scale_using_time, "IIO_GTS_HELPER");
 
+/**
+ * iio_gts_find_gain_time_sel_for_scale - Fetch gain and time selectors for scale
+ * @gts:	Gain time scale descriptor
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ * @gain_sel:	Pointer to value where gain selector is stored.
+ * @time_sel:	Pointer to value where time selector is stored.
+ *
+ * Wrapper around iio_gts_find_gain_for_scale_using_time() to fetch the
+ * gain and time selectors for a given scale.
+ *
+ * Return: 0 on success and -EINVAL on error.
+ */
+int iio_gts_find_gain_time_sel_for_scale(struct iio_gts *gts, int scale_int,
+					 int scale_nano, int *gain_sel,
+					 int *time_sel)
+{
+	int i, ret;
+
+	for (i = 0; i < gts->num_itime; i++) {
+		*time_sel = gts->itime_table[i].sel;
+		ret = iio_gts_find_gain_sel_for_scale_using_time(gts, *time_sel,
+								 scale_int,
+								 scale_nano,
+								 gain_sel);
+		if (ret)
+			continue;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_time_sel_for_scale, "IIO_GTS_HELPER");
+
 static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 {
 	const struct iio_itime_sel_mul *itime;
@@ -1086,6 +1121,48 @@ int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
 }
 EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_old_gain_time, "IIO_GTS_HELPER");
 
+/**
+ * iio_gts_find_new_gain_by_gain_time_min - compensate for time change
+ * @gts:	Gain time scale descriptor
+ * @old_gain:	Previously set gain
+ * @old_time:	Selector corresponding previously set time
+ * @new_time:	Selector corresponding new time to be set
+ * @new_gain:	Pointer to value where new gain is to be written
+ * @in_range:	Indicate if the @new_gain was in the range of
+ *		supported gains.
+ *
+ * Wrapper around iio_gts_find_new_gain_by_old_gain_time() that tries to
+ * set an optimal value if no exact match was found, defaulting to the
+ * minimum gain to avoid saturations if the optimal value is not in the
+ * range of supported gains.
+ *
+ * Return: 0 on success and a negative value if no gain was found.
+ */
+int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
+					   int old_time, int new_time,
+					   int *new_gain, bool *in_range)
+{
+	int ret;
+
+	*in_range = true;
+	ret = iio_gts_find_new_gain_by_old_gain_time(gts, old_gain, old_time,
+						     new_time, new_gain);
+	if (*new_gain < 0)
+		return -EINVAL;
+
+	if (ret) {
+		*new_gain = iio_find_closest_gain_low(gts, *new_gain, in_range);
+		if (*new_gain < 0) {
+			*new_gain = iio_gts_get_min_gain(gts);
+			if (*new_gain < 0)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_new_gain_by_gain_time_min, "IIO_GTS_HELPER");
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
 MODULE_DESCRIPTION("IIO light sensor gain-time-scale helpers");
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index 9cb6c80dea716cb80b69bee5277230bafe1c9a95..e5de7a124bad6eb65414df364f84e81301b0690b 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -188,6 +188,9 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
 int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
 					       int scale_int, int scale_nano,
 					       int *gain_sel);
+int iio_gts_find_gain_time_sel_for_scale(struct iio_gts *gts, int scale_int,
+					 int scale_nano, int *gain_sel,
+					 int *time_sel);
 int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
 		      int *scale_nano);
 int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
@@ -196,6 +199,9 @@ int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
 int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
 					   int old_time, int new_time,
 					   int *new_gain);
+int iio_gts_find_new_gain_by_gain_time_min(struct iio_gts *gts, int old_gain,
+					   int old_time, int new_time,
+					   int *new_gain, bool *in_range);
 int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
 			int *length);
 int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,

-- 
2.43.0


