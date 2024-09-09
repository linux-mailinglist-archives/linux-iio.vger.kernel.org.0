Return-Path: <linux-iio+bounces-9354-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F4970CB9
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0C71F22634
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B21741FD;
	Mon,  9 Sep 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noIk1YfC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5774C74;
	Mon,  9 Sep 2024 04:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725856384; cv=none; b=G9PYxEiqgeryCGX5fOOtYfmoeikW1vgziHbxFeqCLpO0gC7ZdFjjy2FV2vM0JE3rrnoFXbuAlvfYD+OJWv7CZdw+UK9SxvF2j8tWdmanZcBccxjfTqkxHpmeDxBoEXDTudzdu17mX+B6RkMA70cd77yZ+00YotOPBcPwd/TU5i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725856384; c=relaxed/simple;
	bh=EVZPIUSsZjGZMeUpN7YnAFV0A0x6X3t6d3gx9BOiXBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVQzmVSEo/NtRmkWuAyT/4OADZA4e4rVcvF/z8KFy3CouWFzKQYOn36I/KgxPIoYeTM1XEObDLOIMTDFjTs5SJveXzyg0hM6RkDfc1hWXy01iUg/f1QcxwZHR6Y9xHelRma4ZDD2b2uCXNXUwjckICiTacxwx1TCj/qEa/fMUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noIk1YfC; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99d23e036so164818585a.1;
        Sun, 08 Sep 2024 21:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725856381; x=1726461181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QdOMMhx1gpxvBS/wfDoSKFubKp0egWivBQSYQQOJaA=;
        b=noIk1YfCQwsDgnDcPp3X5141fmjEeNqRC7IVoYKAfS+rlXzrYuuLzy0QuEaapJe/rK
         IUPrDx3krhf4eSsZ7s0MkNy91FvvK7jWBrIs3LByvecxupi0N20t2Fh4ri9MsfHvnjkH
         jpZOAyqS1oEYGEt4bi4LCIDAVDeTbHrv9swyv3FUxQomWj5hawr0ybgqfdMaHrTGZOlI
         L8wGEUGgdf23U1KezWUClPzH6Wr5sLxY5YuNy8xgldtltZZsAmhZRUY27RedJP3XkxoS
         2xwxLd15BMe0U0otGNiEYVSNqhUCJ309/jSaQuhisYi5tvN8A3spxncrBzGzrK53B5rr
         ahVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725856381; x=1726461181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QdOMMhx1gpxvBS/wfDoSKFubKp0egWivBQSYQQOJaA=;
        b=huFiq0bUq6Jg0JMu+Hz82SVcSOODmYehmF+OsOQPsu/ZD+MUqTxJiqkKP8kP2zS+Si
         ueLVrN7SoyVeGRqpTXWl+7HH6ElcVCnC+wRLk2D3BhjDuAB7gFxDz9VliRqtO9Gf70j9
         d+D3WAApV4KTy2jxyz17PWtdLmDZBVK00VncuUlcF1ZE0G0CsHR9DX4rPMiOIEYXB9mX
         tyHUPn5uudXK86+inHj4xLMx34Jea569fbsexCOZdsvJlsXFmlIp8TK7FSFfs8WlX1o4
         gzWGwLbbouT/mO8jtKVK9WLD+hEdqjr0MLFSjvFSgEP/KbYsWbnlLNR+zODVLpA84LYK
         HxIA==
X-Forwarded-Encrypted: i=1; AJvYcCW/U3TEZcbQVFOREnRRgVjVO8LODaJhch6kzS0i8vs2E9rG7+zLVqe8Evk2GLDQMSujosBJ/GW4gQjAoqGe@vger.kernel.org, AJvYcCWYR+gowHg7Zj/5UX5f+nGGn5AupSvPthns7Zb9jRBY00Mh3IaslK0EuseZocmj09HAqAMjY+8ELSQo@vger.kernel.org, AJvYcCXbceBLS63k0gnhWHX9cj3KEktl96INBD7JDeyM81LoH0ua0RucFHbasMmR1XWD7G3FZpeJV++QVKZT@vger.kernel.org
X-Gm-Message-State: AOJu0YxiysXm3R9gTFtkNXjJ6ntwhvxOONF8iWxSjGEzGfOWsJWj8Sm3
	b6tjivgbp2S4YQrXIUjw6Dc6siFjICG4z9JUehkV8oeBi3PzsLi0
X-Google-Smtp-Source: AGHT+IEh1QEywJsPJHkyFDksMeTinTFmR0iWFLZH3H5xDpwkYQocnQsExUxTRmOubpBbdi4NOakRNg==
X-Received: by 2002:a05:620a:4543:b0:79f:197d:fe6e with SMTP id af79cd13be357-7a99735e832mr1260685385a.45.1725856380836;
        Sun, 08 Sep 2024 21:33:00 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a794559bsm180791685a.6.2024.09.08.21.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:32:59 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jagath Jog J <jagathjog1996@gmail.com>
Cc: skhan@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add I2C driver for Bosch BMI270 IMU
Date: Mon,  9 Sep 2024 00:32:22 -0400
Message-ID: <20240909043254.611589-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic I2C support for the Bosch BMI270 IMU.

References:
https://www.bosch-sensortec.com/products/motion-sensors/imus/bmi270/

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
Changes in v3:
- Remove code pertaining to buffer / triggered buffer
- Move register definitions from struct to defines
- Add bit mask defines for registers and replace hardcoded values
- Create macros for accel and gryo channels
- Code style cleanup

Changes in v2:
- Remove spi example in binding documentation
- Add more properties to i2c example in binding documentation
---

Alex Lanzano (2):
  dt-bindings: iio: imu: add bmi270 bindings
  iio: imu: Add i2c driver for bmi270 imu

 .../bindings/iio/imu/bosch,bmi270.yaml        |  77 ++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/bmi270/Kconfig                |  21 ++
 drivers/iio/imu/bmi270/Makefile               |   6 +
 drivers/iio/imu/bmi270/bmi270.h               |  62 +++++
 drivers/iio/imu/bmi270/bmi270_core.c          | 251 ++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  48 ++++
 9 files changed, 474 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

-- 
2.46.0


