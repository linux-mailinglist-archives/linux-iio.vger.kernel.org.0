Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815603A44E3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhFKP0e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhFKP0a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8DD1D61404;
        Fri, 11 Jun 2021 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425073;
        bh=ZiNOt8KDCt+fRzUgKHxVHICNGdH9V2MKhmyLI4pOmUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtk26PpASY+qGYZ/+ySB2nx85sE89+CfgwJlO4uodwsG5xWWSs7xhbFXIKnhQKJUs
         Cea9usPFeOPzt5xsdFSy4l/lq9UVSJq3AFEP4zLJrgd4oYqiTjedg+uRXX7GO5I5dd
         g0dQMDWVS5BQducoc8urOXo4lnWn5Du3w/LiefWgayIDtTeDPkw4RMgS2Q6SfwQRIS
         DIppkIEc7i2Vbb8u/gnkXFBaWjBml2MFcnChQZw7P/Bs236uS55QYuCWnYOpgk0Nfw
         hVxttZHJYqKkdRP1kjIoV4TLvGuLI6PyAKreSFsqYN9DGSiS2ysF1VyYATWwM4xWFl
         1e9z/TvHUBS7A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/7] staging:iio:impedance-analyzer: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:12 +0100
Message-Id: <20210611152614.109361-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use
tool.  Drop unused headers and include some that should probably
have always been included.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 793918e1c45f..33dc8b7eb37a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -5,17 +5,20 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
+#include <linux/bitmap.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-- 
2.31.1

