Return-Path: <linux-iio+bounces-9471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A19977356
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 980D61C213DE
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825D1C230C;
	Thu, 12 Sep 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD1rcXxc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505C1C1AA9;
	Thu, 12 Sep 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175283; cv=none; b=Aitfiml1rYnVAU3anWiuOV2p+gSkHI8bbyo8xpPjBFmb+T+R7iphB85FBcma5EM/gN61L+9xqdQ8ehtfIgQoLLURqFiD9UIANyVgcMOgv8vW1ZDTtC/adlriZNIeDEHK8MsJkQ+5Pw1R7CTXo/8HA5AdYxSVcsKgKlUUoyrWqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175283; c=relaxed/simple;
	bh=DOe095VgAmtmG/Rr+qKsLs+VDn98WoUUMfuTo90VSAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIoI49QYXKz8neKugnUMCSxOgOd5X5ZnZ+LKilCx5ziPijHo9JSWLHG3CRD2GTyn0wb4Qor1ic/GvpJYKXWq/P/NAoElcrewdfxAsm+Ss5cj8wyjk7m96el3ROyn4DXRbvvz4l/ey7t6R4JwBAobEg9BaRnpmm6OAqQNzBZY5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD1rcXxc; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45826431d4bso1746261cf.0;
        Thu, 12 Sep 2024 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175280; x=1726780080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aq36KinHoVqKCX4QGWHIhVOHyI731EkwzmAhEoQDUo=;
        b=LD1rcXxcVvUSICasOItCp2z6Khd/+VVhoOsSkpjHvu62Lq/ezd43kr6tPYxIoyEjeX
         CYjmNbUQp0OtTJDF7yzPWuoatbCnGzoyfYMgBgcwfDg1eIOU8Ul2h07qP7KwgQmqhnTz
         4Kc2jSq41RlRzGoFTqToSdfsv/PDv/NUWBjbQa7mKCHhCJagwiF151gb+B6uO1tPZ2Rc
         l2gKFGgjo6MA0zaoxD/HO5aXMZ8gqobv8WPA10y5w616aRoCi4vsjJcw37fFsnZLL2vx
         jJeQSsIoIGw4DmyGM10rWq/pKbe5J9WvYG+uDDENewNqWZ+JdIkp3IEmJYdGas+AUKC/
         MhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175280; x=1726780080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aq36KinHoVqKCX4QGWHIhVOHyI731EkwzmAhEoQDUo=;
        b=r38fArtsgTym2lOl27z2U1U5cdxC7I59ubSb66bKKGH7eDhP/SiarfPN/y2Y+bvua5
         Vgq1+Jc+8cyXepUeeD/aCHc/ib6u2vZEJr1QqiHQ88nhHD2Ea0nOLUfnjU6meJzeX9e6
         IBaoyMbnXxo9w5ak/Htin+PYRsNgfOIORyez4EFyfn6I3uAU3DW1aScyuZKzLY1jS65F
         xlhqxhFAAObuz+dSJpP3LVJQQKb69eFK3K/gKCBVmbf2J1t79jLkk3FDYilQ1lM5Qw48
         OQWTV9k3eFXnL7/aDjgQb2IScogeidI2k0aANmX0IPlnjAv4Jcg9vhqhbZfRuf9SsI7+
         eRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS69rbRWw3KNky/vCb/hJLhIlJQrBlengol39rCZdfOHKpiluHMlE8j+1nLXjW8XzwdC06XDzFiFhb@vger.kernel.org, AJvYcCW9Xj6jXrzzglIRH3oIo3AgyjSivlNyUh2WxZIutwMpAgZJ8iA0byy0kj3k4FmyPff5iDUkppM77lcR@vger.kernel.org, AJvYcCX3l0FBOtWaUdYLElMpJ3DMqd4KfV+e3+5PuLxyUm6DFYS2xNbcNbonClt/jGC+iFN+NvQQ0sXMh6Fo7Z1R@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kuy7jlPihheC0c4QmXMFRkndFtZ5mVssQGSjbYAZwqpPwmIQ
	pdmsM8qzD9uBmDvyFGz6KNR9dKK4BSM2eaUHihLUH97opY4GHtVP
X-Google-Smtp-Source: AGHT+IFZJqS29OHudrWu8tsBBiSakxrEbp4C5mHl0PcTRt3nDXqY7x4EsdbZMNKRtrMATP4mSrzk8g==
X-Received: by 2002:ac8:5a46:0:b0:458:216f:96ef with SMTP id d75a77b69052e-4599d2bbbc2mr7607371cf.57.1726175280033;
        Thu, 12 Sep 2024 14:08:00 -0700 (PDT)
Received: from localhost.localdomain (117.sub-174-193-5.myvzw.com. [174.193.5.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e613eesm56959721cf.12.2024.09.12.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:07:59 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Add I2C driver for Bosch BMI270 IMU
Date: Thu, 12 Sep 2024 17:07:17 -0400
Message-ID: <20240912210749.3080157-1-lanzano.alex@gmail.com>
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
Changes in v4:
- Include linux/bitfield.h to bmi270_core.c
- Add comments documenting sleep functions
- Increase configuration delay to be inline with datasheet

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
 drivers/iio/imu/bmi270/bmi270_core.c          | 258 ++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  48 ++++
 9 files changed, 481 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

-- 
2.46.0


