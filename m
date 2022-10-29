Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775586121C7
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJ2JaJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 05:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJ2JaI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 05:30:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFD0564EC;
        Sat, 29 Oct 2022 02:30:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r186-20020a1c44c3000000b003cf4d389c41so5114812wma.3;
        Sat, 29 Oct 2022 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IMcGPMOyuVjrwsxO9/L14qIeyoUHwUkbeOcTtHo1MFY=;
        b=hbRRMUxR76ePgCyqoRPN+EmfTeZ+GbVR+gKCCI9C5iGTOwattxP4FlhMiW0KpBBWEV
         mDoScxT2uyIkP/wxVJlo4n4epxanwNfKuQolXdyKCV8oOktoYnEkXsf0etvz9bjzU09u
         j3bVcN5zXq7arHe5fempliuY3Vj8GpQVJZSC27AviAPKv0xKqat6o/ZbUblT6bp8oIqs
         0HmRlid0oipHzPh+Q9M3Kzd16XW9ouyQM9DwTi1o5hDEnWo8oxd/eKRL/MnyH7W2BELz
         SXMFQE3DycU8V1zBnJgbZYbJpnpValgpY8herm60ZJfKfrFRkqNGkQc1YfVciwXjHM6m
         2jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMcGPMOyuVjrwsxO9/L14qIeyoUHwUkbeOcTtHo1MFY=;
        b=KntK7Vyr5zQEYcMCPItR/ikDxQ9azHOOAV7tiCR+fxOcYn0/SXiR49DCd79KZrHFoA
         YECdJE7aqY1gm8U/iy37h6OSeiaxwqH12YxfAmAFd80UM8XioTXUdCSJsaG2EEvyssz5
         e5MFDjP+YwgQyJfP7QITjvZrQ1ppj3tyeAgZRByqkq5EtbYkvR912yqNn72uR5+/yBa9
         nq6CsdJKj0lp9XfA3pkcV4AN9ZCGit+JN+VAuAtHk4iB8r5wtbOtxsN5p+5llv9u/QsK
         FpXompwDK/rXjWJuWDYsTy4xfEmV5HOEVXW7TjOgxUykuuEEaeFiwynQEbolyETHN/pB
         Q4xw==
X-Gm-Message-State: ACrzQf0aEJky1lipANENjAJCaJhiEyYSE7GbNTbZRHWmDubS1ltOOn4X
        I9uNXT6jGzqFc1nhzxelfIVQN0WJ2fcIJg==
X-Google-Smtp-Source: AMsMyM6ZQsraZKeZFId8+Hf2p+MRXWZ12xb2BfGulzb0UcE5iPR1ky5D7Nc7jvllyiqJCM8g7uVVvQ==
X-Received: by 2002:a05:600c:3d18:b0:3cf:4c1e:5812 with SMTP id bh24-20020a05600c3d1800b003cf4c1e5812mr11715380wmb.192.1667035803509;
        Sat, 29 Oct 2022 02:30:03 -0700 (PDT)
Received: from discovery.. (p5b3f76b5.dip0.t-ipconnect.de. [91.63.118.181])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0022e6178bd84sm1068187wrr.8.2022.10.29.02.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 02:30:03 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 0/8] Add support for mp2733 battery charger
Date:   Sat, 29 Oct 2022 11:29:52 +0200
Message-Id: <20221029093000.45451-1-sravanhome@gmail.com>
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

changes in v5:
  - fixed commit message on v5-0002 and v5-0004

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
  mfd: mp2629: fix failed to get iio channel by device name
  iio: adc: mp2629: fix potential array out of bound access
  power: supply: fix wrong interpretation of register value
  mfd: mp2629: Add support for mps mp2733 battery charger
  iio: adc: mp2629: restrict input voltage mask for mp2629
  power: supply: Add support for mp2733 battery charger
  power: supply: mp2629: Add USB fast charge settings

 .../ABI/testing/sysfs-class-power-mp2629      |  16 ++
 drivers/iio/adc/mp2629_adc.c                  |   8 +-
 drivers/mfd/mp2629.c                          |   7 +-
 drivers/power/supply/mp2629_charger.c         | 229 +++++++++++++++---
 include/linux/mfd/mp2629.h                    |   6 +
 5 files changed, 228 insertions(+), 38 deletions(-)

-- 
2.32.0

