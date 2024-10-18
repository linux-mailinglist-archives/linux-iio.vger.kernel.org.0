Return-Path: <linux-iio+bounces-10707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CEE9A3B1F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC3BCB23763
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D520125D;
	Fri, 18 Oct 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cucaDfVn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0F20110A;
	Fri, 18 Oct 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246620; cv=none; b=hb5Oh4v7XTKdM6fGA9lvqI0xtQSOadUkX2mRsfvOMH9ErSXucIov6GosapvrBxqGxf7CV5K7Ad4MojVC0XQsc87yrJbJRoRtgFg0XCuR1o8CiBICkfjfFfGqrKFdwCO0D1iNL5CoQw/gHgPKqFOpKoMfWaYa2tduL46or3oaGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246620; c=relaxed/simple;
	bh=0ClYzGYWuo9R4ytQT8+YomjzZyyvK/shpte3TSu50RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sa4tC55A0veBVVNsqhmsTlB6iazHroJU+1HHvuOGS/JkptEN14KR7ARRZIKelxc6fCwO5xGopvAYh2gG3agVQaNkp5gsabBxsNdcKY5eOw+K1avrFaHBXQMlVRy3WCk1Xh3JzuqMokn1ABfn5Pvdgg2Ru+q29YPL39hOonfazmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cucaDfVn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43163667f0eso2928705e9.0;
        Fri, 18 Oct 2024 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246617; x=1729851417; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=cucaDfVnr89esYQ39szL0yzZVD8fLI/IeTZluHSNQimqjRPv48GzaN9hfykWBFceTo
         qiGa3NmbWAMwT6Bw4Q3HZ4yMYEuRBEDO8zL0zSJa5BBbCzZQTjMyUbwo4LuB2ZmspcSr
         B9qkRPDvCq3A879BUHnhNHAcBIoMeKoIcWMGzJtj4H/gS5WBlespCyZXXDRaczMXu5a1
         UgU3+sURlGWr+kimjG1pfzH1/VkP4Lm5ahK3z74n62K6FDjpZknHDJ1++NXjVqVR5Gim
         VZ7BIny+0BjRe3iWYjPSX4eF/7Ft2EXYv/+qkKyTClVFeghqa0Uql9YcoPKZSTAFvihm
         Y40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246617; x=1729851417;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=fjFEvV5a2ZK2EaaiSGGphDJIKFWHmqS3erNqv93gi1cb/SL7J6S6cPNNPgAV51WB39
         eZNTuvrofiusUABGGWORBGBBXCN3GU19frUzC4tcjay1IQAm8G9zYpxgWpmxAChc9XHd
         HndqZXOBBVTDG7ymGzX6MRRpsps1f9THlSjDUnqObgBe+Ey0bWB2djpQBBle6TXkFcOL
         hrkTy0w5LxDfr0FAf+e7USykMjQfFzNKqymElC4Jqs/X3Mp/YNKEY1T/felZ2DycR8rp
         qxRtrP+DAprR9NI1EbaaAtzj336z/4j/pbZ65yttkah+QjKa+7IxFAXPcDGgrj9yPkZ5
         3isw==
X-Forwarded-Encrypted: i=1; AJvYcCUqSZo/xZM8AF7klnqjoAngKMODTzhegmskm8jgmQELcosXZN0RDuQAtXXShgQtFZnx04P6/+TRdgbw+g==@vger.kernel.org, AJvYcCVqSx7JDK4WcozsR3T+hjiZ3cKgnnpmper8Rjzk0sRs/4H58+ga8m0hhSx2MOLdOAc3iI2B8C4NU1s=@vger.kernel.org, AJvYcCWP1eozMr6cb0fgxvjvs5pRBMg34iLkUTiNKYdQ7291dNJRgoXflc+SvE9EJY3YTKCyPag5codDCLWuCpo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TqtFMKVbzFjBRG3SF0Z23dahFx8jQxvpvkH3v7F3/9+ug+XK
	CbkNniY+JG233kDNCOmOhZ7/76b0Y1EgWsLjjHjftqEWFhjEJIA7
X-Google-Smtp-Source: AGHT+IF+vC1TXXZ41e6GhjeXRX0z3gfl5Roxla4WW2YlYG9z9+bnzPXhoqV+JJMI803cwtmFEfPWvQ==
X-Received: by 2002:a05:600c:3d9b:b0:431:5bb1:f088 with SMTP id 5b1f17b1804b1-431616a35dbmr13565805e9.29.1729246616911;
        Fri, 18 Oct 2024 03:16:56 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf027d90sm1547801f8f.8.2024.10.18.03.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:16:56 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Fri, 18 Oct 2024 12:16:40 +0200
Subject: [PATCH v4 1/5] iio: core: add read_avail_release_resource callback
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-read-avail-release-v4-1-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

Some iio drivers currently share an available info buffer that might be
changed while iio core prints it to sysfs. To avoid the buffer
corruption, add a release callback to let iio drivers allocate a copy of
the available info buffer and later free it in the release callback.
Such control is kept in the driver logic so that some driver that needs
a big available info buffer might also perform some check to keep the
copied buffer around in case no race has occurred.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/industrialio-core.c | 14 +++++++++++---
 include/linux/iio/iio.h         |  4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb3a3f63381d5a6f25a2881b3ba2ed..4aea9de9f15a4d70f9d02fb3d47df49eef8c8423 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -859,12 +859,20 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
 		return ret;
 	switch (ret) {
 	case IIO_AVAIL_LIST:
-		return iio_format_avail_list(buf, vals, type, length);
+		ret = iio_format_avail_list(buf, vals, type, length);
+		break;
 	case IIO_AVAIL_RANGE:
-		return iio_format_avail_range(buf, vals, type);
+		ret = iio_format_avail_range(buf, vals, type);
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	if (indio_dev->info->read_avail_release_resource)
+		indio_dev->info->read_avail_release_resource(
+			indio_dev, this_attr->c, vals, this_attr->address);
+
+	return ret;
 }
 
 /**
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 3a9b57187a958d6e65c699cf7814df5bac9a99e3..03bb765670a0c5f0129fc677c3a4a4cb38f4dad1 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -491,6 +491,10 @@ struct iio_info {
 			  int *length,
 			  long mask);
 
+	void (*read_avail_release_resource)(struct iio_dev *indio_dev,
+					    struct iio_chan_spec const *chan,
+					    const int *vals, long mask);
+
 	int (*write_raw)(struct iio_dev *indio_dev,
 			 struct iio_chan_spec const *chan,
 			 int val,

-- 
2.47.0


