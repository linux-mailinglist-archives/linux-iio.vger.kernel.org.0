Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF322B9E4
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 01:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgGWXDt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 23 Jul 2020 19:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgGWXDt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2020 19:03:49 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4990C0619E2
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so4947071pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2020 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6gik5lIa4hZg2yMpm21gJ3uaZzga/bvh1wizvnRR9VM=;
        b=QVhNlV1PaBaSSs5Sjc/PYgl9v/Jts29p2N0byah6yz52dO2oca6IwAaHUPE4vIsQWT
         ncdYFr8356cW71vtEzFS3lRC6zIGeihOxpBNnLltcVXNjWGzApqSshG0sAWMEqCcZRTh
         D86gxEVaXZUCDPbGchzpT0pwDI57Cs6kE7U/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gik5lIa4hZg2yMpm21gJ3uaZzga/bvh1wizvnRR9VM=;
        b=rxTZGuPOx8B/LUcIukCastQNR5A2WKzLCXvhgbdJ3riezQE65wnh12GgLcJ4RgBgkS
         XZAiatgljjL/0jE7cYKeRrVw5PFygFhLhn27zxHC6NFhzHzNE8SJwohcezKkBjVySq2H
         8PuEEuIwCSgJ+ZIhTHG3QQ6ei3mhD9DyoJhMVlPgl2hM8GXkyOKH9sE4kqOAfutN/7C9
         Mf9Nmgg6OmIn0Hvt0SBF07d4AXsNupwHkBtVBXkP+JilwaAsHXKCiG3fZBZfscHhlWHT
         ev7rXLMwPvIJUcF5vEdjia6jQHilwR5hakOeuP0dlr68P5JcayVWaHYIamIohttG/kFB
         mASQ==
X-Gm-Message-State: AOAM5325kXQVNp1dcPNUVggi5ftxJkHdGo0MNglrfbXOk68xKVJ2nLmS
        AuIGucesANjE62sA3APvGmvMRQ==
X-Google-Smtp-Source: ABdhPJx8tNYF2HodmfcGu+Fa1S4yj5uYhQNArwNvP5aIjev0QLhFeZtHUF/5WCeXzUn7oP2Ul4tNcQ==
X-Received: by 2002:a17:902:22:: with SMTP id 31mr5265629pla.120.1595545428447;
        Thu, 23 Jul 2020 16:03:48 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k98sm3816070pjb.42.2020.07.23.16.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:03:48 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/3] iio: sx9310: Add newlines to printks
Date:   Thu, 23 Jul 2020 16:03:43 -0700
Message-Id: <20200723230344.1422750-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200723230344.1422750-1-swboyd@chromium.org>
References: <20200723230344.1422750-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Printks in the kernel have newlines at the end. Add them to the few
printks in this driver.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Douglas Anderson <dianders@chromium.org>
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

