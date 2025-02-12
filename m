Return-Path: <linux-iio+bounces-15410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD8A31F5D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629F43A70E1
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D41FBCB9;
	Wed, 12 Feb 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL4x2ZU4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C6146A68;
	Wed, 12 Feb 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342860; cv=none; b=RVWYM2AUosVTkHHaZmyfRGVRb7WL2X3G1rOGuV8HOx95pUihgXRq2vx/v33oiKbSifKGRcP0o8OvAsJiaJdfZkpuduEBG3m9AAc5yVCXfkiZ047ppX8FTY5UzzYeXTWejxTbcf65qzY5ZAFFy/nmOPuFuwA2A6nudeV0QsOHWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342860; c=relaxed/simple;
	bh=taHTvKoWTF7BQ5WW8HRGbtCKUPrDALj7zBFaw0w4D0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LteWL0GT7TR2YqJIqstkq0egkzKfzsYjAxeyn0vQeFi3d9tYNxa6ZuHOYD83cS+nXFBZHAIoSGpZ77gEIiGaTz34v840ru/kvhf6ghplkCJoVoJBkgMg8ealTnWDBGUBgVJmXrPXHCIWRT9qtOkJwqvd9oVtu5UdU8ewYWyhlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL4x2ZU4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-543d8badc30so6685651e87.0;
        Tue, 11 Feb 2025 22:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739342857; x=1739947657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e2YsuTCPphVGemqecyPUG5geUpzSnDZxeT/5yx0AbGM=;
        b=QL4x2ZU421cpVE5dhLjEZRpOoqwwDXvuEr8jKmbS6gQH6MRNBNNhfz0CgLyo8WNTIB
         Aw2uJoDiX6e3TbwZj0oR3inlt2EVKYNr+UcCXlWXAbAWBEPdX30ZnktlsvJ0LoIeeuTd
         25l7wNM5Kpw7PWdqwx9F8d31Yx9kMxQgAMibYp6tJi1d+BMx5DJ5FLW/cmU8WJURSswC
         pIpnE7oBpONEWohLU8UqEoRRfhE2riGB4Nrq90XidICFylUHlrIjaeiq3VWIshfTLgoO
         X83x1gTgv3tkKhgHvQb5fqi3h1QbmT4u5+npBWQ5dkZ+Uu0AWY9NdztgqB0IZNcdvdEf
         qbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342857; x=1739947657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2YsuTCPphVGemqecyPUG5geUpzSnDZxeT/5yx0AbGM=;
        b=Xy8YQOcxCkNaxpgtHKTGRgEEtkJnyv3ac/l5e4e+zKf6PYoCaf354612n08ncYOuiX
         atkwLgQuAkDXIK2fmxunhv5a3FPjQV1wkDOxgY2y0nYMz2ssE9K9ju5P4GDFkbzYkoYH
         GqyCYFw2y68QZNv75egXxcVF78Teb7RyPzUmFRZJvpb6gYyFIEA3Pccu3zyi0ZF+aLjH
         RUBIwPAYc11Ac+9e/wp1sYwo1jbhYrQu+Kk9M6agyHwujRmCJ1Z/u3s17pG2SlCNMQRE
         hRoIxTAI98ueJeAUiNztOX/a66QJcWWFQ8QAnJE1X7zjiDl3naN2EcZNO8Rl58fleEK+
         AJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVTznUh5H69xIpXpQHPpb3qG1DinyDxgdD1r3JaWYd3JepFGxoudGhUbMYtj7O1WE3+K23JdY+mW3FMfzj@vger.kernel.org, AJvYcCWVt1vM4YiUqyjcFQYKax8Ro+mNbnPXI4PGnB/TWBoNhq5g6nOtCRXqWMtygJNL+tiiUyIf7X717An8@vger.kernel.org, AJvYcCX2OpZKPumh7bYmLtcBd+yIGATkcfmWxJjrplSseLSnO0/TOidNTkiUCu9WJiplWEQjZJbddX/53GzH23o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+q/wnbkd/UDZNmCDKxnXBO77p1TvjtJT6RnJ66rWGlSCE1Ka
	+K6dnYq7HMzer0kd0AAL48kkXu08yXetX59UOka5nIp/+ro3C8+x
X-Gm-Gg: ASbGncuIKgDPch2zOIIUDLMdY5XrIBDUpgpak+MUyAsycQKFpSMnOlEmLhCQRzqZtyy
	koMl50vOld3dobQSYYcDkf4KezoE7fcww1643mKubVXCt93S4oKEdBlgFuN1ZvcXUi8iDmQYOIn
	Azj4H2yJf4iOdRWwuHujaZg46fiai6bjj07kkm3u71j7AS7TGboQpqzdaMBONBggupI7FqlRm3+
	IKXeUhdMpJGj9cFSgHdqePulvevVJYtcgPFOFaNSDbLkiQ3QZsUD7CnYm0NLatC00Rwdzrgdhsq
	oIlyVSo=
X-Google-Smtp-Source: AGHT+IHIgsC2KuIYoI+i/oR54Zj2+nWE2GIveGKb7lMgC3jlfrosajr8ytXqlJ6wSJwC6q17EXoyEg==
X-Received: by 2002:a05:6512:2389:b0:545:bda:f10 with SMTP id 2adb3069b0e04-5451810fdecmr406848e87.21.1739342856798;
        Tue, 11 Feb 2025 22:47:36 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5450e09e9dbsm748600e87.120.2025.02.11.22.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:47:36 -0800 (PST)
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
Subject: [PATCH v1 0/3] iio: light: add al3000a als support
Date: Wed, 12 Feb 2025 08:46:54 +0200
Message-ID: <20250212064657.5683-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AL3000a is an illuminance sensor found in ASUS TF101 tablet.

Svyatoslav Ryhel (3):
  dt-bindings: iio: light: al3010: add al3000a support
  iio: light: Add support for AL3000a illuminance sensor
  ARM: tegra: tf101: Add al3000a illuminance sensor node

 .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
 .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/al3000a.c                   | 214 ++++++++++++++++++
 5 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iio/light/al3000a.c

-- 
2.43.0


