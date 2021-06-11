Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621733A44E0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhFKP0c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhFKP00 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44BCE61400;
        Fri, 11 Jun 2021 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425069;
        bh=so2ZmCZCAuLN/tUwmKDJk9PunTi8CzGLj9JwuSKwal8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDB4jm3OPVtlWuXYB4uNAOpgrQednDQka/1BzQQf6hCurXZE00ZisC5Xi8CVRxdir
         MNF7CUfhDgE7sY+UOjj2Cp9TV7zGKW2DZ1SKX5Rn9zP7EXPUBqD6y+0Y3RSPCFc8rI
         EilYkZ58j9IhpRKY4vgsL2E6wCKcDu6AMXUMTK6Tef++hOgK6ZtDYOK91ZN7qRcLtm
         t6TOKvjoWshRvd5RnqSwJnAps8vR4pIud6rwh+FlP3wU8j34egsOQRvsSC3PGlmE8X
         nTsSryuLJYe/zlLpu4pv0sDjFULDDb+G1iY9tq320PNiOmAKf0gl62zBhycdHmZDla
         1lwgwFy5LGFYg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/7] staging:iio:cdc:ad7746: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:10 +0100
Message-Id: <20210611152614.109361-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Drop some unused includes + include some which probably should have
been there in the first place.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7746.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 4221312f0a32..fbdf90604c0d 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -8,11 +8,11 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
-#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/stat.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
-- 
2.31.1

