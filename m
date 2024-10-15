Return-Path: <linux-iio+bounces-10614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EAF99E50B
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E302B24221
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E61E32CF;
	Tue, 15 Oct 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5cY8OEe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE11D61BB;
	Tue, 15 Oct 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990411; cv=none; b=p0I3QZDnvud1gly18yA6QXDo89K1AH0Hz6Trk0r0+toGm708ryvwuu6OsRM0J8HmS6VD55S+JZY/vMqb477PR2ywHlO8DM0IZhPBd/P/zZEyMYyjd8xNi5ZSjHvc1IVoI37qK5U+TGLOJOAXMzC47ph3WbO+q9S6PevozO2yOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990411; c=relaxed/simple;
	bh=0ClYzGYWuo9R4ytQT8+YomjzZyyvK/shpte3TSu50RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0ilqnEZmggIkLM/mrm/bRIpuDm6gR+2AsRleg8Ga5d6y2DRqjapXBxk4Yc/Socag2WEgpC69J27C9iicOcHl6oW9zcLp1mYdXrKiQtW8TY89g3kS5VbrxLdkuabYeH+dIQTrorROFWOdlPQMfAL9U4TXqS1Op9snGDBkJux+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5cY8OEe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1646880f8f.3;
        Tue, 15 Oct 2024 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990408; x=1729595208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=T5cY8OEeDesSAv5N1NkoOcub2uDk2BHD02tO6mhoWQG7rhuMT1YKvY86twnuBgU0st
         HISCgvf1ADOf1PmjE/mzYLzQoWW37dtClV4y7qPvcVVoHgUWru0z7Su7BsflbWZ9HuMp
         Um9aia28WsGt57eTLpwMdxHDktXgDhQ2UJiRJY1Y0Fmu3PwhiGa8mUz4xPheq4quJKr3
         nmwPfjGoAc32LJz1wWox8ZD9oZtf3WJEtQtGaCwbqHFJB125tN71ZUODx0QeRn/W+nw7
         K6yths6w3Rlbn6haV3Icmw0KoGtk5jEHVSOdzc5zr1fBy+dTHBRXi8sIT/kerBKAN2zh
         qbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990408; x=1729595208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4DbDXoWuKEPG/SkjaxUaXOQ8tk/bgeFy/xVB16h3Gg=;
        b=YfuRXclj1+6zouL7Gn6KmYbV/F0FJjoECelMLZuCXOg19pVWdqakGub3N0R3E5G9Aa
         TRmQYTX3iig/6TuQYXR2kkyOY1YLrYb8jWnXb7mgI8ipn2nRAU0uHIeObBr8ceHGpq31
         Rug5f44eh85Xy5iGZxDQ/jd2ZMUpdFLuSQ1pXr83pXufOcz1gmmZS1dMO/ghJ0Cu5njw
         qvnJSdSWk2LSFsuedV++fwpaFJp984HYetFbDkMt2R+XlCNhcrPrV14uMNoOCzjgn1e1
         74PqmeNXXWDLiKbbf2iZoK8viU6Yw0SUvKOCcqrb2MGAh4MXg020ZL+2xlWC2xAPWoB4
         JAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHG2c+I1/tOSrBrYCUgu+PvsKg9OdWSwQYYcxoF/rRUz1f9MXUkBJXFZdgHCDGclKXDxVq7HXH4apUQ==@vger.kernel.org, AJvYcCV1Vgimp/i258v3Rz34IoVl6AP6GtjlOW75mkdH7S2BfqDHCxtHZ6j9dtreAgF0bjvbOzsU75N/ans=@vger.kernel.org, AJvYcCViidfNt4fkx5217BezR6v3aOsoj3jJxNwYoDaWE/hiw9vEA3AwFSCLXpL8SX/xDDbP5z+2Hd3FQtHSsoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTi29TlgO/nUDdTd4VyvZUB38BAd94IojfqD+WQpWiSO3Q72jh
	witP9tZUIfLzjysHXe8j3yG6cethkhtSyJSeniQSZN97pmVBThQp
X-Google-Smtp-Source: AGHT+IE0l9XSqoK/MJt2WGJVHE0pf1Cpqs08IgTd2WW2CgPkEqWoEJ//9zQqw6Fz/jISYRbbMQ2wLg==
X-Received: by 2002:a5d:4403:0:b0:37c:cd38:c51e with SMTP id ffacd0b85a97d-37d5519911emr8465822f8f.1.1728990407867;
        Tue, 15 Oct 2024 04:06:47 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87775sm1288894f8f.27.2024.10.15.04.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:47 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 15 Oct 2024 13:06:34 +0200
Subject: [PATCH v3 1/5] iio: core: add read_avail_release_resource callback
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-iio-read-avail-release-v3-1-ac3e08f25cb3@gmail.com>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
In-Reply-To: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
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


