Return-Path: <linux-iio+bounces-9903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F5989763
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99250281944
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90430186607;
	Sun, 29 Sep 2024 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHCRTV2b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7171862B3;
	Sun, 29 Sep 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642349; cv=none; b=Vu3aPBWCe5eObY8/Oo5yNrygx5RAOz/FZg15l9Emhqq9J0OWai+66VqqvYamC/x+HF1X78eQNqzLk2tNEpTFZqVf9zctmT49NR/iSKkvlkdH4YuGZ+y6q3yTKd67j2X6YpAW/5XYpttslAurjnTOgPWmWc8ha/1IErmS8kkcuAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642349; c=relaxed/simple;
	bh=nikxwyB1KSy0wsMXbnH8xFpdMCf+mKH8/245lMmqi5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJlXcvviVEuAFQNLInh0Ufu1n6XCGb4sbSzgJJC696hpeztN7RJYO6x4Hz9MHbhbE+ex5xHItHxdb9j4uwAvPje5p7d5W30DoII4U9SOfGrhrmeZdhhbzhV/UY6zlfdoGjVmDjoGzFO8CeSF8AJ4bzKs90bbkpfNlPMjC+8OtK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHCRTV2b; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c71f1396e4so4587227a12.0;
        Sun, 29 Sep 2024 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642346; x=1728247146; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYZIE0YZeGeQMwblv/AqzD6BdL1SJTh4oD4ee0SlK+8=;
        b=hHCRTV2bnln9Nb6Tfkhn8X9+4DyLYAJ+z/4sRbOF57rPNyRZMbIyb+UANP7g8m96K3
         dwIaxQqjrRMJhhN2hKfeONBCvaH7ws8o7L/91sMA4tr5F2mNq2pD1rxgFyPC/XrMQHxf
         qw2hVwMY59V/tBZCB5AkGMYS6JThuZ7x8nHS9VET0aWuK+HlhlmRddxZCFPcpuBtYxsp
         BO4n4CthyFxqP1oEEPnqMuuHEjQBwsqgjeZAFAgiK56GyfU7pTzd1KHR8WIqqIA5BR4I
         hF2p22grb0dSEhlqeQBu0++Kf98F5ch6FWf3jYX49V+Vu2wVUUfbfkaTiiqn1hagVAd2
         yDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642346; x=1728247146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYZIE0YZeGeQMwblv/AqzD6BdL1SJTh4oD4ee0SlK+8=;
        b=p3Dcimje51WbxRjzAb+wfGmyTlQPFtJY89ZWBwVMhbxbLkFMa4IHkSSf5dPCr6dqT0
         0uDtLUzH6ltZiY/zzEuK/ikdr4aELVqWi6LWnOArjwWoArvZt+ABgBE/Qa8bNeWvt+Tw
         gpgbFwOlxT9PNeXTr8KZ3Wg1gR2Psma5mAPSsoEET8DW2zdcnIhGQ6gVOCClWCyNOWla
         1xZZ0wLVy4A+DBhxEu02PLm3vML/03J1zVABLeMHKAT6JMJag8iRxkbKujjcfXJxGttq
         Ko4G32R1T8iNUJEjbREpAqT9lCOlaRK6LiTvBu6AmVh+R7M9fMSPZ8iTtdjLT/VncwrP
         vvtw==
X-Forwarded-Encrypted: i=1; AJvYcCVFkzxsAkO7GN6mEwvEnzA3z9m8EUjPpP7WaHuflk+kYyhPD7YjZ2W07FvagpSyejTwuauprgL9hF31@vger.kernel.org, AJvYcCX3eqUi01CNHKx5KoF3KLro19ziM5WRYx9kCa+p2OgOgRFKm1zSna6inwqyPacXNHRXWe6PIbWy8DHv9YIZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwridxWiicH+u6WBeXs8im5yGiTzcIMOM0G3hyRZDP9SHh9ipeh
	iPkXRrGj1W/CDR310wGmW1fU68UhtuvvfwrFZrgZGnkkecrwoPjT
X-Google-Smtp-Source: AGHT+IHDHCjPgBpORkOeVnZX+PWdwQZyIprUCxSaxxsKI0QYedP98oHO0HOYosJ94oUVNDjt6ZZFiA==
X-Received: by 2002:a05:6402:26cb:b0:5c8:95ce:8cc2 with SMTP id 4fb4d7f45d1cf-5c895ce8ea9mr2371572a12.16.1727642346039;
        Sun, 29 Sep 2024 13:39:06 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:39:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:52 +0200
Subject: [PATCH 7/7] iio: light: veml6070: use dev_err_probe in probe
 function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-7-a9350341a646@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1046;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=nikxwyB1KSy0wsMXbnH8xFpdMCf+mKH8/245lMmqi5s=;
 b=fXk5tBeALOQQi99O7xzi5Ez+vuMPp40DcbCVWauoQW7Glg2WHGabdjBQam9g1F2BYqIRcjpqx
 ZKYXdy3hWSDC5aHUmCeMVfLtu7Lz3bF9YOd4NRON8RLlzMwwY7+wOBZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop the common 'dev_err() + return' combination in the probe function
and use 'return dev_err_probe()' instead.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 8d02899028d8..6221d07aa840 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -168,10 +168,9 @@ static int veml6070_probe(struct i2c_client *client)
 		return ret;
 
 	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
-	if (IS_ERR(data->client2)) {
-		dev_err(&client->dev, "i2c device for second chip address failed\n");
-		return PTR_ERR(data->client2);
-	}
+	if (IS_ERR(data->client2))
+		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
+				     "i2c device for second chip address failed\n");
 
 	data->config = VEML6070_IT_10 | VEML6070_COMMAND_RSRVD |
 		VEML6070_COMMAND_SD;

-- 
2.43.0


