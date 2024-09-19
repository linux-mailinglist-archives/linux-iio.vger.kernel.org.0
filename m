Return-Path: <linux-iio+bounces-9637-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A0497C6E5
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B06E1F281C4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D11E199937;
	Thu, 19 Sep 2024 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qtvIMknt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839A19922A
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737698; cv=none; b=brh82tv7+/HKm0zbLGDA/0nDFtrLw5SUVi+3VbrojD7jcAwZciW8gC4NZj8WMfyNi6FWnpzzp3mnyCa/f0BJ4bZ/hte50sWpolQy+FnQTd4q7LMaIvVyrZpQpRUbFG0ZBqc27istDT7CSdA4rwoeWLRZNeioa59FdwLmcqC7No4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737698; c=relaxed/simple;
	bh=9K94bsQInkxbf+bSNW5RZty39cCxuDTVv2CdbHV6Ex4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VQUnsvmMdoyUbxnjMrGq8uadr2lysWji4lqRWe5Df24EYnj9BlVj9IKMxSP02ORwBeCrrk55pfI4H9wdn56tcrsn5b2ewwxYkUfJFu21dbR6hcGVuU9b8Q+o0ZngpTv0kpfsgQY5agpUq3KmjfZBHmf9ubuSKeIL4gC26u7At2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qtvIMknt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so6544421fa.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737694; x=1727342494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JMj5mfXiJJfo04AgibzT9+cKa765pGWiurrBxBDlrs=;
        b=qtvIMkntWFTIdUOYx9omD6UtlqwkvA6ZbOK0Ag2sueI1jgtB5BiWlf8PvL5WiS49QZ
         b6CWGk8HWLZLeiy7yQ5IyMeLCrNM/G9bWRLixHHsmEHiYzPUucixq7GIAOsZSZKBTylz
         6bVfUdyiJ4MCn5cuATQGdTe+IDvExcPK22WBYk+pk4mCg0GaQA0CVfyRwUxRW1B6e/U/
         vuj9LJ8EEki6TfZr4y3KW2BPPNP+WwMQBx734FsJS0QqpaEmNz/IpqUWBupvQ3jN67G0
         UIF4syFXFhy3zAGq55d4NYrPdvWx1ND2X/J2FpUXgT3eoTZxfC8O75gPNTBgnMCPHB9R
         O0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737694; x=1727342494;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JMj5mfXiJJfo04AgibzT9+cKa765pGWiurrBxBDlrs=;
        b=U9Lz7YVry5n8xlzGG3sa1U55OwYd7u9cJDHz0WLQmPQvOtCfr/OUKx2f/WDHU8I4n4
         m05JQnx7/MgKf3La5vVJ4B1bdb1ei9PdjoKVdWMYIn0Mc9EBif77RSFCOSzXzBQrngzP
         u3UekickHZCOGdArWCOHtbXr9H6uYgEQfz7YRTCrUyqnfOTv5ynERtZcwM0nqT4es9Fi
         GYYhTegvMUY1vHZHxwaOF+tHTqP/jPUtYHik/MRlY3gmEQ6bQZn8XtuBU3dlSwGf/xIU
         xBDOCDKQAMvuOFX+Mme4DERg0Qxpmh5ewR4LLILWUEuRhBbWMF/BFCQdxyZeJ+d9p8N0
         Tk+w==
X-Gm-Message-State: AOJu0YyQPtjLBkGB/i3OlAWKXPsLzaHORVSEAFaMvHuOhTFu008/G7Oz
	G2E2i/LKLkd3sVsFSblnmTejYFdmgbCMvmNFGshubfNznr1A5XrfYBmJLmUTSTk=
X-Google-Smtp-Source: AGHT+IGM0Y3r7+gNR/DSAnIT1d21KFJtZd49LfOQKMIvTneI3LyvlzrzglH45meyrNtV1yUu2X09Yg==
X-Received: by 2002:a05:651c:154a:b0:2f6:4aed:9973 with SMTP id 38308e7fff4ca-2f787f5833dmr154394841fa.44.1726737693720;
        Thu, 19 Sep 2024 02:21:33 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:33 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 00/10] iio: add support for the ad3552r AXI DAC IP
