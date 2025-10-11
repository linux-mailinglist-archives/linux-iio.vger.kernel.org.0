Return-Path: <linux-iio+bounces-24935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EBCBCF1C7
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 10:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5BF189C3FE
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1076229B18;
	Sat, 11 Oct 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THY1O+A4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE151D5AD4
	for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760170323; cv=none; b=iekoNS/QuD4h3R7k6DSY1Vn34S6/aLZtpijGi+jiv+xxA0WjgKNyAGLAr1WMfoThiZ6c/sfqFdUUSqdg4bZJl7bF67Uco7gHHN1Jn1qtUsWO0494e6FRbJhe52SuIOGHKagcV3bAiVad+sx07h7/jgSvfium06QvmvLKFMwYFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760170323; c=relaxed/simple;
	bh=l3dtsTPKD7ja5cSlZm3nj/yE7IouGfzVBuBNzd5/+ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eBM7cXMyoq9TMRz72VUhfZz2U+UDpdVr1Aqlk2R8GchE0r1CzGJnQVKXc2T8mknthL2pe3clDehP1gw9bsx06JA4vQTpAcfNLh4iZdFxW8gH/mGMTdJF4KxGnhEri/qsIhlru6KUDdXZ5+9lvu2WUMBthb9Rl4S7uJ633x+mc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THY1O+A4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e44f22f15so394151766b.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Oct 2025 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760170319; x=1760775119; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Flr129UWSX8SXF7pjdsaqgp5u0n6XRVU1xssA6urgzw=;
        b=THY1O+A4gmScwnrEx3lfPhyqzfU887qzdZSMLGGe172dS1PZzW0ibbJDe4y8yZbXUp
         Ir4i21lRJdFw+zXVSr/Kv19ZotY67AIleHhWgQ6gyKLfEGziRAgV23Byb3H7EEmhBc3t
         +BxZ53WP5k9bVpNQjTR9CRYK1bH9BJLqFVt25mXpJrPY5JToEwCOxkS6Hjl2a7CTMI6C
         KAw/jfQ92SQ8E60oPp/umujRSwQ5FcIECB4eWS+Jr6tDUxaBtE1YDdD2Vn6rxwQpLSRp
         9ekCRGk6Ctj4oG/DWX0IrwEjbUaWFuea85YqjwRSqHihbnxaL06DgZtYyHfFuyaSqj+s
         xCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760170319; x=1760775119;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Flr129UWSX8SXF7pjdsaqgp5u0n6XRVU1xssA6urgzw=;
        b=E7eyIlO3nZ5zpZIX1PJkFAUq4s2LRhfMdb+uRLJnX5fPYgluXbn3oSZLiqzYtSlBP8
         7578Nbe9FLgwGMzo19Ld0Qm7X5MJvKaN4QQhrOhNruRIeymr8i1CU0XeyNkWMo1/X0/6
         FHs5IhRWMYUTUtXSsRAWrqEtCsd3uZJleRiMSt8E7Jqzv2Kzp8SvnUYFcpnLtf7o7JZD
         Juwv0b5ZhcHjHQb8zuAdQ5sWzGb6/qQObrh/0bV88QDIpyDMsQYF6y2H5i/sS4NFThj1
         x3f1Y0Vt5s8NTHAt7G653ugttieb5LWUHr6M1feNoMD65H0YYMLbRmnfK4KJVt9n/SUu
         1jdw==
X-Gm-Message-State: AOJu0YygrnbZhemknanmiVp0N5JlriZLLrNj6W3mi2qB0mxE/76tYshh
	mAgSiUyRqOVNesWiseGOJtTwsd9edvFHo7qP1CuQ2pLFVI+pXUPavK4P
X-Gm-Gg: ASbGnctaF7tKvAN++ARpZRrmhcRvQRhJH9b24mf5jVKemViLiU8mgt+X5AnmrFoQ6Xk
	mYHZnrZD+6ha4Tbp5sYHX6/v21MkadJzVusRa/BSgUVRFDrw5qyT9S8pUyzTHNtwXcsXJYWXDKY
	wLfX6//eB1gYIljih/M/bb5j8DI80aSdpXAVpyra+wxfvARx5wTiP+X7E5e26hivrFTFTFN5ldx
	EfCK4LZpuKNK3I05ghuv45k6RTwEe7YWHUR3OErt8+H7GvJ0AR2d0WCXHb0PBUsVRjeQHHg2jBw
	aL7nSKcT4Krstza6ziAB2WCLp5C8MtXMZ8ykd+WVdXgMwBgwzMP4cNyMebnQJAaO1HJuYZI1s0i
	izTusxQ2NsQw+F0BWPcnBZsWOaaK2xhsbNevFzp4iBppTUzZbpQ==
X-Google-Smtp-Source: AGHT+IH3o8vGhtlvXfVau9yJlPGan0qcPbtv3t8vktLenZO7iFKdltC6qjY3tRHYxMwY2Ztz73G8ig==
X-Received: by 2002:a17:907:c12:b0:b4e:a47f:715d with SMTP id a640c23a62f3a-b50aa08f88bmr1539119266b.17.1760170318950;
        Sat, 11 Oct 2025 01:11:58 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:1c43:389d:4bae:10bb:730b:cf7f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d4f12sm436679966b.27.2025.10.11.01.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 01:11:58 -0700 (PDT)
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Sat, 11 Oct 2025 13:41:49 +0530
Subject: [PATCH] iio: adc: ti-ads131e08: return correct error code
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-ret_val-v1-1-8e968b38790a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEQR6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3aLUkviyxBxdY0MLMyNjsyQjE4M0JaDqgqLUtMwKsEnRsbW1AAa
 rRkJZAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dixit Parmar <dixitparmar19@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760170314; l=1367;
 i=dixitparmar19@gmail.com; s=20250726; h=from:subject:message-id;
 bh=l3dtsTPKD7ja5cSlZm3nj/yE7IouGfzVBuBNzd5/+ag=;
 b=sS54gLn3TUckxPhRSL0zRNXRe1Gdh42HpGgckk2CMUfIKiaChL4P1g5uu8Fapl1XwbWrmne9j
 txSMirKcxg+BVXpoqWj0LG6GDFZ6VBSIamnkHjtEwuXUHJDwx0wXU4G
X-Developer-Key: i=dixitparmar19@gmail.com; a=ed25519;
 pk=TI6k8pjTuLFcYiHazsate3W8rZGU2lbOrSJ4IWNoQhI=

The error code returned from devm_iio_trigger_register() inturn
iio_trigger_register() can be other than -ENOMEM. Hence return the
same value as it was returned from the function call.
This change makes devm_iio_trigger_register() handling uniform with
other iio drivers.

Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
---
The error code returned from devm_iio_trigger_register() inturn
iio_trigger_register() can be other than -ENOMEM. Hence return the
same value as it was returned from the function call.
This change makes devm_iio_trigger_register() handling uniform with
other iio drivers.
---
 drivers/iio/adc/ti-ads131e08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index b18f30d3fdbe..10330d6913df 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -852,7 +852,7 @@ static int ads131e08_probe(struct spi_device *spi)
 	ret = devm_iio_trigger_register(&spi->dev, st->trig);
 	if (ret) {
 		dev_err(&spi->dev, "failed to register IIO trigger\n");
-		return -ENOMEM;
+		return ret;
 	}
 
 	indio_dev->trig = iio_trigger_get(st->trig);

---
base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
change-id: 20251011-ret_val-3186236b240f

Best regards,
-- 
Dixit Parmar <dixitparmar19@gmail.com>


