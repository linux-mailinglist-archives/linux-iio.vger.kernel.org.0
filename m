Return-Path: <linux-iio+bounces-19999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA5CAC7AD8
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133CD4E36AA
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386321C186;
	Thu, 29 May 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uGVg0411"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8A219303
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510161; cv=none; b=fF2bJxgiQ60qOqof1n4GnXaVs9oiqGg2wBnjnCt8HUGlVqitMN08ZieA4YsQbXriJ5uWyiFCIxqLsoLRCJS4Y3kUth4ZaY8HVsXbdxBQcahLn4XXOWByQPHUfHw98LeWq9knu7ZjbGorkaVEM97gduwYeqxWk1dVt8m7fgkUQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510161; c=relaxed/simple;
	bh=EuVopUch3RvcMm8wwL4YgvpMZfFl3NzeePoEsn6JRZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMdCcGBdKfxeIkz1yl3dPf2FZUJ8P0HFABwUj8Mpms9PZUz1h84T2RLiZ34LODREohtrLCxExWrkjjnALMqUiZykiQH8ozaS2jO+JFCwC9oTQRfALPsrj/7sh6Sx5oBljUWNYAn+LO6HNlqvngTMj1PYXsHo+6IpStq7FcdLjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uGVg0411; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf680d351so11838295e9.0
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748510158; x=1749114958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmgqoKB1/8SUojJrwigc9jIEEcoeGxp7/cQDPaSjq8M=;
        b=uGVg04111x4ebYSbS/+cu1Ijo0fP8cy1LAfXasWe+SIwCgJTZ98EsC+a2db7O33c+d
         ETJADGql4CkTfMP3dRSCsCWlCkygJiUOPokkTsSdyhodJq2jGKsSHg200gchzbBt+9Uc
         RHLgjdtyepJZSuaaVMOWmi72QHdQGGcxSMndZ1DOMe/Yj789BJ7VQgZzeZfGUHi8xfK+
         xIN7KTyHirZg78PJ1kq+m0hCTk9JmpXRIHDMgygfqgkZJdUUwyRzMh7OPn9VvVC04CVE
         8qduLHuFv+Du6Sw5ja5kwleeavuR1tF5XnD3Ygn4xKHrEZYM/VDtqsYpPCCO5ub/tkuf
         TCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510158; x=1749114958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmgqoKB1/8SUojJrwigc9jIEEcoeGxp7/cQDPaSjq8M=;
        b=maHq056D75DzG7xUQSUAEzW0t+MYN6L7Ar6T3woiuQtJ6FSeHlrQov+0GXqYiK7axZ
         7Jk3RAnZ22uFZ0iVU8FHt9JCWlY3ERdGWf1MNvNgbxlPDiUnZ06C1ekHhmWEPx2biZBq
         /7SLECtI6VrVH4bl4kwqNwo2RSeqNZfxLg+Lh2232+qAm2MAFQVOD6OMBsLoRn6HeBOb
         RlY6lkh6Va1ZTlgE6rqAC8DIaXrg7TnsDOXlU8sDsNKHWHtF3kNil24tAPTrORUpN1RK
         N/53RE9TSuGoQGQsUDOuhFDAMKX/QwK+uTv6rn9gFl7ZHtQtM2K+1/889oeKnNFKLEhy
         N6pg==
X-Gm-Message-State: AOJu0Yxu58y6ZIR6K6MlVoBoDMA4N0spkKb5TLj3qFP1NC9JaEWsWW0V
	cawgzixm9WPXgATMCq+zlGPAksq3P47did9qhoLqJQV2pNXQogh7JdE6IhGIDhogaZc=
X-Gm-Gg: ASbGnct+oIN3K1BfJ0F+xi6BJTBtZDssxcP1z25qmf5JoJtJhSe6JHjuJSrL3Nxt+fj
	AaFW4k5JDpAAbwhLD/yoLiQCMf61M388cXk6KGwsJxyC9h426eFw+hVg8AjfYgErKbHfXUyMjAl
	vP037S1cD6ywpeacw9fHJuouBSZZXu1/Iq/UWVkOvMDNI2N8Rq1FgygElm8tf7JRFKfjVw+c3bB
	RXAcAK8IX31Q2aym/DTZUJLrPLlNnNUzCn9tHY4ybsny/8T/MGduT3J3fm9v5QbEiKj460WTlyL
	/bNceTQmWTg4I3wsZELOXfyaHKcJhxDsYLGNuZFvBHcGCKgFG1swj+03jKiUxr/E80vLrQM5G0P
	AidmUaIugIxJQLrCyVErSJbwl5yvBMfU=
X-Google-Smtp-Source: AGHT+IEvLfj9BL1ztMv9CtDCi1fKM3delubMKoMo6AZBVoD7y6ZKAUIZodqOon+tI100H4Dxv9BUVw==
X-Received: by 2002:a05:600c:450b:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-450ce81cd83mr27275015e9.2.1748510158379;
        Thu, 29 May 2025 02:15:58 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc348bdsm14318475e9.33.2025.05.29.02.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 02:15:57 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 May 2025 11:13:54 +0200
Subject: [PATCH 1/2] iio: adc: ad7606: enable Vdrive power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-wip-bl-ad7606-reference-voltages-v1-1-9b8f16ef0f20@baylibre.com>
References: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
In-Reply-To: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=907;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=WbJxk5bQxvmJFaViamimQiGxr43ZTZXKFb47GKJ4NwQ=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwUK0y3GE+8d1820V5z3j0kyYVcO3hm/Cw7An/porti
 Un7l2x61lHKwiDGxSArpshSlxhhEno7VEp5AeNsmDmsTCBDGLg4BWAiOgYM/6xux644UX75XQTf
 pIU5uxRXV5yJYOtLl/+a5r5w0amXV7MZGW6eb+HeE2e32YSxaqvNr3NGkmvCzSI05JqfRR5brZj
 6mxcA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Enable Vdrive power supply. The "vdrive-supply" property is mandatory,
already declared in fdt dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 185243dee86ed2e9ebc43b578003d0c010e97a9f..3bbe9c05b5edbc11e8016c995c6ab64104836e7b 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1330,6 +1330,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable specified AVcc supply\n");
 
+	ret = devm_regulator_get_enable(dev, "vdrive");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable Vdrive supply\n");
+
 	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {

-- 
2.49.0


