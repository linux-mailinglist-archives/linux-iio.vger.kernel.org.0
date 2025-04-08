Return-Path: <linux-iio+bounces-17804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CEA7FBCA
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 12:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A77D188DB97
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01351264F8A;
	Tue,  8 Apr 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yG0wFQCk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D2267F5F
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107617; cv=none; b=gOun6XZMpPq28ITnMuicXEWIHS337ANvW0eaZThWJ/DKac4u8A1OkyQVXisVU/wBsMBisz9OuRA6eBC4rMeEXhEKxm5zFcPpWzPOI0Ac3LK0jxq2+Xsr64VVj/PU/VgT4tLA24rv78IG1u099IW6u4YmBv2LBrUt++OU4XHNCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107617; c=relaxed/simple;
	bh=VqkQDwdjjBLXg0xsTy9tSOcc4xRmbJVc0CLEPpdho78=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F5b+xzVKh4ojvU1O2vUvQreLhuovdh+6LP5s3quffE8pEI/AGXuTN9p0RtD8OZvJCSaxKfsIXbcS+R8/WnMFPY9UhnD7RsmQgv8NVEDdi2TV8maC9O6PjJ2D73BYzohjtlvqsjTGhqcuzKeoByZMDypakDjDjPBVP1s+flOy3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yG0wFQCk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3978654f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744107613; x=1744712413; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vaQaFHxZ5nKN+lY9D9HQ1Xp3+zQ5MlJgomgir2Nxsdg=;
        b=yG0wFQCkfMXYslCHGeRjYoRhcxA0LZBji6cmfW1P4gIAELPkpS7pIyMT7kxL9Rb71L
         hx3RiXyGm9TV9qV+QspyR0LYC1nfFwghJ1TTlE4A8EvManyuApTUK9HZbLbfsU0S41Nj
         2H8+/8rSY1GC1dwyVP00y7zRoiR0O7KkBHFgbsL/+bEuGssyOW7YvX/naWqMvEM4iWXh
         kA0UZkeyS7Q3ouncoVH/y1d2rZP/xasbsKd8PR5zLeL7/sgxt1l9gv/yD7bw/YVjGleQ
         lMJ+jwfslFz4yOy9nUpKzEfBMMKvkY/V9OPVwtFjBfiMf3ti+dycUvkor8IO782pgvC5
         b+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107613; x=1744712413;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vaQaFHxZ5nKN+lY9D9HQ1Xp3+zQ5MlJgomgir2Nxsdg=;
        b=jsF9RSNn1Y0P7gHaumW/+fDMN5KIif9r7QuWOPTr8Yd1I5tdtOc281JbnJddPxG2L8
         uj7N+1CAb+kfdGziycAJBl+1yHdmB521cx8UIRQ/OgpJtIeb8/SaTt/uhCtJBQMq20Xh
         uFc7Qhm8P3CN1XtRZW6Kp9S6e62eru1LOp8H8rnq5aHe7FqecjQ7ctXCDSTYb3ZQaNp9
         wZYKVgpTNphRU3lm2+amuMPluKhSaqD3TJqFotGEaNae/ydTB9g9DvINGja2ayIyIsqh
         VVpzGBnmgfe67dmCbSoCVbM5YYSYRwjopbuug0H/T41g+06bBQXckG/xcS1O3dgVs4ZQ
         C+lQ==
X-Gm-Message-State: AOJu0YwBXmC1M6KqnondvjNIbnNKB6gcAs40osUrwgwLNMuhCS043sYQ
	m1j5I3i4qMP4QOLBqOqga/sv4MWJSTnxBj1ETUoah3A854gCLsJLzcxFuH+AYNA+Q+UW3RtbiDN
	y
X-Gm-Gg: ASbGncvdueEk71EzYqTfyF/M3i7eh1FdPwVXo9yckZeTerdthdI4uBRDGSCVQ1IOXca
	8eO38vncEAWAbymlSnwTOmfsDCnS8hH/BZrVyM/jw5YG6K7WXkvWAi39RQB1iCLHFsW9gJY/CDM
	0gVzi5Io7Y90VVCQeeSA/wm011UXnttb1QvsotlDik2WA6OTnyPz+vXF86t/wm8vqS+BYITpYrR
	sXWbdWnt7LbUv2QiqbzFXLnrwJbrABCQ8cRAlh9PU6UzMf4rEaE/1NgaxDJ+Vx6gAG33k9h7xwk
	4Bh8pEVSW3XIBydJJVTnwb7iGyzXTCHLn/8TOexgOhF9psvh0a3HUEd6rvQ7jqHLSNj3/p7M3pc
	7qTyQow1f48dFX7vAvsW/Cw==
