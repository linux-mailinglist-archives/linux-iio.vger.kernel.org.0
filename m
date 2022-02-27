Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D64C5D90
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiB0Qon (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiB0Qom (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 11:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C832147381
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645980244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V5Y+mhXtEe4aHWk4DE77nNDoAlUo3znM4yBU3KLbx5o=;
        b=EBxHSPtD//IkAnQ7z2F30xegi82EFj3JwEyFKo0ONrh4kgTvKZMeQY83tMgp8JfXlZP9xQ
        pgPyxD9aoEyWIJLxabNteJJ5imVlfTNIRlBLdqxXG4vIcRKa/TiDa1Ul3+MOtgI9RIOJET
        XvshUbjsvYWOAc+WhQkLtk/MF3cGMOE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-2RlAR1TKNNSh-jDYxOPDkA-1; Sun, 27 Feb 2022 11:44:03 -0500
X-MC-Unique: 2RlAR1TKNNSh-jDYxOPDkA-1
Received: by mail-qk1-f197.google.com with SMTP id u12-20020a05620a0c4c00b00475a9324977so9497713qki.13
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 08:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V5Y+mhXtEe4aHWk4DE77nNDoAlUo3znM4yBU3KLbx5o=;
        b=0pOpsfqNJTwIVQl3Fg/CC7tl4QCTZ8f6ni/uXtblYW9Q++LCNCVkhcPzYU7FWXda4I
         a5fNd+9fnFC5rLmYauQPAQDDMPfcXtnpvpaBAEAwf9sgz6zsQTmWpRyb2KDG+cfgyETL
         qR1Upue2iZMMLPDBAYM9RLHSL+58E4lMeg3lGUdghD98AEHyxyyWRDKlcgeAJOdsvqm7
         ORgON70ezGIWkliahAn/0vfwdXxAKxQWdOA3h+TxGJI4O3gJdcbH7VDziaOGyqUYbvUx
         oUHfeMtqZH9pLnLJPGcBa+uR25EEG8VlKp4kXQaz1nIzKM5JGD4NHEDWoGcuFHQ7gkmB
         xymQ==
X-Gm-Message-State: AOAM530/xVwBIUMV8VJ4bmKNzizH19RA34UZt3uuH6DTHC/05HZzXLXU
        CUhx6m+EdCHliDZAiT/ME+dNGZ7aebQF1qkISE5Z15RORli7jlpP3BVyMN8chIEue0zKIFt00Kd
        3l6L7Nh+Sqq+9m0nku/tw
X-Received: by 2002:a05:620a:1fc:b0:60d:d438:d628 with SMTP id x28-20020a05620a01fc00b0060dd438d628mr9489737qkn.388.1645980242783;
        Sun, 27 Feb 2022 08:44:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmEEmzM5eDcwZIwdUdPIYKMl5r3tEeMsKZSwUZGmeUMBHmHQtSkJ2w3iQrxB7UtVNBvR5apQ==
X-Received: by 2002:a05:620a:1fc:b0:60d:d438:d628 with SMTP id x28-20020a05620a01fc00b0060dd438d628mr9489721qkn.388.1645980242555;
        Sun, 27 Feb 2022 08:44:02 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w140-20020a376292000000b00648e88c1f05sm4010675qkb.67.2022.02.27.08.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 08:44:02 -0800 (PST)
From:   trix@redhat.com
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linus.walleij@linaro.org, ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: adc: mt6360: strengthen return check of mt6360_adc_read_channel
Date:   Sun, 27 Feb 2022 08:43:57 -0800
Message-Id: <20220227164357.84742-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issue
mt6360-adc.c:277:20: warning: Assigned value is
  garbage or undefined
  data.values[i++] = val;
                   ^ ~~~

val is set by a successful call to m6360_adc_read_channel().
A negative return is checked but within m6360_adc_read_channel,
a non zero check is done.
Strengthen the check to non zero.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/adc/mt6360-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index 07c0e67683910..9fb6dc305a392 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -269,7 +269,7 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 	memset(&data, 0, sizeof(data));
 	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
 		ret = mt6360_adc_read_channel(mad, bit, &val);
-		if (ret < 0) {
+		if (ret) {
 			dev_warn(&indio_dev->dev, "Failed to get channel %d conversion val\n", bit);
 			goto out;
 		}
-- 
2.26.3

