Return-Path: <linux-iio+bounces-158-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2C17F045C
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 05:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0E1C2093E
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940923C9;
	Sun, 19 Nov 2023 04:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKKICew2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC1AA;
	Sat, 18 Nov 2023 20:58:12 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40859c464daso7603815e9.1;
        Sat, 18 Nov 2023 20:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700369891; x=1700974691; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U1PTw7o6n++p2pe3+uDNhmt4e6YOBmzSfzozTRbXj6s=;
        b=DKKICew2MXGcZ49HAdcc6o0ZmVQXzBLAOirik7sbg5J/33uv/h2sZODH2Wt6jwAW2j
         Nycc/LjSn2RQ7gPOMb2NQkOgN10QELU+GV7X7O5o8CMoCLDjJ/42wscvmftHESMSHyHQ
         AXUrapM/v/3tE+/dwEysaVjRMK4Yy6k/uVMOVEb9JxExVJIiUfCy9RdMlhSubV+M5rrV
         CgR7nZhC3cdqgTzAuaOzEkUOdCHu/BgoNOiUmSipuxpoQfPnwYT9ol926A3RKT5B3pdx
         qOxH7H6bdElH/+uoG0SKu1LEcZ3z78YRM9wdkE3hFoFRkymxmO9JdTTvdu4uben7glo9
         c9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700369891; x=1700974691;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1PTw7o6n++p2pe3+uDNhmt4e6YOBmzSfzozTRbXj6s=;
        b=TxD4X9WN9ifRXVTLmOydwh7OOx8tXytmiQJh2FThCdW+4DOlfGAXt8/D2uVIoDTnDR
         hjzqz+67VLI/FSTi57+dJKmR7g00zixRenc19EBXiSxVmiC1EHjOD12+JuyhZdtKtpGQ
         KcOJVpx0fWjyYFnXat8GX2pu2yPALGiMGrjSerSiEKD9cy21DgQ9tmBx9g2+Nddwjgk3
         X8huJpD20y9HSIxfBdnudxYVhzapxTI8oNH64FytVzkAo0f+dnTbS42MHODVfkh6/D9a
         PXGA86rzDoz4UBKLUo1zwpDkiVesYRQ0MzfGIdE03feMiT9Ryi+DJhjrbj2Hgk5PqhKx
         VgBg==
X-Gm-Message-State: AOJu0Yxuz1w+TxIFrvQqVIvfNsJq7XuAovxULJxK4pvjM4hU95L/h+gh
	XVcYsM5Oc9vhPFx7Z3aEcF8=
X-Google-Smtp-Source: AGHT+IGK2HFD07qQcC5gTuWG6Pz4nHtRACtxN+wG086X5yYjhy3me6IkMfCGn18OkNWuSNFFQjUehQ==
X-Received: by 2002:a05:6000:186d:b0:32f:80cf:c3cd with SMTP id d13-20020a056000186d00b0032f80cfc3cdmr3150241wri.4.1700369891167;
        Sat, 18 Nov 2023 20:58:11 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-9fcd-7897-f205-6e36.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:9fcd:7897:f205:6e36])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b009f5b7b6f3c8sm2504220eji.56.2023.11.18.20.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 20:58:10 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: light: add support for VEML6075 UVA and UVB light
 sensor
Date: Sun, 19 Nov 2023 05:58:02 +0100
Message-Id: <20231110-veml6075-v1-0-354b3245e14a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqVWWUC/x2M0QqDMAxFf0XybKGJ6HC/MnyINc5A7UaLZSD++
 4KP53LuOaFIVinwbE7IUrXoJxlg20DYOL3F6WIM5KlDRO+q7HHwj951hD1REA48gukzF3Fz5hQ
 2O6QjRhu/WVb93f3XdF1/p1U3hm8AAAA=
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700369889; l=1062;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=V2/ZEhgll+UdHLoD4NiUDtqLeWeoBJkkmnvE6IbaxD8=;
 b=o8z3uttBzv/qSqpOXKgErKg15ku3NmugreQmly9qW9umCTJi3IeqDq078C34Qp727OJdKDwQI
 bjSiDVUR7xEAQTZeuyYJiekSBrjNnSpFmgmsmKwcvHlNxvNWcxyopw0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series adds support for the Vishay VEML6075 ultraviolet sensor,
which offers UVA and UVB measurement channels and I2C communication.

The device bindings and a simple example are also provided.

This driver has been tested with a Gravity VEML6075 UV Sensor Module in
open air conditions.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      iio: light: add VEML6075 UVA and UVB light sensor driver
      dt-bindings: iio: light: add support for Vishay VEML6075

 .../bindings/iio/light/vishay,veml6075.yaml        |  40 ++
 MAINTAINERS                                        |   6 +
 drivers/iio/light/Kconfig                          |  11 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/veml6075.c                       | 503 +++++++++++++++++++++
 5 files changed, 561 insertions(+)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231110-veml6075-321522ceaca9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


