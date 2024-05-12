Return-Path: <linux-iio+bounces-4991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1728C3868
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E3280F00
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5E4E1B3;
	Sun, 12 May 2024 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqJRtDB7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F4B1DFD0;
	Sun, 12 May 2024 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547895; cv=none; b=dCLSURRcxP3Ym28a682zhNbZsGMrkTeaxUZ4xXuCXlBaSEBAvQaOeQETcgoR7O3Jm6XCCDy3as1odQbF8qZyPoMEXLQDKuBJxKiQ+T8ls7SqjgIgxw1/FwRYt+ct26qvXrbfdCQNNNrSmndYstMDFwOW4wqkfquVlH375KnPSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547895; c=relaxed/simple;
	bh=uWMyoS64M6BvRn+3IiwkbrlGwagXWlrWOlikPtGavgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hsi7cz0PAe5EGYbT6nx8g9LhBkx/O8mA6+nXKIBc5VhTdT285xfyGHZg7Q6v24fth184CgbSMfJcMQfDlnA+sduZFN7yrssxUWuWxq3XL8oLaEUEuSnzZj0E2sjHXQmCf1H5TYJFqQViPziztRskTL1Dmcp16919kWBnEap0H6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqJRtDB7; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ac61cf3fffso1822635eaf.3;
        Sun, 12 May 2024 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547893; x=1716152693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49gp34vg08KM1Pui5A3dBoTwgYUqH7gz93G6LxNn9ds=;
        b=bqJRtDB7tT+8xynmaz6XRLTsuFh2j0ulC/YBe/YDrqwLZ/vC4AAUk5Dr1+NI++TSEy
         /+M/Xqff3vzzJR75uPjauam1YU/O82ILu8Wslb7Rvwj965fn3xMmxMbwX1JihffPCnWJ
         ogH4cXPxaY8mHL6K5WAwokzY/8bgbB6YvAMQ+PKdxV+v+o1nE/LFPlhTfGUOZ2v8yyt3
         XFfwS3QBLdfKSyJkrKJ3rWqrY32hec6hYskipYUpo5ol9xp+yRe/G8bqNWmVDooG74Jg
         9TuQWt/6ZzaZ7lyLISmETLafyRSzG6fQunSbgKz49XKJ77H1H3updDjRkVJhWbbcUXK2
         hyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547893; x=1716152693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49gp34vg08KM1Pui5A3dBoTwgYUqH7gz93G6LxNn9ds=;
        b=RHQxFRCbizpDmrnglu0NSljNI7jR3DEla3RvNVnOxSZEktf3BYfe06EQ5t4HmrPDQs
         fT4BMr6D/3Dn0vEDXTQJ7z2PfQgl0iX5NWF1Wncm3Yl6fTJtPdAD9XWt/62uojCVuEWa
         ukvpWrjHi05UHFFypeXNQdLmleU53WmiI5T13jZxov+HJdavhgY7ptOFtqmrFd4K6w46
         9KJyZJBFZlGUepkFDdxtq7IowdMWLgBGQxN5L5NVrm9o6VrEoodr2tYOkX6Caiwb8VQJ
         IJdIJCOE3gTvbEriFExPEE93nB/uEtPxe/9wmJYzukbgoceZAkMFlmYgbKdI+4+nfmdB
         qXiA==
X-Forwarded-Encrypted: i=1; AJvYcCUUlpn+8tGF7mhRO+X59xhtZnav2/A5br8ORR4H14C5vxeoltd8MLcbPTAKRR2mWMT2x6vslBWN8pfn5Nl8LY+7Y+X+0IVNgjo+5NjW3gBU/gcMGcWlGH/Hn3vTs7QknXFk1NUMKiSf2/rrAQxpueTMadhPi5DR7EJLlmRTf2Ewl9RV5Q==
X-Gm-Message-State: AOJu0YzgSTrc/aQjmv1C1hVLCbsFgbMg1oX95eKpEqIIyYwSp2GcCz7d
	3I2r/i5q1d6Or2JKYR++f5p8lTpwlyY9U/uJ1UeKeXSr/LeB6WYX
X-Google-Smtp-Source: AGHT+IGaLzQtf8lEExRQHkXeBJWs+tj4uh3NdhXcCrZvn+xvs8ap41m82njn5QXF1jySL4urQ15lkA==
X-Received: by 2002:a05:6358:7f9b:b0:18d:daac:f411 with SMTP id e5c5f4694b2df-193bd0005b6mr749382655d.31.1715547892974;
        Sun, 12 May 2024 14:04:52 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:04:52 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add driver for ENS160 sensor
Date: Sun, 12 May 2024 18:04:36 -0300
Message-ID: <20240512210444.30824-1-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches adds a driver for ScioSense ENS160 multi-gas
sensor, designed for indoor air quality monitoring.

Gustavo Silva (6):
  dt-bindings: vendor-prefixes: add ScioSense
  dt-bindings: Add ENS160 as trivial device
  iio: chemical: add driver for ENS160 sensor
  iio: chemical: ens160: add triggered buffer support
  iio: chemical: ens160: add power management support
  MAINTAINERS: Add ScioSense ENS160

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/iio/chemical/Kconfig                  |  22 +
 drivers/iio/chemical/Makefile                 |   3 +
 drivers/iio/chemical/ens160.h                 |  11 +
 drivers/iio/chemical/ens160_core.c            | 401 ++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c             |  69 +++
 drivers/iio/chemical/ens160_spi.c             |  70 +++
 9 files changed, 588 insertions(+)
 create mode 100644 drivers/iio/chemical/ens160.h
 create mode 100644 drivers/iio/chemical/ens160_core.c
 create mode 100644 drivers/iio/chemical/ens160_i2c.c
 create mode 100644 drivers/iio/chemical/ens160_spi.c


base-commit: 084eeee1d8da6b4712719264b01cb27b41307f54
-- 
2.45.0


