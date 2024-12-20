Return-Path: <linux-iio+bounces-13731-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1DA9F9A7D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B44D7A3BC1
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D5221445;
	Fri, 20 Dec 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMK6iFXm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309C2210D2;
	Fri, 20 Dec 2024 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722927; cv=none; b=trRUDO/Z3htsuMlm2zjYRV895RuV6BsLalcwmMMBR0IU1NFbUo5XfJjThB/Ay9XtK/1HAm3mYaHoLfGDDXzIW2wB+gYhqLOe6ZrxzgV3AFXXa5zRL0AhqzPSKVGSwq9Zhw3S0TINImHnHU3l6mH+FIlQZjIqdVXiXv7hj4QQryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722927; c=relaxed/simple;
	bh=lRIcob3MmLCag3pqwH4XZhG+3achPumKsGxUJQkU02I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6bgHZp7n1NhnriYOCy2Tu0ERR2Tbt+SJOJ1fDhtXPBeY+gY8wM5PlwZcnrsT+gFWzds9FtKaMhTspxCi/dptr7ShT4HfcFdapNKUNBiIXn7EmLtsbYQdcXvyHFD3nayEWUnVbYBt9YTvEh4m7W0ewwJDv+9gOvnioVCGoydhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMK6iFXm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385de9f789cso1757564f8f.2;
        Fri, 20 Dec 2024 11:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734722923; x=1735327723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49IMAEFWlOfYA59ZoLIUwcVsB9n9a6Z3uJBX/spVF/U=;
        b=jMK6iFXm3KRVUGaFaKwm9qDpobfgde9Fqd0FZembS2uaZJd2CXu8yJRLF8rPOlJqeD
         /PpUx0UJ1fS9oqy66z169RO9un6t68SODY5Z9Z44E+JcUgMKwSkeIxthN11CSXiL+j/7
         9Ei6IiuIGEyyenouyon6KYvFCE+JIh52lYQBnaTd1l7VZU7HQeAus/0+bYu59MP7MNnH
         7P/V1E59WnjoesF6uGzSDzJ/D9NeriAZI4tj9pkIaUpJxxTAHfcYShKD3mKYvio/0TBe
         HA20+7Wbx8sCubOSUuzjDfWHGLd2f6JZgjyCmMSfuq+RqrKvwQx+hLs9mVauKTeOLbsL
         rglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722923; x=1735327723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49IMAEFWlOfYA59ZoLIUwcVsB9n9a6Z3uJBX/spVF/U=;
        b=hgDxpqKZdwIZSoAxf/dit+1tGNXxRYjxj9Wa0dL7PqSgJhXB6Vl2O8UJtdC7WN7r5f
         5M1/E57yrIpUG14DUtmKUftPPU3SApiS6fnemjE5FSd+shlmQhAxHLZjhtk/oR1x4CSg
         zyS78mwU4PwZuwgX8ubY/F+HID5wahu5pg9FtSSPsDrifOfDZnA/ntqJmDkd4LjYFrVO
         9/VLQOINr3QqpvzxHD8lW7MB90fW2wbFEt346FRquyC3CZbmJ3E8xf6vyT+wTqn182EA
         zdlXyDzUHQ+oxfmF8Ck/4FrGXHStz0Fp3R6N0596hj3rV8WbqI3S5HDKNcW3774op8Dp
         BEjA==
X-Forwarded-Encrypted: i=1; AJvYcCWzMk139ci6XUu/CP8QizEKpzj8nWfyR3IV83zS8HscDLztPPo7/lUHpFEWwrsVj+yyXvibIcJBPFol8/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5C9epRmX/fkV54XoX0JJrgiE8UhYnHAKwWlgynybvTFB44S0j
	vntIeiJqLAXsRMBJnYEr0ohZS44A046LMOxheaanG1DL92vByv9S9x4+mg==
