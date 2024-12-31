Return-Path: <linux-iio+bounces-13870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92D9FF19B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F91162643
	for <lists+linux-iio@lfdr.de>; Tue, 31 Dec 2024 19:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9721B0405;
	Tue, 31 Dec 2024 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DWV31QZ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D4189BA2;
	Tue, 31 Dec 2024 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735674158; cv=none; b=E8gXdB+g9iCJDnMIAWeB1U9Z/0ryPOSlsfxOK5Cpu9fjY6D+72AClPZVDPC2iZ0MEziBdHIoNZyvHysPd9S6HbE2tZDyiSqUJkskfzHN480VYGAntg+leyoyaciFkXEzdK+FfQjkiMyX007BIGIf1VnbhTERiLtT8puUxNgbU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735674158; c=relaxed/simple;
	bh=d6ZiQw8iCWJdS93O4RWFWiz7tZzaFQLtRslg79rRcao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB/Orw2XZZE4S/j6NDmdrfXWd3N0tuXbHrVxskh62ul45uWdPLRsF6LQaXceunH2NBSO3Fovza+Y3HaorzxROyRAneUcAGxgDBHI+G6ofrJyXJQ8ThyGqIFsfio+rQswWBBn3M39+1Y/aX8J4miXfYzo0P0KlGB05mfXhIK8/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DWV31QZ2; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so2369415a12.2;
        Tue, 31 Dec 2024 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1735674155; x=1736278955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O4LH06p6e80pK5KxPNhNgWz2cmsFSg5nIydohZVyBn0=;
        b=DWV31QZ26cX99HHgBkLAGxMsrnyFkKgIOmXWwRmP030e4eraBB9Y443whkGIVRk5z8
         iPcZyMr2l8jEaLYMFRbrAy2J0IM00NBqBpE+3ZONuNDQ5Yeku9lsjUrZLqS8ZrD4/ItS
         14BV/9tanvrSlbX5d3tn+RX8I7M6Yqn2XCeC6KtV1fcKjgzPZYijepo+m0NL22ReCtnC
         LyTplB+MwrNDeOtLCTKdvj+jHC7sYrYaVhMCWjk7VZxp/oA17H3EKIL2d4CxXDcRO0d/
         yfJHh6F/VJpiCcHiuo/iO89P78H3mGAcZTmXBHNV4tOvKxFIRMXQoax68ED8bnJGiUuH
         JR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735674155; x=1736278955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4LH06p6e80pK5KxPNhNgWz2cmsFSg5nIydohZVyBn0=;
        b=h6QRpzj4SKnUiQJm68d7SqylD2nbBO39E32jftIBf+ZwiKFe/20NBegvQqcX8Ldi17
         5HsotqPdydrJBrfqiOmzAiKeRfHFA4U2ZoVmaZQwrZM6Xa8Dh4XjAS1nszerm+WC+Ncs
         NO5foitcvtkP+B3knpQWntNhHmtF6Hk3dfJevH9BvW7L6EkdC9QM+8OPYLaGqX/m3uRl
         pclqjegBePV12SCEsE6h58qOrLqXNkJ0PhSSU3jI4G3ShtxFh+9Rgu+Qn3C6LlPsdlyN
         frmPRFCBe02GgYMgblajeXuGoHVi34zAT4ZJZknEjSMGrooYwslcYOXeqYrnAxb8nF0f
         L+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCURvAWJf9PTdKzeLWajuD/nsKXYfIehZ3brXZNn+HqZxUzou0rCwWylKGCUzoeO9WhFPorYNnq70gc=@vger.kernel.org, AJvYcCWRj3PpRaBf3FwWF7vyp/4wqrUTx6e2GVQK3p8aDdlaSLCJSRIQbsKTOwiQfHlB6UFgdcPZKQiR0D0P+vng@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wvAyOL23ipNQE4T7KUo69orABGCLIkt/JTDi6VdRHUl/ZZu0
	xn1vFREutoUqXiaDqWOedK9O6G94C5aJqjYcyk1dYO35Q9N6KYge9T7Icw==
X-Gm-Gg: ASbGncv+cHg/Z0MoVflbfAUiSKAmwQR0rNX8+U3SR762Lv/4r1uWU2kDyvHYA78ipG9
	5GKIAOeJRo3oZcp6wnZjBNe6RMtijXrkYr55FKGrxoidk2V8CfX301VyFRsgzJpITeAqVedja2N
	EOJIFJm8IY0/5DfEpJq7Ng5R0J6EFeWhHLBIpWZ0EUUCzkf7OkBMScAMneaSFVmgkta6+f3BGZw
	omaYgq0Biz5TcnFmoR3/Dvrik3f+V0znTEIr10/qW1pPvPE9AyZNT+ycFS/QlUnMfU1O7XR45NR
	rWoTFSQrPd/h8GDY7tsRjKm60es5btfPOJk8uyK5uePV1jDMq+8Oe5S0ePF9s/ULg221KNk28jG
	Ls7Z73zx7KrlntWK8BXLcCkYX
X-Google-Smtp-Source: AGHT+IGXqm/aQBqvNi35rgVLYkC8kH5DSjX826DjeCEUtekC9n0oOmjoa0MClXKsVCVmiNvGJMlXhg==
X-Received: by 2002:a05:6402:3217:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5d81ddffa67mr36677539a12.23.1735674154722;
        Tue, 31 Dec 2024 11:42:34 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b300-ce00-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:b300:ce00:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f9acsm16237820a12.31.2024.12.31.11.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2024 11:42:33 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	christianshewitt@gmail.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [RFC PATCH v1 0/2] iio: adc: meson: add MPLL clock workaround for GXLX
Date: Tue, 31 Dec 2024 20:42:05 +0100
Message-ID: <20241231194207.2772750-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Amlogic GXLX SoCs seem to be mostly the same silicon as GXL. The only
known differences are:
- one less Mali-450 GPU core
- no VP9 codec
- and an odd one: the three MPLL clocks need a bit toggled in the SAR
  ADC register space

This series attempt to fix audio output (which relies on the MPLL
clocks) on the GXLX boards. Unfortunately all we have is a downstream
commit [0] without any further explanation (or anyone who wants to
provide details on this). Since it's not clear if this is a gate, a
reset or some other hardware fix: the driver side includes a warning
for users to update their .dtb along with kernel images in case we
ever figure out what these bits do and how to model them properly.


[0] https://github.com/khadas/linux/commit/d1d98f2ed8c83eb42af8880ed8e206aa402dd70a#diff-c5aaf54323ef93777c5083de37f933058ea8d0af79a1941e0b5a0667dc0f89b3


Martin Blumenstingl (2):
  dt-bindings: iio: adc: amlogic,meson-saradc: Add GXLX SoC compatible
  iio: adc: meson: add support for the GXLX SoC

 .../iio/adc/amlogic,meson-saradc.yaml         |  1 +
 drivers/iio/adc/meson_saradc.c                | 34 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.47.1


