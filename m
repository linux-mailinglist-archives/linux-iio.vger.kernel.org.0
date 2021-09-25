Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72121417F36
	for <lists+linux-iio@lfdr.de>; Sat, 25 Sep 2021 04:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbhIYCIS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 22:08:18 -0400
Received: from mx24.baidu.com ([111.206.215.185]:54688 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347050AbhIYCIO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 24 Sep 2021 22:08:14 -0400
Received: from BJHW-Mail-Ex13.internal.baidu.com (unknown [10.127.64.36])
        by Forcepoint Email with ESMTPS id 0A5EE3E16CECED960A22;
        Sat, 25 Sep 2021 10:06:05 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 10:06:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 10:06:04 +0800
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
Subject: [PATCH v6 0/3] iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
Date:   Sat, 25 Sep 2021 10:05:44 +0800
Message-ID: <20210925020555.129-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex13_2021-09-25 10:06:05:168
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
driver support for this ADC.

dt-bindings: iio: adc:
v1->v2:
        *Fix some indentation issues.
        *Mark status as okay.
        *Change clock2 source.
v3->v4:
        *Remove 'status' from examples.
        *Remove unused 'state'.
        *Remove interrupts-parent.
        *Change num of address/size-cells from 1 to 2.
v4->v5:
        *Remove unused properties.

iio: imx8qxp-adc:
v1->v2:
	*Squash patches 1, 2, 3, and 5 into a single patch.
	*Add device specific prefix.
	*Remove the brackets around individual numbers.
	*Make use of FIELD_PREP() and FIELD_GET().
	*Remove a lot of cache values.
	*Replace mlock with adc->lock.
	*Move adc->value read from isr to the completion.
	*Set pm_runtime_disable/_put_noidle() before adc_disable.
	*Add error handler-err_disable_reg/err_unprepare_clk.
v2->v3:
	*Add "return 0" to adc_runtime_resume().
v3->v4:
	*Sort header file declarations in alphabetical order.
	*Remove explicitly cast from "void *".
	*Make use of dev_err_probe().
	*Add some blank lines to help readability.
v4->v5:
	*Update commit message.
	*Remove unused headers.
	*Wrap imx8qxp_adc_read_raw() at a shorter line length that helps readability.
	*Deal with clock/regulator in probe/remove().
	*Use ADC_DRIVER_NAME instead of dev_name(dev).
	*Don't use dev_error_probe() without returning -PROBE_DEFER.
v5->v6:
	*Rename the error path labels to indicate the action that will be performed.

v1 link:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/
v3 link:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210907015724.1377-1-caihuoqing@baidu.com/
v4 link:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210912071334.1745-1-caihuoqing@baidu.com/
v5 link:
https://patchwork.kernel.org/project/linux-arm-kernel/cover/20210921052821.91-1-caihuoqing@baidu.com/

Cai Huoqing (3):
  iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC
  iio: imx8qxp-adc: dt-bindings: iio: adc: Add binding documentation for
     NXP IMX8QXP ADC
  MAINTAINERS: Add the driver info of the NXP IMX8QXP

 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml     |  78 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/imx8qxp-adc.c                 | 492 ++++++++++++++++++
 5 files changed, 588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
 create mode 100644 drivers/iio/adc/imx8qxp-adc.c

-- 
2.25.1

