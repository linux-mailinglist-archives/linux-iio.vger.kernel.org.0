Return-Path: <linux-iio+bounces-8383-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5ED94D677
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEE11F227CD
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB58629E4;
	Fri,  9 Aug 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z26bnmt5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39D15FD15
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228882; cv=none; b=aEZ895KC0XEeKdjq8sqCosVq2B1ImdYY5p/DgDe7+sMRc3SaoAGhF18y4632DrTeSkCqGAIkeBo7QFxEKqhI4OKkXyI3lqLV9fkFNmhyJvSCkkBs4qOiYTe2Rqmr01w3bh83lJuXfbriFJt6X3CnTxUZTlRFbHE2taRVfPSvI9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228882; c=relaxed/simple;
	bh=GKmFo3bmFk2IVwRE7ksCrTnyul2s0DsTqMziI0uIR6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kij4dWqNXe0XhvVElaPseRLQMANKqZVYoVyKAyjLDAbYHkZu9BX51YUNmgVvoVcE0xyGJ37pFodZiMXvB/+T+LwNsrc7+EOODQW9wk3pLeFTJy4u6EIkGNsuY64m/mihAAsXd3Ij81cnOKJDoghhoMyC5IvE3mn7Cs+zWQF/qlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z26bnmt5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe28eb1bfso13059031cf.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2024 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723228879; x=1723833679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/5uzNUVmRh9vWTdDmOIKmWFbEDxFk4bBzY+xGs2C1kM=;
        b=z26bnmt57rTDtXR28mANK0oVIKhQB2gMLDLaJsY6iB42x6f2AwDNLua2i3haVObLIP
         wydabmCS+EAqr12mtHqwbEYZIZxPGqTn5NVTMYUWR+Rx9YXAu09TfwEF+27sbU5mVcdK
         gPsXXlzYysJ8mUdTwdJaNiTUw4bCSU3719rAUjqpmuVpBvOydG+kfPEHD28Ms84FXi3x
         vK6TEW6bWObfrc4x6UCigj+eGeKUhprwPCrbvMN31lrNKCa+uxddwokfx/DRggllKMUO
         vYF1VLWTu69Zgw66QCAsebPA/vTHvLNiBlEwHOKZDDjKQWBV/Vo+a88OPilQ/nkqMq+0
         330Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228879; x=1723833679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5uzNUVmRh9vWTdDmOIKmWFbEDxFk4bBzY+xGs2C1kM=;
        b=iFd0QpSXUk3J+ph0wqnPp8gkuLeLBxz3zh77S/XxNAtlQCuD5l5KxK1BPVU1gn0/sK
         UvCZs62tUWK6c/W6eFRmn19htfu2Hzljo8yGO3gWM2SL1k/qROZ58JbNOp/3sIZFNMy4
         yFkjtBRWrGssvHdKAuBcmYC8mQ/USVnZeJTTM3TDCQxykVfTmZQOBNYKRkWIwPIX4rrd
         3ZkdjnvPsJ+MrUyN4FIzdGg5Hw7azBOTpp5oAuLZnUQDJ47R3PMwuDAI+6nn+LfiYSp7
         BcvRI6jL+SJJipz+OghpM3huAZDGbpMOzUQtihu5C9SiH1hHfUPuEZsl4ZQ1P3Jtn3J0
         vnLw==
X-Gm-Message-State: AOJu0Yx+cI6a0sOZgee8aS8WZRZY/2sQ8SSxulOomi0cv8tUMpnrBKC6
	EDA+oVmQGSHUSwHCGOIaxUnHOi0zxyyBMRCdg48BuyM5XTSLgSxp4ABY4cxKZy4=
X-Google-Smtp-Source: AGHT+IEH6rBg8rXSvuwRkWBK6lSt3cf/9vZ3CI2KSvFnC2fju7qVpHmtGUnb5onX/VEKhf3izdyAMA==
X-Received: by 2002:a05:622a:258e:b0:451:9f75:4667 with SMTP id d75a77b69052e-453125a7e84mr28836101cf.28.1723228879272;
        Fri, 09 Aug 2024 11:41:19 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1d723asm370381cf.44.2024.08.09.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:41:19 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Fri, 09 Aug 2024 14:41:10 -0400
Subject: [PATCH v2 3/3] docs: iio: new docs for ad7625 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-ad7625_r1-v2-3-f85e7ac83150@baylibre.com>
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
In-Reply-To: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add documentation for the AD7625/AD7626/AD7960/AD7961 ADCs.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 Documentation/iio/ad7625.rst | 91 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                  |  1 +
 2 files changed, 92 insertions(+)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
new file mode 100644
index 000000000000..61761e3b75c3
--- /dev/null
+++ b/Documentation/iio/ad7625.rst
@@ -0,0 +1,91 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+====================
+AD7625 driver
+====================
+
+ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
+devices. The module name is ``ad7625``.
+
+Supported devices
+=================
+
+The following chips are supported by this driver:
+
+* `AD7625 <https://www.analog.com/AD7625>`_
+* `AD7626 <https://www.analog.com/AD7626>`_
+* `AD7960 <https://www.analog.com/AD7960>`_
+* `AD7961 <https://www.analog.com/AD7961>`_
+
+The driver requires use of the Pulsar LVDS HDL project:
+
+* `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
+
+To trigger conversions and enable subsequent data transfer, the devices
+require coupled PWM signals with a phase offset.
+
+Supported features
+==================
+
+Conversion control modes
+------------------------
+
+The driver currently supports one of two possible LVDS conversion control methods.
+
+Echoed-Clock interface mode
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+                                                +----------------+
+                     +xxxxxxxxxxxxxxxxxxxxxxxxxx| CNV            |
+                     X                          |                |
+                     v                          |    HOST        |
+          +----------------------------+        |                |
+          |      CNV+/CNV-   DCO+/DCO- |xxxxxxx>| CLK_IN         |
+          |                            |        |                |
+          |                            |        |                |
+          |       AD7625         D+/D- |xxxxxxx>| DATA_IN        |
+          |                            |        |                |
+          |                            |        |                |
+          |                  CLK+/CLK- |<xxxxxxx| CLK & CLK_GATE |
+          +----------------------------+        |                |
+                                                +----------------+
+
+Reference voltage
+-----------------
+
+Three possible reference voltage sources are supported:
+
+- Internal reference (only available on AD7625 and AD7626)
+- External reference and internal buffer
+- External reference
+
+The source is determined by the device tree. If ``ref-supply`` is present, then
+the external reference is used. If ``refin-supply`` is present, then the internal
+buffer is used. If neither is present, then the internal reference is used.
+
+Unimplemented features
+----------------------
+
+- Self-clocked mode
+
+
+Device attributes
+=================
+
+The AD762x is a fully-differential ADC and has the following attributes:
+
++---------------------------------------+--------------------------------------------------------------+
+| Attribute                             | Description                                                  |
++=======================================+==============================================================+
+| ``scale``                             | Scale factor to convert raw value from buffered reads to mV. |
++---------------------------------------+--------------------------------------------------------------+
+
+
+Device buffers
+==============
+
+This driver supports IIO triggered buffers.
+
+See :doc:`iio_devbuf` for more information.
diff --git a/MAINTAINERS b/MAINTAINERS
index a90972e1c5c5..97c9b03e1cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1268,6 +1268,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	Documentation/iio/ad7625.rst
 F:	drivers/iio/adc/ad7625.c
 
 ANALOG DEVICES INC AD7768-1 DRIVER

-- 
2.39.2


