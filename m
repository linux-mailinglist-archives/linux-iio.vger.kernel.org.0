Return-Path: <linux-iio+bounces-6690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3586912EE3
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E3BB25E67
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2024 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B92B17C214;
	Fri, 21 Jun 2024 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i0lEz8LV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280F917BB1B
	for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 20:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003102; cv=none; b=I8xdeqAvigJxcbg8qOo6tawTcbma0lvJw1LdDoANCfPcoIamf7Y7BHhd9bEEMY7SnnWRTVo99AFvObBKe9vlDVIVaNm9DO1aPE7GorBkNThR5hpL4iORyB8Fihrgw1HC0R+mbnxGqvKP0NZVdhNZiRD+jDl3LU1w32D55oaUXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003102; c=relaxed/simple;
	bh=tQGiPDfmisofm11aHAvZFzPZ0bp5Gzbq8GMeABdspDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oF6cWK39WbXu4rwgDlE6vLn4O1JyXwg3qJqQSS2Jn2UAe7f30rRT/iCF7eWB4PmuPiC1OhiCEUaR7pCrNYq6so6g17nxfv1m3L/jAtgjJ2GJsdtjpJXgGVezrvnTIJvjojFSrjBM21nDO6rA52Wv74ma3b3vC704zRZFImHyvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=i0lEz8LV; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d220039bc6so1289636b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719003099; x=1719607899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRH2tgmU1zOdmEBVnxQ+i5FH9HPtNyS8KbbO3YRf2c8=;
        b=i0lEz8LVqIAkixVLS4Vts0zMHMbu026Utmz2j84VWucg+ux0OXwZePvNOb7SANnznK
         +2pspkAN46M+95MTGvMs+1qBn9rQlO6KcZvUc9sz3HUxWI8q8p85PZEnRsDjpcLzWx+Y
         ivOXbptAGViK6bnsOZlokOPl6je0cZ2LgiUDzRJAns+0g6jkuuZHOWVOaLwgFrWstkW+
         zRpM7bCTN0i9VVpKMla8tO090E5I8TWKR2V5ai9xzwJalnvEDoIZDGBQ5cHnNVgL3u1H
         RNWdVZPpmMkIZGaJDo4XVs+wTAUIZElYqKZINz6z7sJeEeWw/+h+75zp4r7IlaFBLTxL
         qAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003099; x=1719607899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRH2tgmU1zOdmEBVnxQ+i5FH9HPtNyS8KbbO3YRf2c8=;
        b=PzQiJ4LxrW+xnnDprj7qo0j0u7WIY79aaW4BCrjt7c+IjFJ0s1i1+TuCeVKLGvmM4I
         kHFEid+rxjOI5/GFo7ShmCM0U4k1sLf7jDebZb+3utm/rZKD7J8GRIYYQMZIHRg1Q/VC
         sl5lL6pEPLpl6UNvRhmAFTn/yWBvjArnGeGOrkBvsCo16lwlmXSQrYOmt8cpuPwa0GzB
         4MRwt0kl9AupFgkdp/SdpFymZrq+H/wCFuvpPKWSACvIK1BNjybozcSd6eVhhH+F0gd4
         ZTsWrLe+5AX3iS6UGjXFWv/X+EFBMcqwFzIFvsBdP3sUrEKKD6UbDrH+vUeYJikkOf/Q
         88ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4oxv6+tTFNiYNIPLzF9tCAdz8eODDtD/QQR8tOTjELryYa5Hkf9Y2N/ZI/l6vVDRjFpZTZiuMPPdFDXQwt93G/pLzxNfsRoDQ
X-Gm-Message-State: AOJu0YzqQB35tQ4lyekjdnV7/AuMseM767wAtiy0BGfbVM13Q9xouIeg
	wXuPUVbt38/fBuJkcBPYM6YjAjLVlIXtoe+rmL0PTvqcsvokvazFO53gwPuZ9so=
X-Google-Smtp-Source: AGHT+IHTuWYSYqKLh17Ge8FwVWf/S8UQalIkBMaDZf4pQVzFsewbBSX2uAh2uzY1f8+9FdIKabxjCA==
X-Received: by 2002:a05:6808:15a3:b0:3d2:464e:538b with SMTP id 5614622812f47-3d51b9779e7mr8351026b6e.7.1719003099129;
        Fri, 21 Jun 2024 13:51:39 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345e584dsm428089b6e.55.2024.06.21.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:51:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/3] spi: add devm_spi_optimize_message() helper
Date: Fri, 21 Jun 2024 15:51:31 -0500
Message-ID: <20240621-devm_spi_optimize_message-v1-2-3f9dcba6e95e@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
References: <20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new helper function devm_spi_optimize_message() that
automatically registers spi_unoptimize_message() to be called
when the device is removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst |  1 +
 drivers/spi/spi.c                                | 27 ++++++++++++++++++++++++
 include/linux/spi/spi.h                          |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index a1c17bcae68d..ac9ee7441887 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -464,6 +464,7 @@ SLAVE DMA ENGINE
 SPI
   devm_spi_alloc_master()
   devm_spi_alloc_slave()
+  devm_spi_optimize_message()
   devm_spi_register_controller()
   devm_spi_register_host()
   devm_spi_register_target()
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 54cbe652a4df..3f953504244b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4358,6 +4358,33 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 	return ctlr->transfer(spi, message);
 }
 
+static void devm_spi_unoptimize_message(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
+/**
+ * devm_spi_optimize_message - managed version of spi_optimize_message()
+ * @dev: the device that manages @msg (usually @spi->dev)
+ * @spi: the device that will be used for the message
+ * @msg: the message to optimize
+ * Return: zero on success, else a negative error code
+ *
+ * spi_unoptimize_message() will automatically be called when the device is
+ * removed.
+ */
+int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
+			      struct spi_message *msg)
+{
+	int ret;
+
+	ret = spi_optimize_message(spi, msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_spi_unoptimize_message, msg);
+}
+
 /**
  * spi_async - asynchronous SPI transfer
  * @spi: device with which data will be exchanged
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 85785bcd20c1..a9388714e7e7 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1272,6 +1272,8 @@ static inline void spi_message_free(struct spi_message *m)
 
 extern int spi_optimize_message(struct spi_device *spi, struct spi_message *msg);
 extern void spi_unoptimize_message(struct spi_message *msg);
+extern int devm_spi_optimize_message(struct device *dev, struct spi_device *spi,
+				     struct spi_message *msg);
 
 extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);

-- 
2.45.2


