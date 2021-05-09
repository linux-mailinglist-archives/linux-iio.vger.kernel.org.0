Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE8377665
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhEILi1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhEILi1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 899E5613D6;
        Sun,  9 May 2021 11:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560244;
        bh=ktz9ZZL/vgz6pv7ouc/rfrcq/t+oLYtKqjGKA4vzExM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCXcRdYT10ijQzkHxFBorzp0oOXCbUz/2ZdC9WpI1vQdtE+ZJYpJHttfS41JC/7IL
         1U+svRvSsEuHDVCcSQG762kWVzUjbMiMM+vHkjV0l3WjDTuRxhccs0j1Rs6csB14we
         Jo9t3bDa/uIZWlUujHgf5k18ZxnU7wo6COE4mUTAVdKUCZeTuO/uoiU4xDpBz08sY/
         MweNh0vsBHjZx/YUfiNGXqqISDPGg6WrQOe/wH1d4j0h60BL1NyJ+t+uRGlOjaoAVF
         GblRJ0LteA/AokFOYLs7HgItn1k1aFCxwMHqX1QPc5D+u4in9NwlpRlcM6sWUZ7nyS
         JnkBuRutXXvWQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 15/28] iio: adc: stm32-dfsdm: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:41 +0100
Message-Id: <20210509113354.660190-16-jic23@kernel.org>
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
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index bb925a11c8ae..a627af9a825e 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -135,11 +135,9 @@ int stm32_dfsdm_start_dfsdm(struct stm32_dfsdm *dfsdm)
 	int ret;
 
 	if (atomic_inc_return(&priv->n_active_ch) == 1) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(dev);
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
 			goto error_ret;
-		}
 
 		/* select clock source, e.g. 0 for "dfsdm" or 1 for "audio" */
 		clk_src = priv->aclk ? 1 : 0;
-- 
2.31.1

