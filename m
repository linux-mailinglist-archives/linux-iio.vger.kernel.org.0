Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF436B76D
	for <lists+linux-iio@lfdr.de>; Mon, 26 Apr 2021 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbhDZREz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Apr 2021 13:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233736AbhDZREx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:04:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D80A61026;
        Mon, 26 Apr 2021 17:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456652;
        bh=KqZ66w4rGkxSrrpm0eFPIfRnZ0XDnW8oNhdKj8ln5Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjxsvMSkUAGLHIBmgsJolt65b214xRxgiU3EdrQIdvJflypZDEfuJKgYz8oPxhVGf
         QyzKVD55wHsNv/utdEI905HuXzvLcHaO4yGuQXEZR7dWsQEIhvPCB6SLtcprcBpmT4
         qc/Y0CeWwSOx5qke2UuDL+KQExMlg9LED9Wt+5PVgHEHvM+oPW7uSZXznnOQL321Ev
         ZbTElZZRZP25hOsdDnHA5rYBbk+M3XuQ/eL8JNIrwdgoYLkZV0fiD9O9YkpLKH/waS
         oUUlRLtHxqBPisb3PDADfdregFfbC5DInnu2ej9EMyr3LWeFaaBccXQINJ5lZ2uZbI
         18bjI3UcgwMow==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/8] iio: accel: bmi088: Drop manual assignment of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:44 +0100
Message-Id: <20210426170251.351957-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The core already set this to the same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/iio/accel/bmi088-accel-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 12d00658e46f..61aaaf48c040 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -496,7 +496,6 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
-	indio_dev->dev.parent = dev;
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->name = name ? name : data->chip_info->name;
-- 
2.31.1

