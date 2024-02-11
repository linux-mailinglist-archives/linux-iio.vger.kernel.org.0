Return-Path: <linux-iio+bounces-2434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C84850B34
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450D31F23E14
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EBC5D8E5;
	Sun, 11 Feb 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo8czDJk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118E333CD2;
	Sun, 11 Feb 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679661; cv=none; b=LqG4Nv54Muk0BNL/Y73BUjTFPXzjdmkQZDMyIMlyeo1ivxpRbRQSWY6oCYHCfqS9iUJwOg7mWsGpxMbmc3xbDIAzWRReR4aQJPNsJeAgmvD6yWYO1QJyYPR0/PJXztM1x9IwzUhi8MtEzWsPFHBsHYH0Hfe7onSkmFzT4F6OsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679661; c=relaxed/simple;
	bh=rgEoX0FYtg6ykzmDeCYk0UhT2vVjd9laU6gobcrnOxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS1/qNPMjJE3Z/f6jdXh9Yr0YsxVfh2yKM9ste+tORhYZnNSYaoQgE80q1Oe1Qs2cT1mG4XYwP5vAnbvs+tUHfpmoJ7ISQDC6+H9IEV019sSih3aF1mNVDgErutGEh0WKxSDSoGf2rvJK8gfH6qpbE/q4C4Ut7ovQlB8h04aFSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo8czDJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1C4C433F1;
	Sun, 11 Feb 2024 19:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679660;
	bh=rgEoX0FYtg6ykzmDeCYk0UhT2vVjd9laU6gobcrnOxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zo8czDJkeTSrIi/J7Es5h4WO/uifUc0/4RRdNg49xqhuaZHK4LnsrkrASspNRzktZ
	 s/dFDBOwTY33VKbwkA2qCsTwqIOqpNRrYO4KP2AogKKpgGpXnP1xlWUAHVwB3zjZZ0
	 D1xO2WbYWItFfXdcGCiJMe7ZqeYa2VzM86JweU0Lf08GNpvWlZ0ekH0b1RDY0lVc0i
	 LN3NDwzs0gmNvU2Ui0Qp/i5bgwqAxqc7GK+S8An9Vl1qPdr8BZ13oQtJX5lwLItA/U
	 FkjPPHoIIGrhwMy6iXtHUn0n3MJ5XdeKFkdgYhJuyZon2CPH21xvk7F0vRFlGf/xRW
	 KZZilQCCF12Jw==
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
Subject: [PATCH v2 12/14] iio: dac: ad3552r: Use device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:38 +0000
Message-ID: <20240211192540.340682-13-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
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
2.43.1


