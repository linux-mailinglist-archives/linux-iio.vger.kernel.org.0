Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7D370824
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEARQ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7F766157F;
        Sat,  1 May 2021 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889336;
        bh=ZdoKOV6oYT0V0AAEyVPG07gyiCCJZ6KOceGjN6nN0g4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFTNyJxMTM8fg2K8+EHMjnAjWzqKY9afe3lEHcriUD6NYFdxyiCovWdhKzIyuPtHr
         821XmAHBlPMKuxIpsLatGom3h+3w/thtXjBN0lIul0aJCh+4SXBCERs53G8mgBO7TZ
         oFAY8KOwRURKQfmAk7ryS61RzCaXTZCDJk//jUdBpm/KqVDU4/BZ+4ig3Sh7LAJBVS
         bw1XvlasuBwDvspGiXhS9y38P0sLpDlujmHFD72fhaZaYq7Q6TMe3nuK0Gcd+wfPuG
         Q8YWf//B6L+V5B28ER1DkS1DrWwW9L0dCpsSfeH4fyhGzQOIxtpzpqEgCNiGciwmHz
         izy08ODMVRiMA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH 09/11] iio: light: vcnl4000: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:50 +0100
Message-Id: <20210501171352.512953-10-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
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
index 2f7916f95689..3b5e27053ef2 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -910,7 +910,7 @@ static irqreturn_t vcnl4010_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4000_data *data = iio_priv(indio_dev);
 	const unsigned long *active_scan_mask = indio_dev->active_scan_mask;
-	u16 buffer[8] = {0}; /* 1x16-bit + ts */
+	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
 	bool data_read = false;
 	unsigned long isr;
 	int val = 0;
-- 
2.31.1

