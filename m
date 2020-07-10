Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B6C21BA99
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 18:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgGJQP2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 12:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgGJQP1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2020 12:15:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9D6C08C5DC
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:27 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so6743667wmi.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=c/4slGI65Q34YtH+SDdFpF7G4+0XGXMuxXkoCPO0M5y54DgTEonMEEKiJ1aX4maZPI
         xexN1w6sXCRbXSjGckFsKvlgHkE9h/JxY7X7PpWmfzew8ZpwwygVNt39AtGUkAj3UmoD
         EBnLrTIEeNsMT8o8DkUgYXXRUT9UhGsXpO0aKxasSaQaHG775NqAS61maxfHI0Tx/Ty0
         loEa4cMkiyYiMAd9t4EYMco07+ehqxY669oGP6mUL2I/eTMjZs1ASyVZAZTpGKcqtnby
         VUlCyJdLU27vsyIXZWrWe04ckJyVBQIiBmwuQ6o04DCbdNooi2BV7v4ZSIb0RPbvLwFT
         GRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=UZVClVNxMjHh/nI16NDkE0N2mi8psMYtZ5OcUAqcvcuDivyqlmnx3OpykjF6G5uRki
         ig/4mAda7QkPZSb8sSC437aMYjAHOqsdUGgMONkalmc/gl/Y5rqFGZcP4Y8hjwTuT/1W
         0GP5+QGnwUokfDWHZA6FroLLDF8okJE78UBBxuByK7pvlb/vmwI3cz9SWPCXl5kve+me
         6ckVuwzR45sZxaEuyUBgHTrIxKiueq8kCE2GbvQ5OBxQ+aqxqTUHBH34QhsPdRp8X3sU
         9EI0J7StlrGdE4hRIjbZnP5x8CN9K4v5TXCjVrZcEhmHJc6GyL+ZMaAexkp3dEJn2ak+
         Er0A==
X-Gm-Message-State: AOAM533vCRQUjT1sOvUEFwl7WzYjQ52qcAzgJiuswuNk+patKLwK28EQ
        A4mOtFgJOQ/XTaD4eL68CB+4Hw==
X-Google-Smtp-Source: ABdhPJwt3IgeUN9TgYJhau5DYs8214C9lbhCSPsS5zQNpuTvCkT++MyByRc627aN9oAdzByltAQl/g==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr6268130wml.25.1594397725779;
        Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 2/3] hwmon: pmbus: use more devres helpers
Date:   Fri, 10 Jul 2020 18:15:15 +0200
Message-Id: <20200710161516.11625-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200710161516.11625-1-brgl@bgdev.pl>
References: <20200710161516.11625-1-brgl@bgdev.pl>
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
index 44535add3a4a..91839979cf6c 100644
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

