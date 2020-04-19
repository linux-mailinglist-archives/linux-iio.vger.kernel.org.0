Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE2A1AFB8D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDSPEY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFD572223D;
        Sun, 19 Apr 2020 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308663;
        bh=QNskoY1itoFU/fw3SvXQqgFTvdObxWHJ+yFsXBj2yBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om/2NLMx6/GH+6HPHDv6IK+QxMxVBrm63ltyD+nYKyLpqWqfLhn57stH3JARi6oN8
         a6lJfMoCHu1hqqxLqm12tHDUgexjsIv6cx2QNa86tREpSk77JzcKrEOa9losSGxADE
         2SDGONJ8HdkB0hEiVGIWotuWTXKk8CF7noMdma+g=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/7] iio: light: opt3001: Add mod_devicetable.h and drop use of of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:04 +0100
Message-Id: <20200419150206.43033-6-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Enables probing via ACPI PRP0001 but mostly about removing examples
that might be copied to new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/opt3001.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 92004a2563ea..82abfa57b59c 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -844,7 +845,7 @@ static struct i2c_driver opt3001_driver = {
 
 	.driver = {
 		.name = "opt3001",
-		.of_match_table = of_match_ptr(opt3001_of_match),
+		.of_match_table = opt3001_of_match,
 	},
 };
 
-- 
2.26.1

