Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3785220C7FE
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jun 2020 14:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgF1MjE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jun 2020 08:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgF1MjD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91ACE20885;
        Sun, 28 Jun 2020 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347943;
        bh=mBpR4+1rGqD4HDEtxnq9PHSdaeSSVRt0zkY0vwIasd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBFCxAA7bK5YVx91gPRoNQHC72WE5cheBXvZIYgge0+zjXUbYyHtcYddSofHkxBG/
         ywJB/h23kybo0eqxFA2nzGoO2H+TnIxb4OuY4QJA9oAOxeUDbmrXmmv0MnbrTfV8Fy
         aLFhs/gNvjiO9XtRRTgzCmQpQDgayW8zancmaT9w=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Subject: [PATCH 03/23] iio:adc:hi8435: Drop unused of_gpio.h header
Date:   Sun, 28 Jun 2020 13:36:34 +0100
Message-Id: <20200628123654.32830-4-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I guess this is a left over from some earlier cleanup. Not used
currently.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
---
 drivers/iio/adc/hi8435.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 127e78243233..235374ec7bab 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -17,7 +17,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
-- 
2.27.0

