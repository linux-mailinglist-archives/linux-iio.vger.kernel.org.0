Return-Path: <linux-iio+bounces-9713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C297E3FD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC91F21533
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D46126BFA;
	Sun, 22 Sep 2024 22:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0eha6bM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198D84D12;
	Sun, 22 Sep 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043486; cv=none; b=Xh9LCzNAdt04lhfoh/0niWm8uJqqhC81SUdN0CLyLh+9y35LWEfrh9n41b9Y1Eho1d/72eyEG3r6QJ1QRCxbikVo5tR26L16pQcYqrG6diXcBaf6P4rIhBsjOko5eRUQNNmFUangj+A7htH/kdlvibVU3weaqmXgjnSCFjyFuZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043486; c=relaxed/simple;
	bh=C9SaDL5Gqy8FxtoCb/1ZeQNFzCAM9ANHOsVq7eulza0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLY5xtRWh2tABvhQXk/hrwe6O3IKE3zCP9pRrdmP19jFNdKJ119W9K/1wexMnBrJh15XavXI0qeYNu6BeLUs73hTUeTrDYA4AdpGViQgWLUyyyXtl4enIXXytMlVCmHeQ/rILoxDKKHKRVF0fPXrV3EbfruZu0OVcWxFumKWyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0eha6bM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so533611366b.0;
        Sun, 22 Sep 2024 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043483; x=1727648283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6CY7vwzy9oj4NQxVHEf7BN3LYzmQ5EROEyqCGIj0cU=;
        b=I0eha6bMcjBn1nh64TNtw+9c+IkIbK7aDQvDcRcAkBn7iX/iuAeaQvM+qbLg7KqpUn
         B5uoYBWsDnKd5XGYIBUrkCFrdlX9nFKKQxVsOzLwcO21Z1Zl7rF+VHkWPpGIDArhn82R
         zMkl7AiF6//8qDsYaHb5gOcGzQBSfKtaZmgiECmYuhtX6NP1yHrZuTllzWRLgB22NPSL
         6NUKSw/V1ZlxbBD2v9ai+osR7rarWLXFAWMZ/GMYbc47upFRytnkjMWLxLxi4RHPBuQR
         Z1y0rzPl7FjsURod0zKUy2eOICZdHvzCIdTUZEAF0YUxwQRUREAxSuN4MS+OlxXjwlUG
         F83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043483; x=1727648283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6CY7vwzy9oj4NQxVHEf7BN3LYzmQ5EROEyqCGIj0cU=;
        b=o6qSFbivic/+9y6VWq4gYxfXgH/eIulfAGNE41cATYqzUzZ8iEtDCSWuqm5DM1Sd1n
         31MLcR/iP7JDdYaLCgt9sisw3sPRZ29Y+iNSox4M4j77GYFM/s9n6m60/zvG5QzcT5dR
         4uGRQzDKLSYc29OXEqJIaXqeAzPRjdX6pq+ZzqogGdTOUnhn5BSjmJ8n0sQ3ONQb8k2o
         k93HBKyT6MJxzAwTbcylS99LaITVJLEMM4Olfwjf4gJJUVMtzeReaPIayvp+LPHNLLLV
         uMXcPOW915Ss8OT5Ho9YlfMK8r3FDoUXTO/0hU/2NU/Cc3m0OrEq7KA+OaOG8w5JUBgF
         Ozlg==
X-Forwarded-Encrypted: i=1; AJvYcCVJP9lCMjXITqQuEzMfRhMx9xotxe5pYe6iI3H7obVCMYhpESJD/guirummTfVmLyMLAFqKTPkiD1FI@vger.kernel.org, AJvYcCWjHibS+ysyD5HlV1daTqz4sKB8mVRAZu9lRw8R58qXaXpYveBWS4YZ+EEft8d18GvK7AoVzeqeaa51cWRn@vger.kernel.org
X-Gm-Message-State: AOJu0YxeI9Ebkgb9uqW4yDUyJZlTul7Hzo4R2cY2BKBRA2i1jdAsd9Rq
	p+vMaBUq47Mq8zTJ/G0pDS1KLGoZrs2DgdwpoiYByQk3JhHUs/o+
X-Google-Smtp-Source: AGHT+IEqFjddnEcpeG9ysMM/Unt/qUQjLCocbjjPRsQsqCSihMIItEAfmn5W73jznkANokk5WIePGA==
X-Received: by 2002:a17:907:3ea2:b0:a90:df6f:f086 with SMTP id a640c23a62f3a-a90df6ff2d3mr914225166b.11.1727043483369;
        Sun, 22 Sep 2024 15:18:03 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:03 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:53 +0200
Subject: [PATCH v2 05/10] iio: light: veml6030: add support for a regulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-5-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=1203;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=C9SaDL5Gqy8FxtoCb/1ZeQNFzCAM9ANHOsVq7eulza0=;
 b=/uzQ4zQ1pyoMJTsenjj/ZKF+rAbSZz712iiWKPprjBjKX4OeoBTpm64gsRnHBrsxpETvRSMeJ
 i2Bf1DgCse8ALAMJ0epZdF3NNMNnet7cnl3pJrY/bhyPFviiyIYiL5b
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the device managed function from the regulator API to get and enable
a regulator powering the device.

Use "vdd" as the ID to account for the provided name in the datasheet.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index ccabd4c844e4..89c98bfc5191 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -14,6 +14,7 @@
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -807,6 +808,11 @@ static int veml6030_probe(struct i2c_client *client)
 	data->client = client;
 	data->regmap = regmap;
 
+	ret = devm_regulator_get_enable(&client->dev, "vdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable regulator\n");
+
 	indio_dev->name = "veml6030";
 	indio_dev->channels = veml6030_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);

-- 
2.43.0


