Return-Path: <linux-iio+bounces-15906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FDBA3EFA5
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 10:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919CB3AC315
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D1F1DC991;
	Fri, 21 Feb 2025 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ns/MhcEH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E95DAD23;
	Fri, 21 Feb 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128976; cv=none; b=XobnZZMPW9GWnEBmU0tvXkVJ/Aj34O5JHH98kIC9551aWsWmHItB5X/etJyq7TDhHBZQUixmWtZy4FFKzxvk4c+v6n/VnPjEbrgnsF/686iFgfRnPGwysrq+plwBmR8q1rl3cgQH2MTyqYwO35czv4lZyTdZZwqJnDhT5a3DTgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128976; c=relaxed/simple;
	bh=atF49Wf9ch4bq4+y7ep9CEtDZcJs4oL27xVnNcfrhiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=agQkVnhs6VbBdi5qtMAfV/+9Zj0arlOMgl+X/U2vlhEejc3XP8cc2ZD2tHEX2f/p36wheO4QsGSYNO7qu//VbDzADbtjh+9SiJUCCGyGo0QGSMSQJe4ojtILNu2bwjTid867+WPXwUFDaY1cSPn3b81JiwYpGmnwNk/yoXV71vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ns/MhcEH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2211acda7f6so38914395ad.3;
        Fri, 21 Feb 2025 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740128974; x=1740733774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqGbA/0NwGgtEVAy7QTjo1baSDqwWc407TkYNX6+Pac=;
        b=ns/MhcEHtpYRF7qwXZ5tp7g78Ibw/75X2Y+LoCVtv9ZPVfCVRG9iDw87/1GSWa8vWn
         adRBSW59X4B9t/Mtjd/3WzHS+JecaYTC8Vd1eUJXtNruWV2hzaiOTX2v78xh7kZXIEyn
         6CKYgwQ8CAOxFDsU1EEQAg5nJN8ZAlnN9LisRvTngppcFwTss23aQhnqS1j/akDZd4rF
         VEgasA0ChmrlWHK4rD60hjSWJb6aEfbLFSRgKWdTrcA40EiE+Lzu/kxYDvUtuk9WxNum
         HX5XFkCLjxgzmNGO2dF29EVtUueAxnSSO9Y4V2jCFiuZXEVnT5U3rfYGc328/+nbKMfd
         LwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740128974; x=1740733774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqGbA/0NwGgtEVAy7QTjo1baSDqwWc407TkYNX6+Pac=;
        b=gwAPIwRhHEz+4+uE6Ycl7EAUi517Yd86nKHVS1Kj89X2xCjQiSTP9rVGKYmcE7dNuh
         Lj2ndIN/3rtq0IqJlCV9Zix1W82L2CD2ZMn6Jitl+DNe6VFvZy82kXvyh7cf6luIAV3j
         VtImvX6fhCWrwVducJYNNPHkwf+u8P5sHOow4a98nqdxnBIj9uC1SgRb6w4LIs75ivay
         MAjNCTQejDGvPlUFLlo4KiORPaS+DR0wFT/OQe7EC3sazj2WNcsVtp6N6hAsgiI3nRrQ
         xaxiObfLgrWV98mtyC+aFCEWZN6CORyOgjuQYNVSenYRxn2y5JJ5BFl4HLrSNZUBNzNr
         0TBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyOFDBKcp1yWvSf8ZEB3asggBlOGYkFegh6dQXXcGLgFW84VuI0ds3FKJZhbq/KjQGj/o5u8CvgyvefFZm@vger.kernel.org, AJvYcCVUsaLsGNB68yxxAnWJx06bq7m2WtYrUIxJORsr63B5G6YdS4Gw8iMBLDlqQvhfG50I9XGHjBdVRnJ5@vger.kernel.org, AJvYcCXRc9EzMKEaYBePEPLDTX3gMXh+sd3gfUJDTMSytrojjckZlVPSBzrRfibha9tgcCsALrvXtkp2Wepb@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyPZFk+3QTnUFmVescozUFfhCCLCUUyXSduVga05WE8ayPITC
	k0LvSyI2npP6k3sDqpHonNw2z2ou4CrzSRzQeSJUua/BEkF8NyXg
X-Gm-Gg: ASbGncsf6q1aE7scspxQsAc7Ou8ZjPK0cM7ICH0I+wLmjhZvCrKZLHp0xfHdc1vziRs
	zaseyC+gPMMTY7P6P8xSc1bQNwW2sGaBHp1gYCfUEeMynPZ7gtA3lBcABEtkv3JY58vk4iOTYEi
	7p51W03XsMR7/fK2tlunnDlcaBARWoeLYrCWjdb39fxfSBX1woxSN+shkUiF+7lu+hOuV6khqWI
	RECKpMh4aVWw1I/f0jwx19OKQFSfVqIoJsDtjKK2MbzRJNy0+cTJCVg+Ud15D01g+OkAxSci5Li
	jYukv1Lw2gQspQ6FSYlEtUdndW7k/tucwQnN30rFnuwQ0RIjC3XtTxV6vQ==
X-Google-Smtp-Source: AGHT+IHue6t9hMQwjssNM5DwX9cqnd0OR3VV+CKpdu46s9JYRLX9JgSKZHuMCZkMnCgJsmhoePwtPg==
X-Received: by 2002:a17:903:32d0:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-2219ff4e7f2mr33490245ad.18.1740128974428;
        Fri, 21 Feb 2025 01:09:34 -0800 (PST)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367e8csm133593115ad.67.2025.02.21.01.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:09:33 -0800 (PST)
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
	gstols@baylibre.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	alisadariana@gmail.com,
	joao.goncalves@toradex.com,
	thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v4 0/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Fri, 21 Feb 2025 17:09:16 +0800
Message-Id: <20250221090918.1487689-1-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since version 4:
 - Fix comments
 - Add interrupts and reset-gpios to the DT example
 - Use the FIELD_PREP and FIELD_GET
 - Add use_single_write in regmap_config
 - Use regmap_access_table

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
  dt-bindings: iio: adc: add NCT7201 ADCs
  iio: adc: add support for Nuvoton NCT7201

 .../bindings/iio/adc/nuvoton,nct7201.yaml     |  57 ++
 MAINTAINERS                                   |   2 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/nct7201.c                     | 487 ++++++++++++++++++
 5 files changed, 558 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
 create mode 100644 drivers/iio/adc/nct7201.c

-- 
2.34.1


