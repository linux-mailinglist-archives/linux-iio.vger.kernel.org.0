Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF00624C5D7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 20:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHTSvg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgHTSvZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 14:51:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18273C061387
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so2698811wme.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=iwarKzYyK4MKjJW/4BzhLQmtU+H8hW6h05HtZHyxDAz+nC5pJoxUpbY2HF5XhTIeQu
         c77ui33ScwYXE81kdCnr3IghIageEAAQRR8YC8AXSqkOgme0P7wQMwl/Yty3iEq/Jd89
         rXfJXnQUWdPYdQVZVHDCorDJf9RRjvJ/PtrBvUmO38x8preXWRmgaohWeMvTw6IQcvpQ
         s1qN9tsrpxY7JGHxeZmz4WmHPh1gZz0JcTJ1PmoRE/O1kYn6abSDLbnhqpgI+lTXE/t+
         aY86hNiy8Vh/C/F3cN7gCw49cwwvmOj8Ak8He1yjXlAfchwBtXjw8PDKOgs6B96RtO8i
         e+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=hX5+Qi8TaVwIYXwU84/7qPlAfOBwe0eSUQIdlFANS8SV04ASovAOljUKj1E4dVJyyn
         gXkvov8L72IZMWesZ7aNuUiwD41D6kOLhWbknXWBhZQIl3Gy/XqVuxIg14HsdtRmvYNZ
         ne34qq72ycBemMZLqwdIdOLIlR89aXZyeReuBsVNyzI3U2Um81q+EOkwLjNwdX/MsRmi
         BMF0IH+3Zz2Nya/AC3xvKyGP4ZcqOEzXBX7rAbIqN9QbM5tM5CHlATFCokqKb9FoX5tY
         orE4q8+plhUBz63mQ3WAARJYntfWLYZm4ueBOYjJnl1y4auxGlpA17pEF2sXeoPWDPQH
         dPmA==
X-Gm-Message-State: AOAM533FABccSy6g4W+xW+0DE/AMccx6uihRxDFHZ8SPrrfl/n2zIk/J
        9R9nI488XJS5aaOmHgAJJZTdoA==
X-Google-Smtp-Source: ABdhPJyi93EpGUHDhn1RcT/hobwWURvQP6QtBccpZMz7jNGPAcMuH1elqP6hkoFeMAOkZrFBFXKrew==
X-Received: by 2002:a1c:2d8d:: with SMTP id t135mr73516wmt.76.1597949483778;
        Thu, 20 Aug 2020 11:51:23 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q2sm5694019wro.8.2020.08.20.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:51:23 -0700 (PDT)
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
Subject: [PATCH v8 2/3] hwmon: pmbus: use more devres helpers
Date:   Thu, 20 Aug 2020 20:51:09 +0200
Message-Id: <20200820185110.17828-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200820185110.17828-1-brgl@bgdev.pl>
References: <20200820185110.17828-1-brgl@bgdev.pl>
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

