Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FB4F659
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFVO57 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO56 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474312089E;
        Sat, 22 Jun 2019 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215478;
        bh=8GrcL+W1O0TnMyKu7ePiSV4Zne+c0AZUYut8NHcW1O4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKbfc0P3nbbsCkOzVzqj49L58cThGdG+nfu9E4qdkEtFLK2/hXq3i/JF01AXDYLS3
         Wp463N5ctAQisuUXhz42iU6tUXXo/4/rGW27MeACIGug/+IpoLot9R3iypARdutF7Z
         yQM6dmOsQOChxUxnVgmPmM+HafrkwoEXe0IpLy8g=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/14] iio: kfifo-buf: Add SPDX header
Date:   Sat, 22 Jun 2019 15:55:10 +0100
Message-Id: <20190622145516.3231-9-jic23@kernel.org>
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

Previously no license header, but there is a MODULE_LICENSE
so match that with GPL-2.0+

Header was filled with default GPL-2.0 so update fix that as well.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/kfifo_buf.c | 1 +
 include/linux/iio/kfifo_buf.h  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
index 70c302a93d7f..041a8d0b9aac 100644
--- a/drivers/iio/buffer/kfifo_buf.c
+++ b/drivers/iio/buffer/kfifo_buf.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/include/linux/iio/kfifo_buf.h b/include/linux/iio/kfifo_buf.h
index 764659e01b68..4611bbcc37c3 100644
--- a/include/linux/iio/kfifo_buf.h
+++ b/include/linux/iio/kfifo_buf.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0+ */
 #ifndef __LINUX_IIO_KFIFO_BUF_H__
 #define __LINUX_IIO_KFIFO_BUF_H__
 
-- 
2.22.0

