Return-Path: <linux-iio+bounces-13777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E395A9FBCD0
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 12:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAC57A2146
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DE1B6547;
	Tue, 24 Dec 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVOFwfrj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA192D76;
	Tue, 24 Dec 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735037999; cv=none; b=fyw+6OlJN191fbJYJv4Gm8NLw+erPMAu08tWmjRNiDA3+vexE8prP5H2DCLr19BnWZMXsQ/w1fm7UElG2XnjvedHy9aKU8suYrVpLyPRr4iBffswpLzIMLRdUVp3yzkzcYQF6WsqV6MDo8irwf/wdeVJAILPMjQL9HhjkPSqN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735037999; c=relaxed/simple;
	bh=NzK4cjcUACTSCFQVbojeKefz34qKcANt5reQRhyKDJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpOy1+jIicMpuw6wnBzUTQWygUrBrACkLRPOWA89SEKB/YSmYj9cCDNbGE69gdCqDuatsMAplLTfpZBvWTknVRXNJ2tpzILuKEG7UgI5Gy5CFOJINetxtKEklDU8cRB4E7xbF6Z9gYoPXOeGTREGmKWqOf1wRWAhpKPeCCZDD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVOFwfrj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de9f789cso3837994f8f.2;
        Tue, 24 Dec 2024 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735037996; x=1735642796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LShQ3cZdx7UGTQMZnEPJlH8RBGekAXkVTNISJd8oxLQ=;
        b=WVOFwfrjzChFK5lX4FJRVopgrIRVG23S5TSZHDv+WQKcAt6Q9bBgXM0Bd61RZyHcQ5
         9OiLVj1Vvr0bzzOQ+8Ot/7C23z2GhPqTqWfvwhEd79+ohGYle7zC9Y75FuOtjGY2UqGw
         Pw4h2MeSUWwS5LpIFRBVPG+cHo1jFi6ZkmkViaGUxauiUXsFzJpLpUn6O9UJw+YtGCWV
         sXoEnzw21Gj6VsNDOfWlW2jmuJgYhHamTU54yVtxyCSRfM23/72+dYqSK+shVZgSypnD
         gqcyahvGaTrz2ZFTWaqbwzrt3008S6HWApFDlcb0OtamdiY0rCoqo5usdgpS3Mcvl4Yj
         jLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735037996; x=1735642796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LShQ3cZdx7UGTQMZnEPJlH8RBGekAXkVTNISJd8oxLQ=;
        b=X2IfRGkIRZeFkHUoSmc61nGQR939lTlrsPcETPzXSBSGQ185filmrcgyX22/ljGaZt
         yWZ+70vCMwnoX1DlOeopGOBDk0Tm7P0ePmcPpipyvFTf5C3Br2xVg3ZFXlinSNYoVtQq
         En3ueoruB4sGNz6gIpLP1o7xUvmkuASF7ka54gHabbs8v118pk2M6UwHfZd1XkGsrxDg
         x0cwq2+3fh+lOAceUATY5pbWkcwBjQs7Yl7fNmCoIZ4fRT6V9NRuiLW9Nh4Bbhirzg2s
         ZuLZ9FygRw+pq06CaS6ze4rB+G0hvWl7+esAAdyanz082ZxOmVw8apy65jYFxGm8/Omx
         GITw==
X-Forwarded-Encrypted: i=1; AJvYcCWZNliB8bXqQeZ963UnQI2v7j1GpKGMqAMFycYaPNcvzDvxONQz+MyeT1p3w+ObUJpkxagGWEGl3VsCU1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjOYx7o8zrjhC/LjFjtk+LwBgimIl31t32QwiW0w5G4iSpoRG
	GpN4pbsHzR1GnB5ZPqS5KNeQDSvW6bdJpy2pFIlVrz4D0F6ecZHi
X-Gm-Gg: ASbGncuytRsSyM+U9n78kmoltPPglg2ENy8r8hXMksSE5ezMpdnPkDXgxJZPYNnJZzT
	IE9s1zfIqzfs/p322xso6XfTMlSwuxqLuuVrhN3G5uReNCwco36VNyDH+oJRvrksTHwGLxNfO5D
	csI2AmcjLVr7CuPrOa3s783n2eaqY/b9GfFTgGInwl5NqGD8wIkPJqv/83V3XQYzx7W9IMCqIP6
	uX+zqCE3z7fD1A2x8u+CggG6MG92EMoeEbQqotsGQXciEhpT9MjJ08ph6NcC3frl+3An3eChTB3
	IJiZ/6s+nzNVOIk+EweP8tvIeW4hbjreMoOJnalDWQWtpSTf4V38rH/87Z0MsP+bmvhKL3FWfXM
	tXw==
X-Google-Smtp-Source: AGHT+IE7s3pkOcQqkBsgIM+4dkbj2Rc6ZfsT8DKtU5Id1KqujTE4gNkAPCop8nxwYzF9VAdiqUZ8eQ==
X-Received: by 2002:adf:a443:0:b0:38a:3732:4462 with SMTP id ffacd0b85a97d-38a37324578mr1887743f8f.48.1735037995767;
        Tue, 24 Dec 2024 02:59:55 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a49-0b63-5213-952a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a49:b63:5213:952a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm13699427f8f.103.2024.12.24.02.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:59:55 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Dec 2024 11:59:00 +0100
Subject: [PATCH v2 1/4] iio: gts-helper: add helpers to ease searches of
 gain_sel and new_gain
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-veml3235_scale-v2-1-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
In-Reply-To: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735037993; l=5803;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=NzK4cjcUACTSCFQVbojeKefz34qKcANt5reQRhyKDJw=;
 b=PCnEm7HPYJiMzQXoFUVeuyMjzJc5I7pLRV4N3Sn4yRc/2fC/1Y1BhP96xWJkVyDLpkPGnE2GV
 1rOI+lPtXzzAWEgPD2bmAziqqyr4FVtteFL1QxgghU6yjGHcZxtWcB7
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
 drivers/iio/industrialio-gts-helper.c | 76 +++++++++++++++++++++++++++++++++++
 include/linux/iio/iio-gts-helper.h    |  5 +++
 2 files changed, 81 insertions(+)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 3b5a998150623ba43c2f015c2c5d8a757743b893..7a96dbec45848781008f72338d63d7693abb9076 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -915,6 +915,40 @@ int iio_gts_find_gain_sel_for_scale_using_time(struct iio_gts *gts, int time_sel
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
+		if (ret)
+			continue;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_sel_in_times, "IIO_GTS_HELPER");
+
 static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 {
 	const struct iio_itime_sel_mul *itime;
@@ -1086,6 +1120,48 @@ int iio_gts_find_new_gain_by_old_gain_time(struct iio_gts *gts, int old_gain,
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
index 9cb6c80dea716cb80b69bee5277230bafe1c9a95..ae91ad008cc8cbd9d674402f3d4e50385c78e5d1 100644
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


