Return-Path: <linux-iio+bounces-10381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D0A997766
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 23:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B42845B1
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4931E25FF;
	Wed,  9 Oct 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sVIe4Vla"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68329429
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508990; cv=none; b=LZ0Now+e4XBpCOD9YtTmF2XtB6dKEQMDyvWZeirWOAPCYx8HsVvtS4eDpVPjX5bqDB6mhhXJdw/YAVzkjnrHWCX2I+jXMOFggvta0bkyGEuUx63br45CQi2gfgeFTO8GrRIEnNemvBoZgoL+BEzL85kKWRvSvXNs6sKoz1BR00Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508990; c=relaxed/simple;
	bh=tRSw1k/0sr85ExbmOl0gPeC5STZqIEB0X87MsW8wciY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KGTtVdpmiRZiqVZ7LgeMRTfX/kdfdQ3+DxhF96K5ZtU8hZckgjmW5HI+FtTf1dogBSpsHjbFuG7F6M+EbVEKoE3iqFCwRa1qAvduLVDDQuBgZX8tWMsFURToZFikIP4ju+44N1sZHMATnH+j7fr4xB+eugpox1d07NE8PXdzw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sVIe4Vla; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7165df3a85fso154492a34.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2024 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508986; x=1729113786; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+Esmh61ONH9tsyHUh8tyGRx4VPfWSAFGr8/A3GrspY=;
        b=sVIe4VlayEp98Dn8Kbu0nDU+IVKjTe+gxDzsbjvCW2/gEn6RRT+VcAQXU+ipCuIcai
         bFoVAooTmmHHllakE3KbrOujtU/1iBnmpkyn2CoUbAt9s2z3U/52KmMxWi9IISBurADG
         dPMFZtwXnw+wcMF3wcKBP1x3narYqyFmwPXo6pg8SEHx6CkhE+3Fd3I/rgwr2YmU0Ae8
         VB6FbqoHNgFHc5kAWkWmvwHZAqnGRJZEAgxb+uke7+ap1qIC7WB2gw8FGTU50ZJY94DG
         qMe7uEicyQ/qTesyuuPUAS/ttp9BhXXzt4WjZYqTc2GfwKjtFGDR9euG1sINj4HwclN5
         /VAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508986; x=1729113786;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+Esmh61ONH9tsyHUh8tyGRx4VPfWSAFGr8/A3GrspY=;
        b=f6pMriqgJgsCcw0YLIP6A5xOSxhjOOaWMQ/I9OU43O4rB//FCKCkM8RWgYRctVrJTL
         DiTC5wun4lSoYRiH9TWPeIVlA6AoRKuqr7wHAdLzDCoZz52KFCPJ3fnC7FpA5yQEzf56
         9SooChinbhTnA6x5K2ikHRBdejzK8XLfFr11xGVK9S8aVNe1qaaiv+URpd3lB03w71Oo
         3FkD86xzkj9/7HMslb/tWsNNOP64PGpXBI3vw19EM5N8b6EFJ9hAlwN4FEvtAjlaSzg9
         r2TMhndb7vmYOpTQynVqtIRHVvBiYLalbgPxMYc91x9GE+0RJzixDi/kDODs9LX4Yt0t
         ICOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEKgnIZnnGbPZDD7A/G4yx6sPn5wdRDoBkE0Q8ZzrQcK46l4ZWX1nQEkB5xUc/A/m204FmgVUz3gU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8dXrPpQfFqpE4vvhFX8CT0vFJ5e8V19MJco18rBTZtnQVScky
	PeC6Et1emznJ2GqKdgHeurKHWszmhdnN0YhuHuXS9KOALQ3Jnqc/w2PK24YLWgg=
X-Google-Smtp-Source: AGHT+IEaJCQb724C+qYxz/hI785RHLentJJFmeUnrLCgmN26JLfX2nQhw7w/BXLmgRfbvojb1I2YWQ==
X-Received: by 2002:a05:6830:3108:b0:70d:e5aa:38af with SMTP id 46e09a7af769-716a9f62f50mr1971315a34.11.1728508985727;
        Wed, 09 Oct 2024 14:23:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-716aa70aea2sm140015a34.37.2024.10.09.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:23:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:23:04 -0500
Subject: [PATCH] iio: adc: ad4695: Add missing Kconfig select
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-iio-adc-ad4695-fix-kconfig-v1-1-e2a4dfde8d55@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADf0BmcC/x2MywqAIBBFfyVm3YBJL/uVaBE62hBoKEQQ/ntDi
 3vhcOC8UCgzFViaFzLdXDhFga5twB57DITshEEr3XdKGWROuDsr60czoOcHT5ui54B6MtaQn50
 cSODKJPqPr1utH/IC4tZsAAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add select IIO_BUFFER and select IIO_TRIGGERED_BUFFER to the Kconfig for
the ad4695 driver.

Fixes: 6cc7e4bf2e08 ("iio: adc: ad4695: implement triggered buffer")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
I didn't see this one in the recent series with similar changes [1][2],
so here is another one.

[1]: https://lore.kernel.org/linux-iio/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com/
[2]: https://lore.kernel.org/linux-iio/20241003-iio-select-v1-0-67c0385197cd@gmail.com/
---
 drivers/iio/adc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 85b82a708c36..98d441d6cc5c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -52,6 +52,8 @@ config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices AD4695 and similar
 	  analog to digital converters (ADC).

---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20241009-iio-adc-ad4695-fix-kconfig-279c9ef8d9ef

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


