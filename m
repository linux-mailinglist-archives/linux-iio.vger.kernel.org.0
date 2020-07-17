Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938302240E3
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGQQ4L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgGQQ4K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:10 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2039C0619D2
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so7563406wmc.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaAEngpMWZcocEAV7ao9KvOaMLVn8ta5ctXWHocndM4=;
        b=ZJrx999gJcsSLac1AZ9jE6z8jV20FHjvtuuZDeNZG7HmMiRiV1M2DywOLcnLAFsliW
         fG+mlXYbAxvnbjjZkWjHuF9BYWR/7wF3kKCap0LZMvllWDGAhHjxxvxOQKqYEr+llUqA
         NGjfzKwMotju6ppU4nTnZ0p+f8xe6VW8fbuxm+mu0xl9f6Y6LXu2vNQ5CnT2vFx49svh
         vUd1XaBFV/TrXYr+xcMOpmBojGd8ANfmaU/xCxHv9xNfL+9mlNYne7VyXjDAYOWM1sI6
         ZG5W9UHH+n2yJf3nXLdLpAC6rmDWlUr25+GdyIS40DPqFWAP68ByyY2LCuBjhNWmyPk1
         0V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aaAEngpMWZcocEAV7ao9KvOaMLVn8ta5ctXWHocndM4=;
        b=oB0BdGbvyPLo0pp9qk6pwnUx7h31k4TioPnHzL2wTnx5MBd+xCJWioECmPzwvQ4Bw9
         ArrMZWmCekQ2DCZ5bfChaQZg6sOUQk05JIFkknwsX8YpLD2alx75TajWpKcdtUCzoEkM
         tP77lxyLgNstOlKsfHV7+Pbe2ZA+yctD+XWhpBCyvYMPJFfM3/BPobbjlm1sEPECyfdC
         PDiTNCV19SWbhebMPfEqSOThb0wrcG8MguXkwpDQYPlky3S2nGn8weaTYmFjoR0e9MAf
         4VAwvhfnGPfBOLoUb+OR5aA3XB+dVZcpTuucCpxHi4bWqP5MiyJep/4GYWaQgDon+Qbl
         D1sw==
X-Gm-Message-State: AOAM530OsJSdVh/L7omYCvptfs4gSbxffsbYiB5ETcRaM9PizlulQ/qT
        DRJQ3ymd4YgCZLQZQDW7R3rb5g==
X-Google-Smtp-Source: ABdhPJwurLCgsUKBH4m6dcESQTptlhoR0rEHbjcOfc+k2e9gB4ZDfT9hTuuRh6BlyqKKP1waMkjOXA==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr9877767wmi.94.1595004968669;
        Fri, 17 Jul 2020 09:56:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 09/30] iio: temperature: mlx90632: Function parameter descriptions must match exactly
Date:   Fri, 17 Jul 2020 17:55:17 +0100
Message-Id: <20200717165538.3275050-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

'*'s are not welcome in kerneldoc parameter names.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/temperature/mlx90632.c:175: warning: Function parameter or member 'data' not described in 'mlx90632_perform_measurement'

Cc: Crt Mori <cmo@melexis.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/temperature/mlx90632.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index eaca6ba068646..b9a8089be3f63 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -164,8 +164,8 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
 }
 
 /**
- * mlx90632_perform_measurement - Trigger and retrieve current measurement cycle
- * @*data: pointer to mlx90632_data object containing regmap information
+ * mlx90632_perform_measurement() - Trigger and retrieve current measurement cycle
+ * @data: pointer to mlx90632_data object containing regmap information
  *
  * Perform a measurement and return latest measurement cycle position reported
  * by sensor. This is a blocking function for 500ms, as that is default sensor
-- 
2.25.1

