Return-Path: <linux-iio+bounces-8947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D457967C38
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 22:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231052814E3
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 20:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9013AA20;
	Sun,  1 Sep 2024 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9S/kbkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F014CE05;
	Sun,  1 Sep 2024 20:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224054; cv=none; b=rptK1Mk9ydDolvIUyfqfeBoOFYdZ1xxsUs5eKtpTfdPRnVYup8qPc5uWcQavV2Stcruwk2DJ2eiFTwSuJUDDSjZdQiMXowLnjvumdv90zCWtLTmBohYPeVvmHhRCIS0YUIA5A6zg32cWTIBoQchogfQZk/+rcUuEIBmJCb21o8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224054; c=relaxed/simple;
	bh=2/dpL0DywYScHQt477sF2ba9yNukMi6rG+osg5PZIno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnDt5A3TTjYAvI2Alx4dSW9abNZFGwn25/MwnmV0G6VXgGzIrkdMOw58NHSv1d47EyU14pK+4hRnlrOisMQuhVq0Ze7w45jQwuDx3ivOivva2wcfiP/zJghd7qVA5UxBONX1YKqZcUCjjkk/tvsYQkzF6VpE6ttVt+5uO1GzIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9S/kbkr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4567d78ad2fso21628711cf.2;
        Sun, 01 Sep 2024 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725224052; x=1725828852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9mRHAsBGF17GqwCZZSUSOWSrbOHvrWg33W2YfY73OdI=;
        b=G9S/kbkrWvghry8Gz+ZO1pu12lreR6ns1U+iWUfJRNzShOV1+8k/9zmUGjxVNHuM0b
         JG4KtZmK7OPmeC6GFv3rRnabvn0w62VTOf3+ysIMZB23qFp9zv44j35fH+v0yZOvdGI6
         8sbfgRIS+PyojGKRnLTLQ7icFT6lxDfjsPPhJknuvdAdGe170nRWpve1W6Un+w+4bWbn
         EzlXvUrKLMcI1DuZQyeDh08gkQLtYBw9XFFuVyD/fiekiBmUTe/2YjpvmCkjp4VufIqL
         STFcdmV3lANC/FtGgsbvOelKfnoORslIjpeACxi1hYYAiRB3p08QZr+b9dA0T3fzmUBi
         WhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725224052; x=1725828852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mRHAsBGF17GqwCZZSUSOWSrbOHvrWg33W2YfY73OdI=;
        b=BsMo5hUteuUkvNssOc+/dgGRrjtPgJO20JEZFIx3hmQiCEgfwX809FvFZFaYin/ebm
         pCpkKKsram8u6uUhCH5hJEOFYO2pOEAJdp/NExJK0yzZwG692F5i2MUQqb5LfS2QxERX
         adWsP2Fo0JfjJ589MojeiukxytFcWVXlXhQ+RSRWlXzWmv8xoNXB/0rg4tuW3/mEqfFi
         L6MCOcij6I/f2EcockZuVJxLGh7WL2bpvERc3GbV21uuyonxEiIXak9HsuL/x1VqZZ79
         WSqoqx5clWvNlKVIG3ROGc1pSetcN2XwEeGcFBjlS8POP39Er3JKyQ3H8XYDbnkoS1Fn
         dt2A==
X-Forwarded-Encrypted: i=1; AJvYcCV22JIyT5+vxTUQZIzj3xapiiYwyXfr5gDqEsJVkr82vJDgwON8oInfn6l5PW6z8QEO1+xxo5sVWPUH@vger.kernel.org, AJvYcCWpl1ONw9hQmWG8yEXyrhw/5+rOwJIwI5ZcnxEr+XTREGcJ3+7dRnVpfiDw6PzgZNNUIThCKLIB2lZnxEdE@vger.kernel.org, AJvYcCX4UkIjCKCdbhRgYLaVl3ak6AzgVGir8Q/YUObOOKzzDQPfl3N5e/I3rK18LYTzyIcWRNUz791et2aW@vger.kernel.org
X-Gm-Message-State: AOJu0YyOk8TWjpujS/URlX7W5G3jBraCembSvqfjmTprWd/mGb4w0yCq
	ve7J59Hk2gbnrUJR+Lxs4ULGr/ZQX7PlZa6FMUxpQ6h13bWu3+wHRQ7ri18j
X-Google-Smtp-Source: AGHT+IHABzcVDHDqym8tMVEbonoHPiDgFs9wuSC+slplVVB9yJu0NzGbiF6EWZzwW8zQ3N8h9DuRxg==
X-Received: by 2002:a05:622a:1dc9:b0:456:8170:bfa5 with SMTP id d75a77b69052e-4574e7e95c2mr72177231cf.1.1725224051839;
        Sun, 01 Sep 2024 13:54:11 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9a148sm34148231cf.32.2024.09.01.13.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 13:54:11 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add I2C driver for Bosch BMI270 IMU
Date: Sun,  1 Sep 2024 16:53:22 -0400
Message-ID: <20240901205354.3201261-1-lanzano.alex@gmail.com>
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

Alex Lanzano (2):
  dt-bindings: iio: imu: add bmi270 bindings
  iio: imu: Add i2c driver for bmi270 imu

 .../bindings/iio/imu/bosch,bmi270.yaml        |  80 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/bmi270/Kconfig                |  22 ++
 drivers/iio/imu/bmi270/Makefile               |   6 +
 drivers/iio/imu/bmi270/bmi270.h               |  18 +
 drivers/iio/imu/bmi270/bmi270_core.c          | 322 ++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  56 +++
 9 files changed, 513 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

-- 
2.46.0


