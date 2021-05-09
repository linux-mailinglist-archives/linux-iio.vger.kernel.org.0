Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFA377666
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhEILi3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhEILi3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C854C613F0;
        Sun,  9 May 2021 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560246;
        bh=nUYCEpZ4d5x4PUSJjh7b5cyzrnTJXFaXEP3ADX/XbeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctGUjowZP7p9xLopvCdAgnrFVlQD44VVRwTBap3WvlDz2TdXLPQLbRNPWG7rAHx3U
         zcaI6scEVP5HPqcGE71h1W9eaMHUacXp0YQcC0nXBBFGi9p1BGNzQw3j9+RBwOiUgj
         9f1GdLyTd+1pC1qA8w67pjfMbzrAA2WECZ/fMyJ7m1Tjqs8GFR9NdwJIEE6TDOMZP9
         PH9V+luzgSv6XjuICqFjvoYzH+2/pXqE190NHgyPZFf8vmyztRxgwcW+M6MfEL3Xp4
         xXEfXQ/2j9J7wTHfUAgDfgopQBbFaucHqtutGZzAp1SagZkaB9fqTNAVGoINpFUwKP
         YnKIVcsagSXUw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 16/28] iio: dac: stm32-dac: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:42 +0100
Message-Id: <20210509113354.660190-17-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/dac/stm32-dac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index a5b0a52bf86e..dd2e306824e7 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -69,9 +69,8 @@ static int stm32_dac_set_enable_state(struct iio_dev *indio_dev, int ch,
 	}
 
 	if (enable) {
-		ret = pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0) {
-			pm_runtime_put_noidle(dev);
 			mutex_unlock(&dac->lock);
 			return ret;
 		}
-- 
2.31.1

