Return-Path: <linux-iio+bounces-25171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C9BE6E25
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 09:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AF7405889
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330930FC02;
	Fri, 17 Oct 2025 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2cU4Ekx"
X-Original-To: linux-iio@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0991024166D;
	Fri, 17 Oct 2025 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684851; cv=none; b=qQX67SQamwQ6Z7ybV3Bf9RbGPPWihbiWrSBFerBfe874Xxl4YCXFCT3kVah5iM5ZIFtfXss57CJRjXgsUlmdEw/MW5XuyUU7Rmu6u5ZobZXdbxSWr4e+ljgxyjUPggAsosI6051vstNEIoLLcfVNelxNWEvUAoXh/2yjiZEAN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684851; c=relaxed/simple;
	bh=cY/Weje5coPtoLUsq2fidT5RhMfyCgPWKAH7j7GAfQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sUmYl/dwJWL5kQghnmI1O/EBwoJwsxQUem89V8bcPflTbhhuaXLOS73Eegt36xK31huqYmS0Ky+5d8St8dOnKS6sMD9u1suqtDa9UA17sLwh5ogp5YuBWOZRDG3BGlZsTRuniqI3d0ZUauWBKtOHXL3U9p4byIwgD+oDUcMR210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O2cU4Ekx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=z60jJjD1yYvrzflT05tbaE9g1ERMGfi3yyxZR5gxLms=; b=O2cU4EkxLN2MKtJxICFUDgMX3e
	YTpWBZmxPUqQ0ydHNkddfN2XZlvl9YXxWzr5nm8ZbMpEabvS/LFhf1r/V7+XQzthteHTcdohfB/41
	LOWSLHq8Kta/jfg7rUcdG8+/SUzvLe+wGuQVZRXPFuMXADogIj9OfwnFn7eEE9J69WkL5Qme7RK+6
	qFc0TGl5Dc8j13BZPu7ew9fHiH99+1opq+Bo5KQgxF1VdzwQFJXpIN2QcXjTFBEJ2x2olNS8iZkWd
	bcWZ+3ns+y6wPz0rH1bcBvCm+xlrlw6M9xqKutMRJfHGpr42sfK4vIa7oqv8mT1/D5hO8h5nn4STY
	gGi2GEMQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9eYj-00000006vp9-2Xu4;
	Fri, 17 Oct 2025 07:07:29 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: adc: qcom-vadc-common: fix vadc_scale_fn_type kernel-doc
Date: Fri, 17 Oct 2025 00:07:27 -0700
Message-ID: <20251017070728.1637804-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix multiple warnings in enum vadc_scale_fn_type by adding a leading
'@' to the kernel-doc descriptions.

Fixed 14 warnings in this one enum, such as:
Warning: include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
 'SCALE_DEFAULT' not described in enum 'vadc_scale_fn_type'
Warning: ../include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
 'SCALE_THERM_100K_PULLUP' not described in enum 'vadc_scale_fn_type'
Warning: ../include/linux/iio/adc/qcom-vadc-common.h:123 Enum value
 'SCALE_PMIC_THERM' not described in enum 'vadc_scale_fn_type'

Also prevent the warning on SCALE_HW_CALIB_INVALID by marking it
"private:" so that kernel-doc notation is not needed for it.

This leaves only one warning here, which I don't know the
appropriate description of:
qcom-vadc-common.h:125: warning: Enum value
 'SCALE_HW_CALIB_PMIC_THERM_PM7' not described in enum 'vadc_scale_fn_type'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 include/linux/iio/adc/qcom-vadc-common.h |   27 ++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- linux-next-20251016.orig/include/linux/iio/adc/qcom-vadc-common.h
+++ linux-next-20251016/include/linux/iio/adc/qcom-vadc-common.h
@@ -83,27 +83,27 @@ struct vadc_linear_graph {
 /**
  * enum vadc_scale_fn_type - Scaling function to convert ADC code to
  *				physical scaled units for the channel.
- * SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
- * SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
+ * @SCALE_DEFAULT: Default scaling to convert raw adc code to voltage (uV).
+ * @SCALE_THERM_100K_PULLUP: Returns temperature in millidegC.
  *				 Uses a mapping table with 100K pullup.
- * SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
- * SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
- * SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
- * SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
+ * @SCALE_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * @SCALE_XOTHERM: Returns XO thermistor voltage in millidegC.
+ * @SCALE_PMI_CHG_TEMP: Conversion for PMI CHG temp
+ * @SCALE_HW_CALIB_DEFAULT: Default scaling to convert raw adc code to
  *	voltage (uV) with hardware applied offset/slope values to adc code.
- * SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
+ * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC using
  *	lookup table. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
+ * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC using
  *	100k pullup. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
+ * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC using
  *	lookup table for PMIC7. The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * @SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
  *	The hardware applies offset/slope to adc code.
- * SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
+ * @SCALE_HW_CALIB_PMIC_THERM: Returns result in milli degree's Centigrade.
  *	The hardware applies offset/slope to adc code. This is for PMIC7.
- * SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
+ * @SCALE_HW_CALIB_PM5_CHG_TEMP: Returns result in millidegrees for PMIC5
  *	charger temperature.
- * SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
+ * @SCALE_HW_CALIB_PM5_SMB_TEMP: Returns result in millidegrees for PMIC5
  *	SMB1390 temperature.
  */
 enum vadc_scale_fn_type {
@@ -120,6 +120,7 @@ enum vadc_scale_fn_type {
 	SCALE_HW_CALIB_PMIC_THERM_PM7,
 	SCALE_HW_CALIB_PM5_CHG_TEMP,
 	SCALE_HW_CALIB_PM5_SMB_TEMP,
+	/* private: */
 	SCALE_HW_CALIB_INVALID,
 };
 

