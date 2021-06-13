Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A843A595B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhFMPXX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhFMPXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A116120E;
        Sun, 13 Jun 2021 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597681;
        bh=3/7ZH7g1j1rFfoo5SRi/tmpWpYw4Vi9sb+xRO6Uci58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JoOJrOew9U83dlBDsQTytPuU/9pm33vp0uZaq8DSBjW3Sz8WGTd6B7V/QwBAyOEFv
         48vjvUOEy1kRGE70gjasUnwJmEXwwncHplZIvZ8/01HxqFglnJHNw/tt/eZYzUCvNO
         0/iL/0FGTg78csNVjCfRB22wEOul0zO8pP6j1yU8FQ5bAlqVttSsGmaZH5/uls6yqR
         XzmTc/9H4l8x7sJzVEqsyFdkH+YCP3T8K0UZlP79BKiYrIY00+iomv7twlTQ2qD78C
         yHmEb36xwYwbQeaUjqZOO/4M7P/W+A+BE2dtxoYYWmxkL/BEaGRGs/TjKS7vlS0hf0
         fCJB3lbNycvug==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH RESEND 6/8] iio: light: vcnl4000: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:22:59 +0100
Message-Id: <20210613152301.571002-7-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
References: <20210613152301.571002-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Here an explicit structure is not used, because the holes would
necessitate the addition of an explict memset(), to avoid a kernel
data leak, making for a less minimal fix.

Found during an audit of all callers of iio_push_to_buffers_with_timestamp()

Fixes: 8fe78d5261e7 ("iio: vcnl4000: Add buffer support for VCNL4010/20.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 01772327a947..e02e92bc2928 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -908,7 +908,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
-	u16 buffer[8] = {0}; /* 1x16-bit + ts */
+	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
 	bool data_read = false;
 	unsigned long isr;
 	int val = 0;
-- 
2.32.0

