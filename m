Return-Path: <linux-iio+bounces-10265-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008E799271F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA46280AA5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB118BC31;
	Mon,  7 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO37YK/o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DA189BAA;
	Mon,  7 Oct 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290282; cv=none; b=tF43dN2LqoTGoQ9uLY/nEAQ75gUAyMTEcARib/447peeL3LH7tPvKOcNA9/URZ5ld0Iyq7QPtIWHwr/wAsuuXIOBdESnvNezcokYoCHh194GhdBp8IOg8LvhpnpVtb0P8SEeNZF2IVEWe5oyNLIOunMsKilL1g0YedrIvKei/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290282; c=relaxed/simple;
	bh=7Qd7pConDOask/BNXfSwFweuyl/4yUcBzrozpeWuKdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EEAbYcNUuTDzD7atiMTjoV2Eyi1UiHghB50dEQ1rFN0aSuUrg2IS9kjWqgEtldnQdo5rp8nvkTuZMW5+GeQB9WkJSBb57oNPPqmkSq3eC3JwrqhVQfE0q9o+LoItmlF1cz3/SIxWpWzZJoaRy/z2wFr02Us4fpp50BWqoi+akmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO37YK/o; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so477773666b.0;
        Mon, 07 Oct 2024 01:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290279; x=1728895079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h4jXiLdPt0pxESQJDinZHqz2wgnSDllGc714nCDCUQ=;
        b=jO37YK/o+SfXJwkfwmiPKTlqtSgjYDVQNQKH/cVQjFZ05Jijn9z60tguAEsKXb0BhO
         /Hp6mZMojsJ+URIZwOWySqHKJqpl0x30b6/7rBS7hT3E+Wegl3xGVq+qe3odxgvXV0+v
         eHXIeNqJ9th5HyKu0cJwsVxrcVg0dN2NN5TJ3MoxIzmFBBlkNs8zalgPiRE621AI6x+l
         0rgZBhHZiKISTTidpVO+bYrpDDI7fJlaQ66CQFOUsZfJeNYhBvzhSBldezs6zHzpmavw
         uWio26sdYHNO0SM2rIbifMMDYOEfOjlyu11Q7fgeof0Wxyqj/KIXw8EC9tU/C0Hz/+BF
         ZdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290279; x=1728895079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h4jXiLdPt0pxESQJDinZHqz2wgnSDllGc714nCDCUQ=;
        b=ZZ9nO7D9TrzLRuLstMW/d2kp3qV8TvTz4tdNjBQIRppV3PLW1sHX2ggjkR041vHoq2
         AyuDNEM7+Lj9pvkSKQ5T8TcH5/oDaEDDvPaN/bVbXo1uwxJMm31vDTZ7PM/c96Js0t6h
         ADxZDiAu/WD+1C6mWswyy9Oas9i8qGwMlRP4JYmkLroy9HtlGPYhv3iu4noS0XbAsSZW
         u9+JXHGXZ5vF/VG9zRnk16dvsGqQYa67X4olPSq9pYSNbDA7y9mw6//Q7OFnQUCWHT3b
         OKCDwJ40xWtZQ5y7FeT02llPZxXiMIwUhd9wEZJuSN7HScwB35R22xkCOW6TMLFCawRb
         3z3Q==
X-Forwarded-Encrypted: i=1; AJvYcCURHKsRGAZTXU24KfIK8/b7dq45YxI7C0aAotgy7t5yzfqDoHd29Qu3WsobbYazZoyM0Fep9AwdiAc5gQ==@vger.kernel.org, AJvYcCV3UBtaYxY33Fv3XE1gp8VtA74q4IahFaqAMpWQpkaLDgBxjNYhVwVs1txxqmLwijxyfuWYwP9TPuc=@vger.kernel.org, AJvYcCWiw9eL+lFAnX6QglithZYmphWpftfO7O4QwZOPLGmG6WyhfZmTZF+gsra2NdNAdcB4/I0L5Ie56wekrSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHcZpW9itvaMVhqvLVlufG8thY7ALIj3zpTN14RRW/E3H1dMv
	iQ5AgLhZpKwT/UwxwFextNTdM1uKMprJ2o2ZD0lilllGDZgkDD36
X-Google-Smtp-Source: AGHT+IHb8QJqDDbymdlp6OK+wtmSQbGb4sEYnd+tjiMcvWc7eKwscGGJU9MQkIPuOEI4D7OO5FB7Kw==
X-Received: by 2002:a17:906:fd89:b0:a86:9c41:cfc1 with SMTP id a640c23a62f3a-a991bce40demr1243863866b.8.1728290279222;
        Mon, 07 Oct 2024 01:37:59 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e625a7dsm350698666b.84.2024.10.07.01.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:37:58 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:10 +0200
Subject: [PATCH v2 1/7] iio: core: add read_avail_release_resource callback
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-1-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
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


