Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9E138DC22
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhEWROK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhEWROJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:14:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10568C061574;
        Sun, 23 May 2021 10:12:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v8so24935334qkv.1;
        Sun, 23 May 2021 10:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NI6VGTgdO7QUPT8Xbl98mX1OA2u/yEB+lofSkIV6DFs=;
        b=Cv08fynHoQ3MdJJet/pK3X9cTxSniHt3KnvtbV43MHXpC8EgI7CB3ZmkQvDpeU+ldV
         AXOpIRVo9PUUPrhvkMkeyxlsh5BOWuSlIqbDhXA2XDHSkRn1UZLjpZWNow/c0qPzbeYu
         y5+5rLV9wslYZjJqRw87WlIG5v3AIYUXZuJbtgzmRUaw4rN3t6l44+o1eEVrhtCIS53w
         KxLyliwMZP1fltrBWLtvagEwSpnEx0Qa+uuBw9AG8VvSlskxvRLE2ZKrwYhuicVDloOU
         C/GFSfMFEfp/iNrpP5r7d29LimWwzj5Lp9aITO7UNutfDtwHS4attXoTHhcmMnM/BWVX
         i7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NI6VGTgdO7QUPT8Xbl98mX1OA2u/yEB+lofSkIV6DFs=;
        b=CeoWQY2o4gFF80XDqdSMlIl7KHILG9ipISdGD2WozsnvvJkAEm3pdmNZepYwzsMEdM
         JezrzlLw6yDkHeJcLb1JMBnZVB2mhHgJZ+Bngq01uUG926QXmhxxCCvCYC/yHfLjd970
         hAXFlItGDwNtSzqE1dvL0xE6/gJaRvvpIBdR/6lmhNL+JIKu3Z2+4bWZR55jBxQ5Ihp0
         sloRKHlHEi4o+FVNN1KUB/o+MZJ25Uniejrv5ue5ffK8zVyvwazFmygd1IIDxsyA3Vjt
         lawtAe4/sYvBJGf4q/ID39co1tdN/EZNCKuEDpFYGrcZsgE7dYKi1FyUI5sbfD2e5pav
         2vvQ==
X-Gm-Message-State: AOAM531EoPNcPZ6luUOgncRlWdORmEzUdyr1kYAITLyeVYGJn43UAw0j
        Z8R4LDomyKuHvyjPKEWjFxI=
X-Google-Smtp-Source: ABdhPJzMy+yWRIRNkHTk1RCYZRyY0+b9LlR7tq95R7QTH1YZgdH9euujbyRqArU714Yh2EL+jvrcKg==
X-Received: by 2002:a37:aa4c:: with SMTP id t73mr26395487qke.79.1621789961284;
        Sun, 23 May 2021 10:12:41 -0700 (PDT)
Received: from smtp.gmail.com ([2804:14c:73:9a01::1003])
        by smtp.gmail.com with ESMTPSA id n18sm9115529qkh.13.2021.05.23.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:12:40 -0700 (PDT)
Date:   Sun, 23 May 2021 14:12:37 -0300
From:   Lucas Stankus <lucas.p.stankus@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: iio: cdc: ad7746: extract capac setup to own
 function
Message-ID: <b637a5ecde4e5f9f927a5b104332378d4721c91d.1621786036.git.lucas.p.stankus@gmail.com>
References: <cover.1621786036.git.lucas.p.stankus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621786036.git.lucas.p.stankus@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Refactor the capac register write logic to own function.

Also fixes the following checkpatch warning:
CHECK: Alignment should match open parenthesis

Signed-off-by: Lucas Stankus <lucas.p.stankus@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 36 ++++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 367a5990ae35..4221312f0a32 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -209,6 +209,19 @@ static const unsigned char ad7746_cap_filter_rate_table[][2] = {
 	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
 };
 
+static int ad7746_set_capdac(struct ad7746_chip_info *chip, int channel)
+{
+	int ret = i2c_smbus_write_byte_data(chip->client,
+					    AD7746_REG_CAPDACA,
+					    chip->capdac[channel][0]);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_write_byte_data(chip->client,
+					  AD7746_REG_CAPDACB,
+					  chip->capdac[channel][1]);
+}
+
 static int ad7746_select_channel(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan)
 {
@@ -224,17 +237,11 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 			AD7746_CONF_CAPFS_SHIFT;
 		delay = ad7746_cap_filter_rate_table[idx][1];
 
+		ret = ad7746_set_capdac(chip, chan->channel);
+		if (ret < 0)
+			return ret;
+
 		if (chip->capdac_set != chan->channel) {
-			ret = i2c_smbus_write_byte_data(chip->client,
-				AD7746_REG_CAPDACA,
-				chip->capdac[chan->channel][0]);
-			if (ret < 0)
-				return ret;
-			ret = i2c_smbus_write_byte_data(chip->client,
-				AD7746_REG_CAPDACB,
-				chip->capdac[chan->channel][1]);
-			if (ret < 0)
-				return ret;
 
 			chip->capdac_set = chan->channel;
 		}
@@ -478,14 +485,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
 		chip->capdac[chan->channel][chan->differential] = val > 0 ?
 			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0;
 
-		ret = i2c_smbus_write_byte_data(chip->client,
-						AD7746_REG_CAPDACA,
-						chip->capdac[chan->channel][0]);
-		if (ret < 0)
-			goto out;
-		ret = i2c_smbus_write_byte_data(chip->client,
-						AD7746_REG_CAPDACB,
-						chip->capdac[chan->channel][1]);
+		ret = ad7746_set_capdac(chip, chan->channel);
 		if (ret < 0)
 			goto out;
 
-- 
2.31.1

