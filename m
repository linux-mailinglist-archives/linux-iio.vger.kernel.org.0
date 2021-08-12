Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACAE3E9C7D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 04:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhHLCYp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Aug 2021 22:24:45 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56084 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229729AbhHLCYp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Aug 2021 22:24:45 -0400
X-UUID: fec819cb61bf4a4bb39af694e654bd07-20210812
X-UUID: fec819cb61bf4a4bb39af694e654bd07-20210812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 998655441; Thu, 12 Aug 2021 10:24:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 10:24:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 10:24:16 +0800
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
Subject: [PATCH 2/2] iio: mtk-auxadc: update case IIO_CHAN_INFO_PROCESSED
Date:   Thu, 12 Aug 2021 10:23:42 +0800
Message-ID: <20210812022342.29092-2-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210812022342.29092-1-hui.liu@mediatek.com>
References: <20210812022342.29092-1-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Covert raw data to processed data.

Signed-off-by: Hui Liu <hui.liu@mediatek.com>
---
 drivers/iio/adc/mt6577_auxadc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index e995d43287b2..cda03a653269 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -83,6 +83,10 @@ static const struct iio_chan_spec mt6577_auxadc_iio_channels[] = {
 	MT6577_AUXADC_CHANNEL(15),
 };
 
+/* For Voltage calculation */
+#define VOLTAGE_FULL_RANGE  1500	/* VA voltage */
+#define AUXADC_PRECISE      4096	/* 12 bits */
+
 static int mt_auxadc_get_cali_data(int rawdata, bool enable_cali)
 {
 	return rawdata;
@@ -205,6 +209,10 @@ static int mt6577_auxadc_read_raw(struct iio_dev *indio_dev,
 		}
 		if (adc_dev->dev_comp->sample_data_cali)
 			*val = mt_auxadc_get_cali_data(*val, true);
+
+		/* Convert adc raw data to voltage: 0 - 1500 mV */
+		*val = *val * VOLTAGE_FULL_RANGE / AUXADC_PRECISE;
+
 		return IIO_VAL_INT;
 
 	default:
-- 
2.18.0

