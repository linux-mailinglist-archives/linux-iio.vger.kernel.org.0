Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51313352F6C
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBSry (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235984AbhDBSry (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F74361151;
        Fri,  2 Apr 2021 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389273;
        bh=zYKZZTERA99i0KEMqsxBjYL6dtr3DGCWTOfkshaW+J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWI2qE+rXJnucqHBeRuxG0nfRXEDstDBjwPca/1PN6ATbk5AwnIVDNLehT3wN1WH3
         gdl25JUOxnvNlTC/mHOgQ8rh7dIATTbPkbpxs5DrOOUGrzcpjkgwfYel5xa7GemwDi
         woj80rTLZb1SmlAVvC+2Mqz07u1yeU9dY4WdwfPgw7T7oDoNcXo8TdsGZB3RoY1Hju
         A/JHvSc0tOxSwMfcnkWN6hqg/HWv8dYAGfdoCLjDpiFke6M76WYuUEvccZklBvbPkq
         MqhSjNRAz7p8zTaqOgkre6+j1+0k1jvktj+v9mYHJWxwASHgA5m+L2EbUZrpEWwsrA
         CujwcazSaMDVQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 5/7] iio:chemical:scd30: Use IRQF_NO_AUTOEN to avoid irq request then disable
Date:   Fri,  2 Apr 2021 19:45:42 +0100
Message-Id: <20210402184544.488862-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new flag cleanly avoids the need for a dance where we request the
interrupt only to immediately disabling it by ensuring it is not
auto-enabled in the first place.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
---
 drivers/iio/chemical/scd30_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 261c277ac4a5..d89f117dd0ef 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -655,19 +655,19 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 
 	indio_dev->trig = iio_trigger_get(trig);
 
+	/*
+	 * Interrupt is enabled just before taking a fresh measurement
+	 * and disabled afterwards. This means we need to ensure it is not
+	 * enabled here to keep calls to enable/disable balanced.
+	 */
 	ret = devm_request_threaded_irq(dev, state->irq, scd30_irq_handler,
-					scd30_irq_thread_handler, IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					scd30_irq_thread_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT |
+					IRQF_NO_AUTOEN,
 					indio_dev->name, indio_dev);
 	if (ret)
 		dev_err(dev, "failed to request irq\n");
 
-	/*
-	 * Interrupt is enabled just before taking a fresh measurement
-	 * and disabled afterwards. This means we need to disable it here
-	 * to keep calls to enable/disable balanced.
-	 */
-	disable_irq(state->irq);
-
 	return ret;
 }
 
-- 
2.31.1

