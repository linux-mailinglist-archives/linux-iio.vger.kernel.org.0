Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB021D953
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbgGMO7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 10:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgGMO7t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 10:59:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970E1C061794
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so16901702wrm.4
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=UT49nUv50rfkVE34LzYzCUN0MzEtJUk/hHQU7Yoiq4SYrI6OS+HIXgj7MMtYTMb/UW
         lS6D1Fbx2CsDabTrAve2C9SMY5SqBjKgGL0mG4UiV95E668adMxp9MERWVlBwE3HCFGd
         dPhLl5e75N2rR7AfxpjORZq5CPLsWT7MpAbqfHuv/F5Az3caWZcGEnq2L4Jn1qHSbcbL
         MtXQbsSK8a2AfYO7e64tGBeFzo0u6PylqUUDBCj8jqNVLpltCH2M0Da7LSK33uguM0V9
         BH93Iujz9fKJFr8Xiq9/3a1yce/8iPU4rMTgXS1BQFq/sYsFsEWC5BJh65pv385yedp0
         OBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=kMAa2Cd14WV7X/ioWILGVOZaRT6Av9y6/g6VCtN2m6uNM312STI1bQUvrB53f02W2X
         87I+GDkjaJZco4n8v9u+P4hgsjPOuymjMC1vZnyphaplqj7T9oFBQlDh62xIG1moALaM
         xQtYGk6jw9hltTW/9BDdTT6HEYUbQpQG986uLB9gs0SsPShdnOhhcEFI17tW5CmyuZfc
         NdFibv+Xtcb3kQjkqa+AY3M+i/qQDpDWKjcbyawM9VYkNYbqzBAk2X0v4VCcCzfm3riH
         oceDEslo95JRTp32H+1I0abSTAxtlt5kIUxc2tx1qxZWj2qgyDlITP/ILP7DS+5eJM86
         kgDQ==
X-Gm-Message-State: AOAM531w3dx4dsdTbE+9tevm9an+QB0MY7RyugwHKFti8KHv4yEll2VQ
        JALjH686aTvIDo13SQcPsbbM6bkNSpg=
X-Google-Smtp-Source: ABdhPJzxLWXdgm9jFVVW4np6605Vs5gN0IJc/FptyfVS18DJKRb00triNmLMkoUaIVNauvJ8+1nbXA==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr79075013wra.165.1594652388415;
        Mon, 13 Jul 2020 07:59:48 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 2/3] hwmon: pmbus: use more devres helpers
Date:   Mon, 13 Jul 2020 16:59:33 +0200
Message-Id: <20200713145934.18243-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200713145934.18243-1-brgl@bgdev.pl>
References: <20200713145934.18243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shrink pmbus code by using devm_hwmon_device_register_with_groups()
and devm_krealloc() instead of their non-managed variants.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 44535add3a4a1..91839979cf6c1 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1018,9 +1018,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
 {
 	if (data->num_attributes >= data->max_attributes - 1) {
 		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
-		void *new_attrs = krealloc(data->group.attrs,
-					   new_max_attrs * sizeof(void *),
-					   GFP_KERNEL);
+		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
+						new_max_attrs * sizeof(void *),
+						GFP_KERNEL);
 		if (!new_attrs)
 			return -ENOMEM;
 		data->group.attrs = new_attrs;
@@ -2534,7 +2534,7 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 
 	ret = pmbus_find_attributes(client, data);
 	if (ret)
-		goto out_kfree;
+		return ret;
 
 	/*
 	 * If there are no attributes, something is wrong.
@@ -2542,35 +2542,27 @@ int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
 	 */
 	if (!data->num_attributes) {
 		dev_err(dev, "No attributes found\n");
-		ret = -ENODEV;
-		goto out_kfree;
+		return -ENODEV;
 	}
 
 	data->groups[0] = &data->group;
 	memcpy(data->groups + 1, info->groups, sizeof(void *) * groups_num);
-	data->hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
-							    data, data->groups);
+	data->hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+					client->name, data, data->groups);
 	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
 		dev_err(dev, "Failed to register hwmon device\n");
-		goto out_kfree;
+		return PTR_ERR(data->hwmon_dev);
 	}
 
 	ret = pmbus_regulator_register(data);
 	if (ret)
-		goto out_unregister;
+		return ret;
 
 	ret = pmbus_init_debugfs(client, data);
 	if (ret)
 		dev_warn(dev, "Failed to register debugfs\n");
 
 	return 0;
-
-out_unregister:
-	hwmon_device_unregister(data->hwmon_dev);
-out_kfree:
-	kfree(data->group.attrs);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_probe);
 
@@ -2580,8 +2572,6 @@ int pmbus_do_remove(struct i2c_client *client)
 
 	debugfs_remove_recursive(data->debugfs);
 
-	hwmon_device_unregister(data->hwmon_dev);
-	kfree(data->group.attrs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pmbus_do_remove);
-- 
2.26.1

