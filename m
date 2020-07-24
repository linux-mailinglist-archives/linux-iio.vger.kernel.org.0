Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2884B22D098
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 23:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGXVdp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 17:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgGXVde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 17:33:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02173C0619E5
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m16so5292879pls.5
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2020 14:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Or2hRyZ+DJD2fMv0vkFvtUzR/cluRUiM0su+3Iw/kY=;
        b=bueanFjGE8P6y0aX0kwLr2tZV2YD96YtUUUTOZYK/ammPsZ0QoUt0HZCNi1ZOtnfN2
         9gedv4E86CKFfdSifS9RuWJ7hPiVHPmSsGQsOJZNE3NneGyBG/L2woCwcQHCZRlJDtTg
         dBEkIFoYCBcSRPmhMMzNwfYN7pVeD8XIqlPi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Or2hRyZ+DJD2fMv0vkFvtUzR/cluRUiM0su+3Iw/kY=;
        b=mr6Y/kJ2PSPXJj7BQKfbVAclJXXL/odSzXLsYLKLAtVkbGACptiC0d8uv/r0iq0mgE
         D9ajqNWiwgfllpJbQ8WtE0YYqM2Ym3AtQFYNNl1l5wAoS6VgEl/5KxjU49CpyjrmXNBR
         EG5uau1J7VFeU7NbPhE8wEHcomDTQr2fw2X7D6ayIKBgL1rSu4faapVSePLNHy2unQp3
         suTMOq1EzY4ZIKdzyx42CQUuT+74ODLOnm0PMvUZGhL9etmX+dU4mnVUtpNCb1XkoLhd
         HA3QsAEN5TNYuoeNpJSUeSiyubjhlUp2HA47gDfCwjb3bRfDmQkOApPMkj/BVqXs12Ac
         O+tA==
X-Gm-Message-State: AOAM531B5mAvp5jweeuaofppeHg3mLorPfu7aY0SnOQOTujSmeBKpBW9
        ySmAc8zfSRBEVvJSlq1LhXgYBQ==
X-Google-Smtp-Source: ABdhPJyHNEX4/GvHCS4/49Y3LcVSQrJYa3M5O+TtF5sMRlADwPsO/3YJw0/2WqHVUucWSfwuDbYpgA==
X-Received: by 2002:a17:90a:62c1:: with SMTP id k1mr7522698pjs.107.1595626413574;
        Fri, 24 Jul 2020 14:33:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 2/5] iio: sx9310: Add newlines to printks
Date:   Fri, 24 Jul 2020 14:33:26 -0700
Message-Id: <20200724213329.899216-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Printks in the kernel have newlines at the end. Add them to the few
printks in this driver.

Cc: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: 72ad02b15d63 ("iio: Add SEMTECH SX9310/9311 sensor driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/iio/proximity/sx9310.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index d161f3061e35..84c3c9ae80dc 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -824,7 +824,7 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
 
 	if (i < 0) {
 		dev_err(&data->client->dev,
-			"initial compensation timed out: 0x%02x", val);
+			"initial compensation timed out: 0x%02x\n", val);
 		ret = -ETIMEDOUT;
 	}
 
@@ -871,14 +871,14 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 	/* id will be NULL when enumerated via ACPI */
 	if (id) {
 		if (id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
+			dev_err(dev, "WHOAMI does not match i2c_device_id: %s\n",
 				id->name);
 	} else if (ACPI_HANDLE(dev)) {
 		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
 		if (!acpi_id)
 			return -ENODEV;
 		if (acpi_id->driver_data != whoami)
-			dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
+			dev_err(dev, "WHOAMI does not match acpi_device_id: %s\n",
 				acpi_id->id);
 	} else
 		return -ENODEV;
@@ -891,7 +891,7 @@ static int sx9310_set_indio_dev_name(struct device *dev,
 		indio_dev->name = "sx9311";
 		break;
 	default:
-		dev_err(dev, "unexpected WHOAMI response: %u", whoami);
+		dev_err(dev, "unexpected WHOAMI response: %u\n", whoami);
 		return -ENODEV;
 	}
 
@@ -920,7 +920,7 @@ static int sx9310_probe(struct i2c_client *client,
 
 	ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
 	if (ret < 0) {
-		dev_err(&client->dev, "error in reading WHOAMI register: %d",
+		dev_err(&client->dev, "error in reading WHOAMI register: %d\n",
 			ret);
 		return ret;
 	}
-- 
Sent by a computer, using git, on the internet

