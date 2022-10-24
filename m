Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DB760B878
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 21:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJXTq1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiJXToN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 15:44:13 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F842FFC3;
        Mon, 24 Oct 2022 11:12:22 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z24so3822817ljn.4;
        Mon, 24 Oct 2022 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbQJ09ZTPaHlRrFCuN4fBc+xGyuOsxpPwvn3XoL26j8=;
        b=guspafMuQ/edprFnQg7tzMksVRTX1qD8gIg+VAl/J8Efpbln+KOjbeSlwX77rZTUYO
         xgyS94nUzLMewUpXm0Of2SEPcX2RnxRS1/fiLLCY7ahV/V6+UQ9eJZDyIvW7L1MqNJFb
         NM4TJqQ1MewCs2FyP/K4ofhfKFvY4ciQ/pup4wDM3hOozBYWfGVOOWKqKMjRYO4Sn0EV
         omCVCseLGCP3FOZkwkmKkqkk15gZdyqOjGkWvHRhoSsDQRkA6rORsOQXXVBh//bkrecU
         B88/t4/0BIx7pEt145wZlmnqR6JXu7FEDwrO5u9CylXeBlnKmo57hGZEUWcR0AGOe7d4
         NEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbQJ09ZTPaHlRrFCuN4fBc+xGyuOsxpPwvn3XoL26j8=;
        b=mPvYuhA11J+Hbcn5i2v8u+foDVNh3FJpBek4yuHuCHcx5JnVP7c827zIA7VD9G1Ubn
         idVDeUyryyUn/UquijDRBt8k0O/am8G1/eBYAFQrTLYx7fXfCXOTLTsUujQLAngH0xUd
         3M5IDk7lhk5l96i7Yujkx3DAMc7DbAng6kTy/mWXws0t9q1z9Y4/ekqSTWRuwyADwWPC
         M/mpc08VV9vZsDNhVWnBVxos0XnFb/8/hQOxRERJQhq56dalhZXJDgeQDXVAzQHYssJ8
         l+GQtxtCASpJz9YM3O6B7knnc2O7sroSZVBOnS4abaWtEt49yifpkRuLSTIQ54+J6SGE
         Zm7Q==
X-Gm-Message-State: ACrzQf0pgUKlDyz4C6h/Px5yVIhwqUhVfz/7L7UnBfJuhtvEtcFB2sUC
        8iu+PBCHGl/s1Zy6NMHhSL/YMRDJYTw=
X-Google-Smtp-Source: AMsMyM6HmwPoHkG90IEhF0m7PQ6pO40U8ZN/esxQmIUCuawhp3BayxivI/DswckqIn88qEg0ge6BGg==
X-Received: by 2002:a05:6402:f24:b0:461:7c77:98c4 with SMTP id i36-20020a0564020f2400b004617c7798c4mr10841948eda.80.1666618082256;
        Mon, 24 Oct 2022 06:28:02 -0700 (PDT)
Received: from discovery.. (p5dcfeede.dip0.t-ipconnect.de. [93.207.238.222])
        by smtp.gmail.com with ESMTPSA id l20-20020a056402231400b00457c5637578sm18243818eda.63.2022.10.24.06.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:28:01 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 0/8] Add support for mp2733 battery charger
Date:   Mon, 24 Oct 2022 15:27:49 +0200
Message-Id: <20221024132757.3345400-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v4:
  - fixed attributes groups review comments in v3
  - added new bug fix patches v4-0007 and v4-0008 

changes in v3:
  - fixed dt_binding_check error
  - fixed spelling usb->USB

changes in v2:
  - fixed spelling
  - revert back probe to probe_new in mfd driver

I do not see a cover letter, but FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for all patches except DT binding
Note, some of the comments regarding spelling were given, I believe
you are going to address them in v3.


add support for mp2733 Battery charger control driver for Monolithic
Power System's MP2733 chipset 

Saravanan Sekar (8):
  iio: adc: mp2629: fix wrong comparison of channel
  mfd: mp2629: Add support for mps mp2733 battery charger
  iio: adc: mp2629: restrict input voltage mask for mp2629
  power: supply: Add support for mp2733 battery charger
  power: supply: mp2629: Add USB fast charge settings
  power: supply: fix failed to get iio channel by device name
  iio: adc: mp2629: fix potential array out of bound access
  power: supply: fix wrong interpretation of register value

 .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
 drivers/iio/adc/mp2629_adc.c                  |   8 +-
 drivers/mfd/mp2629.c                          |   7 +-
 drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
 include/linux/mfd/mp2629.h                    |   6 +
 5 files changed, 228 insertions(+), 38 deletions(-)

-- 
2.32.0

