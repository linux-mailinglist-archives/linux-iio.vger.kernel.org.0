Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F43435F18
	for <lists+linux-iio@lfdr.de>; Thu, 21 Oct 2021 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJUKht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Oct 2021 06:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJUKhs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Oct 2021 06:37:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8CDC06161C;
        Thu, 21 Oct 2021 03:35:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q187so1791834pgq.2;
        Thu, 21 Oct 2021 03:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S42YA9E6qpGmlASfzaYHN3PZsTWoN0dAK517P7u1Vp8=;
        b=bPsKp2eZ0fO6Hjivl7iRuE404jA+SLd3I2lEwsPw7LCljN+hlP/+zmoUlgYwtk6GGD
         mv/PsO/w97+UZKrJqWlZyt/Hg17ZsGoScv2lhR+o6gkHSa/FLumGNbOwRND2qq20in80
         c2zBqsi6/66AtQizaBkVNw6uEmG6AFs5VqBUMajKCZIoW9HUcDeOQxLtDmCG5CPWplFz
         s2/FPVzYd1rKWRiMK1rPe8UZ+D8gI7x9x8GQ/0hZxJ+Cr3QgKpsS/dikSnsoRYv7dc+w
         T9/QlT/oBSVMSxISYKEVn6tiEzVLxTT/UCeOjz3WeUV3nRE5WuPWl6FT2yOdCDQLtmmt
         AGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S42YA9E6qpGmlASfzaYHN3PZsTWoN0dAK517P7u1Vp8=;
        b=zdcbTDmi+Aga9l5GiNG855438IbDWZNQR66U0pPLKibvAaNfQixgjxlg0SiA470FeG
         e/b25Wp96rjsdJMNdITznkuS8rERMfc+0HIWTbDNrrg2ccHIUJ2/sRyBYcFiCM+bJydb
         Hd+oVMvUOSfL6ohS+GBauyVKbavroqoi86G99gIf9VqDwYZbWAvbfxPPoVy57fmoTb5q
         oV7Df4/w+UHu4kG7pywxIrWBu0DBeGMhsi8ZVRV9IDCKH+oMac7q9BHcq+rHzdO92nL6
         zHzt8TCkgeDQIZ0mwqu2mi/mu0DVJRAO4IMwjeQxuIysLgua9Tk9wSYeBG4igCBLp/Ex
         xWGg==
X-Gm-Message-State: AOAM533SPr+TvhQs3rlAaTgQd7phQYsopToAx+cNr3oSvXACqkAiLfZC
        phMjBvXu25FcmYiaVHJjua3V9er9rus=
X-Google-Smtp-Source: ABdhPJyvWshVqzE+Sqkr/EOufBaUe8CJF35np8Ur2No3Mc8YfLnoK/EafDXJ6wV0vPMKk9LZIczKkg==
X-Received: by 2002:a63:b007:: with SMTP id h7mr3686634pgf.443.1634812532309;
        Thu, 21 Oct 2021 03:35:32 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i12sm5464024pfo.126.2021.10.21.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 03:35:31 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] counter: Cleanup lingering atomic.h includes
Date:   Thu, 21 Oct 2021 19:35:14 +0900
Message-Id: <20211021103514.955622-1-vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

With the removal of the chrdev_lock atomic flag, the counter-sysfs.c and
counter-chrdev.c no longer needs to include the atomic.h header file.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/counter-chrdev.c | 1 -
 drivers/counter/counter-sysfs.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index b747dc81c..0c8261358 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -3,7 +3,6 @@
  * Generic Counter character device interface
  * Copyright (C) 2020 William Breathitt Gray
  */
-#include <linux/atomic.h>
 #include <linux/cdev.h>
 #include <linux/counter.h>
 #include <linux/err.h>
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 8c2d7c29e..67a988851 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -3,7 +3,6 @@
  * Generic Counter sysfs interface
  * Copyright (C) 2020 William Breathitt Gray
  */
-#include <linux/atomic.h>
 #include <linux/counter.h>
 #include <linux/device.h>
 #include <linux/err.h>

base-commit: 8135cc5b270b3f224615bdee8bd7d66afee87991
-- 
2.33.1

