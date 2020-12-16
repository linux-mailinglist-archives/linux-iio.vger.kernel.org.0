Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31382DBFF4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 12:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgLPL7X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 06:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLPL7X (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 06:59:23 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB4CC061794
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 03:58:42 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ce23so32313605ejb.8
        for <linux-iio@vger.kernel.org>; Wed, 16 Dec 2020 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jzn8TR0czymy/ecdbj2AZeWCxKR0EeY46LKLUOJRwt0=;
        b=hBt6X1lW1HfTGeWsKDpxfOmh7J4NSpgdzO97V43vx55K8TqUdJal7vBe41QqXBUTIB
         lRicH8/80f5fOmU3D1eGdSOfPf0zzPcn3dAdSGmAmn15SywMezFWDVDgP0LIjY9/Nvwo
         W9iVDJvUxZhbyh59q6hnR/aj6VYTrCs4TW9T77+s1Y4043S4C4vlMI2PZVw7zFbQJ3si
         nZ0vkEWaDfWECp4ozCoCVkTpYQDssu6sovMY6Rf2LddjrnB67WDuseZXdgaWbQsXRwp1
         C33eAJDx7JNdLfQMtttFmC1J0UcU4RYoCBbfRrFG0CoeyihNBSLJJ/3wmchdxTCRlnZt
         H3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jzn8TR0czymy/ecdbj2AZeWCxKR0EeY46LKLUOJRwt0=;
        b=DKUQn5GJmbvHSYX+k9BB/VVqGU6SZmSpQFz9tHe2NAVonTMkCh8bxn8IclQJ332bVA
         FP/dPkT1MpUp9a6/ubD6DNj9R1BG1nDTaNY6UHA07cRImTcD6KocPaIgVOlhUn/56J5n
         nYG+maNrjji+SJxe52yYknbHl2aqX042WBqjehTqJT5ptJUn8x+IQ/P8AirUhoeLhH/J
         1dUyh44n/nw+PdJWdLVprU5eF35/6iKWgUesTAonl6XwkUmR51zp9SB5pjYq9+hNMmuR
         BGDqkPtLdfEyl+ot6HCBE7UNPB9SpzsF8aE2c0ZvqgoCdVkgtIgZmUiNfy+4MJ72Aohk
         /xQA==
X-Gm-Message-State: AOAM533SV7qF1BX6Hs7NLbp7PVtML3dBqXmYolU2XdcUu0qlQ2odwpqV
        Qgl7Vl1Wni3p19QEwds+miNnHA==
X-Google-Smtp-Source: ABdhPJxPixJ0W4WanDG5uheAKaiAmHidjC7F1v3ymmUcGYKoYb5AVBSTT0XghGR8NcS1gW788qG2bA==
X-Received: by 2002:a17:906:b309:: with SMTP id n9mr8239350ejz.365.1608119921514;
        Wed, 16 Dec 2020 03:58:41 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id ga11sm1239316ejb.34.2020.12.16.03.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 03:58:40 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v5 1/1] drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c
Date:   Wed, 16 Dec 2020 13:57:20 +0200
Message-Id: <20201216115720.12404-2-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20201216115720.12404-1-sis@melexis.com>
References: <20201216115720.12404-1-sis@melexis.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After an I2C reset command, the mlx90632 needs some time before
responding to other I2C commands. Without that delay, there is a chance
that the I2C command(s) after the reset will not be accepted.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Crt Mori <cmo@melexis.com>
Signed-off-by: Slaveyko Slaveykov <sis@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 503fe54a0bb9..608ccb1d8bc8 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -248,6 +248,12 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * Give the mlx90632 some time to reset properly before sending a new I2C command
+	 * if this is not done, the following I2C command(s) will not be accepted.
+	 */
+	usleep_range(150, 200);
+
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
 				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
-- 
2.16.2.windows.1

