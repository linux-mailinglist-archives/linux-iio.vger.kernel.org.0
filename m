Return-Path: <linux-iio+bounces-2708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CE859116
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 17:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301ECB210EE
	for <lists+linux-iio@lfdr.de>; Sat, 17 Feb 2024 16:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B3A7D3E8;
	Sat, 17 Feb 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KviDyznt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CE1CD1F;
	Sat, 17 Feb 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708188235; cv=none; b=dsUKBRTw6vBfNulz0SNUdGiFjNVzxZ9j1AMLOe6XxSpRATUDraTd+LR2A0Udja5ULUV9xi8Z+c7rWkhZGIqsaAXwI0QIDnyqkUPmYR32FObp9uXUoX+kYya3WgpZeU3Cx1HRuLC8Y/utoitZALwU0+RSq2WgwrVlDG494fpSEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708188235; c=relaxed/simple;
	bh=QrHoWfZbRHMq4P70zGYxGeka18F/ERWgdcsa9lr19q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id0W8T1r89UkdTG3zFatiDaajbAZu7GUVnuhnmhP6nNtZ89ytg0mHobLCAPeo/e3H9W46dFgSn6R1l+1f461a6hucBNnfPU2xDL3m2oxn6MryogegUzDBianrgG7xS5Okb9dadgArbok8U7e8k07om1UafCxpGsIXSu38s8bBUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KviDyznt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CAAC433C7;
	Sat, 17 Feb 2024 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708188235;
	bh=QrHoWfZbRHMq4P70zGYxGeka18F/ERWgdcsa9lr19q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KviDyzntTMWqfml6AyUnyUImc/FFb8emara+J8z5R45nk5lZBbQMTpOYND+6Sy+lo
	 9EpVBKpy3/RZ4JcR72Kml1Li365Ny/qACqfcfKkAKDeFt3EyKncfVsq/zCRn3Fw8eW
	 GP9tjE2YoWWROkFBKZIp3j9BFMpD4+HJP7jdl3NZwjleccowCWpbB7IH4RFO9jcbWh
	 aRKGBFQXRdyTy0FJeQcitkNPehrJOHqLBItzfVn15VrvrAd+7AZ5Kdmsu66zc0Av9q
	 BHA9BOGkyT3XuuLzbf/3KxKN8y/7euxZnVj+Sqr0n5iZGg1RqBT55+kXsfEapU5OBl
	 C1ahWFtLd1N5g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 08/15] iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
Date: Sat, 17 Feb 2024 16:42:42 +0000
Message-ID: <20240217164249.921878-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240217164249.921878-1-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0921ff2d9b3a..cd3a7e46ea53 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -302,7 +302,6 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
-	struct fwnode_handle *fwnode;
 	struct rzg2l_adc_data *data;
 	unsigned int channel;
 	int num_channels;
@@ -330,17 +329,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(&pdev->dev, fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
 		ret = fwnode_property_read_u32(fwnode, "reg", &channel);
-		if (ret) {
-			fwnode_handle_put(fwnode);
+		if (ret)
 			return ret;
-		}
 
-		if (channel >= RZG2L_ADC_MAX_CHANNELS) {
-			fwnode_handle_put(fwnode);
+		if (channel >= RZG2L_ADC_MAX_CHANNELS)
 			return -EINVAL;
-		}
 
 		chan_array[i].type = IIO_VOLTAGE;
 		chan_array[i].indexed = 1;
-- 
2.43.2


