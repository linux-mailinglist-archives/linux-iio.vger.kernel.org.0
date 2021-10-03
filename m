Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D542023C
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhJCPbJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 11:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhJCPbI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 11:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6062361A4F;
        Sun,  3 Oct 2021 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633274961;
        bh=QcJU86k2Lx5NZ2UC/bYzR5+8NKWQVg0c7QV5PFTArXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvIDCo9HsZ7QmpFDuzaYnqw4LltdKWCAkhDRlQ0dz6nNsaLPVWXYJRPSQoGZkel47
         1pXb9VPGFsip9AxpPQ/BjThh/2yqJ9So93AzNksUR4lj6MEqNw1Wb4EnQHiA7ZHdip
         9jjgHQu2ifuHxrZ0kIOmMDs5kirBbN+LXRTxTUMKbFcR5iTzTgymb3cBPKNcwdXMlE
         F8CpyB4NnVj4GY3uTuIECclbvAWiOLKfvI6JyM5Pfp24Ab61ohH3CK6qjG1+8ZbqzO
         4uNEbN2cDOPai46mhJ0ZtUFyf+rk0IyFH4B4wxkRL8YjDAWUfSj8/ZMeAxWmiic8i8
         dnnHfpVDM0o0g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 07/11] iio: configfs: Bring includes up to date
Date:   Sun,  3 Oct 2021 16:33:02 +0100
Message-Id: <20211003153306.391766-8-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003153306.391766-1-jic23@kernel.org>
References: <20211003153306.391766-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on manual inspection of the suggestions from the
include-what-you-use tool

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-configfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-configfs.c b/drivers/iio/industrialio-configfs.c
index 47900de1f105..37f530faa131 100644
--- a/drivers/iio/industrialio-configfs.c
+++ b/drivers/iio/industrialio-configfs.c
@@ -6,12 +6,11 @@
  */
 
 #include <linux/configfs.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
-#include <linux/kmod.h>
-#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/configfs.h>
 
 static const struct config_item_type iio_root_group_type = {
-- 
2.33.0

