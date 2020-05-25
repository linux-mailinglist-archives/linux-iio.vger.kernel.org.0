Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAA01E133E
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391303AbgEYRJU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391300AbgEYRJT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:19 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0AEC207D8;
        Mon, 25 May 2020 17:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426558;
        bh=CNWGTwBeYGJWxxzCexMKu10P8TSjcAkE0sqNRE5lu/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sizrp5LYo7GJMNudqMb88tGXDWwf8RTL1XxuJ6+vfGrOeSVGlt4HQD10AECzPHNgt
         7Ta0An6fghqafHnbB/yeuXDXIUTL+61oEwbrXg7hwm/bxyJ9O306fw3Q1cfr2qP4pK
         pEK7/wwkChI5ifx9ZkAWfl2GCCZ4YDX9oVmeDJjA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 15/25] iio:pressure:mpl3115 Force alignment of buffer
Date:   Mon, 25 May 2020 18:06:18 +0100
Message-Id: <20200525170628.503283-16-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst this is another case of the issue Lars reported with
an array of elements of smaller than 8 bytes being passed
to iio_push_to_buffers_with_timestamp, the solution here is
a bit different from the other cases and relies on __aligned
working on the stack (true since 4.6?)

This one is unusual.  We have to do an explicit memset each time
as we are reading 3 bytes into a potential 4 byte channel which
may sometimes be a 2 byte channel depending on what is enabled.
As such, moving the buffer to the heap in the iio_priv structure
doesn't save us much.  We can't use a nice explicit structure
on the stack either as the data channels have different storage
sizes and are all separately controlled.

Fixes: cc26ad455f57 ("iio: Add Freescale MPL3115A2 pressure / temperature sensor driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/pressure/mpl3115.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index d066f3c5a8a6..1eb761befcbe 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -144,7 +144,8 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	u8 buffer[16]; /* 32-bit channel + 16-bit channel + padding + ts */
+	/* 32-bit channel + 16-bit channel + padding + ts */
+	u8 buffer[16] __aligned(8);
 	int ret, pos = 0;
 
 	mutex_lock(&data->lock);
-- 
2.26.2

