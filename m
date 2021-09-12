Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A020407C1F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Sep 2021 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhILHPM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Sep 2021 03:15:12 -0400
Received: from mx20.baidu.com ([111.202.115.85]:51168 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229783AbhILHPM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Sep 2021 03:15:12 -0400
Received: from BC-Mail-Ex32.internal.baidu.com (unknown [172.31.51.26])
        by Forcepoint Email with ESMTPS id 8F40083A1DF70830CC91;
        Sun, 12 Sep 2021 15:13:48 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex32.internal.baidu.com (172.31.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 12 Sep 2021 15:13:48 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.12) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 12 Sep 2021 15:13:47 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <aardelean@deviqon.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Cai Huoqing" <caihuoqing@baidu.com>
Subject: [PATCH v4 0/3] iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
Date:   Sun, 12 Sep 2021 15:13:31 +0800
Message-ID: <20210912071334.1745-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.12]
X-ClientProxiedBy: BC-Mail-Ex29.internal.baidu.com (172.31.51.23) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
driver support for this ADC

dt-bindings: iio: adc:
v1->v2:	*Fix some indentation issues.
	*Mark status as okay.
	*Change clock2 source.
v3->v4:	*Sort header file declarations in alphabetical order.
	*Remove explicitly cast from "void *".
	*Make use of dev_err_probe().
	*Add some blank lines to help readability.

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
v2->v3:	*Add "return 0" to adc_runtime_resume()
v3->v4:	*Sort header file declarations in alphabetical order.
	*Remove explicitly cast from "void *".
	*Make use of dev_err_probe().
	*Add some blank lines to help readability.

v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/
v3 link:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210907015724.1377-1-caihuoqing@baidu.com/

Cai Huoqing (3):
  iio: imx8qxp-adc: Add binding documentation for NXP IMX8QXP ADC
  dt-bindings: iio: adc: Add binding documentation for NXP IMX8QXP ADC
  MAINTAINERS:  Add the driver info of the NXP IMX8QXP ADC

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     |  88 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/imx8qxp-adc.c                 | 461 ++++++++++++++++++
 5 files changed, 567 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c

-- 
2.25.1

