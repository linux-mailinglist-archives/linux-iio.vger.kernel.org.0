Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63852453B3
	for <lists+linux-iio@lfdr.de>; Sun, 16 Aug 2020 00:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHOWE0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Aug 2020 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgHOVvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2020 17:51:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C1C061388
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2020 17:33:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x25so5347737pff.4
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2020 17:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1jIv0RVsh8QFJKNNGoBmL/qTETkSqOi/OBQJ3ZeiJk=;
        b=RR46SWN5SZ1DhXQHb5Pda5dg70Uzl3YutEI7aEX5/NJL/JMIZfQvgpP2waOM1/lnnG
         vY7DEj4/D+x3IhYt9CvKCMILtiIHNZPJ9bQ5KEDhUg9s9CY8sdHZ5WSDfmOj/BIKLC3w
         pOnDgyGVRazXNfW21IVa3vcspv3t3Pb3O5Pm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1jIv0RVsh8QFJKNNGoBmL/qTETkSqOi/OBQJ3ZeiJk=;
        b=CYW6fPuILGOmHpGIYN8BF9Hxev/+JbBoD8ihFTDDmvm7JZ4hJE2eBC1Jw3Oybbwlx6
         Bpz6XWcaDs3YKTGaONGbmftVUDkPuhnjfEVawd5C88sqx4GSYwEkjJfVJSwq73Q/ouMf
         R10yONoO2/hat3SprsM1h9zxg36F+4Vb+w1bjV+KJfz8zsI5P6N0H/M74FWtnFOAzFSL
         gnWl3kVJmc9qIK723zE5KWW3qzVujIjBvFWM2MwgeQRLeJVsg2G7fBSSAxA/Eq1JrW2P
         VRZXid0fYrEhLxVWtZahWQVR2yUK2RiEffNVHMMo7F0vDcz1Zd3URMxtm+eqxXg8mu4K
         DqpA==
X-Gm-Message-State: AOAM532G7n3oAORjaecARyoB4DvPRaU+GnLnYugE4GeRSN8RgsQKY4ou
        RbJp81XPVhpRwmBHq2014mAeUYkM56HRAKgO
X-Google-Smtp-Source: ABdhPJxYVoX0M363jvtDkKljhn5EqHyfltmzlMN+2VKtko6YkU3dQt+S7wmIjGM470458oJr8jBSRw==
X-Received: by 2002:a62:6083:: with SMTP id u125mr3632348pfb.286.1597451615679;
        Fri, 14 Aug 2020 17:33:35 -0700 (PDT)
Received: from localhost.localdomain ([172.58.46.233])
        by smtp.gmail.com with ESMTPSA id k12sm9224817pjp.38.2020.08.14.17.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 17:33:35 -0700 (PDT)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: health: max30102: update author's email
Date:   Fri, 14 Aug 2020 06:49:41 -0700
Message-Id: <20200814134941.10576-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update email to author's current employer

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 9b47d9472a4f..bb504e993f19 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -2,7 +2,7 @@
 /*
  * max30102.c - Support for MAX30102 heart rate and pulse oximeter sensor
  *
- * Copyright (C) 2017 Matt Ranostay <matt@ranostay.consulting>
+ * Copyright (C) 2017 Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * Support for MAX30105 optical particle sensor
  * Copyright (C) 2017 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
@@ -632,6 +632,6 @@ static struct i2c_driver max30102_driver = {
 };
 module_i2c_driver(max30102_driver);
 
-MODULE_AUTHOR("Matt Ranostay <matt@ranostay.consulting>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("MAX30102 heart rate/pulse oximeter and MAX30105 particle sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0

