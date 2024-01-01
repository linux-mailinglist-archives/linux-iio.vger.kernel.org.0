Return-Path: <linux-iio+bounces-1374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572BB8214A9
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F32281A0F
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jan 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA08828;
	Mon,  1 Jan 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la6OXOmJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4FF8BE5;
	Mon,  1 Jan 2024 17:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74330C433CC;
	Mon,  1 Jan 2024 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704130024;
	bh=ozsSYFV5e7XdTlhrbVWP9N6auZ3btR7QaCsF8q/QKuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la6OXOmJ++eQfSzCgr2m9KkFhKRBQeZN3N1lDs/rTCTEFayMAOptpu5ioltCGC460
	 GIcUeyDD0MepP4k7u3bBdj0eM6V+BerwAjgVqoQmbbDEOe2B6SL2+vs55CL2iiuExL
	 RQHOFj+qgsqLxjqBSzchircTiqyynBuEtSsFo74tvpmikOoKQiCaiC0LWVdrTkC0Rp
	 y4iUi9Ia4hI05cVHcC+pX6Kdg5x+QGihBpVNMechbLWqw68j+RRK8rMSOTGOSdwpWt
	 MVIwMbSnvCiyVSrEzHQ28ZUG2xDFbyfgcjErET3pJE4tLeSshGTdvBrROQdEBp2ait
	 7NA7uWMfq4qow==
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
Subject: [RFC PATCH 05/13] iio: adc: rzg2l_adc: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Mon,  1 Jan 2024 17:26:03 +0000
Message-ID: <20240101172611.694830-6-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0921ff2d9b3a..08af54824f25 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -302,7 +302,7 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
-	struct fwnode_handle *fwnode;
+	struct fwnode_handle *fwnode __free(fwnode_handle) = NULL;
 	struct rzg2l_adc_data *data;
 	unsigned int channel;
 	int num_channels;
@@ -332,15 +332,11 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 	i = 0;
 	device_for_each_child_node(&pdev->dev, fwnode) {
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
2.43.0


