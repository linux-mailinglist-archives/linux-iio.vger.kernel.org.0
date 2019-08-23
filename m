Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6F9B2B9
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbfHWOzG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 10:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395561AbfHWOzF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 10:55:05 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 636AD23400;
        Fri, 23 Aug 2019 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572104;
        bh=fr4N7dB86WBDn85mKUGsngUXYt3sdawwdc92J+rXkWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoOCQjHM0KeE2TlrDTobHhS0ycIkCQjbx2vZ3RMN3+iemKTa4o4h0wygW+7u0awyn
         Lkj8uNUwKQ5+ELt0Int6Ut40AasNinoloHvDzIzxJQ5h2zpTfOjPXRu7l+MLp92jWj
         ezkYzvX3AqomxcAAa0iDzc3F/j/GGN/PQPhnMg1o=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 9/9] ARM: dts: exynos: Remove not accurate secondary ADC compatible
Date:   Fri, 23 Aug 2019 16:53:56 +0200
Message-Id: <20190823145356.6341-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Exynos3250 ADC has its own compatible because of differences from
other Exynos SoCs.  Therefore it is not entirely compatible with
samsung,exynos-adc-v2.  Remove the samsung,exynos-adc-v2.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 5659c4a10729..784818490376 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -450,8 +450,7 @@
 		};
 
 		adc: adc@126c0000 {
-			compatible = "samsung,exynos3250-adc",
-				     "samsung,exynos-adc-v2";
+			compatible = "samsung,exynos3250-adc";
 			reg = <0x126C0000 0x100>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "adc", "sclk";
-- 
2.17.1

