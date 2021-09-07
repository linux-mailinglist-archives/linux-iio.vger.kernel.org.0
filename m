Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6626B402220
	for <lists+linux-iio@lfdr.de>; Tue,  7 Sep 2021 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbhIGB6s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Sep 2021 21:58:48 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56752 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229835AbhIGB6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Sep 2021 21:58:47 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id 98B5652CD701E2D33035;
        Tue,  7 Sep 2021 09:57:35 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 7 Sep 2021 09:57:35 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 7 Sep 2021 09:57:34 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/3] iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
Date:   Tue, 7 Sep 2021 09:57:20 +0800
Message-ID: <20210907015724.1377-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex12.internal.baidu.com (172.31.51.52) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
driver support for this ADC

dt-bindings: iio: adc:
v1->v2: *Fix some indentation issues.
        *Mark status as okay.
        *Change clock2 source.

iio: imx8qxp-adc:
v1->v2:	*Squash patches 1, 2, 3, and 5 into a single patch.
	*Add device specific prefix.
	*Remove the brackets around individual numbers.
	*Make use of FIELD_PREP() and FIELD_GET().
	*Remove a lot of cache values.
	*Replace mlock with adc->lock.
	*Move adc->value read from isr to the completion.
	*Set pm_runtime_disable/_put_noidle() before adc_disable.
	*Add error handler-err_disable_reg/err_unprepare_clk.
v2->v3: *Add "return 0" to adc_runtime_resume()

v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/

Cai Huoqing (3):
  iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
  dt-bindings: iio: adc: Add the binding documentation for NXP IMX8QXP
    ADC
  MAINTAINERS:  Add the driver info of the NXP IMX8QXP ADC

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     |  85 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/imx8qxp-adc.c                 | 470 ++++++++++++++++++
 5 files changed, 573 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c

-- 
2.25.1

