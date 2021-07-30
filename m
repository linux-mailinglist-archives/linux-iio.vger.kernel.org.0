Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3DF3DB45A
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhG3HRG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 03:17:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:56978
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230273AbhG3HRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jul 2021 03:17:06 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E40EE3F0FF;
        Fri, 30 Jul 2021 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627629420;
        bh=Bxi4+gVVY7RYVNsZmSxbI2QT4hl08RVLKb5YuD0/vnA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=vnwdWLoh0qTfJ7WUGbqHFlZ7uh/kRdoDkKiiwU+I3APP6kLRUeVHqLmsoAx5iQUr/
         5zWuyNteG+wmdDMTFvrVF0lCR11+h+Q+wWzKNo7TVwzNP4iwiAPouL49/XArnt03w/
         9UTG1DXKX2DCa6tJmEkHHYsK3fZLxksNDXr6j/HtBUh/C/4PrDDxqGM7tp7Onny81m
         WLQzpBYK2kUZpO/MW9LT98tke5QEcfKy/dGpEC7aCCj3q1PP3yf3ZAhZWR8x+6lZXf
         zk+CdtTQw7W4VuSd9DTUJzAVbvfwinl8MgxvpV8VatoviEXYhmes3OYkftQueR3Gp9
         mLaqOtPy13z/A==
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Pradeep Goudagunta <pgoudagunta@nvidia.com>,
        Marek Belisko <marek@goldelico.com>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Fix incorrect exit of for-loop
Date:   Fri, 30 Jul 2021 08:16:51 +0100
Message-Id: <20210730071651.17394-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the for-loop that scans for the optimial adc_period iterates
through all the possible adc_period levels because the exit logic in
the loop is inverted. I believe the comparison should be swapped and
the continue replaced with a break to exit the loop at the correct
point.

Addresses-Coverity: ("Continue has no effect")
Fixes: e08e19c331fb ("iio:adc: add iio driver for Palmas (twl6035/7) gpadc")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/palmas_gpadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 6ef09609be9f..f9c8385c72d3 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -664,8 +664,8 @@ static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
 
 	adc_period = adc->auto_conversion_period;
 	for (i = 0; i < 16; ++i) {
-		if (((1000 * (1 << i)) / 32) < adc_period)
-			continue;
+		if (((1000 * (1 << i)) / 32) >= adc_period)
+			break;
 	}
 	if (i > 0)
 		i--;
-- 
2.31.1

