Return-Path: <linux-iio+bounces-15146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FBBA2CDCF
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 21:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86AD2188D8D2
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0571DF97C;
	Fri,  7 Feb 2025 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UIusOfQF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440731A0BFD
	for <linux-iio@vger.kernel.org>; Fri,  7 Feb 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738958997; cv=none; b=c5OBs2bO6n8u3fpSnTyxuJpO/wTl31NvfSYCn+8v+NirmKuexwPFgZHOT5iCldSGsn0ewpQEaWGekhOffMt4G2jASlf/uTX6fFbq072VY0b07DKacxc/w7uh19nWS42Chwe77dyj43B7ob+Xr8I35SoU0RiXbQOXtcuFsjEAl1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738958997; c=relaxed/simple;
	bh=DhX51StZjS6ZG3+/IYLjnj3db6LuckpDYDUdYX9k1yk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ragHqbLS2lnyx4E12kir1JDIoqnOObdA1QqIPDWhAdPHDF2mD5jSFTsiZtbhKmm9yb+hQszBFP2pbsDSVx3StSipYtYX3m5hQ/UivxOhhI1Pn1onJA7MsM0mSd97RGlomSvUfLJfKQQg9DgdUQlwfGfc8JtJpcySmHbg34rJGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UIusOfQF; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5f2e13cb359so738054eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Feb 2025 12:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738958994; x=1739563794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=UIusOfQFpbY0NZvz5tAJ9fg8VlI6XO5rYeDpZsnIEI1hMh/11Fnm2tAsTds3HbjQWt
         m25ljZfwm3dwa1Ak8jrt/ywVI+R0kCULi1DBT5+T04Jx9wGklL1g4FIlHUbnpnBeFhVO
         EPXFfVOpQtIqPI7hFU/Mzcz+rLRUTHGVfTMs6UT+C2tsuiS/ymBIFtSA3ZwBCj3YOFNX
         q2nzi7fspti4uM7BnoJqUluIeJ6gnQB/5xg5H9sU5lLuLG430EEvx5Ln6YbjPHicFd0k
         dD3VRZAGH4dXbxjywOhHWWrxPQLxBs1imrTA16DJoDO0z9OAY4MEziEaHHftWV2E7Bv4
         hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738958994; x=1739563794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uXVd6FnRPX1W8Wg/eWBdOZEvpGo7dHFBW2WCW32Bdw=;
        b=s8lxwXOmGdIJaQCtrnUByFkIlEaO5RsIv60r2fT7qsn0EAoJKIu75oiJ8ZTinjAc3r
         76XqKVDGK8dveH9z6XSMEOPHGCSwPMHj5Vy4rSPyGlcS3DeqCIyxEOqrQmLuFx7xRP9Y
         YY/Iu/xp7AB99jo5ARju3YxEni8H69+q4rGVmdOx3xjok+nW2Y1ZyNO6zpnmoOAv8EIJ
         izYQpP0iylgiPnpmkwI0FTdqFKcuWUrnGhk2vPsAYJqKlmOj/coAFwHb2K6oi4iR9fhB
         6R5A0ggxO4Qwxub4sW8IzoUJZrNdXvU9lOsATiPUqT+0w4Biucr/RSlCRqmLIMkJL8MW
         vNbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpwNhGQXyOzoyTcnTJ6RKdoFgWs+jKlZK1xcqtr2OylWuRy0Jh7SgJKDdJFxmgWhYsRWjSMu0NUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8fE8pqK7j7aZ1dJlPbphcdP7pqelrV+t4FAghD/itxx6lLeM
	hg35+QwkYTVVEosqMFIzoUJl45DV+nfl+6fMNO0jEMxbXniVOdUe2cJKVlWDGwEsiDSpPXpns44
	Y
X-Gm-Gg: ASbGncvo2XmHwwLGEIBosZ4mis81CoeW10w8FODpZm0GTR2p5JBp8TlIGRbpO6vSwvn
	UEuirCm3BY3rQUIs62E2U9m9h25jTvrqNbmfgT3moZjbTfCV/KetCOK7H6ZbmxNjq4LFs8hO7oE
	0eyaoZqdYTEfvZEDfiZfOV1SngYE0tJVu2KV39TwRuooJrT2XhJqAVIEYv5yynHg7IupoYhvzcX
	UKS3W3KKD9a9JDoOkez35oVySX8Q780Gb273FvPwNdTHpTdWBDWbaj1nnGOxbiZ5By+pWW7j9kt
	moJVfln+K1BRjSahvxCAU3Lq+UeWlQP4HIVq9wTiX4td7pY=
