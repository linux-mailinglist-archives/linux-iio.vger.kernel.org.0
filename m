Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C313D4F654
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVO5t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:49 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32CCE20679;
        Sat, 22 Jun 2019 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215468;
        bh=CoOcIJ/F5TFlOGbEUMjRsUYfQ81+FptII5JZiEf3g6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TaWjeGFZ0A3M+DgivIRV6cxKCShqRQZwyshkziEMIO9mT5Ds4Ea3QKXqnQ0R9QktS
         QigmbUh5kqWvL+FNouimmXj/7lFZt5r0kfmBIZIPg7v9/pnq5fuPgTU9/V91QAXeps
         WiqW4SVABb0ZYYcjAA6Iz7wfa0htzEslrrLiaVOI=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/14] iio:configfs: SPDX headers.
Date:   Sat, 22 Jun 2019 15:55:04 +0100
Message-Id: <20190622145516.3231-3-jic23@kernel.org>
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

Simple removal of boilerplate and insertion of spdx for GPL v2.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/industrialio-configfs.c | 5 +----
 include/linux/iio/configfs.h        | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 5a0aae119369..92b1ab4f159d 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Industrial I/O configfs bits
  *
  * Copyright (c) 2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/configfs.h>
diff --git a/include/linux/iio/configfs.h b/include/linux/iio/configfs.h
index 93befd67c15c..75752e69916c 100644
--- a/include/linux/iio/configfs.h
+++ b/include/linux/iio/configfs.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O configfs support
  *
  * Copyright (c) 2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #ifndef __IIO_CONFIGFS
 #define __IIO_CONFIGFS
-- 
2.22.0

