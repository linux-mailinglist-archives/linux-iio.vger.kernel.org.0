Return-Path: <linux-iio+bounces-11931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5A9BDD18
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 03:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AD71F242BA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2024 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470F18DF64;
	Wed,  6 Nov 2024 02:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bioSsQrK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6B21106;
	Wed,  6 Nov 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730860778; cv=none; b=L+GvdDcyq710mqpjrF9KxPVPT5BeF61f8Ti3WILILKAcxVmq8NGif5O1Url7xQoXyJXB5qZRT3ZWKTJimXNkGGnfEB9mCK5A+r2nl7GMFrHantBmq1im6DdRoCXsLE8Cyak8+ioooXrPJzqd0r87DCOl/6i+ii8IjsXQ625y/OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730860778; c=relaxed/simple;
	bh=QRKo8U7x3Co0izA3jDtoKaPVGfIjqejXHW7FurDca+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bXt07mECL+D9TjTq9nv1SxCuQ/BzJIe4nAHvw3un1NwzO2QVYSVtqtU1W+kCusim86pOes1wB0yHIL5mtgrRmJcLf3AyUmr3FsGRfzkwsNnEFVJFrJLBUpmpQyuGieCQPEYxkIbOMSPHQMQDo4Bz3GBnsmSV2Shqw/OoHWCrEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bioSsQrK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72041ff06a0so5356026b3a.2;
        Tue, 05 Nov 2024 18:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730860776; x=1731465576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5aqta9xWdl89diKgAynphJa4Bu9tznPgpZ4juTK/lOs=;
        b=bioSsQrKpm6vFEU9Lbpa1is/7fjmtshfcRZqY7d32SOZDL0sbfyZ3RdPhKB5ZZ8Sjt
         9mDHSTTm1xoPXgGzCIftfHhT8QI9bh5CjZajpFUdDh6KdZscGgP7D5Z+Z1cP4XncpJqk
         WRJKYx0mMp7Txekhzi++XhcdUdecAho1ZxjSMdH0Jw+DCMg3/C49wrXzEZkdJz44QpuH
         UGPNMl0yoFnpV4h/F+SPOc1pwnox9xYwd6/SktDzycocoLMmTO7ZACTNo9dzESfHalyJ
         unxsh6eGTWC50htc5YV2zLsiZuZS4gUg8Zlx76wrpZdoKzGa4rYV2scFWERGfuSeqn9r
         1x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730860776; x=1731465576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aqta9xWdl89diKgAynphJa4Bu9tznPgpZ4juTK/lOs=;
        b=mFza9nlNYEQfmIKIJ5bnpjhQxyLvQ4lu9gn16xoVePi6Tq/KbQNJZRBQWJowzqoyjm
         cFb69m44xv+/cccyigByL7Ib3kxgwhggwZNj998zQonZ2fZDwnfjs+xbAM631TYDjuQ4
         7KB/FGLDZorqMEoV7h6OvWFEmFUgW0yWJX0IaFCT3dn8tUcpWYmwwa9KEHzAu2vPxB6d
         +NFc84iSCMeRzIyv3hUQNCEK+Jix75oro3dt7/dTrvp1IVkmQlQSfyHUFu1GDpaMIq9w
         JG/l1OH6on/leKQ/ilwEJ4+Sy2utesCgbCseLZ8BwGLy1917s+s+MYOzKdLrebFudXCZ
         xxfg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xk2xCyWuPvyq3xfMa5R8CANSJ8RVjf5Gtj+oWqyvSxTiOakBzRA8K+BeFFB/+biZR89gNCgfFZPV@vger.kernel.org, AJvYcCUQX26hjc2KiAhU3rP+o/wu03JKXgJVF9CciGIC5fXWnEehVeZQ6KSF7o/XSIcN5vxH658FIF4RmJ99XaES@vger.kernel.org, AJvYcCWNKkdyWDmnlLBWO+Cm00i7sT3EsfueTp0aXu7qsl6maruXZdUQIDvlHsVxTm43TyWFS6blOTeC3ifk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wP1PavwipZVSXpCMa98bbNA6wvFsl3zBQmiVrMEzEadV52+D
	/yF8P7U9M+SRqwf5drA6WNm+idVPGMLC7K67oFx6obaP7k5Dxr/p
X-Google-Smtp-Source: AGHT+IGHXwrWMQWOHGiJbdIOc25nriZXhePbhiKeAdZty+sczhomUbGDQZgQON2Ctu8YaN4Kln3sSg==
X-Received: by 2002:a05:6a00:a2a:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-720c98a3d45mr24435157b3a.7.1730860775842;
        Tue, 05 Nov 2024 18:39:35 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c39acsm10382484b3a.137.2024.11.05.18.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 18:39:35 -0800 (PST)
From: Eason Yang <j2anfernee@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	joao.goncalves@toradex.com,
	marius.cristea@microchip.com,
	mike.looijmans@topic.nl,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v1 0/2] iio: adc: add Nuvoton NCT720x ADC driver
Date: Wed,  6 Nov 2024 10:39:14 +0800
Message-Id: <20241106023916.440767-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since version 1:
 - Add new property in iio:adc binding document.
 - Add new driver for Nuvoton NCT720x driver.

Eason Yang (2):
  dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
  iio: adc: add Nuvoton NCT720x ADC driver

 .../bindings/iio/adc/nuvoton,nct720x.yaml     |  47 ++
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |   9 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct720x.c                     | 617 ++++++++++++++++++
 5 files changed, 676 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct720x.yaml
 create mode 100644 drivers/iio/adc/nct720x.c

-- 
2.34.1


