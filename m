Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7387243581
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbgHMHxd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 03:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgHMHxc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 03:53:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F0C061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i6so3482036edy.5
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTU5cFHGkO34IlxC63OEHwEFnYr2XsRlWX055O1ML3A=;
        b=pUCeAa+pMf2zrP+puNTGip5yqwy6FR55xLkRihZlhdM26SfdUxkLfpBsoO3bfGcojD
         TBHwAvFadEyNgQRTvG6wWPAHZdiuvKDOcvpFmvXMwLDw19FsJL43sIrcsEKOC0XIOsrD
         vB0OZJt0+HcnBWL9StpSd0pSjzNZEkrKToRfjam0+hicG6ziTu5b79W6PLfwHuXUJEo2
         qcn8WNBHrQ1Wfd6Acwnriqq4ypSE9A/dtgXqnoSXRlpGMryLv/ZnPFpjV7mAtVZzI0PS
         dr7ZgiwLGedQ45gJj8c0C3+buyj5C17NFFulAJ/OmVp9FdR+q4xkZEEjexiG2vPRcL5Z
         wPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTU5cFHGkO34IlxC63OEHwEFnYr2XsRlWX055O1ML3A=;
        b=swzrxnH91xK9JDCk/EhEIPc0+WBxiavK6ZXvnJ6Mq8UqGe9rbARhtdocXHi5g7csdk
         NLiMNM7lrplCKlD0uJlESgMJpX9ru3Nva25wXrrvzDDwB46DVNdqowMf62MWic/lm7mB
         o/cTHHiAMSRsLHkIa+eKk8nYFWvVy3zdF89AleECR2UaMMgBi5+sOyWfGJhpbY4kGBwD
         pVkDiZJ+/Fo+WOP+prxfwwfeVJkBUVbTz33f6HY9c+kg+o59PM0O90MZXsBdRVj6Ak0L
         GvlJ2p6j6bjIPy8vuLNQ8SGrY+ciHLGOSlRoZD//r2ZxWzxNgvYDJXN83S5VzGSDaOgc
         /HvA==
X-Gm-Message-State: AOAM5313zTTxtGXIlXL9vcyJd4fuIZ0EFW7fJE8W3oKIwnx6s7K9RSWZ
        DEtNHgBj3v89FbecfgROGnbgUg==
X-Google-Smtp-Source: ABdhPJxXWIDrNeLHL1LuKgL0WLgw+b0q5u6c7ANOaAdCs20RPppz1P+nds9KU+hCnBjzuAVhjqVAeg==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr3607140edb.6.1597305210681;
        Thu, 13 Aug 2020 00:53:30 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgyw9mz6ybkfgzn4.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:8d0a:592c:7d6d:8770])
        by smtp.gmail.com with ESMTPSA id br25sm3363449ejb.25.2020.08.13.00.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:53:30 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 3/5] iio:temperature:mlx90632: Convert polling while loop to do-while
Date:   Thu, 13 Aug 2020 09:51:23 +0200
Message-Id: <20200813075125.4949-4-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813075125.4949-1-cmo@melexis.com>
References: <20200813075125.4949-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reduce number of lines and improve readability to convert polling while
loops to do-while. The iopoll.h interface was not used, because we
require more than 20ms timeout, because time for sensor to perform a
measurement is around 10ms and it needs to perform measurements for each
channel (which currently is 3).

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index ce75f5a3486b..d87c792b7e72 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -188,15 +188,13 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
 	if (ret < 0)
 		return ret;
 
-	while (tries-- > 0) {
+	do {
 		ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
 				  &reg_status);
 		if (ret < 0)
 			return ret;
-		if (reg_status & MLX90632_STAT_DATA_RDY)
-			break;
 		usleep_range(10000, 11000);
-	}
+	} while (!(reg_status & MLX90632_STAT_DATA_RDY) && tries--);
 
 	if (tries < 0) {
 		dev_err(&data->client->dev, "data not ready");
-- 
2.25.1

