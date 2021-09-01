Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6873FDA5B
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244924AbhIAMcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:02 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:55485 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244585AbhIAMbV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499425; x=1662035425;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b7KC/3OW3RV6bU+IXe2jATbGjJZFaZjUrZviOJCwN9A=;
  b=ETiMx2x4S74ZLNSJeKduMKhVbrApLVt4mW847/yN8ZJBEZZlyEE33WW3
   Ot9/bcOdBoXlwfz1Gqhf4AWi5BG+jqAj8+0PJpHH39A8qk+Vu50qqs/7B
   a7YGYyqPBYJ4/gMnYoNsbPYuSBiFQz68j0cstl+LSGF2FnseR+fbcvw6q
   uZiNbF9iriieWCAx9TA+YpDD2mudcwycz+FNnCq7yOIUxmi+TjBmBLmTh
   vFM7FKyK+W9hxTLCFq+kFf8gzxpmJy6WAxPy9Pk0eYyyOAa5vwozcZCt8
   O+ywPszi4w8WGxggmGlLa27I2MkfqIfTBeKxMgMGQkU/4xyiWqBA0OxMA
   g==;
IronPort-SDR: Q90feKacTf3jbK8/LWWyguioi8F6sswgm8gwsZ5LJ9E/MLfSj2PeISyDJxX1AE/k8vMNRbYLl8
 ciGNFI1ShiNb2U6Ml6soLkwARds8O7CeND0XCaPVbDw/t1Vn7UbWl+Ba/AZsyIE4g0CHcNfelP
 T/rif3KRcKA81f52tt4sfX+zzdwv1GoUGF0evqiNecpP8bV5Ex6/bZ7VPUl5DL9+sRsqyi6eMC
 q8kvDFxrVG0lSc2MfosT3Hej5z/4dMhXJeWxI+8rcdycIuXZzkoXj0z9msD0mmKxc4HjyisPGw
 MjwasXYU/hblac7RrTs0VZud
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="134969763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 00/10] iio: adc: at91-sama5d2_adc: add support for sama7g5
Date:   Wed, 1 Sep 2021 15:30:03 +0300
Message-ID: <20210901123013.329792-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi,

This series adds support for sama7g5.

The sama7g5 is slightly different from sama5d2, but has the same basic
operations. The register map is a bit different, so, I added some primitives
to differentiate between the two classes of hardware blocks (sama5d2-sam9x60
and sama7g5).

Sama7g5 has 16 channels ADC, no resistive touch, and extra features
(FIFOs, better oversampling , not implemented yet).

It is a rework of the series initially sent here:
https://marc.info/?l=linux-iio&m=161461656807826&w=2

Changes in v3:
updates for the channel indexes ABI
minor nitpicks fixes
fixed krobot report



Changes in v2:

I reworked this according to review by Jonathan, meaning that first I created
a no-op patch that will convert the driver to a more platform specific data
dedicated type of driver. This adds various structures that hold things like
register layout and channel information.
After this I created few patches that implement the main differences between
sama7g5 and older products: the end-of-conversion new register. I added
helper functions to make code more easy to read and more simple.
One the last patches adds the layout and channels for sama7g5.
At this moment in linux-next, the DT for sama7g5 and sama7g5ek is present,
and the last patches add and enable this node in DT for this board.

Eugen



Eugen Hristev (10):
  dt-bindings: iio: adc: at91-sama5d2: add compatible for sama7g5-adc
  iio: adc: at91-sama5d2_adc: initialize hardware after clock is started
  iio: adc: at91-sama5d2_adc: remove unused definition
  iio: adc: at91-sama5d2_adc: convert to platform specific data
    structures
  iio: adc: at91-sama5d2_adc: add support for separate end of conversion
    registers
  iio: adc: at91-sama5d2_adc: add helper for COR register
  iio: adc: at91-sama5d2_adc: add support for sama7g5 device
  iio: adc: at91-sama5d2_adc: update copyright and authors information
  ARM: dts: at91: sama7g5: add node for the ADC
  ARM: dts: at91: sama7g5ek: enable ADC on the board

 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
 arch/arm/boot/dts/at91-sama7g5ek.dts          |   8 +
 arch/arm/boot/dts/sama7g5.dtsi                |  16 +
 drivers/iio/adc/at91-sama5d2_adc.c            | 594 ++++++++++++------
 4 files changed, 432 insertions(+), 187 deletions(-)

-- 
2.25.1

