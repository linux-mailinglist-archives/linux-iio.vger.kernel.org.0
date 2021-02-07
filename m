Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59176312589
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBGPuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AC8F64E52;
        Sun,  7 Feb 2021 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712933;
        bh=AoC8AdZxKBKJlcFns1l5O/bD1szk6uZUqhe8jzPPMTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/pl44mv/RvAjFykZXKaBA4yrS3VWveD5Yz7/0BFtod9580ktiCWDai9y0datlnSN
         LYGFMVUL2AEvk8n4Y4dk+Up6NFy5qpC67lsoM98hHbmO7Wp9YyK3vahuZOoMOepjpA
         AKb5HQSq8hLXHj1P9g8lfL4DQbmRDaHoTk/7+/WnVD0CEbArHodwRLD4O2K9PpvfA/
         7hYfwTxGFgBjKGllqxmYkDQgBzbduUG7lvmQJPcV+zf6N/Wq6EWggJxvFgmqq9XYaX
         U26cU3dThqU814hzdygOBVQQufgenPqzUG5cMbDfywVaROXiQcaUgKebI7i60QcGxr
         stc0LCEAI42Fw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 07/24] staging:iio:cdc:ad7150: Simplify event handling by only using rising direction.
Date:   Sun,  7 Feb 2021 15:46:06 +0000
Message-Id: <20210207154623.433442-8-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The event line is active high and not maskable within the device.
It indicates current state directly.

The device supports separate rising and falling thresholds so rather
than trying to using each bound to detect in both directions just use
IRQF_TRIGGER_RISING.  If a user wants to detect the value falling
back below the threshold, then set the falling threshold appropriately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 539beed1a511..34e6afe52f0e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -603,7 +603,6 @@ static int ad7150_probe(struct i2c_client *client,
 						NULL,
 						&ad7150_event_handler,
 						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"ad7150_irq1",
 						indio_dev);
-- 
2.30.0

