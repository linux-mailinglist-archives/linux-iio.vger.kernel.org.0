Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9760F274371
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 15:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIVNrB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 09:47:01 -0400
Received: from www381.your-server.de ([78.46.137.84]:44418 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVNrA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 09:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=oUeSwr/n1Dl6z6L8xZ5BzVC3kUWF5+rtKL0jGU4TM1Q=; b=alcV2CURi5Q1Et/4QDW1pcgsY2
        dBiKnogI3d5SqXy2KD5XFsuYLJmynnosNVOAVXUBFkcrcDhDfC2InCbQ2bxvWujK8D5BnQXtANqX/
        WzlVAEP9CEm2KHk5XgK7GTXAfdMYji+XWH4Unj8rmHMRcdvU6IunQe3R7yytqfSDxBc65DXw67bld
        a4v4y4FdYA2p6NNqw6IFPMf2uxGznVebGB7w/SxPtrZlAueNfxb8Lye7yr1Mdr+9Px5ziGReoXBRh
        ONkScdjwpvmhh4vW6IR5stfnZ522JnQdFazbOFlvlW4bLXdN0h86I5EdQ9CHJBrMKKnuNf1QxWHLl
        7/V3h+FA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1kKidF-0005wA-VP; Tue, 22 Sep 2020 15:46:58 +0200
Received: from [2001:a61:259b:1201:9e5c:8eff:fe01:8578] (helo=lars-desktop.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1kKidF-000LOk-RN; Tue, 22 Sep 2020 15:46:57 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] devicetree: Add Xilinx System Management Wizard binding documentation
Date:   Tue, 22 Sep 2020 15:46:23 +0200
Message-Id: <20200922134624.13191-1-lars@metafoo.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25934/Mon Sep 21 15:52:04 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding documentation for the Xilinx System Management Wizard. The
Xilinx System Management Wizard is a AXI frontend for the Xilinx System
Monitor found in the UltraScale and UltraScale+ FPGAs.

The System Monitor is the equivalent to the Xilinx XADC found in their
previous generation of FPGAs and their external and internal interfaces are
very similar. For this reason the share the same binding documentation. But
since they are not 100% compatible and software will have to know about the
differences they use a different compatible string.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 .../bindings/iio/adc/xilinx-xadc.txt          | 49 +++++++++++++++----
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
index e0e0755cabd8..f42e18078376 100644
--- a/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
@@ -1,13 +1,22 @@
 Xilinx XADC device driver
 
-This binding document describes the bindings for both of them since the
-bindings are very similar. The Xilinx XADC is a ADC that can be found in the
-series 7 FPGAs from Xilinx. The XADC has a DRP interface for communication.
-Currently two different frontends for the DRP interface exist. One that is only
-available on the ZYNQ family as a hardmacro in the SoC portion of the ZYNQ. The
-other one is available on all series 7 platforms and is a softmacro with a AXI
-interface. This binding document describes the bindings for both of them since
-the bindings are very similar.
+This binding document describes the bindings for the Xilinx 7 Series XADC as well
+as the UltraScale/UltraScale+ System Monitor.
+
+The Xilinx XADC is an ADC that can be found in the Series 7 FPGAs from Xilinx.
+The XADC has a DRP interface for communication. Currently two different
+frontends for the DRP interface exist. One that is only available on the ZYNQ
+family as a hardmacro in the SoC portion of the ZYNQ. The other one is available
+on all series 7 platforms and is a softmacro with a AXI interface. This binding
+document describes the bindings for both of them since the bindings are very
+similar.
+
+The Xilinx System Monitor is an ADC that is found in the UltraScale and
+UltraScale+ FPGAs from Xilinx. The System Monitor provides a DRP interface for
+communication. Xilinx provides a standard IP core that can be used to access the
+System Monitor through an AXI interface in the FPGA fabric. This IP core is
+called the Xilinx System Management Wizard. This document describes the bindings
+for this IP.
 
 Required properties:
 	- compatible: Should be one of
@@ -15,11 +24,14 @@ Required properties:
 		  configuration interface to interface to the XADC hardmacro.
 		* "xlnx,axi-xadc-1.00.a": When using the axi-xadc pcore to
 		  interface to the XADC hardmacro.
+		* "xlnx,system-management-wiz-1.3": When using the
+		  Xilinx System Management Wizard fabric IP core to access the
+		  UltraScale and UltraScale+ System Monitor.
 	- reg: Address and length of the register set for the device
 	- interrupts: Interrupt for the XADC control interface.
 	- clocks: When using the ZYNQ this must be the ZYNQ PCAP clock,
-	  when using the AXI-XADC pcore this must be the clock that provides the
-	  clock to the AXI bus interface of the core.
+	  when using the axi-xadc or the axi-system-management-wizard this must be
+	  the clock that provides the clock to the AXI bus interface of the core.
 
 Optional properties:
 	- xlnx,external-mux:
@@ -110,3 +122,20 @@ Examples:
 			};
 		};
 	};
+
+	adc@80000000 {
+		compatible = "xlnx,system-management-wiz-1.3";
+		reg = <0x80000000 0x1000>;
+		interrupts = <0 81 4>;
+		interrupt-parent = <&gic>;
+		clocks = <&fpga1_clk>;
+
+		xlnx,channels {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			channel@0 {
+				reg = <0>;
+				xlnx,bipolar;
+			};
+		};
+	};
-- 
2.20.1

