Return-Path: <linux-iio+bounces-774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D980B3CC
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4781C20A55
	for <lists+linux-iio@lfdr.de>; Sat,  9 Dec 2023 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085313AC8;
	Sat,  9 Dec 2023 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inmjv7AE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A5D1;
	Sat,  9 Dec 2023 02:54:58 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id ca18e2360f4ac-7b6f2dd5633so131279739f.2;
        Sat, 09 Dec 2023 02:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702119297; x=1702724097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh2d4eIQQpeZhqaTpIu7fiK0w7WGTGpR/zV0sJF4iLA=;
        b=Inmjv7AE7OgRB5oBXDD6eGE39F0ExaXNIP83rOJOUM6R9Y5P2DuY4b+xHIx/mmHjIa
         7gE6JPT49n+mj5V1TTj3jzZnwNgrhMZnDvaa4XyyALnQD+pm7Wo2LvTnIw2NsG9MkL5w
         E/qc4ugBxRsqyCwUG02HqSsd5XxXzuw69pFcRDMMLrIOkdzCOR1SbmBMCiNEJzrlbSv7
         Hld8vYvpoekvBSw8r4aU3YJcHPsXgxSojd5kcN9s5jxQ5wa33n8SO94UrGY9HC0tAWjU
         FZE4IF7hE805HVzOZyYJ2118VG2vphjfZz1ZQeVwVKaPgBxiIxvSZ5+BBbx/ImEODO4g
         MBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702119297; x=1702724097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh2d4eIQQpeZhqaTpIu7fiK0w7WGTGpR/zV0sJF4iLA=;
        b=XakYoNib2EtzZNZFlC0W1zOsJo9wTProzwJmvbaBqx8fASkH/UtnwK417/pBQ3FTbc
         GuJrO2rxZgERmZGEFli1hf4AnQMne2q8PMBi9noItxsGvDDCFYTXZHQbcq2654scr0k8
         ckew2qQ/WmR5txIBlCghQnZEKkNOERAVGdTn/FuKqHyCeND2f75J41994Q22xe38gy4T
         qzYwmnTx7mDcmU34GP/kFgscAMmixPlcnl7+UEsjGIwku+0dTOL/MmSoKeBbSGn2rVx1
         tALQOBG8AeLKtJ/BYnlJuKDoGdmQNtX1wH1AJaQVquxty7+AtHA5ERJ/NI3t27XKitEF
         YUvA==
X-Gm-Message-State: AOJu0YynM1me+5dQcfWrO1tk6q+X4PkP9JVXJVqxC10TGLiocGLxqF2J
	A1ojZGL+Pb6gP0AgkbbDAwo=
X-Google-Smtp-Source: AGHT+IEJwcZQCoa9FXfx3Kann2ldxbN3Zhs2QlzLomT5wp7oOXzIx2TN5X3LHs9oFR7tqR36BvGnXg==
X-Received: by 2002:a05:6e02:144e:b0:35d:a484:3d3 with SMTP id p14-20020a056e02144e00b0035da48403d3mr2428594ilo.81.1702119297312;
        Sat, 09 Dec 2023 02:54:57 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.111.112])
        by smtp.gmail.com with ESMTPSA id g192-20020a636bc9000000b0058901200bbbsm3012424pgc.40.2023.12.09.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:54:56 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 1/4] iio: core: introduce trough info element for minimum values
Date: Sat,  9 Dec 2023 18:54:47 +0800
Message-Id: <20231209105447.3695-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209105217.3630-1-579lpy@gmail.com>
References: <20231209105217.3630-1-579lpy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

The IIO_CHAN_INFO_PEAK info element is used for maximum values and
currently there is no equivalent for minimum values. Instead of
overloading the existing peak info element, a new info element can
be added.

In principle there is no need to add a _TROUGH_SCALE element as the
scale will be the same as the one required for INFO_PEAK, which in
turn is sometimes omitted if a single scale for peaks and raw values
is required.

Add an IIO_CHAN_INFO_TROUGH info element for minimum values.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f6a123d397db..9a85752124dd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -184,6 +184,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
+	[IIO_CHAN_INFO_TROUGH] = "trough_raw",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 117bde7d6ad7..d89982c98368 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -68,6 +68,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
+	IIO_CHAN_INFO_TROUGH,
 };
 
 #endif /* _IIO_TYPES_H_ */
-- 
2.34.1


