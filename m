Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7119481EB2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbhL3RoG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 12:44:06 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60284 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbhL3RoF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 12:44:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3AA0DCE19A8
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 17:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EEEC36AEB;
        Thu, 30 Dec 2021 17:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640886242;
        bh=BF3GPOewNaZl2MF+8NzKdt0Ng2HqV0cnV5JgIt+l2eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQIXeyuSEz5fAkWFRmc63CDoDtaTFRA+VoPthTXApFgWt3+E3y1I8xneUa4HMxkGq
         vCgUU6CqgooRSmBIPJSGqokYD2Yn+IMILHqkltp9Q97H6ekRb6PP5jmBEpdZT8sKVt
         jl/v/zppu+9SlOOa7SYur/nBQ4yTDgMF5Y5vGf9vT930YEa0AuJoUTIQmSXzaWyK2X
         Vwq/94Xa0dXBr729pN1sMYWTwOs6sGfTaRLAhEUqYCqwT2DBiky35DSR677576FHeI
         QgPj3hip5fym0rhMJ76zET0Raej+3vkMW+zkPM3F6B/ZbHOZ2iGXNB/jW5xcT40GFO
         hWNIn2qc61kog==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 06/16] iio:proximity:ping: White space cleanup of spacing around {} in id tables
Date:   Thu, 30 Dec 2021 17:49:01 +0000
Message-Id: <20211230174911.78291-7-jic23@kernel.org>
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
Avoid providing examples of this inconsistency that get copied into new
drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/ping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index 1283ac1c2e03..24a97d41e115 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -267,8 +267,8 @@ static const struct iio_chan_spec ping_chan_spec[] = {
 };
 
 static const struct of_device_id of_ping_match[] = {
-	{ .compatible = "parallax,ping", .data = &pa_ping_cfg},
-	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg},
+	{ .compatible = "parallax,ping", .data = &pa_ping_cfg },
+	{ .compatible = "parallax,laserping", .data = &pa_laser_ping_cfg },
 	{},
 };
 
-- 
2.34.1

