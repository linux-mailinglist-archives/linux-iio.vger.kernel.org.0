Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC6481EB0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbhL3RoD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60268 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbhL3RoA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82D05CE1C99
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D66AC36AEB;
        Thu, 30 Dec 2021 17:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886237;
        bh=GjNUJomAxL5bF2tNlVY7fA2isGUL/eRjyM6F9PCfdzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBTKoBwpt4jeoAC2Tzcjq35qXNR0OGMIqdPjNvDxbYgcmpFxO2fMkthvS7yburOKm
         h+KcYrJVLqVNkPO69RnxfOhT7wZv6dJWTzIl70KgldGpV0Rp6QwP+fsyYGJKq4F4ld
         FjpBW9nNnnWKRiYxMS8uDLB56h1k91K9Ft91S9jH5xGzft0cpwhX7RG+Bn24/h0X8U
         0XHZVAL8bLaw94osgAMUf+nXGUDUGS6J9DMdgciOVLrVghfHDSqklY7nZcEfMpL/Wf
         3eTzzNBHLfjmaKdf4w7IoU0jjA0Ils/lLScU7IAsFnF/GU0E3hUUTPyRWF/qCl0qlu
         27w5+bknvJFXw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/16] iio:light:us5182: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:48:59 +0000
Message-Id: <20211230174911.78291-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The spacing in this driver was inconsistent so make sure we have a space
after { and before } for the two id tables.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/us5182d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 96e4a66ddf28..1492aaf8d84c 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -947,15 +947,15 @@ static const struct dev_pm_ops us5182d_pm_ops = {
 };
 
 static const struct acpi_device_id us5182d_acpi_match[] = {
-	{ "USD5182", 0},
+	{ "USD5182", 0 },
 	{}
 };
 
 MODULE_DEVICE_TABLE(acpi, us5182d_acpi_match);
 
 static const struct i2c_device_id us5182d_id[] = {
-		{"usd5182", 0},
-		{}
+	{ "usd5182", 0 },
+	{}
 };
 
 MODULE_DEVICE_TABLE(i2c, us5182d_id);
-- 
2.34.1

