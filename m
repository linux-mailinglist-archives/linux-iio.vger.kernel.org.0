Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19C72B38C5
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgKOTcM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:12 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFBE922384;
        Sun, 15 Nov 2020 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468732;
        bh=9K6SJF2DPcYP95bCSQS5MwGaGuNC39mHRymwVDL/LaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5SwWYWu/7mh0rCtohgZYikZl7vMPJbrFNQ5NVDwP1Yxbw4jkuaodub8Okx+lP7+N
         5FSaawtrBkIHtNJvcp+QoCQVmCVcEC6kCxJnmzan0wCGCnJCclBAZs8NEIHXnf6YeM
         UoFMSkFmSM4OT+UKzMxXvbwsoTI/p+SDInhm1KPg=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 7/9] ARM: dts: s5pv210-aries: Drop unneeded io-channel-ranges property.
Date:   Sun, 15 Nov 2020 19:29:49 +0000
Message-Id: <20201115192951.1073632-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property is only useful if a node has children as it allows them
to then use io-channel properties in the parent.  Here there are no
children.

This is harmless, but we are planning to shortly drop this property
as it is rarely used correctly and there is little reason it would
ever be needed as we can just provide the io-channels property to
any child nodes that need it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index bd4450dbdcb6..1ad9582db1ee 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -589,7 +589,6 @@ gp2a_shunt: current-sense-shunt {
 		io-channels = <&adc 9>;
 		shunt-resistor-micro-ohms = <47000000>; /* 47 ohms */
 		#io-channel-cells = <0>;
-		io-channel-ranges;
 	};
 };
 
-- 
2.28.0

