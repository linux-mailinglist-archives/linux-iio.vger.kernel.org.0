Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EB246DAB
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 19:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbgHQRJz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 13:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbgHQRFn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 13:05:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E82C061345
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so14504717wmi.5
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=Fx+WmWRgfr0mflhkLJ74+msNBLBy0EPtTitUpI7fH2cbRlxfGDsxPb22XTGidDpn6z
         578bGEK8cSGp6XbZrNa4+1KI9nFHrQic7Cx7U0Ph2PRWmjRKEaEuZHxQKwNxkH1FNhiT
         24bYnn/L8FNNwfLfJU2by7fFZtPx2c1PuI+gq8iKJANmqbJwQw5wO5K4d0Ss1ZU3yO1T
         9FsmnsV1apgyWtGo4WGptWM5dbrpful2QmrK8OXh7wZl7PUudknHZ42YUNSy40/1bugC
         zdB0NbEmV0IbIypDt0T/1qpPbPQFb66qEcYWUQ0uFbzrWzAVPuAaWS9T4JnjXrtAguX1
         Xt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y9xTv9MTk+DYQZI9tVbj30/uWX0D0ZC3rsteP6Q+Zs=;
        b=dtmTo8GvJI+qfv5r4Jdw1Uu4PIEWFypg9zMQ0C8J/fw6xn26++a1IKMlO/tNjchQKZ
         d+tAlWVGhJSYvvXrFsye9C9LZOEe5a8Do5sFq4cW33YmtyyXiD0FatyW2Zf70v1QLEUO
         Z0cAN3Y2YNrsVfcy6op7X7UzsNRk30PcWUeG6A2LqOg0nSRg4Og2M3DKCdwE/LvB0AEH
         toc8RcwgTo/D9pTdq7TaLCKVQyQvK59EhT0jRcT9UXLE1VrGx6da7X5+JnRu0YATuoU1
         XnM9QRlEbb9KYhMwy04eoBKG6Q2cXQqBy0bjIuACcSg/BE2msIxXKNeDa5v5/xnimTJ6
         fCEA==
X-Gm-Message-State: AOAM5301RFhAe7USJ+YGXeo2BlKhSkO49JRSzXJsML6Nk+OayChYOS0+
        k3Bd74d8jFLTGJyAErbBk4dNEQ==
X-Google-Smtp-Source: ABdhPJw0YhmfuJvsFy4mf0KmtSdpljVxHGj9ockaJ0FFHKKjx2eRxG/8HNwYyN23bACjUAbKwjJ+MQ==
X-Received: by 2002:a1c:b487:: with SMTP id d129mr16340568wmf.185.1597683941879;
        Mon, 17 Aug 2020 10:05:41 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id k184sm29747177wme.1.2020.08.17.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:05:41 -0700 (PDT)
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
Subject: [PATCH v7 2/3] hwmon: pmbus: use more devres helpers
Date:   Mon, 17 Aug 2020 19:05:34 +0200
Message-Id: <20200817170535.17041-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200817170535.17041-1-brgl@bgdev.pl>
References: <20200817170535.17041-1-brgl@bgdev.pl>
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

