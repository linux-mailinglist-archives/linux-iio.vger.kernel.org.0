Return-Path: <linux-iio+bounces-1036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFCD8161A9
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 19:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3018C1F21E37
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7447F43;
	Sun, 17 Dec 2023 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai2Qi7hw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A045BFB;
	Sun, 17 Dec 2023 18:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE80C433C8;
	Sun, 17 Dec 2023 18:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838843;
	bh=tpyIiinfVf36Owr7X4Mhg3T4gpSPmzxIBlw+KoPBg7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ai2Qi7hwvn1Nv+Hwo0E4T/8fjaIOcwwq9KTehHZLycH554M22BJQlpg8I9IDQT2ov
	 YtYpoDn93+CJJBsoAtr3v0x78w/1DO4XztT3kN8BKrwR9CFjMBEhemxenRB8WL73nT
	 DYgipL99lwTvUe2O2XrCUxAHTYJkcDJihkmfTaXwwZOj2JxLBUyZjNWWeBf+jnSiVv
	 cp1ICJl842DDAfXy5pczWuOqBzFfnlEJuF2R6MRFELkw0AV/LfgmWGnLerVNxYHeV/
	 cAPvjEvL/qMdkQofiD2Rf3nHyWadIVLIPTYFWeZGSjs67t3jYjwn/7OYT4ZKEfsKgD
	 EDhrYMSLIEP6A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 3/4] iio: adc: fsl-imx25-gcq: Use __free(device_node)
Date: Sun, 17 Dec 2023 18:46:47 +0000
Message-ID: <20231217184648.185236-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217184648.185236-1-jic23@kernel.org>
References: <20231217184648.185236-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Using automated cleanup reduces chance of an reference count leak
and simplfies the code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 68c813de0605..e04f92d7a953 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -199,7 +199,7 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			       struct mx25_gcq_priv *priv)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *child;
+	struct device_node *child __free(device_node) = NULL;
 	struct device *dev = &pdev->dev;
 	int ret, i;
 
@@ -224,14 +224,12 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		ret = of_property_read_u32(child, "reg", &reg);
 		if (ret) {
 			dev_err(dev, "Failed to get reg property\n");
-			of_node_put(child);
 			return ret;
 		}
 
 		if (reg >= MX25_NUM_CFGS) {
 			dev_err(dev,
 				"reg value is greater than the number of available configuration registers\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -243,10 +241,9 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 		case MX25_ADC_REFP_XP:
 		case MX25_ADC_REFP_YP:
 			ret = mx25_gcq_ext_regulator_setup(&pdev->dev, priv, refp);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
+
 			priv->channel_vref_mv[reg] =
 				regulator_get_voltage(priv->vref[refp]);
 			/* Conversion from uV to mV */
@@ -257,7 +254,6 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 			break;
 		default:
 			dev_err(dev, "Invalid positive reference %d\n", refp);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -270,12 +266,10 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 
 		if ((refp & MX25_ADCQ_CFG_REFP_MASK) != refp) {
 			dev_err(dev, "Invalid fsl,adc-refp property value\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 		if ((refn & MX25_ADCQ_CFG_REFN_MASK) != refn) {
 			dev_err(dev, "Invalid fsl,adc-refn property value\n");
-			of_node_put(child);
 			return -EINVAL;
 		}
 
-- 
2.43.0


