Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477374F65A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfFVO5y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E302084E;
        Sat, 22 Jun 2019 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215473;
        bh=1SWcOBbMn6qx5/OxmB+Dc1o42dx9RsUNKRAaGLcXHu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv7+kz1lhvUGFVD1zoltUVKrX/2AC+EjmgammiZQdpGFjAgTtd3Qx3XM9L3prV4pq
         Z+HcUHb8lk1klMzYxh530kkSnhXb8I/xUq2asMG8Dgm85fmcYu1XtZuOw1FiFZfViV
         LwIGmMahxw4V48mh7crljS31D2IkDsb1018UpkKU=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/14] iio: triggered-event: Add SPDX and fix header license to match the code.
Date:   Sat, 22 Jun 2019 15:55:07 +0100
Message-Id: <20190622145516.3231-6-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The c file had clear license text, this disgreed with the default
GPL-2.0 added due to the header having no previous license
text at all.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-triggered-event.c | 6 +-----
 include/linux/iio/triggered_event.h        | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-triggered-event.c b/drivers/iio/industrialio-triggered-event.c
index 8cc254fac16a..77b59dbfe710 100644
--- a/drivers/iio/industrialio-triggered-event.c
+++ b/drivers/iio/industrialio-triggered-event.c
@@ -1,10 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Cogent Embedded, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/kernel.h>
diff --git a/include/linux/iio/triggered_event.h b/include/linux/iio/triggered_event.h
index 13250fd99745..8f73190188ce 100644
--- a/include/linux/iio/triggered_event.h
+++ b/include/linux/iio/triggered_event.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifndef _LINUX_IIO_TRIGGERED_EVENT_H_
 #define _LINUX_IIO_TRIGGERED_EVENT_H_
 
-- 
2.22.0

