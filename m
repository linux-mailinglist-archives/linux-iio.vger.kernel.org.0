Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08011481EBC
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhL3RoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhL3RoZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282DBC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:44:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9D66173E
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8826C36AE9;
        Thu, 30 Dec 2021 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886264;
        bh=puZZpHs4Sxrm8/+UjRdos/e9j/jfx3Cd6Xm3WpOrPLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSg15eRnMPI7rLHf9TNylZjgDEgDpAVBwkYOZ/fb+vmLm51s2rn1ffwOvrHUJZ0HW
         9u5c7eW+7AJ/sJMY5SSXrmgjl7monpt1lTuNLvq3PpkQsGy/yCZHUUad5q8tI3NrVI
         tftfJfnBXbdll9fX2xR/GOUKf6VapuUKwvLvrMu+vvyBk0XqFc+oW5FhnDIF9tAioj
         WjFZT8Oqu/n4kqzd9pH0/nKQsx6YwA50iX7wwkJVV/+0hPLwYqin6ifBa9U+rmGPQN
         WyBYSpbDAMvRvec2+J2+M71CxLyO9hpN2IVfI75VWVYzrpMFWCKIpDL5HcHsFf7ZiT
         +VvIOTKkV6DsQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 16/16] iio:accel:dmard09: Tidy up white space around {} in id table
Date:   Thu, 30 Dec 2021 17:49:11 +0000
Message-Id: <20211230174911.78291-17-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Previously inconsistent with a space after { but not before }.
Tidy that up to avoid providing a bad example that might get
copied into other drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/dmard09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/dmard09.c b/drivers/iio/accel/dmard09.c
index e6e28c964777..53ab6078cb7f 100644
--- a/drivers/iio/accel/dmard09.c
+++ b/drivers/iio/accel/dmard09.c
@@ -126,7 +126,7 @@ static int dmard09_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id dmard09_id[] = {
-	{ "dmard09", 0},
+	{ "dmard09", 0 },
 	{ },
 };
 
-- 
2.34.1

