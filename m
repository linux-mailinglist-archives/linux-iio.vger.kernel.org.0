Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C8123F77F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Aug 2020 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHHMMh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Aug 2020 08:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgHHMLP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2020 08:11:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEDEC061A30
        for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2020 05:11:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so4755164eje.7
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2020 05:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XWY4gvQRYHXEyWmE4WsXwZ1nN+0si4ZlbIfngpHZ5M=;
        b=awV+k81WnzaxYEO9gsxcGspjzXsyKu03ExAJEbK9V/ZL3FfU2Nj1gdRph/ixyi65Rk
         jfIun1AY/HiBnDJVnRqedB1bV3fPirB79TaRcxNKY3r2qYkKLb7wKha8Z60S1Tk/lK+5
         kStUyHD0H6iu1uI8qwM2RnoBj8EKttgGc8k8SIU4oz2n2gCYjNyd6+eEa9fYVy3NB7Yf
         j52xN1L+DnnztgzcDWAhlIJyBpP/kgiHA3oxcInwJ7MO7/jcMwU0xq0RCimqrThsLQYj
         qyxavCKanOWsEAKpByVVRmc+FtDiy65xRcKihp1//lvK25CauS8V3W/vWiQL+++aLMMU
         hMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XWY4gvQRYHXEyWmE4WsXwZ1nN+0si4ZlbIfngpHZ5M=;
        b=tAlC1rEfVhfPoiw3LXi2jNVO2SiNFT+NivO0LdlKcFoWpCvTN7UWAg+jID8kfPuz8T
         aahl3rF4i450ttL1YingxsZcXkUa0aj6Uc2CyF3ujLabLdEFojbtilUjQYqa2DcmyR+8
         3g+H/aPn/1VMWUK3yx13ZffG2eIEUu2Lz2q90denAgkJu4KZitQFc6Xb2gIiDsx6ejqz
         D6d748p63Yv/wunfZt7+H3qaJMbbmxcZq5kNGibyDHNowCTD/Bu+OuEw1d+hQuXf9vKL
         fl7t+A81XBDYo1i8+d6FeEhcZBkV723fOggIoiCxipdn5ELf+KphtiIY2tshYr/DEFsv
         JBDQ==
X-Gm-Message-State: AOAM5326S/Nn6DGvMx5MBMhSTLrHpHQEC2SsiNeZoH1zX4ByQIDfUZki
        5g5qBqaptK80yQ+7ZijhkG5fxQ==
X-Google-Smtp-Source: ABdhPJxQzvJnqokhx97YNGfRwinM7IAeYCnLYiHfVMfvK3qytGjU16LoWecSxOgwsXIzu1cScWZ/LA==
X-Received: by 2002:a17:906:f905:: with SMTP id lc5mr13207897ejb.340.1596888665305;
        Sat, 08 Aug 2020 05:11:05 -0700 (PDT)
Received: from localhost.localdomain (ptr-4xajgywt9p1tstfsdfc.18120a2.ip6.access.telenet.be. [2a02:1810:a421:dd00:b0e6:1cd9:30c1:35f8])
        by smtp.gmail.com with ESMTPSA id b2sm8130833ejg.70.2020.08.08.05.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:11:04 -0700 (PDT)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 4/4] iio:temperature:mlx90632: Convert polling while loops to do-while
Date:   Sat,  8 Aug 2020 14:10:26 +0200
Message-Id: <20200808121026.1300375-5-cmo@melexis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808121026.1300375-1-cmo@melexis.com>
References: <20200808121026.1300375-1-cmo@melexis.com>
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
 drivers/iio/temperature/mlx90632.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 4e0131705c11..24ffcce9ad74 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -214,15 +214,13 @@ static int mlx90632_perform_measurement(struct mlx90632_data *data)
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
@@ -419,7 +417,7 @@ static int mlx90632_read_object_raw_extended(struct regmap *regmap, s16 *object_
 static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *object_new_raw,
 					      s16 *ambient_new_raw, s16 *ambient_old_raw)
 {
-	int tries = 4;
+	int tries = 5;
 	int ret;
 
 	mutex_lock(&data->lock);
@@ -427,14 +425,13 @@ static int mlx90632_read_all_channel_extended(struct mlx90632_data *data, s16 *o
 	if (ret < 0)
 		goto read_unlock;
 
-	while (tries-- > 0) {
+	do {
 		ret = mlx90632_perform_measurement(data);
 		if (ret < 0)
 			goto read_unlock;
 
-		if (ret == 19)
-			break;
-	}
+	} while ((ret != 19) && tries--);
+
 	if (tries < 0) {
 		ret = -ETIMEDOUT;
 		goto read_unlock;
-- 
2.25.1

