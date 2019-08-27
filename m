Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7B9DC23
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 05:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfH0DxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 23:53:22 -0400
Received: from anchovy1.45ru.net.au ([203.30.46.145]:53652 "EHLO
        anchovy1.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfH0DxW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2019 23:53:22 -0400
Received: (qmail 8938 invoked by uid 5089); 27 Aug 2019 03:53:20 -0000
Received: by simscan 1.2.0 ppid: 8898, pid: 8904, t: 0.0407s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-c7.electromag.com.au) (preid@electromag.com.au@203.59.235.95)
  by anchovy1.45ru.net.au with ESMTPA; 27 Aug 2019 03:53:19 -0000
Received: by preid-c7.electromag.com.au (Postfix, from userid 1000)
        id CD8522021C4CF; Tue, 27 Aug 2019 11:35:28 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, michal.simek@xilinx.com
Subject: [PATCH 1/2] dt-binding: iio: Add optional label property
Date:   Tue, 27 Aug 2019 11:35:23 +0800
Message-Id: <1566876924-63608-2-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
References: <1566876924-63608-1-git-send-email-preid@electromag.com.au>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This optional property defines a symbolic name for the device.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 Documentation/devicetree/bindings/iio/iio-bindings.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8ce063b..ffeae5aad8b5 100644
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
+		label = "adc_voltage_sensor";
 	};
 
 Example for a configuration with trigger:
-- 
1.8.3.1

