Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB025FE8F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Sep 2020 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgIGQSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Sep 2020 12:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730321AbgIGQN4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C0621897;
        Mon,  7 Sep 2020 16:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495235;
        bh=lJTmDWXKg31GyIqyPqmh82OMpoVmcuqwnXsiJb+RucQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=apbLCJlXZDFOcqmNdYWKAzYQ5IYHMZM0fzUr/YBo4a3tCRD9ELwNdyRu2pOZh1vmg
         PGXKryJQ5bXeTX23Z8mt93I/IOYHBsKxh+gsZ7z1XcmdKyWd8kWHxk+eQcH5hU52Fj
         GCRVfGx0ID0YL6dibhHWAaIw3bhpNRPBD3lKLQBo=
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
Subject: [RFT 22/25] ARM: dts: s5pv210: replace deprecated "gpios" i2c-gpio property in Aquila
Date:   Mon,  7 Sep 2020 18:11:38 +0200
Message-Id: <20200907161141.31034-23-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

"gpios" property is deprecated.  Update the Aquila DTS to fix
dtbs_checks warnings like:

  i2c-pmic: 'sda-gpios' is a required property
  i2c-pmic: 'scl-gpios' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aquila.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 28e9e81bb2d1..8e57e5a1f0c5 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -65,8 +65,8 @@
 
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

