Return-Path: <linux-iio+bounces-26366-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F8C7B0AD
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 18:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5128A345311
	for <lists+linux-iio@lfdr.de>; Fri, 21 Nov 2025 17:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2A6346FC0;
	Fri, 21 Nov 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV+7jSuF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A093340A4C
	for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763745400; cv=none; b=Lf7xiUXRtow0K8XNCbhS+e9fG5dZoKiAsRBSCGOk4xECs+opbfXl45GAthprv+BAi9ZFETei2PntbmUQVImWwjDbMDFZ6csOOF32BsrEu8Dzn29LqpQk0KIMlcahg8avp21y7ySsaKyslL/oEh8W8j/4qvFO+l178S0sa5TJxs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763745400; c=relaxed/simple;
	bh=SkLzZ5Rd4z/hR09+MOL5og400mSYcS/W6VZzgWxZRzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DHsf2cwyM3c40wvcpsqT4RccZXz5jgfHy1hsSfcWoerkvHLNV0C1Mkt0VbBgmc3NMy/d2pVVQ9cA7wdZORTLCXDxx6sr+qLs1MfWqGGW6XrdBdhL6jRYPwV6fySHrocWpC8TdcShVemaIvnU737YBJB4et3+nw5tXCHEAPAxrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV+7jSuF; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5dbde7f4341so2879932137.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 09:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763745398; x=1764350198; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+pdDwG6dzXuJBegjHU77HvlovlFjmyHVEdno7rJHvc=;
        b=UV+7jSuF9nEziGK3jib2z4+ng5Kg3R5j4ALSWEe3CNwy6/qpVzWeRiUIIXq42TtQcK
         W/eShYRW84Vr/7AHDiA6UrL17vYcJzvl2U95f4LO9XoX6mtMcEmZOgvixM8CMY2a+Zo6
         8iF/FYk67XsE2w2RqxrvqUy3r7skRjJNbjbtU9M4+mhwfAV4WeDxgWVDlRVCSyeq3USf
         xYTb8UBwDSepX/ftJinw3wTx9XSbKfihuFyBVRfD89HwiuMM1npDmyXJo9LtT4A6HD+w
         ecHyiDV0DjkE6cjuV7OsQKg37P7Wazq+jRV5TnPGoro9A+2W6iT41NfOkJDZMtk27XEn
         aOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763745398; x=1764350198;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+pdDwG6dzXuJBegjHU77HvlovlFjmyHVEdno7rJHvc=;
        b=pObGfm3VwThC12LdQMlw42UBVbVV9tPM0PkGgOV30RrHKI/0NRj9Tog9FVcCLMUgK5
         T9IobFelg36Fo4YIF1xHjq1YKKiZnWDcQ8ar6/cIjgZQWDGsLyZflH39+XMLy76muHDv
         n/9pyHBG6OUw8R3SFS0nPw8KUIHEePhaEpCT+NFzZ6Ud5D5Up/P6C7T/kvP2rK1aKJak
         qEUMBERZRao0mtDVkCZjT9GQ+Gp4fjg9gY44I0qAaN34pOlIdugluWTWzjuNxsShR8TV
         7rGnjV4mWXC4YHhdG1VU7fq6xy82se9OfW182dPCX3fMtTKY5ikWjoMK9L0by414MfZA
         88sw==
X-Forwarded-Encrypted: i=1; AJvYcCVhQRnCeaaqfgspVqAJ7OEwm60URq0/iEGOhkQ84LIX/vqdqBToH10UDDOKuyOuiPXZ3mOHp4yLofs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGj0MyPzdlVedyv0F36n0l/vG5WKFK5+RYzkumL5Sz4m5bX63
	AVJ9BaliskewM41ar+9xr9iP4/8+xcHpiwhNRQ1XfiOFhUpprWU3stIK
X-Gm-Gg: ASbGncsnxx1hZZpTQ3p0Cfeka8EBvk3ZHjsmqw7ukQu3Tg58DtLz7YgwJ+ZEmkUaS4m
	2GB4CC21+190xMhpwKzFlX6N/3P4EGSdU/WYBGrE81RNR2HlHq+NaDpmwOBka45EJ34Y7F/BEf0
	WlBPax0+/6faWBy9PEAOUiyKUfgMR7t+oSnyZ3aeirDhQNDGdc5sAdlJYYbIRoxnlaf7MWdm5y1
	h+OZ0ftS/pA4I89VOYTN/btWPhLuktnPp8i5xufGawlvv6o9eKj8Ni7cUz3bFwarAQWEIrmCPrY
	WoHxoO/OimXLu/+zeNzxogTvwEK2OPuV/fSmzvtUPLGlPaKnO+XDc+eq276tgH7om82dXmiEk10
	0dv36CrrANqyYKAhfPBhGBF9ETKYTivAxeEnlyOQw+WuIU966fTeP5eoI2EzJrZKb9khETNwBKX
	xJKdEt4P4fQpvp
X-Google-Smtp-Source: AGHT+IF8/Ex/eDUVlLmdr1+X5s76Sr+ZCE3NK6DYE+c5IyTnbzkxdfegbW2OXzGM0O7lBMRkfsguUg==
X-Received: by 2002:a67:e114:0:b0:5e1:86cd:21a3 with SMTP id ada2fe7eead31-5e1dcf41e1amr1261335137.14.1763745397783;
        Fri, 21 Nov 2025 09:16:37 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c562728fdsm2554368241.7.2025.11.21.09.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:16:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/2] iio: Add support for TI ADS1X18 ADCs
Date: Fri, 21 Nov 2025 12:16:13 -0500
Message-Id: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2eIGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mj3cSUYsMKQwtdgxQDc3PLFAMzM0sDJaDqgqLUtMwKsEnRsbW1AOj
 JF21ZAAAA
X-Change-ID: 20251012-ads1x18-0d0779d06690
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=SkLzZ5Rd4z/hR09+MOL5og400mSYcS/W6VZzgWxZRzM=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkK8/Kqv8yQ2/Z/SULi0ZeLvh06uOgge1mbiSnjH9HQj
 ROjPkRKdpSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBErj1jZNj63jD5bFf4+WYJ
 yV8zbHa2yjHOZ3HbLGX24wOv3pKYNVEMf/ificq+XPk3v69xubjbZbuzm17uEdSwLnn2u23BpuP
 9wpwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi,

This series adds a new driver for TI ADS1X18 SPI devices.

This is my first time contributing to the IIO subsystem and making
dt-bindings documentation, so (don't) go easy on me :p.

As explained in Patch 2 changelog, the DRDY interrupt line is shared
with the MOSI pin. This awkward quirk is also found on some Analog
Devices sigma-delta SPI ADCs, so the interrupt and trigger design is
inspired by those.

Thank you in advance for your reviews.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (2):
      dt-bindings: iio: adc: Add TI ADS1018/ADS1118
      iio: adc: Add ti-ads1x18 driver

 .../devicetree/bindings/iio/adc/ti,ads1118.yaml    | 132 +++
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  12 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads1x18.c                       | 919 +++++++++++++++++++++
 5 files changed, 1071 insertions(+)
---
base-commit: f9e05791642810a0cf6237d39fafd6fec5e0b4bb
change-id: 20251012-ads1x18-0d0779d06690

-- 
 ~ Kurt


