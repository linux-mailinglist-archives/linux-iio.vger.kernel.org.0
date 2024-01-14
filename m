Return-Path: <linux-iio+bounces-1649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35082D184
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD921F21564
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4B524B;
	Sun, 14 Jan 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIV72eZt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921BA53A1;
	Sun, 14 Jan 2024 16:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB1AC43394;
	Sun, 14 Jan 2024 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251263;
	bh=tpyIiinfVf36Owr7X4Mhg3T4gpSPmzxIBlw+KoPBg7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIV72eZtXJNpCAWIFZ+xLZjCZ29Wv+8cOHb5MGp9ySaIhginppPDUaSuq7vThPKqE
	 VW2kWYDm1n3aF+wYvauGu2P1P6/4/3N2ohfFv+35Mie41l0kAmDPQBTPnNOaH2HVpN
	 +Om/tbylbjzTLTfXM4TGiWUgB824ePbGshbS+6gGU1EExzRUMRxNRDd1QNX77PA4bK
	 MfKWM/huSTpJN5JL4b5XhvVufz9E6DG67aDrhvE1N7QLMSfAuAlVgdCBa2SmUn2HGd
	 nf22OnMNUtLM7pCDYE6NfRI2nND12vethA0fOopyqXc++3G6elKcNX3+Tlcl8Ckrnp
	 Q1USQdZAhYfYw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/4] iio: adc: fsl-imx25-gcq: Use __free(device_node)
Date: Sun, 14 Jan 2024 16:53:57 +0000
Message-ID: <20240114165358.119916-4-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114165358.119916-1-jic23@kernel.org>
References: <20240114165358.119916-1-jic23@kernel.org>
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


