Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2DA36B772
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhDZRFC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235161AbhDZRFC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F77061006;
        Mon, 26 Apr 2021 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456659;
        bh=XyQ1LylS59jGa9hej3qbQhyq6X6qs03YV0cNDe5vWMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HPvAPOLK05cFXJX1ACqlQf3PI+y9I13zvUtnfid7KFqKxFmOqCh5z3LHmyXP+1G33
         +2qfQrHtCOgHOvOnmShqmR32TY62VHA5VFtYAn7a7HV+sqvjeHlth4wMFKoooXIw/1
         hJFZMGLKOARCfnpliLi5coNNYNtoxIxsX7voE3hgxw0wog713eeYnTmjW1Pml9fMIB
         EnD2Wq6uTnJRWc/Mza4qIK5k9ApvHUmQ+L/UKVRDhGea8ndorYA41ykN5MXx9/bbds
         6YEOW2FD9zexEFdeQXZ5rS97ITmMIDqA9tjUK9MTq5xsSfgcJw2jKD9lJ1vnPY8dCn
         Q9vbZSumzJv7w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomislav Denis <tomislav.denis@avl.com>
Subject: [PATCH 5/8] iio: adc: ti-ads131e08: Drop duplicate setting of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:48 +0100
Message-Id: <20210426170251.351957-6-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Already set to same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomislav Denis <tomislav.denis@avl.com>
---
 drivers/iio/adc/ti-ads131e08.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 5dcf1e9294d7..d220eef5c0df 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -824,7 +824,6 @@ static int ads131e08_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->info->name;
-	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ads131e08_iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.31.1

