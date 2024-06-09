Return-Path: <linux-iio+bounces-6128-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDB9018B6
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02870281338
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1E47580D;
	Sun,  9 Jun 2024 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkF2fHIY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91D74410;
	Sun,  9 Jun 2024 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976325; cv=none; b=aRH1l6KC06nW4yPUPIFaxownGP4GY4qZaoX7c/JUhzSujeX7kYkr55EamoqRY57eyOj8EdSC6mgBSXAdU0RJc3CiwKiimBeAK34I1aR4scRXJlJSAq+N782DTQTI+fG6age2R81a4bZDRid8qUg3TO9utJFdMsYjKbhcDNBLWyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976325; c=relaxed/simple;
	bh=Z5vCLOtayG12+oURNPul0+eUnfkY1Ez/Lqwna0p6jj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UDMCwVP/xyKn2RRz/7I95rnbmJR84sJAs/Bzc5zonUZYvZcH8QIkAIA/0D52efh0Qf4lFtJPuW/axwEjfYtmDpESOlspb6eVRHqFnTq+P70FF/ece7Zop0pkEegSU6s6tekN6I/sWz7j5iiuaETykinARGruZKZHREvDzVymyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkF2fHIY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f1c4800easo59288166b.3;
        Sun, 09 Jun 2024 16:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976322; x=1718581122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsbnqsAhFK7wuZ2DJC+e/vk6WotV4BxUYJD8eztjyM4=;
        b=NkF2fHIYjGhV3XlRsGWF/pMiyBBGk6VGurdyQoGQ5u2rPkyJLq8V6bxmZAl967JT/H
         r/mpgb7LQq8EkkJOBu4gtdDIKJ74vCSij/9SKRhOX5ZZNe3Xw7OAKcUjzWB6Sl0ycD6m
         ONO+DuxafGnLY1xCbQ5N5ywgnjaUGz2La2KjVNmzNDQa7Jxv/HojdlykNTmSVZ+vl/hq
         dokhYo3T+b8T55kXRimsPm3kJXTd8FgP0S6cpYT/ZnVEjKmQ7qtyC5IFoJYH8aNsRZxQ
         o97Yk3SQiJSTnoMPie3kkg06XHJIMWaKb0lILGr6vNRjj0iIUcVgCrSyKYPLRflvwUp8
         HVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976322; x=1718581122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsbnqsAhFK7wuZ2DJC+e/vk6WotV4BxUYJD8eztjyM4=;
        b=YR+UP1/RE7Qj65ILcrNR7Xmi6tLzO/a3cZlS81vLl8wqomMg4q1eOHYvS/7mKAq1ig
         RQGAqYNlbcV8yPCYOHL1MBFiKrwnuNEPXS+HTUM6RqVub+wnB9fugzNwC2gVx7jwg7N9
         yZ53vs3VyoN2RoATcNi81LhirDyBcaUM4nH6WBNQzpKYEstI17JwLxfzoFLgrGBtw3wf
         KYqjvdh8f0AxsK/6xJzgsTIm0TGmKS1GSYxNJitW59xTHFyw/kNfVHcD6VfTCFU/aNzW
         r7UiJsOjPIPpEZU8SDjM6KviIJ6NE/kPPBuNaNAdD77xXDxI2tkKfizpApz6Yzb+soug
         6Vbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4CrXhwbrdgcHuk31w0fv41TjgLeNyGjmLDkmIbPv92Fj9Kfzv9H87lUdYtlbdxzxZAxhRhJWACyX+zcqZ15FCqQFaRs5C/tbCN/hv42yKcMekMV8t8Y2fkTnhuo0bVygGKMPSwkjx
X-Gm-Message-State: AOJu0YzGRk2vIlFs1M3xcGzdMMBYD9cWprFNCVaKjc1utHx9IkGeVFsi
	qEMy/N4uyulTT7FskQut/FJu/CUrEH87j4MyYS0Rx73XUS3gxFwx
X-Google-Smtp-Source: AGHT+IElQCic8ok5twKsuh/dSk23KfKcO6iepCxu3HeNIJbYt/XVGNBX1igmIR6WHLZc2gY3NgLkew==
X-Received: by 2002:a17:906:25d3:b0:a6f:18ee:7932 with SMTP id a640c23a62f3a-a6f18ee7a35mr115533766b.20.1717976321864;
        Sun, 09 Jun 2024 16:38:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:41 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 10/15] iio: chemical: bme680: Make error checks consistent
Date: Mon, 10 Jun 2024 01:38:21 +0200
Message-Id: <20240609233826.330516-11-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the majority of the error checks after a regmap_{read,write}()
operation the following coding style is used:

	ret = regmap_{read,write}(data->regmap, ...);
	if (ret < 0) {
		dev_err(dev, ...);
		return ret;
	}

In this particular case it was different so change it for consistency.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 415816a6cc9b..a54460fddc91 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -517,10 +517,12 @@ static int bme680_chip_config(struct bme680_data *data)
 	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
 				BME680_OSRS_TEMP_MASK | BME680_OSRS_PRESS_MASK,
 				osrs);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(dev, "failed to write ctrl_meas register\n");
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int bme680_gas_config(struct bme680_data *data)
-- 
2.25.1


