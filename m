Return-Path: <linux-iio+bounces-15668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FCAA38579
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 15:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF041747C4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6B21D590;
	Mon, 17 Feb 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej77w0oO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53421CC59;
	Mon, 17 Feb 2025 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739801038; cv=none; b=NM4op+hAHlGNLSVdZyQLAkVXBJQx4Pgu9y3EWnfm7hR9jI+dRr+MmqznJ955250b9hOILM4+QlshD+EOONy/prqK1EIDr4NTBu1s75TeJlqqF9ITLCXJ/kCTKwJNSNSFT62sTWv/LJ09Dn1RfkeFkre+VIyytx38BUV6u9c/4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739801038; c=relaxed/simple;
	bh=H2TfDN5N1f/JWBybl+hGo2sR+gO1dBz1QeSZxPe3pS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDM3mAfrv3bG62+l/IBQ/BGaASfN5GRz6DhbrJ2KNTpFun8IRtyP8VMpKAo4AS2CoqCOzrSI4C7yXFCpm5oAo3f0UAU6bujF15LUBgGfKXcN4wYNe5R0UIjxSOOpOcpsfBYsjbnfyrbUChZNFnF3RxxutDRESuy5tOcWG4Uhjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej77w0oO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-546267ed92fso581622e87.2;
        Mon, 17 Feb 2025 06:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739801035; x=1740405835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQc+tH0GO9uRin+2J73aFkZwQ+0KuRk3ppOAlbjmV1A=;
        b=ej77w0oOH152waBf4JcZEf56D+cdJl96n2FNBgfHa4IUwiY2kfZ4ztHH6FDdrNwkCw
         /vlzeoyvwqSbjmGREDwSDcA1lJwc6upSPoj0RdshRRf32N7kt5O/v0QRfBDR8upBI1cq
         sIkZuRXKQzLv/DFEYgrFn5S+C3P8rfqVn1Ao54lMsk9526Bph9Q1XpeCpswiWeq+GE5C
         3WMT3OwmDyGvh1DWTKgubRrF17IACCTgm6GWnimX7totubMvnk0NIFv0op9k9tUQqLpo
         wWG4Ph7jQwlWdUDF3WYJmY0aoq+66A/x3wD9SHNJCwNziBtPRB8LwmlUaYGCxnGVpuTo
         Qoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739801035; x=1740405835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQc+tH0GO9uRin+2J73aFkZwQ+0KuRk3ppOAlbjmV1A=;
        b=qdpyi8hO4KN8SnWHF7VsycWK/+6cP6lXmRllgSMh6ZZgH+E6s9BJYBch+kXsVXCVVZ
         EemfXlRL+cxgBO7QIdOnsHVUXS8T8Ya5PkRqgv+mH/Gk5fMKrte1rvGmIYiGbhrj8/P2
         CGLRrKBEKj1x19RClBjX2BkoLQfQbXVI/ICzAsp/bUF1nZjyuURg+ol5+kltYSfrZaJc
         v9oS5XK5CM8carYJl/l90XRKphmGDwJDThhdMS1qkd3fFDzyQIVw1t627x4Fjlds+Yfi
         ao6xg9ZpsoKhmZXmqqiYMO1gpy4sKu6eB/m7NUKXFiSBid9Ob45Gx6jVgfXKXlL9ildq
         +MhA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHXmmb8Sk3CtJe8MSaIDzjxT1woUJAeSAaptppqK3sEFMgWaGBzciSG3iOYn0JV2kAz4UznkumuzFY4k=@vger.kernel.org, AJvYcCVT3tnFSpduxv0/1sUMM0VqIEIS4hysqXTMaHotuKZdmP9CRAPivi5nLPV+X1+oCI+8eGxQIq8uzVro@vger.kernel.org, AJvYcCX9JJVscvEwWkoj0DpjbysgKjb/TqcyJvSCiSPVivxa4F7i5VbjaS8Gll8yEaoBORfXWLZWfCbB0dTpXnbO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcne3ilX6R/sDZoi77QHEmE2X8U9KuGU4fH2FTEzG+FscRX3Zg
	/YpXf7waEZQxVPvokrhvEgHpeWtl+uIOQVuHDMoVK7lbFt7oEYBp
X-Gm-Gg: ASbGncv11jS1mxtJaHwFx9e+B1tm3WKPz31C0Ysc0HUpmnSTkpwtWC/CDfvlXETU8K1
	N4QwVSelp5ijD0WG/8Kl7mHbBGuCdVKtZHASXum31Fbe7fZwRZADB9lpqJVKeoCzm5xtgoxWE/z
	hz7lT+YD9af9aBKtt2390I1H2f9TgG7SkR5TCe+5AobmoYrjSvSwP+PZDe3VXJsQBzDRfNsMRhX
	YdrwalAgfn0hlHFzzF0m0CE3t5iCYI6ncuKqqHzLHKPO+oTAl2YvGmKIPXtqxTolID2S5HAISZc
	rpggykM=
X-Google-Smtp-Source: AGHT+IHuYGoR3QQWomhG87aYbk+cYDQP1vD2qTfpy/eDbW+KJzQ7tYnJF8/1Nlz+O2OoxyuRfMOQ8g==
X-Received: by 2002:a05:6512:124a:b0:545:5f0:9533 with SMTP id 2adb3069b0e04-5452fe73e42mr3179389e87.49.1739801034416;
        Mon, 17 Feb 2025 06:03:54 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309306d5f48sm8919601fa.57.2025.02.17.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:03:53 -0800 (PST)
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
Subject: [PATCH v4 0/3] iio: light: add al3000a als support
Date: Mon, 17 Feb 2025 16:03:33 +0200
Message-ID: <20250217140336.107476-1-clamor95@gmail.com>
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
Changes on switching from v3 to v4:
- return write function directly
- clean up and fix i2c_device_id

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
 drivers/iio/light/al3000a.c                   | 209 ++++++++++++++++++
 5 files changed, 235 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/light/al3000a.c

-- 
2.43.0


