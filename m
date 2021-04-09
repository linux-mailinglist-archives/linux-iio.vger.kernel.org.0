Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D9D35A61E
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDISur (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 14:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbhDISup (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Apr 2021 14:50:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80DC061762;
        Fri,  9 Apr 2021 11:50:32 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q26so6855227qkm.6;
        Fri, 09 Apr 2021 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V06g/V1PyEv48SI7Hy2SrXRWy5uxigOGYLsg44Gvu+0=;
        b=flQtyr4g7O0z7R1besBKPwzFccbfZHeZo/r1YD03lAB0h2S4w+etAKkwk9039/e5TW
         9hlM1xt1pUzntNZ73KIfw9Be26WhjVs5RR8LGpM+9mdG13KXoOcMUosrLxbFs0RJYrg2
         cOcpYZmb4rZAjcno68WG7NBtIOdPxKd2AckokMiKZN1kdYIgjDKXPgmzHNvaUIHSNzeO
         7f30TmhSszH/z6huOOTnRgeqfSWrltgxM7e3r2D/5Vj6b23DnySSCrYyYzJbKxX6r4br
         oZXyq3D0l9fPUFr/iCO5yuzMuqJdyFEjeqHuSdlp+2GgTkEeaKcUjrAbC70K3sI9Hw1e
         xrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V06g/V1PyEv48SI7Hy2SrXRWy5uxigOGYLsg44Gvu+0=;
        b=sT3WyB7WWJZCQajSKMIkkoMCAOk9ra6bH8bWnNqbH1anBQeuKyQWMWd8DlRS4gF5m1
         q7+b09xoLak/9nzPHS+xENGNGqFbWtAQ0YpPEJ0R6NtfjnPQtLkDI3ETF1noUfTPsoey
         FKi6roFKBD21DiDrfk1vXWHRCQsUmM+fPhfgkOIWbSV8WbBW9tUFu9Jma5fGmTDZw6ME
         iDLfwGIHMOyPCDxC6sZLwRm8R/pWf2Slaemy4zBYm/i1/VFm+qka22ZCj199nOsc+Q3p
         SLZrBidsDOnlAphfM17/JkboO03QmDZQ7J64Vfg4d5QzpZkALuxTUMYPsrEvxxrSuEnI
         VvRA==
X-Gm-Message-State: AOAM5334sm2kle01kcJeZGokzr/WU8UjBV2Jq7MdRh4r6TynShXyJfKK
        cGauRBOUVjPg5iAc181iQt0=
X-Google-Smtp-Source: ABdhPJyNkvxUdZ444gfxFwAZsyO1t3IEaIvmxGRhVd2xNTTWfiYLHqfkW6o8JphngO0hLlvc6uuFKg==
X-Received: by 2002:a37:5ce:: with SMTP id 197mr1236863qkf.23.1617994231748;
        Fri, 09 Apr 2021 11:50:31 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01:86f3:17eb:e23c:86fd])
        by smtp.gmail.com with ESMTPSA id n136sm2379730qke.123.2021.04.09.11.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:50:31 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:50:27 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/3] staging: iio: cdc: ad7746: use dt bindings to set the
 EXCx pins output
Message-ID: <39486895e4e985d0220342f3accfd98a1e149ea7.1617993776.git.lucas.p.stankus@gmail.com>
References: <cover.1617993776.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617993776.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Ditch platform_data fields in favor of device tree properties for
configuring EXCA and EXCB output.
This also removes the fields from the platform_data struct, since they're
not used anymore.

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 33 +++++++++++++++++---------------
 drivers/staging/iio/cdc/ad7746.h |  4 ----
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index dfd71e99e872..63041b164dbe 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -677,8 +677,10 @@ static int ad7746_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ad7746_platform_data *pdata = client->dev.platform_data;
+	struct device_node *np = client->dev.of_node;
 	struct ad7746_chip_info *chip;
 	struct iio_dev *indio_dev;
+	unsigned int exca_en, excb_en;
 	unsigned char regval = 0;
 	int ret = 0;
 
@@ -703,26 +705,27 @@ static int ad7746_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (pdata) {
-		if (pdata->exca_en) {
-			if (pdata->exca_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCA;
-			else
-				regval |= AD7746_EXCSETUP_EXCA;
-		}
+	ret = of_property_read_u32(np, "adi,exca-output", &exca_en);
+	if (!ret && exca_en) {
+		if (exca_en == 1)
+			regval |= AD7746_EXCSETUP_EXCA;
+		else
+			regval |= AD7746_EXCSETUP_NEXCA;
+	}
 
-		if (pdata->excb_en) {
-			if (pdata->excb_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCB;
-			else
-				regval |= AD7746_EXCSETUP_EXCB;
-		}
+	ret = of_property_read_u32(np, "adi,excb-output", &excb_en);
+	if (!ret && excb_en) {
+		if (excb_en == 1)
+			regval |= AD7746_EXCSETUP_EXCB;
+		else
+			regval |= AD7746_EXCSETUP_NEXCB;
+	}
 
+	if (pdata) {
 		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
 	} else {
 		dev_warn(&client->dev, "No platform data? using default\n");
-		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
-			AD7746_EXCSETUP_EXCLVL(3);
+		regval = AD7746_EXCSETUP_EXCLVL(3);
 	}
 
 	ret = i2c_smbus_write_byte_data(chip->client,
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
index 8bdbd732dbbd..6cae4ecf779e 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -19,10 +19,6 @@
 
 struct ad7746_platform_data {
 	unsigned char exclvl;	/*Excitation Voltage Level */
-	bool exca_en;		/* enables EXCA pin as the excitation output */
-	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
-	bool excb_en;		/* enables EXCB pin as the excitation output */
-	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
 };
 
 #endif /* IIO_CDC_AD7746_H_ */
-- 
2.31.1

