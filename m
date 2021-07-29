Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468F63D9F1B
	for <lists+linux-iio@lfdr.de>; Thu, 29 Jul 2021 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhG2IDK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Jul 2021 04:03:10 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58822 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234686AbhG2ICy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jul 2021 04:02:54 -0400
X-UUID: 1d30e5a2c3544b07bf44b3dda8486fcd-20210729
X-UUID: 1d30e5a2c3544b07bf44b3dda8486fcd-20210729
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 510656948; Thu, 29 Jul 2021 16:02:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Jul 2021 16:02:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 29 Jul 2021 16:02:07 +0800
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
Subject: [PATCH v1 0/1] AUXADC: Mediatek auxadc driver
Date:   Thu, 29 Jul 2021 16:01:34 +0800
Message-ID: <20210729080135.17436-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes one patch:
1.Add mutex_destroy when probe fail and remove device.

Changes in patch v1:
1. In probe function, move mutex_destroy to "err_power_off".
2. In remove function, move mutex_destroy before "clk_disable_unprepare".

Hui Liu (1):
  iio: mtk-auxadc: add mutex_destroy

 drivers/iio/adc/mt6577_auxadc.c | 2 ++
 1 file changed, 2 insertions(+)

--
2.18.0


