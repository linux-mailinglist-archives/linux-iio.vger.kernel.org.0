Return-Path: <linux-iio+bounces-9897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAE989751
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F2C1F21793
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3016BE0D;
	Sun, 29 Sep 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBx1pM5p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4B2AE90;
	Sun, 29 Sep 2024 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642335; cv=none; b=s56i0ZY2Zz3WKCnfteJ29nPr5q85ZTls9PRSVdRPj6h0XEa4COddbyxmM+QlHCdxAvcXSRFZ+m3GY4UN+HGhVxZgnA0Z/X3jIK6WONP8Q46TM3HA77hmxe1FVKcDP6g/SddycoBQ/8bjxlHILk8Y52PQ3riI/k7gnlvnC501jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642335; c=relaxed/simple;
	bh=PS84KGlvp7AflQAyoQJs6pFrBW7fmCrzJpt/+luR1Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uagviKgPIkRgoOrZ4bVzzdQ0tTOe/n7MaRoXWBg/DkgLWiR5mYGvpvoTMZThgxEUlFtRAzhvlQDJuzqxlEzx714jfPTliUZ1lqUJ8wCbxRwZUUZBhYuCZMxPZeE6H2pHtQPErFKfkQPkkbxyBTyCkSISp12YcWp8Jn6Rp0pMDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBx1pM5p; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d446adf6eso636921066b.2;
        Sun, 29 Sep 2024 13:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642332; x=1728247132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuaIft20Ql2rSmGWWdOJTX9VQf3hfQ2B1fumcjgC0xw=;
        b=JBx1pM5plOkIuDjWUpw57yHk4e4uCsbsDm14HijJ6/cujs53KRYWNtqIepkRkJ6x8P
         vyONnxh8kt+6DXCNFg5HZMXPCyaxExlEZPO9jq4ES0FeqC1XvAmGAm80mhwIGfCOE013
         QDLAo9UmXlHg8STPkh731Fd3EFs2EPuhR0lvHpESryBZz7N23tvKeJe4wUp77YRG4pCT
         DVpmZQb+PZnPfdNjMuUIIt4x022VcoPiphFj7WdsfbcO+cGTCmu8tvPWcm2aO1ZEh9hi
         HQFGTVvq2AVrQVfmRmqhonMhRKk2PnTP3jDiNV77NexnXHTD3fIyO4syj0MmborOWVpi
         KJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642332; x=1728247132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuaIft20Ql2rSmGWWdOJTX9VQf3hfQ2B1fumcjgC0xw=;
        b=ARQUrcIco81SB5mHaIhPdRnDBGBQVbtqfvsQ1zNAen0gdCTMB+SyyiwY5t+WsM3gQv
         DaNtdYeV68o5ZOHIxIDpGBvCdIzvD21rkhOGMApQM37H37MXBf1aW0+V4PGKaOjkcss5
         aTpqOcZSFClT/Luzwdos7GoXghLj/HGiFg/k/KdWjcEy+qJJe534RW32WxklvpOW0i8A
         8wWpFxg40ntdaVidwX6jTFNQLPsQefwCD4pGDDaXQYKzSENT/GZ8XXMzh+L2xf6i+LLT
         6xCGkRdtQki9Ua6bYjGQhWKBxxSlRzvOkS4AShiXw1QiSCba1W3cgXvw3/WJnL8LmFvK
         w6gg==
X-Forwarded-Encrypted: i=1; AJvYcCUF0XGSlH1SwBxQMrDw2V5Dc1Pq/zJGOYdETtzHJWyIVSoVuu1/PTIe+Y4AqkafoS6pGBl6hZJLSUBFzL2C@vger.kernel.org, AJvYcCVAtPf2vSna9LtBVyatC0iP+Dl1996sUsMj9TlIsIdHShb662av5A1p6qHxKDPOm06sqPbt/lSfFlBn@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNtrhMBqaMZR9HAlzCGbFVVN7SuToVAMdks7evD8YVyGibuNW
	9JRSbh6FmY8ij0uRmu5vknGiMzEABojnIdxLsDmw6IOQZBx3Awm9kCmKpsqo
X-Google-Smtp-Source: AGHT+IEAzmAWslIqpsVj/X4D0eCH8cXZKZi4oo5mO/bkyY01gkyzuLCx3QU6TfHDPtKAj/2vgYxMYg==
X-Received: by 2002:a17:906:d553:b0:a8a:87d5:2f5e with SMTP id a640c23a62f3a-a93c492a596mr1269147166b.34.1727642331683;
        Sun, 29 Sep 2024 13:38:51 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:46 +0200
Subject: [PATCH 1/7] iio: light: veml6070: add action for
 i2c_unregister_device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-1-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
In-Reply-To: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1726;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=PS84KGlvp7AflQAyoQJs6pFrBW7fmCrzJpt/+luR1Gc=;
 b=kadRFgaTHFj/1zfh5zQhsWePXmTaBiCh/wGWOH2YFZbiM9NZJ5AiwE5TB/OUnnTp0HxzqLLSh
 JZsgRMPqMCoCtMK8RKx8MEgUiSJcCbZfy9XP+AV3RyaGdqiBzK+1c5W
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simplify the code by adding an action to call i2c_unregister_device(),
which removes the need for a 'fail' label, gotos to it, and an explicit
call in veml6070_remove().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index f8321d346d77..3c476b6f6122 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -135,6 +135,13 @@ static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
 };
 
+static void veml6070_i2c_unreg(void *p)
+{
+	struct veml6070_data *data = p;
+
+	i2c_unregister_device(data->client2);
+}
+
 static int veml6070_probe(struct i2c_client *client)
 {
 	struct veml6070_data *data;
@@ -166,17 +173,13 @@ static int veml6070_probe(struct i2c_client *client)
 		VEML6070_COMMAND_SD;
 	ret = i2c_smbus_write_byte(data->client1, data->config);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(&client->dev, veml6070_i2c_unreg, data);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
-	return ret;
-
-fail:
-	i2c_unregister_device(data->client2);
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static void veml6070_remove(struct i2c_client *client)
@@ -185,7 +188,6 @@ static void veml6070_remove(struct i2c_client *client)
 	struct veml6070_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-	i2c_unregister_device(data->client2);
 }
 
 static const struct i2c_device_id veml6070_id[] = {

-- 
2.43.0


