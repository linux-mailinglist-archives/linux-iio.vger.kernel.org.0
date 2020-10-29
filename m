Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAC29E4F3
	for <lists+linux-iio@lfdr.de>; Thu, 29 Oct 2020 08:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgJ2HuG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Oct 2020 03:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgJ2Hts (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Oct 2020 03:49:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44658C0613CF;
        Thu, 29 Oct 2020 00:49:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w21so1652732pfc.7;
        Thu, 29 Oct 2020 00:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qcp90+f/8gUugmcEijCiUNWJQTlwDOq2UlIDoO0BJa4=;
        b=XmsZImdRu0jjMLdVacgcIq8eULPMQhyENNOOOmmiOr+QJguVGhjBWIq1BEOmZflCT3
         pVij/myxb+ih4tRgDa7RUotUddvNYgKe1wmTjS5v8C27oXUvYN/J+dqr5Ft6dQBz0YJp
         4bxzhyN2Y8p9dFk95SrqR6WZ6vcMMrxtVpb5GrUxFSiXpuXYJP840PoaTePnPY7Blakw
         ej4nRLFDP+++rYbi5F+o1nElWWuQn8Zz/IHYRKlQ6XiQ0UhGA9gBXJJUogq0q1TpIqj1
         evk/JxgUpCexvGkHbCTJT5jbAjLXsBtwKHWQX9vIhrNmpsNxQ7lorrsGHuvPDg2Qjhkh
         8Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qcp90+f/8gUugmcEijCiUNWJQTlwDOq2UlIDoO0BJa4=;
        b=QosuXMMZaYAzK6kxyD1jA75Pw4WL7QHR7skrCtEUwMEKHslIkoxCSXv4kRv6oeKL0d
         DDzC5LXe6wX4xDU2gUBYowzreVKbm4cwhCP00Cg2F6xH9wlCXybJnmCvmH09HrFpv/LA
         fWsZrOeq+MmHxFZPd6yFiP84EhxLXT41YY8IdqmL6Hyi/nRoCHHcWKtINVCBIfQqASHc
         A/RZLfZ0FXFqyTGKEEjm8212njfCdGsarSWuFShVpUG48nVYc4LlPC+d+Eh6CdLHXLWZ
         cgD7ah3ciyxLFJEIrqZ99nfSVZ46LJDNrM01155z3pFONXjkkUhyd0qzQAZIwdBJHq5c
         D+5A==
X-Gm-Message-State: AOAM532qoKeoWN/cC5pUdJEIbAAaqdr/7PuLOb4XDjtZ/73dtxpmi8hD
        j7uf5nxtmAl8iCxYTr4PFX8=
X-Google-Smtp-Source: ABdhPJzNu6f/h4OyCOlpfOFPG9b/8q8uTzxf3NTXJ+6Wk28OKfVdfiiIuwyJgT/05RZNZlxN9RiWiA==
X-Received: by 2002:aa7:94a4:0:b029:151:d786:d5c2 with SMTP id a4-20020aa794a40000b0290151d786d5c2mr3096886pfl.50.1603957787899;
        Thu, 29 Oct 2020 00:49:47 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id n64sm1882118pfn.134.2020.10.29.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:49:47 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/15] iio: accel: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:48:58 +0800
Message-Id: <20201029074910.227859-3-coiby.xu@gmail.com>
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
 drivers/iio/accel/mma9553.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index c15908faa381..1d2e57158b31 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1197,7 +1197,6 @@ static int mma9553_runtime_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int mma9553_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1223,7 +1222,6 @@ static int mma9553_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops mma9553_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mma9553_suspend, mma9553_resume)
-- 
2.28.0

