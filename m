Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BB67A378
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jan 2023 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjAXT6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Jan 2023 14:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjAXT6b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Jan 2023 14:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E36EAE
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2023 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674590270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Czuty/IXmZh0Ej+a6tXx+TzxJZ0sK5TjGVX3sprTlhc=;
        b=GG1evi+N8vsJACv64rzq/Sp2qufqfRfe2SPG1zL2DnfCSlgzgV6j61mwQY6eQPlSVKPv2q
        ExkFAAhTe61cFF+t7MdrvBpsoQ0FiOjkNk5NKftnCVdQwttUVomHRTKtHYi1Su/4g5kja7
        Bim1gTTSMx1fOdyqLqkI0nrjYTSTndI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-9WxBmFLeM5-Z2z4MkZOOvA-1; Tue, 24 Jan 2023 14:57:49 -0500
X-MC-Unique: 9WxBmFLeM5-Z2z4MkZOOvA-1
Received: by mail-qk1-f197.google.com with SMTP id x12-20020a05620a258c00b007051ae500a2so11654197qko.15
        for <linux-iio@vger.kernel.org>; Tue, 24 Jan 2023 11:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czuty/IXmZh0Ej+a6tXx+TzxJZ0sK5TjGVX3sprTlhc=;
        b=rY89w4F3LRrFtPYVlmlFlf+n4zsFGShYY8JodBwaF6wBMNtvYXstVkM+ItEguJH7aF
         vyMu4FCrCJ1pHWtUZI+N1rZmlIe1JI9hVjjJLHOc0pXq4DwR3HKfzyfu585o/vyA3GDG
         nQKFgVLMjoANTkwh49Fy6UPxQ/Yk/OC2OHcwvFi6g1sdXxwyP44AbAt6I1CuozRMJiJx
         WXAsi50h3jEUGTQ3iasrgaixFVBgOSx9DNTnlPF3JC0o2nSrwqRdqNH/L9QU8QAfL46/
         BkY412H7NiWLmUjNLMmY4Bt+ZogC1lrsoRmDevCPuGjgb+/orHJn7K4sXkjCz39hGKX6
         WA7g==
X-Gm-Message-State: AO0yUKUgApCkVou9aMYbVMT3hVDXn197R0yjAMR3uUrR8iEfQFv/yMuA
        0VqjvtaT1EoCa5XHsVikYuiN3shHJqFruNGUS6CyRxcxJ3BtSBYoXiBwkeq64PSPYf6XLteHZ0z
        5fFfyvaUWNLNyKNSp5J7H
X-Received: by 2002:a05:6214:459b:b0:537:6e23:f350 with SMTP id op27-20020a056214459b00b005376e23f350mr3160693qvb.31.1674590268610;
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
X-Google-Smtp-Source: AK7set9kKYBDFdSjmr+lGrxgWaKhFEYSXIS1MBxhMFZ/vCcevsONki7kxiyHr9fwQS2F+JNHi11TBg==
X-Received: by 2002:a05:6214:459b:b0:537:6e23:f350 with SMTP id op27-20020a056214459b00b005376e23f350mr3160672qvb.31.1674590268414;
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c38-20020a05620a26a600b006ea7f9d8644sm2012405qkp.96.2023.01.24.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:57:48 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, andrea.merello@iit.it
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: imu: fix spdx format
Date:   Tue, 24 Jan 2023 11:43:01 -0800
Message-Id: <20230124194301.656518-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

checkpatch reports
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
FILE: drivers/iio/imu/bno055/bno055_ser_trace.c:1:
+//SPDX-License-Identifier: GPL-2.0

Add a space

Fixes: 2eef5a9cc643 ("iio: imu: add BNO055 serdev driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/imu/bno055/bno055_ser_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bno055/bno055_ser_trace.c b/drivers/iio/imu/bno055/bno055_ser_trace.c
index 48397b66daef..ab564186d19c 100644
--- a/drivers/iio/imu/bno055/bno055_ser_trace.c
+++ b/drivers/iio/imu/bno055/bno055_ser_trace.c
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 /*
  * bno055_ser Trace Support
-- 
2.26.3

