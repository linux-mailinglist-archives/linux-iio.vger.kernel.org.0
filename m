Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC87111FE3
	for <lists+linux-iio@lfdr.de>; Thu,  2 May 2019 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEBQOp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 May 2019 12:14:45 -0400
Received: from da1vs03.rockwellcollins.com ([205.175.227.47]:44885 "EHLO
        da1vs03.rockwellcollins.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbfEBQOo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 May 2019 12:14:44 -0400
Received: from ofwda1n02.rockwellcollins.com (HELO ciulimr02.rockwellcollins.com) ([205.175.227.14])
  by da1vs03.rockwellcollins.com with ESMTP; 02 May 2019 11:14:44 -0500
X-Received: from righttwix.rockwellcollins.com (righttwix.rockwellcollins.com [192.168.141.218])
        by ciulimr02.rockwellcollins.com (Postfix) with ESMTP id 676D62007D;
        Thu,  2 May 2019 11:14:43 -0500 (CDT)
From:   Adam Michaelis <adam.michaelis@rockwellcollins.com>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, charles-antoine.couret@essensium.com,
        devicetree@vger.kernel.org, brandon.maier@rockwellcollins.com,
        clayton.shotwell@rockwellcollins.com,
        Adam Michaelis <adam.michaelis@rockwellcollins.com>
Subject: [PATCH v2 4/6] dt-bindings: iio: ad7949: Add cfg-readback option
Date:   Thu,  2 May 2019 11:14:30 -0500
Message-Id: <1556813672-49861-4-git-send-email-adam.michaelis@rockwellcollins.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
References: <1556813672-49861-1-git-send-email-adam.michaelis@rockwellcollins.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding optional parameter to the ad7949 to indicate that the part should
be configured to include the configuration register value used when
acquiring the current sample value.

Signed-off-by: Adam Michaelis <adam.michaelis@rockwellcollins.com>
---
	V2: Add some defines to reduce use of magic numbers.
---
 Documentation/devicetree/bindings/iio/adc/ad7949.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
index 14ee9a2cb2a5..cd3572828243 100644
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
@@ -18,6 +18,8 @@ Optional properties:
    7: External reference, temperature sensor disabled, buffer enabled
  - vref-supply: The regulator supply for ADC reference voltage. Required
  if external reference selected by 'adi,reference-select'.
+ - adi,cfg-readback: If defined, set bit in configuration register to
+ read-back the configuration used for the current sample value.
 
 Examples:
 adc@0 {
@@ -32,3 +34,10 @@ adc@0 {
 	reg = <0>;
 	adi,reference-select = <0>;
 };
+
+adc@0 {
+	compatible = "adi,ad7949";
+	reg = <0>;
+	adi,reference-select = <1>;
+	adi,cfg-readback;
+};
-- 
1.9.1