Date: Thu, 19 Sep 2024 11:19:56 +0200
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzs62YC/x3NQQqDMBBG4avIrB2YJBWJVxEXqY72hxIlERXEu
 zd0+W3euylrgmbqqpuSHshYY4GrKxo/IS7KmIrJin2JN55PbPz+cphc09jE4QIfwsDKu+YdceH
 We9eKETXjTKWzJZ1x/R/98Dw/3fA05XMAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

Purpose is to add ad3552r AXI DAC (fpga-based) support.

The "ad3552r" AXI IP, a variant of the generic "DAC" AXI IP,
has been created to reach the maximum speed (33MUPS) supported
from the ad3552r. To obtain the maximum transfer rate, the custom
module has been implemented with a QSPI interface with DDR mode.

The design is actually using the DAC backend since the register
map is the same of the generic DAC IP, except for some customized
bitfields. For this reason, a new "compatible" has been added
in adi-axi-dac.c.

Also, backend has been extended with all the needed functions
for this use case, keeping the names gneric.

The following patch is actually applying to linux-iio/testing.

---
Changes in v2: 
- use unsigned int on bus_reg_read/write
- add a compatible in axi-dac backend for the ad3552r DAC IP
- minor code alignment fixes
- fix a return value not checked
- change devicetree structure setting ad3552r-axi as a backend
  subnode
- add synchronous_mode_available in the ABI doc

Changes in v3: 
- changing AXI backend approach using a dac ip compatible
- fdt bindings updates accordingly
- fdt, ad3552r device must be a subnode of the backend
- allow probe of child devices
- passing QSPI bus access function by platform data
- move synchronous mode as a fdt parameter
- reorganizing defines in proper patches
- fix make dt_binding_check errors
- fix ad3552r maximum SPI speed
- fix samplerate calulcation
- minor code style fixes

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

---
Angelo Dureghello (10):
      iio: backend: adi-axi-dac: fix wrong register bitfield
      dt-bindings: iio: dac: axi-dac: add ad3552r axi variant
      dt-bindings: iio: dac: ad3552r: fix maximum spi speed
      dt-bindings: iio: dac: ad3552r: add io-backend support
      iio: backend: extend features
      iio: backend: adi-axi-dac: extend features
      iio: dac: ad3552r: changes to use FIELD_PREP
      iio: dac: ad3552r: extract common code (no changes in behavior intended)
      iio: dac: ad3552r: add axi platform driver
      iio: backend: adi-axi-dac: add registering of child fdt node

 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   |  44 +-
 .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   |  40 +-
 drivers/iio/dac/Kconfig                            |  11 +
 drivers/iio/dac/Makefile                           |   3 +-
 drivers/iio/dac/ad3552r-axi.c                      | 567 +++++++++++++++++++++
 drivers/iio/dac/ad3552r-common.c                   | 173 +++++++
 drivers/iio/dac/ad3552r.c                          | 451 +++-------------
 drivers/iio/dac/ad3552r.h                          | 199 ++++++++
 drivers/iio/dac/adi-axi-dac.c                      | 328 +++++++++++-
 drivers/iio/industrialio-backend.c                 | 111 ++++
 include/linux/iio/backend.h                        |  23 +
 include/linux/platform_data/ad3552r-axi.h          |  18 +
 12 files changed, 1572 insertions(+), 396 deletions(-)
---
base-commit: 4ff29e5af68e081473240420d5ba8fe1c410239f
change-id: 20240919-wip-bl-ad3552r-axi-v0-iio-testing-79937010e1cf

Best regards,
-- 

  o/ QW5nZWxvIER1cmVnaGVsbG8=
   www.kernel-space.org
    e: angelo at kernel-space.org
      c: +39 388 8550663
       


