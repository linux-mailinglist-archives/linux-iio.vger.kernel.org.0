Return-Path: <linux-iio+bounces-18109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65454A88B92
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A4A3AE1AA
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD3F28E60F;
	Mon, 14 Apr 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WteGvAEy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F528DEE9;
	Mon, 14 Apr 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656177; cv=none; b=NfO/r4soRh0mE9OrOFr2w0Xd6KgqP5fQmnx0MjzAhi/ACFoy57Qn7Es2MjBVCdCqpNXQ00tlDhZVVMetF+d+suuBniycYRSMI3H0bO7Ve4u7UUXPqrBnIPnvq6r9OPLfuiuxsii7sjQHWY1JdKTKnjkGf4BEjCriRlXapti29Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656177; c=relaxed/simple;
	bh=rbaYOkUTWpyowR7jBDQPIChL648feaPDsQw7fIdQNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMYD2rLNuStV0LfgJUmv/PP5uFK308Fz6DOf3r3USvrPiXHeCR2To9BEkDNDEqd1ma6Bnt90Qcuuo8Oge1/+Amp7hYhVf967Uxxd/mKKEP6QcV3xEFr1moeG0NImMFtKoezNNzLC+8Uw7KgScn87Iigg+lCEi1N0U0e5bj+ndvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WteGvAEy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac73228ea73so71563266b.0;
        Mon, 14 Apr 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656174; x=1745260974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IPG/e3mCWKEPm+RsqHpGKWjD98/6RuMtaJowuJZ564=;
        b=WteGvAEyGO2eoubwQJJpNRTvtOxcBPZUMiSLn0YSSdfrUinn6cL9H7GANFbXtOQLD4
         T/E69iYZ/wRlLdEWWHKHaS/c3j1RlmX25Ve7Zzqzn54BloqAXhfb2YLQh3xOIOsjvrDe
         E3O1FYKTPQKkPRiG+m8xRkQUwRHAXlRC0tmV5SzFoL7SGwDbsShLtelKJRmM0lLnyU63
         sb7u/EQ+aLoyU3Geuot7gCVy/H5mnmvhtodXCzvC02+j8l3h1bR9MWCAjogoEOvxu3QS
         E0gQmvNrrulg3D75lT+Oyn6GHcNcLtBez7cqsZa9G8xAz1reImmU08BI/q/GbQwzr3QI
         dzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656174; x=1745260974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IPG/e3mCWKEPm+RsqHpGKWjD98/6RuMtaJowuJZ564=;
        b=gExKmCr8gOR+7s8r2gw95HUJHnDRYWqN4oMTgUBnmbBQ4EVjZ81uh0Yka4UyEX2dQ1
         DY7GmxpFLOGxGKngtrqrFMLYpCOQ9AX9zYCs3PgKPxV+iVLgMb/DLpqObVK0+6HVekgC
         xZcairGg7MDGr/dyrIbaiFZ7Fvpt8DEVseFzMfSY4YZW4Im82KgZMdabnTg/ZFc8iu/i
         stHYBU084FIWO/5l9boWSRBLED8QP2Ss5P5AK08g/Cj8YqSJfe+KBwSa4ftQQ1cMTqZr
         4L9688wNQVnBFaeVsElpUTU9XHX1MjhocN6DEaNeCZ3qiiDuSZGNK+yF43xrgjEjIwm0
         95Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXAkMcz04QH89B+kvTGI50Tad9bODLTYJoT4CgJknX9nWkVxds/g+iSEt3e3JjhM09q6sxNiNyloMnRWcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY72yobu1FJlNX2qNP0JCTf83Mh/dzXTQRiye15GQqMR/CHim
	w0y9HXDyWDncnRMoZpRbbG0H5RRKjUK9ITXJUKE69xDoBawRUBOE
X-Gm-Gg: ASbGncs3g9yTkHdK+tlWmFk8zh5daPKfz1j23BzzsSzfWQJc0LBw5oxKMNBIsNLvjUs
	pn9MB1uRGU3cvU3mfaVyXPoHM9qeg5hfYu8pmu6mvdWvVoP5q5btPDWkMRFsi832/2RSfZP7CQM
	48/aRI9UIl3cgHwRLf3Q2w7DrWppD/xr5FL43qQGRWQJSJs7XJfOT0b0KyiBgQ7dD4AQQVcP/2L
	OM/MMeVohu/HPA0+p1SbbK80IPJeG/m4jE5IlOY3stVtyo+RFogcnHAZHeNNcwuTsMTot7uXExs
	naA3sxI+Y85fVnnS9mIfypVT8M8niPgIUuhOuemAYN2KiuPM/BxVsY5CiOFW30qQx8FU8FMID7A
	eBism8O7AZckQTpkgFs8=
X-Google-Smtp-Source: AGHT+IG0MBKskRn2bioPx2eBrmJFIohEDJARFNOI/1LKNC0m9TKnucK0yuRv1maFcU3+ofJgqnFm9w==
X-Received: by 2002:a17:907:bc87:b0:ac0:b71e:44e0 with SMTP id a640c23a62f3a-acad34d87admr430536566b.9.1744656173333;
        Mon, 14 Apr 2025 11:42:53 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:53 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 04/11] iio: accel: adxl345: set the tap suppress bit permanently
Date: Mon, 14 Apr 2025 18:42:38 +0000
Message-Id: <20250414184245.100280-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the suppress bit feature to the double tap detection, whenever
double tap is enabled. This impedes the suppress bit dangling in any
state, and thus varying in sensitivity for double tap detection.

Any tap event is defined by a rising signal edge above threshold, i.e.
duration time starts counting; and the falling edge under threshold
within duration time, i.e. then the tap event is issued. This means
duration is used individually for each tap event.

For double tap detection after a single tap, a latency time needs to be
specified. Usually tap events, i.e. spikes above and returning below
threshold will be ignored within latency. After latency, the window
time starts counting for a second tap detection which has to happen
within a duration time.

If the suppress bit is not set, spikes within latency time are ignored.
Setting the suppress bit will invalidate the double tap function. The
sensor will thus be able to save the window time for double tap
detection, and follow a more strict definition of what signal qualifies
for a double tap.

In a summary having the suppress bit set, fewer signal spikes will be
considered as double taps. This is an optional add on to double tap,
thus a separate patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a95f1c218c0c..c464c87033fb 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,6 +34,8 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
@@ -295,6 +297,18 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 
 static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
 {
+	int ret;
+
+	/*
+	 * Generally suppress detection of spikes during the latency period as
+	 * double taps here, this is fully optional for double tap detection
+	 */
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				 ADXL345_REG_TAP_SUPPRESS_MSK,
+				 en ? ADXL345_REG_TAP_SUPPRESS : 0x00);
+	if (ret)
+		return ret;
+
 	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
-- 
2.39.5


