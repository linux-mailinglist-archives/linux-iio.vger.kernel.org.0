Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D713EECAB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 14:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHQMog (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 08:44:36 -0400
Received: from first.geanix.com ([116.203.34.67]:37256 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229539AbhHQMog (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Aug 2021 08:44:36 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 5BD39440EB8;
        Tue, 17 Aug 2021 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1629204241; bh=wsMAzbXu+CYg3T+rFliUvr1a08eDPZiV6+ghNN5JGKc=;
        h=From:To:Cc:Subject:Date;
        b=ZFnFsJQNbi3yyPD28vIclL2nQG5Kl+mtg6lmQa+tXXQuKKVpmqdzjB/vRctonCFI3
         MVlBCFCu6EtYqLsU3w+mc0jPssC92m2y0ZDdxCGSau9opTGUcPXBUP3WWxxCll1uEB
         9YKAoTZOPMPodQ84BPrg7Lkz5lVF/OixIczOF25xB8kkJjdI8Wn+A8Gv0X5wF4/h08
         Sv7TUrFA3iV+s4LMxLtxloE/Kz25aLyNIBj1invzZUg+1emQp4btYHPYu1i3tQZajL
         iYsUhsdgmQwlgFqZEvBl4vyp7/0+po8E1ZAnGPprplhONBmEMNVwbL1ADNupOzns1Y
         hBq+J5PKBNPeQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-iio@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH] iio: accel: fxls8962af: return IRQ_HANDLED when fifo is flushed
Date:   Tue, 17 Aug 2021 14:43:36 +0200
Message-Id: <20210817124336.1672169-1-sean@geanix.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

fxls8962af_fifo_flush() will return the samples flushed.
So return IRQ_NONE only if an error is returned.

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/accel/fxls8962af-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 078d87865fde..6b36eb362d07 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -738,7 +738,7 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
 
 	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
 		ret = fxls8962af_fifo_flush(indio_dev);
-		if (ret)
+		if (ret < 0)
 			return IRQ_NONE;
 
 		return IRQ_HANDLED;
-- 
2.32.0

