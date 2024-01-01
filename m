Return-Path: <linux-iio+bounces-1371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53598214A4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB4281BD5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CB6FD7;
	Mon,  1 Jan 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVOQ2ef1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E878BE5;
	Mon,  1 Jan 2024 17:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9215C433C8;
	Mon,  1 Jan 2024 17:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130001;
	bh=JIYJBHDVe5HowU0NJPYu9GVb95JvOvlq5pZk1HIw3jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVOQ2ef10sReR+ToTUhcJ1ve31QCxWb15It5YvAv1w9CbJOVFiMljx03wv2d7beWq
	 PoA6GIcHPtyuKr4RSLTz0Zf0gXnhdEWWtsMEmqqMSZmCm6NHPPetMyZA4M6nnhFyv5
	 Hca9+GAQZcETEraEKY+6LycR1jGd7Mp9Dq9gEj0TmunmgqDrWcmKOAai8OjQ85JSiP
	 F2Uvk+Jh+7eyfTBopZ7xvmLOeIh4WCIHfDA7atswJv8g30zL0hsicThlrE1KUKjUto
	 wQxUHSI1WFJTsvgwIB5Zc/rh+jbR4VVBBoHeobU59WL/2cjuciyh6mUTWZ7V9dp5NA
	 swe0Vnh4MLvBw==
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
Subject: [RFC PATCH 02/13] iio: adc: max11410: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:00 +0000
Message-ID: <20240101172611.694830-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240101172611.694830-1-jic23@kernel.org>
References: <20240101172611.694830-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This use of the new cleanup.h scope based freeing infrastructure allows
us to exit directly from error conditions within the
device_for_each_child_node(dev, child) loop.  On normal exit from that
loop no fwnode_handle reference will be held and the child pointer
will be NULL thus making the automatically run fwnode_handle_put() a
noop whereas it will release the reference held on early breaking or
returning from within the loop.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 drivers/iio/adc/max11410.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
index 6af829349b4e..790a95474bb9 100644
--- a/drivers/iio/adc/max11410.c
+++ b/drivers/iio/adc/max11410.c
@@ -696,7 +696,7 @@ static int max11410_parse_channels(struct max11410_state *st,
 	struct device *dev = &st->spi_dev->dev;
 	struct max11410_channel_config *cfg;
 	struct iio_chan_spec *channels;
-	struct fwnode_handle *child;
+	struct fwnode_handle *child __free(fwnode_handle) = NULL;
 	u32 reference, sig_path;
 	const char *node_name;
 	u32 inputs[2], scale;
@@ -735,47 +735,37 @@ static int max11410_parse_channels(struct max11410_state *st,
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
@@ -793,10 +783,8 @@ static int max11410_parse_channels(struct max11410_state *st,
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
2.43.0


