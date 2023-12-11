Return-Path: <linux-iio+bounces-817-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9880C9BE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 13:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671AE281D8A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Dec 2023 12:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3D3B2B4;
	Mon, 11 Dec 2023 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mheZ+JDS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C01BE;
	Mon, 11 Dec 2023 04:27:58 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso59554a12.0;
        Mon, 11 Dec 2023 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297677; x=1702902477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh2d4eIQQpeZhqaTpIu7fiK0w7WGTGpR/zV0sJF4iLA=;
        b=mheZ+JDSfPxyfrUeBR/ZCpUThmxNTY1GBijL+IQH4SyQmZLz9S5rEBzTnQmzyQ20xO
         KpbkpXNm4LYitYZfYnbmdzW/WNqQvT5vk5x7ERl3DHImThRLl8i/WPgN2frog9+mxzjv
         bjO+VMFH0iFUSC7YxWOpszS4r0wtN9LC4vbLY0IEJJC1ZlfY1Wf5WA7EdgrS77h7MLtg
         P9/S4kPgaj/PJlB7Y7EkpmmBJpnMnEjumNs6FEV50YiAgbtcY4WBD6h/hVa4JLWIu7IB
         sWIoul0sOHqrfz6qGCzAKz0Nfn0cRCcD7LJVuEf9xkl7PIvCIFKqBPl04agYXrxSva6O
         PHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297677; x=1702902477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh2d4eIQQpeZhqaTpIu7fiK0w7WGTGpR/zV0sJF4iLA=;
        b=YWYpLaUkOobZNA1ZCuqdcGE4/uzx3TulIti3EfgoRwP4WG1MxXHZNIhG//A/SNJ2s0
         OCjhwO5K296NI0t8f6Xkk3UiqeGHWsV6aBbgE+IZHJzImtulXRJkgsCHw+fovCGu7KnQ
         OuiXwjekECfSrhCrV6hvkpHIFYPesMPcZzcmjeP8XT+M1JvrXc3veZwrPmLRIzGcNZvV
         cEzFahIHpkdkSCPFTr5uv4nFJfbNPiA/w9mBGY7Se45lUKImkWquMsrdpV/+igVcU4o6
         0+vjZdJJ+9tddR+MKE5kU78redPS1QOGA8/3aQxsOkAVFiDqiOkgZN7N168PZzAQltpZ
         Ze7Q==
X-Gm-Message-State: AOJu0YxkHHLIyN3e2o1bmxR0RCL5JhqwXMjE4cOF6xv0sdoPVJsgyhVB
	4YyCk8KN7TVdbpo3tLreuVmPJnfYhkVVgGG5
X-Google-Smtp-Source: AGHT+IE1TEJ++VWCi9AftDuGLa6dUkkntlusw+w0FMs/RT6hY2YzCnxHcDlZcQ1gRnxhwHFnlHCVBw==
X-Received: by 2002:a17:90a:d407:b0:27c:f309:f381 with SMTP id r7-20020a17090ad40700b0027cf309f381mr3117162pju.6.1702297677385;
        Mon, 11 Dec 2023 04:27:57 -0800 (PST)
Received: from dawn-virtual-machine.localdomain ([183.198.110.72])
        by smtp.gmail.com with ESMTPSA id r11-20020a17090ad40b00b002868f5c2847sm6834746pju.7.2023.12.11.04.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:27:56 -0800 (PST)
From: Li peiyu <579lpy@gmail.com>
To: jic23@kernel.org
Cc: javier.carrasco.cruz@gmail.com,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] iio: core: introduce trough info element for minimum values
Date: Mon, 11 Dec 2023 20:27:47 +0800
Message-Id: <20231211122747.9723-1-579lpy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211122201.9598-1-579lpy@gmail.com>
References: <20231211122201.9598-1-579lpy@gmail.com>
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


