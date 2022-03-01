Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349924C988A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 23:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbiCAW4Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 17:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiCAW4Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 17:56:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94030F47;
        Tue,  1 Mar 2022 14:55:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d3so22914762wrf.1;
        Tue, 01 Mar 2022 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6wYcTuEdx9Nq7ognvc7vHgoVBJTMoosFRQn+DHuu4w=;
        b=hvRpZ0S9kUPDlIYUiIIo1gE+Mcrjv1gimVTiIm+gjlbrxecDLCn13NAl0ZSeI1wgcJ
         8vjd78GyEvh7eSU/cmCVV+6SNddK+2s/G++Kj8LUXFhc8j1eoMqgWcqBQCdn18VSHa5Y
         l9Iwws+zASn4htgmxHbuudM/WiAQtFaFbZ7O9EBD0P/hy2uBW46oiuellhhRuX3qpHJv
         LBh7acrno2gmZpmN/MHpEIycvPExIEpXhSrkpJwKJTzmX0yUEwXL01Cs/652ZWJJGfuy
         lE14oxdSu7Md0n/W+hP7y0JsfwfeazbJ9MufkL+FZm8gppQWWWrVoA+lZN/5am5fI0rO
         RdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6wYcTuEdx9Nq7ognvc7vHgoVBJTMoosFRQn+DHuu4w=;
        b=fL52AhZOVDjVcrV1RXMJIRx/UfgviTXKMxuGB30FPog/ERuH/gzLSRxUbl20nEH/bv
         rb6bsuMFLfaiom0hFBkIMpy5gGETrJgkelwt9YFNNqdMVDNZRQ6jNRbOBiZxF3WbU+/A
         jR8vnZpFSlX+XNPCPtE0MnnKwzOJuqEP70ww/8BEoyGfM36I200WLSkwinOE29ra/Q9N
         KcPKX0ZYcqyYgNJJPG21pY9KvKZ6YmP+ITRvIZTtshCc9Xkw/0bGHASaMylGnQFfVKUO
         kBqMz6l3ehtik15BupTAGAb7DHUGmtkjNWMA1ZGOQI9ApQHt73LKojWIPfl06k3vgL4V
         9ZLg==
X-Gm-Message-State: AOAM531rj5Jv6bV6J08fDheTkUgzxZgAhfmj65hf5s7qjPL8AcXnJTc7
        AXH2tt382koPXp2mNGTP1Hg=
X-Google-Smtp-Source: ABdhPJy/JC/KqJ0Ck39RCz+tr7ZDANNbTfnntOUNjFTfFX896FssrqpZ6ghjKXqCC6q7MAtP0k1vAA==
X-Received: by 2002:a05:6000:1acf:b0:1ea:f20:cbed with SMTP id i15-20020a0560001acf00b001ea0f20cbedmr20477362wry.217.1646175342105;
        Tue, 01 Mar 2022 14:55:42 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm5314832wms.7.2022.03.01.14.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:55:41 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: st,st-sensors add LIS302DL
Date:   Wed,  2 Mar 2022 00:54:30 +0200
Message-Id: <20220301225432.60844-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301225432.60844-1-absicsz@gmail.com>
References: <20220301225432.60844-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Update st,st-sensors bindings for STMicroelectronics LIS302DL variant

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index 71de5631ebae..321fd16b6ea7 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -29,6 +29,7 @@ properties:
           - st,lis2dw12
           - st,lis2hh12
           - st,lis2dh12-accel
+          - st,lis302dl
           - st,lis331dl-accel
           - st,lis331dlh-accel
           - st,lis3de
-- 
2.35.1

