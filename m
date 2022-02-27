Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80EA4C5CA0
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 16:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiB0PoS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 10:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiB0PoS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 10:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 838D94248D
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 07:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645976619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=smOWqrVZ4eE9JROh4nQ4evf5L+Z1zd/JgqN0UrYlquk=;
        b=Yn+7viEH/ujy6f82tWRnwzQKav9zw3enRazDnT1uEg1SnOu81MkxGCf668+g/3MyRkPnsw
        WvukC9Vci6IYYjH2Sba/ak6AK1ZieERqszXNnaND7bfYx3+Nuj3M0OZTE3AHIqxotuE/mx
        3jf4ha6NQxUyX0NLM7/yut3eNvjk15s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-7tCvGng2MVqG-oKxlj1CRg-1; Sun, 27 Feb 2022 10:43:38 -0500
X-MC-Unique: 7tCvGng2MVqG-oKxlj1CRg-1
Received: by mail-qv1-f70.google.com with SMTP id k6-20020ad45be6000000b0042c82bd64deso9987760qvc.22
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 07:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smOWqrVZ4eE9JROh4nQ4evf5L+Z1zd/JgqN0UrYlquk=;
        b=1h0ebRRoniGp/zUMTVkAYURmA8EIuy03sUGCSFfYsPNUf6IhF/dLc0Aqm9OqTNn/xL
         CQ9ArluvEdco3xzjnhWDNIm463tSfSmcK+k8xh7Bkey11ed4xTl1JBpxYRcHcmsBGM6O
         H5Sc6xr4RAhAyDlCEgZ5TpeN81FlORONUpgDFBtfpZROJ2+e7ZVhyTRflepG85vdn6kh
         YMgeKBhLGh1G7bhHtWbGkdOQ9XVnpxUW9pS6xARnTEw0OcqF0KkteRG1p3jTDWY5rDWW
         jQmll2BccgEdVs/XUZybuKWSTFkSSGAk8BPTcHaNVhobbHSW+qAp0S0xKwliykzW97wR
         OeGQ==
X-Gm-Message-State: AOAM5314gzsIdx2nXxFa3FaCdbU15aJDWmvlKh/LQlpCJ+6ZV28n0D+I
        4hKQ+LdJ3co8D8fsLr2KH5Bp+UlHJaxQgICKYBiJ3ZOETWDvOohuVfHgMEi4dGbWyypAq5EkbV2
        m/AbqMYJjqCzo171rdOsk
X-Received: by 2002:a05:6214:23c8:b0:432:e64e:969a with SMTP id hr8-20020a05621423c800b00432e64e969amr5260652qvb.109.1645976617585;
        Sun, 27 Feb 2022 07:43:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWzeFRSiG3cOIAwp97dJ6GYhZ7NMFr89QVxs3UHGNUewDKGBxEIr1Lw8iFumUGLWe3rqDY1g==
X-Received: by 2002:a05:6214:23c8:b0:432:e64e:969a with SMTP id hr8-20020a05621423c800b00432e64e969amr5260645qvb.109.1645976617352;
        Sun, 27 Feb 2022 07:43:37 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87f53000000b002dd45d67a8esm5104596qtk.59.2022.02.27.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:43:36 -0800 (PST)
From:   trix@redhat.com
To:     roan@protonic.nl, jic23@kernel.org, lars@metafoo.de,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: scd4x: check return of scd4x_write_and_fetch
Date:   Sun, 27 Feb 2022 07:43:31 -0800
Message-Id: <20220227154331.80338-1-trix@redhat.com>
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

Clang static analysis reports this problem
scd4x.c:474:10: warning: The left operand of '==' is a
  garbage value
  if (val == 0xff) {
      ~~~ ^
val is only set from a successful call to scd4x_write_and_fetch()
So check it's return.

Fixes: 49d22b695cbb ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/chemical/scd4x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 20d4e7584e923..b978330fb761c 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -471,7 +471,7 @@ static ssize_t calibration_forced_value_store(struct device *dev,
 	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, sizeof(val));
 	mutex_unlock(&state->lock);
 
-	if (val == 0xff) {
+	if (!ret && val == 0xff) {
 		dev_err(dev, "forced calibration has failed");
 		return -EINVAL;
 	}
-- 
2.26.3

