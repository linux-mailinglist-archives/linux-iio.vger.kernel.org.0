Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F419B418728
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 09:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhIZHcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Sep 2021 03:32:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34466 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231267AbhIZHcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Sep 2021 03:32:09 -0400
X-UUID: 78c49c1f3edb4520978a70b0f7d85e52-20210926
X-UUID: 78c49c1f3edb4520978a70b0f7d85e52-20210926
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 58730484; Sun, 26 Sep 2021 15:30:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 26 Sep 2021 15:30:28 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Sep 2021 15:30:27 +0800
From:   Hui-Liu Liu <hui.liu@mediatek.com>
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
Subject: [PATCH v4 0/1] AUXADC: Mediatek auxadc driver
Date:   Sun, 26 Sep 2021 15:30:27 +0800
Message-ID: <20210926073028.11045-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes one patch:
1. fix case IIO_CHAN_INFO_PROCESSED: change readback value from raw data to voltage.

Changes in patch v4:
1)add inforamtion in patch description.

Changes in patch v3:
1)add Fixes tags inforamtion.

Changes in patch v2:
1)abandon support case IIO_CHAN_INFO_RAW.

Changes in patch v1:
1)fix typo covert to convert in patch 2/2 description.

Hui Liu (1):
  iio: mtk-auxadc: fix case IIO_CHAN_INFO_PROCESSED

 drivers/iio/adc/mt6577_auxadc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--
2.18.0


