Return-Path: <linux-iio+bounces-13805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E18E9FC8B7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 06:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732547A1237
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 05:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783EE15E5CA;
	Thu, 26 Dec 2024 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUOEJ4Yc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39E14AD3F;
	Thu, 26 Dec 2024 05:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192409; cv=none; b=KNWuNQ8zHxiKF33XsFd+o23E6kjS3CCqF+3MbyeiK8wxNQVvCinNAoRwBqoDcBuu1lg1QgabIli5iU6D1iC5XvQdZPufKw2pvprrah20SiFnXEZdbuH5ZMh7OC2g9tL7jVzcTCbVFaePmvMi5DKqRrWkxEP2HnrRVoyIi/1klSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192409; c=relaxed/simple;
	bh=7VvkaDH/zxEpeZoFn8NW96i/X2Xo+pswTjpT1YVY1jY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F93UsQtcfz2uSyJMN4MYRoCHJEkhKg4Ob2lk92SXN+Jb0sucOVyQbwU7sk+eL5YXzg0aePie8x61w25FjLZ6WteilSqDER6azRct3gG2id5X50NThXTOqRIaorQcp0g8xL4Ns7nslY1xQRD9mTxbEirWEkiSJDjlqV8QnyhcVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUOEJ4Yc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2156e078563so63172215ad.2;
        Wed, 25 Dec 2024 21:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735192407; x=1735797207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FeWw1POirV279kyPc1N7G6Ig9OxjD0d5GRNIwt9u/dU=;
        b=OUOEJ4Yc9FbuvO0sNmKdcVRl6rIrkPDr10RkrRmEMOIfIzjDvziXkmPjHY8/3bZZtZ
         47TpCfcTZCU2+CxDn9ThrnFX9lNq681ROOJNuflIuZ2Vt4DZYxbagLkkpmlciw+teGWW
         Tb6svinKjXqMs+VrawW5rP2UK8jiFCqzXKIMrY5Y9CXGv1hernWZaxfw8yRLv5sXK2wa
         sj7GAS52nj8oChqI+eL4ckgNX2X4hiJWGs7uVCUDZJS9JqsShanuoE/CCdmjXuRM0i9o
         IbsQzkgIq/TvZAbbo/Z3jNWuzRuV84m7tXQAiyz8m8HVjF9hnjHXoQGEjfLRSNYUaDRG
         qYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735192407; x=1735797207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeWw1POirV279kyPc1N7G6Ig9OxjD0d5GRNIwt9u/dU=;
        b=ODOGzgW59jFJFP0otE3ymiG7euNJmaEsQXOkohOCMMcLz4EEkNlPFIVUe4WMy4kWRa
         hCSn15A2n9e123aH8lNdUSrxdJlxUM3Vm9cfuh2vAb+ukaUb4C6D15BqSado2LPdA/B8
         NpRUtAshKc6ALevClZEOnM2xuBPDOOY/ejZQTJ8aLHje0+YO77pb/5N7GH9Zy346H3nj
         w0KYdvCUaTA8K2IKic7Bs14NiUjt2tfuo9OVxyx2W42L6YI51FiTLGM/u/uM4E4mjwev
         8lDt1y3UFYnXV5ErVQ4EJuntBsU4l0+2sJcAYH4Bf5yxcanX32bKilmvIXQPGEstumf2
         LQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUwD8whGqDlyEPLotfcA8Vbv8jTO8+NjsvhUgN4HSOuapi+39a4UCirB6KPhIgErHhGTeXjCKh2ZAqs@vger.kernel.org, AJvYcCX42CunauX+MfrE7TvX6wLM+9aHihN6EatMB1bx6PT8js7HPRUjqgLNhbCZj0UrhQedKFjG/qcdWT5HUqfe@vger.kernel.org, AJvYcCXImqVtHW2Z3iThq3CU7rEcxMiIZHulDvHsF8GsZ55YdpVTOS4BvnoSkBgCotsc4x1zXJD/wiiD8btv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Maa54w1oh4gXj891yPXA+ByrnKcD4w7UYkaa+CkCoyxawIQa
	xQe2nQhvhVfOw7UuSMVu+evEICEQMr+JDPyBD5rj8HfVmJ38UI77
X-Gm-Gg: ASbGncsBccNEVN1I0vAigvwMc2pjfPGpk9JYHsBsKCCXoHfmxGSNqN2FAMq0PvTQ/X7
	20rUDd+1k6EnLE+Gr+1lAqf+tco8sCc4x+rKDwxInud7vWkFNCgbHsbLh0IQQJN3Vk9fuSnO/Qc
	s/+rpVi0NCX+QrutHzIAUCCorIVMet4lDNgcVT4pXtFTtOUy0o1Q3gCSI5RS3OdqCWMJGLaiiCP
	BnH2AC2CZrZf6UmzNlDRsih0hT2vqPE4HXIkMXhYRKEvcgWVI1ltT/cv7kOyAORZrxXj1JMMKW2
	+w5Ac9QlDTKGdLMdlOSl/g==
X-Google-Smtp-Source: AGHT+IFFhwKO4ICta882R38aTBMCAsSh7ScglNr3FCDjMYJyLDyCZlBEzIXsDd8x71I/ifCe9b3iWg==
X-Received: by 2002:a17:903:320a:b0:216:539d:37c3 with SMTP id d9443c01a7336-219e6e9e8d0mr316810885ad.24.1735192407017;
        Wed, 25 Dec 2024 21:53:27 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm112679455ad.21.2024.12.25.21.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 21:53:26 -0800 (PST)
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
	andriy.shevchenko@linux.intel.com,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Thu, 26 Dec 2024 13:53:11 +0800
Message-Id: <20241226055313.2841977-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 3:
 - Fix comments
 - Don't put nct720"x" in the name, just call it nct7201
 - Remove differential inputs until conversions are finished
 - Add NCT7201_ prefix in all macros and avoid the tables
 - Correct event threshold values in raw units
 - Add with and without interrupt callback function to have the event
   config part and one that doesn't
 - Remove print an error message if regmap_wirte failed case

Change since version 2:
 - Remvoe read-vin-data-size property, default use read word vin data
 - Use regmap instead of i2c smbus API
 - IIO should be IIO_CHAN_INFO_RAW and _SCALE not _PROCESSED
 - Use dev_xxx_probe in probe function and dev_xxx in other functions
 - Use devm_iio_device_register replace of iio_device_register
 - Use guard(mutex) replace of mutex_lock
 - Use get_unaligned_le16 conversion API

Changes since version 1:
 - Add new property in iio:adc binding document
 - Add new driver for Nuvoton NCT720x driver

Eason Yang (2):
  dt-bindings: iio: adc: Add binding for Nuvoton NCT720x ADCs
  iio: adc: add Nuvoton NCT7201 ADC driver

 .../bindings/iio/adc/nuvoton,nct7201.yaml     |  49 ++
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct7201.c                     | 449 ++++++++++++++++++
 5 files changed, 511 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


