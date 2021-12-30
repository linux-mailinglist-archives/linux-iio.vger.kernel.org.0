Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17D9481EAE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbhL3Rny (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbhL3Rny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:43:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91FC061574
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:43:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C772CE1C9C
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEBFC36AE9;
        Thu, 30 Dec 2021 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886231;
        bh=+GrkgofJmAWmPsrfqNr19/E4AxYhGw+5wWhi/xtKOUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yo3gljo1HpWLha/1qrEBKunkekDU0C2MxQwRTd7l2Vy9e7b8OxwD7OAxoeQAsZAP5
         9pJxjvJhhTOGkRrWnNdPf5kwZOdO/tROrFhggD5k/eQbor4h9kBPDZtO0jFvoDSG2i
         9WJvjiCeAtia6Si7E8vULkLcagGIOglc7/+fEZULUPX/lmzSC9CsgZMSba1FcYukTC
         wrwrIFQtmNq/2cWbrCVRbAR/TedtXhkS0XFYz9X5RCDN/hfIo6+rJTh1t+lA/0DrpL
         u9cBaxIwD2ig/wRxsRyT6txngWKEethK1IKPhkfTEgUGbJKFUFf7aG9zSYCkOlFxq2
         CJQaU0kyJpxdg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 01/16] iio:chemical:atlas: Trivial white space cleanup to add space before }
Date:   Thu, 30 Dec 2021 17:48:56 +0000
Message-Id: <20211230174911.78291-2-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Having a space after the { and not one before the } is inconsistent and
good to remove examples that might get copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 04b44a327614..a8211dd20b35 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -589,11 +589,11 @@ static const struct iio_info atlas_info = {
 };
 
 static const struct i2c_device_id atlas_id[] = {
-	{ "atlas-ph-sm", ATLAS_PH_SM},
-	{ "atlas-ec-sm", ATLAS_EC_SM},
-	{ "atlas-orp-sm", ATLAS_ORP_SM},
-	{ "atlas-do-sm", ATLAS_DO_SM},
-	{ "atlas-rtd-sm", ATLAS_RTD_SM},
+	{ "atlas-ph-sm", ATLAS_PH_SM },
+	{ "atlas-ec-sm", ATLAS_EC_SM },
+	{ "atlas-orp-sm", ATLAS_ORP_SM },
+	{ "atlas-do-sm", ATLAS_DO_SM },
+	{ "atlas-rtd-sm", ATLAS_RTD_SM },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, atlas_id);
-- 
2.34.1

