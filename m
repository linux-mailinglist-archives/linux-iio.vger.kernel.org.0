Return-Path: <linux-iio+bounces-16322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C09A4D919
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD5B3B2F9A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483CB1FF1D5;
	Tue,  4 Mar 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LKLawjV7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A891FECCE
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081184; cv=none; b=JmfhlopcRkBa57rQFHmLO3fpbFGys3r8SofbePrk79mHz1utrblnME6A855BuXhKY/rZZOzWUBPsMpzRwqmRLe/tcJ/IcXgRmoN+Fx6fxmY9mc1dqitHtP6JvmEEyM4akn0ttXBuZGd5NtPNLwTttBD39BzjJvQzc4U6BNbZFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081184; c=relaxed/simple;
	bh=ZXzmpb4axwe5e+KmC+wKSRDPy9USmDbFe7MNC5wo4Dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jjyK0XI/U+xFrurKzlpwiSurgUF0Xhc3cQyADiIX+jdSUgj+hF/kvx8zPR8J4f7edTg68XpUHRIYgUgI6GWxNhLasheXsN+IAFshVrbzk+HEUEZVchq1NXdsDC1dALRrRkpxI9LkXRp3qtnmMUhSmUR98efD3XV7hMfkG+wXXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LKLawjV7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390cf7458f5so5001493f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 01:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741081179; x=1741685979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzkM1CNNQnYlbfs6JoNQ+Yr5xlry9PSvlEEig9xhArk=;
        b=LKLawjV7AIYB1Dn4KIboRFFGQj7j/50uL+aCGqG4EVpkh0UsvexDVWmVyR2N49T7Hm
         mYcwgKPoKzq1n8pHLsObgeEtHGgiUPRqLbxQIqCBC9+BZX8J6Ku0csPBoU57EiLgoQvS
         JSSKV6LOU03PhRkVbt/lmeZKI4UyH+7F4RsRcycrWO3VgFFbZXXMlWQVqArctN/VqHuS
         vrFByc+VKhjFum4iX0OZROWeUTqmZxpTy8K9FKBN97ZALainTsnErYkDpMiVtwH+xGMc
         yxd6KeMHuwcBtsEk5/nBsTMDM/P+BEJ79OaejtsQZbCYYsvcKWjv/57+sZYyasRY8loM
         wA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081179; x=1741685979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzkM1CNNQnYlbfs6JoNQ+Yr5xlry9PSvlEEig9xhArk=;
        b=tPdVPNI7+cZh8RPvkIgV4NMotNtP4CrpaNoOWcFf7fNcYPjj+eHBBURQPWxxaOOx3J
         tdt5uo8Y/I5Svqu7ruJzek7orPo9sk93en0TUBdscLo63AZmE6Fg2aQmRt/pZpkdXLfZ
         96wf5oRmZQaUMSVpbNP9f9VzKeucTmnQHoXOCqP4zEOL/PwevsYP0jSHzcSIQcqkWIeO
         Jc+VzmL2/v153ikx+jYu9V+xasxuuv6/GQV65p5UTuzZjDukmaeMZDRRg2i5/jtG8cHf
         pWdLGdJjx9TurMxz4ozxrJQrxH1g1N3j7YH0R8VkrbGY8l/fmDF1wxDzinoiXLVvCKpQ
         qxNQ==
X-Gm-Message-State: AOJu0Ywb3gSuM4mo4HiRnDC5kg2Ydr0Rm0BEbcWCKS4cehj1u9f7Y2Aq
	4Hz1T1VfbBYFtWX1wL3NpGdYikr+kJw6CbWEjN3ZryrANwqyP44m2Gt/ZtkTXlo=
