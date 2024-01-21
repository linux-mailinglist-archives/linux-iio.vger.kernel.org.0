Return-Path: <linux-iio+bounces-1784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943ED8355FB
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D86E281825
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F43374C1;
	Sun, 21 Jan 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8uL/rmW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853B37170
	for <linux-iio@vger.kernel.org>; Sun, 21 Jan 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705845097; cv=none; b=BviiRG/VKpQpcPV63cXCmtzXQEaa6IKqMsuI6gdYlRcg3UvZjgSF5TX7i/xKktWe5auQL0jDzJlxwoAs/+VBz9EwvAP6DPKuUMFKQg4dXXocUVIzxj7+cX9vJdQSz2pzgaJ52FM3TjhsGxlLiRzQ8Ji0AU0779XL8Fiu8nxpgT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705845097; c=relaxed/simple;
	bh=M2M1C9Zq2KVphceWiVxi+Ihl8SIYuoLfNQmSlPP5PVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8h/b/W5C+soeChySreeWQA6guqjKtPHg/p5KWcrJksJ9PxeTmKrbBCGlP13Tlmf5GliCa5pKB/M9DbSb2eTYWsqlEUv+FwG67IxNSnlC3UBeyjBDXhHmc+BofHUmSWa0M5thNGv1nEb5ieyPVDVbjVllyM9xLXwtNs+4ylXUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8uL/rmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C66EC433F1;
	Sun, 21 Jan 2024 13:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705845097;
	bh=M2M1C9Zq2KVphceWiVxi+Ihl8SIYuoLfNQmSlPP5PVo=;
	h=From:To:Cc:Subject:Date:From;
	b=Y8uL/rmWQOK96xC5t8GlC0qFAKJhj47yum0udXAyA5q4l9VrZDFyVYZqO2Cy1hhny
	 A76x8MyGagcRe11YgvsP9AE7TPt4Y67IbJCgOyoAaRg7Rlz2M+rUMfAzO2Kpq7CWLJ
	 MD5xieiajaEIyLIQlzTGCR+qKhPzaABKS6vj0Dihp81QkYrjyJm92hmeCnYP3ZMRQE
	 ejFC5COWe11wLlaTeJvwhsL/77fBGta8iSLlIRwG/lWdKS64NN89FM4q+deMxiEzOW
	 R71EB0sIy6iN7JqykHO0RItvN2wmV+saUEeEoXEFaS+NvURgReM0PWC224aDLx+z/R
	 rcIG2p5sh1CDg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>
Subject: [PATCH] iio: humidity: hdc3020: Add Makefile, Kconfig and MAINTAINERS entry
Date: Sun, 21 Jan 2024 13:51:23 +0000
Message-ID: <20240121135123.71506-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Something when wrong when applying the original patch and only the
c file made it in.  Here the rest of the changes are applied.

Fixes: c9180b8e39be ("iio: humidity: Add driver for ti HDC302x humidity sensors")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS                   |  8 ++++++++
 drivers/iio/humidity/Kconfig  | 12 ++++++++++++
 drivers/iio/humidity/Makefile |  1 +
 3 files changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..1b590e6f6bdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22005,6 +22005,14 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
 F:	drivers/media/i2c/ds90*
 F:	include/media/i2c/ds90*
 
+TI HDC302X HUMIDITY DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+M:	Li peiyu <579lpy@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
+F:	drivers/iio/humidity/hdc3020.c
+
 TI ICSSG ETHERNET DRIVER (ICSSG)
 R:	MD Danish Anwar <danishanwar@ti.com>
 R:	Roger Quadros <rogerq@kernel.org>
diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 2de5494e7c22..b15b7a3b66d5 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -48,6 +48,18 @@ config HDC2010
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc2010.
 
+config HDC3020
+	tristate "TI HDC3020 relative humidity and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say yes here to build support for the Texas Instruments
+	  HDC3020, HDC3021 and HDC3022 relative humidity and temperature
+	  sensors.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc3020.
+
 config HID_SENSOR_HUMIDITY
 	tristate "HID Environmental humidity sensor"
 	depends on HID_SENSOR_HUB
diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
index f19ff3de97c5..5fbeef299f61 100644
--- a/drivers/iio/humidity/Makefile
+++ b/drivers/iio/humidity/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_AM2315) += am2315.o
 obj-$(CONFIG_DHT11) += dht11.o
 obj-$(CONFIG_HDC100X) += hdc100x.o
 obj-$(CONFIG_HDC2010) += hdc2010.o
+obj-$(CONFIG_HDC3020) += hdc3020.o
 obj-$(CONFIG_HID_SENSOR_HUMIDITY) += hid-sensor-humidity.o
 
 hts221-y := hts221_core.o \
-- 
2.43.0


