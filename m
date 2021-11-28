Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366BA4607FE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345082AbhK1RZU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:25:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35538 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbhK1RXU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41B20B80D29
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 17:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74552C53FCB;
        Sun, 28 Nov 2021 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638120002;
        bh=wWNWeyos2kXI7B8ZCXvjb517pr/rLsHgEl+6fqsoOD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPetb+/NPUX44MW9vfETvFNRc38HHqG868zxDkuvu0r9N1gVvCOG82ZykzPZnz2YU
         q7mFRhBGA8wMYrngwLmKcfIWgmYH9KaLFPm3O4V84Yt4SEKIjgZGJwqjyqkvXtWxlQ
         EMKhca08/GnMSoQA/sfb3bpf635eTxf2anSaCylJ2blyRwFc/P0MBg9XE+IUos0MH7
         8ftS4jgZA72g3nVdokAsZyuwrsMMrPfqxaNSDiJrRpXWnuHkMTqKKmzbWlTOlWkjlR
         y4m06sEBwwlJHrA8AAKek2XqD7IEfVcotiJIWM/zBJiMFGMVHAV8p+TsAgMCkI0CdJ
         hbW+A7rSvbHqQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 04/12] iio:adc:ti-ads1015: Suppress clang W=1 warning about pointer to enum conversion.
Date:   Sun, 28 Nov 2021 17:24:37 +0000
Message-Id: <20211128172445.2616166-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128172445.2616166-1-jic23@kernel.org>
References: <20211128172445.2616166-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Cast to a uintptr_t rather than directly to the enum.

As per the discussion in below linked media patch.

Link: https://lore.kernel.org/linux-media/CAK8P3a2ez6nEw4d+Mqa3XXAz0RFTZHunqqRj6sCt7Y_Eqqs0rw@mail.gmail.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index b92d4cd1b823..068efbce1710 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -950,7 +950,7 @@ static int ads1015_probe(struct i2c_client *client,
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	chip = (enum chip_ids)device_get_match_data(&client->dev);
+	chip = (uintptr_t)device_get_match_data(&client->dev);
 	if (chip == ADSXXXX)
 		chip = id->driver_data;
 	switch (chip) {
-- 
2.34.1

