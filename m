Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD32DA1E4
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 21:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503007AbgLNUoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 15:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502980AbgLNUoZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 15:44:25 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D557C0613D6
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 12:43:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id q18so10243261wrn.1
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 12:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bQZHbKflKHTQzaJUd/yUdxU0tIAIgvBQ9RKJ7wgBeU=;
        b=b63gxVLHPQnn9I1aRIU0RnGGbpTgzGxv50I/JUrsEvPVTPGFbGNX99HXqWgBFswz9O
         i+zde36f0fBLswEVwvtRHVD+sNjAy5yTUg7vIQvOp64fRs3xGrtYQfgnohCWoGvSXT1o
         riBPOWbvI6/Beov8jpIE1bBRBnjwXbfVw94kAa7p2yEZJv+rd1A4EejP4m1QN0+6NTEX
         aGnYCY+jPGnAJiUmQZpy1ZWDRRMqVFjaraALxsBkgGJXUJ3fOXGdIrv+FScEgFU8Qo4b
         R8yQd5W4YIatF8x7qJNXG/AtxAjnt2loxGU3vhw/wePdSDgsPVh5VX4+5hCjkVFNWcYE
         XZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bQZHbKflKHTQzaJUd/yUdxU0tIAIgvBQ9RKJ7wgBeU=;
        b=AXJN3B/B/6bvy2gUlIvqDzaHG591TwzfpjOOQgmsPEAaCxv74UfgStjeEXNLPqbG7y
         Kt/dnU3+2p5DBJVmPbst2XjFL6a+lH/19dy5vkD6PD12XYI49rxhEzP0aD1N/Rupuo/G
         /0G4SQs+ET4QG959MXBTMSaSNb3R8XPnhQa0XdX41zyPMV3vv4baQrGpYzcOcYbwmm5A
         E8U5FUw2DFgAu1l2JEM8jkioBLoiDl3rp+L34eXvKG5GVRysVN8ok8trx/TQVJXn5Udx
         bF1M/yel3UUz2NBQ4viKehjPYVD+n+rdged+rIJfVGzFXnc5TtkytmdUOosAmNmDkLkY
         w2aQ==
X-Gm-Message-State: AOAM532TtsalBRYDF9H5EPeejGtlpdJ6R0HMPrA09sr/S0DCuqmFl3Jw
        pLxlPbltlePo9i2StPgKL5/XIA==
X-Google-Smtp-Source: ABdhPJwI7uLjUe9yzyT7p1IGv+OXYu6zGvMSI3DzViEe4Rh7Vp1DPFxusV5+BvtNQl080MAv4O1J3A==
X-Received: by 2002:adf:8185:: with SMTP id 5mr29930014wra.44.1607978623921;
        Mon, 14 Dec 2020 12:43:43 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id c129sm32833123wma.31.2020.12.14.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 12:43:43 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v3 1/1] drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c
Date:   Mon, 14 Dec 2020 22:42:41 +0200
Message-Id: <20201214204241.12308-2-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20201214204241.12308-1-sis@melexis.com>
References: <20201214204241.12308-1-sis@melexis.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After an I2C reset command, the mlx90632 needs some time before
responding to other I2C commands. Without that delay, there is a chance
that the I2C command(s) after the reset will not be accepted

Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 503fe54a0bb9..872092c2fc61 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -248,6 +248,12 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	if (ret < 0)
 		return ret;
 
+/**
+ * give the mlx90632 some time to reset properly before sending a new I2C command
+ * if this is not done, the following I2C command(s) will not be accepted
+ */
+	usleep(150, 200);
+
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
 				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
-- 
2.16.2.windows.1

