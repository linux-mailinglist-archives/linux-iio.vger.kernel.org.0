Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E722A36B76E
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbhDZRE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234795AbhDZREz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8946561077;
        Mon, 26 Apr 2021 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456653;
        bh=CL34ytVnq5hQFJ7sGACvCbprHpXlfGidJHXPqvihC80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrWSrECqhxPRUSPBnGQDRrQwiOOLszJyzVV615Usm4avM8kstfHQIitfmI3m30C3a
         aWZQSFx8YptoZevx17aTI+4vT1zrzkCKXyMtSyGzjbxt2usG1RNQ+QOeZFSoVuiNwa
         JHmso2S7/BwZZJ4v5Mo7PlVE52qeU58ADs0k0tp7q33kjZVha86q8K/cFPqBWSvMCs
         C34LSJDoa/aex+3eZZTbKSh9V5OTtuxz+PIwCNXA7g37do1dFJQa63q4R7sekv7vhU
         s8F4rWHmbloO34YAoBgTM2M7ddHZjnx7s5XuoeH2kp+tsAt22DC5joUWwMFEosMagx
         5tVo9RckcLcbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH 2/8] iio: dac: ad5766: Drop duplicate setting of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:45 +0100
Message-Id: <20210426170251.351957-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is set to the same value in devm_iio_device_alloc() so no need to do
it again.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/dac/ad5766.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index 79837a4b3a41..b0f180d46394 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -597,7 +597,6 @@ static int ad5766_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->info = &ad5766_info;
-	indio_dev->dev.parent = &spi->dev;
 	indio_dev->dev.of_node = spi->dev.of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.31.1

