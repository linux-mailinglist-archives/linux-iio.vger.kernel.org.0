Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923644F65C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfFVO6D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 10:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO6D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:58:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3089208CA;
        Sat, 22 Jun 2019 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215482;
        bh=+zgqrw0ByGWaHhZpsJe8f0namex8Ygb1+BOHzEh3KXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDWKolDUhzGDP8Syg/sqGJetXuEvT4+h2FHphLqeWl7olmCEs1NbuXVjih3fsnAKb
         LFEVDnO0buP4W8spRXppOVPBci2nQFyeozFkDtbQzUMZfLqWdISzMk8ifVQFpqZv9Y
         0Uwemr5JAkJTX2qCSnF7K+6CNkmvODTapGRx+D88=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/14] iio: triggered-buffer: SPDX + fix MODULE_LICENSE to GPLv2
Date:   Sat, 22 Jun 2019 15:55:12 +0100
Message-Id: <20190622145516.3231-11-jic23@kernel.org>
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

The licensing was inconsistent for this module, so gone with
the clearly stated header text which had no "or later"
element.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index d3db1fce54d2..0c413012f8e1 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -1,10 +1,7 @@
- /*
+// SPDX-License-Identifier: GPL-2.0
+/*
  * Copyright (c) 2012 Analog Devices, Inc.
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/kernel.h>
@@ -142,4 +139,4 @@ EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_cleanup);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("IIO helper functions for setting up triggered buffers");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.22.0

