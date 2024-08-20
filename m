Return-Path: <linux-iio+bounces-8636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022C6958BCC
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 17:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9916B1F2398C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Aug 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFE1B8E8A;
	Tue, 20 Aug 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z3GAUfFB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0417196C67
	for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724169538; cv=none; b=Rv2d3YDOHefCKUUnpEezD18dfLpVaFsXRVOcNMxi73lpawzVealW/EdLvD19JO37jAAAzOxoaWzA7izY79Y8k3aV4ID9BTf5VuOoxeTWKZWeW6FUH39lyAyDV2msDiFfVSNp6N1CzwXi4fehSynoXpTcgnU48kqtgYGNb6EmpoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724169538; c=relaxed/simple;
	bh=plzPScmSdjLox3OYdz9t2P7i8g4UtSg4NyCpXW7I1m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tsgZFZM/BCR9UAmA5zEKWK0uOrvId2zuuFi5K8kVg4Ctz+O0/Xnu7s2VPt6Re0B082xEMX618f6J7soFIpKg91qnkl6lhC+ipCsAjRnGD1h3jBVXaWqb2Xu6/hxLy+ye8u9+4/PnaUcP6zVebKg9Q9Ah/ojcUzooBDnq5fbZ/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z3GAUfFB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db18842a4dso3401303b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2024 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724169536; x=1724774336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfB87M+ajklff9IR1StKsGavCV4e8E2kBLAYS9A+WSE=;
        b=z3GAUfFBJb9Fr9y5ct6dqH57lQtBem4fP09z9PPB3juPZdXZ3vKuVq1cyArYpChE7s
         ReuskLcI3i0+xiEqEjiPIS1Ko2dAzc3WQiF+ez993HRqzOWaWrSt1n4C/SGX/tQUSiWQ
         VaRiIfewuTLRnWMPz+PGz/BBQ1qZisFx+rR6KtDBkyieUxYHH3lhC7xDmzJIhgwBROAa
         jhxf5R8hmmYm828bakmtbL6OEiuT51mPyUXiF9j9qd7VAbyeLIxmkZrF0WrNzPJWDHNF
         thM2DBmBwn6F7PPtAJvuHbAydhEzJ+n14yIbyLCj2sjqEyrXr3JovDl7w1p0Le8g4mGw
         K4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169536; x=1724774336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfB87M+ajklff9IR1StKsGavCV4e8E2kBLAYS9A+WSE=;
        b=a5PrSFOx+4CJ9FUbHR9gyQb/96bwWssUB4HvFqZp6Pe0HTpwdUkM8zbdMJuM9KRfq2
         uK85JzyL1Z/FOZFr4RGC0cAZTs/fpjD7DRkk4FsDkIWllU1ykK7kuhi+F6TpZkKBx7Ta
         8s+Z0yooOsMHPhz0OxIV0trzDc7fbizEDMx7qte/rc3CRyFpK6rdEt6artpwYJDZ31Vh
         l6+9TZ2X9JtqpUb2hfC5z83kesM1I+e2mk/nYS5GnPTLyvpFuPJqB7eneFR6p16Cyllg
         WT5HiZvAelo1IrY9BaYtVOHljJygnPKD/nD5ArN8WOwEgNLiyYCQyJZO3WEZnvgS7ZR1
         qtPA==
X-Forwarded-Encrypted: i=1; AJvYcCVgF4ixTpG3ulMWK7f3eQ7NBxC9WAinFeeUWE8+KK5Fp+yQ3gun9MLafy/jES0tv4eTxgH5GOP4ETjM4KgQVnMBiRbaJd7pv8i7
X-Gm-Message-State: AOJu0YzVjtqADFqFg/NA3/lSBvMvnG9TTrnAb4Y4Behkp1cGpQYpMkR4
	VGylZBVNHz6UkKoe7/8CFy9SRV8vebLlWJEDmARR1yacwT0yhKni6QIzVmwgD9Q=
X-Google-Smtp-Source: AGHT+IEeoSdOkv8tmbc7KwjQ9tuFv/ugArVpvf2FmLeUfmeuA5fXqNWShnl4Dr6Ie3etUsR24flJvw==
X-Received: by 2002:a05:6808:15a3:b0:3d9:dbe9:7cee with SMTP id 5614622812f47-3ddb9cbf10emr1211638b6e.14.1724169535714;
        Tue, 20 Aug 2024 08:58:55 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dd33d5a3efsm2872718b6e.17.2024.08.20.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 08:58:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 20 Aug 2024 10:58:38 -0500
Subject: [PATCH 4/4] iio: ABI: document ad4695 new attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-ad4695-gain-offset-v1-4-c8f6e3b47551@baylibre.com>
References: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
In-Reply-To: <20240820-ad4695-gain-offset-v1-0-c8f6e3b47551@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

The ad4695 driver now supports calibration using the
in_voltageY_calib{scale,bias}[_available] attributes.

Only one of these was documented before. This adds rest.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 345d58535dc9..89943c2d54e8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -541,6 +541,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibbias
 KernelVersion:	2.6.35
@@ -556,6 +557,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibbias_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibbias_available
 What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibbias_available
 KernelVersion:  5.8
 Contact:        linux-iio@vger.kernel.org
@@ -603,6 +605,7 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminanceY_calibscale_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_calibscale_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_proximityY_calibscale_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale_available
 KernelVersion:	4.8
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


