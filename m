Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6106CA84
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2019 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfGRIBa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Jul 2019 04:01:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18594 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbfGRIBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jul 2019 04:01:30 -0400
X-UUID: 69342f1487ee4fcaa2ce2f0d74f62c59-20190718
X-UUID: 69342f1487ee4fcaa2ce2f0d74f62c59-20190718
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1083301432; Thu, 18 Jul 2019 16:01:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 18 Jul 2019 16:01:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 18 Jul 2019 16:01:22 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <jg_poxu@mediatek.com>, <sj.huang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <sean.wang@mediatek.com>,
        <erin.lo@mediatek.com>, <eddie.huang@mediatek.com>,
        <matthias.bgg@gmail.com>, <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 0/2] AUXADC: support efuse calibration on MT818 
Date:   Thu, 18 Jul 2019 16:01:17 +0800
Message-ID: <20190718080119.30707-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 655C57B55616B30867184C87976E81790A029DB57092B498944C9C7194938B5F2000:8
X-MTK:  N
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This series includes two patches:
1.Add mt8183 auxadc efuse information in device tree.
1.Add mt8183 efuse calibration function in auxadc driver.

Zhiyong Tao (2):
  arm64: dts: mt8183: auxadc: add efuse information in device tree
  auxadc: mediatek: support efuse calibration in auxadc driver

 arch/arm64/boot/dts/mediatek/mt8183.dtsi |  5 +++
 drivers/iio/adc/mt6577_auxadc.c          | 71 ++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

--
2.12.5

