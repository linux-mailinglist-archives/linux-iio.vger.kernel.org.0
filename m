Return-Path: <linux-iio+bounces-18926-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DCFAA5CE9
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41D53BB64D
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 10:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9E21422B;
	Thu,  1 May 2025 10:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayRhWFtV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCC22AEE1;
	Thu,  1 May 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746093691; cv=none; b=O+jp0v9z9PEPVwCHx2Tm8T8WPHgcuSA6aKZetUlw+oUvMQSdmskqDplxoXgMyaqA7mBIOyASKzJIJEtnKHvz3hXvGpJLajhhr3ShKJXzj01PoKiZwBOeznnre1UkWk5g/gjmNUiAb525/MimBjR8+SGXosyrqxUz4NkdU+0PMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746093691; c=relaxed/simple;
	bh=AI/mHUl8LydWya19DshJH2A1tt9SvRunHOX7jCqrT4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rvwdEgbiSS8E4CdATXzaNy60d27aj6JkQGOtOCSVEfSwUDnFbtVK8Ay3oPW5rRa6g7AF3Q6Y+6Ar+nlq8t4Ee4biuN4NatOURPJqGW3NSmWd6jk4PV6EDcqYe0eE3Wxf5kN2YUFfP3LAsqNEBobyqZOr/4K6VHyZRviAZ17LopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayRhWFtV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so710992a12.0;
        Thu, 01 May 2025 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746093689; x=1746698489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxebTC5y7OhLqj3HmllTjlggghkFcGo2pX2o0VLrcuc=;
        b=ayRhWFtVVDcTjwv4xZxKeNjTHbP9mD84cKQlAm/hGcbdwH0XolcB3BBw/DhuLaYm5m
         nJnm2CjRICx2yLHqp8Y0nnumAW6mvHwhYWHslJqd3miYtoindCVsN5bzDiqKmFucSMgO
         pcxohEkYvf8aPMPbQY3L3+wSFq42yr53g0dB2ckLt5ndxzM3eZrt2EZrwPOyD+gec90l
         TtxRtWkCWJks3FZAPDyuo6FdRosrproeOUeOlnaS4llfSeYp1Rg1Vbs7WP9xbPgtq1j4
         7qeiB4YVcDl3D58nM6xMm6zU3jq4i9Xtja6vu6WCqk7v48KD8zQoNbLe1vviVvVmFO9q
         zhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746093689; x=1746698489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxebTC5y7OhLqj3HmllTjlggghkFcGo2pX2o0VLrcuc=;
        b=xAIpCGJveMOzLxIOgf0O2VADTWX/YfQxgVvcy1VdaenMq0cREJNEYD2UMeilcYTiYS
         Hbxr8lxDHw+SWjtgLK5A5RwtAh39UbV2F8N8nnVSAj6x2LaMMHxb/AK3DV1mAkR+dL6K
         ib0xvnkXOQKFB1qBg0twuWvh7FtDBtKuvQU8Iii9jgskuLHIPrJT6prwD2a3JiXOwDyd
         8Hz0CimTEanxRRSv3pfLcph3OPTuonouuYT3PhInbmPRugbw7V/5XzllkqVJB4YSOqva
         GMkmF+C0JLZ96h2b/FXmCFzlDtHdhiOKBTFaJSsDQzYJvF3WjSiIeR5MTXhhvEBLLshr
         mKIw==
X-Forwarded-Encrypted: i=1; AJvYcCVCbiy6ihmucIRZ0Jtovpm68p8hUWB5h9HpZcj0O4OSaenlylxSJys5wuG4hTMj/HLb1XLtV18HJJtBi0ax@vger.kernel.org, AJvYcCWTJfSJbCTAagxfk+X8ARbx7tJLlpQYJQQn+MrJ8aVAXDpTZ8SPhfn2O8ApGWEFQYwUdoHwVl+IAidJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFSWWXmxskb5rcZU4vJN4aOwm8W739hP5nEcvKjd5WWSpp3ns
	eIdKQg/h0tMBPnMM5XwR9lZsGWHn87AwnRT/ff0VmXr5lNaCpw1kvY5NoM6lQU8=
