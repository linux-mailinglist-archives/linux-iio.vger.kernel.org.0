Return-Path: <linux-iio+bounces-15582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE96A375B2
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2008A169024
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC64C19ABC2;
	Sun, 16 Feb 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QenDqNEl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE0191499;
	Sun, 16 Feb 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723264; cv=none; b=lAr3gUvKNfn811GnQlu4O+oztML9MiEz4SZ2SaZS7L1XvHPgOqWCIxDaK57/i3tYccoQ6vEqR7zNRmeMSZHsvLK8v6N4kw6Ww3UkrpiJcwV3pCk090ynmoe4ze7P4eBzlZJHYEQpz8nHYhDJw62vSqocCqKmR14Aa6ISnuo5Sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723264; c=relaxed/simple;
	bh=yTLzjAo+KcqoWNduSSE0mzD0ceiO5DTQAXIIndfLujA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbxIQXo1vMhVMWfQr6BeLQimrb0kXBKYdQ8Iqsz5Y1LL7JYLXNxqvJxwSbl8g9gRPEP0IVbzFgM9CNo2ZZs1C33000ASOzgCJ6xGFD8jgItRJWY1v9L2j7RKz9245Do6ER9rt77EtlVGGpUe/ek0WYq1bCk1nA028DzniEJXVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QenDqNEl; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5452c2805bcso2327512e87.2;
        Sun, 16 Feb 2025 08:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739723261; x=1740328061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zauf5zxFWWLZSth2HbJwJMsQ216gUntGDkfuE30UgBk=;
        b=QenDqNElfw31q077uHvoZEGgovnipnCbeMVXPJykoa4mmr7Nqh27zDZz3wrIKAUQEI
         if9Hc9iEdIv89enY+oW788SgARSXHC07v5YqkaVfpf9eF3p8kb+EQWhXQfRsEvjICApI
         tyBDdVtSt2PU3ugSD/G2roqF1YM3/qPbnFm6vQOzr545OhO05XgDn6E4o9A+oNIBo8fC
         1xMlwR5w6f/TXKVCaOlvm7rNEq/pt46UXIVg/xEgwCJdJyX61p67PhuDQNWMvP//VsGd
         1a1vGekeS7lZfPdnohs4n74byuJyKu09SRcHfMv6DE26PYsY8cyLIbhSsAiDN6N+Dzme
         vALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739723261; x=1740328061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zauf5zxFWWLZSth2HbJwJMsQ216gUntGDkfuE30UgBk=;
        b=h3vov2RDlCyUBYO8TEH+4gEo8OsUoP0cP9NE9Cm3eI/CzCbKmSdnZ5jwgTgrqgsmpU
         5Kr14Tsuhx9WPSQRG7t0WFjT+4LYNZeJN98j4WIu9Zq0VhenfEQGf70adMItlG/CnNiZ
         FBhFKbdVY3CDFc56Fs/uaBpB6rMUXu2JzYNy11/JZDQ3aZbVi2r2gZE/GrSl0hJTwqbG
         z/PAHqjnsz9AksmK6PXw3fsDs4qls+hCgPWyEavegjKdxMDa2C0XTUyhj0/bXkjmnA0C
         5zYonN4XVI+z5sm1atvvWMYlVD8KYIO8fqQYijw1oiiAWbVLC5rOCJVLnQijutPNyCsW
         48Lg==
X-Forwarded-Encrypted: i=1; AJvYcCULb9Y5X4KN7AqSE4r82rSO9NcDGQ2DkoaH1Y4fWGpkykLT5wJv2na6QaotM1pUJCRt+TEOQogrxBFOB38=@vger.kernel.org, AJvYcCUUqrOGFts8PXWN3Efovdbfe1jm/s1HbmOnfoeJwRIHnPdO/MQf4HscJmcSIEN7/edRY4ukt34z2eS8ilTB@vger.kernel.org, AJvYcCXhpbCoYnXhxqy0e/Xeddh2lLpbrfNaBPYCBRH0ihgBTAKu/ypkgEy9KGIxB3B4JEazz4yiGMPSf0qZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFw7Bn697nKS5G0GrTgek73RSFGlo276QV4NoUuT0D2ZawqY2
	Bw8EOksQADtC+yuKETaf3hI0kzhEutK44CDpWOWGaqTtqwxWiTrH
X-Gm-Gg: ASbGnctr16Pm8TmGCtL6CUgoeUdxiQUtQlq4AoZcDr7lk9gSmJaHk2LroCzS7OpFsBK
	gw52LhI+o5xTqRw4O1+OVwueQJoI51QXeMi5pEs6bk3ti5GP2p1nf9FStsKubs4lPo4gFNbhfjJ
	UeGDrtDvYREYLeD9vbHIuds2v9v1Aa1IQi+vchu6aYSzgM7bbjwr8NaijxXgiUTyVp4MLiZwrY7
	KeJPBHMg7YC+mpKY2yD+d8XwbMUnXD0+kDbect41PVvQby//V/ElDv2R3depl5RZ7BaujlzTQiy
	uNkl8Q==
X-Google-Smtp-Source: AGHT+IEfyw19KqgBgbX8BnoR8UCxGSSP+RtIOF9FWGWE9j0G1d3J+HWE+7CvgJ0oLl3OVIOTDVIE1w==
X-Received: by 2002:a05:6512:1189:b0:545:3dd:aa5f with SMTP id 2adb3069b0e04-5452fe92491mr1764798e87.36.1739723260558;
        Sun, 16 Feb 2025 08:27:40 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5456468c28csm481835e87.122.2025.02.16.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:27:40 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/3]  iio: light: add al3000a als support
Date: Sun, 16 Feb 2025 18:27:18 +0200
Message-ID: <20250216162721.124834-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an illuminance sensor found in ASUS TF101 tablet.

---
Changes on switching from v2 to v3:
- droped linux/iio/sysfs.h
- set driver name directly
- switched to IIO_CHAN_INFO_PROCESSED
- split al3000a_set_pwr into 2 functions
- added i2c_device_id
- improved code formatting 

Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
- clarify commit descriptions
- convert to use regmap
- arrangle lux conversion table in rows of 8
- add more used headers
- improve code formatting 
---

Svyatoslav Ryhel (3):
  dt-bindings: iio: light: al3010: add al3000a support
  iio: light: Add support for AL3000a illuminance sensor
  ARM: tegra: tf101: Add al3000a illuminance sensor node

 .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
 .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3000a.c                   | 223 ++++++++++++++++++
 5 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/light/al3000a.c

-- 
2.43.0


