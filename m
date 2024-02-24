Return-Path: <linux-iio+bounces-2993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452848624F9
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 13:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EE51C20EE8
	for <lists+linux-iio@lfdr.de>; Sat, 24 Feb 2024 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D237164;
	Sat, 24 Feb 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGvCKoPc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48A18021
	for <linux-iio@vger.kernel.org>; Sat, 24 Feb 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708777973; cv=none; b=G2hM9oXCbsG3aKk28MxWpuR0v3ncS4xTjex3MdOQ43UdS52xyjNB+ZD13p1j2LaZMr8LTl0kfnrwtybeQpJXl4hpnrrVytOeDtJRPsaO5GdD14IjbicyqA4da+liyxRF7ZMIiRywPg9ZG8SXHwD/HfhxPafwwJTRMSi1qglspT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708777973; c=relaxed/simple;
	bh=ox+Evaxjxa0J6imV8DxSC0CTBfvsevk1voCwRwmjOl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDDgULD3KTZBjW9593FCU3SIplOajjA9n5By2aTyyjgyDk34zeTmSwJYsZN/kvXjkl3ImIUznMxRj1DHE0saYLboqmyt5GNYvwIiHIPcHQkZM7snmR/vAl1LWl8fYodru+Ir6Iz/feEiYQQYfrKYpuMf7TB2+mPom/JcB1aZHTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGvCKoPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A147FC433F1;
	Sat, 24 Feb 2024 12:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708777973;
	bh=ox+Evaxjxa0J6imV8DxSC0CTBfvsevk1voCwRwmjOl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGvCKoPc6B34cOGbpt3YYEwdpY5p/A1MQ4s0fYn/IjPfB/bfd8w0Ta47+7ioKfHEM
	 njNbOcIU5iRZpwsZVIsAIxdjDDdRzV9CiPoLDacF5P6l1cqcTh7wh1bwpoNS7A5EFz
	 Qh3ehvrje7Jd/p/FENqKTaOgdFBsfFgYSe2AIHHE0JjkI4cpNSHsK1/+fX7Jq9uNqh
	 9brTzJzlUSiVdWYXGiKvDD3s1GDKYtrRv2EgzDcFUEURJqCoJMVtxL0OXHGlrh76jW
	 JBx+2lE/2SvkesQEGV4aDDoa/9hikLpMR7Kz7wD69HgiQPV26zn6MVViFkk7e25yIV
	 R99SWe7Zeg5wA==
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
Subject: [PATCH v5 4/9] iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()
Date: Sat, 24 Feb 2024 12:32:10 +0000
Message-ID: <20240224123215.161469-5-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240224123215.161469-1-jic23@kernel.org>
References: <20240224123215.161469-1-jic23@kernel.org>
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
2.44.0


