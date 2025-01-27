Return-Path: <linux-iio+bounces-14640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD79A1DCBD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997CB3A57FF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FB61946C3;
	Mon, 27 Jan 2025 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQgi3+TK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B2192B65;
	Mon, 27 Jan 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006236; cv=none; b=Y/oUGoqR2mn1lnR4GJkGwbJBufzGWwckH0cLTuFgNEIJNyac0svG8r1/9uYvYjnC6+FtogPfG7scTktFwkR9xondvkilEAvjqxt7IW9FUvMvP8NkGGyv6+NJGnOcz8L87aSjy+Miv5H5/dNy/Mxr5ABWPJh0UToOOD1e2pWBKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006236; c=relaxed/simple;
	bh=Euw/mXXtqClrUNsPf9xLrVVugYUKexvZQwY0SWU/FZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQ1/GXJPBeQecpD0RFSTDNFeG9+a6JozSbFSVNIJHFJ+WOozVWoFMBS0B1gcp69ip5Y572PBPq9S2h8IRvbQmNqgjH+p+bFouhUI0wzQvfNoXmmycFuncPWGyZZY3bhl4lww6pf/Nw2+APBRvRNR43mdKI56i56q4PuL/ip6zH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQgi3+TK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso34396035e9.2;
        Mon, 27 Jan 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006232; x=1738611032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVUFXyr+FZRD4HY2XlH1s8RMg1XNx4vfrzF0pS0ZY0k=;
        b=IQgi3+TKtyyodqJR61JQ2LVkcTfZAvEl/24f8LhdhtwEFtsyNKA2Ox7+a9RJJohRMX
         e+ozx6Ow2HUyLuxoKm0mn4rq47j6620XmPdTOX3ADc8RSgOU5dpUtV6unAWOonommsQz
         2VPz9pJc0I5gxc8+t/9mJj/7FvHbCPC/jokqyHvFp8zJa7B6/XEi0Cb9dnED9IVdj7Ql
         aFJ8mArmWSXmGYtnLAypu58sVtKGp0VYJvV+LvvOOFCSFaUWk0zLlxdsTGPVuL25grvM
         LxdD+oe9IqPvERVNHL737ghrusEvHeE/gRIXdn2VyN5N0SnaoYy1vAXa1Nv4CDCsTPAU
         Pa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006232; x=1738611032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVUFXyr+FZRD4HY2XlH1s8RMg1XNx4vfrzF0pS0ZY0k=;
        b=GyhMhJg0Zq0s+6TbsBp73Ob0Lolm0XpfQeEY5NnB95ZSdDoO+GkmA5ufwKdThOIN4w
         BlvmSWoBtcZWxeq+pB9XNRXxXuumLd3wc3twwv2KYs68DPCJCijJZ+859Gyh/gwxGCh/
         iD+K7QL7pHKgqO7l5/YxNdWpLTO+IqooBNHD/xap8edmWk2aLSSneFcOFoF+smwSpESr
         IsT5TpqsTfCs3pAv+mIta2WJxTUTUN1OSZnlnrLUzizJvVVp0FTDTgXvuyaPnXjj52je
         DJCa82jJfk+4pe8zishfUN+wWedf7uiPFiZn12jVhJvPlmM71sJ6rnQ19Ll2RiU9doTg
         K9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVFyUlSiksN66KRLiUf/FtIm6n8TkZvH12/rgEbOVpg2xK9EUiJEnwX7hDAiR1BlLZtbaE+BtXB4M0cFBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3wy9TMorkoYVrKAhQ+3sGrZRoUzGSScDDAttWGv9Um9hec7aQ
	HnktT0RMuT3Em50J7S2hSuVyZaDkwxLWB6msS6yKhStI7H2OEnb3bdk2QQ==
