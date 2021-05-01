Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F9370822
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEARQZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91527614A7;
        Sat,  1 May 2021 17:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889334;
        bh=JwEAoIwHkzBSAmAdq3Nrno00qVDCe+GWTUHUoWHQKdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJkZWUtYX795o038yqIPd/jLUSH1u1KhRWgGKpNSrWzAAyMm7Ll3gTnEmbARcFhwD
         mBeZPZSge2rdqPq//KzmY/gzgfmTkKNIET1I+UIr1I99gYy/Jku7Ag9dZ8BZytB6IE
         6fG40LuxU1FRvjktzPRQR13aN7VxMBvvNn7IbjerBTJzcAez8wmKP9g9TToYyq/3If
         +fsdBTlKu4JOz6QmV3MQktDYlWB8SqHYG65Yyrb9TcYnlfI2vgQqcvhIwFrtrMs7v/
         pBHA9UyVTGYjfgIwXt38DvKZTEFuEImyvqf/oSwpDEqzj2mBtABGtNwM1udAjBW8tl
         0NSlcG9WIlzLA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 07/11] iio: potentiostat: lmp91000: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:48 +0100
Message-Id: <20210501171352.512953-8-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Here structure is not used, because this buffer is also used
elsewhere in the driver.

Fixes: 67e17300dc1d ("iio: potentiostat: add LMP91000 support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/potentiostat/lmp91000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 8a9c576616ee..ff39ba975da7 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -71,8 +71,8 @@ struct lmp91000_data {
 
 	struct completion completion;
 	u8 chan_select;
-
-	u32 buffer[4]; /* 64-bit data + 64-bit timestamp */
+	/* 64-bit data + 64-bit naturally aligned timestamp */
+	u32 buffer[4] __aligned(8);
 };
 
 static const struct iio_chan_spec lmp91000_channels[] = {
-- 
2.31.1

