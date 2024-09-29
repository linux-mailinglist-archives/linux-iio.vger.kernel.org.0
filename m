Return-Path: <linux-iio+bounces-9902-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9982989760
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 22:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C2E1F211D4
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2F185B6C;
	Sun, 29 Sep 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBYbdUAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4C185954;
	Sun, 29 Sep 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727642346; cv=none; b=hLchEB5CbVUv2DuPYkJy0wglwEamwu90Q3SSJrgfBxIW1Ocehok/h4Wqi8utkm75cHoVaLSv2ROOqXoTO0cdkrClw+cf2f4lD8B/XVCc3T/fjFqxS6cFFrulC4T2S3V4VwR7CZbX+P96HfK897DHoF7CVOvQwp61p/kdvxUThhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727642346; c=relaxed/simple;
	bh=GxpFD4n+UOKfDv0dYLS/5z/NDDKPjNwuLx4KutIecnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fAjzZkWxpcpAtmcaiR4DG6Lsd5u/AUmqqoAHjD9Yb2LuDhUWFRMNeFjtaWfjQ4rDIzdrT5e0PWJ0Wq4ZAKQJi8TO3WYNjAHKHEVdssC+Ehg0KMFmjyrHnXT+potH5JccmuxlhCbPsPFA4q+bEnJ7a6yZSS1Y2oNCmPgNFYYOUpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBYbdUAF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c88370ad7bso3090049a12.3;
        Sun, 29 Sep 2024 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727642343; x=1728247143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xGWWtQWL8H06GfqAD60uT9oc1UGLA/x5EVLWu1GowA=;
        b=JBYbdUAFwSgolB5NAT7xClR2orSlStfY1LxoOYYeJ2gGUza81CsXlilgpVzU9src+t
         GRyw18CtdwKmqrPRdbmLInZCrz5dbVIvEoRAMI2HbGCQLFOlYYFzjgHYCDYnUzNPPa5k
         Ey9i9eSNLPHXel2wsz1bgambRcd40IBpUioJM5JHSskLTKrrxPo48DFd4bYqqY/Ch4L4
         eJaS0HxfOxh07R+GDY9kcTX7TQKED+s+LRiWEPFLhTFn94v+6TFGUP+YopGuOzD97o4x
         HRqkQFkQ9W2sFLgytTKTccm8XmeLMffsB1qfmxbzPedjFhHX+G9xMtkWepHtwrg8exQ6
         gKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727642343; x=1728247143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xGWWtQWL8H06GfqAD60uT9oc1UGLA/x5EVLWu1GowA=;
        b=riLVxaacsVhirHW33MPdDp4rIYEotLGnK9OIt9gIsIGPTiWqZmQ/BaEXWVBChTBqTe
         0GyLmDFZQMxqwrnmLX8EoXyu66BmhMHfuwmUQ5wPNbiCqpEn5I2RopBQhOg5XjQDqr5C
         TQLXOWSGJpe99C+n9ihjyQR76d/eufPDTGTLfpZY9o/3GGKKzq1DkXWXpcsquJCtY7Un
         sVw7dE0bPd1GNuU5PYGCx18FnXvZ+e9oaZEXyvsGnCj97sduW65dVxRcBiDQ8i3lqyqP
         9qGy+/uxeBykGWwLbsniByEiy7Emcl747QTPthMxV6qQIbXv/og/cDcY+xnLdqJx7ox8
         9dZw==
X-Forwarded-Encrypted: i=1; AJvYcCWN41IqFlci5YPWwqMTVyL95whCca4hXnXZU5M4qeg4AYRzbDQqb7rquiN9pYG+2EhnugcTLndyLREWYd8J@vger.kernel.org, AJvYcCXnnOJ2zm6EqFJSrKLb0RjoQCWx73q2B06CxoWscvBemgS6cY3bVjFQ4RWLRPt9f+44rmMC+rc49wUb@vger.kernel.org
X-Gm-Message-State: AOJu0YwqiTmCHaBnD1xm0TZgDj0KJR8AeoAM1zbRB4SwtpjRW7HKPmlZ
	NNXC65b+TitSPBeVNEfM3b+1+QZfxr/xjaQmxrPiDYn3ew6URInh
X-Google-Smtp-Source: AGHT+IGu3Vks+yZ+loKrkQH9ea7mdAQIlCq3hnmwIqNsSVIxKhDG6FaKhbebTZ47rQ4DzIGO89XgjA==
X-Received: by 2002:a05:6402:1ecf:b0:5c6:cf72:fcbc with SMTP id 4fb4d7f45d1cf-5c882602745mr9201341a12.24.1727642343298;
        Sun, 29 Sep 2024 13:39:03 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e2c0-9a60-64a8-717a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e2c0:9a60:64a8:717a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051c2sm3487985a12.19.2024.09.29.13.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 13:39:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 29 Sep 2024 22:38:51 +0200
Subject: [PATCH 6/7] iio: light: veml6070: add devicetree support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-veml6070-cleanup-v1-6-a9350341a646@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727642327; l=880;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=GxpFD4n+UOKfDv0dYLS/5z/NDDKPjNwuLx4KutIecnA=;
 b=783uxrwHsIhBRrVFri3zubB5JaA85shfbkiYFD7Uddc5wYMEcsEKfuIXNviDh/JH2Q2xhlHN8
 dfEmcEnXH/bCL15RJ7vimBHk9P6OB6Z4+kHSerdeClrPRcmIig2V4nm
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Register the compatible from the dt-bindings.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index faba04e1da98..8d02899028d8 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -192,9 +192,16 @@ static const struct i2c_device_id veml6070_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, veml6070_id);
 
+static const struct of_device_id veml6070_of_match[] = {
+	{ .compatible = "vishay,veml6070" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, veml6070_of_match);
+
 static struct i2c_driver veml6070_driver = {
 	.driver = {
 		.name   = VEML6070_DRV_NAME,
+		.of_match_table = veml6070_of_match,
 	},
 	.probe = veml6070_probe,
 	.id_table = veml6070_id,

-- 
2.43.0


