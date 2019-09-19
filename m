Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6ECB7CF7
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732581AbfISOgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 10:36:19 -0400
Received: from anchovy2.45ru.net.au ([203.30.46.146]:46412 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732506AbfISOgS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 10:36:18 -0400
Received: (qmail 22142 invoked by uid 5089); 19 Sep 2019 14:36:16 -0000
Received: by simscan 1.2.0 ppid: 22117, pid: 22118, t: 0.0448s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@118.208.174.34)
  by anchovy3.45ru.net.au with ESMTPA; 19 Sep 2019 14:36:16 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id D5820201AF902; Thu, 19 Sep 2019 22:36:11 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH v2 1/2] dt-binding: iio: Add optional label property
Date:   Thu, 19 Sep 2019 22:36:07 +0800
Message-Id: <1568903768-65998-2-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
References: <1568903768-65998-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This optional property defines a symbolic name for the device.
This helps to distinguish between more than one iio device
of the same type.

Suggested-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8ce063b..af33267727f4 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -18,12 +18,17 @@ Required properties:
 		   with a single IIO output and 1 for nodes with multiple
 		   IIO outputs.
 
+Optional properties:
+label:		   A symbolic name for the device.
+
+
 Example for a simple configuration with no trigger:
 
 	adc: voltage-sensor@35 {
 		compatible = "maxim,max1139";
 		reg = <0x35>;
 		#io-channel-cells = <1>;
+		label = "voltage_feedback_group1";
 	};
 
 Example for a configuration with trigger:
-- 
1.8.3.1

