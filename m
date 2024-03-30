Return-Path: <linux-iio+bounces-3948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094A1892CAC
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12A01F22943
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D9B3BBE3;
	Sat, 30 Mar 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL6QgJIF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494B82E3E5
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824838; cv=none; b=tO4FLFYU/jXxrJ7cOBYgJuI3lw+56pPwbZ9v2lQApIBISfCWH29YuB9pL5mFjYuK1pLST5PJ1EYsJ+7a7IoMwhM4RVB5Lbor/P79hTE6th/QbnnxxGLbJRF1HcO1nKhY8RKb7BN8jA+UzJIKYgbQ+ftXt6k8B43VsciCaIQvpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824838; c=relaxed/simple;
	bh=ZEX5V6rA/qW9iOHSltdQCogQSODPZOZ+ahDrhUmzuXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO5+LgY665lbR/2bNcu7D8eeQaq52ACUc87IKoYVSmVOv9vtsObNgY/98Q8ApD8n3ENDpqiJqzkQ9t+hfFL5wHQ9kwAURKNvA52tVK6l0UVb+g0RtPilmCovSWVWv0k+36YrqXuJml5HddZRy0Yv8QVwWFzWmVeOwfT1lCEWk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL6QgJIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EE1C433C7;
	Sat, 30 Mar 2024 18:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711824837;
	bh=ZEX5V6rA/qW9iOHSltdQCogQSODPZOZ+ahDrhUmzuXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DL6QgJIFLGQNBn3eexFoRBN+yc12j0lsHANgcnuMBH7Xn0QShWgpoTj7b5WTjHbUl
	 RBj9tK+aUGYj849qEp+baW373VDhr0E/CsT5CM7yMXIDp1CYnU350WHXKYAR6nLIiL
	 K7liwidi4Q9FiI3kKoiZ3V4x02I4JIVL+1CBz548o/APhaJfaJYbTBCFJ7cj6URLhK
	 YRrUbGEYb+Vxvc7t9X9V/xnceunV52rgRh6cttOtzCEuwAIsskW8WCz7T9NnV4U2Qb
	 HIXwrxUiHz2zyIRUtp+gJ2k0Ucl9PopdQQOhr+OKWjYOr1LMXtRX6m+VnFJV8pI2U3
	 v1jiPHLYHIbGw==
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
Subject: [PATCH v6 7/8] iio: dac: ad3552r: Use device_for_each_child_node_scoped()
Date: Sat, 30 Mar 2024 18:53:04 +0000
Message-ID: <20240330185305.1319844-8-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330185305.1319844-1-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
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


