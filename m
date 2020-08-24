Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320AD2506AC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHXRjR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHXRjH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 13:39:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D360C061795
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w13so9325572wrk.5
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=mVpAGo7eY6TxDLtJv9VnboajgA8FuB2xAnMl35bzpRxAQpWpsN3EeLbTgDSa95OIj1
         EmS0CB3EIwRjYRC1f/nkxGbzMgAS5OKJTT7nIjyOSnU7LDRA3SoqH9XoMgzc13FuJ3QJ
         z1MvPvWXCjIWXhrZ3sfiX59TU3NjA/gIo1QHwu4PJlf6pYp4XzwlpIoNvGwSIkexbm3u
         S2RBRtBV6HVKx8xLoLEKEyQRhDmX2G9ENHCwY8UZgSWDUjaSzwQK1PkGrHn8wYRNCwJv
         wwEggv2OE1t4UEQ9lNfKweTwN5Zhdt0rhUhAH5CXQwfvIKtu0c4xLA/WRkkBBEJskazW
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=pIfT8mPA/1v1Nompeo0vc+9wZ+xgx/fb57cvjxIfGY98b8xpVVLDWpH5vXedAiBp9q
         lThhaJnyo1rYu+ppB4rrqxD5RGHk/129genejsfMvpe7Y00SC9EJXJUUs+P4xK+s1ukZ
         6fzlpleYjjOqqdn1WpSYbGdZDeZvElhy43B6jwiBI205ropTDJ+AdE+u9OrhN8mXxiWs
         claJLu0RIOIAhcWARe2Vx5hRuGi82IQzJhp2fKGLabTtAWsJrPrhNdTuUIenA81Kom2v
         fTKTnLBLuXBHSbhsUBk06vpXRNuZFAa4ujK+ICtVW896zqyB3dOsnwj086EHlRUmKrqZ
         uQFg==
X-Gm-Message-State: AOAM533jdAVE3Aetc3mxLqaXFXV5zY1mrbbJCvVcV/ohZui5sBIcFH0z
        Xd3/3cvsK3Vy+0mCLf/N4jjF+A==
X-Google-Smtp-Source: ABdhPJyqjmDxvzAygJrcC76kK9zKNKJDqWRAsTa16DY8BCJG1oe0jQzsj9BbUtJnHjDRnc4j58m79A==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr6911532wrn.225.1598290745779;
        Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
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
Subject: [PATCH v9 2/3] hwmon: pmbus: use more devres helpers
Date:   Mon, 24 Aug 2020 19:38:58 +0200
Message-Id: <20200824173859.4910-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200824173859.4910-1-brgl@bgdev.pl>
References: <20200824173859.4910-1-brgl@bgdev.pl>
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

