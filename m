Return-Path: <linux-iio+bounces-1650-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECF82D185
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253A91C20AAB
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF033538B;
	Sun, 14 Jan 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0EGIyDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A275255;
	Sun, 14 Jan 2024 16:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873CCC43390;
	Sun, 14 Jan 2024 16:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705251265;
	bh=yP6evj5zceY7Ye61hXwY7pu/5SYa4vhY2oqK5+w0LMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0EGIyDFYYCkrWB4GOrhGufynlrhz3RUYvWcgm1sVxfiWaKG9PzAPtsjvyBtQ7+ob
	 qeseiggh660pI3m682zfICNKpOMnJziGasyxsC8GmqjnmqjNgRfxBySrCQK5nimsVX
	 h/W1h50WatooFD6N826HKIGRAXB88yDITzEndhnevbdMO2yKLyfXocXvOiNYmJLzNj
	 BAKzs/IdehUg7MphG4kGTQdX/EOXt4dFCx2R7j+/q1uPeyyFaL4GAa/m5gJDHzjJHm
	 +G001VhRn1jSpsufAmCN8LH2czTm5oy0AjpD6aAeUkTmrkNsxpdvR6GwAynAT4tJGk
	 sCPtJrTCqdq/A==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4] iio: adc: rcar-gyroadc: use __free(device_node)
Date: Sun, 14 Jan 2024 16:53:58 +0000
Message-ID: <20240114165358.119916-5-jic23@kernel.org>
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


