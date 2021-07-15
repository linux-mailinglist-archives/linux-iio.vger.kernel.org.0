Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CDF3C9BF4
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhGOJiY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 05:38:24 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:59676 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237538AbhGOJiX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jul 2021 05:38:23 -0400
X-UUID: a3d5b12ba3924c20960dbea0bef5e2e5-20210715
X-UUID: a3d5b12ba3924c20960dbea0bef5e2e5-20210715
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 688587474; Thu, 15 Jul 2021 17:35:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Jul 2021 17:35:26 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Jul 2021 17:35:25 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <seiya.wang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH 0/1] AUXADC: Mediatek auxadc driver
Date:   Thu, 15 Jul 2021 17:35:22 +0800
Message-ID: <20210715093523.29844-1-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes one patch:
1.Add mutex_destroy when probe fail and remove device.

Hui Liu (1):
  iio: mtk-auxadc: add mutex_destroy

 drivers/iio/adc/mt6577_auxadc.c | 2 ++
 1 file changed, 2 insertions(+)

--
2.18.0


