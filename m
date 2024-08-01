Return-Path: <linux-iio+bounces-8126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A87944445
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 08:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553711C21A76
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 06:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A8B170A1C;
	Thu,  1 Aug 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bovwho/k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A471A08A4;
	Thu,  1 Aug 2024 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492845; cv=none; b=WsxVO4D/hdDZYYyAsncNPdyaxDF41vtQhVKktTiXwuOSrR3w5AqnNq7BLzasiDwW1Dv7yDc6NTSJHA0IH4Ud/ntLEqYSNt6mt+R6Rm40LFeK7fOwrMKUc4a+HsddNP6Cd0XJqC9TRdPtZMN8ykCwQdRSbcv44FROmhch07bwFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492845; c=relaxed/simple;
	bh=i0sBRG11zXAIKwjcoVFnL1Y8Swho6X1BW3kA0cfdhTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyhWA6AjF399m2SYmPrU7pOktBlITWIDTiHAtJiHltUxrpjh7Yhy9qucOZ43dn0b7SjcBSd2YPy0GOTBhe21dPomm9pA9W3x4UIVLfX2lB/J2NUlZ/vCjqtZzdit7ePbXVRgv7AOluQ+q1sZDsKVwR5ZIGyXC0UtbCD6u5d+CsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bovwho/k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-369c609d0c7so4489185f8f.3;
        Wed, 31 Jul 2024 23:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722492842; x=1723097642; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNuDB4bLwR4acprYzX2JMVmPgj/lKzcikki7sLZSJG0=;
        b=Bovwho/k4yDvfqoSjHdLIS60/G7fhkw9rdfCv9uEYqDjtEFk4cZS9/O6QswdOYXJKA
         AY3WuQTxlxYCCphfZZTiZRJZaqkyZxk7HAGvPfmTLyQwl3SBd2bl6XwJcNlbfrSPmSRm
         YYP58zxYJx0XYwWO/dAbS/IsqtAc7gSfXxNGNQ+imymm+DD9j2YUkogJKX27EWWoW3+e
         7LE5DzBHY9A+wzZ5K7LzoUUh56MXS69u/Fnx3aXwquUkcTkBzSnFVfvs4FQGVa+dT5pr
         ZJYQYpxqxsqslJOHJ6gXABbRiiPdmNGBghY/NyXwTlaN0U27Plf9uC/M1malWdZxm/3g
         jnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492842; x=1723097642;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNuDB4bLwR4acprYzX2JMVmPgj/lKzcikki7sLZSJG0=;
        b=uJMaBKZhAfsf4W+jDJj7HKYcw3kl/UC0wtnJlwqKNe+2LpdTNElpRzwNX0oSWg/+h0
         s54OvcE8Vzp0a8djD43YvLZc1Xv3NtNJ8J4TEU/N7odi7xYu5RTrpubcHIBx0eRzjqSl
         vfx0kBXtcJqkf2VMUbWGgV/p3cY6+FhoemEQoROowwofu4vIAMSB63ekYxpJSH4xJciz
         aKGb9rJfqb/kOhYsbCpkZU04h/y28Bzv+cChRnBQBeciKbdbMY6XzvveGFwl+gihlzGh
         CEeBRGwtD8UUbNAShJSR+9x7J6UjFCzCiDk85otFkpTlZunL9KN87s5KKCexUtWVEe3B
         DB0A==
X-Forwarded-Encrypted: i=1; AJvYcCVoLpqXJEjqrAVJku65sfxrfKxjxWFiHfA9cBcm+v/nloCkqRMEUvoqps7wTmL8LwDKDlMdtQwXhwW+cjd8Hy4N75SpyEjqudRpGnWZ5nmvjsJIGqcNWd1gX19F1zZtM54NIE9F1DAZ+iGudSvpG+6swawm1bXe/UKZiPXl/WQVU+jXtA==
X-Gm-Message-State: AOJu0YyE4PcmIOk7zx6+KTJtlZqXw+NUfnoCxHtWLQn2r+pjy8XfoUd+
	U+w7o62yh1WjhbI7xsXXsfZy3nHgHoHsnaSQDJrpxo8BzWbTJIvsfZbtXYBj
X-Google-Smtp-Source: AGHT+IEvftdwznEgDkq633cEgtwng1mS7I9fQC5OIBPjDd3jttKupLDcxY7G5Nlc3ySfC//AjuL7Gw==
X-Received: by 2002:a05:6000:1445:b0:368:4b9d:ee2c with SMTP id ffacd0b85a97d-36baace1998mr1455919f8f.19.1722492841664;
        Wed, 31 Jul 2024 23:14:01 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c032bsm18696455f8f.12.2024.07.31.23.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:14:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 01 Aug 2024 08:13:52 +0200
Subject: [PATCH 3/4] iio: adc: xilinx-ams: use device_* to iterate over
 device child nodes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-device_child_node_access-v1-3-ddfa21bef6f2@gmail.com>
References: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
In-Reply-To: <20240801-device_child_node_access-v1-0-ddfa21bef6f2@gmail.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Lee Jones <lee@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-leds@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722492833; l=1411;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=i0sBRG11zXAIKwjcoVFnL1Y8Swho6X1BW3kA0cfdhTg=;
 b=7m5HHkACNNgu/mKXKiw3ayPLFGCDzWUt0OJixovqW9e6tKnbUu5tW6DIs8OjCzuCw1sjzjPGM
 1aSWHyGe+yAAbReOXBk5pMYYe2cBhrBvsU4VvOuvv1pEID9ysZtlWuo
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use `device_for_each_child_node_scoped()` in `ams_parse_firmware()`
to explicitly state device child node access, and simplify the child
node handling as it is not required outside the loop.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index f051358d6b50..27d5e4a6f9d6 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -1275,7 +1275,6 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct ams *ams = iio_priv(indio_dev);
 	struct iio_chan_spec *ams_channels, *dev_channels;
 	struct device *dev = indio_dev->dev.parent;
-	struct fwnode_handle *child = NULL;
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
@@ -1297,13 +1296,11 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		num_channels += ret;
 	}
 
-	fwnode_for_each_child_node(fwnode, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		if (fwnode_device_is_available(child)) {
 			ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
-			if (ret < 0) {
-				fwnode_handle_put(child);
+			if (ret < 0)
 				return ret;
-			}
 
 			num_channels += ret;
 		}

-- 
2.43.0


