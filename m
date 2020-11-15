Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F392B38C7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgKOTcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:13 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7350124170;
        Sun, 15 Nov 2020 19:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468733;
        bh=qg7S1FYh+40H4HhjM4ldZ9PsZ0Izqr4zzHGY0I4mLyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Walhpthl8BjFhAjx5iuwb9HpKPxp4OEaSIT0aYJBPypDKznqw3lptkJpkUtnuAHFD
         uhvDM0MSZFdjhtfWmdpVS8pwU3H0guEmz8h+mWKDazWw7QmhczK3evW1OrY9DUIHAy
         QWvHYMAbr4KMqoB+jzf/9LtITterFHpYwWHL/iFk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 8/9] arm64: dts: exynos: Drop incorrect use of io-channel-ranges property.
Date:   Sun, 15 Nov 2020 19:29:50 +0000
Message-Id: <20201115192951.1073632-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property is for consumers of io-channels. Here it is used in
providers of those channels.

Note dt_schema will currently flag this as an error due to a dependency
between this property and io-channels.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 -
 arch/arm64/boot/dts/exynos/exynos7.dtsi    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 8eb4576da8f3..ac33372f611b 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1445,7 +1445,6 @@ adc: adc@14d10000 {
 			clock-names = "adc";
 			clocks = <&cmu_peric CLK_PCLK_ADCIF>;
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index b9ed6a33e290..1f59e437e606 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -567,7 +567,6 @@ adc: adc@13620000 {
 			clocks = <&clock_peric0 PCLK_ADCIF>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			status = "disabled";
 		};
 
-- 
2.28.0

