Return-Path: <linux-iio+bounces-2997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4258624FD
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A2428298D
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2E63E48C;
	Sat, 24 Feb 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHnaQHCW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3518021
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777994; cv=none; b=h/a13d2aiaCe81/LOM6fL1TTTf4ISPWX2Y4x9n53N/wY6XJlmmRmh9GoZexcH3qsztdj5BvMQYR0KM6di76ILB/ZPLSudhbesTsUnAia2ITYeOoS0CZ4lrzorV2iFCbeo4lTxCiwhY+mVgzivW3q+e7YY+3m83UMkXbuNWlb600=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777994; c=relaxed/simple;
	bh=ZEX5V6rA/qW9iOHSltdQCogQSODPZOZ+ahDrhUmzuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFru3B52ijbe8PYZ0os5QjPnJ9HYwmNny2PESlVHrYmPIh3aHJ5K6ADQwvTV5EXIkpkpF7VwwgQrZrb/u6nRDu8Rjj3lCsEy7niq2Vl2jHZEKc+16zCq73sTqIB6YslSUJ4XPED7i/4Pdn5BpDhKLC6V9s1OFLWOVOY1tTgTz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHnaQHCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10D4C433F1;
	Sat, 24 Feb 2024 12:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777993;
	bh=ZEX5V6rA/qW9iOHSltdQCogQSODPZOZ+ahDrhUmzuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHnaQHCWVKlV7sgvKhsgqCGbIyU1922hMsOKjubselcgzAfEYtvnKA4RGOMwTZRV0
	 vXfomgzxAW0EqrBwiSD6HBdQ6aRqawrxvpG8/qtI9lj4M5JVx9grc5igV/CoeADki5
	 lSOl9zM9lUZJJ1nBeqEWIFkU3bCnR9LkRuOGIN3IXYSSmsFIMAntAk8Pj0AI6euGHv
	 SeoayNIyiMlgsQpOFvO1A+qsFk7OSlh69CgzcJvijOrLayPXWbaJwcMx4lB97zF4ik
	 +Me7O5Lrxzy3qL+0mhaPFKZ0qv9JQOOP1/jUoOvto8rc4TBG/u+Jx2Arve2Z1ucwKc
	 bnhR4pjF0llnQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
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
Subject: [PATCH v5 8/9] iio: dac: ad3552r: Use device_for_each_child_node_scoped()
Date: Sat, 24 Feb 2024 12:32:14 +0000
Message-ID: <20240224123215.161469-9-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
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

Removing the goto err; statements also allows more extensive use of
dev_err_probe() further simplifying the code.

Cc: Mihail Chindris <mihail.chindris@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad3552r.c | 51 +++++++++++++++------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index a492e8f2fc0f..e14a065b29ca 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -880,7 +880,6 @@ static void ad3552r_reg_disable(void *reg)
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	struct fwnode_handle *child;
 	struct regulator *vref;
 	int err, cnt = 0, voltage, delta = 100000;
 	u32 vals[2], val, ch;
@@ -949,53 +948,45 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 		return -ENODEV;
 	}
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
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
@@ -1003,7 +994,7 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 
 		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
 		if (err < 0)
-			goto put_child;
+			return err;
 
 		dac->channels[cnt] = AD3552R_CH_DAC(ch);
 		++cnt;
@@ -1021,10 +1012,6 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	dac->num_ch = cnt;
 
 	return 0;
-put_child:
-	fwnode_handle_put(child);
-
-	return err;
 }
 
 static int ad3552r_init(struct ad3552r_desc *dac)
-- 
2.44.0


