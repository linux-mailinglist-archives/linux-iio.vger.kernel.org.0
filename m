Return-Path: <linux-iio+bounces-12797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C99DBE15
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 00:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A933CB22499
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B989A1C7B6A;
	Thu, 28 Nov 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk8mPs3B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE701DA23;
	Thu, 28 Nov 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836306; cv=none; b=uioAHqMS9aaCJP+vkFJOexkJbtILLoQ7cuBQL5kQA5fjblG2AekHNUTCHzAMyIbKCnDx5O5Y0vmHqfB90jmiN29mD8m2aVU+FjISJF/P0tIeq5NXd3wHAVmU9gkVftAnEAf1HMVx4xenS7mG6pNTm91YfdTj1up7eG8UJ+tPk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836306; c=relaxed/simple;
	bh=JGWGnk6x0wZk6Fqh1A6YU6MXAj0RVNcpLxQlSHGJDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1qk7sfULVDlK7oAUIFBUq/5y7HqJVus7hDc5Yc+ZlKMVkw5J2JlZ3X1RXLhW6uLRPycCxwkhqa+lujYCiiQz6CP9YYXtQuswOyPZouJynRbN+aKh1byzhL5CnF0qJvfTqPKhQ4zbra0J5j+tAR+ZMblMnnxV/L/e5HO+hmo5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk8mPs3B; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so11905915e9.0;
        Thu, 28 Nov 2024 15:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732836303; x=1733441103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KoCBSIhYiSk8RIZv58Ren7hKSHx4Dd2qTRXDu2vNNf4=;
        b=Uk8mPs3BjwkTDOj3+V/jFuAbxItLKFQkbsFH3CINr43doUDM3B1RnBjzXVlnw1lY9N
         RxmqKXK7KgVptwYIVfdmPw9X7B1vOO6x2S4yL7hpwK5lYEOXjbPzP6ATV+J0vHaJ2rkS
         EGRh1tPdefHdd7h3HYcqhl11puJfmTv9yrRixykDL5D08Q7M7DrtY45O6C7Veb/0Jn/a
         YmzSd9fyxastBuPH0zWnC4TxtgqeaeaGNH9rhmWW9ENssK5VphneXOPq5CdoCpsLMATW
         bxp6Py+6x9hj6GLWsW1kGacoN7ChB8TPoFH6R+451Yi/nLtKDE4rAc4iiu8DpJXevaVj
         SFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836303; x=1733441103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoCBSIhYiSk8RIZv58Ren7hKSHx4Dd2qTRXDu2vNNf4=;
        b=O0vZ5s5/OJrHdwMU98EBVIaLbRrPvuVWoemwMaNBBN6QsLaIHu/SNCsobyI4mOq4lE
         dcafSQxH2vESelTz85emWz9KFeSmdiZ6as+ZvKzcOq7I/+wC7Qgki93Ibm8Dy6baT6PU
         jGN600r+E7VBLUe031pnGxRxiWy8mGgXxJ75cNJeFE8YPXU9+fLUZCWBViIhSKHGYpqF
         1afkVTkC/xcky4bE7jRsEgkS6zAIElGA62ZojYLgqIywQ0VvpOzgxL+6+fVRNCvN96oJ
         LrqHnz7nvLzQoznOamWnYaeCsyfz99mSMDhF1C4xYOkG6frVbdLmqWO5zMxCixGdJq++
         sKNw==
X-Forwarded-Encrypted: i=1; AJvYcCVymvG4BL4/tqD04suxbPGBfHOLeT/gVFrrRnmFbn0Un6PRv2RUDo4POJZ6oDuYiak/hKSO5iP3o9Rc3uya@vger.kernel.org, AJvYcCWyAQ6G/FIn4IHuTiRgXRzukbwGjQv6hLls+wLvI7JR2S89NR3ScHyFgHGJjL4HJjKzp7eRFgaEKsSJ@vger.kernel.org, AJvYcCXRNgmh1IgJYq5xPEVJY2dMuN6W5f8FbOGm5HkCarXncfIhNCotKdDjxhUrPxecRVaoV01UIqNZbmXY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wsTitSJr8gkch/Cv5q6E+b9yB31V1lc6QjRu9Sitz+AuAr1+
	ku8q/vI65CJjpirDos7fIECEKsP76bAIHb1apM31J5yf/GHkl4tp
X-Gm-Gg: ASbGnct8RDKsRkl05iYULoTJtCiTxecCZ4h+5Lxch3WX0XKG0qytHzgIY3H0l/yQeZx
	9ozPJ2HM38zHhvwXTednm5uaazfLjW+O9H/3vXJD7WW3xJjCKCUh6+L9cNTugPo9Rx0HfSFvlfm
	u3n4yhUQrEuQuqlxie+6jymo84shYY7nhdFh8YKIWnuNMv7+UmokW/sz06zztkgRK7A6wmNODSG
	/CcV0jzKLDS+HUHDKfsEr2DquOGCmBgbxLn6ZZhfKLGz2QT+Y0URF8OEOdvsag=
X-Google-Smtp-Source: AGHT+IHJ3WmTkSlsEbk8YMcx2+z7xur8PJDnyiYsRFgx0CDrhYmi2YbBxojnzsu9TG9UyARFUPmnXQ==
X-Received: by 2002:a05:600c:3b1a:b0:434:a160:3647 with SMTP id 5b1f17b1804b1-434a9dc3eb6mr81513905e9.12.1732836303193;
        Thu, 28 Nov 2024 15:25:03 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:a8c6:c7bb:87d7:66dd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-385ccd3690dsm2765594f8f.35.2024.11.28.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 15:25:02 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: ajarizzo@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com
Subject: [PATCH v1 0/3] iio: pressure: bmp280: Minor cleanup
Date: Fri, 29 Nov 2024 00:24:47 +0100
Message-ID: <20241128232450.313862-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the SPI interface description on the device-tree file
of the sensor, adds proper self-described sized variables and performs
a minor optimization in time variable names.

Vasileios Amoiridis (3):
  dt-bindings: iio: pressure: bmp085: Add SPI interface
  iio: pressure: bmp280: Use sizeof() for denominator
  iio: pressure: bmp280: Make time vars intuitive and move to fsleep

 .../bindings/iio/pressure/bmp085.yaml         | 35 +++++++++++++++++
 drivers/iio/pressure/bmp280-core.c            | 39 ++++++++++---------
 drivers/iio/pressure/bmp280.h                 |  8 ++--
 3 files changed, 59 insertions(+), 23 deletions(-)


base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195
-- 
2.43.0


