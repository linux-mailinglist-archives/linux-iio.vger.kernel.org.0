Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6463271394
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITL2c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 07:28:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgITL2c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:32 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C7A216C4;
        Sun, 20 Sep 2020 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601311;
        bh=FMt/MWnMDBB5Me8UPa7JHiF4FYkqXlGcj/+y+o7MUoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZvaPFwjzlLDwGM/3f+QzRqMOnE0PXjkhxLn0zegn4SSMRo9Zc+t4xYc4P3a/WaPu
         qXoO1ykiLVCzz4ufjv93Fk2dMi98OPJelSoqR9CZ5vYz/A4OshrCCmNguny3s1ERaQ
         SULgMILtszJhkqe/vMQU4hP1r/a0ygvmfKGHvqng=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v4 6/8] iio:pressure:mpl3115: Force alignment of buffer
Date:   Sun, 20 Sep 2020 12:27:40 +0100
Message-Id: <20200920112742.170751-7-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920112742.170751-1-jic23@kernel.org>
References: <20200920112742.170751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst this is another case of the issue Lars reported with
an array of elements of smaller than 8 bytes being passed
to iio_push_to_buffers_with_timestamp(), the solution here is
a bit different from the other cases and relies on __aligned
working on the stack (true since 4.6?)

This one is unusual.  We have to do an explicit memset() each time
as we are reading 3 bytes into a potential 4 byte channel which
may sometimes be a 2 byte channel depending on what is enabled.
As such, moving the buffer to the heap in the iio_priv structure
doesn't save us much.  We can't use a nice explicit structure
on the stack either as the data channels have different storage
sizes and are all separately controlled.

Fixes: cc26ad455f57 ("iio: Add Freescale MPL3115A2 pressure / temperature sensor driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
v4: Added a 'special' comment as this one is unique.

 drivers/iio/pressure/mpl3115.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index ccdb0b70e48c..1eb9e7b29e05 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -144,7 +144,14 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	u8 buffer[16]; /* 32-bit channel + 16-bit channel + padding + ts */
+	/*
+	 * 32-bit channel + 16-bit channel + padding + ts
+	 * Note that it is possible for only one of the first 2
+	 * channels to be enabled. If that happens, the first element
+	 * of the buffer may be either 16 or 32-bits.  As such we cannot
+	 * use a simple structure definition to express this data layout.
+	 */
+	u8 buffer[16] __aligned(8);
 	int ret, pos = 0;
 
 	mutex_lock(&data->lock);
-- 
2.28.0

