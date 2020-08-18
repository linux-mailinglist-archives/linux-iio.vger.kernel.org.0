Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058E924903E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRVi0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgHRViP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 17:38:15 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4079C061389
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so19557128wrs.11
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCKkfI4KUgwhE7z/MGIgFuxJr6A36cU9I1dFPpHRlos=;
        b=Te28b6GraM5AAO5E5d9a7pbomPCfaBFiUh1IlgdWQp7iRYae5+R+sV3xKyOn2oDIkV
         odfxpeWDKt1Ai24PpuW+Vvf0tFwI9ePJXbAZUUPJcQ4CzcmcxN7XzzgZDmLrLQAxwYjE
         JLldjyhrcJZXeiaRA67gLVd4z+2AjSQBruM9vzoLITm7SzsXnawRjrIz72s0ovegdXNw
         x7O5PbRwiCWiXBH2AOihqu4w5Dr65r927pDIqLSlrmTJIL2ZgoaxBJzGtmOzKwn91Pth
         uUSKINmo6BsCWKj0/lEi+/bHL05g0JnoO+5C5qhziEBt3qjqqBPCw3yDaBiFb5L02z2C
         SIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCKkfI4KUgwhE7z/MGIgFuxJr6A36cU9I1dFPpHRlos=;
        b=StHbUsRh7CrhBnKp+Drr8rrWagdUDch9ij3Ujtz1tREPqGJtU/q3bY1VDRNmtbhbSW
         FXSYXHPojNtkGFmZOKjsiWKqvGko2hC4uG612PL5z4+lfuCttSYUwHnoE9tJgYB+tpo/
         M1ssVuSVniixq1+vqbO/93R3RRl1249tLV3FHndqguDES0LTxASw4r7JlgADHOXL8CvZ
         lfMVheh7fIW6+BDq8Z50BTKNp4ZAFeSD2+nkVhKJ9/BHgOstZr/GcgzsIj+b4F7snh4t
         ozs0/PuxRhamVcRcpsEhNw8z8f70CRGMwAD+ZibSnMJNSmMsmalFivzB+FQnKyXiRAUm
         zP3w==
X-Gm-Message-State: AOAM532If8ptPCr8f1OUBJST1a3R4rzVaMTUJNwsByZTtWFEbHm6Ywzs
        n3yDlGhwWmKv914qV5vSqThlcg==
X-Google-Smtp-Source: ABdhPJzzLziDaSiiV6C5/msWuEDrAjETq4OW0ouB5eldrg1N+W3o2BnVXNTMG2xvY3VpZFRIcS6cuA==
X-Received: by 2002:a5d:6a4a:: with SMTP id t10mr23083894wrw.360.1597786692207;
        Tue, 18 Aug 2020 14:38:12 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:11 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 2/5] iio:temperature:mlx90632: Add kerneldoc to the internal struct
Date:   Tue, 18 Aug 2020 23:37:34 +0200
Message-Id: <20200818213737.140613-3-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818213737.140613-1-cmo@melexis.com>
References: <20200818213737.140613-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document internal/private struct for mlx90632 device.

Signed-off-by: Crt Mori <cmo@melexis.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/temperature/mlx90632.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index c3de10ba5b1e..ce75f5a3486b 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -89,9 +89,16 @@
 #define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
 #define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
 
+/**
+ * struct mlx90632_data - private data for the MLX90632 device
+ * @client: I2C client of the device
+ * @lock: Internal mutex for multiple reads for single measurement
+ * @regmap: Regmap of the device
+ * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
+ */
 struct mlx90632_data {
 	struct i2c_client *client;
-	struct mutex lock; /* Multiple reads for single measurement */
+	struct mutex lock;
 	struct regmap *regmap;
 	u16 emissivity;
 };
-- 
2.25.1

