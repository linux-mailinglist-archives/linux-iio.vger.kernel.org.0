Return-Path: <linux-iio+bounces-10868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062BB9A6932
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC9C1F23A0C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEE71F706A;
	Mon, 21 Oct 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmzM8OMK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890311EB9FC;
	Mon, 21 Oct 2024 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515389; cv=none; b=tShUNNuJhjJr+1SBm4jFy9Hq3vwP7J0wfvsUFEICJLFrEa+QK965Q34ddkfXe/ZCzrrIiT5C291jo8d662uuhYi5Lfy7rT75JJf9pQeV/C72rxa+z3GnuWxiHYTANyfSb98fkmKdJy/3gAI/cSDDZdNAjM+rExD9jJ5oCXWkn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515389; c=relaxed/simple;
	bh=0ClYzGYWuo9R4ytQT8+YomjzZyyvK/shpte3TSu50RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6XclNvg3mzALkx8dc152QSrnmdm0byEevaQOvaSMe+pmmYLHQcx4EQYjhgW+vRQfmlXJNH4WyYBCnJ5r+c5zCwW7p/Dvb5FwXx40E8hm9sA5hPPBtW55gf2JVa9Cy/yELpgHs6tgDGLS2dwRETtrJ+SxHisJ4adSADZfJB2RSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmzM8OMK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so45598175e9.1;
        Mon, 21 Oct 2024 05:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515386; x=1730120186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=WmzM8OMKa4chw4UtNMIkyqRM6W+MxkBbMEre5NVw6cFckW2SfuoFH2P4nw5EuFdKFQ
         4jnFjKXZx4ZCVAt7ZAx3waKavoJ1w8ZFXJ9ChGWAL1fjVI4VLwUtIpmYfHtqFhtV41MS
         S+crv52UN5BD10hvzFGOVqyFqwf9I+BrkvhevuhuSIM/SZPDYZ9IBA+GsSYOPiLWYK8U
         jzD6ZCobqfv2/MdgL6gT0rPlYOLyR26gESLtdOgA49Wd9SoC7BHG6y9r7XC4Ht3gNBA9
         8wptuKzNw1V3259E0PZPM1QJxKoU4tdhbSS4BlfQlLUq7r8cBCaxxqbo0D0cS3uij6Fd
         X3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515386; x=1730120186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=HlEVEXK4dHXCok8PQburPUJSM2Q0nahtKc9SYjwkUB8TZxNJ9sKvdKzoMURqCY/gcH
         RBylTQMecXSNJ9AcyYq+UeZokDjVWiUbpYXNMG8yvLYaOjV8WjeTqPkneHhBo+/6SAVy
         o1ugrC6+ec7mOGKCT/9Dtah5akgy+44s063y4AOxVEP5mbulZk+i+6yJiwJaAiIFh7Ug
         Dh/+p1XBJnKnjWHal48/x9MDKIE7H00X3KgkBgrEaiOrRa+VfsMarM70uviEqoPBFMhE
         Ppo8fxNExbxkPkQePmMkVKv8T8J8sX6PtuNvHRVIWJ7eHuKbT1D2fSFm0iVm9FxuULXj
         0w2g==
X-Forwarded-Encrypted: i=1; AJvYcCVR1ai9mNHq6vwcAPWtBxTi74b8IoyxzDezrjJfGVraxfLJ61BqLSrh2oTolt3DXsXoTmuahZlwMJdnWiU=@vger.kernel.org, AJvYcCW2hT+EGuYCLdwFelExaidHMAZwaaDhwnU320GeoRMHGMoj+hv8rd/OQx7RkeJo3wn8pbdgTiZ58K0=@vger.kernel.org, AJvYcCWzmza8AXjDsGxSI90z9hRBRS8Nb9DZTZDwIeefX3LC84/jF1UnMM3U2LKI32B6FQCcf8CIdubLzOYilg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx29M6813NAXlhbbg4nr+Cf1BYzXRzo0k3nqs9kwwiUC6rma3
	lWQzWB5J0YwXNlxSxHDSy5q2aEptI3+7UD190drYqpgxJOgABO3h
X-Google-Smtp-Source: AGHT+IGZ8MiqwunkQyNVTGOJ9VHraenoSHSD98vz/0FpWLI2bapcbutIDFCTUd2ygH4Rgow6TNUO/w==
X-Received: by 2002:a05:6000:1f0a:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-37eab6ee8abmr6798456f8f.29.1729515385527;
        Mon, 21 Oct 2024 05:56:25 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570dd5sm57210805e9.3.2024.10.21.05.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:25 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 21 Oct 2024 14:54:14 +0200
Subject: [PATCH v5 1/5] iio: core: add read_avail_release_resource callback
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iio-read-avail-release-v5-1-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
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


