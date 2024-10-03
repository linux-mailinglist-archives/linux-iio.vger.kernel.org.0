Return-Path: <linux-iio+bounces-10091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D198F87C
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750181F2296E
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852CA1CCB55;
	Thu,  3 Oct 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFzTI1K0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50831CC16F;
	Thu,  3 Oct 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989508; cv=none; b=OmVxoJXJgmsyo2sHBDDCzAMN6QXo/cRH9pkr0/AUkBQCkNmxplMKmO3+5ags8wdDeS0uLVjHSTq7Gkff1QvLJpUcfDCTivPzHTQ3OqSBh1iDGDKEuFcWlmcuzt9ys1DvD7S+7tKUFUQAsK1JT+89Fye3JLdjsaFMISN4d8nX244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989508; c=relaxed/simple;
	bh=UDUIU33cUG3Q3WPQ0b6UwKmEsXsMMs/v2smuIUeObJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJiRRzwoFodMRcKa2R6iBI4sDFN20jHI9qK8FX46sB4FMeAI1oYBB40S3PaaD3JPLAMZKTbH1GQwHkft5IZmxbQ0f7Ykl/luhfTF4oJtX7kNu0wMZRnBj00aPs6F/aYL5PjlQ6tGqO2EWhxvqzP6g2FYqotsko906AmHXGZbS78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFzTI1K0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d04b32ea6so1010095f8f.1;
        Thu, 03 Oct 2024 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727989505; x=1728594305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nfYN8Y14gOBtpeopWG2GxnSBBdqipmpvcig5GPcgvY=;
        b=nFzTI1K0dcVnbYm1zY3MIy0tJOcL1uni0Swh4miM4enMUCJrdg2GrJFYMCoNv4MRfg
         UJdSg1gM6c7xCJOl/DknF25TQEiu01kQuFLvjnwT/5QRQDC+vVq5oU8ckZuYgbV9o3z1
         oovGwEyRrFLB/wJ6LRxfkzdy59wxZhBVdYI2GN5lOWp0ZhLmaUSEU2Mmr2Vaj9jXUW8E
         ThmZZfq8PVN8lhmsnFgn+1UZQNlzRROQcaJZ6u/VgBSyaHhzrU2njkHpBD5OhLyEhCjZ
         5aav+QRXSZh7MYksEc1/S3de9xNaesA+TQrA6aLi6s2gFzLa4DJqFMNuFMFNPv6bd0x8
         LI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727989505; x=1728594305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nfYN8Y14gOBtpeopWG2GxnSBBdqipmpvcig5GPcgvY=;
        b=KrRP0aPsXO5K+/njHG3kiJMwiXaw6bjJo+nTlOojLmlcCnuXIsFP2YarvVrjfioaRO
         Twai6BPV8Uj5ns/vHcz5/hfOX+MQmssiGuw/aOudFzi1eZB8eidesMeo51GkOQ9X7ScW
         KRSBpR/9rJQAaV99gbc3EyhOj0WcnmaBb/nkh5E22IZmQUbq/QLi61mo1JWIqpYetdyf
         ZT55H+4eS42m5hCNge3YSfewSrJAdnO5iMD0OfiCG5BNZQRIU9imscECKBml8UZ27tNY
         cMl9F/D/pYY10hxMVlNFRr2R0bZIDaBtly/TTWBAZW9mDFeF271IdO8fEqT5JhbNq6rF
         0WAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcvloCS+78Fy4HOwCp0aVPDVp21wX8IwPupx8JGuYlZbdP7GERNeo1pYcJUlGDv/9u3ueP+uwuY0g=@vger.kernel.org, AJvYcCWiQV4y6aihy8QkwvIiVuJpkD8EOnUbX0JEe+wv0TVWHDi9hHmnVf/xdlnD79C1VyMCyOp7m0M9wxuRKfEZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ENd9hwZnW0oymKL7RObZESrg+NZj8t8FPhKy3Y3OqaMB9sgi
	YDa10iUvtWyTuZDuDNQ60/1LmXP5BZw3oRkWd4MtEGH1nGQjBZEhTZCKKjG9
X-Google-Smtp-Source: AGHT+IFdhBMc6kRhzhKhOVdzo4987rdx/GzLSzGu6ZaFfepRLgOvW28fkrgb32KNnHgS4XZ1nDEgfw==
X-Received: by 2002:a5d:6886:0:b0:37c:cee1:acb2 with SMTP id ffacd0b85a97d-37d0e6daa98mr364559f8f.10.1727989504603;
        Thu, 03 Oct 2024 14:05:04 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d1f90sm1981853f8f.93.2024.10.03.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 14:05:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 03 Oct 2024 23:04:53 +0200
Subject: [PATCH 07/13] iio: dac: ad3552r: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-select-v1-7-67c0385197cd@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727989489; l=853;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=UDUIU33cUG3Q3WPQ0b6UwKmEsXsMMs/v2smuIUeObJg=;
 b=Ycx52yRgffeji7Ege85IzsOgU7QJqMyTnoDmMsRdgVfihvSCmx1bEg3CAcRHxZj+PyiI6+2lE
 n7nYnv5D2IVAlHUtb5A/S1otNQi41nsZgdp+xe3HKRyzTvBTRrUjQWr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This driver makes use of triggered buffers, but does not select the
required modules.

Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 1cfd7e2a622f..9d4600ce0427 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -9,6 +9,8 @@ menu "Digital to analog converters"
 config AD3552R
 	tristate "Analog Devices AD3552R DAC driver"
 	depends on SPI_MASTER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD3552R
 	  Digital to Analog Converter.

-- 
2.43.0