X-Gm-Gg: ASbGncvue0MMPNFHkTB6c/YBTcfcB7bgKekdy6A1szK3tN7RmSWLXPUSWtrCUq/qS7/
	796gvHun4E7N+C21UZAHf93hZOK8AXLxapWu5OP9N8h1LjrAZIobnDIeK7eyeHpCHbAWlMQCjmx
	jUaNapm2iZjYgJeokknHCw3o5D/lSljCq+JQac5L5uIELgxZqiYkVmb7DF4POhuePyINRabkanj
	AfQD5PNAN0wqWTrukzgExpCXR4jBUeKbYOxisEwkMqoafqjN7kMEzM1ftJib16qBKvRqeH+lGGE
	tH+uJwTQzui/Q7n3UtnjcXhm5jjFwcshGCrYLQ00pqlZngQ3KTI1xoF+Efx9nXXGxGS/xtEaPhp
	j0Gg=
X-Google-Smtp-Source: AGHT+IHjjYdiKigBLJwa+mmmFI7MPe3+6hEeR6DcSNuVd1RfkLPtPlHFv/EOpDKgHLGgAqKqSA9VQw==
X-Received: by 2002:a05:6000:1f8c:b0:385:f89a:402e with SMTP id ffacd0b85a97d-38a221f65c9mr4771256f8f.14.1734722922803;
        Fri, 20 Dec 2024 11:28:42 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e9bd-7e4a-34d9-3ba2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e9bd:7e4a:34d9:3ba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm4674274f8f.59.2024.12.20.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:28:42 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 20 Dec 2024 20:28:28 +0100
Subject: [PATCH 1/2] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-veml3235_scale-v1-1-b43b190bbb6a@gmail.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
In-Reply-To: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734722919; l=5671;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lRIcob3MmLCag3pqwH4XZhG+3achPumKsGxUJQkU02I=;
 b=IqjVrX/ZlZEEHBrvvJlJFvy2bzuzQucYaK5+4vnJ5vkur1Dv+nWl9FXLuAO/nRO5pCtNdT8Vw
 Ydglw4ci/SpDQWRDi0yQcVqWTDe+uukwwm2ZbWa01clidzlEChX5Ol1
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This helper functions reduce the burden in the drivers that want to
fetch a gain selector in all available times or a new optimal gain.

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

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 74 +++++++++++++++++++++++++++++++++++
 include/linux/iio/iio-gts-helper.h    |  5 +++
 2 files changed, 79 insertions(+)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 3b5a99815062..f88b0b7192dd 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -915,6 +915,38 @@ int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel
 }
 EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_for_scale_using_time, "IIO_GTS_HELPER");
 
+/**
+ * iio_gts_find_gain_sel_in_times - Fetch gain selector in the available times.
+ * @gts:	Gain time scale descriptor
+ * @scale_int:	Integral part of the scale (typically val1)
+ * @scale_nano:	Fractional part of the scale (nano or ppb)
+ * @gain_sel:	Pointer to value where gain selector is stored.
+ * @time_sel:	Pointer to value where time selector is stored.
+ *
+ * Wrapper around iio_gts_find_gain_for_scale_using_time() to fetch the
+ * gain selector for all supported integration times.
+ *
+ * Return: 0 on success and -EINVAL on error.
+ */
+int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
+				   int scale_nano, int *gain_sel, int *time_sel)
+{
+	int i, ret;
+
+	for (i = 0; i < gts->num_itime; i++) {
+		*time_sel = gts->itime_table[i].sel;
+		ret = iio_gts_find_gain_sel_for_scale_using_time(gts, *time_sel,
+								 scale_int,
+								 scale_nano,
+								 gain_sel);
+		if (!ret)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_in_times, "IIO_GTS_HELPER");
+
 static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 {
 	const struct iio_itime_sel_mul *itime;
@@ -1086,6 +1118,48 @@ int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
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
+				return ret;
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
index 9cb6c80dea71..ae91ad008cc8 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -188,6 +188,8 @@ int iio_gts_total_gain_to_scale(struct iio_gts *gts, int total_gain,
 int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel,
 					       int scale_int, int scale_nano,
 					       int *gain_sel);
+int iio_gts_find_gain_sel_in_times(struct iio_gts *gts, int scale_int,
+				   int scale_nano, int *gain_sel, int *time_sel);
 int iio_gts_get_scale(struct iio_gts *gts, int gain, int time, int *scale_int,
 		      int *scale_nano);
 int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
@@ -196,6 +198,9 @@ int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
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


