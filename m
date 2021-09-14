Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307640AE9A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Sep 2021 15:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhINNKZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Sep 2021 09:10:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54012 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232865AbhINNKZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Sep 2021 09:10:25 -0400
X-UUID: 1ffe6a376543482584969c4cb7f96578-20210914
X-UUID: 1ffe6a376543482584969c4cb7f96578-20210914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1655091650; Tue, 14 Sep 2021 21:09:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Sep 2021 21:09:04 +0800
Received: from localhost.localdomain (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Sep 2021 21:09:03 +0800
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
Subject: [PATCH v3 0/1] AUXADC: Mediatek auxadc driver
Date:   Tue, 14 Sep 2021 21:09:00 +0800
Message-ID: <20210914130901.1716-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes one patch:
1.update case IIO_CHAN_INFO_PROCESSED: convert raw data to voltage.

Changes in patch v3:
1)add Fixes tags inforamtion.

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


