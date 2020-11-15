Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03E52B38C1
	for <lists+linux-iio@lfdr.de>; Sun, 15 Nov 2020 20:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKOTcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Nov 2020 14:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:09 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BFA922453;
        Sun, 15 Nov 2020 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468728;
        bh=EygQxIRuhbt1ue+G0jOWi99anW905/Chac5nTAS9+tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bvfGXOZu+HrkThdEC2OpyNpOLHHJkDU0MTOBkX33kyvNQ8nV7P6tCqi63/Ynf7IDx
         aI6dZrUZaRyC71Jdbi0faEftTQhCeZG67Zd5z4O8ZQC92RE6bdg7PNUahwAi93FzPv
         YWL0wal9yfvdcd4vA9F4UBZcOFDtMw83oBr+zUns=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/9] ARM: dts: s5pv210: Drop incorrect use of io-channel-ranges property.
Date:   Sun, 15 Nov 2020 19:29:47 +0000
Message-Id: <20201115192951.1073632-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property is relevant to consumers of io-channels.  Here it is
used by a provider.

dt_schema will now report and error as this property must be in the
same node as io-channels and it is not here.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index 2871351ab907..353ba7b09a0c 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -149,7 +149,6 @@ adc: adc@e1700000 {
 			clocks = <&clocks CLK_TSADC>;
 			clock-names = "adc";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			status = "disabled";
 		};
 
-- 
2.28.0

