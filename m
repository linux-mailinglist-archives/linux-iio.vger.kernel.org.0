Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D9D3A4791
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhFKROT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKROS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2218B613F1;
        Fri, 11 Jun 2021 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431540;
        bh=b78PFP+LhxMwH6lGUeQPufculG0n045jGtxjNoRIsVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRDqyJfLKMJam9zPsly9edgMtz54cbh3INAo6Rtb2t8Flgzpr1sWVVZHCQeYB31P3
         mMtQJinw5da0kkvPKTJ9ZnQStEqOQmWR901LoMw254u2TbuAvx3B0si1YVu/M73lqj
         lemc9s35DPOKfYK4V6ovIdE5F2oyZ0/xtwr3ZOFRsmBrI59nhpNQ1ySE7ClZCpZ31W
         ZrI3hShxo+wgetDOwxLtXDpEQjErgZ843l59NdMKLirqqsaDQVbJJ+KcgJ85qnBrPu
         GFCX81l0wv3evELPYUL6yJQxikXMnBtTCNHV1kFgPn3WxKL/k7xrWmye6+5HHOmc5u
         PHi6xbFiyq4Bg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 08/12] iio:accel:mc3220: Cleanup includes.
Date:   Fri, 11 Jun 2021 18:13:50 +0100
Message-Id: <20210611171355.202903-9-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of output of include-what-you-use.
Drop iio/sysfs.h on basis we don't use anything in there in this driver
and add mod_devicetable.h as I'm aiming for consistency on that across
IIO.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mc3230.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 735002b716f3..da0cb428d6e1 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -9,8 +9,8 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 
 #define MC3230_REG_XOUT			0x00
 #define MC3230_REG_YOUT			0x01
-- 
2.31.1

