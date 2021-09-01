Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827453FDA85
	for <lists+linux-iio@lfdr.de>; Wed,  1 Sep 2021 15:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244925AbhIAMcq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 1 Sep 2021 08:32:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61597 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244923AbhIAMbt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Sep 2021 08:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1630499452; x=1662035452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=solFwV4JTQfjT1p/kr3lKPxhmPtCyWwDUzcwzBiiHAo=;
  b=sS7rnzZDzYGS79TbId3bQ5CxB/ElJBZqk5kYIi8S6kkfvmspd06KFhVy
   mDDqoSYVdFeDArMrz9UnSlTzjUJ3vnmqd8EdpAHRbV/NuGq9xZTWLeGy3
   uD0Qt1IOF+AZTUNeQVB9Ixje66/GAXPuPFAWn5PnO6MQF4n1oYgG4kT72
   AintL4epFfsfGm96E8P8Z/AA6n8lYraoIEicF+pIyrBOEgfDYVpT+PY0G
   cvhKJAp3mo/3y5xk5TcG0D2P/M3sZfrGSMFjDO8n8jXQXItVgbu4mVl5I
   xXwUEAwcA3/T6XTV6NUp9fKoCKLyrYR3wk8796uGQXLmwTM8Cqq/jOcMl
   Q==;
IronPort-SDR: GNeBo18az5P2D2SIfssYe+RWQitxbKxnuINk85HUxCuee08lWDJZRUFq6Ki9imiTZoXbF0Huq8
 wYPAzR/u456tUeekDJZZsc5EqUs7sZYyA5+OYcvB0a4PXmYAgW2extWpICe+i+dyjpn28No4gc
 i1ObCIvZu0MdxSIhjYzZ6fsFsHHCuYE5Hn3DsL+nCTBfE4Hh7OqgtxwYCcbCG33UvCqUH8j+r8
 I2JFtdvx75BiE4CVx+zMDpu3WVbi2rVfy9dOMzgh5EwRBfJH4CNB1fg7Hhs1EX6eJQwYAOVRFL
 9bk34D3pAj154OKqFTD0MifT
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="67859488"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2021 05:30:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Sep 2021 05:30:51 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Sep 2021 05:30:49 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <ludovic.desroches@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 10/10] ARM: dts: at91: sama7g5ek: enable ADC on the board
Date:   Wed, 1 Sep 2021 15:30:13 +0300
Message-ID: <20210901123013.329792-11-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210901123013.329792-1-eugen.hristev@microchip.com>
References: <20210901123013.329792-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC controller on the board is fed by a 2.5V reference voltage.
By default the channels #14 and #15 are dedicated to analog input
(marked AN on the board), on the connectors mikrobus1 and mikrobus2.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama7g5ek.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
index 4cbed98cc2f4..c46be165f2ba 100644
--- a/arch/arm/boot/dts/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
@@ -122,6 +122,14 @@ spdif_out: spdif-out {
 	};
 };
 
+&adc {
+	vddana-supply = <&vddout25>;
+	vref-supply = <&vddout25>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_mikrobus1_an_default &pinctrl_mikrobus2_an_default>;
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&vddcpu>;
 };
-- 
2.25.1

