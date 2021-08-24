Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B83F5D65
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 13:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhHXLz6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 07:55:58 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:20894 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhHXLz5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 07:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629806114; x=1661342114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bs1skQnHmiQI8BMFOJLtlVnI7XmB1cbsizHEwNDRUNw=;
  b=B0Rd9wKh/KqevVArhC0FPCiWlmX83pyQs+6TQhDUQomcoGkZuakijp88
   o32TVDplQmUE4nq1JqczToy1euximEgVk1MIR/Vs0bGCNVl7EL+24I2zT
   RkuEP2nQFVK+n0TXt55S2CWIROVPDtI8JOEdpSu5Ix3KIvoCgtfJXUQvL
   rD/ZxQlHwBdH9FfYA7HiusSVN2/GglEZScAeDBs4+gj7OPop5+A20Z3p1
   PgGXjx8sJszwd3pNWQRuz5n9E2IBSBGdmfeeP8aL54IKZ3eI6PO+U+NeF
   BLsqAjlB8pZk1c09OhsFSg2bz9kF8IYEJLjsOXNG9tGHtqUIX33rLa9pu
   g==;
IronPort-SDR: KbfgXBwu1+LzQzdDQQrbVirDkBWwdKZa1ZWI7V98ywI126Jfvsk75dB2Vdu32sKmLBXI2J54AY
 F6D1DB1z2q2gppcXZ3U2K8jokPTVwLJr8kaBo0AlDH1huvBpDL9FFp6ngSpkUwSDfZ/BaJxYqu
 QO1EgIZ3I+iVEgpEF+vVOIPmpluq7mqrA+zCaElTbvXZbN+mugCHPK6BJKNLof48YCxflEuTKZ
 VWh7R3vBoUT8lJF2FZdlgcX8ADdm5OIOZcXTjX6QhOVSgk0jG6wv/W9B+8n/WTjCRAJSypOmls
 6XHNzjsMCQyQ2Z5hJGH6ET8e
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="133407941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2021 04:55:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 Aug 2021 04:55:11 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 Aug 2021 04:55:06 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v2 00/10] iio: adc: at91-sama5d2_adc: add support for sama7g5
Date:   Tue, 24 Aug 2021 14:54:31 +0300
Message-ID: <20210824115441.681253-1-eugen.hristev@microchip.com>
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
  iio: adc: at91-sama5d2-adc: add support for separate end of conversion
    registers
  iio: adc: at91-sama5d2_adc: add helper for COR register
  iio: adc: at91-sama5d2_adc: add support for sama7g5 device
  iio: adc: at91-sama5d2_adc: update copyright and authors information
  ARM: dts: at91: sama7g5: add node for the ADC
  ARM: dts: at91: sama7g5ek: enable ADC on the board

 .../bindings/iio/adc/atmel,sama5d2-adc.yaml   |   1 +
 arch/arm/boot/dts/at91-sama7g5ek.dts          |   8 +
 arch/arm/boot/dts/sama7g5.dtsi                |  16 +
 drivers/iio/adc/at91-sama5d2_adc.c            | 586 ++++++++++++------
 4 files changed, 425 insertions(+), 186 deletions(-)

-- 
2.25.1

