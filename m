Return-Path: <linux-iio+bounces-24475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70221BA546B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 00:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB30B1C024F0
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17A8291C3F;
	Fri, 26 Sep 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIQY2NCy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC5286D7D
	for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924139; cv=none; b=E8jZhM9tpZyOLxN9NFkSX96nBn51GXNV/FpdVMqN9GiZe0tt7jUmsnjkYAdAiIlyxgQIur4qy8w0PtDOiO4d12rYiZrt2j37ph/TFzMcWqGRTDg1fIoqOHV8lLBvjtuCGIUUWkuA/2NhLoyGi8gfycUbYGcOkr0W8dryoO13COU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924139; c=relaxed/simple;
	bh=Fzii6xFMlq2tmZrhMKrNSx2r3cN9Y5yZ6BuKvSWLAQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SpNiMD/dqJISsdUMjmuPv5JECQYzMf06is3GdxSHQHAwinAGS4+Ae13ufm4qitCxHnMbOoDcwvNICDSAhAAGOGGWmivPqU0fDaSULMM8F8grrO79+JxbCavr2XDFxFNUJVg4lnqp15tBTtXcF9pbUxJr9CeE9s9bZzpc3UusQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIQY2NCy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f42b54d1b9so2657864f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Sep 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924136; x=1759528936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WiK0o9OsPPIgnlfmJq/d9pxBatMc1jJsoABLigao4DU=;
        b=UIQY2NCy9DlNOrYxMIR0XxQw28GYK9+6neyP/uc4goA7MbHwrAzhaexkiyda0IUxvT
         m4QRO2+jgaxPWntO2X2QeNVv7KPJB4rqh2jAplU1xUtxTdn5xvSxgzCAkBbIwmMPzqK+
         nQxBvysqjLaHvKaBgw2kxi3AQNxspgZKNrpwrE6VutIOFIeNQov6jykxLLby/N40lwSy
         MngQlKq/PIcub9P7Q4lxJrU7frD/Ht3IhqU66BDwfe14ruP37YsgDRZrcu3DKxwslOiG
         Tp42T1UZdZwGa9zU02Hqmhj09RO6+94oSVQabapgc5QDA4pvbLxWllkDrPR9D7x1Ysqh
         O5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924136; x=1759528936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiK0o9OsPPIgnlfmJq/d9pxBatMc1jJsoABLigao4DU=;
        b=tjeccMjtveX1mHiQOSMG/2ibwzyqudNwYjRvhYXvsvLnmEX927HN4cGHjlenVNwU4J
         OA6f5ANJNfq94Qseq9Cylc3qDr9fbgS8aKH+LX33SGWjqMXgbwHkOHDKT8F85oRHJEon
         W1F+3IdPktnvzDanCA1ICimMxh/JHiLGIEP3VYHBB/HD8r5ERehoNHSL9O+l8ALAZjyN
         Hg+QIj1lC9jGCCt9q0Sts1VMNdRV7DMYbjI7e8r7rOXQZ1w7UkGPGz7bsw/GcU6bQKgI
         r+Bnn9iQUFbO8eCpGpZmIKTs+RnDLIxYNQNkzG3Hz8h8Q30ZkCS0aONQgeEYExFcHEEU
         oR6w==
X-Forwarded-Encrypted: i=1; AJvYcCVLQEHI2H9rWcbGZUOm10OPD7SuovHx3i7bZY/Tt9xTFaM98C04GFyd3a1C1vXqwWwqpIEnjNtFdKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgxjBR0oD7fpKeiHHSX343Bt4ckywVNQkM5sEE66N4zwtXRtiJ
	bZf+xi7q371wAygzCaC00+c53luhRQ6T0vg5vG3/XrB9aLBN7Cm/4P1z
X-Gm-Gg: ASbGncsR32NdTlyA/0amAo87/tgqCbWVGc34hNS/I7+ywI/6aTy48DpDgkB1k70t/ZS
	S5xV8Bs+hu+oXoi6t9HHLP4zoKcjySRHIIdGU0ZsHkhJ0FI+OUexl/mkc2W3EiaT1kdH1uXOgKQ
	8ThDUUAnyQTkAb3IeTFZSPnakvtUU3pgLw2ziRsMOExPLO+tWv3B57kSRWbfDV/BNh3eLCu5Qhl
	M9/K/8MJZk3yrQlHhC/naITlzIvV1f5as9Oohc24ncFzxlYqU4r0nNb5mEfSWFGCLNBOAnjTJjF
	grTV5Q5RJSC6i5NC9ItRa1XXynymklHmG30IuTjj4b9kfY3ouO4SpC4cB5HGJ0VzKwKsmDNUGP0
	aKfS2OWy//avvVBVc+0ugrpUVJ4bp1b5zTApnclgg
X-Google-Smtp-Source: AGHT+IFOpFRZvqIjkfBl0P4vtqpIDNMACFW7mLBlCtVmhjKs7Ub89Ws2JgUgQ8sZ1aDgm5ZAaXD9PQ==
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id ffacd0b85a97d-40e4accc83dmr7196825f8f.61.1758924136008;
        Fri, 26 Sep 2025 15:02:16 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:15 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 0/4] iio: mpl3115: add support for DRDY interrupt
Date: Sat, 27 Sep 2025 00:01:46 +0200
Message-Id: <20250926220150.22560-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
This set of patches adds support for the DRDY interrupt in the MPL3115
pressure sensor. The device has 2 interrupt lines, hence the new
binding. I also added support for the sampling frequency which
determines the time interval between subsequent measurements (in the
continuous measurements mode) so it's obiously tied to the DRDY
interrupt feature.

Kind regards,
Antoni Pokusinski

---
Changes since v2:
* P4: included linux/bitfield.h

Changes since v1:
* P1: add `vdd-supply` and `vddio-supply`

* P2: new patch: use guards from cleanup.h   

* P3: change macros of control register bits to convention
      MPL3115_CTRLX_NAME
* P3: MPL3115_PT_DATA_EVENT_ALL: use GENMASK
* P3: trigger_probe: do not fail if dev_fwnode() returns NULL
* P3: trigger_probe: use devm_iio_trigger_register()
* P3: trigger_probe: introduced enum mpl3115_irq_type and 
      changed IRQ setup logic accordingly

* P4: MPL3115_CTRL2_ST: use GENMASK
* P4: read_raw: samp_freq: use FIELD_GET
* P4: write_raw: samp_freq: use FIELD_PREP
---

Antoni Pokusinski (4):
  dt-bindings: iio: pressure: add binding for mpl3115
  iio: mpl3115: use guards from cleanup.h
  iio: mpl3115: add support for DRDY interrupt
  iio: mpl3115: add support for sampling frequency

 .../bindings/iio/pressure/fsl,mpl3115.yaml    |  71 ++++
 .../devicetree/bindings/trivial-devices.yaml  |   2 -
 drivers/iio/pressure/mpl3115.c                | 314 ++++++++++++++++--
 3 files changed, 352 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/fsl,mpl3115.yaml

-- 
2.25.1


