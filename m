Return-Path: <linux-iio+bounces-2662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5D858490
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5611F222B6
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94613328F;
	Fri, 16 Feb 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQUuGSZ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E6132C35;
	Fri, 16 Feb 2024 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105991; cv=none; b=I5HEYQ4Btnf0D1TT6vNPjugkrlaHMgISNpdSZ4kgd8NfBqqS0iXlX4uDoFDlNLmEbqRlIbKmp6h4hgA2+vSjXIbnBlmToZlzs2K5uheodPjxsyfrBFtdjPaRSHBgAg8QjopNoksoFAxyI6QtFjRwNy9QW1a0O2Ss6Cy+njU3l3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105991; c=relaxed/simple;
	bh=iojKGFHS6Uwh1iJBxwwefEnfrUPfJjcrCNVF0odaKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVdAdBht/9YMhhyVQHLee4FaM6JFryv1ODvAxxJxF4uaZ2wyeaOejUhCBWJz8kbMW1WUEzsjxJrKkk55WsMaNNAAqp0v014lfAe7eM7PMVqxF2Qvxq9YmoNBY0EJM+LGHSy+e9D698apCYhXMOcY3pZDXbvB9x2QwlgOBcQrXaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQUuGSZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA640C43399;
	Fri, 16 Feb 2024 17:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105990;
	bh=iojKGFHS6Uwh1iJBxwwefEnfrUPfJjcrCNVF0odaKFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQUuGSZ8oks7AHEPa4tQfCJKOQEvROEWT6rZrI1bxkAYmIBELVt2ijrnrPTWFlOCy
	 J5svY63Q4aND3zg6dFemt8WkB0SXj+J73M8C1+p6+cRBQI2lFEzq1Uh5m4vFYtxgex
	 bGKuEKc64XTAp4pXOiD0sgJ0Gzk/6864+cxfNdxPzArBSBbfSYd/vxcQGSzBrDGWBg
	 oY5PlKpayqmckGWX1H9LeVFaowq+sDPh697gJlU47ndw3l8NJOO0T+8Xl6Nd+z2iNX
	 /Ej57VCUMxMsfb6cuGIULUORi+6f7bSV4XylYsQVBjlWrSts5C/D2J128AIH7lTyru
	 VAoJmwhfrHJSg==
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
Subject: [PATCH v3 05/15] iio: adc: max11410: Use device_for_each_child_node_scoped()
Date: Fri, 16 Feb 2024 17:52:11 +0000
Message-ID: <20240216175221.900565-6-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216175221.900565-1-jic23@kernel.org>
References: <20240216175221.900565-1-jic23@kernel.org>
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
2.43.2


