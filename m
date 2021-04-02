Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0038352F6B
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhDBSrw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 14:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhDBSrw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 14:47:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14B0161165;
        Fri,  2 Apr 2021 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617389270;
        bh=v/LYvSH89yZ1xU15oxNGe9W7Dqxs2TkiUTMAZ9JOKiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4Wfnphl2df3TULWa/i+A1CSjPQlTIuAK4OsXXjYxhIw7YFCb0b4P3pHZLlvhuzzx
         3dDXsuDXRUjidHLeDrTOt50U2L1nNYO/D0OH1eXYDxsWE6s0bjYH5+hEy49OJa+W12
         pgtyCAUKN0E6xUH4AxE6+N6TBAncaoR89bz4hG++db1VE38ghyW64NP4SyVO+f6vIq
         eLF2YQ2Ok3HI6bE4A/cErQQsiKEMlGNJUrOSBfPb6Y+J1ftssusE7skcPTngDq9Cgo
         MMY4VQdAuYeWF+speLnXN7nKfBuo1ksGukHwid3RCydICg79kp0TS4ceQacGQVnp6H
         wst8ElMRwi9Cg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/7] iio:adc:sun4i-gpadc: Use new IRQF_NO_AUTOEN flag instead of request then disable
Date:   Fri,  2 Apr 2021 19:45:41 +0100
Message-Id: <20210402184544.488862-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402184544.488862-1-jic23@kernel.org>
References: <20210402184544.488862-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This new flag ensures a requested irq is not autoenabled, thus removing
the need for the disable_irq() that follows and closing off any chance
of spurious interrupts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 99b43f28e879..2d393a4dfff6 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -470,7 +470,8 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	}
 
 	*irq = ret;
-	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler, 0,
+	ret = devm_request_any_context_irq(&pdev->dev, *irq, handler,
+					   IRQF_NO_AUTOEN,
 					   devname, info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "could not request %s interrupt: %d\n",
@@ -478,7 +479,6 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 		return ret;
 	}
 
-	disable_irq(*irq);
 	atomic_set(atomic, 0);
 
 	return 0;
-- 
2.31.1

