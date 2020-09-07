Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32AE25FE8C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgIGQOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729893AbgIGQN7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1641D2177B;
        Mon,  7 Sep 2020 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495238;
        bh=jWL3HWcEEiNy/8rVC7of/uRNx5Tnyo1FPmlxmXCKRBs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iKLcR5zfkqvnazuCXr9yn7VqbcERxdWOIZBqIz9YdCR//HQh5G4biLwQe9jpFkztW
         jMEzjpnJlJ09LOpX92V8MZ6uxOQ7HXBuNvSglz/haWLZZiiesc1yIr5eUFpWP9ChEc
         Fi6sj66RzV9aDkequXlALLdESWA+dvlG3DOOZrKs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [RFT 23/25] ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in Goni
Date:   Mon,  7 Sep 2020 18:11:39 +0200
Message-Id: <20200907161141.31034-24-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"gpios" property is deprecated.  Update the Goni DTS to fix
dtbs_checks warnings like:

  i2c-pmic: 'sda-gpios' is a required property
  i2c-pmic: 'scl-gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index eec6531e6ef8..ad8d5d2fa32d 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -76,8 +76,8 @@
 
 	i2c_pmic: i2c-pmic {
 		compatible = "i2c-gpio";
-		gpios = <&gpj4 0 GPIO_ACTIVE_HIGH>, /* sda */
-			<&gpj4 3 GPIO_ACTIVE_HIGH>; /* scl */
+		sda-gpios = <&gpj4 0 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&gpj4 3 GPIO_ACTIVE_HIGH>;
 		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1

