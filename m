Return-Path: <linux-iio+bounces-2670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD8F8584A4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F10CAB24736
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7A13174F;
	Fri, 16 Feb 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWgg31dk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DE1332B6;
	Fri, 16 Feb 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106038; cv=none; b=d8siM3lu8W67mUO14oeF/Llvn2PQ1HoXfau6WCfKQjt6G8COpXRZSBU1mDQMAl2PBURt/sIK96oUahS4vGb/qEitbYnSO+7OHNGIFKfvXjY6K90jjSoCyw/AeValU9Hl5sYN7BN3/RS6qKbYk0QFz/ejl2qxxAFb/Xq0GDBqoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106038; c=relaxed/simple;
	bh=qJ6hucCm0b/moPq3jjlQ5H1GFMO0uvJDXAqN+WPZ58Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOZl50XSMGzOgxBjik6GUHSqmo3zNgw+/eWyeCSVfp8IHeS/dql+7Y7ogQU+tYQemAY03u+xJ3EiWHZkNAkYgq4VoeYVUJN/yQEFhwceanSh7yLJZ8Dnk/1xrY5pYDfeevOONStbh3t7gMC0y7QEsWydp0ZoNuPuHn5Ek1VOfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWgg31dk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4772EC433F1;
	Fri, 16 Feb 2024 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708106038;
	bh=qJ6hucCm0b/moPq3jjlQ5H1GFMO0uvJDXAqN+WPZ58Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HWgg31dkEMbasvk1jCrt7o9iqjeDTgyY8XbgC51tAPJq1jDCHmm/nA6ruZvz4DjBq
	 2g9xSRLqoI1uXHeDFxBlo1+JI342BqVwrEfEKXN1WAiULeBh7KDTqsWANyGRQbrdOf
	 iAJd6H8YDTPDzxD5/qxVp9LFz1QXWTkzrsoRzfso6gFe2YyMgAQX/Tu+mCdzqMnPfS
	 k4G/q45c/LEeCTM+M3CEtlkRfLh0pkwYoCnuAreAkEWcxVup3Fl+vkxTnvmC6uFGxt
	 5FG4AYwNdAXEPwR0u4y6c8Gzuw+dXiBQKcZ8zDpKQ/uEeaO6ZA4t6XhCyU3bWmpqdk
	 cR1wx8jpv+yrQ==
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
Subject: [PATCH v3 13/15] iio: dac: ad3552r: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:19 +0000
Message-ID: <20240216175221.900565-14-jic23@kernel.org>
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
2.43.2


