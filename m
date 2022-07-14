Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3D257528A
	for <lists+linux-iio@lfdr.de>; Thu, 14 Jul 2022 18:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiGNQOU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Jul 2022 12:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiGNQOP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2022 12:14:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333661710
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 09:14:14 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a9so1776554qtw.10
        for <linux-iio@vger.kernel.org>; Thu, 14 Jul 2022 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Q1rOEGSDk/MdGe+KKgrYeB7dlxzQOSbkzC7u5rM1Wc=;
        b=Dx7H4mPpGm5SS1i66ZMaq3PN7ZeJq4VEN+s+/tKevX/QCZkEUBxCX7A7e9Ffek9zHr
         lNU2RDlxT4vw/jzXY4oXX8ImwzbmKyX2/NiUIuCuTqBaNPpaQXTWX/ayJ53mxhw2IZgX
         kdjdmNQ4gKjLu96LTpjJ0CQjYIulOoNuflLAoyMeoPGEuKKy6IEGUDUaVORLQSU6Cg8v
         Uhsblg/I+njVq31aFqs+a1IJ2R7rKH3sOJRpE3qrlplmgcOKAWx2zKrmhwPaSy7n8TZA
         P+PenRYSsDIwDuvhVZzZVoDDvwCaZnvqejcd44U5y/DGUwugHs3r8uY2FgdUiFT6zUeP
         WO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Q1rOEGSDk/MdGe+KKgrYeB7dlxzQOSbkzC7u5rM1Wc=;
        b=zWhJTGDm21vaqoUCKRzYZYg23NUWZVPTVRXpikWEYrM9fv8gSsppRGc8D0DKGvRDqB
         ioocKJw7fIM59sRlS4nTLnaFiGGpUv0B8r8N2WRL+TYrmoEd/dyyZOqMPusYtEAttOCU
         v45kVKRFkkpvavhoZIAiK/Kv4Rrvt/ZEyXg3Tgz0lgRDis1x7ndAAkR2jWViV3Hhm6Je
         Td1PmhGcd2/kXBSms1EwaxuXVXPGLN+BNB1DYsDisKDCzXT5qRkeqHx0+SoQV9Auwad/
         wj0RxFWvEXZzRGu5jzh7PVFMyOQMvomnGvVOTaZV7bBEh+oWqWkP0MTQYDuo2sAAFHLw
         WcLg==
X-Gm-Message-State: AJIora+FREDNGgBY6gdm0rg23oINkuAuOrBYpF5lP5M+1bXFVyb/rqQu
        5UyHYNVxFGMG8qh08zJxZlmoKg==
X-Google-Smtp-Source: AGRyM1uTqE6ZqqqpvevdUWlxwbWLNpzg19xTmvBiXDFlKIjlwuUkEjG7pVKK8g/owLabK3CfqMk0Fg==
X-Received: by 2002:a05:622a:1ba7:b0:31e:c153:646b with SMTP id bp39-20020a05622a1ba700b0031ec153646bmr8550357qtb.283.1657815253836;
        Thu, 14 Jul 2022 09:14:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0031eb393aa45sm1690067qtb.40.2022.07.14.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:14:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/4] MAINTAINERS: Update 104-QUAD-8 driver maintainers list
Date:   Thu, 14 Jul 2022 12:07:15 -0400
Message-Id: <53ecbe49e48dd142fc19f6436fdbe5b8573c5f9c.1657813472.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657813472.git.william.gray@linaro.org>
References: <cover.1657813472.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Syed Nayyar Waris is no longer available for 104-QUAD-8 driver
maintenance. William Breathitt Gray will continue as the 104-QUAD-8
driver maintainer.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bb95b27f418d..22302d3bd7e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,7 +299,6 @@ F:	drivers/gpio/gpio-104-idio-16.c
 
 ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
-M:	Syed Nayyar Waris <syednwaris@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/104-quad-8.c
-- 
2.36.1

