Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3E481EBB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236158AbhL3RoX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48952 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241509AbhL3RoX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7E306173E
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78644C36AE7;
        Thu, 30 Dec 2021 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886262;
        bh=oofL7NOD6SemSCrNnA9YqAVxzqNJ1TzTXObOU8ZYNgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3sb5D1O03R7bIwarxKCyJprprdk1WYBVX35NZioJhN7OiIic7T1IaLN9LEUhpXMU
         uQwPLZmVRfm+rU6kwCKesurNxhyPo/kmn7h0bjxwDJGLhDK2s2Adxt6HnizPjGzDIq
         j9MgGwE7yH/r7CPM/5ZhLiraFwR2pP7lfur5tx9pYuD2FO4UuwL0b9xBViNzuRcUwc
         KMq7Vokxb3ma8INKVPZiBwjZhQaQ/JCPxjqgYHx5Xj9NOs0mvQ1AgGr7VeC9bcAtIu
         LvSTGtnlzrN/fUQP+OR/H7eK8fUCqgkCM5Jmr+B3vwyBTAQD9HWUl0KKUDDBImJGA5
         Ub0mu3IP6p5JQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: [PATCH 15/16] iio:proximity:vl53l0x: Tidy up white space around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:10 +0000
Message-Id: <20211230174911.78291-16-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously inconsistent with a space after { but not before }.
Tidy that up to avoid providing a bad example that might get copied
into other drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
---
 drivers/iio/proximity/vl53l0x-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index cf38144b6f95..661a79ea200d 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -226,7 +226,7 @@ static int vl53l0x_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id vl53l0x_id[] = {
-	{ "vl53l0x", 0},
+	{ "vl53l0x", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
-- 
2.34.1

