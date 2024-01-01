Return-Path: <linux-iio+bounces-1379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4548214B4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8CE281AB9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA408C1A;
	Mon,  1 Jan 2024 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaFBjM9s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF28F4E;
	Mon,  1 Jan 2024 17:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA634C433C7;
	Mon,  1 Jan 2024 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130062;
	bh=JTSIIrXCSy/TvL6/LUtr4dULemI+i6Mc1adooApvcXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaFBjM9sFD9C0/08xWTMRGh5rdYu0AlKGpjYY+94RRqYOPoghWKOeJviT74MEJC5i
	 IMT9MbwcalcAZnEK+CVKnZPwIiB7JHxRHFc66W6nXqacyy1pVCNIRUXVf8bwfhzVkX
	 5mlVvsqaycKsLtBcI43jPNkV0WX+8ju05vc92zVzUXKX6iECf7JYaRE1xSoFLm5ebI
	 4/3st69czBxgETiTYwUFQq5kxjeMcoDaV8++rLJbT5smlNJpqEEAIifnF53MjwUAK4
	 ICCfHayS8AjesT37sybdS6+rrmBJTovefaOk9OXr/Iw997tW97dwThhJg6C9sDIPw3
	 bbNbFkjnW5jig==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 10/13] iio: dac: ad3552: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:08 +0000
Message-ID: <20240101172611.694830-11-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop. On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop.

Removing the goto err; statements also allows more extensive use of
dev_err_probe() further simplifying the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mihail Chindris <mihail.chindris@analog.com>
---
 drivers/iio/dac/ad3552r.c | 50 +++++++++++++++------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a492e8f2fc0f..f21c88cb480a 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -880,7 +880,7 @@ static void ad3552r_reg_disable(void *reg)
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 	struct regulator *vref;
 	int err, cnt = 0, voltage, delta = 100000;
 	u32 vals[2], val, ch;
@@ -951,51 +951,43 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 
 	device_for_each_child_node(dev, child) {
 		err = fwnode_property_read_u32(child, "reg", &ch);
-		if (err) {
-			dev_err(dev, "mandatory reg property missing\n");
-			goto put_child;
-		}
-		if (ch >= AD3552R_NUM_CH) {
-			dev_err(dev, "reg must be less than %d\n",
-				AD3552R_NUM_CH);
-			err = -EINVAL;
-			goto put_child;
-		}
+		if (err)
+			return dev_err_probe(dev, err,
+					     "mandatory reg property missing\n");
+		if (ch >= AD3552R_NUM_CH)
+			return dev_err_probe(dev, -EINVAL,
+					     "reg must be less than %d\n",
+					     AD3552R_NUM_CH);
 
 		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
 			err = fwnode_property_read_u32_array(child,
 							     "adi,output-range-microvolt",
 							     vals,
 							     2);
-			if (err) {
-				dev_err(dev,
+			if (err)
+				return dev_err_probe(dev, err,
 					"adi,output-range-microvolt property could not be parsed\n");
-				goto put_child;
-			}
 
 			err = ad3552r_find_range(dac->chip_id, vals);
-			if (err < 0) {
-				dev_err(dev,
-					"Invalid adi,output-range-microvolt value\n");
-				goto put_child;
-			}
+			if (err < 0)
+				return dev_err_probe(dev, err,
+						     "Invalid adi,output-range-microvolt value\n");
+
 			val = err;
 			err = ad3552r_set_ch_value(dac,
 						   AD3552R_CH_OUTPUT_RANGE_SEL,
 						   ch, val);
 			if (err)
-				goto put_child;
+				return err;
 
 			dac->ch_data[ch].range = val;
 		} else if (dac->chip_id == AD3542R_ID) {
-			dev_err(dev,
-				"adi,output-range-microvolt is required for ad3542r\n");
-			err = -EINVAL;
-			goto put_child;
+			return dev_err_probe(dev, -EINVAL,
+					     "adi,output-range-microvolt is required for ad3542r\n");
 		} else {
 			err = ad3552r_configure_custom_gain(dac, child, ch);
 			if (err)
-				goto put_child;
+				return err;
 		}
 
 		ad3552r_calc_gain_and_offset(dac, ch);
@@ -1003,7 +995,7 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 
 		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
 		if (err < 0)
-			goto put_child;
+			return err;
 
 		dac->channels[cnt] = AD3552R_CH_DAC(ch);
 		++cnt;
@@ -1021,10 +1013,6 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	dac->num_ch = cnt;
 
 	return 0;
-put_child:
-	fwnode_handle_put(child);
-
-	return err;
 }
 
 static int ad3552r_init(struct ad3552r_desc *dac)
-- 
2.43.0


