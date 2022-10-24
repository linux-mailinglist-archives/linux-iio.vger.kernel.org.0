Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF460AF6F
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJXPtj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiJXPtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 11:49:21 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6FD2A968;
        Mon, 24 Oct 2022 07:42:55 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id a13so32180194edj.0;
        Mon, 24 Oct 2022 07:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYDe+pPSD0vc7fcU9WurDQ2z2Lc918aKtSIZ7Rn8KXw=;
        b=iPiLBv6575MeL9d+q2zZB1Oe/sGJ3rPuJQad8fELE0DVeDXDgIzRyDMC+CoStYEpy8
         z/mDAR2Vec+1BPqOaKUGtIo2GMVhyltj5zjo6E/Wo63C5qIHPhAPTEtv6nbmX74dv6II
         SkcTuoZkhvNOL33U2CxQEE77hIqv1e/kilbGi1Kd6ewYtipek8gH8v4+WgVwniEYXDlh
         ZTXgywMN8Nq58NbrFlNdZFKVRSSRGBZ//MQ4B42j34z9Km3PrHq9uRr2b7L4dwu0T/pr
         o/pk0YWkH9MgqJJWqMlQ8z/2/D3FQkyDDXZCHt11i+3dB09hhmP9DrRyxCdyrHTOR+5C
         PpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYDe+pPSD0vc7fcU9WurDQ2z2Lc918aKtSIZ7Rn8KXw=;
        b=OyHuSlbW0TuNGIBUlLuvMgwZaAA/iofhlJX+jX+NSbJro0h+UzSzGmYRSyKIQ5mj7o
         Jbikht8l4KzjSEFp1f3JF++/Ok73YcctNNyBdnfvyLfcmDVvi3I31A8/PWY5dw8XwzJb
         QaSUSHb0ntoby5h6VUFRW/3IwNPxl1MkxuEPZFUk5u3A1PqrUvj1xtUGIzmL2N2O4Yuy
         CocJfGdK/MtTJSfJghEEvDNpqu8ZwUGo67ag7L2q/tTLtPMMW66oRfiXZus4E3Lp5CZd
         INaNr7TVgA1v7tTalIG8wkha0NEXfH/yrPKdFZ125JbVJzJN580+bJSOYPiDTQ7w3pNT
         +gCw==
X-Gm-Message-State: ACrzQf14j4B/lxxcPY4+TrD8I2FsijgPIntI4NeRwaYGWsNAT6NJuso7
        CkfdwZ4t0Bmtl2vzfj5m4bkh3PJrRQ8=
X-Google-Smtp-Source: AMsMyM7rW8i8eCkcbfpOCp3IRqDyjVQj3PEdLDUFEk4WffYh+K+tRiFC1TX13LHlUYZPJ9uASUMg5w==
X-Received: by 2002:a17:906:65c6:b0:73c:8897:65b0 with SMTP id z6-20020a17090665c600b0073c889765b0mr27950016ejn.322.1666618087180;
        Mon, 24 Oct 2022 06:28:07 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:06 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 6/8] power: supply: fix failed to get iio channel by device name
Date:   Mon, 24 Oct 2022 15:27:55 +0200
Message-Id: <20221024132757.3345400-7-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221024132757.3345400-1-sravanhome@gmail.com>
References: <20221024132757.3345400-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The mfd cell devices name populated on sysfs entry is dynamically derived
from an auto instance which introduced a regression. As a result
mpc2629_charger driver failed to get adc channel because of iio consumer
name mismatch with the sysfs.

/sys/class/i2c-adapter/i2c-1/mp2629_adc.0.auto/
/sys/class/i2c-adapter/i2c-1/mp2629_charger.1.auto/

Fixes: 466a62d7642f(mfd: core: Make a best effort attempt to match devices)
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/mfd/mp2629.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index f59c97e70f83..57db0f5009b9 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -53,7 +53,7 @@ static int mp2629_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, mp2629_cell,
+	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629_cell,
 				   ARRAY_SIZE(mp2629_cell), NULL, 0, NULL);
 	if (ret)
 		dev_err(ddata->dev, "Failed to register sub-devices %d\n", ret);
-- 
2.32.0