X-Google-Smtp-Source: AGHT+IGcbz9EPZCqgrBKNQ8aQeRDCGZyMg6GG7p5JvSkTyWeu0NoTLGjdTFe1Q3xhSgsj7nwDpOzeA==
X-Received: by 2002:a05:6000:2410:b0:391:4389:f36a with SMTP id ffacd0b85a97d-39d6fd0229bmr9811971f8f.48.1744107612907;
        Tue, 08 Apr 2025 03:20:12 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d7c6d838bsm4396138f8f.69.2025.04.08.03.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 03:20:12 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 0/5] iio: ad3552r-hs: add support for internal ramp
 generator
Date: Tue, 08 Apr 2025 12:18:50 +0200
Message-Id: <20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAr49GcC/4XNTQ6CMBAF4KuYrq1pO0MBV97DuOjPIE0QSGtQY
 7i71Y3GSFy+N3nf3FmiGCix7erOIk0hhaHPAdcr5lrTH4kHnzNTQhUClOSXMHLbceOhKFTkTbh
 S4mig0jWik6VgeTpGeh3ycn/IuQ3pPMTb68skn+0fcJJccHDSGIW1lxp21ty6YCNt3HBiT3NSH
 w4sOSo7zpO3CALrkn448HZQlAsOZEfLqkShC6tF8+XM8/wAjaWTHUsBAAA=
X-Change-ID: 20250321-wip-bl-ad3552r-fixes-4a386944c170
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=VqkQDwdjjBLXg0xsTy9tSOcc4xRmbJVc0CLEPpdho78=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/8kOQZ064XHzXNd2ubwkCv658uW316gnT28kl19/We
 3AEijT+7ShlYRDjYpAVU2SpS4wwCb0dKqW8gHE2zBxWJpAhDFycAjCRDesZ/lfX9vDc1n2qyv7Z
 7o/e72MrG09/uFOepHx98orn13zzth5nZHifeUWureeFD+9pxy/pb5fzB9tbG8rnXXnlsD7euT5
 LmxcA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

Add support to enable the HDL IP core internal ramp generator,
actually managed by the adi-axi-dac backend. 

It works this way:

/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage0_en 
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/out_voltage1_en                                           
/sys/bus/iio/devices/iio:device0# echo 1 > buffer0/enable 

Activating ramp generator:

/sys/kernel/debug/iio/iio:device0# echo -n backend-ramp-generator > data_source

Deactivating:

/sys/kernel/debug/iio/iio:device0# echo -n iio-buffer > data_source

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v4:
- set data source based on hw channels available (model_data),
- use a string array for data_source debugfs attribute,
- modify debugfs accessors to use the string array,
- add new "data_source_available" debugfs attr,
- fix documentation accordingly.
- Link to v3: https://lore.kernel.org/r/20250407-wip-bl-ad3552r-fixes-v3-0-61874065b60f@baylibre.com

Changes in v3:
- add mutex description,
- use devm_mutex_init and check for return value.
- Link to v2: https://lore.kernel.org/r/20250331-wip-bl-ad3552r-fixes-v2-0-cdedb430497e@baylibre.com

Changes in v2:
- doc, add few words for generic spi driver version,
- axi-dac, add a separate patch to check cntrl chan validity,
- axi-dac, return EIO on a wrong source on get, 
- add a lock on debugfs file access,
- use const strings and strlen on file access.
- Link to v1: https://lore.kernel.org/r/20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com

---
Angelo Dureghello (5):
      iio: dac: adi-axi-dac: add cntrl chan check
      docs: iio: add documentation for ad3552r driver
      iio: backend: add support for data source get
      iio: dac: adi-axi-dac: add data source get
      iio: dac: ad3552r-hs: add support for internal ramp

 Documentation/iio/ad3552r.rst      |  73 ++++++++++++++++
 Documentation/iio/index.rst        |   1 +
 MAINTAINERS                        |   1 +
 drivers/iio/dac/ad3552r-hs.c       | 166 +++++++++++++++++++++++++++++++++++--
 drivers/iio/dac/adi-axi-dac.c      |  54 ++++++++++++
 drivers/iio/industrialio-backend.c |  28 +++++++
 include/linux/iio/backend.h        |   5 ++
 7 files changed, 322 insertions(+), 6 deletions(-)
---
base-commit: eb870a5af7db1e5ca59330875125230b28e630f9
change-id: 20250321-wip-bl-ad3552r-fixes-4a386944c170

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


