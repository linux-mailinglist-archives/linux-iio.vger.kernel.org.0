Return-Path: <linux-iio+bounces-9253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DC96F99D
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 18:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AA5281B28
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8F1D417E;
	Fri,  6 Sep 2024 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2RWdYHw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048B1CBE8A;
	Fri,  6 Sep 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641613; cv=none; b=XC+RA456r/g5iyg5PEwiZZoCx2NTqkzxU25ODwRJHJB7SarNsvKDilu+aY7SJAh/aC7cvUkWnO4wdeu6UXaf1qav8N0EoMQ4fpVrgvNQaryJATURhaR5Jb75EH7j3uHQsLDdNh8CPSLaEYJAXR8HjF8GRySMZbaMQ3val7S9LVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641613; c=relaxed/simple;
	bh=rRq9yjHCDKXbXbcrMKCuvNOIdIvhE6xLqdVGFeoQR3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bfK4fIiOWWtKNOrtC69x55KOs18MFwVuoEUrESaLdcetvU6p6jKGV3UVDvu0B8s4g/3bp2e/IeAnuJJXjLVn6WW0gX6oZGrtj+rdoTVEWqujzYoudYWd4703ykcA21tX2RMhUxp3knW7cT6vw7+FhzhNLPHxP20Q3mat4uapOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2RWdYHw; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3df06040fa6so1422317b6e.3;
        Fri, 06 Sep 2024 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725641611; x=1726246411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWEQHOwaM5Wfsp4uoZCh9UcLUSiGupjYGoV/bAUl0fM=;
        b=W2RWdYHw2YzNPpN+ibPlyh6r0VnHdE2l3vDyQEYPTQbCFkPhoojPA7hOzrf2jvTh0g
         QPd/zSR30uRpUUGoHWX5XPIaacL1r9okTs5K26DLG4nL/0WZwtuhuXCJNy1zelmbj2JI
         +9WAoFbJaGKZfsh0sQc52PvcPT3FYROrtdUA/fWOZqiNrx9HydQh4QWPpq0susR31bZJ
         ieGlkwJU8Tlh2uZ+oZD+gcupH8Qg6nBGDm3rPJJrzKqqufUiQpA+5OK6dZlfNknf5Xll
         5pEz6bJQfz0G47fpZaP2dp53sk/H11P3jXiGy/FLz75Mp7lxNkojGtErfJ+fsk15cmRv
         8oxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641611; x=1726246411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWEQHOwaM5Wfsp4uoZCh9UcLUSiGupjYGoV/bAUl0fM=;
        b=dmCWh5lFUmNOty85oO79Ze8Xs1DqnMQirkMXaLrWnLQ+Wv/QvPVzIWqDVf0huOJCRX
         DDEXRbx008dBEZeu0unwSA1baseXL35JCHWKonFKM8GMIoWALVKVEOcIOXRtaeAEaFYP
         XLvkGesXxk9HtQ3wm6YH16TchLhraxGb3KCqtSzDVwgyom/RwadYtJfvSOEM3KyKybYP
         mksh4FxITJFt8SqtDUp6C9Q386nHOHksSVmU+yQtjbA0SlGYS0Dg1zUMz6fd9snP0mav
         gC3zlJCYIT5RwyWOBBAo+/S36LW5LdZstRdyvP1+S0jvtpsIcc6/fo9fCYWGrg8cAEuu
         YfvA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZPNarToj4IndBff4K2r9BzGkoX7U53hz7MsvNjxNms74VdDCd3EqCCyXoJlw4+O0tnJzYRMogHsN@vger.kernel.org, AJvYcCXScPZVXCjUDL2ZVjYaBTTogn90JuMBgjq7rDGEJDSHluVw8rEZQ+QZNESNCGgm9B6gc1Gche00eHcgC5w4@vger.kernel.org, AJvYcCXWEdG2zQ65IXf/VjUjeHOVAxREuTxg5wTX0/xmzJfv7JlarsN0w1spPgphStiQ0W9tESUWxM/2LdYg@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSpxrQT2EZfA8Q8fr47GliHKbnhmb9rVd5Fpy6bYNfSlkHb+q
	V0MO7wQ9kGQCj3glruuX9zUktTM/kwW2wBnxGPs43tdeoAnnrNwy9YreRybg
X-Google-Smtp-Source: AGHT+IFOxp9AoAp0J+gOTuRtfB85p8n1UEoxGS5Tn3GWYTeQb9Wc7Ggan9i1Vo4vK7du8MiwGdeynQ==
X-Received: by 2002:a05:6808:221c:b0:3da:aac7:43b2 with SMTP id 5614622812f47-3e029f2baf6mr3936589b6e.34.1725641610993;
        Fri, 06 Sep 2024 09:53:30 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b36206sm17580121cf.29.2024.09.06.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:53:28 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add I2C driver for Bosch BMI270 IMU
Date: Fri,  6 Sep 2024 12:52:49 -0400
Message-ID: <20240906165322.1745328-1-lanzano.alex@gmail.com>
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
Changes in v2:
- Remove spi example in binding documentation
- Add more properties to i2c example in binding documentation
---

Alex Lanzano (2):
  dt-bindings: iio: imu: add bmi270 bindings
  iio: imu: Add i2c driver for bmi270 imu

 .../bindings/iio/imu/bosch,bmi270.yaml        |  77 +++++
 MAINTAINERS                                   |   7 +
 drivers/iio/imu/Kconfig                       |   1 +
 drivers/iio/imu/Makefile                      |   1 +
 drivers/iio/imu/bmi270/Kconfig                |  22 ++
 drivers/iio/imu/bmi270/Makefile               |   6 +
 drivers/iio/imu/bmi270/bmi270.h               |  18 +
 drivers/iio/imu/bmi270/bmi270_core.c          | 322 ++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c           |  56 +++
 9 files changed, 510 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

-- 
2.46.0


