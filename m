Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7F468D2B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbhLEUZj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43778 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUZi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 809C5B80EE1
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A6EC341C5;
        Sun,  5 Dec 2021 20:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735729;
        bh=wq6OAWf8p6jJu+9bxdyQGlkxojQH7pOOrvg1D21ji+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FK7LKlroxACiJEeLfrKksFVGLrQoR+Qo42FF8V663n9I8a8JzMpBZyklSmTTiwyRO
         r1ONkj+WGGKR+1K/EFZXx5CSopgBpi7W/gZdWgu4vrsXuS0F73VX1IkfYHfvfGcH2r
         U4cwgBezVe1gFtosL0l8tcagnlwBpqybhnA0RfSairK56kBctzfPJCE2RFJMZs6x+n
         Ebq0HTywUqdvtDGAupxv2pPwIVrJe4h+ZOVuAlbPy4DwxwGkDPtejzXV1ujvopw+RN
         amT5i/Wm6WhyifjOCYgaBskypsSgLcEq0F18lhdFGRDOHBSXI4R8i85LSr60fHGRSI
         mAXILbQxmHQ6w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 01/17] staging:iio:adc:ad7280a: Fix handing of device address bit reversing.
Date:   Sun,  5 Dec 2021 20:26:54 +0000
Message-Id: <20211205202710.2847005-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
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
2.34.1

