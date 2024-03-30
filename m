Return-Path: <linux-iio+bounces-3958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA7B892CB9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 20:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830201C211E5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Mar 2024 19:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4240867;
	Sat, 30 Mar 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k05ELnRy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5AA200D9
	for <linux-iio@vger.kernel.org>; Sat, 30 Mar 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711825771; cv=none; b=dx5spUV9yEq0XSfnnQqtvvBg8sk6jS/gXqJulpLjGUAPM93NvKe2Gh+ovRXb1XEc1toqkv9p+CEjwFzRl/7hfg7KLEJwQxKUQ1lWsTNnxX9H4hGF7E4NbsFyxsqdvXkO79InjhWUAOCFvFGdL0NbX7h36uZ+xVHijb8KHqL7Y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711825771; c=relaxed/simple;
	bh=zO1Fm8arirm596tju5FVU2TBB6HGajHMgVL9jq1CBWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbK7QImdIzgd/dBIB6AcRTpO1MJ05bAWvSs+cOJ9crJV/e0cMfv3SvFaA70SerBOElnfLZbbpIsBY0Zx8lw8Pi6MkXfXsx8x9bFXpXoVhJxCGKPRW2ofl2/5Zj3JcPxVU4OWTlXoo0MDgJKqpeoy1MafASBljU8jlwiKRwDJWHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k05ELnRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B89C433F1;
	Sat, 30 Mar 2024 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711825770;
	bh=zO1Fm8arirm596tju5FVU2TBB6HGajHMgVL9jq1CBWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k05ELnRyYMDjukwGoEfJN4m9k+/elgh44O7nr8JqTmex4I4L34h41B0937KH/zKe2
	 feCIqShs81L1x+Omu8xSns9kxp6agbvjtrfgB3OG3Wmnpa2q9JU8kpND/RF+tZvfjB
	 GCrVNmVfmk6MaVfzy1MNLhAqd0nDdYku/YekcobfFkBMoarVw42MHfto7YoOsrDuhs
	 pLpB49G5VXJGcsg/7yBzGStO/0SS0AT/TTScyPYTA6IwMs/aCVRb6JFKV3fZQS/ZPw
	 Hebjx+Rk17IIlKuIN37bw2/1Baav8wqi5Vnd7pJokdOLK/xbp4B0/Id9swi0tcMStU
	 3S7QUV6kmJvBA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: adc: pac1934: Use device_for_each_available_child_node_scoped() to simplify error handling.
Date: Sat, 30 Mar 2024 19:08:49 +0000
Message-ID: <20240330190849.1321065-9-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330190849.1321065-1-jic23@kernel.org>
References: <20240330190849.1321065-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also change both firmware parsing functions to return meaningful errors.
Whilst for the ACPI case this isn't that useful, for the generic fwnode
case we can return the errors coming from the property parsing instead
of just whether we succeeded or not.

Cc: Marius Cristea <marius.cristea@microchip.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/pac1934.c | 77 ++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index e0c2742da523..f751260605e4 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1079,8 +1079,8 @@ static int pac1934_chip_identify(struct pac1934_chip_info *info)
  * documentation related to the ACPI device definition
  * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
  */
