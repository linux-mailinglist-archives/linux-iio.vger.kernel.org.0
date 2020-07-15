Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543B22208AF
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGOJZm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730684AbgGOJZf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:25:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6EC061755
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so1684290wrn.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=qhopu08JJqyGVWM8MDtpU6JVIWtlkY/NnlnGcBCS+TkqHVlMYZCT1RLk+MEuRYSutJ
         Mz8gNxGSDfTI2Khw6fFC3HZcnjZ6Z+Z5iqmwENLjM4HHIWIMh56/pmcmIBmkgn3H6XMZ
         M6KH8TAg17NgRppYPsBYkQf4jev6BsLcTpXASzlY4SUydRRXOOANPVb6nu0GXXXxZT1U
         vUXWUbvpCu8a/l/dBvForlWP/wA2pJyQJKcjMOlX3Y5uSh1i4gEz0L2GOgugIFGpyQHK
         1n0DYLSdBKCzzAx++x22kXWT9YBkSHuodb5M5K4+W9OauBo41vCiKiCYdQE1/zn9bP0Z
         OUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AR4pD/vZwN2JP47WtR5Vfk5V/YokTCEDqho1kec2JCE=;
        b=fgol7qORqM+4lepR8v/f2E3LAwvU01eGBgJJ0sVwtIGlOXH72kwGO04zK1NJgPlC0m
         zW8BlnSVVupFy5jCZkUHUekfWGnQA3iRJnGauvI7hUsOF/GwDBETjmOn5DwzXwFX3B1E
         d5PlfGjG5XCYy/gPe9ZIN1pKzr5nuVeUCBzh15ijgYLlvBKHJScrhBZjtGOtS02+UDXA
         bHK3Dyvnr8RDlnoS8dDHU51vnIVzB96lt1EUsEmLpkBzfbH4lsTYQd7gbSlHIA2eSXEa
         vTrPZ5WHXvp3HDd24LpWCiev+5OsDxESSFcdPEDe7jw+HTMjbwJdzz1xecTNqcGqUBEj
         HEBw==
X-Gm-Message-State: AOAM53074fcajHHiXhRSCKIuS7tjfzeHulR4vRI5MM7Lh7MRNclmJml+
        PFEw/4OkVfcl9WEEW+Nh5CfpGg==
X-Google-Smtp-Source: ABdhPJwasQoZOdVqFSXYXVkG5h1AH+jFH0hwrRh6njPBhBYy1lP/eR9xcCccJviz2jSBfYaDCl1Kqw==
X-Received: by 2002:adf:facb:: with SMTP id a11mr10840496wrs.277.1594805133522;
        Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v11sm12083419wmb.3.2020.07.15.02.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:25:33 -0700 (PDT)
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
Subject: [PATCH v5 2/3] hwmon: pmbus: use more devres helpers
Date:   Wed, 15 Jul 2020 11:25:27 +0200
Message-Id: <20200715092528.8136-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200715092528.8136-1-brgl@bgdev.pl>
References: <20200715092528.8136-1-brgl@bgdev.pl>
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