X-Google-Smtp-Source: AGHT+IHBvhoA/1vsHrBvSb8E+WSGvN4wz1yxpemeyG9bRp8GQ1qD6XCZmUkIVAeGNsD1uexoiKGc/Q==
X-Received: by 2002:a05:6820:80c:b0:5f3:4175:1d7f with SMTP id 006d021491bc7-5fc5e75e777mr2414422eaf.8.1738958994116;
        Fri, 07 Feb 2025 12:09:54 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b08d4sm930387eaf.2.2025.02.07.12.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 12:09:53 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Feb 2025 14:09:12 -0600
Subject: [PATCH v8 15/17] doc: iio: ad4695: add SPI offload support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-dlech-mainline-spi-engine-offload-2-v8-15-e48a489be48c@baylibre.com>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
In-Reply-To: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Document SPI offload support for the ad4695 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Fixed double "all"
* Don't abbreviate "sampling_frequency" attribute names for clarity.

v5 changes: new patch in v5
---
 Documentation/iio/ad4695.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/iio/ad4695.rst b/Documentation/iio/ad4695.rst
index 9ec8bf466c15bf94cbae2ebdb61875f66af1264f..ead0faadff4b5aede2a34bac52e103e375da6f21 100644
--- a/Documentation/iio/ad4695.rst
+++ b/Documentation/iio/ad4695.rst
@@ -47,6 +47,36 @@ In this mode, CNV and CS are tied together and there is a single SDO line.
 To use this mode, in the device tree, omit the ``cnv-gpios`` and
 ``spi-rx-bus-width`` properties.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+When used with a SPI offload, the supported wiring configuration is:
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |    GP0/BUSY |-------->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    |             |         |             |
+    |             |         +-------------+
+    |         CNV |<-----+--| PWM         |
+    |             |      +--| GPIO        |
+    +-------------+         +-------------+
+
+In this case, both the ``cnv-gpios`` and  ``pwms`` properties are required.
+The ``#trigger-source-cells = <2>`` property is also required to connect back
+to the SPI offload. The SPI offload will have ``trigger-sources`` property
+with cells to indicate the busy signal and which GPx pin is used, e.g
+``<&ad4695 AD4695_TRIGGER_EVENT_BUSY AD4695_TRIGGER_PIN_GP0>``.
+
+.. seealso:: `SPI offload support`_
+
 Channel configuration
 ---------------------
 
@@ -158,6 +188,27 @@ Unimplemented features
 - GPIO support
 - CRC support
 
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad469x_fmc/index.html
+
+.. seealso:: `SPI offload wiring`_
+
+When SPI offload is being used, some attributes will be different.
+
+* ``trigger`` directory is removed.
+* ``in_voltage0_sampling_frequency`` attributes are added for setting the sample
+  rate.
+* ``in_voltage0_sampling_frequency_available`` attributes are added for querying
+  the max sample rate.
+* ``timestamp`` channel is removed.
+* Buffer data format may be different compared to when offload is not used,
+  e.g. the ``buffer0/in_voltage0_type`` attribute.
+
 Device buffers
 ==============
 
@@ -165,3 +216,20 @@ This driver supports hardware triggered buffers. This uses the "advanced
 sequencer" feature of the chip to trigger a burst of conversions.
 
 Also see :doc:`iio_devbuf` for more general information.
+
+Effective sample rate for buffered reads
+----------------------------------------
+
+When SPI offload is not used, the sample rate is determined by the trigger that
+is manually configured in userspace. All enabled channels will be read in a
+burst when the trigger is received.
+
+When SPI offload is used, the sample rate is configured per channel. All
+channels will have the same rate, so only one ``in_voltageY_sampling_frequency``
+attribute needs to be set. Since this rate determines the delay between each
+individual conversion, the effective sample rate for each sample is actually
+the sum of the periods of each enabled channel in a buffered read. In other
+words, it is the value of the ``in_voltageY_sampling_frequency`` attribute
+divided by the number of enabled channels. So if 4 channels are enabled, with
+the ``in_voltageY_sampling_frequency`` attributes set to 1 MHz, the effective
+sample rate is 250 kHz.

-- 
2.43.0


