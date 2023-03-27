Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C926CA313
	for <lists+linux-iio@lfdr.de>; Mon, 27 Mar 2023 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjC0MJX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Mar 2023 08:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjC0MJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Mar 2023 08:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287843A90
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679918909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f6OgJqgpSNTTFYSUSudYbvVLpng6GaBH202qHK3zoFk=;
        b=ZoHRMPW3A9Dum9+UKxwjUf2zPa2SP9+GP5e8lje4agNmodEwSOc6OQVbDrg1FwV6GxTB/p
        4z2qiHoSisPM/WffzI35yW+aHJXfmgSYkyr+diCdvbPIVGLc15OQ9kXBGRCqKWCNpn9s1l
        1ZiA92Ao0PNliIribsgJE1JIUVdGGRY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-AhzUqywWOJ-Jg7Y9vFO0zA-1; Mon, 27 Mar 2023 08:08:28 -0400
X-MC-Unique: AhzUqywWOJ-Jg7Y9vFO0zA-1
Received: by mail-qk1-f199.google.com with SMTP id c186-20020a379ac3000000b007484744a472so3576924qke.22
        for <linux-iio@vger.kernel.org>; Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6OgJqgpSNTTFYSUSudYbvVLpng6GaBH202qHK3zoFk=;
        b=Y8RET2vgEikV/1yP6VMyJywhU6jU/67BbwpIlPKrT1p6muOPORunf5kUnjp2vqBolD
         QOPc86df6iGSkeIH+3xf8Aw3zx4mH4tVLcD417jcRqmM+Alp2bPYlccUmBABoruRLZMj
         d2RraZ+WfDQmZRgwSBrheT64AyMeWpKnaaJrp2HuJO6pscEPU0HjLH98x8hFGaKUDC0u
         K6GXezQHdFTMNQ7/nKl1UtuC8DbFavgXF1r6X2khEDYOZumWq51G//8W4V+eqvScSEVq
         kfxA5JLBJwPqlhkBN66onVi7gFeWyYnNGLSNlQAJooKCNe2gVTfNkKDqDcnX1CtUh0E/
         u/dQ==
X-Gm-Message-State: AO0yUKX65JThcyBQQkZ2d9G5Bou+Z056knl1nHOraMdI3o91yY/buN+w
        kv2y/AD8eXzgQxHLLG1nWim7XZw9r2uYjQBxgio+qKX+WWa9j7ELzldRVhdTZqs5sP12pHj2wfc
        P8DR2l7fzr1oLhu1ZMR8z
X-Received: by 2002:ac8:574e:0:b0:3d6:d1d3:eeb8 with SMTP id 14-20020ac8574e000000b003d6d1d3eeb8mr20398690qtx.11.1679918907441;
        Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyfOhpAFIIn4S3oaK+SRWKemSRvTcR5bSBOqlG0NAjA410/ztoUYY6RVRQVXHBhcaeImdxww==
X-Received: by 2002:ac8:574e:0:b0:3d6:d1d3:eeb8 with SMTP id 14-20020ac8574e000000b003d6d1d3eeb8mr20398655qtx.11.1679918907195;
        Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b007486052d731sm1396515qkb.10.2023.03.27.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:08:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: tsl2772: remove unused prox_diode_mask variable
Date:   Mon, 27 Mar 2023 08:08:23 -0400
Message-Id: <20230327120823.1369700-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

clang with W=1 reports
drivers/iio/light/tsl2772.c:576:24: error: variable
  'prox_diode_mask' set but not used [-Werror,-Wunused-but-set-variable]
        int i, ret, num_leds, prox_diode_mask;
                              ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/light/tsl2772.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index ad50baa0202c..c090405c2358 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -573,7 +573,7 @@ static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
 static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
-	int i, ret, num_leds, prox_diode_mask;
+	int i, ret, num_leds;
 	u32 leds[TSL2772_MAX_PROX_LEDS];
 
 	ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
@@ -590,13 +590,8 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 		return ret;
 	}
 
-	prox_diode_mask = 0;
 	for (i = 0; i < num_leds; i++) {
-		if (leds[i] == 0)
-			prox_diode_mask |= TSL2772_DIODE0;
-		else if (leds[i] == 1)
-			prox_diode_mask |= TSL2772_DIODE1;
-		else {
+		if (leds[i] > 1) {
 			dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
 			return -EINVAL;
 		}
-- 
2.27.0

