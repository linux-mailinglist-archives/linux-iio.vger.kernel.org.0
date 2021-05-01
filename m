Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7E370823
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEARQZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231566AbhEARQZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E2F61494;
        Sat,  1 May 2021 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889335;
        bh=89oLJqJwIQXRp1mCCkHQbbgvhA/qytOulqQlmRBlKcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfjrEiay9E8n8Mj5dhuPjeg4vqvSlNzI4/TsQQsVuP4mC96Ou4yi+oGQOetJ1BiZi
         DBPd6am4Irmc1aQHu1mXRj1e8THTjy7Bxrak08SD40ofu/ybkRpg1XXmE1BBm3S3HC
         H5WNdayfQvTvuaMAehPQuQsf9vyCpUeqtRE6HLAMfL30OwZ1Q4iAQw+JHkegIAk72G
         32zVVI7oh0ar8x3ELXjTe6ZLk0F0xy8ILY+yaslVlge8IDjbU7YlYh8O0q9gzOlPS3
         37NuF2vIJZQz7qReXRkGnvwHGk9AmiJ3X9Kg77dhBi9+78MmAmPvSYoWdQzWgfmLQ2
         yMLOm5/n3Ip3w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH 08/11] iio: magn: rm3100: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:49 +0100
Message-Id: <20210501171352.512953-9-jic23@kernel.org>
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

Here an explicit structure is not used, because this buffer is used in
a non-trivial way for data repacking.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index dd811da9cb6d..934da20781bb 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -78,7 +78,8 @@ struct rm3100_data {
 	bool use_interrupt;
 	int conversion_time;
 	int scale;
-	u8 buffer[RM3100_SCAN_BYTES];
+	/* Ensure naturally aligned timestamp */
+	u8 buffer[RM3100_SCAN_BYTES] __aligned(8);
 	struct iio_trigger *drdy_trig;
 
 	/*
-- 
2.31.1

