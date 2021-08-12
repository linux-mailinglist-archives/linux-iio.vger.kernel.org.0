Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7593E9E21
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 07:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhHLFts (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 01:49:48 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50396 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234406AbhHLFtr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 01:49:47 -0400
X-UUID: 0eb8716fb15e41478008571afda521e5-20210812
X-UUID: 0eb8716fb15e41478008571afda521e5-20210812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 366213087; Thu, 12 Aug 2021 13:49:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 13:49:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 13:49:18 +0800
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
Subject: [PATCH v1 2/2] iio: mtk-auxadc: update case IIO_CHAN_INFO_PROCESSED
Date:   Thu, 12 Aug 2021 13:48:44 +0800
Message-ID: <20210812054844.30575-3-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210812054844.30575-1-hui.liu@mediatek.com>
References: <20210812054844.30575-1-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert raw data to processed data.

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

