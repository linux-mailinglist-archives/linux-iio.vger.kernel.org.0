Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89AF481EB6
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbhL3RoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60324 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 256F1CE1C9D
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE76C36AE9;
        Thu, 30 Dec 2021 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886251;
        bh=2FLqDZnAUk4T1uzuFjmMscKPKH4+noN1yvTwx/2OZ94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HExVsBr6wUSrgYod3VO63FAlmFJlh5v22Bwznhhwd+ocS1njxk0skG6yKoR8I5Lgp
         5aCn94CyWaySF8zZ4gJ4kB3Ggwfm4su0twmr9iEabCQgQJp3uIQcynvvmXy1jfc+nf
         tUuREgkeK5yLJenh7KJzD6VmU/lR112F/jcxc+MjAdzK+7hXaZG/VUBwrChoAJk6zq
         Ib/lxrrKHD3gSSAmj+eoUDF3NYdaLyroMmiVd3GTSgA42MRdTlEA1+/dXnLWXnvIMe
         zlvL/eZu6vtsqlDxC2PiNwOhh/kuZqoLbByeoQaVdSNLHJXU6PpW2FlBr6XuQ7USdb
         JV2uGchxtNbEw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 10/16] iio:frequency:admv1013: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:05 +0000
Message-Id: <20211230174911.78291-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The spacing was inconsistent with a space after the { but not
before the }. Tidy this up to avoid providing a bad example to copy into
new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index 6cdeb50143af..849a9ea7ebe5 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -630,7 +630,7 @@ static int admv1013_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id admv1013_id[] = {
-	{ "admv1013", 0},
+	{ "admv1013", 0 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, admv1013_id);
-- 
2.34.1

