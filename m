Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C636121C9
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ2JaK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJ2JaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9435808A;
        Sat, 29 Oct 2022 02:30:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l32so4465436wms.2;
        Sat, 29 Oct 2022 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW+UYRb2CSBuEpmSaGw7sQ/AAKDnWs/63BdEHUXF19Y=;
        b=Zp9rJbyx0urCnZGLvKGDNjhEfFoFfPH7kdDjdkEMANwoRordRSk/DUXX+PZtPSSGt+
         o8xSAs/tqw7srio5+PqeiveCTsFp/B9O8zQA4obfcwLghIgXUxeDa8XeruhLe/p5G/4t
         drRX22IkUn273HrJDQ1fcOzAcoM36UrMA1Ovi8yj2db4J7KojhH7vwDBenhRF8MY8hRx
         fh9K3D8NlZuS1YeORjEu2k1Z6of0xvXByUAkJXSS0eXth1XztHUUkWAvYhMx0SmiANK+
         lqpPOYKFQiNA4Lu5X3PMOPSXLbVnU9uT+WVN+sclvEb3QbUVwioQYImq/hN+yuL5Qq2c
         vRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW+UYRb2CSBuEpmSaGw7sQ/AAKDnWs/63BdEHUXF19Y=;
        b=SoWWJTbzvqSy1Nnr1tn+5s3f1nLfy5BtwXoxmwOeQg7JeCnmTgOx+wDZj8N00dXtYg
         EIEZ9os5cVUKFmgMhfK0xW26B/VHWRe/mqyT+Aq6vsMqjgIBbMcFrkwYO8XShCzmsdaZ
         OMKi4oOVUZNumWamAhlAp/opwxy6ty6vAtToOvNoW4dCdJYImb24M1aFoPo9D00jVPQE
         s900IXDU+Pk2iIuU6dhqNvb4gcxP7POd+Xc4po+PLqqt+IqT175sC7lYEZ+EqjBOj2tO
         n+//ZR/9XGpDWj4U4mqLG63OaxmYg8y0OPFcz3lmVKrGqKdWiXj1jlZswI7JRBnTG9oI
         IYyQ==
X-Gm-Message-State: ACrzQf0NG9NWol8xBizrYnli/s/Uigauo/22daCVFEwPfGN1pvGb/pi9
        JfyHlEkybG0IDgTFj6/WYcs=
X-Google-Smtp-Source: AMsMyM6COioCS4F6sVSJDC7QvwzHDVe6990k2yEiGXXYJ/DTBlJX+aQdhY2WgfKauRsbemOR5xbRBg==
X-Received: by 2002:a05:600c:5127:b0:3c6:47ff:5d33 with SMTP id o39-20020a05600c512700b003c647ff5d33mr2065991wms.68.1667035805788;
        Sat, 29 Oct 2022 02:30:05 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:05 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 2/8] mfd: mp2629: fix failed to get iio channel by device name
Date:   Sat, 29 Oct 2022 11:29:54 +0200
Message-Id: <20221029093000.45451-3-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221029093000.45451-1-sravanhome@gmail.com>
References: <20221029093000.45451-1-sravanhome@gmail.com>
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

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices")
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
2.32.0

