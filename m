Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B2B29E508
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgJ2Hus (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbgJ2Hur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:50:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11FCC0613CF;
        Thu, 29 Oct 2020 00:50:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1646566pfa.9;
        Thu, 29 Oct 2020 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NOzNlbNOltOtdR1QdriCPf2XH+HcyRFu5e424v+5S24=;
        b=K6/mzp9+iSfR1F0KLrjqgFqtGBgGu5Qsyh9lrv3lpj51Z3FiXtcnICok7kdsijfIJ3
         0oLxGapPR3OtbP/2I4cWFTW2mESkcLLGuP24RealKcYZJeZIQJYzniqNa69DaEsg5fh/
         ll71+R5b2Ag8xdbm/UYVEY4Et5kfQ5lpqhb93x4kjPRXWMBJ20bdYEyPklacx3G5kGod
         I/jpxhGvKPKF4uIdkaTPVZa7QwAUbVSxGMkThEYK+WDi8MPeDO3zVmVcbHppfXO6Whn2
         YQPIZKzDe60sCedqDCnbzWt7QBHkiHmQdC+TTTEPpKs120vc1/j2qC4Cgbilim1V2KZm
         QPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOzNlbNOltOtdR1QdriCPf2XH+HcyRFu5e424v+5S24=;
        b=poJp9o35/lcP8Z+VBTrGx8bESgMf6JMa2rMOtOrE6hYlzCIvxbIna1foiNqHrg4gb7
         vTHrllffRi6ZMtHn6FuevkqfSeYuwAP/62wvYs7cPEU0VWfchDIgBP20IeNnq+5KiVw0
         2yuigMWINrr57f+SqspPnuCF875wjT/coOzIT+aWNP2il1qHCodQpPe75fZNXJehpYQo
         BANMUTipHbZwTCmvmVcGWIynvmEyTgEv1TcV2HivOQ2lN0q7TYDfzO7wJHS/vPW0SW/h
         7aizan6ZxOivq3RWx/cdazSIpqcERH5KlVV965DHQ2gQN/lGyqfVjGKJV8whGMdzA5A9
         j1BA==
X-Gm-Message-State: AOAM53196DCZs2nnKbCfWxxc41mx7fT1tn98hwU5jzk48u5A7CR+uQAk
        JM6RYBzFH7GhMpU7DiXObHI=
X-Google-Smtp-Source: ABdhPJy+HK/XXBsjKtniKutr4zdsu++EX8yBXcfuVK/U0htYUR+tkyhpMk6KZpbyMeKtccqlWH/5xw==
X-Received: by 2002:a17:90a:4e83:: with SMTP id o3mr3025792pjh.164.1603957846646;
        Thu, 29 Oct 2020 00:50:46 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id s6sm1631225pgo.8.2020.10.29.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:50:46 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/15] iio: ssp: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:49:02 +0800
Message-Id: <20201029074910.227859-7-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074910.227859-1-coiby.xu@gmail.com>
References: <20201029074910.227859-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee87100038..e284ff702280 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -612,7 +612,6 @@ static int ssp_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ssp_suspend(struct device *dev)
 {
 	int ret;
@@ -661,7 +660,6 @@ static int ssp_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops ssp_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
-- 
2.28.0

