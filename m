Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA36367B7
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiKWRyp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 12:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237461AbiKWRyo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 12:54:44 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A465861743;
        Wed, 23 Nov 2022 09:54:43 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b29so17984714pfp.13;
        Wed, 23 Nov 2022 09:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7SDO8Hfv8UNbCG9VUfErLc2iywPx7lgKEb1KGhgxPQ=;
        b=B8qFyvJ0ncXIpKh8Uz+tA+NVGOEhLdB35VewuYn15B+1aUQAzc1ojGCWU7dKUqfdG6
         ixZeESZi4myMt3y5S4vc3gFlD78dPjPC3kmDr5HkElp4gqt5YeXrlDnBSIB3y/jnJDbu
         fp4TK2S1nH+lMs3RSAQPfcIaunm+jYc22HhOypMsBcdNF45ONzcV9X5OOjpmP7z/aMmn
         FppIwyOrCHDj4ht5hx6Mlv/grnF9OLNiAzlzin6t8/ioW2v3OaBxehYYUXHNxcjzmQ9K
         EvQjUulZFrdacDouK+Xv6HJnNKb1Hlqwnri5vH1p3hCJTima3kgmox4QWYkKOxZyJlZd
         HVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7SDO8Hfv8UNbCG9VUfErLc2iywPx7lgKEb1KGhgxPQ=;
        b=stuUsFP05VqjIM6oaZVxmqqCEg8dRnZH8JhFVHETH36uoXnFGlRefbhkDIDd2YOeoI
         rQrIgelpwLUfDOuzwtcPXHy6JdmIjcy0zdEafQqVulp/EJb2UFCno9Mnip39rfA6kb6w
         WcIXmPqbs4R7aJHiPB3Xz8SKPkkW3A7U3GyEf9yRnRmW5QFrJ8TLjIYjugAGnYCtgeEV
         3lT2ZOyIzNuHAusq2OgOf76uLIRaIaNL7TZ7Y18Ap1izC2mZ/IE8bPm4jkkVWuOXIV7L
         M+CP+GSOsZ/r0Fxk0kXCBf4Ht9HHthtca0EpvKkyd3KnYNr1HJZ7Cuvrre3eGj5DP9q0
         E6CA==
X-Gm-Message-State: ANoB5pk5V5YaiVxUFRgwWJ0dJsUKsCbMWB0taypND5kNUOoEM1yGTLSp
        7US4k/pvEimZt5sHGcz9gFBeenS75fE=
X-Google-Smtp-Source: AA0mqf5+cnVz3hSy30L2DJBG/IkNjGN+e/YIar8DRBKJ7BNLNd/Ti0vZ7RCnhS12aQ8Op9gtkz/APA==
X-Received: by 2002:a63:389:0:b0:477:7f68:bbbc with SMTP id 131-20020a630389000000b004777f68bbbcmr4199498pgd.279.1669226083192;
        Wed, 23 Nov 2022 09:54:43 -0800 (PST)
Received: from discovery.. ([2401:4900:483b:e422:60e:77bf:baa2:9d8b])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0057470a06694sm837503pfb.40.2022.11.23.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 09:54:42 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 1/7] mfd: mp2629: fix failed to get iio channel by device name
Date:   Wed, 23 Nov 2022 18:54:19 +0100
Message-Id: <20221123175425.564042-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123175425.564042-1-sravanhome@gmail.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/mfd/mp2629.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index 16840ec5fd1c..f4c5aa06f38c 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -51,7 +51,7 @@ static int mp2629_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_AUTO, mp2629_cell,
+	ret = devm_mfd_add_devices(ddata->dev, PLATFORM_DEVID_NONE, mp2629_cell,
 				   ARRAY_SIZE(mp2629_cell), NULL, 0, NULL);
 	if (ret)
 		dev_err(ddata->dev, "Failed to register sub-devices %d\n", ret);
-- 
2.34.1

