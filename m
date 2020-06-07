Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA81F0CAC
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgFGP4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F654207ED;
        Sun,  7 Jun 2020 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545404;
        bh=Xm+MlJ2SnfPeDcxMvvfWqhIChWvopZqJRFLMYpPAjEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxaKLJcS8ZkQaprZEkqBd24TEHelY3uHG3tKZHnqvygj6TmdUlfX34JSybP28gciu
         HBDOfLg6U4IKdvVwwKhOHfBwLTjPpXO8TgnrPbE2oT11CAu+wujzKxj1evy77daXb0
         Dy7kXMrpIdyFwlxbHJiTt+n3jWxwNHg7wFMMmIX4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 22/32] iio:pressure:mpl3115 Force alignment of buffer
Date:   Sun,  7 Jun 2020 16:53:58 +0100
Message-Id: <20200607155408.958437-23-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607155408.958437-1-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
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
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl3115.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index ccdb0b70e48c..8a481dbe808c 100644
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

