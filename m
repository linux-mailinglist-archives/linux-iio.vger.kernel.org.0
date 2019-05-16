Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9720104
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEPILf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 04:11:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65281 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726738AbfEPIL0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 May 2019 04:11:26 -0400
X-UUID: e3542c8ee8a74750adb7df7e9a167c4e-20190516
X-UUID: e3542c8ee8a74750adb7df7e9a167c4e-20190516
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 670884927; Thu, 16 May 2019 16:11:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 16 May 2019 16:11:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 16 May 2019 16:11:13 +0800
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>, Chun-Hung Wu <chun-hung.wu@mediatek.com>
Subject: [PATCH 0/4] iio: adc: mediatek: add mt6765 driver support
Date:   Thu, 16 May 2019 16:10:43 +0800
Message-ID: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds support of auxadc to MT6765 SoC.

Chun-Hung Wu (4):
  dt-bindings: iio: adc: mediatek: Add document for mt6765
  iio: adc: mediatek: mt6765 upstream driver
  iio: adc: mediatek: SET_LATE_SYSTEM_SLEEP_PM_OPS support
  iio: auxadc: mediatek: change to subsys_initcall

 .../devicetree/bindings/iio/adc/mt6577_auxadc.txt  |  1 +
 drivers/iio/adc/mt6577_auxadc.c                    | 75 +++++++++++++++++-----
 2 files changed, 59 insertions(+), 17 deletions(-)

-- 
1.9.1

