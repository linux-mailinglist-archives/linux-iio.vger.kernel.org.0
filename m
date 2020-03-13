Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34A9184106
	for <lists+linux-iio@lfdr.de>; Fri, 13 Mar 2020 07:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCMGqL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Mar 2020 02:46:11 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:55940 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbgCMGqK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 02:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KJSvEB5GYx0NMRbbOsFK/DkUQp3KkBqyuRsPuE4sghw=; b=Yal9W1k8kM3pVZzT7fC7nBi4gn
        Ug8bHIqPnkSR6Y7gzYoXtzMncvN597X7+eaxvjNR3nVq3L6JhENT9a38Fw6jktwCLYS8eVNlKOabR
        t665oWn/YYF26Ewef0QRxo6tHDNRvfh0W+Lh1NCzx2snG2W2CyNMl/IGE5brjrlLHZJM=;
Received: from p200300ccff096400e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff09:6400:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4v-0002pB-5A; Fri, 13 Mar 2020 07:45:53 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jCe4u-0008Ct-Fq; Fri, 13 Mar 2020 07:45:52 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, stefan@agner.ch, b.galvani@gmail.com,
        phh@phh.me, letux-kernel@openphoenux.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v6 1/7] dt-bindings: mfd: rn5t618: Document optional property interrupts
Date:   Fri, 13 Mar 2020 07:45:28 +0100
Message-Id: <20200313064535.31503-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200313064535.31503-1-andreas@kemnade.info>
References: <20200313064535.31503-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

These chips use interrupts for various things like RTC alarm.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4: add refernce to interrupt binding
documentation
 Documentation/devicetree/bindings/mfd/rn5t618.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
index b74e5e94d1cb..16778ea00dbc 100644
--- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
+++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
@@ -15,6 +15,8 @@ Required properties:
  - reg: the I2C slave address of the device
 
 Optional properties:
+ - interrupts: interrupt mapping for IRQ
+   See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
  - system-power-controller:
    See Documentation/devicetree/bindings/power/power-controller.txt
 
@@ -32,6 +34,8 @@ Example:
 	pmic@32 {
 		compatible = "ricoh,rn5t618";
 		reg = <0x32>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
 		system-power-controller;
 
 		regulators {
-- 
2.20.1