X-Gm-Gg: ASbGnct+48Qtx5ScZJqwBEBRU1Z6RhZWjW0Skhhv+8DUg5TYkTdPGN/7PnxJfIH+Jiv
	aGNoCDKEM+rcGSGPF/Bm/EHSpv4cXb89sYDwb/wgw0VJ7wAVQW3TMNuBVUOhTDFLlUBJeXjc4UA
	ByjMnspbVgLojWwhtViFvheX1cds/udaIC3W75usICYa/zSgGKWV+gBT7jkjI77GJfgOiV1FR09
	vBO+NKGQE5IwpxqyVpL82dq+pKwW5NJAwdrxy9gM8w6tKNJOXEN6Ier4PVaMwQ3ILb5zV+UrDvR
	IF+02I+Fvm3Sh7cBQNVoF6JhYws/Gm2yqELLDIG/Tg7uF0pW9LKwdOH6kA==
X-Google-Smtp-Source: AGHT+IGQWOmfENunZupgyaKhNy0TTGVADlNGGuyh/mvhxc8Rx0ELKrdePtlLozv9FQcnYc3pkVzkBQ==
X-Received: by 2002:a17:90b:510c:b0:2fe:8c22:48b0 with SMTP id 98e67ed59e1d1-30a400d32dfmr3921191a91.15.1746093689180;
        Thu, 01 May 2025 03:01:29 -0700 (PDT)
Received: from debian.domain.name ([2401:4900:1c45:13dc:af05:2012:1f6c:ed34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a47476120sm472477a91.13.2025.05.01.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:01:28 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-iio@vger.kernel.org
Cc: sayyad.abid16@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	olivier.moysan@foss.st.com,
	gstols@baylibre.com,
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	eblanc@baylibre.com,
	antoniu.miclaus@analog.com,
	andriy.shevchenko@linux.intel.com,
	stefan.popa@analog.com,
	ramona.gradinariu@analog.com,
	herve.codina@bootlin.com,
	tobias.sperling@softing.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] iio: adc: Add initial support for TI ADS1262
Date: Thu,  1 May 2025 15:30:38 +0530
Message-Id: <20250501100043.325423-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADS1262 is a 32-bit, high-resolution delta-sigma ADC communicating
over SPI. It's designed for precision measurements.

This initial driver provides the basic functionality needed to:
 - Probe and register the device via SPI.
 - Expose standard IIO channels for reading raw voltage samples.

Basic testing was performed on a Raspberry Pi Zero 2W using the hardware
SPI0 interface. The connections used were:

+-----------------+            +-----------------+
| RPi Zero 2W     |            | TI ADS1262      |
| (SPI0 Pins)     |            |                 |
|-----------------|            |-----------------|
| MOSI            |----------->| DIN             |
| MISO            |<-----------| DOUT/DRDY       |
| SCLK            |----------->| SCLK            |
| CE0             |----------->| /CS             |
| 5V              |----------->| DVDD, AVDD      |
| GND             |----------->| DGND, AGND      |
+-----------------+            +-----------------+

I would greatly appreciate any feedback on the driver structure,
IIO integration, SPI communication handling, or any potential issues
or areas for improvement you might spot.

This series is broken down as follows:
 Patch 1: Adds the core driver code (ti-ads1262.c).
 Patch 2: Adds the Kconfig option.
 Patch 3: Adds the Makefile entry for compilation.
 Patch 4: Adds the MAINTAINERS entry.

Thanks for your time and consideration.

Sayyad Abid (5):
  iio: adc: ti-ads1262.c: add initial driver for TI ADS1262 ADC
  iio: adc: Kconfig: add Kconfig entry for TI ADS1262 driver
  iio: adc: Makefile: add compile support for TI ADS1262 driver
  MAINTAINERS: add entry for TI ADS1262 ADC driver
  dt-bindings: iio: adc: add bindings for TI ADS1262

 .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-ads1262.c                  | 438 ++++++++++++++++++
 5 files changed, 647 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
 create mode 100644 drivers/iio/adc/ti-ads1262.c

--
2.39.5


