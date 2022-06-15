Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3D154CBD7
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jun 2022 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiFOOyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jun 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiFOOyE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jun 2022 10:54:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD4255B5;
        Wed, 15 Jun 2022 07:54:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c2so16555845edf.5;
        Wed, 15 Jun 2022 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm2W6v9ccsuKHVJhwB8rr2eHxTDAjCj+px+ePJ5qgIs=;
        b=jiy/iuSj3AfU2kuIdFtr8PXuyzYy6seV5g6tVWhn/JlJYbGhZhskDOQiK8Ga2faNpK
         JMb9UOoo/mzbkXVaCEYepY224dm24vB7Q80OyBCEgp/hdjkqy6bamryZmGLSm6U0aOVp
         DZquHV69vQTqVZViqyGImIvaa+8B8yOELcd3WhmmxAj9nQEQ/IgNIxMjI42TSF8tnTEj
         7h9nmUeqCTcNQkU7l2zea5q+2YHIzeRTr3P2ZcCI/llMlqXFDW91aFIBiY8E83MnVPON
         RhNB/L9HiC+IkGqVXJ2SFqw7DbAeZOmkjkIyyCW11GRygKb5HbVfWdiKQv7asu1DKrR+
         fV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm2W6v9ccsuKHVJhwB8rr2eHxTDAjCj+px+ePJ5qgIs=;
        b=hnusF9D4FoxYRNLVuZZlUTHDgp0upMDljaYMyyO+0UU5XcnwKJ3xUkbk/HsGHdV+0b
         rSacuK5XfkKWC/vCQsNtbi63M7EZJ77B5LqbojJhFXDR7O4ZwmvxOS7Pp9AMvvrrqhOe
         tNuWtVU1qlLQfN0FMEN9ZJ7EHnBCOpg+pQWygTrJ200rM0Zikx8vI7DQFnHXmn9WjVRu
         sQf6xrkb077xN25TSru7Z5MW4xUyEvz0rlr5FV72ZOdHvLgICacjCW1gkjdE8LzxZTe0
         rTJqpIeKgm6bvlh7X2NY3mbujB2VlBK6nK83+01oDetfK19AYu8Jkt0MMHajCvpNOSff
         BszA==
X-Gm-Message-State: AJIora8WZ5/z+zPtb0MFa1+yei8vCcI0N+N21Y1yNkjmXSD+Twr17e4Q
        qkhdWzdhdXwi8MbwoMHrsyoB8dHPsl0V3Q==
X-Google-Smtp-Source: AGRyM1ssNYYluvGF08zqq6Tim7ZAg+YNRrtCwwml4VMqehODAChivoe5VgtdJv77f6EKr5ZLt1TMXg==
X-Received: by 2002:a05:6402:5212:b0:42e:2fa:41a7 with SMTP id s18-20020a056402521200b0042e02fa41a7mr184821edd.22.1655304841912;
        Wed, 15 Jun 2022 07:54:01 -0700 (PDT)
Received: from localhost.localdomain (p5dcfe5fe.dip0.t-ipconnect.de. [93.207.229.254])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709063a8200b00706287ba061sm6341665ejd.180.2022.06.15.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:01 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 0/6] Add support for mp2733 battery charger
Date:   Wed, 15 Jun 2022 16:53:51 +0200
Message-Id: <20220615145357.2370044-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

Saravanan Sekar (6):
  iio: adc: mp2629: fix wrong comparison of channel
  dt-bindings: mfd: Add mp2733 compatible
  mfd: mp2629: Add support for mps mp2733 battery charger
  iio: adc: mp2629: restrict input voltage mask for mp2629
  power: supply: Add support for mp2733 battery charger
  power: supply: mp2629: Add USB fast charge settings

 .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
 .../devicetree/bindings/mfd/mps,mp2629.yaml   |   4 +-
 drivers/iio/adc/mp2629_adc.c                  |   5 +-
 drivers/mfd/mp2629.c                          |   5 +-
 drivers/power/supply/mp2629_charger.c         | 208 +++++++++++++++---
 include/linux/mfd/mp2629.h                    |   6 +
 6 files changed, 212 insertions(+), 32 deletions(-)

-- 
2.25.1

