Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21F332690
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhCINU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCINUh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:20:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88037C06174A;
        Tue,  9 Mar 2021 05:20:37 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n9so7794265pgi.7;
        Tue, 09 Mar 2021 05:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGsMq/or5LrbS6jzzwVkZSD8zHMbssCRETsq5AlmHhk=;
        b=BF2JeSQcBj5jKUajNNhfuC3RoAx40evJrNJ4jcEXKRuM8WUBWCil6hP9b89RjeqSjF
         iZ3CxQf0Cb6OS5BbtCIonpLqvfb4F4SNvpGxRZV6tUojZBRM9sVIuLyq0Lj9P/ktOram
         /8kPcJ3OWmvbqzak0914vmxbQn4e+V0D4Wbe9zJcrlQgXsd8wjBx9qPUjRBgGPJnnig6
         o6qyI2qyS77Oj9JBLyYKJJMiS8QZt2WaAMYoPuL6xFot8HvZGMGi5OI4lYh7AalKKfba
         ehY87TN+zKbUk6LJ4nErVtbaQONWCO/flWpdZ5CFWStInUtpqX+UrKEgDecCz27TXZes
         azuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGsMq/or5LrbS6jzzwVkZSD8zHMbssCRETsq5AlmHhk=;
        b=f8l9wADLuKFYny00VE49jxdq7PZ7iPkzc+d+G4YJA0DyGXGLij7mVI/fKfVNEsh8jM
         mljAgYOhVCcvBYRcNdNCFAJeWNNhNIG3JENGUJUg5odKWcDZBj7SkgEvdosLqxB+CrOk
         H3BnTttRB9MquZtRRGPSPWdEPWV8z7golYIy2ngO5RbRHEZ/18ht4Y9eK5wZHHt2a3N5
         084ZqBVWY/sHnzyeD7y9dtWLKyEylZ9dRIu7uL5Jh8JMDhxRjZ/L6WTtc6UIV2IbJNx6
         Py1vO6vQaGHVD8kOI/76ZHN1p6Gi54SWvVnBYok4BGeRrpem2iiUQpyzy8jK3eL0UmBJ
         c6Zg==
X-Gm-Message-State: AOAM530duhc8KrxzKh2xBWN9zGKJCsM8DIDtxFzZhRwLTH5sY5wKK+Tu
        Jx59ZkDlp/pOpp+jLPblfq8=
X-Google-Smtp-Source: ABdhPJxYMcx8TAwzEMsyNljEGsxrjAzaeLrqUb84oaUmvtU0ci1sM9AnHXfbQ8l6WsU4z40xxM0RXA==
X-Received: by 2002:aa7:8d05:0:b029:1ec:b460:f21d with SMTP id j5-20020aa78d050000b02901ecb460f21dmr26014314pfe.29.1615296037168;
        Tue, 09 Mar 2021 05:20:37 -0800 (PST)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id y9sm7647421pfl.201.2021.03.09.05.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 05:20:36 -0800 (PST)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v9 05/33] counter: 104-quad-8: Annotate hardware config module parameter
Date:   Tue,  9 Mar 2021 22:19:18 +0900
Message-Id: <97bee75c6b792f49e0b6331c922bd944591206ec.1615293276.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615293276.git.vilhelm.gray@gmail.com>
References: <cover.1615293276.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates the 104-QUAD-8 driver.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 233a3acc1377..0fd61cc82d30 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -21,7 +21,7 @@
 
 static unsigned int base[max_num_isa_dev(QUAD8_EXTENT)];
 static unsigned int num_quad8;
-module_param_array(base, uint, &num_quad8, 0);
+module_param_hw_array(base, uint, ioport, &num_quad8, 0);
 MODULE_PARM_DESC(base, "ACCES 104-QUAD-8 base addresses");
 
 #define QUAD8_NUM_COUNTERS 8
-- 
2.30.1