-static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
-					      struct pac1934_chip_info *info)
+static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
+					     struct pac1934_chip_info *info)
 {
 	acpi_handle handle;
 	union acpi_object *rez;
@@ -1095,7 +1095,7 @@ static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
 	if (!rez)
-		return false;
+		return -EINVAL;
 
 	for (i = 0; i < rez->package.count; i += 2) {
 		idx = i / 2;
@@ -1118,7 +1118,7 @@ static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
 		 * and assign the default sampling rate
 		 */
 		info->sample_rate_value = PAC1934_DEFAULT_CHIP_SAMP_SPEED_HZ;
-		return true;
+		return 0;
 	}
 
 	for (i = 0; i < rez->package.count; i++) {
@@ -1131,7 +1131,7 @@ static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
 	if (!rez)
-		return false;
+		return -EINVAL;
 
 	bi_dir_mask = rez->package.elements[0].integer.value;
 	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
@@ -1143,19 +1143,18 @@ static bool pac1934_acpi_parse_channel_config(struct i2c_client *client,
 
 	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
 	if (!rez)
-		return false;
+		return -EINVAL;
 
 	info->sample_rate_value = rez->package.elements[0].integer.value;
 
 	ACPI_FREE(rez);
 
-	return true;
+	return 0;
 }
 
-static bool pac1934_of_parse_channel_config(struct i2c_client *client,
-					    struct pac1934_chip_info *info)
+static int pac1934_fw_parse_channel_config(struct i2c_client *client,
+					   struct pac1934_chip_info *info)
 {
-	struct fwnode_handle *node, *fwnode;
 	struct device *dev = &client->dev;
 	unsigned int current_channel;
 	int idx, ret;
@@ -1163,46 +1162,38 @@ static bool pac1934_of_parse_channel_config(struct i2c_client *client,
 	info->sample_rate_value = 1024;
 	current_channel = 1;
 
-	fwnode = dev_fwnode(dev);
-	fwnode_for_each_available_child_node(fwnode, node) {
+	device_for_each_child_node_scoped(dev, node) {
 		ret = fwnode_property_read_u32(node, "reg", &idx);
-		if (ret) {
-			dev_err_probe(dev, ret,
-				      "reading invalid channel index\n");
-			goto err_fwnode;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "reading invalid channel index\n");
+
 		/* adjust idx to match channel index (1 to 4) from the datasheet */
 		idx--;
 
 		if (current_channel >= (info->phys_channels + 1) ||
-		    idx >= info->phys_channels || idx < 0) {
-			dev_err_probe(dev, -EINVAL,
-				      "%s: invalid channel_index %d value\n",
-				      fwnode_get_name(node), idx);
-			goto err_fwnode;
-		}
+		    idx >= info->phys_channels || idx < 0)
+			return dev_err_probe(dev, -EINVAL,
+					     "%s: invalid channel_index %d value\n",
+					     fwnode_get_name(node), idx);
 
 		/* enable channel */
 		info->active_channels[idx] = true;
 
 		ret = fwnode_property_read_u32(node, "shunt-resistor-micro-ohms",
 					       &info->shunts[idx]);
-		if (ret) {
-			dev_err_probe(dev, ret,
-				      "%s: invalid shunt-resistor value: %d\n",
-				      fwnode_get_name(node), info->shunts[idx]);
-			goto err_fwnode;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "%s: invalid shunt-resistor value: %d\n",
+					     fwnode_get_name(node), info->shunts[idx]);
 
 		if (fwnode_property_present(node, "label")) {
 			ret = fwnode_property_read_string(node, "label",
 							  (const char **)&info->labels[idx]);
-			if (ret) {
-				dev_err_probe(dev, ret,
-					      "%s: invalid rail-name value\n",
-					      fwnode_get_name(node));
-				goto err_fwnode;
-			}
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "%s: invalid rail-name value\n",
+						     fwnode_get_name(node));
 		}
 
 		info->bi_dir[idx] = fwnode_property_read_bool(node, "bipolar");
@@ -1210,12 +1201,7 @@ static bool pac1934_of_parse_channel_config(struct i2c_client *client,
 		current_channel++;
 	}
 
-	return true;
-
-err_fwnode:
-	fwnode_handle_put(node);
-
-	return false;
+	return 0;
 }
 
 static void pac1934_cancel_delayed_work(void *dwork)
@@ -1485,7 +1471,6 @@ static int pac1934_probe(struct i2c_client *client)
 	const struct pac1934_features *chip;
 	struct iio_dev *indio_dev;
 	int cnt, ret;
-	bool match = false;
 	struct device *dev = &client->dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
@@ -1519,16 +1504,16 @@ static int pac1934_probe(struct i2c_client *client)
 	}
 
 	if (acpi_match_device(dev->driver->acpi_match_table, dev))
-		match = pac1934_acpi_parse_channel_config(client, info);
+		ret = pac1934_acpi_parse_channel_config(client, info);
 	else
 		/*
 		 * This makes it possible to use also ACPI PRP0001 for
 		 * registering the device using device tree properties.
 		 */
-		match = pac1934_of_parse_channel_config(client, info);
+		ret = pac1934_fw_parse_channel_config(client, info);
 
-	if (!match)
-		return dev_err_probe(dev, -EINVAL,
+	if (ret)
+		return dev_err_probe(dev, ret,
 				     "parameter parsing returned an error\n");
 
 	mutex_init(&info->lock);
-- 
2.44.0


