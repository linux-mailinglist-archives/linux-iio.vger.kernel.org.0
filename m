Return-Path: <linux-iio+bounces-9721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A366597E490
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 03:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22AB41F21642
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3E1FA5;
	Mon, 23 Sep 2024 01:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoTpRVh7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485FE9450;
	Mon, 23 Sep 2024 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054356; cv=none; b=KmIBt+2gKaMKYml7ixDYVNvwAo5htdMDfcAUGNqKwthoB/ur2nI7oCCc8nZrzrhtUnquLRIotAy/bJPoOov5s27pnzRGjIiga5x47yIEWJpYL4Vx7cD++LUQ41C2OM2GiQINYpxHQnYhti+LtwMyZiSJKmQ6emibMaqy1spsV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054356; c=relaxed/simple;
	bh=KStoEX4Apn8xxS3E/SGC47/J8beTo7X55A2E0bNdFGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdWUdLIUrVpCWB0CzS3Bc01Z513s0JFwNVEKJ2RSmZ/KsPENCG1Bhjk7DgoR2GS8UxjipBtKWvkxbwhYRJUmrA5HdBG6bMAUiZu7o4u+JklyjDGKmjnlbcpEW3f+j7T8YsFArXXD/nVb1uZTd4u6WR0YyAsWGQyh20LYl+wNM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoTpRVh7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-717839f9eb6so642367b3a.3;
        Sun, 22 Sep 2024 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727054354; x=1727659154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X51HK5UxBlOj57NVe0MqHbD85kZB4QtxGMuHxpmIE8w=;
        b=NoTpRVh7c7BZtG6O54n4VFpGKajVPFnS/FMnzS+KcrNsCUOEztNhriiFIBGncKfZj9
         Uvzm5XExmjgv4LKpNqLZodQ5prJdPJKCkrTZLn9+Z2J3GNJzGtinXJKXnnAbiZg/94/J
         e9Fa5mtZ+5+oZc/aYjGfMe39eX+KCe2kZRwEPbYSRhyEZ4VK+lxtzuMxkkRwZVI3ghL6
         zfUIn6OAYuZzO9Cna8TJT6wHXqIG/rC5OXH/fbRu6eZsMRYU5cg5zxgNQS/cvSIKw/tp
         3ySrkiw7A4jmTCVkfupNporQMme+uhh2lFJz5CP3qacZa7ODbJUig1/lFiNG2lI45e7+
         dmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054354; x=1727659154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X51HK5UxBlOj57NVe0MqHbD85kZB4QtxGMuHxpmIE8w=;
        b=MwJEKpqOSiJDlIoAKWRKi6a6CzKBHFw+XymE8bNhftCZIoRZSmYf4vqiCGtEFDJi4+
         A2wwHspAj2NvCDQc5k0RyvRPTYTcuGqmgnZLqRhGge2KyFIvc1TaO9wJ5b8ux/cciEsy
         Vz6hXWmkEr257vDje5dla3eM8gFRdG1xb1pWU6iFx1LiLYA+BRrYPO37sx3RZeSHBsY0
         o+5n3+dQMefLrw/DSLdQLQUZE4OS0ysaeXP8baMCm4OwwZeWNUCjMjzfPHH6LeZ5Wk2P
         dcP5HT/VcSZ5IAlLDmU/ofsgeulJwFLu7lIiNkZdORKxNm3CQ7kBBVfqiwbzZcwlTq1V
         OtMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3+N4ICI+vkHLc6QnJoUadPTnqZm6GCvxm1vOqcczOG8z8A7ZslkF0BdmwhwvcBEsHAQYiEhqNmKWY@vger.kernel.org, AJvYcCVyv/fHw+pGOPWWbgto9qjTOjBNqiGm3QzVbe7mXJAR4o8BFaIudQDc3CrzQC59x8KUCrqM8MsNtsIlQ5Aq@vger.kernel.org
X-Gm-Message-State: AOJu0YzdGu8InDCtzl/nicgjw7g7IqRJosd920zw5sCAKF9+y5YMeciF
	T1+9pAvpECBu2wTMkxhZGU+SRztk8f0epNj6KI44HhHyXT2Y+jyqcwndG0dJ
X-Google-Smtp-Source: AGHT+IFLiTm1FuTDC4CJymAkPcobJwQ+Glfo1vOI2+YQUF+3gYFVcQqjAm/mGwjqHmp9XC+RoqeODg==
X-Received: by 2002:a05:6a20:6a26:b0:1cf:3be6:9f65 with SMTP id adf61e73a8af0-1d30a752ec4mr6757274637.0.1727054353964;
        Sun, 22 Sep 2024 18:19:13 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49920497sm14408888a12.45.2024.09.22.18.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 18:19:13 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 23 Sep 2024 09:16:11 +0800
Subject: [PATCH 2/2] iio: proximity: hx9023s: Add performance tuning
 function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-add-performance-tuning-configuration-v1-2-587220c8aece@gmail.com>
References: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
In-Reply-To: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1973; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=KStoEX4Apn8xxS3E/SGC47/J8beTo7X55A2E0bNdFGY=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGkfDrH/YA9av6x9sepDdW1/3vdZ3Nrm0szJ0sf+HV+jm
 6zS8fNJRykLgyAHg6yYIsuZ129Y81Uf7gn+7ZoBM4eVCWQIAxenAEzE5y3D/8T41w+W927wy530
 4ZqPnvDTf/NEPG1/8chttepvOPtdZSkjQ3+VQ+Xvq/3a8REfd+YHSH/iuS+a/e13xWPnm83Z21W
 mzwcA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 8b9f84400e00..963da240c9b9 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -582,6 +582,39 @@ static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
 	return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, data->ch_en_stat);
 }
 
+static int hx9023s_performance_tuning(struct hx9023s_data *data)
+{
+	int ret;
+	u32 i, len;
+	u8 *reg_init;
+	u8 reg, val;
+	struct device *dev = regmap_get_device(data->regmap);
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+
+	ret = fwnode_property_read_u8_array(fwnode, "tyhx,performance-tuning", NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	len = ret;
+	reg_init = devm_kmalloc(dev, len, GFP_KERNEL);
+	if (!reg_init)
+		return -ENOMEM;
+
+	ret = fwnode_property_read_u8_array(fwnode, "tyhx,performance-tuning", reg_init, len);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < len; i += 2) {
+		reg = reg_init[i];
+		val = reg_init[i + 1];
+		ret = regmap_write(data->regmap, reg, val);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int hx9023s_property_get(struct hx9023s_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
@@ -1045,6 +1078,10 @@ static int hx9023s_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "channel config failed\n");
 
+	ret = hx9023s_performance_tuning(data);
+	if (ret)
+		dev_warn(dev, "performance tuning not configured\n");
+
 	ret = regcache_sync(data->regmap);
 	if (ret)
 		return dev_err_probe(dev, ret, "regcache sync failed\n");

-- 
2.43.0


