Return-Path: <linux-iio+bounces-1656-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D62182D1A4
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896501C20A1E
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DD6134;
	Sun, 14 Jan 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe5lJGA0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB37472;
	Sun, 14 Jan 2024 17:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA8C43390;
	Sun, 14 Jan 2024 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705252861;
	bh=Sjp6tSD+gYOla0bsf2bUAXw2BNF3WegJcnJrNI68Sg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pe5lJGA0MHsCaVe75xHnkhiLtubd5honP+i3wFwGF5qmRgJ9PwzX38+/fxbABZSwr
	 leGpIy1gllWDdq6wWZZsuGdCTmCrpKCUF+OeIkFr5jwrz8n9nrLRzjKENg9QULJHHE
	 BQ/nWSGxfCMO5lCnqciZFJeQbQfsHtkftbcvosCgrAfez3jMDcdu4yCwdPhS0L2vN8
	 Ls1Dmta+QLf9cauOAdOceiJBsj7YKKf6fEi1UNjlXISZt6sab26vgoZuxUAt/uwrqP
	 SbNN5F+kKQfsm2LftrumjdO0RK462uf+eln1QBGxciv361Zqi6YnuwmwZHW+KRCAEI
	 m+pnz+hl6g+QA==
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
Subject: [PATCH 05/13] iio: adc: rzg2l_adc: Use __free(fwnode_handle) to replace fwnode_handle_put() calls
Date: Sun, 14 Jan 2024 17:20:01 +0000
Message-ID: <20240114172009.179893-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114172009.179893-1-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
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

Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


