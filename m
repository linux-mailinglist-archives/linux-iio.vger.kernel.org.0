Return-Path: <linux-iio+bounces-2426-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A1850B23
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7861C225D0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6D95DF3D;
	Sun, 11 Feb 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlqdvnfM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789E95DF34;
	Sun, 11 Feb 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679611; cv=none; b=IJY5bFbgHW7GbJpN3M77fSSVK2zEhEOiLPQ8Yk/FBvQJTfE8eLzlyAb1lBmh4naJrgnWv+a2tCLqjvr5klg4kILJ4yW5DZvBn+FO03m2P3bQvTJhWfPQArtxJd9MBWI11EA9pMX0w5fXzj5tlH3exPUocJUgIflk7Mhol2Qj4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679611; c=relaxed/simple;
	bh=DU/iOWMCd1LvRo1Q6PdWhghdA/tvkisyLu7vKgJfAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qocEpCLxKKCG/htLjHgitTirn8vLvj/dNV4K9JuYRiqwRIh58SbFH9Pob7cIs2+s4Qpc1Jre9l+rmHe7A1hs6nckqTDY6RhgPqFzWiXTatUn7pIAl5vOHCUm/bYaIN2/OtSH0Br2gyzsNXi/uZ6Z3M0NelzDaBbLqBen6PzhdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlqdvnfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8652C43394;
	Sun, 11 Feb 2024 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679611;
	bh=DU/iOWMCd1LvRo1Q6PdWhghdA/tvkisyLu7vKgJfAP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlqdvnfMHYa/VszGsLdRVPN2qK57Ox7pE58Y0wx8utpoCPtY80XS5uHjRwTkXhu3Z
	 bdNHMdtwxNV8AY5ZlDsnT2tD0lkYfzHWbL+L/Q4B9t795o2s+sLZah+ysL9TvqKuNc
	 YnxrjNtU/vVC47lP3jIbFyWoF0oWUbW1CmqJdXJyhYddlFDoXrsb1aagYaJDCRnRGY
	 vgXeJEO1tW7qYGj4aikvO6bajJxLSmBSI4e21nRK5cGEB6stEs+wcTnxDyKkFd58Df
	 jOlprYtUdbCHq7yWPZWoZH5XYXz+rbBM+/9YNzmBGB4WIT2YiFmVMz5K7GeTtBzuYe
	 Vdo8x+No+GSTg==
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
Subject: [PATCH v2 04/14] iio: adc: max11410: Use device_for_each_child_node_scoped()
Date: Sun, 11 Feb 2024 19:25:30 +0000
Message-ID: <20240211192540.340682-5-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240211192540.340682-1-jic23@kernel.org>
References: <20240211192540.340682-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Switching to the _scoped() version removes the need for manual
calling of fwnode_handle_put() in the paths where the code
exits the loop early. In this case that's all in error paths.

Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max11410.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 6af829349b4e..45368850b220 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -696,7 +696,6 @@ static int max11410_parse_channels(struct max11410_state *st,
 	struct device *dev = &st->spi_dev->dev;
 	struct max11410_channel_config *cfg;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *child;
 	u32 reference, sig_path;
 	const char *node_name;
 	u32 inputs[2], scale;
@@ -720,7 +719,7 @@ static int max11410_parse_channels(struct max11410_state *st,
 	if (!st->channels)
 		return -ENOMEM;
 
-	device_for_each_child_node(dev, child) {
+	device_for_each_child_node_scoped(dev, child) {
 		node_name = fwnode_get_name(child);
 		if (fwnode_property_present(child, "diff-channels")) {
 			ret = fwnode_property_read_u32_array(child,
@@ -735,47 +734,37 @@ static int max11410_parse_channels(struct max11410_state *st,
 			inputs[1] = 0;
 			chanspec.differential = 0;
 		}
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
 
 		if (inputs[0] > MAX11410_CHANNEL_INDEX_MAX ||
-		    inputs[1] > MAX11410_CHANNEL_INDEX_MAX) {
-			fwnode_handle_put(child);
+		    inputs[1] > MAX11410_CHANNEL_INDEX_MAX)
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Invalid channel index for %s, should be less than %d\n",
 					     node_name,
 					     MAX11410_CHANNEL_INDEX_MAX + 1);
-		}
 
 		cfg = &st->channels[chan_idx];
 
 		reference = MAX11410_REFSEL_AVDD_AGND;
 		fwnode_property_read_u32(child, "adi,reference", &reference);
-		if (reference > MAX11410_REFSEL_MAX) {
-			fwnode_handle_put(child);
+		if (reference > MAX11410_REFSEL_MAX)
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Invalid adi,reference value for %s, should be less than %d.\n",
 					     node_name, MAX11410_REFSEL_MAX + 1);
-		}
 
 		if (!max11410_get_vrefp(st, reference) ||
-		    (!max11410_get_vrefn(st, reference) && reference <= 2)) {
-			fwnode_handle_put(child);
+		    (!max11410_get_vrefn(st, reference) && reference <= 2))
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Invalid VREF configuration for %s, either specify corresponding VREF regulators or change adi,reference property.\n",
 					     node_name);
-		}
 
 		sig_path = MAX11410_PGA_SIG_PATH_BUFFERED;
 		fwnode_property_read_u32(child, "adi,input-mode", &sig_path);
-		if (sig_path > MAX11410_SIG_PATH_MAX) {
-			fwnode_handle_put(child);
+		if (sig_path > MAX11410_SIG_PATH_MAX)
 			return dev_err_probe(&indio_dev->dev, -EINVAL,
 					     "Invalid adi,input-mode value for %s, should be less than %d.\n",
 					     node_name, MAX11410_SIG_PATH_MAX + 1);
-		}
 
 		fwnode_property_read_u32(child, "settling-time-us",
 					 &cfg->settling_time_us);
@@ -793,10 +782,8 @@ static int max11410_parse_channels(struct max11410_state *st,
 			cfg->scale_avail = devm_kcalloc(dev, MAX11410_SCALE_AVAIL_SIZE * 2,
 							sizeof(*cfg->scale_avail),
 							GFP_KERNEL);
-			if (!cfg->scale_avail) {
-				fwnode_handle_put(child);
+			if (!cfg->scale_avail)
 				return -ENOMEM;
-			}
 
 			scale = max11410_get_scale(st, *cfg);
 			for (i = 0; i < MAX11410_SCALE_AVAIL_SIZE; i++) {
-- 
2.43.1


