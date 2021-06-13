Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3383A595C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhFMPXY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbhFMPXY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096C061357;
        Sun, 13 Jun 2021 15:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597683;
        bh=PF1US0c7Wsh9C/4TzIRkm0l7hg4wgena7Kc0Y2kWV9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkGfo7UeO0Q6FlseiBRAcnxlQ3JLo7/8pOAxuAk8zSOoKCf7AVcojoAOGNnTblDkZ
         G9pqrFx9R7NUlyd3YHICuTJEWqfwAWMPEChvZ9oMBPYXsDFSOYQ/5omDnq4lqjpM5+
         zEl/rdiT9Rpphh00m845iJXk59O+aaDSP31zXCqnnc89hNiJsi6Kcm2uIMAwN4ByD2
         a3WTismLKlpwU+DzHVUgOknqlkc21RBNNSgD8M+e6fgUWno2ZF85crGw5HbRTY4pAN
         LgtouDx52gpbWpbFsmELHl2fNA+v5k6xD0vIA8maVu5mlLivCX37E9l3KTorHZ6PAP
         etx4W1xNboFjw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH RESEND 7/8] iio: light: vcnl4035: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:23:00 +0100
Message-Id: <20210613152301.571002-8-jic23@kernel.org>
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
necessitate the addition of an explict memset(), to avoid a potential
kernel data leak, making for a less minimal fix.

Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl40352")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Parthiban Nallathambi <pn@denx.de>
---
 drivers/iio/light/vcnl4035.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
index fd2f181b16db..0db306ee910e 100644
--- a/drivers/iio/light/vcnl4035.c
+++ b/drivers/iio/light/vcnl4035.c
@@ -102,7 +102,8 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct vcnl4035_data *data = iio_priv(indio_dev);
-	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)];
+	/* Ensure naturally aligned timestamp */
+	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8);
 	int ret;
 
 	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
-- 
2.32.0

