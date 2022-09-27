Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9085B5ED073
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 00:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiI0WyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Sep 2022 18:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiI0WyJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 18:54:09 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2325B6D1D
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso7219455otq.1
        for <linux-iio@vger.kernel.org>; Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FABGJYCg3ML5damim2lrDVnvSH7cs9gN7anGIiw2miY=;
        b=KYLRla7aDnN2wRrqTO6KznEiaHoXVbwq3uDT4QhGcRcNppVEti4QTVI5pbd+4KLDMc
         IuT/7/diP06j3IMOdtX4shrhYTUmoVwNzQBK4r0fbZIPyiVcrLSRfqet/R7Pu8KNyhtn
         lD2tyL4RXhkg0026erfE4FmgFqtK26if9VH7UUtPn/Q6hexEI3QIE3VRsGzX7RMWwAMS
         M5mIb0qLX83a6oSSFRZW2sK8bH4BOQV7ezsX5ubn99rd1dACcHGCGZf96rjovWlDvPKL
         ltfb5ChnJVVz0GIJlpgfTmQuO6AgwJN0AgvFyJwFex04LH7kYFHuko506NlUcaHJcMjz
         RpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FABGJYCg3ML5damim2lrDVnvSH7cs9gN7anGIiw2miY=;
        b=N13iz03b5rirozKV1pqISEJmBo3mrDki6q+P1n6+5Uu40+/6XE187xqD7UoerrectL
         BHbp/ikhb7amdfFRlqar7vWcNUNIvb2+WN7/NkvxNJmZ/z0yJnPkNR3tVyDYEWjJMjFR
         I5iJFWRWzdnJCFcWo0VVhJmlEn1YoEHrIHOeFY8qygL45yxEyfNNTTMMkt2hQ01qSMNd
         B/mftiz6egU2sd+/Ep1GsSqVAsvuQnyVVWVEvS+QaAz6lPGlSc1xtLYqFYhzLYMXPHr6
         9fk+mn2JBhiPBo+8vz3rH5XcuNXYRu4J5z2e8K155yfY+dng+dfBTVW45oe+KdCLYG6z
         dUNQ==
X-Gm-Message-State: ACrzQf1FK7UYq2ihjReYYxud07EE7JoiBFdMg4NAgVhP8TUAVE18FqqI
        PfLD59PveScoCL5Tia94KElZHQ==
X-Google-Smtp-Source: AMsMyM4/MYi36gmiNKFEawuClnRfbQKVdX5Hyt+75WAoVzUCyY14nDCQNUfNc+1bGsk6lK8HO2Z5Jw==
X-Received: by 2002:a05:6830:4129:b0:658:772:afe6 with SMTP id w41-20020a056830412900b006580772afe6mr13128911ott.307.1664319246318;
        Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v186-20020aca61c3000000b00350c5d946casm1188965oib.4.2022.09.27.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:54:06 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 01/12] MAINTAINERS: Update Counter subsystem git tree repo link
Date:   Tue, 27 Sep 2022 18:53:35 -0400
Message-Id: <075c91bb0af32d27a139112701b12b118a50edd6.1664318353.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664318353.git.william.gray@linaro.org>
References: <cover.1664318353.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Counter subsystem git tree is now located on the kernel.org git
server.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..d4999f68bda8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5289,7 +5289,7 @@ COUNTER SUBSYSTEM
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-T:	git https://git.linaro.org/people/william.gray/counter.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git
 F:	Documentation/ABI/testing/sysfs-bus-counter
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
-- 
2.37.3

