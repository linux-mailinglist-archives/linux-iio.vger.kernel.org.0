Return-Path: <linux-iio+bounces-1037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00718161AB
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 19:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519151F21D9B
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C410047F63;
	Sun, 17 Dec 2023 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxiOk5dS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF1641A84;
	Sun, 17 Dec 2023 18:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3E4C433C7;
	Sun, 17 Dec 2023 18:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702838846;
	bh=yP6evj5zceY7Ye61hXwY7pu/5SYa4vhY2oqK5+w0LMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxiOk5dS6asXALo/hODL2as9vhZ9Iupkw0t0yZEVcLU1hdupnMg+BiYd3PlMZZLFf
	 A6KQfP/FF4EDJKLcaRH9lWOiGdKCF3ApY6xW/rRi5uCE6bqpxNX4NwaFCmRxZ04C5/
	 9ve7p9JX0EezEm0gA4Sq7dpEUm//B7NiROwu55oZZDhvfVSI6AaxWczUIHf46Aw48/
	 JlNWLIbnTirCOiFlsxjRj2iwBibp97zgjgJWCzmKBcrrJNYR7HvMyvBneV4Q1cOmx3
	 TcrTrPp3REToZgSbcjrpaHAkUYZ2ektYUweT3KkQ+RzBf46ileYXOZ3IwC5aurWA2V
	 /CcgaJC7ce1zw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 4/4] iio: adc: rcar-gyroadc: use __free(device_node)
Date: Sun, 17 Dec 2023 18:46:48 +0000
Message-ID: <20231217184648.185236-5-jic23@kernel.org>
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

Using automated cleanup to replace of_node_put() handling allows for
a simplfied flow by enabling direct returns on errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d524f2e8e927..9d6227b31724 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -318,7 +318,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	struct rcar_gyroadc *priv = iio_priv(indio_dev);
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child;
+	struct device_node *child __free(device_node) = NULL;
 	struct regulator *vref;
 	unsigned int reg;
 	unsigned int adcmode = -1, childmode;
@@ -352,7 +352,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
 			break;
 		default:
-			goto err_e_inval;
+			return -EINVAL;
 		}
 
 		/*
@@ -369,7 +369,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Failed to get child reg property of ADC \"%pOFn\".\n",
 					child);
-				goto err_of_node_put;
+				return ret;
 			}
 
 			/* Channel number is too high. */
@@ -377,7 +377,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
 					num_channels, child, reg);
-				goto err_e_inval;
+				return -EINVAL;
 			}
 		}
 
@@ -386,7 +386,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			dev_err(dev,
 				"Channel %i uses different ADC mode than the rest.\n",
 				reg);
-			goto err_e_inval;
+			return -EINVAL;
 		}
 
 		/* Channel is valid, grab the regulator. */
@@ -396,8 +396,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		if (IS_ERR(vref)) {
 			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
 				reg);
-			ret = PTR_ERR(vref);
-			goto err_of_node_put;
+			return PTR_ERR(vref);
 		}
 
 		priv->vref[reg] = vref;
@@ -422,7 +421,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		 * we can stop parsing here.
 		 */
 		if (childmode == RCAR_GYROADC_MODE_SELECT_1_MB88101A) {
-			of_node_put(child);
 			break;
 		}
 	}
@@ -433,12 +431,6 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 	}
 
 	return 0;
-
-err_e_inval:
-	ret = -EINVAL;
-err_of_node_put:
-	of_node_put(child);
-	return ret;
 }
 
 static void rcar_gyroadc_deinit_supplies(struct iio_dev *indio_dev)
-- 
2.43.0


