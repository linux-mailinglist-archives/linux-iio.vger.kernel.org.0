Return-Path: <linux-iio+bounces-2665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7A858495
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F851F2226C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA91332A0;
	Fri, 16 Feb 2024 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYKPTIRA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2696132C0F;
	Fri, 16 Feb 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106008; cv=none; b=sWvs/+hFd5CpEQ8GVDM7shKA0Vn+6brP1qLv8Pv32BgB/N+qbEvGzjhH0Vj8qdFdPwITjS/sbtejCpL8R917eHtUkSz4ZOaX/UsnZTsNLgduQRq1H3FoCGw/RQP2GSkOkEumQE5q3uKWddICN36vbWxnY1I8Ml/PYKXiKQ0YwkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106008; c=relaxed/simple;
	bh=QrHoWfZbRHMq4P70zGYxGeka18F/ERWgdcsa9lr19q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki27AchaSJV+crYd0hZ4aG+O9YCgnPQj+6aCgaTp3KE4R1dFQsUKopl4X9Cign1Cgon8eSUpiLKRC+04B/MW5IcdERdz2SCedCXzZOKWRSMjDWDr3lOxnsx6+67hhsuVBOitQx6cmAw9ki/OvbsqRkntQktSRHEUE8ieNW0gWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYKPTIRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3197C43390;
	Fri, 16 Feb 2024 17:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106008;
	bh=QrHoWfZbRHMq4P70zGYxGeka18F/ERWgdcsa9lr19q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYKPTIRAmh3TjzAwG6dVCT4pk5tWiZLy7NER9iV3LUfsIkFDuaGh+eNz/xIZzjt4G
	 8OIG978NUzQrQarInv+yX12BssldtO+ZKj1dTyotR0jWDbt9xhl8hKsxSYWZpx84J5
	 CrcDwi2wpoCuAkujjEHiNGQgFDO336OQw6CtmU4JBZSRE80L4wXErpzuVoP7S/SQXp
	 zOj7+gYJTj64Ji7Q3ymgM/We4v+8FHCsu853xl6ygJvirNtwYpqWDrreTJxliSOKlD
	 Wfiqc740u0SzR1GSi0euIczwSaDkPUdMBQYYoUzJ5GuI7ewnoibMA+O12ls31ir/1V
	 2+QkWhLDDWlUw==
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
Subject: [PATCH v3 08/15] iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:14 +0000
Message-ID: <20240216175221.900565-9-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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


