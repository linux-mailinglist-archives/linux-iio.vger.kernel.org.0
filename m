Return-Path: <linux-iio+bounces-10096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943FE98F889
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE552835E0
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2E1D0941;
	Thu,  3 Oct 2024 21:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef9jHpPM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123511D049B;
	Thu,  3 Oct 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989520; cv=none; b=IPz7klj1SpA5wOeggwN/tvRla69tK+9EcDlvI1CBdd+TsOTbK/16ESlFZL4/BeAxI2VZSLy7ctNk5VYZFJNuihYcixOGT/SPVgm9qZLbHMFhfUh20lhWztM+q1EsEPKtS9kXkt7lBNqAor/Q0AgzemCCXAKML+orMH5no5lybZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989520; c=relaxed/simple;
	bh=pJm6aEsH1JG//ar75NwFYnL6uPDbkanApZ65S8uRHBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAxTKEMfKxpbs9nUCiArpIRpWCRWvuWE8/s3NV3GFXhYrTIK0DMtCHSB0V70uIGGPs1fI9kuhFbcF0j8nXLUU69v2AsvKryg+dWk8Y0yw8fB6De9GIbtLqyT+loz0W/noMlThGQZ+uhtpIN8uY+HOX5PfHisOZxlVlEBaDofsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef9jHpPM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso12618135e9.0;
        Thu, 03 Oct 2024 14:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989516; x=1728594316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLhcLtJi3DUZsxCk9oZJU0/cAu5Ysh3YPXfHHNtEVDU=;
        b=Ef9jHpPMCDcK44RTcTtWr35P0sr33xPFOahGaYJUjQmcoqv5H5iV6pxbxmvq2jKDGz
         yaLGaLRSA2fec2g5l6AXuifcXUFv2roUzSCNH2c/W1Xpm7n5mY3DQw9HjldesFJn4kkc
         OLjN0ttl43Ovs89TyxOq6RDXYhMcOErg9Pc2TSKp0FGOZ7doz/T4V5qmUnGiQGntbHQC
         TwK7JDhal/N2tO4Lum5687al/1TMEptiYKnSXaHlEMpLuJtp0zyN50Hj70JGP6401jn4
         +8NqW+p1fAzWjp5crLZ3s2nZBBs9PQGdBt1RE5epq+Ko63kH7FBvqym+MJdNeb/99o3N
         D4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989516; x=1728594316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLhcLtJi3DUZsxCk9oZJU0/cAu5Ysh3YPXfHHNtEVDU=;
        b=MopnemnVtnktJ8Dmr3J+DOVKj7ZX0NKhuwZJAinACbNwXI2qwCC7DOf39LA4CecJqM
         OZg/4/tcXbN+JlK1jGRO5cZ3v5i2kfWI9tNpYJAp/qjD8gGi283Ssd6rSPkgtY0tVPm+
         E6RoldjFKEby7UwiMWH5uyDlnU42DAQoXP9qTrV7EDSBDHJGl9IBhx93WHg0eHsjfXZY
         IdJAs0TDjmsuSbWWtXwORPf20azYAjiSMwI34GSVqdh1rHf0OYNNgmyAwReNprTTx/0r
         QUEQB6RH7JBQ1G3e9f7bkyt+ttUEOyDh8RVXHR6HV56PywsHgHtEjmU7y99xVXj27bvO
         rloA==
X-Forwarded-Encrypted: i=1; AJvYcCWB7OhqZdjM2GoEExEDnjXrYmREFJG4MyOdJxZGDODtgIqC3KgLAKGoQLE9tQVDI0MacH2sPVt+h38=@vger.kernel.org, AJvYcCX3xX4iFq07Yrr/wdXCW19y/x9kX4VvLsNBCtA/f7xGvph6AW/LFTUXG7GgcIn2r0zUadO/LZ2bogSqpA+S@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEAbQRJNdMS4O6BfC3L1PgmruaaiAXhMBuQAHWkXnwfp4i0CB
	2pyVLrYWj3fdWOhAglrUlDjtKcYGZ3dGYeMkd1jN6wPNaB1oux4AuDGHvbpT
X-Google-Smtp-Source: AGHT+IHvSFIwB2Nli5S1zg8ivBeopw/bTugSAzNt5rnXpR0UTJ5J58cAQSnUjKZLuTuT7xA9k8NcPA==
X-Received: by 2002:a05:600c:3c90:b0:426:51ce:bb14 with SMTP id 5b1f17b1804b1-42f85af46c9mr2043575e9.30.1727989515648;
        Thu, 03 Oct 2024 14:05:15 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:58 +0200
Subject: [PATCH 12/13] iio: pressure: bu1390: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-12-67c0385197cd@gmail.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
In-Reply-To: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>, 
 Mihail Chindris <mihail.chindris@analog.com>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, 
 Gustavo Silva <gustavograzs@gmail.com>, Shoji Keita <awaittrot@shjk.jp>, 
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, 
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, 
 Andreas Klinger <ak@it-klinger.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ondrej Jirman <megi@xff.cz>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=911;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=pJm6aEsH1JG//ar75NwFYnL6uPDbkanApZ65S8uRHBU=;
 b=9NRv/wSXyzJMgcJaMxEzGApQ3Hi7pcuTX100ayqzas5EaQPvNhDBiFkqJVHo3i4c+Wefuqvhh
 WZa8GNwI734Ajapo/4AxE5TobAy/osjqdspoSJpF2SmY8tnB0qUm1cw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/pressure/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index df65438c771e..d2cb8c871f6a 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -19,6 +19,9 @@ config ABP060MG
 config ROHM_BM1390
 	tristate "ROHM BM1390GLV-Z pressure sensor driver"
 	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z
 	  can measure pressures ranging from 300 hPa to 1300 hPa with

-- 
2.43.0


