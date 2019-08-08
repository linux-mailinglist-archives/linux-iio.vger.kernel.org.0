Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4122086621
	for <lists+linux-iio@lfdr.de>; Thu,  8 Aug 2019 17:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733248AbfHHPoQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Aug 2019 11:44:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46814 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbfHHPoQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Aug 2019 11:44:16 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so43679582plz.13;
        Thu, 08 Aug 2019 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HE8FZxsruLvX3xYGHWKwgoiLO1Rd2XyeDoDtQvRCtWY=;
        b=grsy3TOjiWtkORQo0KQVvYxBio+r+1W1VYhuqO0Ixlp/eJi5+qv7krzNM//xDoPLjf
         aBkSIM3msOdm+qIzlp9azGTTbNGkZhP5TFr0HVlrZ9t4M03fvyvSonRZmCKDywCANjhs
         Xi9Bq+BOD0X78QLL6RevrbBDRJd+cN3beZVgVuqEDk7rsrYQ/rYlY5OXlg8AunTkSWs2
         HzWEhqEIFmZWfk3sVQ6X011c4X8vtSd6jOz5IKNycI0EjqQgEMNcvpKclHRVmcnzjfJk
         B7RjWLDD8GANCewwkrcjQAtQvvLXM79SSQ/OoHHPmZJkf2mG9zUUG7XK20WzGX/OfdF0
         gkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HE8FZxsruLvX3xYGHWKwgoiLO1Rd2XyeDoDtQvRCtWY=;
        b=eb8E+mH6r9AA+prvB0DQeruSCboemQ77QhBPnsRz+EYhJfJQWMEmzoulN7fypivcuO
         /atr4Wiici3aRbT/YpLaaUcEpI/DMsSofbmjbXLJljUbEHxUy36WX0QbxguD4j2s/yEY
         dP61XbItYZE9vajETQ0/txJzL8A99cBoizd9443uVVHnhmEQeIFoheCVDazJkbc4hIaV
         H+kpXrmbvhmjSjY4h396a2cBSz8O6YwiHpcqLP3c4s4Q7Gn5hvBnjCSVok2OPADmKcRl
         vsslsK1Nh63JCF4ERGA48BlU1spgDIYuMUN0rj+hxCxT4ghAbt9mFcKVOMt02ZrUdLn/
         zU4w==
X-Gm-Message-State: APjAAAWzE/Z1Cz06qmjdc+KCRz6tst2MUg7JLZCPjMYHIkPxEC3XbGoU
        optWmpwrCleuL0xGbPR0c2Q=
X-Google-Smtp-Source: APXvYqyJE4kvaS/a5NKJl4jOQIWf8UAHU39u6aDn4hk7Oz3YDqlkOVze10Lbmptf27kKa0ja5ylYAg==
X-Received: by 2002:a17:902:b218:: with SMTP id t24mr10170494plr.213.1565279055259;
        Thu, 08 Aug 2019 08:44:15 -0700 (PDT)
Received: from localhost.localdomain ([103.83.147.157])
        by smtp.gmail.com with ESMTPSA id j10sm64476517pfn.188.2019.08.08.08.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:44:13 -0700 (PDT)
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dpfrey@gmail.com, mike.looijmans@topic.nl,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] iio: chemical: bme680: Fix pressure and humidity ABI mismatch
Date:   Thu,  8 Aug 2019 21:13:50 +0530
Message-Id: <20190808154350.9693-1-himanshujha199640@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Standard ABI for reporting pressure is kilopascal and for
relative humidity it is millipercent.

What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_input
KernelVersion:  3.8
Contact:        linux-iio@vger.kernel.org
Description:
                Scaled pressure measurement from channel Y, in kilopascal.

What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
KernelVersion:  3.14
Contact:        linux-iio@vger.kernel.org
Description:
                Scaled humidity measurement in milli percent.

Currently pressure is reported in hectopascal(hPa) and relative humidity
in percent. Hence fix this ABI mismatch conforming to the standard ABI.

Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---

While cleaning this mess I wonder about the gas channel and there
exists no `in_resistance_input` in standard ABI :-(

We only have:

What:           /sys/bus/iio/devices/iio:deviceX/in_resistance_raw
What:           /sys/bus/iio/devices/iio:deviceX/in_resistanceX_raw
What:           /sys/bus/iio/devices/iio:deviceX/out_resistance_raw
What:           /sys/bus/iio/devices/iio:deviceX/out_resistanceX_raw
KernelVersion:  4.3
Contact:        linux-iio@vger.kernel.org
Description:
                Raw (unscaled no offset etc.) resistance reading that can be processed
                into an ohm value.

The sensor outputs processed value which is reported as is.

So, does it need a new ABI ?

 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ccde4c65ff93..28cc96d1e3c8 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -670,7 +670,7 @@ static int bme680_read_press(struct bme680_data *data,
 	}
 
 	*val = bme680_compensate_press(data, adc_press);
-	*val2 = 100;
+	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
 
@@ -704,7 +704,7 @@ static int bme680_read_humid(struct bme680_data *data,
 	comp_humidity = bme680_compensate_humid(data, adc_humidity);
 
 	*val = comp_humidity;
-	*val2 = 1000;
+	*val2 = 1000000;
 	return IIO_VAL_FRACTIONAL;
 }
 
-- 
2.17.1

