Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E43A6554
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbhFNLhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbhFNLfX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:35:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D123B61209;
        Mon, 14 Jun 2021 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670401;
        bh=DGEJhZj0RNHztUBk54pVFKT/l8A/xuK64FSh/emWbrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpQNKOz0rJYJasV7V+HjOCpDjppJddjTx3HiNAKqXNk+qlv+snnBIdLIEI3inI78c
         5bPK1Cp+JOvYlCx8dbWJ3KO0xflDEeVcvIpnsSlu1InFCk1uX4xxdc8OIkQIloowRv
         NfxCHaUmBcqggAakxnUtQLLCbo+mxUEcL3imXiTPCQRvoNSlv/ALLFvkqVXRqaqhy6
         MLbTxNmE12+sfbg3TBlGkiYHb+5OdJ67LjQBU8o4cGXLWzXS/Cl34IasKGxXyzxdPp
         wD3kRBhrKvmHbHbx7Ccw8Gi58MABYHhXM+F9Otg5cb6iFcNfoDA3zopeEf27hX/Oog
         N561Uo69/Kuhg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 01/17] staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
Date:   Mon, 14 Jun 2021 12:34:51 +0100
Message-Id: <20210614113507.897732-2-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The bit reversal was wrong for bits 1 and 3 of the 5 bits.
Result is driver failure to probe if you have more than 2 daisy-chained
devices.  Discovered via QEMU based device emulation.

Fixes tag is for when this moved from a macro to a function, but it
was broken before that.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Fixes: 065a7c0b1fec ("Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse")
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index fef0055b8990..20183b2ea127 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -107,9 +107,9 @@
 static unsigned int ad7280a_devaddr(unsigned int addr)
 {
 	return ((addr & 0x1) << 4) |
-	       ((addr & 0x2) << 3) |
+	       ((addr & 0x2) << 2) |
 	       (addr & 0x4) |
-	       ((addr & 0x8) >> 3) |
+	       ((addr & 0x8) >> 2) |
 	       ((addr & 0x10) >> 4);
 }
 
-- 
2.32.0

