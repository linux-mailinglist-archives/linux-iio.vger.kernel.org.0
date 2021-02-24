Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D307332414D
	for <lists+linux-iio@lfdr.de>; Wed, 24 Feb 2021 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhBXPqM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 24 Feb 2021 10:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbhBXOqm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2021 09:46:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1547C061794
        for <linux-iio@vger.kernel.org>; Wed, 24 Feb 2021 06:42:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c7so2126482wru.8
        for <linux-iio@vger.kernel.org>; Wed, 24 Feb 2021 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RlLY69dl0FNKKcCh7g/+fwlPd3uLKJlhP5Zykbo8eos=;
        b=mPYPZVu/FfUNUfxpNy7RV3MqNsdIWmrMQYP8/qAU8NR0URMVo7rV/JNEYEpXp9v1X8
         EpRvph7XIQGY2L56Q/ouJ3UbI09/HlGmhzxVEXpjZur9VVbpXaZszc8gWsQZtllzQS+k
         LoMdCAGpXKpjAe30zFN6pD/YdMxTJ9oRzEp61cmHfRx51M+M7GrZVmhQSAFA/wi2tjQB
         NotVbXtcnDwdQBHUrVKkgjo8QHAFG1AmG0sYTeDoebk9N+4ZhQPxcfjzQU4EB85lYVi7
         I0hsnfMNRHdtX2DJNyuICQjF4+AwdmZVr8NLj1moHdpr3EE3QJ/quccOfqj8BwvImcza
         NVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RlLY69dl0FNKKcCh7g/+fwlPd3uLKJlhP5Zykbo8eos=;
        b=tomPr/AzdW0HVe3A3jP+KcMtJRQtMNvrxA7LO0GeBR3Zgo80xCp7f8A96+7BPGtKEl
         aAu243U/OijOyDr7Pt2tu7f6hUr8E3IgKhqwpoKbLfPCmjI+BAqRJ8GLQN9gD7pB6UAr
         jIVvG5ialzNVXx8ZWhcc4GNOcurOBEGExG29DHhSFRKcvjpFjiqQOOLgH6Jww4JK1Fbf
         d79YpJGUgjccGqWDuF7hsKo1ppNGmMvvJc96ZB6/tcHt2DkwrpoM54urVWXFXe8ohWut
         Mshyini7+KUi+fo+q4uLa/Bvb0UwTo2pk5HMHeb9tXHRED1+hBA9LonkXD4FCRQBxb0q
         XEWg==
X-Gm-Message-State: AOAM532bZRELwWhlU5iJI2inH7KtGCmCENOMvgz9tQ2YqY7rhxPXXxqI
        /pUBrFnxptacXyH4gohgPrSFlCTQh0at7Q==
X-Google-Smtp-Source: ABdhPJwcXbOVFQ7pcprfedminlYKezPtRgM8WYzRegU/uPGj0NJQ8H65qUeZOEh+uRBtDy+jVjsO7g==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr529839wrw.277.1614177757504;
        Wed, 24 Feb 2021 06:42:37 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-157-252.adsl.proxad.net. [82.252.157.252])
        by smtp.gmail.com with ESMTPSA id p3sm4170669wro.55.2021.02.24.06.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:42:37 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org (open list:AMS AS73211 DRIVER)
Subject: [PATCH v2 4/9] iio/drivers/as73211: Use HZ macros
Date:   Wed, 24 Feb 2021 15:42:14 +0100
Message-Id: <20210224144222.23762-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224144222.23762-1-daniel.lezcano@linaro.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

HZ unit conversion macros are available in units.h, use them and
remove the duplicate definition.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Christian Eggers <ceggers@arri.de>
---
 drivers/iio/light/as73211.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 7b32dfaee9b3..3ba2378df3dd 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -24,8 +24,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
-
-#define HZ_PER_KHZ 1000
+#include <linux/units.h>
 
 #define AS73211_DRV_NAME "as73211"
 
-- 
2.17.1

