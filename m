Return-Path: <linux-iio+bounces-2429-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77637850B2A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5761C22637
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 19:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953CA5D905;
	Sun, 11 Feb 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2wGx5Xq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508465D751;
	Sun, 11 Feb 2024 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707679629; cv=none; b=KWWPQXg2L2x6qFxNScoKU5MvYtxLmdxtvqSCJyvJrjasYzwwF0lKpnUBkhFfirrgeHlp5dJvwANrfj6ZFaf54HGHhpomBGS75CqxEaJJBl1xY+uBZKBwd1+D73VM/AZuWdlKZq/rsEqgauCiEueBJmw2AeQh1sQd2kTkU11Aamo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707679629; c=relaxed/simple;
	bh=J3pZmC2KKyBlCMRCD/FTEFP9csRqHwyyTXOVXEmuL5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHKvJKtpqE3IKeXieWViXBUE6tSUe6yPDsaEBO9pw/iM+qHZqJ9azBY9NdSUq+LBgZDdNBG0QKZqOG0LRq1QuofpRTk2XFdf2NuUFSZ+QWsYOmOMFp501WItmudLj+d9pnJLXImkEv68mg1Us/MdEbfFOwE3xirdjVCb3cdILRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2wGx5Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC3DC433A6;
	Sun, 11 Feb 2024 19:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707679629;
	bh=J3pZmC2KKyBlCMRCD/FTEFP9csRqHwyyTXOVXEmuL5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2wGx5XqlGx+e6wAlcQJm8GmK45CuoMAJUa27M3i9iTdSJUMwA8Q1mXj70tQtQVOz
	 dbFXAzXzq1rIKsP2hQiIITqjIIk0gQrBixcQgd++leQ+XsgmS2yffXccPfQnjs7vLE
	 jUfsV9t7N1s48e6IJ4rSedTgbPB1EkZZzVXWxv0HidG2S8uWwwIUjcSVwOwXS5ylTZ
	 BBrZyQiNrRgW7CzZko7jVxpMezmsz7KSRvGgU8rAfuS0GfoY+81IwfdjOcgC3h+m+H
	 PSo2CCJnQa/LcRePEmLPEv3syyxv9GjSnWNNxQMt/9SF2HnMbzJ69Daq83m46y774I
	 mO6U4hKZsIXCA==
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
Subject: [PATCH v2 07/14] iio: adc: rzg2l_adc: Use device_for_each_child_node_scopd()
Date: Sun, 11 Feb 2024 19:25:33 +0000
Message-ID: <20240211192540.340682-8-jic23@kernel.org>
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

Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0921ff2d9b3a..cd3a7e46ea53 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -302,7 +302,6 @@ static irqreturn_t rzg2l_adc_isr(int irq, void *dev_id)
 static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l_adc *adc)
 {
 	struct iio_chan_spec *chan_array;
-	struct fwnode_handle *fwnode;
 	struct rzg2l_adc_data *data;
 	unsigned int channel;
 	int num_channels;
@@ -330,17 +329,13 @@ static int rzg2l_adc_parse_properties(struct platform_device *pdev, struct rzg2l
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(&pdev->dev, fwnode) {
+	device_for_each_child_node_scoped(&pdev->dev, fwnode) {
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
2.43.1


