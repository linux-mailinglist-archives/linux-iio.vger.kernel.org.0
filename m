Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA3476569E
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jul 2023 17:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjG0PAb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jul 2023 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjG0PA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jul 2023 11:00:28 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F430DF;
        Thu, 27 Jul 2023 08:00:22 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RAH1wh027816;
        Thu, 27 Jul 2023 16:59:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=doC1Pd1d3NibZb37WWHiE70DKjD6XTr1B8pDdUXXdeU=;
 b=kXoqR2HH0CWHQ1GPMt9yevGGyieem0U7ABUHEI8AmP2jQ74X6lp+4e/m9W1c3cfgJAlG
 I9c66gZAgkGwIQpL9H1UMF6EvN2OQyzcIKohIHp5uPysjh9skOJA39QRfRDtdPNjiJ86
 35aaX6kA73vd6cJ3jOBIMVozJ42aY33abrMRiPWyrxkc+HKv7Hz1VyMxUf9aAo7Ofssm
 x8zFgTbacmiCB70yHXShcna0D9XLE3G1WcNJEQX9vOVqOvUoR5pMZmlTkhWWUHxMqmmh
 2q7paXg/5Tdm9VbdmYqn7lIrdtqf1wdL0hiRKK2E3uNbGyWhhyjFDCDqpyMRbN+5i0WF 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3s3kn2b15h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 16:59:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D66C710002A;
        Thu, 27 Jul 2023 16:59:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 787F2209721;
        Thu, 27 Jul 2023 16:59:44 +0200 (CEST)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 27 Jul
 2023 16:59:44 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC v2 00/11] iio: add iio backend device type
Date:   Thu, 27 Jul 2023 16:59:26 +0200
Message-ID: <20230727145939.1157607-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This v2 is an addon to initial RFC:
https://lore.kernel.org/lkml/20230623140944.2613002-1-olivier.moysan@foss.st.com/

Despite the "IIO backend" naming has to be changed (as pointed out by
Jonathan previously), it has been kept here, for time being. The
appropriated naming still has to be discussed later on.

In the previous RFC the "IIO backend" concept was proposed through
a set of template APIs.

This v2 implements a functionnal exemple based on STM32 DFSDM,
to bring scaling support to this peripheral.

Olivier Moysan (11):
  iio: introduce iio backend device
  of: property: add device link support for io-backends
  dt-bindings: iio: stm32-dfsdm-adc: add scaling support
  dt-bindings: iio: adc: add scaling support to sd modulator
  iio: adc: stm32-dfsdm: manage dfsdm as a channel provider
  iio: adc: stm32-dfsdm: adopt generic channel bindings
  iio: adc: stm32-dfsdm: add scaling support to dfsdm
  iio: adc: sd modulator: add scale and offset support
  ARM: dts: stm32: adopt new dfsdm bindings on stm32mp151
  ARM: dts: stm32: add dfsdm pins muxing on stm32mp15
  ARM: dts: stm32: add dfsdm iio support on stm32mp157c-ev

 .../iio/adc/sigma-delta-modulator.yaml        |   9 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 189 ++++++------------
 arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi   |  39 ++++
 arch/arm/boot/dts/st/stm32mp151.dtsi          |  18 +-
 arch/arm/boot/dts/st/stm32mp157c-ev1.dts      |  68 +++++++
 drivers/iio/Makefile                          |   1 +
 drivers/iio/adc/sd_adc_modulator.c            | 106 ++++++++--
 drivers/iio/adc/stm32-dfsdm-adc.c             | 187 +++++++++++------
 drivers/iio/industrialio-backend.c            | 107 ++++++++++
 drivers/of/property.c                         |   2 +
 include/linux/iio/backend.h                   |  56 ++++++
 11 files changed, 561 insertions(+), 221 deletions(-)
 create mode 100644 drivers/iio/industrialio-backend.c
 create mode 100644 include/linux/iio/backend.h

-- 
2.25.1

