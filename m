Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF628481EAD
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241494AbhL3Rny (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241488AbhL3Rny (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED376C06173E
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 09:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B60761710
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96676C36AE7;
        Thu, 30 Dec 2021 17:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886233;
        bh=yKuP9Z0i/msxNggKUVioOGQoiNk8KjSa++EANEf7NqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s0ACeqAATKSnKeCeJP9Xvk3ZMpUIce9HZ5vv3/tyeqqEQDTHE4qRELTrjCdypOc+7
         qllnvxMGZRsp7ut74tLWgmJYUX4yvpnYXF5A1FXj8pu5CRG6RE5Z/tUn8rlf1ZVPkg
         S9uVwQ6t3BQwpJw9YwwWC9b5txcxC1l3CcVzAd7+ga35z6m2LhGayRyoTiBVjGD1OX
         dyujuQ2NOjG5ZbRwjAIE7MS7JGKPZpUL2uEcpTvRRXsDcxdF9jdMkNJkeGWQjgs8mm
         gPx9XGH2q5VuTuIcAVNRQr4oILxbu4NK6jyLFQyb0x8W8IsJ7G/fci2JliQQ72UsN3
         p5iLTaVNv7ARg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 02/16] iio:light:pa12203001: Tidy up white space change to add spaces after { and before }
Date:   Thu, 30 Dec 2021 17:48:57 +0000
Message-Id: <20211230174911.78291-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One case in here was inconsistent and was main focus of this patch.
In that case there was a space after the { and none before the }.
The second case was then inconsistent in having now spaces.
Change makes sure there are spaces.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/pa12203001.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index a52b2c788540..528fa5dd2b13 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -452,14 +452,14 @@ static const struct dev_pm_ops pa12203001_pm_ops = {
 };
 
 static const struct acpi_device_id pa12203001_acpi_match[] = {
-	{ "TXCPA122", 0},
+	{ "TXCPA122", 0 },
 	{}
 };
 
 MODULE_DEVICE_TABLE(acpi, pa12203001_acpi_match);
 
 static const struct i2c_device_id pa12203001_id[] = {
-		{"txcpa122", 0},
+		{ "txcpa122", 0 },
 		{}
 };
 
-- 
2.34.1

