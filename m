Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B5185DFA
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgCOPZT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 11:25:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgCOPZT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Mar 2020 11:25:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id 3so518336pff.4;
        Sun, 15 Mar 2020 08:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=OZDiihJ3OBBRg2OIBgYZpbzLQGD8FEl/aXEB9troNrk=;
        b=QX+syxtcf4GjKjCDWFlesV29F0cBOtMntwqXN5uZUar72ElN03mFqOQENkbtOvbE3r
         i2MEkW5/ieqzSaHZ6DdxfJRTN54XWIQHLVf15BMOoZ39XaU58QYkHo1JCv6yTeCeUCC/
         kZBKlLf/iwUA4LSnsSXi5Xi8K8iFRZBckcRd6j88GDMUTLMprslKd8dzYmx1eHygkQxt
         wbPjW4Hizn3C9+n6sUim89qqAn1gHwfSGNjOKEeuvOp1uMjerSsGwIyMxKmYbZw9gPfM
         ksodhVrtnAMA8QGmnwdRrXRpwKCJ+yuiknoQqlDQWMd1hcDzpyZ9qqOgcVcuf/GR5cXw
         oQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=OZDiihJ3OBBRg2OIBgYZpbzLQGD8FEl/aXEB9troNrk=;
        b=FnxhqXEBTutJZT74PgEM/eksr2DgMiHV9fHcgkaohw+95HDnIjcF+4bSHoZrC1HDdd
         SnhcCgzi+IVmv4V0CFfbsGiV3ABlP2OfQM/3e1//4f1yocoCGKcfgcAaZvovownWtJem
         pFWNc8P/OdB738tAGjfV3tO1f3eavie9uwuv9iwVZuEYSOKb0sK6DjmcdMW1fmIl5N2n
         sFQCHoeJCnJoO4ej1jlPy0jxpKHijxDFU7goUKttvRjkbiCZveFIr7jMMwFX1ATzmyN4
         z9j/yXSavj7wF3yQSk8ufJQUIVPNlyGWAAKc6ZWgv2p/g4Gpt0qvMqC9+Q37ZTas2DGS
         uSoA==
X-Gm-Message-State: ANhLgQ31Qt/iffkb1EuKH+XzCFG7op3GK9ArstqMOOIHVrPM9S0yFgi1
        6qKJAOt9XaL07VCeVcXiquj/MW0/mDG/sg==
X-Google-Smtp-Source: ADFU+vuRzHjAMFvBgD34pBjb6od/bFzqiSRchqVitpfWqkx3vPp9jB8ejHAhhT4dhtHDNo9AQ08D+A==
X-Received: by 2002:a62:1dcd:: with SMTP id d196mr22287689pfd.296.1584285918156;
        Sun, 15 Mar 2020 08:25:18 -0700 (PDT)
Received: from SARKAR ([43.224.157.36])
        by smtp.gmail.com with ESMTPSA id s18sm26154569pfe.15.2020.03.15.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 08:25:17 -0700 (PDT)
Message-ID: <5e6e48dd.1c69fb81.11507.523e@mx.google.com>
X-Google-Original-Message-ID: <20200315152512.GA8096@rohitsarkar5398@gmail.com>
Date:   Sun, 15 Mar 2020 20:55:12 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alexandru.Ardelean@analog.com,
        dragos.bogdan@analog.com,
        Matt Ranostay <matt.ranostay@konsulko.com>, jic23@kernel.org,
        rohitsarkar5398@gmail.com
Subject: [PATCH v2] iio: health: max30100: use generic property handler
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Instead of of_property_read_xxx use device_property_read_xxx as it is
compatible with ACPI too as opposed to only device tree.

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
Changelog
v1 -> v2
- remove of_match_ptr to make it possible to use PRP0001 ACPI based
  bindings
 drivers/iio/health/max30100.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 84010501762d..546fc37ad75d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -16,7 +16,7 @@
 #include <linux/irq.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -267,11 +267,10 @@ static int max30100_get_current_idx(unsigned int val, int *reg)
 static int max30100_led_init(struct max30100_data *data)
 {
 	struct device *dev = &data->client->dev;
-	struct device_node *np = dev->of_node;
 	unsigned int val[2];
 	int reg, ret;
 
-	ret = of_property_read_u32_array(np, "maxim,led-current-microamp",
+	ret = device_property_read_u32_array(dev, "maxim,led-current-microamp",
 					(unsigned int *) &val, 2);
 	if (ret) {
 		/* Default to 24 mA RED LED, 50 mA IR LED */
@@ -502,7 +501,7 @@ MODULE_DEVICE_TABLE(of, max30100_dt_ids);
 static struct i2c_driver max30100_driver = {
 	.driver = {
 		.name	= MAX30100_DRV_NAME,
-		.of_match_table	= of_match_ptr(max30100_dt_ids),
+		.of_match_table	= max30100_dt_ids,
 	},
 	.probe		= max30100_probe,
 	.remove		= max30100_remove,
-- 
2.23.0.385.gbc12974a89

