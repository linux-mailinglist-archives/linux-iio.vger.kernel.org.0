Return-Path: <linux-iio+bounces-21262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A469AF65DA
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3067A7554
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749292BE7DC;
	Wed,  2 Jul 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSavGmzb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF62271473;
	Wed,  2 Jul 2025 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497419; cv=none; b=Lz7VjOJ8ts8XyYQTIyhLxLOLaOPXIShlo4+yHG8vo9JLou2HrNao278JjLCpWhXxuxh8cPc0bmS7Z7+1ndYeNfMjEKc1dLM4OM2m78vin5CaaNz5X/qsdl1ptAKOfIVCVj96vsoOg+CojUFFR/rsxzZpJYi1erWNMuUxpcEtNnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497419; c=relaxed/simple;
	bh=SRaABmozsgF0f3mE46kXYAgf49NAeAKQ51vLOpdMXlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RcpGbwR8OFM9LHbMB1Vr3rJvffbAReRf8WoYixMT6UWKNgQMef0nWOduq5chgTCDKmXyAlJ6d5ls0gmGH2FpIc8yJErAJK6y/cbEi71hd0YZeIP1LQrwvtgL4ONk7T0CCrEB6PYofjUKtNAlT8Xiz1E9wVIkAPF5+j0EhYzxZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSavGmzb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-607780f0793so1519487a12.2;
        Wed, 02 Jul 2025 16:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497415; x=1752102215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTqgcGzLOzohiTbEZCmB5DbpLjs82c1oETtUUMblFyM=;
        b=gSavGmzbJOJ4R3NlC7yg/IXFH6jXcjzvVijnq8X4wdpt/gTEckLIarltF0YttR5B6g
         ddcC6fVO8jXbPyIk2PC1BCjA+pf1kHiXu++c04pNWKhmbsAEawzXJ1NplgTYCpOup0qi
         V1djF6NEYpoVZAqBv8b1rLmjdpGEMI6UQ1Qc6uaUZQbrInpskW6zXsOoV4vvEtpKSbFd
         XyjSyAoQ0bDewW24m3YGNqXnOiR3Ef6c3X6cx3JIwMicvm3aDsgU6yAdbOaNMvK4+jPl
         W42HJxEE50b2lMICqmCue2CuLuF6L9I86VzlLxY3gxw2dEyjUcGpBDK9T0gPnJ6tE1R/
         /gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497415; x=1752102215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTqgcGzLOzohiTbEZCmB5DbpLjs82c1oETtUUMblFyM=;
        b=qxXPs8V9IRtLqbtIPHlr0u9l47xxUYoEaxvvaMPCZpXE2ZsZcTA5ff7AXNTNJRaxU5
         XkdlKarF7rzHeYhzcegkTH2e1pFhG0BnMiTxz97a5PSYkD2xpNjrZuDfYe861MdQozNN
         tui6lOQD7lGpssN3gyPdfxOuTHPucWVC1iFStNr/jOYWU2Kk2qrbILqBONXwFVg1/yJ5
         AE42AfXnkavhQ7x0cdjuPpeF0snkHP/E7d1TNAA0XfQhGdqlAxp979M4TMVEcxBOw78y
         SDAGJmSdkn6hGRriyD7ulK2uqEA+zEV9oR31O1/N9d++g1dZ0cgWQOVTLBubilkxfTSl
         mhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrQs0o8R+UsGtZNFWdJ1GSe0X5BShezR0U5I1jH0fwK8kEaszSABphMbV8Yrd7kG3L0u9UHeSOAuB8WEcZ@vger.kernel.org, AJvYcCV+cH+o7IrMcFBhkzq0hqTpeeAHfLbc4KEhB5AYponumaL6YbU1ZrL8irnbTlVkeJlgFPYMWVQJHOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo+iiVbGhr9uFerUSfUyoobH6de1MTYMuXdeCQ3rxwl3PQ8P0S
	wAa+6nc1x7lCfnacha2hpnr8zyM10ApAdsNLkAVOwMXZBfT7bf70ihZ7
X-Gm-Gg: ASbGncv17a+nZ4qP9ZDjdYbiJKOIUeZF6apd6y3mEEVuwsiyn08OWJLhVAhvSrY/lfX
	NNfGVeZJD9wTAnMKfxurmI/KcUpWpU2cvhRohZYSOgW1pqILeOFvt4HHNLYGrmZdUEYlBW8Hs9j
	NPd7heBbKHk9PiJNacZKfXlHlB4ulqwy4nXzypc3QCyDRABoyUnO3z+o6WwV0+xNNmT2lYDA75d
	6QbRv0y10N5QjQV6YYcVLGY2J+n4QZ+wkW9B+V8a5lbZ+yqcsGW2zb0W5fiJXnKyCLL2I0UOjy9
	uqIwxZUZYctfiASbRAZOYhYkLfZCdlzxbSxS8rOrbII92awy2unR03VzO2OmZPqRJIp2QalkjkA
	wggyiBK+rzV2sFg+kJcqQrJIyhfP9vvJz
X-Google-Smtp-Source: AGHT+IFhKJNG+ljOldhF4FdYLjOhsK3OLt9cGTnI3B+UArDcStKyqEIKDX5ekKWliVL4hhSqVcvovQ==
X-Received: by 2002:a05:6402:2344:b0:606:c63b:e330 with SMTP id 4fb4d7f45d1cf-60e5361114emr1407071a12.11.1751497414664;
        Wed, 02 Jul 2025 16:03:34 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:33 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v11 1/8] iio: accel: adxl345: simplify interrupt mapping
Date: Wed,  2 Jul 2025 23:03:08 +0000
Message-Id: <20250702230315.19297-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230315.19297-1-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the sensor interrupt mapping by utilizing regmap_assign_bits(),
which accepts a boolean value directly. Introduce a helper function to
streamline the identification of the configured interrupt line pin. Also,
use identifiers from units.h to represent the full 8-bit register when
setting bits.

This is a purely refactoring change and does not affect functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/adxl345_core.c | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index e21ec6c15d15..6c437d7a59ed 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -1088,6 +1088,19 @@ static const struct iio_info adxl345_info = {
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
 
+static int adxl345_get_int_line(struct device *dev, int *irq)
+{
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (*irq > 0)
+		return ADXL345_INT1;
+
+	*irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+	if (*irq > 0)
+		return ADXL345_INT2;
+
+	return ADXL345_INT_NONE;
+}
+
 /**
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
@@ -1203,23 +1216,16 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
-	if (irq < 0) {
-		intio = ADXL345_INT2;
-		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
-		if (irq < 0)
-			intio = ADXL345_INT_NONE;
-	}
-
+	intio = adxl345_get_int_line(dev, &irq);
 	if (intio != ADXL345_INT_NONE) {
 		/*
-		 * Any bits set to 0 in the INT map register send their respective
-		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
-		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+		 * In the INT map register, bits set to 0 route their
+		 * corresponding interrupts to the INT1 pin, while bits set to 1
+		 * route them to the INT2 pin. The intio should handle this
+		 * mapping accordingly.
 		 */
-		regval = intio ? 0xff : 0;
-
-		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
+		ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_MAP,
+					 U8_MAX, intio);
 		if (ret)
 			return ret;
 
-- 
2.39.5


