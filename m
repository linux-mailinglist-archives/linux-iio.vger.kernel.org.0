Return-Path: <linux-iio+bounces-13552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01CE9F3AF1
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD63B7A4F8F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 20:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151F1D514C;
	Mon, 16 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Azplt655"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546391D2785
	for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381473; cv=none; b=eHkmSyPRLqURVu69weACid+JlwYq15h3fvXXz0RGX52ePJlvP6z6ewSziXRPt4U6ABtYZqm+W1XUC1wEIVZ+wvTMIWVde4SQqQDFead6Iuk44RjyFULG3hPAn1uKG5OFTaPwryelRzsF6KAakYhGFrPxeyKAEEn44Bl/ppsQwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381473; c=relaxed/simple;
	bh=iVCmsO53/XGy4jvlMhHXrY4JB3K8lYaWVgXdiHkbpVk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E56LErCXUvr+0Kz9MG9JRMDUjmQKt64GFkjceeJhubGTbbCuY/+eWxUe+dqpNEDdI4z9Zgt9pZRIVs7ybqO4XjnhXIxrhQZLQ8UhsqENhANC/h+mffgWg1xPuhmuZnigvK9xhEAFE9MNUY6gvCeRhe9nobLP5BuV3BN6CQcIAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Azplt655; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so31752805e9.3
        for <linux-iio@vger.kernel.org>; Mon, 16 Dec 2024 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381468; x=1734986268; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDig5j+/O/4f0Wndg1xc17b3h1tURQz0MNAvDRCrMqM=;
        b=Azplt655gqVzyic9iXnohWHGJOSeohmwwV4DWtOzvJWe/voil1n+NYxnOMegtc948o
         eAZL6ENi9h5RP8DAaOTsQc5UGnl45d8RhatZXobO789rGEqBeryvgW7WEmwLXqDHlZC9
         b3sACGJPhIXwqli8FfGbdCZ6JgzDkAKJmW5zBy0dt5JRqOK+xwr03MM7Am2NtutzxGcL
         cA/TVYDBQwUzC9nUcVbNFxDOHqw8TaFQGsi2K1MSJQT36PZWuCL4ZJe+iTtMJeNu3WuB
         9i8bgbZWa1B2BpJ1ZSzQuEGX5wvjYrdySSyqXIqdYYpEX1tIlgwKnYnoSx3KPBc1yR3p
         9Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381468; x=1734986268;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDig5j+/O/4f0Wndg1xc17b3h1tURQz0MNAvDRCrMqM=;
        b=tggaoZJt1EWkcgsjzGXx+n4LvsXhnSLmQM3QeDl3dYA/kxr8nttE4IQfskX1nHkIjB
         /5l/BrDqRrHZRTfTjGaiF6yqMOaTFCf0RcUPGFavEm/KaAuSrMoTHgwqRw3KuMm+IfB6
         X+cR+s2SlliSvyny9UfnYczpBEtOEhqwC0Vxm3Iy5QBE+atfugDwNkF9LdTTZyN29k4Z
         58KkWyquTpy8QYcBj4l9EOSW3n8PJpQsUkUSjLWZE7gCM41I+MuBMsYfH6R2iHwxTRfR
         bUM8GNm9xu8YDSmfn4CShYTZ2A6pIYdl0pzj0J1gTieFYs77GI+RKrmg7SBsGsYT0sm3
         M7nw==
X-Forwarded-Encrypted: i=1; AJvYcCWOyn01zD+/L7aL3CAQVvvxcGzOfG5AgBl9b1vngDncojhMksckAhUJlN04ZSnGjk5/Td0JTDfNyik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyclh0cgcjLt2NQQr1jMRUkOVOxD+bPmbpJGoVK/ztPz9miDpD8
	3743CI5MIQWpmkf+zYUBzvD3hd3T5wMbh5Cm3Y+ob1XXkP0XRUKobteAfXZ9TsDQ5H7bG0hnhOl
	j
X-Gm-Gg: ASbGnctFelMUmdcwl4O4j5Bq7W6odLgTKSAkziBNm02G2dzLRCUO6iRRFX5Tbmhjy+K
	OrI64lhS3ZbRnEy+7CbgJF+vGu4nWbWAwMKSfXB9DZCKxgd2WA1iZFU6ADUz9to/mQ0IKQwghzf
	WwkEnX+hrGcfKjK3Eua9px5xzvkl5L3U2dSc3PoY7d24yeoLnBXWgA5CuSrN2G/hMcutLYLXsFa
	0I/qAnF7yCnUNF+EUPpWezGoerKsxWoECdFHhfK5XSDz8ncyj3G9axhuIunkfLfaNV/IL+E59q7
	YLX6GF8xiA8EaVwzE8CHr8ly+Gi2UcNd/A==
X-Google-Smtp-Source: AGHT+IH0M44jPrchVIDJu2Ik2dUUUEgDxJZpsSq4mVHR3g+WHZM/OM6bxkHERFrZ+7udSbphMbcKyw==
X-Received: by 2002:a05:600c:4ed4:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4362aa589f0mr131042225e9.14.1734381467096;
        Mon, 16 Dec 2024 12:37:47 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:46 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH 0/8] iio: ad3552r-hs: add support for ad3541/42r
Date: Mon, 16 Dec 2024 21:36:20 +0100
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESPYGcC/x3NSwrDMAwA0asErSuwnLq/q4QuXFtNBcEOUkgDI
 Xev6fJtZnYwVmGDR7eD8iomtTTQqYP0iWVklNwM3vkzebrgV2Z8TRhzH4JXjJvg6lCk4sK2SBk
 xRZ2qIdE9X2+udyEFaLlZ+S3bfzU8j+MHOFK90XoAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>
X-Mailer: b4 0.14.1

This patchset add support for ad3541/42r, 16MUPS, respectively
single and dual channel DACs, together with some minor fixes.

The ad354xr connect through a DSPI bus (while ad355xr through
QSPI), so a new fpga HDL supporting bus mode switch has been
developed to support them.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Angelo Dureghello (7):
      iio: dac: ad3552r-common: fix ad3541/2r ranges
      iio: dac: ad3552r-hs: clear reset status flag
      iio: dac: adi-axi-dac: modify stream enable
      iio: dac: adi-axi-dac: add bus mode setup
      iio: dac: ad3552r-hs: exit for error on wrong chip id
      iio: dac: ad3552r-hs: add ad3541/2r support
      iio: dac: ad3552r-hs: update function name (non functional)

Antoniu Miclaus (1):
      iio: backend: add API for interface configuration

 drivers/iio/dac/ad3552r-common.c   |  49 +++++-
 drivers/iio/dac/ad3552r-hs.c       | 305 +++++++++++++++++++++++++++++--------
 drivers/iio/dac/ad3552r.c          |  36 -----
 drivers/iio/dac/ad3552r.h          |  16 +-
 drivers/iio/dac/adi-axi-dac.c      |  57 ++++++-
 drivers/iio/industrialio-backend.c |  42 +++++
 include/linux/iio/backend.h        |  19 +++
 7 files changed, 414 insertions(+), 110 deletions(-)
---
base-commit: 5f8c6f117400b7b21ad248959ae2cb6e0d634e97
change-id: 20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-119d780305c5

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


