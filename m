Return-Path: <linux-iio+bounces-10075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4658298F545
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C031F224E8
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636A1AAE1A;
	Thu,  3 Oct 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYqgIQXD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB319DDCD;
	Thu,  3 Oct 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976883; cv=none; b=DEwzwJUn35ORAkawKuy7jXjEdCUjEea3eyiRD4an8lIYRwHz5npYoxyY5ON0uOB9nGyFx736vLw8Nc+QoUXINkB/aooeZqZedQ/J4eTYoa3HveK7c4TY8bYoOUdBmiJFMFjqgXdtBRxdBb5joy2gjUGA8+tJJ5imrxJx7guE0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976883; c=relaxed/simple;
	bh=7Qd7pConDOask/BNXfSwFweuyl/4yUcBzrozpeWuKdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVpjlhRUWJkALOC+hoHIWlGk7lEXcw1FlW9MYbscvBDvACWgfgUXUJn6Dz8kVFkxq+BSu1YJO0PoTZBuIteW31tKPkI0kLvNnftFGPrRhcR/0gfpJ4fSVcunxtS8zmap7EC+KZzj8C/QxRv24qstHKVvTbjrJnnRfJjYZaRaw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYqgIQXD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdac05af9so1230343f8f.0;
        Thu, 03 Oct 2024 10:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976880; x=1728581680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h4jXiLdPt0pxESQJDinZHqz2wgnSDllGc714nCDCUQ=;
        b=JYqgIQXD/dm7Ev17zIlhiN1ndAimGrDGY3PlkeCcJ6S6Ehlkc14H0hVks6Ub8hFjfd
         P+sE66659uf0CDTtWTP+iPz+Ja1ftDwAtkxVaGRqcmmYGK5s23R5mfDBhpemFiNNcJrX
         dha2MnGQHvwF9Ri5M56dudqWAdXXO9HpbJTYMmQKrgjd0dnQ4Al470HBAjJFmDC1U8up
         tIil0Th7qK1kwvylhjpa1q0I0GR2KVxeJvl9e5DzbPbtnrdrtPCc+XH2yVHzkZr0OUCT
         2R+o7JLgmh9LMsuRyupekeyNMtdkXHRX9loz+kYbueSlwnvFLEIy6zZnGjuZFY85xtmR
         mjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976880; x=1728581680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h4jXiLdPt0pxESQJDinZHqz2wgnSDllGc714nCDCUQ=;
        b=nt63h32qRmX5ZIYHFy01oEDQQ9uZatZfy4Z9JDsCm9feLpmamRPX5FeBRnHsN8OF6c
         BAZCp+7Tekb0DhHoflU3D0Yq7z2lgHPpC+OpAjFN31fm/ySl8r6Bxb91XwDgbosDZ39B
         /V2Qw2WlxVNaRQ1Do0ndDZGHjgDyr+0rdCpUjQyq0xqMLUZfXTYuqH69x3x2di6j2DA1
         ADSqY9Z7E5cvdaCAPRv3xs3re1+i5PSvo0OIzUWoEGWObsUcLJx0HdOntkkfKWtaFFkh
         k/w1cZYkmr/z8z2UtgGkKCYOc4Hov8UVMjx/+UPOhkXTSCxlBJL4Zv/sHRJ1u8FmCYNm
         Ly1A==
X-Forwarded-Encrypted: i=1; AJvYcCWjorGygToCaKDBbLqq77RLqXXITRj2adNs/hsSMEKHvJiQdTKyNUHrZHjQYILeFZw6XvuJvZRRsiY=@vger.kernel.org, AJvYcCXQbVNuG3lE0AZHWfPEc/xKO586/Q9qk0uqHpnYskzLLRpaSBiPQVfOSyofvFStWGYYhMRY1eRue7o5Fg==@vger.kernel.org, AJvYcCXhwcECNcC6YcolbVTILSKRk/Xvqxe180ozgh38HxDjO0mWWLb/mB3VPa9O/WWsMyTQgUFM5Bkiwy62r9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuvBr/Xdb1u4mnnOlVNRY15dbgJPTbUHObO/4ApH2n88NwSS5Z
	WRgyrtPEiYyOIutw4RNS0z3mJUDSox8FrwL4ND6GoML2Kvi++eIS
X-Google-Smtp-Source: AGHT+IFYXJ4cT7wIRHX5Lvd/NZde12jGaUy1DpudCWiHF3jLCUVlAtvMN9LjEyoXYv6RhQtqt9n4Ng==
X-Received: by 2002:adf:cd06:0:b0:37c:d270:e5cf with SMTP id ffacd0b85a97d-37d0e779b4emr111859f8f.33.1727976879849;
        Thu, 03 Oct 2024 10:34:39 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d081f7035sm1705056f8f.23.2024.10.03.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:39 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:06 +0200
Subject: [PATCH 1/7] iio: core: add read_avail_release_resource callback to
 fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-1-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
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
index 18779b631e9071801958fc9d50b941b548fab940..55326f0310b2e9b3fa561c4728e7eabe1d7a5e78 100644
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
2.46.2


