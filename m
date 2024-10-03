Return-Path: <linux-iio+bounces-10086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70398F872
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD85E1C21A46
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D51C32FC;
	Thu,  3 Oct 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf+IcAT7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54411C0DFD;
	Thu,  3 Oct 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989499; cv=none; b=cstbPDdokSHSfoTEKUuITSRQhvpg8sLEJWaE2pzEQ8Pic/lF+1BGYYAvna6Eos4iRVqz4pzpCgOysLnKrmm/NsKOVpV0zPT3CnW6eeE2DmtGvaTx7V/wdugeOA7KvkI7BBJ2BXaR25Lc731RsPeGOi5zdVCrUCuFrjXdF1Z5SaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989499; c=relaxed/simple;
	bh=McQxdtwEupzbUm+EhXUres8xsy1ewiFsDUkVrdwHeI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jwpcwspTAPgAU1LrYAYDHOvQtNOWx0ceYJLiRBXlIG79lu8BzJ/p6kDUoptIvX2Wh3S6F0Q9/pDy5B8ZHixfCyHO3b19/3jBzsztmgE8P3vwLqhUdPFcgFcSbbyNtWD0pcu/ZcAt7QUbYg5CSMhhByt47pXvpkG5Z3f0SvrJ8Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kf+IcAT7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cdac05af9so1379198f8f.0;
        Thu, 03 Oct 2024 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989495; x=1728594295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HNudfaPjvypa7TQyJIOw3LqdBEpuHpJ7Xio0sncxVE=;
        b=kf+IcAT7BT6YahWrVLvN5fmWj1LwxbR2rhBp4ZC80xSkgaV9eBMQK6eo9zJRtqvgFR
         7cSCsja/CtVpM+DlyMyu33bdLsCnVkHRBOLnWpDw2VByMlTZxc/HENE8qUv9FiZBPihy
         ZQ0iQnI2a0Kuh+XolNGywMigbA1exPhe8lznzm9AYbX/EGFjizP67iUvELTe+sTIGHgw
         ixoDLSiHH/Ss3f0Ll+mgxVbcHjplRqNTDZXya54b1M412Nu4MSrgNucD68HFrx/VX+0e
         VaMuirL2dJzaiwQqF4LLTKO6gLi0Fbsh6ybu/R/ui4LZy7b9N6iQr2eLx0uvW3qFc2Zy
         kIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989495; x=1728594295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HNudfaPjvypa7TQyJIOw3LqdBEpuHpJ7Xio0sncxVE=;
        b=RwlxaZrgrO/SDYdZB3xRJ8VWWWmIxBVLEVyQu9O6czVkKAb53T6EruG8YZs2o7rhTF
         7Ih3aroeqStXXzNFms+Zp5ulKH6QopMRDDnavkG1MQ2G71E/k47QyaDmxaOmKuLgQ+i4
         vYO5ku8f4cU6x9GlpPblhsNh6jiLo5nFxWJYa1nS6W6z2yQUQm0eWypk2GkdJ3vjcQv/
         SKWkH9FjjiXTEvuCuIeL058HfOaRnbnJkRTfvx0OfSj9kKxs4o3yHlVNqCiKaVCuDi30
         MPJ02nyJYcsoQFSmO4w+F4/wPZ/xKaOdahsFmQAU1HKVPPrpslzdafRVRcxNrt+IaaYV
         AWXw==
X-Forwarded-Encrypted: i=1; AJvYcCWPsiUhKQditzU1CxeuFh8T3RzgI+qZVv//2YeV1q0KzHfYfLGpnpth4R3DoKrURWselEYKd/ZI6GQ=@vger.kernel.org, AJvYcCXlDlQO9zG8rjTertv16hSKQD1B014lLJ5mGv1rIRNmuizppREm2M4fctM/qrzYbT0vxF9M3efPFbdD8L9a@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+q/bwQmXVMXwOuZfSjfmWDC1/qCvtaSlwR5mE5nirUjsmvY09
	DUHmRHbquT01NuLHzBmPO56ERjfZfxsjq/oUbAGClGlpKmgWrI6lkvpAeGi/
X-Google-Smtp-Source: AGHT+IEOIlFsiZQoISQ2lryKNFpjPVx4dl2+f5ybTHa6yI1MPPzt0RbDnqaLZncPjp2pT76Nd07SnQ==
X-Received: by 2002:a5d:69ca:0:b0:374:c3e4:d6b1 with SMTP id ffacd0b85a97d-37d0e8dafefmr533446f8f.44.1727989495280;
        Thu, 03 Oct 2024 14:04:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:04:54 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:48 +0200
Subject: [PATCH 02/13] iio: adc: ad7944: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-2-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=841;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=McQxdtwEupzbUm+EhXUres8xsy1ewiFsDUkVrdwHeI4=;
 b=MDHbuGC+/o4WHTr7dlDoszoLf0UdnP6jmbVbQP1waUHw+gkYbpLPJ/b9UdQxcqnAaw+Ex5/CD
 Ufh6tBePGVdCzjTb4T3VI16Q7LSTFp3lk5AB8g23hMKrsKdcZ7B8ICV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 97ece1a4b7e3..6790e62700fe 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -328,6 +328,8 @@ config AD7923
 config AD7944
 	tristate "Analog Devices AD7944 and similar ADCs driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices
 	  AD7944, AD7985, AD7986 ADCs.

-- 
2.43.0


