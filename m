Return-Path: <linux-iio+bounces-7342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF769286EF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 12:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A055A1C21C64
	for <lists+linux-iio@lfdr.de>; Fri,  5 Jul 2024 10:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535B148849;
	Fri,  5 Jul 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeiwXAGx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4003148312
	for <linux-iio@vger.kernel.org>; Fri,  5 Jul 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720176058; cv=none; b=GDVZSRrZPG9JKucqQDR77UVpRMSJ+Addv27CylQc8fL6/PkFAQCh3UhAP4xIf1SUY15p7gR2zvC7VziBC+nprLVLUd5kU6HhtV62xWuXA7hUK3r0GTZyPYDKe5WzVsXOq7e3l5gf3OOpCIzLUHpOhXGwX7Pqs9msqWQZQA8S+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720176058; c=relaxed/simple;
	bh=2JNEEDT0yqg0ZpezS+vJkAIFphubIucu2CrwWdLhExA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GKBPcCKPRHvyyZzgTXtl5FsD/7qGTCAM0RUSOgyKXPMKS2XGM5lN+5+YwnqA7CJEltvpoIgXvYr4twzmd6rx49lMiFI9cqi1ILjX2y2hgBTa5nInmrZjNWr1TrzAQfsTXArj+81aF5gF3AkmuIbNSYbhmb5FgYb9JFPsi+VtWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IeiwXAGx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4265921b0f6so1733295e9.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Jul 2024 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720176055; x=1720780855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPUGB6WWLvSgcH0G9Q4p2N02Tp+SMaWAilQNUIzP9x8=;
        b=IeiwXAGxBTyEnIO9Us4XvDbvXCw7pmEzKczda6qvJEYejW5KjVRFGdOT9EEKU3j5SK
         6+yRVIJtNXmiBXlB3EzG5EXG7dVCnzMLzUIwYpsvJKQXHmKbKe36Tlvs2Bz0hldxGXHc
         vlZnEB5NvlLZJhC/uKKCq4pXmCNQudqRCBmfcwOZHzKCbsFzCgjpeZq5ZtbV78aRdsqa
         FwbsdDv+RohVAcYfk/9TY5nF6H0QoERWnJE0jArtfB6Sz4mAD4fQOeGtvAuhWH/jQgIS
         l7OZwpRr2kXL89X6ZTSFVz+CfOzgSvNa0a6OHZJN4uDwJDb/RtJw0etr+daHXKQhouTK
         YDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720176055; x=1720780855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPUGB6WWLvSgcH0G9Q4p2N02Tp+SMaWAilQNUIzP9x8=;
        b=kijbZk9NfrrVX0bpkvEe/YwEqXmR6gK3YHNYS2LxCpZfzFgIRkqVSyjtyf5ooxpGHu
         0yQNW39oHIwY3fXGDZOUDqLbxAd48E/HQtWGB9OAhsrROS5fbRmq7SvnHqv/rXKLz9ze
         G02goAOC65hCvbzwa8UUSuvrTQowgyEyl6N6pqFSXpnrKBunRJ4YCBZObPs5A4RTlW5y
         A6Fwr9ylsJMNJTJ5BNcsjnKazSJD2OaMMOgqsjzwPY1s840ITidHqbfVXrI0l4O7x4Ff
         dzFDNo9mb0wDhQ+YTnJ8NJ4BWYEoUlrprXyJ48C2nqEr9q7khx25e7XsPIFnJnbm/1zY
         oMlA==
X-Gm-Message-State: AOJu0YzrV/sl+DlnJVxsBdP7/8HS1wSBnezK/svAk17t0Wx1YpBpzTSF
	gkCrF16J/tlxnOgUW7z9NPbov2ckeUvBgRYRtIs2ofc454m0SHcQeAYNXZf5YtpfSIPBBahMUJ4
	u
