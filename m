Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC43E9E1D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Aug 2021 07:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhHLFtq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Aug 2021 01:49:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230377AbhHLFtp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Aug 2021 01:49:45 -0400
X-UUID: ac7b4d3721684250a58decace1416389-20210812
X-UUID: ac7b4d3721684250a58decace1416389-20210812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1699305085; Thu, 12 Aug 2021 13:49:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 13:49:17 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 13:49:16 +0800
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
Subject: [PATCH v1 0/2] AUXADC: Mediatek auxadc driver
Date:   Thu, 12 Aug 2021 13:48:42 +0800
Message-ID: <20210812054844.30575-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes two patchs:
1.add support for case IIO_CHAN_INFO_RAW.
2.update case IIO_CHAN_INFO_PROCESSED: convert raw data to voltage.

Changes in patch v1:
1)fix typo covert to convert in patch 2/2 description.

Hui Liu (2):
  iio: mtk-auxadc: add support IIO_CHAN_INFO_RAW case
  iio: mtk-auxadc: update case IIO_CHAN_INFO_PROCESSED

 drivers/iio/adc/mt6577_auxadc.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

--
2.18.0



