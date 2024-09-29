Return-Path: <linux-iio+bounces-9898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B60989754
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A501C20B52
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356717DFE8;
	Sun, 29 Sep 2024 20:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlMcTy2A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9817A922;
	Sun, 29 Sep 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642337; cv=none; b=Pv1nHPU0kn+/gxGh8AcoLkqkHXkrqRpqew0hLAA/s/Pg8CTjR/hIvKgPY8VyV8KXVMMptwmF9VdH6sSJcqZQOmURJfSAK3gI536wkUkhe5rFiWKMrv8LODzIRpA3/07MzFAiC1NEt96+Dek8SIYysM68ddYIrARp0hUpCSaYX9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642337; c=relaxed/simple;
	bh=jIBsAq1qDGDYHr2IDSUS9jTUCSQchvkFih2N04M1W2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pITiYqU8wtGsqt4rPAlSplaeR7kt10wBf0Y7pRv4NYh41Z5Dda6qtPhFPhnfi1lUHdX8BL5njD6XJXWqrXtTI4cEjpwVfyusG3BoBS64cvZFSYTx9EOhtq+udLZHL1Uj5UB2VPnS5fN5BVOhBL/pmbcDjzhNAIq+1qT2/tkJ+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlMcTy2A; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d43657255so589909866b.0;
        Sun, 29 Sep 2024 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642334; x=1728247134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM6JVtUjqMJf6niC9kqfqAofxw0iLOFDnfwbGtgaJq4=;
        b=WlMcTy2AyHdyvWlN601K9S2UM/hxHeNb8fwCZuqI8TmNLtfrjrfJcqAwO8zK++SriK
         h0oGMuXm/GRipG22HXi1Acqyl4Hha9nDmGNuH8+Zqxb7UMh/7gEwh5RqHA+HgrF8cxEp
         AaXq/svIM40OKQTskmbNVoOq9RX3djmKoYwCYw4fY2rSSTRBxWixfm+0JNdlCq/RsNTf
         124WAbWmqd5WdmeZoXtmiYtrGZksb51KscavSreG2UoAEDtaCyJkjCDTDy7ur/wKtCcV
         +Be71Qm1Hvi+9VexAZf4P9eIaWPtKEt6SxWbS/zaSbDjOlMqN0Zm5cUQzxwIR1z1cmEh
         uPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642334; x=1728247134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM6JVtUjqMJf6niC9kqfqAofxw0iLOFDnfwbGtgaJq4=;
        b=A7Rup9m4EEYphlk0SWpE0sxk4/AFM1q1H89zjshygiwGqk+fj2UyMY2H2gWACPOjNH
         hzhBTY/tUW6XZ3foWhlEZxYJlfzi9SoBbRRCqmiRgYYFMuk/PuYkDArJLz7Uvfe18pAy
         k0GGrPXtlMEAqa7KyuzlBAxZaC6dD88qneyMRuOtT4p1d/BQqbaclNJGPEWACLOjQQd5
         ogeraMxA75+z68PU6wKqX4ZOwu8oXe1w1KvDMG/8QZIlsLdNP9xkDpIdszHXAGapDJ1g
         v6iYWSFU8llfXwKCCY6sZ1Q55LAw0UUbwPESGTljKl501yLQBSOZoxxHLkQna4yCjKIT
         JbRg==
X-Forwarded-Encrypted: i=1; AJvYcCWF593vMPEy696RwusJEiMihiE8ay3dncBWHRTDJvvs2LLQzv2JB9t+rjlD7Y4kC0aWotUDkIseG9X1+ffB@vger.kernel.org, AJvYcCWdanSpuEWv8GMawr8AyM0MmgBieydq3FgbfGEGsdkBSgV+l8iLHKO6iCp5uD5VZe54pfEJU49EoDVH@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8Li98LrS2iV+38PrjFz4n/GrM95jJ08Z8ETw8TnaeUkvpsEb
	iWOo2OOXUZ98lo1PVpe4XmBy4uWVDiJr4Y8JWrTfbhs/n2MQSoiDFh1vVzFV
X-Google-Smtp-Source: AGHT+IGUdBzdwVetrQsZC32m66yyO4n5IFwJ7k9q8iloEFfQQwyzHCdbdnQXlGKmeXbKTrlESR3NBQ==
X-Received: by 2002:a17:906:db05:b0:a86:812a:d2ca with SMTP id a640c23a62f3a-a93c490a0abmr1041266266b.25.1727642333791;
        Sun, 29 Sep 2024 13:38:53 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:38:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:47 +0200
Subject: [PATCH 2/7] iio: light: veml6070: use guard to handle mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-2-a9350341a646@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=1437;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=jIBsAq1qDGDYHr2IDSUS9jTUCSQchvkFih2N04M1W2o=;
 b=8JJmmQt/55MjwbZ5YMqbgYGx9gXI3SOo5rStmwtu7uKzIGY/CblIaHkCwjnRMKFIjiXe1L1uN
 RduH9JdIEmJD3UeypPO1R4tj3VYZjZxiQBgyqHz4wvVtDxPMNKQIUJ+
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simplify the mutext handling by using a guard to automate the mutex
unlocking.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 3c476b6f6122..945ef58beead 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -42,36 +42,36 @@ static int veml6070_read(struct veml6070_data *data)
 	int ret;
 	u8 msb, lsb;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 
 	/* disable shutdown */
 	ret = i2c_smbus_write_byte(data->client1,
 	    data->config & ~VEML6070_COMMAND_SD);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
 
 	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
 	if (ret < 0)
-		goto out;
+		return ret;
+
 	msb = ret;
 
 	ret = i2c_smbus_read_byte(data->client1); /* read LSB, address 0x38 */
 	if (ret < 0)
-		goto out;
+		return ret;
+
 	lsb = ret;
 
 	/* shutdown again */
 	ret = i2c_smbus_write_byte(data->client1, data->config);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = (msb << 8) | lsb;
 
-out:
-	mutex_unlock(&data->lock);
-	return ret;
+	return 0;
 }
 
 static const struct iio_chan_spec veml6070_channels[] = {

-- 
2.43.0


