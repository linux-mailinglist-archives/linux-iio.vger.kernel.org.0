Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F27F3D3731
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhGWISF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 04:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhGWISE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 04:18:04 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC6EC061575;
        Fri, 23 Jul 2021 01:58:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m38-20020a05600c3b26b02902161fccabf1so3062964wms.2;
        Fri, 23 Jul 2021 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOYS6lb1YTBxNzPbGghn1dFCSuBt5y4qx5FjzOqrB2U=;
        b=OFJp59TijOVSJVGsghbtjcUqq4pOKTeS4befrO0MM/RIEHeFH25xRI14d/88pNsj79
         qykkx+VoqJ8bUWNxULlvu5Icf+yikKNgfclUDQXUEQea27Hu/Le/yc5T/Fs/XwXLZ59M
         BZhV1l127Q4NC3Ru/I31CprmpmBI4/benC5Sg7KqGnWLp7fLWqW2E/CTsAfBAi8o1mt8
         Nzu47NfoAPrcXoKSJWuXFrzg7jo3AH2o+Z1CA4IfDX+321801ODvgyl5K83lv7co9pCc
         gZr9A0k+rpxCchGsZvoR6ZsTm0dXAWBdeINBUqFu1NodfW1a7eADTw9LFb1gC9FtjkWp
         fyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOYS6lb1YTBxNzPbGghn1dFCSuBt5y4qx5FjzOqrB2U=;
        b=WQt6bMFfu8hC4aTLTBbcmNldqbJVj1/tIHkcXwYLDZGRvCG1I5JuPT4p0L0bxo8RF1
         RA+DzxizPRzZ7/tmkeXa3XmjjD2V4YW8y2A4DbXhsX3dig+W0BcUgYHh8IXQ/syRRLID
         toC05Y1CfTuA+VA38UJiOJX8NXDbRH8E7YCh3QMrRYjFMvrhIOeQIQIaYzdXrT9wqY9e
         9lTKf3XpsNXjfqp9uP0J7cpNMTG4L+Um3N6gCABqiKhsVMWGtD4G058bf8+8+06/EI8s
         W/2614BPUo4iPQZyTZoIxoPaQJGHsCWyj8r5ZwAqUkddkitH2V6KJ9Ad02nKL8NVdQ4S
         s9vg==
X-Gm-Message-State: AOAM531770CZJdl7DUM5gqFLBBZa2v0jwyk6pyERyA5mMELXzKFEx3/l
        EvSq9EPIA1Le2c18VKdf0SE=
X-Google-Smtp-Source: ABdhPJwCcQarW7pQm5oVvORMkeVo4cevdIlJU6HrkHwuva73EOqS1LppTZdpkmmD+quIANNpfiT5lA==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr3535067wmj.148.1627030716031;
        Fri, 23 Jul 2021 01:58:36 -0700 (PDT)
Received: from monk.home (astrasbourg-157-1-7-84.w90-40.abo.wanadoo.fr. [90.40.218.84])
        by smtp.gmail.com with ESMTPSA id l23sm17503607wme.22.2021.07.23.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 01:58:35 -0700 (PDT)
From:   Christophe Branchereau <cbranchereau@gmail.com>
To:     paul@crapouillou.net
Cc:     jic23@kernel.org, lars@metafoo.de, linux-mips@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, linux@roeck-us.net,
        contact@artur-rojek.eu,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: [PATCH V2 2/5]  dt-bindings: iio/adc: add an INGENIC_ADC_AUX0 entry
Date:   Fri, 23 Jul 2021 10:58:10 +0200
Message-Id: <20210723085813.1523934-3-cbranchereau@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723085813.1523934-1-cbranchereau@gmail.com>
References: <893d6165-0f12-d0da-44be-449a4ae96ac2@roeck-us.net>
 <20210723085813.1523934-1-cbranchereau@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The JZ4760(B) socs have 3 AUX inputs, add an entry to prepare including
the one named AUX in the sadc driver.

Leaving the rest untouched as it's ABI.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
---
 include/dt-bindings/iio/adc/ingenic,adc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/iio/adc/ingenic,adc.h b/include/dt-bindings/iio/adc/ingenic,adc.h
index 4627a00e369e..a6ccc031635b 100644
--- a/include/dt-bindings/iio/adc/ingenic,adc.h
+++ b/include/dt-bindings/iio/adc/ingenic,adc.h
@@ -13,5 +13,6 @@
 #define INGENIC_ADC_TOUCH_YN	6
 #define INGENIC_ADC_TOUCH_XD	7
 #define INGENIC_ADC_TOUCH_YD	8
+#define INGENIC_ADC_AUX0	9
 
 #endif
-- 
2.30.2

