Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5943FC236
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 07:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238052AbhHaFnP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 01:43:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44890 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231537AbhHaFnP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 01:43:15 -0400
X-UUID: 17cac67aad734e0d95a0ba0e270bb0a5-20210831
X-UUID: 17cac67aad734e0d95a0ba0e270bb0a5-20210831
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1860664525; Tue, 31 Aug 2021 13:42:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 13:42:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 13:42:15 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <ben.tseng@mediatek.com>, <matthias.bgg@gmail.com>,
        <s.hauer@pengutronix.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 0/1] AUXADC: Mediatek auxadc driver
Date:   Tue, 31 Aug 2021 13:42:06 +0800
Message-ID: <20210831054207.13236-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes one patch:
1.update case IIO_CHAN_INFO_PROCESSED: convert raw data to voltage.

Changes in patch v2:
1)abandon support case IIO_CHAN_INFO_RAW.

Changes in patch v1:
1)fix typo covert to convert in patch 2/2 description.

Hui Liu (1):
  iio: mtk-auxadc: update case IIO_CHAN_INFO_PROCESSED

 drivers/iio/adc/mt6577_auxadc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--
2.18.0



