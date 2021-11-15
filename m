Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C2644FD9E
	for <lists+linux-iio@lfdr.de>; Mon, 15 Nov 2021 04:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhKODrG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Nov 2021 22:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbhKODqt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Nov 2021 22:46:49 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2C5C061746;
        Sun, 14 Nov 2021 19:43:53 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id kl8so5962601qvb.3;
        Sun, 14 Nov 2021 19:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNlwuNoia1G1oP9SNKRZNXK98CkNYszLFmmmscXJdmM=;
        b=OITNPXYsDcuBUX8IuIJ+b7KIR5xGSajaUnyA1Rg263I0hw+7GCuVoe++nyhj7x3zIW
         cHsrsWZi4aMzqfHpGE3XUyhJw8xyrZLfGOi/NC2aZ6qdfQlO4rtCGFnEEIxGV2+Dna3X
         xELqclOzgVJQ0qjZjskg3IuWoPT1aoYApki2/TiP/ccPplej77D6L2vuuIjbxGB3LXty
         Ocw0nKwuCSQIS5vzPK20dNDpTEJ0ojxBY2iVDAvVgzIqGULrlZxlehWZfMbGMdBCrNCW
         Si4YUBwxB4Cl9M4bAisozRrnhqLCK2+TyktS1GstjVcVl5cPup0SEfVBnfyRFM2OyTwy
         ucfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNlwuNoia1G1oP9SNKRZNXK98CkNYszLFmmmscXJdmM=;
        b=RnD2YLtsV8Gui3puBv3H9EYhRmpjXf6R+yVY77FtTPzvaA96i7lE3XjRYDJOPNpmk/
         LJBmiTEKvkJXuGwHbnO30fNFe9HnYp0D4vCSxzewd/7k8ZVR4BRIcnFv1F6g9PbyeUP3
         REJ8PFStK5fSYOl4T4TnHbBXskhxanX4dtbWhOD2i+79MRC70U8ttJ2pvt77VGr3nbUX
         b5x2cJOA+ipVVWdjy4k+e5r4S/tb4etxN7mRN13YHTEpKda5NP6ssrlS5B7XFA3lD6TN
         gReMccXM0EoUhmTXjjS1CC+4w5gqflkwqz/aXyONPo+bPXtEjMHr+XQk/pXUfwM6QChq
         1vrg==
X-Gm-Message-State: AOAM532oGeoXVuLKGftOYd8z0tBCSfZzXgOALgRGWYkAvTJgz3D4HI3N
        /xEZyBKmj/q0K2b+gqMutfo=
X-Google-Smtp-Source: ABdhPJyyXigWsaQYbTaSTnsyvO0Xs8zpZ6fiVscxRenbxvf+uBOaFFCq0zsbLXKdmVHeDtuuXnNJXQ==
X-Received: by 2002:a05:6214:ace:: with SMTP id g14mr33746763qvi.12.1636947832809;
        Sun, 14 Nov 2021 19:43:52 -0800 (PST)
Received: from shaak.. (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h5sm206519qkn.62.2021.11.14.19.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 19:43:52 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v9 12/14] iio: afe: rescale: add temperature transducers
Date:   Sun, 14 Nov 2021 22:43:32 -0500
Message-Id: <20211115034334.1713050-13-liambeguin@gmail.com>
X-Mailer: git-send-email 2.32.0.452.g940fe202adcb
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
References: <20211115034334.1713050-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

A temperature transducer is a device that converts a thermal quantity
into any other physical quantity. This patch add support for temperature
to voltage (like the LTC2997) and temperature to current (like the
AD590) linear transducers.
In both cases these are assumed to be connected to a voltage ADC.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index ea162ba2a674..6bdcf6e139c7 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -422,11 +422,37 @@ static int rescale_temp_sense_rtd_props(struct device *dev,
 	return 0;
 }
 
+static int rescale_temp_transducer_props(struct device *dev,
+					 struct rescale *rescale)
+{
+	s32 offset = 0;
+	s32 sense = 1;
+	s32 alpha;
+	int ret;
+
+	device_property_read_u32(dev, "sense-offset-millicelsius", &offset);
+	device_property_read_u32(dev, "sense-resistor-ohms", &sense);
+	ret = device_property_read_u32(dev, "alpha-ppm-per-celsius", &alpha);
+	if (ret) {
+		dev_err(dev, "failed to read alpha-ppm-per-celsius: %d\n", ret);
+		return ret;
+	}
+
+	rescale->numerator = 1000000;
+	rescale->denominator = alpha * sense;
+
+	rescale->offset = div_s64((s64)offset * rescale->denominator,
+				  rescale->numerator);
+
+	return 0;
+}
+
 enum rescale_variant {
 	CURRENT_SENSE_AMPLIFIER,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 	TEMP_SENSE_RTD,
+	TEMP_TRANSDUCER,
 };
 
 static const struct rescale_cfg rescale_cfg[] = {
@@ -446,6 +472,10 @@ static const struct rescale_cfg rescale_cfg[] = {
 		.type = IIO_TEMP,
 		.props = rescale_temp_sense_rtd_props,
 	},
+	[TEMP_TRANSDUCER] = {
+		.type = IIO_TEMP,
+		.props = rescale_temp_transducer_props,
+	},
 };
 
 static const struct of_device_id rescale_match[] = {
@@ -457,6 +487,8 @@ static const struct of_device_id rescale_match[] = {
 	  .data = &rescale_cfg[VOLTAGE_DIVIDER], },
 	{ .compatible = "temperature-sense-rtd",
 	  .data = &rescale_cfg[TEMP_SENSE_RTD], },
+	{ .compatible = "temperature-transducer",
+	  .data = &rescale_cfg[TEMP_TRANSDUCER], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rescale_match);
-- 
2.32.0.452.g940fe202adcb

