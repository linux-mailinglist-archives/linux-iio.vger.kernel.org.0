Return-Path: <linux-iio+bounces-7278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A3E9269E6
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226632817B7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E48194A42;
	Wed,  3 Jul 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRSq0+Mw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B71946AD;
	Wed,  3 Jul 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040707; cv=none; b=ig/hAaMghxCeP4/MA2G3O5nZRqqH2nC51CvOwHN/W3+0MomdRTIe4l/t7o7z7Bib/VWBOw5amwYNhVR+JbdZnk9n4oi0oMYpAXyzZgmIS0jNTGOGVlUNOXWSixNuDpZmQZoh5632JC+SG1EAHGBPf6jm6PuaPVxSSonwrlJHD6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040707; c=relaxed/simple;
	bh=ooeA+PgyaBsBen4Pd9RbrcNbKRa742OPgC9ACIXtitk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwAU8eqQwNudLpCNkY6WDo6ar3EMpIDz7Vr/n6ZtcZd+AoBl0gKY2gBhBezCruwK04GMPh3/DX8hVvHTNTdNIZsYVC7IFGUbCt8OZ18vIkTQLpqlRTmq4hBuJ3VukQklpsiO9ikCX2mvjUDGi1Uvj45ZdoSkqmBU9mZs+l4oe3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRSq0+Mw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-424ad991cbbso45247835e9.0;
        Wed, 03 Jul 2024 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040704; x=1720645504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlTGqrOKF0ZgjIRJTA1cVGKEsmLO3ONpu3x8xyQX0YQ=;
        b=DRSq0+MwCIrKstTUHcsrJQngW1NlfpYgj95oaGL2O36Syn/eW8mw/2kgIYGe9CiS6T
         eYNJwrAQRVvsTGZc7ZTa4ezNThlQYAe7ZWI+QWNMcUvoTuQOfmi28PAThgwZYF4aq7Up
         YEsxSFXfQ2AI66bQheWM8fF1IlmIIrueXW3T5cHDD83ea1155xM2Bq/bELsCjjsFFXIK
         oCEtg6qVFISmIBNfw1KP3o41kZeDUV0VQEbI9qyfyn9WfnQnjBjo2d69DOCIVy/5usXn
         g3kjn3jr7tGhppX2RynPHmTx6zTfDNN+q4X3EDnHnxP4b3rc5BRKtYk6B6GyKcddlOL8
         FtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040704; x=1720645504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlTGqrOKF0ZgjIRJTA1cVGKEsmLO3ONpu3x8xyQX0YQ=;
        b=vNS4ggfbDCY01kgM+W2BPAzqSW4QQn5t1/oIqTuinN3hjW4zAwvG1yyEadmXmDcZG6
         Bbz2lHtYJbpPF1RASy6eCWmYKduONnzAl3jZaQuunYLm44dF+3nF0NfqMHZEH3PhkkNn
         gNKZc8NQIEb9hBze0G106POx+T08mHpsxVs4+hiGex/phjl5iUNamJVMOBRZie5MXouF
         Ss0SRXJnVk3vqbE4MGHqiIh99RPaFVml4/SJumyRH+n0YRK9Qy9fE5aT+sc9nAqGzNzD
         SZ6XA6uHmibXmcaqlND5z7eL/M/+Mysi3tfnt17IkNKA/f7J0RBqaUXrB635nVQSJYan
         Tbsw==
X-Forwarded-Encrypted: i=1; AJvYcCUH1zMcXxf2gkXs+g9C+LHGEYXDy9awyMU6A5QnqPBySfch5wUW0HUktrs0JD/NrJ3IexDF3vFVqd9VRg203paw6HAmZB0TgXx1IgHl
X-Gm-Message-State: AOJu0Yyxk3IaI2yhQ9TBqdnuuy5ufpDURHkamyjhHolVksl3kpszcF+k
	9Rul2IIdwkTWljDPiu58F3fSE+koiTTfkn3OaV/ucWs964qwQQJR
X-Google-Smtp-Source: AGHT+IE1NXvpVBCK9QupLk9bc5nq9+AD53fTMQ+c+4TP2br/j2J6xLWtnAS+6/YZMptOgeGmXHcxnw==
X-Received: by 2002:a05:600c:1c28:b0:425:81bd:e5fb with SMTP id 5b1f17b1804b1-42581bde710mr69730475e9.36.1720040703914;
        Wed, 03 Jul 2024 14:05:03 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:05:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:47 +0200
Subject: [PATCH 04/10] iio: adc: ad7091r8: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-4-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=854;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ooeA+PgyaBsBen4Pd9RbrcNbKRa742OPgC9ACIXtitk=;
 b=HPb8o0WTIB+c+VIThvsdtN7kTNTsLBLwOEdU4TfHuLh7YEg9NBZmSDDE5bqOD97dinzPZpEB3
 WK5NABJCCGNAsu8eOZwM59qGx1pI61k8xNrdnFdMXJM9Rr9KEA007fk
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`ad7091r8_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/ad7091r8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7091r8.c b/drivers/iio/adc/ad7091r8.c
index 700564305057..c9e014d6a77c 100644
--- a/drivers/iio/adc/ad7091r8.c
+++ b/drivers/iio/adc/ad7091r8.c
@@ -159,7 +159,7 @@ static int ad7091r_regmap_bus_reg_write(void *context, unsigned int reg,
 	return spi_write(spi, &st->tx_buf, 2);
 }
 
-static struct regmap_bus ad7091r8_regmap_bus = {
+static const struct regmap_bus ad7091r8_regmap_bus = {
 	.reg_read = ad7091r_regmap_bus_reg_read,
 	.reg_write = ad7091r_regmap_bus_reg_write,
 	.reg_format_endian_default = REGMAP_ENDIAN_BIG,

-- 
2.40.1


