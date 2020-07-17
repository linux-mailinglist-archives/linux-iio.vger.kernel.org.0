Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF552240F0
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jul 2020 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGQQ4Y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jul 2020 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgGQQ4W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jul 2020 12:56:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DE6C0619D3
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so11908235wrw.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2020 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rHQ/jO1LhjZqNtelCIEh1tkpMHr7F5JhR3YsKGdMJak=;
        b=gax7WoquXCNWbtQ32PKWdu+p6CINIYPJ64653qBVA7k6sICf8rlMQTpk2nd/sPyRKW
         LzPBfRVamHkdO/sf1vEGjrOjSxv++JfIprn9Igv21SDOyw2b73cXNm/p13aUAO4bPVeG
         WIT5jOcosEKJUAYL0iK5CZDiwYlIKtNdEhpYpzmJXMMaybPSuowQUpX1UDiOOU0fVhXZ
         T0L2WJ7tvFvMmBIaiRVmwnMn2Zq7b7PNO6Ho3bca5LjWdsG0ksj+Wal/Mcu7eJyB4RsF
         6sPolkV1LjvVteKTcBo+aU3tvd18BW7yUcfWp8dJDRcQDrBMvIJnSS6v4mihpd5MjcZI
         cpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rHQ/jO1LhjZqNtelCIEh1tkpMHr7F5JhR3YsKGdMJak=;
        b=FolUd6/ThsSM0kDi4j695meFt3qlAxBLpBkegRiVMHbYfuCl/KWE4+8PuskAe5ul33
         cspyv2IBd529Jl8jGsfisuOgtEO6eZ8nbsO3vz7uxzV8u+xnZKMd5weQQVD6qgrMB5ML
         rsdPgTGEzcljpaOQWe7nTXqCw8rQ3xgQ87F10L280qCzLG/2UGf++5fcIstwHEnQxox3
         eCAeJn5/VH/Rn9AiS9fVHM1kMk1o54LyapJ3u14lDpdy+fcwxrxMd6TXorVyAjs+0+y4
         043mM0Fa5/Yrxc/aT7YSk5SqTDqf5njcpvSG6G6nwHAba0FXMkSMSVHy1tZHRZLhA1Po
         SooA==
X-Gm-Message-State: AOAM531f5USKNxzxT57me5txUIfLLe59pzMW6cZJ+WqtMM19hvmZMy1X
        GU7U4mv5bQlGnYOyP6tQj6Bz2A==
X-Google-Smtp-Source: ABdhPJwoHoY99/X6VnON+9Fq/TFQG3iB3igVuAL6ttNu5GBSpTuN7C9MiiUk2XrtnDU7l2HXLI8KqQ==
X-Received: by 2002:adf:efca:: with SMTP id i10mr3678182wrp.278.1595004981099;
        Fri, 17 Jul 2020 09:56:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rohit Sarkar <rohitsarkar5398@gmail.com>
Subject: [PATCH 20/30] iio: adc: max1363: Fix kerneldoc attribute formatting for 'lock'
Date:   Fri, 17 Jul 2020 17:55:28 +0100
Message-Id: <20200717165538.3275050-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/max1363.c:190: warning: Function parameter or member 'lock' not described in 'max1363_state'

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rohit Sarkar <rohitsarkar5398@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/max1363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9d92017c79b2d..0fe348a47fe01 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -150,7 +150,7 @@ struct max1363_chip_info {
  * @current_mode:	the scan mode of this chip
  * @requestedmask:	a valid requested set of channels
  * @reg:		supply regulator
- * @lock		lock to ensure state is consistent
+ * @lock:		lock to ensure state is consistent
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
  * @mask_high:		bitmask for enabled high thresholds
-- 
2.25.1