X-Gm-Gg: ASbGncu0Lclkd0MGZt4aEdhbTN0iE70QSrX2VMJN/0Szrr+fYypkRHG9yHtZDuXnr/3
	z/4iMXJAayZuu+nvMt6dpxq7W1gri97Gopj7JFLU3MkZEFdifqtiSZ/w+ykJgZruDhDxa49bAjj
	eKQ+2BL3lpiBpwpoltysSEt8i5PEbyPUthWUpkK17NLJtxZuBHrUNvMhXqJTKRhG67PkVGcCRY3
	baXfmZerXoecBp0ICbgg1O341vTcQzprftT0kGPSJB70GyRFytF2FMgWhH8xU3ahtC7ebG8YYcR
	Tx7AmkY5g5bIScEcDx/dYgAvwjVX4qOUXKI1FBvqJBgA4oG4sad7kMNf4lzu9KK82kJJvmGqmhJ
	g7DS+l5v6hIxJFxodO871jkeR+7IFwhvmcg==
X-Google-Smtp-Source: AGHT+IGP8/XNJEym12siW12OXb4Z12lWgJwu5ud44/xI6+DcmWzTDDMlA/u9XUQdHWGyyJpPjSs+9A==
X-Received: by 2002:a05:6000:1847:b0:390:fc5a:91c8 with SMTP id ffacd0b85a97d-390fc5a9e2emr10725079f8f.53.1741081178818;
        Tue, 04 Mar 2025 01:39:38 -0800 (PST)
Received: from [10.2.5.157] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7ddesm17307844f8f.57.2025.03.04.01.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:39:38 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Tue, 04 Mar 2025 10:37:51 +0100
Subject: [PATCH v2 2/2] docs: iio: ad7380: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-wip-bl-spi-offload-ad7380-v2-2-0fef61f2650a@baylibre.com>
References: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
In-Reply-To: <20250304-wip-bl-spi-offload-ad7380-v2-0-0fef61f2650a@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad7380 driver.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/iio/ad7380.rst | 54 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index cff688bcc2d9601a9faf42d5e9c217486639ca66..e593ab6037b0da4cebfad148313f21cca7f00fd4 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -142,21 +142,21 @@ Example for AD7386/7/8 (2 channels parts):
 .. code-block::
 
 	   IIO   | AD7386/7/8
-	         |         +----------------------------
-	         |         |     _____        ______
-	         |         |    |     |      |      |
+		 |         +----------------------------
+		 |         |     _____        ______
+		 |         |    |     |      |      |
 	voltage0 | AinA0 --|--->|     |      |      |
-	         |         |    | mux |----->| ADCA |---
+		 |         |    | mux |----->| ADCA |---
 	voltage2 | AinA1 --|--->|     |      |      |
-	         |         |    |_____|      |_____ |
-	         |         |     _____        ______
-	         |         |    |     |      |      |
+		 |         |    |_____|      |_____ |
+		 |         |     _____        ______
+		 |         |    |     |      |      |
 	voltage1 | AinB0 --|--->|     |      |      |
-	         |         |    | mux |----->| ADCB |---
+		 |         |    | mux |----->| ADCB |---
 	voltage3 | AinB1 --|--->|     |      |      |
-	         |         |    |_____|      |______|
-	         |         |
-	         |         +----------------------------
+		 |         |    |_____|      |______|
+		 |         |
+		 |         +----------------------------
 
 
 When enabling sequencer mode, the effective sampling rate is divided by two.
@@ -169,6 +169,38 @@ gain is selectable from device tree using the ``adi,gain-milli`` property.
 Refer to the typical connection diagrams section of the datasheet for pin
 wiring.
 
+
+SPI offload support
+-------------------
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
+
+When SPI offload is being used, some attributes will be different.
+
+* ``in_voltage-voltage_sampling_frequency`` attribute is added for setting the
+  sample rate.
+* ``in_voltage-voltage_sampling_frequency_available`` attribute is added for
+  querying the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0-voltage1_type`` and the
+  ``buffer0/in_voltage2-voltage3_type`` attributes.
+
+.. seealso:: `SPI offload support`_
+
+Effective sample rate for buffered reads
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Using SPI offload, the PWM generator drives the starting of the conversion by
+executing the pre-recorded SPI transfer at each PWM cycle, asserting CS and
+reading the previous available sample values for all channels.
+Default sample rate is set to a quite low frequency, to allow oversampling x32,
+user is then reponsible to adjust ``in_voltage-voltage_sampling_frequency`` for
+the specific case.
+
 Unimplemented features
 ----------------------
 

-- 
2.48.1


