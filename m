Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62C27989E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIZK4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 06:56:11 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:53788 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZK4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Sep 2020 06:56:11 -0400
X-Greylist: delayed 654 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 06:56:10 EDT
Received: by agrajag.zerfleddert.de (Postfix, from userid 1000)
        id A18785B20677; Sat, 26 Sep 2020 12:45:15 +0200 (CEST)
Date:   Sat, 26 Sep 2020 12:45:15 +0200
From:   Tobias Jordan <kernel@cdqe.de>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: adc: gyroadc: fix leak of device node iterator
Message-ID: <20200926104515.GA12079@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing of_node_put calls for the error paths of the
for_each_child_of_node loop in rcar_gyroadc_parse_subdevs.

Thought about adding an "goto err_of_node_put" instead, but as the error
paths are quite divergent, I'm not sure if that wouldn't complicate
things.

Fixes: 059c53b32329 ("iio: adc: Add Renesas GyroADC driver")
Signed-off-by: Tobias Jordan <kernel@cdqe.de>
---
 drivers/iio/adc/rcar-gyroadc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index dcaefc108ff6..3746b0276b80 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -357,6 +357,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			num_channels = ARRAY_SIZE(rcar_gyroadc_iio_channels_3);
 			break;
 		default:
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -374,6 +375,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Failed to get child reg property of ADC \"%pOFn\".\n",
 					child);
+				of_node_put(child);
 				return ret;
 			}
 
@@ -382,6 +384,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 				dev_err(dev,
 					"Only %i channels supported with %pOFn, but reg = <%i>.\n",
 					num_channels, child, reg);
+				of_node_put(child);
 				return -EINVAL;
 			}
 		}
@@ -391,6 +394,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 			dev_err(dev,
 				"Channel %i uses different ADC mode than the rest.\n",
 				reg);
+			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -401,6 +405,7 @@ static int rcar_gyroadc_parse_subdevs(struct iio_dev *indio_dev)
 		if (IS_ERR(vref)) {
 			dev_dbg(dev, "Channel %i 'vref' supply not connected.\n",
 				reg);
+			of_node_put(child);
 			return PTR_ERR(vref);
 		}
 
-- 
2.20.1

