Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEFC3E9C7B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhHLCYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 22:24:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49086 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230035AbhHLCYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 22:24:45 -0400
X-UUID: dff4adfb4c0a4c4e9e72d73158659c83-20210812
X-UUID: dff4adfb4c0a4c4e9e72d73158659c83-20210812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 751955085; Thu, 12 Aug 2021 10:24:17 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 10:24:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 10:24:15 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/2] iio: mtk-auxadc: add support IIO_CHAN_INFO_RAW case
Date:   Thu, 12 Aug 2021 10:23:41 +0800
Message-ID: <20210812022342.29092-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support IIO_CHAN_INFO_RAW case.

Signed-off-by: Hui Liu <hui.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 79c1dd68b909..e995d43287b2 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -60,7 +60,8 @@ static const struct mtk_auxadc_compatible mt6765_compat = {
 		.type = IIO_VOLTAGE,				    \
 		.indexed = 1,					    \
 		.channel = (idx),				    \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	    \
+				      BIT(IIO_CHAN_INFO_PROCESSED), \
 }
 
 static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
@@ -181,6 +182,19 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
 	struct mt6577_auxadc_device *adc_dev = iio_priv(indio_dev);
 
 	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		*val = mt6577_auxadc_read(indio_dev, chan);
+		if (*val < 0) {
+			dev_notice(indio_dev->dev.parent,
+				"failed to sample data on channel[%d]\n",
+				chan->channel);
+			return *val;
+		}
+		if (adc_dev->dev_comp->sample_data_cali)
+			*val = mt_auxadc_get_cali_data(*val, true);
+
+		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_PROCESSED:
 		*val = mt6577_auxadc_read(indio_dev, chan);
 		if (*val < 0) {
-- 
2.18.0