X-Gm-Gg: ASbGncuJj8a1b+hML+ng2ukkhdTnmhrqWeB91VGGaSVxZra1msFMvAgR663CsjotzH0
	3JY1grCy7VIvOwv59TnSNMCCb/tuiXN9F1VgU97HHcMGqe2S0HjCV2sNvmN2lF22AQaEDK2bNfT
	1Ln3HW1PLr30SQI0dzvib+7sddDSWl2yiLdZNcYvu5+Oah3oivxjvMCUJtw4FLzr0Hu47obyuqy
	HtfANX6oi4aMSaAnIbhzd+O8rXWXVgGNutB/2qv38jr50PCiQKPQyFNHmejiVSyiicjon0y4NJT
	QcwV8ug+EPbXTcp8iC1UngE6+F5AbnDsiajCcaP2wVxhxLGN+OeCtF0t6A3NQ/HUi0cCsH/TnSb
	QkebhviH7tcHqYtKWNp/+dx7QTMnuxbPTNrXS
X-Google-Smtp-Source: AGHT+IESsemfnpj7hYeO6FsHlEYDgXYpF77oMvlkhxIZc5pe519nebSDr+EcA4vmH7hNFBqDFJoiPw==
X-Received: by 2002:a05:600c:4511:b0:434:f871:1b96 with SMTP id 5b1f17b1804b1-438914388e5mr428380165e9.29.1738006232043;
        Mon, 27 Jan 2025 11:30:32 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b1d9-eb5a-e5fd-0636.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b1d9:eb5a:e5fd:636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa463sm142986915e9.8.2025.01.27.11.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:30:31 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 27 Jan 2025 20:30:22 +0100
Subject: [PATCH v3 1/2] iio: gts-helper: export iio_gts_get_total_gain()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-veml6030-scale-v3-1-4f32ba03df94@gmail.com>
References: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
In-Reply-To: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738006229; l=2390;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Euw/mXXtqClrUNsPf9xLrVVugYUKexvZQwY0SWU/FZY=;
 b=LG6ejV3DyAl3nhquudmRq0161KMOwZg94j39qqCGphtcaH55wMxTVXl39MQP7OcCTICa3aCTV
 tPQxsY0pQOAAD3Nl1sMoaM2+mTA1uFSsk3JZrcXXs8MgzFIKjmZClRy
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Export this function in preparation for the fix in veml6030.c, where the
total gain can be used to ease the calculation of the processed value of
the IIO_LIGHT channel compared to acquiring the scale in NANO.

Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-gts-helper.c | 11 ++++++++++-
 include/linux/iio/iio-gts-helper.h    |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
index 200364b42ead2f560b852fc2f533b4aa83302810..f35c36fd4a55f6d5f0f2ad0c0402cea8fab890b0 100644
--- a/drivers/iio/industrialio-gts-helper.c
+++ b/drivers/iio/industrialio-gts-helper.c
@@ -1026,7 +1026,15 @@ int iio_gts_find_gain_time_sel_for_scale(struct iio_gts *gts, int scale_int,
 }
 EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_time_sel_for_scale, "IIO_GTS_HELPER");
 
-static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
+/**
+ * iio_gts_get_total_gain - Fetch total gain for given HW-gain and time
+ * @gts:	Gain time scale descriptor
+ * @gain:	HW-gain for which the total gain is searched for
+ * @time:	Integration time for which the total gain is searched for
+ *
+ * Return: total gain on success and -EINVAL on error.
+ */
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 {
 	const struct iio_itime_sel_mul *itime;
 
@@ -1042,6 +1050,7 @@ static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
 
 	return gain * itime->mul;
 }
+EXPORT_SYMBOL_NS_GPL(iio_gts_get_total_gain, "IIO_GTS_HELPER");
 
 static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int time,
 				    u64 *scale)
diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
index e5de7a124bad6eb65414df364f84e81301b0690b..66f830ab9b49b566d549c7b5b8291d42a0825b96 100644
--- a/include/linux/iio/iio-gts-helper.h
+++ b/include/linux/iio/iio-gts-helper.h
@@ -208,5 +208,6 @@ int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
 			     int *length);
 int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
 				  const int **vals, int *type, int *length);
+int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time);
 
 #endif

-- 
2.43.0