X-Google-Smtp-Source: AGHT+IG91L1QiQgNWqSWoacLRT/4TO/Dx2hLrfRAQx3fZ6Bx/+xCR5Xz6K+GVEbHWRxKNEP2hp8MbA==
X-Received: by 2002:a05:600c:3b87:b0:425:6bea:8554 with SMTP id 5b1f17b1804b1-4264a44dd7emr27116585e9.27.1720176055057;
        Fri, 05 Jul 2024 03:40:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm8680446f8f.37.2024.07.05.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:40:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 05 Jul 2024 12:40:44 +0200
Subject: [PATCH 1/6] iio: accel: bma400: simplify with cleanup.h
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-cleanup-h-iio-v1-1-77114c7e84c5@linaro.org>
References: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
In-Reply-To: <20240705-cleanup-h-iio-v1-0-77114c7e84c5@linaro.org>
To: Dan Robertson <dan@dlrobertson.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2JNEEDT0yqg0ZpezS+vJkAIFphubIucu2CrwWdLhExA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmh82t2yoLgw7U/d/3WF1lw6Sbpe0R3WznQ7bXQ
 zvidEQNGzqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZofNrQAKCRDBN2bmhouD
 18eFD/99kCbJW7rMBIrokTGQp+teP0OMxk9HEiucDrZMQqy964A/H6w6db7bxlu/FqpIge6xQfZ
 pgShtD2t06mxtvYqI8U7yZJgNkkNoOY8Mzy1NJncQrBuEXHf66NEGrsoMYwpPl31WIGH7LN6EsI
 Ghx3oPDxEmtAAuHBGsEhdCdDzuartmIyR0WnmgMSBT43VYTwVglMAg0Ep48AuxCZnm4PDQD89zo
 bPvUgyFgchmkNQEFwAByBkrlygUVTQ+IPLRa2TlVN+gsau951q2k5VgHgWhtzwqk+5uEWLZHYf6
 wc6adZUHqX43cgbEfSaINs2Mszebw7ONrWbCMLyJLtJsYEAo/UyDrSk8AwM3CXeCzFjkKUE0gem
 N4LryYcpQ0eZ+PKKK/2HL50uDBF+MoMhmJQyOrb5MWFCTQ4Yo54ImehbKCayJSNQg6wx+0fE1OY
 I5KBjLZbj579jh2iLHlCdWNuDwDG6JugmcbLsnJt9D/ZxzDLrGWU3nphOqADk6rOpFUARMuc3ms
 ZLcIPlDzNFu0ntch5S3pAJ5mSW8zKSv65ZGz4qcHkVlVysAPcs4/pKU2ewf0L4x8LOano98sgKg
 /Wp5hbOhQDKwhrdvno18IAYmmFh+9K4rLxikmurZbqTx43Y1luTowQ57+5oh4A5yl4L8c6+DW6P
 7AiqGyaPLAdiiwA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling and
make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/accel/bma400_core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
index e90e2f01550a..89db242f06e0 100644
--- a/drivers/iio/accel/bma400_core.c
+++ b/drivers/iio/accel/bma400_core.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -795,21 +796,19 @@ static int bma400_enable_steps(struct bma400_data *data, int val)
 
 static int bma400_get_steps_reg(struct bma400_data *data, int *val)
 {
-	u8 *steps_raw;
 	int ret;
 
-	steps_raw = kmalloc(BMA400_STEP_RAW_LEN, GFP_KERNEL);
+	u8 *steps_raw __free(kfree) = kmalloc(BMA400_STEP_RAW_LEN, GFP_KERNEL);
 	if (!steps_raw)
 		return -ENOMEM;
 
 	ret = regmap_bulk_read(data->regmap, BMA400_STEP_CNT0_REG,
 			       steps_raw, BMA400_STEP_RAW_LEN);
-	if (ret) {
-		kfree(steps_raw);
+	if (ret)
 		return ret;
-	}
+
 	*val = get_unaligned_le24(steps_raw);
-	kfree(steps_raw);
+
 	return IIO_VAL_INT;
 }
 

-- 
2.43.0


