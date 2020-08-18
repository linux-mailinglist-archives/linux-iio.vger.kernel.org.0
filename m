Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22624903D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 23:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHRViZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 17:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgHRViQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2020 17:38:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB7C061344
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 3so281571wmi.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2020 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkVI01i3TLrSdzKf7VYHhdEqSltEGddTXnsWOh1/YsM=;
        b=kzHVtPt8wp9IvYy2NsG64JKyRoeMhnQnWw85I3YKjzRSCv6mgX0LH3CfjOgiyDy1Rt
         jiqCP81k0b4FIp3mr8ZL4u83pWoMjn8PW4CzWPVz2GXk/IORCQ9k7s7hLT+efg4xxnoL
         Nmwp/zanRQXQwz1sKT14w4hshTFcQGQXsuEDuqX7fREYtQ3OeP1e1dW2j05zJbBKtizp
         AdRAn3okhMJx4YSg4zDT6OKIzhaZv0bGsTIjPg/apb4UE2vVSjnruRxTB/e2wUiuHCLW
         AvKlYc6yRqtPYBS00BqBkfix/gJU7qYBCo3LH92y208jrSsTTOqmcjdcZ9/bnzrRfwaV
         T3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkVI01i3TLrSdzKf7VYHhdEqSltEGddTXnsWOh1/YsM=;
        b=dcLENczGIuyR/Fs0UHzR8ik9T0rqfUhGn+CkX+QEuZxB+imf+2sq0+bh8PkhTucbrw
         2H5YNBFF/g64Vk6DPrfkuIIsOpA2+bcC4rse3s9blF6KnKSM30a80ofma1xmp/NsE+yn
         DaswWDGHv/m7jmGnBo0waYlKipApEuUdhrKW8/UdgJpZpnXhcCy31kqQUlk4o12ZDsFl
         KJBdyu3X7Ls/hSjVsUuKVzqsY41hKQXqqF4UHfORqzFfVHGQfn42ui/9a72H78lLmB84
         h7btRNEzqHpjiUF5xp9tcLqkbD6nTK2kkQHFVAGyfLBM4InkNMyPiPbwZ1k1A+y5UG/V
         pLwA==
X-Gm-Message-State: AOAM532CLa1gwoFNN5DR7FPL8X201Vw1XnPSEB5E0u0IPDuqcPo5/S7Y
        uWzl49zpRqka5N+gLkx4RSuNOIsY/k0CQyFgygQ=
X-Google-Smtp-Source: ABdhPJx4EC1L4toYDnBar1k9GU/hYpSFfkJ9zKqSzKre3qXIAEhjZNwhivgC93vIWCtrIUABE3vcqw==
X-Received: by 2002:a1c:8195:: with SMTP id c143mr1767857wmd.85.1597786693841;
        Tue, 18 Aug 2020 14:38:13 -0700 (PDT)
Received: from localhost.localdomain ([88.116.83.106])
        by smtp.gmail.com with ESMTPSA id z207sm1797860wmc.2.2020.08.18.14.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 14:38:12 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v6 3/5] iio:temperature:mlx90632: Convert polling while loop to regmap
Date:   Tue, 18 Aug 2020 23:37:35 +0200
Message-Id: <20200818213737.140613-4-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200818213737.140613-1-cmo@melexis.com>
References: <20200818213737.140613-1-cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reduce number of lines and improve readability to convert polling while
loops to regmap_read_poll_timeout.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index ce75f5a3486b..d782634c107f 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -180,25 +180,19 @@ static s32 mlx90632_pwr_continuous(struct regmap *regmap)
  */
 static int mlx90632_perform_measurement(struct mlx90632_data *data)
 {
-	int ret, tries = 100;
 	unsigned int reg_status;
+	int ret;
 
 	ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
 				 MLX90632_STAT_DATA_RDY, 0);
 	if (ret < 0)
 		return ret;
 
-	while (tries-- > 0) {
-		ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
-				  &reg_status);
-		if (ret < 0)
-			return ret;
-		if (reg_status & MLX90632_STAT_DATA_RDY)
-			break;
-		usleep_range(10000, 11000);
-	}
+	ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS, reg_status,
+				       !(reg_status & MLX90632_STAT_DATA_RDY), 10000,
+				       100 * 10000);
 
-	if (tries < 0) {
+	if (ret < 0) {
 		dev_err(&data->client->dev, "data not ready");
 		return -ETIMEDOUT;
 	}
-- 
2.25.1

