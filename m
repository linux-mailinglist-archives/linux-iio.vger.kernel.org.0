Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43E31258E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGPuL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D8B964D9A;
        Sun,  7 Feb 2021 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712930;
        bh=DTCL8xHphxH/c6QWI2fC4+eyHtH3JVQ9LLgh4b8UoWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UjdQ0GyKVWCRxeZxGMmmUrCSKuR+jPyyJ/uge0Zu8zdTPRSvVwBb3VJFOPSlxN571
         JALo7RWSIOTlarvTZQTg0oHx4rYhpNSZr+QiNCihtT0PZ2ZnIegcZoKk8wBePzSLC7
         YT0/XLlFT34mnSqzTff+JqrmO4KxxTlDUTQqfJHPw8KDsEf9g4wE/1da8TiMBaUm1k
         Cg6hVdncF6sYqbrPwh37VYpfA7ujiPryjhW41vFj6zmZW+c3cnrJM8KPkpTTiqNv+6
         KVmEEbDyVoU9RkzzjUyMzam+UpjGJmoyOQrvqAuf9cVbJSlgX/uSyKQiPhJld1Rduc
         cXmL5vChXToYw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 05/24] staging:iio:cdc:ad7150: Drop platform data support
Date:   Sun,  7 Feb 2021 15:46:04 +0000
Message-Id: <20210207154623.433442-6-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There are no mainline board files using this driver so lets drop
the platform_data support in favour of devicetree and similar.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 0dce1b8ce76d..7ad9105e6b46 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -570,20 +570,6 @@ static int ad7150_probe(struct i2c_client *client,
 			return ret;
 	}
 
-	if (client->dev.platform_data) {
-		ret = devm_request_threaded_irq(&client->dev, *(unsigned int *)
-						client->dev.platform_data,
-						NULL,
-						&ad7150_event_handler,
-						IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						"ad7150_irq2",
-						indio_dev);
-		if (ret)
-			return ret;
-	}
-
 	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 	if (ret)
 		return ret;
-- 
2.30.0

