Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5424B2B38B7
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgKOTcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:01 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471A122314;
        Sun, 15 Nov 2020 19:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468720;
        bh=yvl2FChY/nKwVcFuQidhF3bYrP5jyxXEU9FBzixiq5g=;
        h=From:To:Cc:Subject:Date:From;
        b=YLV37UwBsgG4JqTGnh/7lqaVb2EdSj/fCr/p8y+wCSP0evjrcUqX2k3eCcrs7EfD+
         YupEKDsFAd5RLw2TicUmV59NPkw50e/9zSZ9/P7Zeu0Sqf3+jnpHTzw5DxSv1/ZAP/
         L3uu/lB1sWW0jOKCfUamX9SfYh2bjeVInvSmpyXs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/9] dt-bindings: IIO: Drop wrong use of io-channel-ranges then drop it as well.
Date:   Sun, 15 Nov 2020 19:29:42 +0000
Message-Id: <20201115192951.1073632-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Rob Herring pointed out that the recent addition of io-channel provider
consumer interfaces to the dt_schema repo [1] has highlighted some misuse of
this property.   It is also clear that we don't have any places where
it is actually needed.

There is at least 1 remaining instance of this in a txt file but that
gets cleaned up in patches already under review to convert that binding
to yaml.

1-2 fix up examples in dts schema where this is missued.
3-6,8 fix up places where the property was given for providers of io-channels
rather than consumers.
7 drops a consumer case where it doesn't seem to be needed
9 is an RFC to drop the support entirely if we don't have any known correct
users of this property outside mainline.  I'm willing to leave the code
in place is we can identify it being used, but still wish to deprecate
it and remote the property from examples and dt_schema.

All of these can go through relevant trees as there should be no
cross dependencies.

[1] https://github.com/devicetree-org/dt-schema/commit/170a908a2204838652407662d326f30cbeb87142

Jonathan Cameron (9):
  dt-bindings:iio:qcom-spmi-vadc drop incorrect io-channel-ranges from
    example
  dt-bindings:iio:samsung,exynos-adc: drop missuse of io-channel-ranges
  ARM: dts: Cygnus: Drop incorrect io-channel-ranges property.
  ARM: dts: exynos: Drop incorrect use of io-channel-ranges
  ARM: dts: s5pv210: Drop incorrect use of io-channel-ranges property.
  ARM: dts: qcom-pma8084: Drop incorrect use of io-channel-ranges
  ARM: dts: s5pv210-aries: Drop unneeded io-channel-ranges property.
  arm64: dts: exynos: Drop incorrect use of io-channel-ranges property.
  iio: inkern: Drop io-channel-ranges dt property support

 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  3 --
 .../bindings/iio/adc/samsung,exynos-adc.yaml  |  4 --
 arch/arm/boot/dts/bcm-cygnus.dtsi             |  1 -
 arch/arm/boot/dts/exynos3250.dtsi             |  1 -
 arch/arm/boot/dts/exynos4412.dtsi             |  1 -
 arch/arm/boot/dts/exynos5250.dtsi             |  1 -
 arch/arm/boot/dts/exynos54xx.dtsi             |  1 -
 arch/arm/boot/dts/qcom-pma8084.dtsi           |  1 -
 arch/arm/boot/dts/s5pv210-aries.dtsi          |  1 -
 arch/arm/boot/dts/s5pv210.dtsi                |  1 -
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  1 -
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |  1 -
 drivers/iio/inkern.c                          | 49 +++++++------------
 13 files changed, 17 insertions(+), 49 deletions(-)

-- 
2.28.0

