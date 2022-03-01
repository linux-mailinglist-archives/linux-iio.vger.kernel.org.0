Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0505D4C9888
	for <lists+linux-iio@lfdr.de>; Tue,  1 Mar 2022 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238377AbiCAW4P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 1 Mar 2022 17:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiCAW4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Mar 2022 17:56:14 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2A30F47;
        Tue,  1 Mar 2022 14:55:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id x15so588713wru.13;
        Tue, 01 Mar 2022 14:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rs/2TqT70AUPabP/GiBqwdGSM+9dWFxDFWKvpjsfMsY=;
        b=QaintAV8YFK2NdnqgYi2vnaOvaRprZ4PNXh/LHVMSK9OT/5gIIdP4lG19UtztKvoyy
         2aPlCQARN7c6PbmjxUAJd3nXrBR2NeH5WzQu4sokLc8Q8PMVfVTAAtvbhH3Vf731fjMC
         6OZeKr/oHBZK3se3G5TqaslKKIHyOhKBaIsHQiJWGTeN7dTOzEq+hX47R3KrPKgCeWmR
         RHSNM/ol/OVnBliPA82+WTtb+M7e+5uNeLFp1qc/sFppLg63zloxrt21ykQnyquhyVmk
         BC1p98qZe8iVBYIbO6CpW+6o8003MACrg1kWtQrG/2kgXABCDUeSqGfCviWsDMgHDsLr
         0AQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rs/2TqT70AUPabP/GiBqwdGSM+9dWFxDFWKvpjsfMsY=;
        b=eS+KkZFHgWR606IRLcGChs8lDqTynif2AuPwmjOGvKFmmMU4F2hWYQBC9WRY3NEWRv
         Ur4SnXmmXF84f8hl9KB/8mizMEwPlK7h3NxoIeD5QK+/hCG1LNIYsxBSP6IFMfhsb5jl
         PHrWw8jXiLbma514wkZCU832oVyv+qmKdJs/cXWxVjfoucB0IPphdyZ4rnWukrNIly5l
         idITdpnfGSJlu7bmGhZvzm7/iKWhL6CoYAGxx8UiSWVUBw93tT0bYwnkdagBuqVBhUFk
         QLlvHilNan0ubpxsQDV00ZcREDRIy3yQAMqAbBxoEg0egqW278EdnI4BblBSG15DuMe4
         f3GA==
X-Gm-Message-State: AOAM531GpLvsc91i0ozTzABzpekE1VrEdcBMHAyCSa1U8BkdvTq3ApF9
        bHeLfUPNHa5GFzC8Q1RmKN8=
X-Google-Smtp-Source: ABdhPJywW97zYgOJWhikjkKxqWUcVNBGwie5df0jxdkroXXIrNHbICF3Si8+anORQDnfdOmxJr9taw==
X-Received: by 2002:a5d:61cd:0:b0:1ef:5b6d:f240 with SMTP id q13-20020a5d61cd000000b001ef5b6df240mr17609959wrv.390.1646175330739;
        Tue, 01 Mar 2022 14:55:30 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.75.250])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm5314832wms.7.2022.03.01.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:55:30 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sicelo A. Mhlongo" <absicsz@gmail.com>
Subject: [PATCH v2 0/3] Support LIS302DL in st_accel
Date:   Wed,  2 Mar 2022 00:54:29 +0200
Message-Id: <20220301225432.60844-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Hi,

The ST Microelectronics LIS302DL is currently only supported in the
evdev framework driver in drivers/misc/lis3lv02d. This series enables
support for it in the iio framework.

Regards,
Sicelo


Sicelo A. Mhlongo (3):
  dt-bindings: iio: st,st-sensors add LIS302DL
  iio: accel: Remove unused enum in st_accel
  iio: accel: add support for LIS302DL variant

 .../bindings/iio/st,st-sensors.yaml           |  1 +
 drivers/iio/accel/st_accel.h                  | 26 +------------------
 drivers/iio/accel/st_accel_core.c             |  1 +
 drivers/iio/accel/st_accel_i2c.c              |  5 ++++
 4 files changed, 8 insertions(+), 25 deletions(-)

-- 
2.35.1

