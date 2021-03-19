Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98502341AA6
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 12:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCSLBs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 07:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhCSLB3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:01:29 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC78C06174A;
        Fri, 19 Mar 2021 04:01:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id u19so3426329pgh.10;
        Fri, 19 Mar 2021 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHsMXHlvFNbqoAQhdtfNE0zKBykgUvZF86//Vvt93y4=;
        b=uRIytIxxH0fuSwhbhHS6b4YfjvyuWeiqfnWivka6MFy9ceMr5uyzm+sQ3oPn0ZAMox
         +fCxTTZuLgrukUbOZpVNuNzprxd3A8676IqPEloktxufGhRUXDhFjlc9IgQ48zOWUny5
         kSUL9qKC3IGQhQON4sjpQd5ucTuEpLUDhp+LzAH0JHTQJS2JXK1IJvGF/laM7UuxVGD4
         Mqk3d/EIrtX1uRUPQqhJMLxnN0zNLYN2cC5rRh9zS+AjkqKn3T2DDN7tGNJcachGYUVF
         44J6hAorf3/jy4z1Q2/WOetkupBcJktiZhzlrltpm3j5LMY3P0RsPxFdMSHJ9tqPenuV
         GnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHsMXHlvFNbqoAQhdtfNE0zKBykgUvZF86//Vvt93y4=;
        b=VNILSE4cAIKQnnFNyJakt8Lk0CSuL6HpFofVW+kOXVsJA1O8uhouqEgYSGAFvYb3cs
         ZAxDvLZFm204z31wvWO+GETRT/uinYsgMxoLwnATeO09zlCS34vuy/pvF9d9PCnGTCmI
         rDDOAsiAURx92zNiDpYjenWmO+HzwUYDZQDEYFGx9u2c2p1pFv5hnscDMVoYW2baYeXb
         n+Wd9H8HzR7armt0seLv/AM3c24eN2YMBwVyxY/YxrllkgqUNZF+o+i8NB4HGnxYFTxw
         opN+9VRfIheb6H7EOg7k+PMaHWZArX0ExJaeVBlAXPF2TGLZXGqAUxWuoOL/9NNMfhqr
         66Ww==
X-Gm-Message-State: AOAM532Xq8+i/EYkxfne65jhY32OYAQKEsx0isCnmwHBJMWZiFkd3MW2
        JYtWuufvGucaDds5faoboNk=
X-Google-Smtp-Source: ABdhPJxSWirRoocy1cgAXwgyeqnrSHox94o4V8L5k6ly6ZQmLV2G7nSUjtsEllB2Jw0UZ7t0/O3OyA==
X-Received: by 2002:a65:4942:: with SMTP id q2mr10660452pgs.34.1616151688818;
        Fri, 19 Mar 2021 04:01:28 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:01:28 -0700 (PDT)
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
Subject: [PATCH v10 05/33] counter: 104-quad-8: Annotate hardware config module parameter
Date:   Fri, 19 Mar 2021 20:00:24 +0900
Message-Id: <203f1b6084ed86a6696eb422bcadc0955c6427bb.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
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
2.30.2

