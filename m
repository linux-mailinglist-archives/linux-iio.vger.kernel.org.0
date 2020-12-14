Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDDC2DA30B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Dec 2020 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440111AbgLNWLO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Dec 2020 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439147AbgLNWFv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Dec 2020 17:05:51 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B42C0613D3
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 14:05:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id y17so17909947wrr.10
        for <linux-iio@vger.kernel.org>; Mon, 14 Dec 2020 14:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pajgT+cCEU9TrF1fXLIGD0wRsyk3IyF9VopN2P5t67o=;
        b=Wv6MfygIdz15VPC7rjMO7OvMuffcJGLdRLrI6yok+sV30+k0zFWAlZy2dhDsyzUTce
         C4K9gvLfRw93RerRBZufvSj23yuwhEOJrTmgGvqsUayrrCu0cr/XP4/dPzbDtP6L9Jv4
         idDCdjPary6Yn4QUC5lEXtXo09xs9hYf3148Z7CMGfg6IIdt5uKT4DcZpu7GleL6X0mJ
         Na/sjlePDS5maHAbxnXrs3uyH6RVKqs6T54zfLVBKARoQTAJUP31/FAIWB/CYLKubGKG
         hu5Sbh0h1nV4nq1sz7eQdyAvWlqaSxea/YOfP8LvYl1sN91cxh4Hc+uhuwl0kpWHBPNM
         E7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pajgT+cCEU9TrF1fXLIGD0wRsyk3IyF9VopN2P5t67o=;
        b=LXFweoQ3Q7ZmY5unKN6YiLIRLAj2mBxVjKNFYA7mbkHpaRQ+kUs3c4P9d0Cu9IBdtu
         n/yUdVjUnifWb9/NxFGjk8dpbWxYlztZRKHvquGWvG1JsxGE/kkMrQw20VIdQ3aD7vi1
         vZY4y9g+YBkKZp7ciPG3A+p6VeY/wq0lRU/v0kRCG9fIhsBSu/K34WlYQRiNqAXyvWQE
         rHHP2I7+2nlYfTAVi0rqjU0sIAhWu5U/satxqDTzxXM+Uj2h6bqetuS1E5NfKSsgUupC
         zVRKlldIHheKb2o9ZyxVRqZg5BprhgYvPnG1S/nZnGZ5xL5gHpxIbl8XtF588f9vKUXa
         rgwg==
X-Gm-Message-State: AOAM5322y68hfAXrN/XfLmZP6ptupzAS42QS7v+4q0UwTb3WvHCXQ22W
        6DJuxPXBB0m320S9MEqdiPIfYA==
X-Google-Smtp-Source: ABdhPJz/AwRJcwplDuRtmo6kJ9Z5pZeoLx4VuFz/ucRWOs88Ht5+uqUTzKM1mFgnbomWOxJp0SbYdg==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr31521841wrn.122.1607983509792;
        Mon, 14 Dec 2020 14:05:09 -0800 (PST)
Received: from localhost (91-139-165-243.sf.ddns.bulsat.com. [91.139.165.243])
        by smtp.gmail.com with ESMTPSA id u10sm31546676wmd.43.2020.12.14.14.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:05:09 -0800 (PST)
From:   Slaveyko Slaveykov <sis@melexis.com>
To:     Jonathan.Cameron@huawei.com, cmo@melexis.com
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Slaveyko Slaveykov <sis@melexis.com>
Subject: [PATCH v4 1/1] drivers: iio: temperature: Add delay after the addressed reset command in mlx90632.c
Date:   Tue, 15 Dec 2020 00:04:12 +0200
Message-Id: <20201214220412.13224-2-sis@melexis.com>
X-Mailer: git-send-email 2.16.2.windows.1
In-Reply-To: <20201214220412.13224-1-sis@melexis.com>
References: <20201214220412.13224-1-sis@melexis.com>
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
index 503fe54a0bb9..474e6cd5b534 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -248,6 +248,12 @@ static int mlx90632_set_meas_type(struct regmap *regmap, u8 type)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * give the mlx90632 some time to reset properly before sending a new I2C command
+	 * if this is not done, the following I2C command(s) will not be accepted
+	 */
+	usleep_range(150, 200);
+
 	ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
 				 (MLX90632_CFG_MTYP_MASK | MLX90632_CFG_PWR_MASK),
 				 (MLX90632_MTYP_STATUS(type) | MLX90632_PWR_STATUS_HALT));
-- 
2.16.2.windows.1

