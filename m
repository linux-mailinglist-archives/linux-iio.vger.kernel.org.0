Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795AB5E6FF1
	for <lists+linux-iio@lfdr.de>; Fri, 23 Sep 2022 00:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIVWuf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 18:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIVWue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 18:50:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BEDEEB60
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 15:50:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so3915125pjk.4
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aUsvRZZI7T1y4lULyz+no0ZVbiyfe4QpyexoidfYtdQ=;
        b=SgPZAe0IfcJAICF/KlO9tfwf7k/nCrqr6QJ09tc4ZLiqBiSgzjV/uiT6LUZGz3ldvb
         CLvG/x+G+u5wm0nVcFCmp8fgewo9G3MYl+MxQ6XJFtw/BdyOQLWAH1hDpMRRrmDNfljy
         Tejf6+99+ngzW+msmzBDEZ6CA5u6SSXiKr5T43W5rfzUdDENqTne2LvsX3b7YJmd45O0
         0iLcdOQWtMtJpfsIOypaYiekFiTZf+q2f+SShsZD93tdcPwAS+trBY1nW4fGEX1UPf5K
         1vaEyeart5YCqMYRWD23MHQ2YxD4sUaLhalk/U3sGFZpg/8bqpXzHpQj44fiLg0GmrlF
         Gz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aUsvRZZI7T1y4lULyz+no0ZVbiyfe4QpyexoidfYtdQ=;
        b=JmuuQpP1T4l83qYTGrPcxtuVNWJp1bWLIqRpoCEIzgBH3pPi0deTUMK/qTy17jhoC6
         Hd3rEtQ2RRIExhFDgJyBi8WeSPDTc14nw/rIlp9BzfAAlDc0uZSx6MiSIFQ5V/yrOCse
         p2SZAMQxfd9JneaykcWQ3p5tALre8GZRE5bZv+pQp7tYlUIDvXrIBhKjeYG2SaX37u/Q
         stu0fg3LPj1HCy0+oCycUtHkSnnVvvZ2HXrlkGdeCMzZfgJiZRl6+fkk4VXePVk5noFk
         eW/T0C02J6vSqduygXQofex1t2HPYvbaPgbfg1U8esquzCWLdRyxl0NihrPaNQtzedb3
         7HEA==
X-Gm-Message-State: ACrzQf3nAKpm6W3lfVLVHWmxEBAjVbHCCvU0NyIqDHMiMvwU7CkLvdaS
        JKJ8bWXeIfFmyl1QRRGmMI9rUg2e+P8aAw==
X-Google-Smtp-Source: AMsMyM68UWImP3j/04nuvpSTAmAU38fG0iJWu3pUmRc70XQY007sazvcDf1dkoh8jC61cRihyzirmw==
X-Received: by 2002:a17:902:c7cc:b0:176:9fdd:ddb7 with SMTP id r12-20020a170902c7cc00b001769fddddb7mr5473251pla.150.1663887032733;
        Thu, 22 Sep 2022 15:50:32 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id 14-20020a17090a190e00b002032bda9a5dsm285189pjg.41.2022.09.22.15.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:50:32 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     matt.ranostay@konsulko.com, zheyuma97@gmail.com, nathan@kernel.org,
        paul@crapouillou.net, lars@metafoo.de, jic23@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/magnetometer/ak8975: check the return value of ak8975_set_mode
Date:   Thu, 22 Sep 2022 15:50:12 -0700
Message-Id: <20220922225012.1709173-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Check the return value of ak8975_set_mode(). When it fails to write the
register, the error should at least be propagated to the caller.
Currently function ak8975_remove() returns the success value 0
no matter the execution fails or not, which will silently leave the
error unhandled.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 2432e697150c..e08f10fe16d0 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1022,16 +1022,17 @@ static int ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
+	int err = 0;
 
 	pm_runtime_get_sync(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 	pm_runtime_disable(&client->dev);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	ak8975_set_mode(data, POWER_DOWN);
+	err = ak8975_set_mode(data, POWER_DOWN);
 	ak8975_power_off(data);
 
-	return 0;
+	return err;
 }
 
 static int ak8975_runtime_suspend(struct device *dev)
-- 
2.25.1

