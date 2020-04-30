Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6F1C00F8
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD3P6V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD3P6V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 11:58:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4AFC035494;
        Thu, 30 Apr 2020 08:58:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x4so2466740wmj.1;
        Thu, 30 Apr 2020 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OPbeDM2cJ5aY40/5CUX4MHQFjKQOx8SNoJZ2e5+rWE4=;
        b=P5yrqIGJN0HwsHhkR4vMRNhcfK9xpijRREv97x1ZAk/hVSZeoUnHqMcaPk5Mpg7k60
         Arw2ul2YgP0P2EZqMvuMAbiWI4riPNjH5n9HqegzKqlKAK6egB88JO1LnICEhqkdhOHx
         C7qgl/AUVidKSO2dQ231ogIMRjnM9+QEzY3U7uGMNfCF/xniyj6Ch1SjEjHbg/CLis4C
         rbT6z5X4mWtbbSlXWzWJSUswcazMECs6EEYudahmjYbkWXf5bMYiMPOHGYmc1Sq2MDb+
         wvNS6jzQK79PzCqvtSnyUapdCU6CUrJqSHgPZXXrZ5o3zHIwduJqjizPf7j/Ht0mL0To
         cF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OPbeDM2cJ5aY40/5CUX4MHQFjKQOx8SNoJZ2e5+rWE4=;
        b=hZzLksOz3yS8KUChr++PjlgJhSs2uhosgMVu11DOxEPNVtNOU0hOaAU86h7kvBDj6r
         hWFwrnmly1l6oCBDfDIRjBjoqWMfL50HIuqfbUBEz3Tc6feqv3nfHU2azTP+XP5iZceW
         UAY05zRH4HJvWA9Ib3TA03pW+3O+xivQHbXAapt6qofAQJs7XX15Qm/RO5QdHRzFyJrw
         ojdk5LZjbya/TDVzz8/0bTY4OhqhK7kubdeTvA/4mJe3ZNRi/CQOxqsNEWPREXf/b2rR
         nvS6LOPPU4CmmIJDb957PyKymGHXLbsstweegzfxnU+etIr+IPfAVNrWxwEPIZAkD1J2
         0vbw==
X-Gm-Message-State: AGi0PuaXcQsWQU86MnhIuFDKratux3gMZ03HlJuJLd1zkl7ZfFegtwGB
        ZeFUx60a3f1kpyvNqVhiYVo=
X-Google-Smtp-Source: APiQypJGM/yC0m96AySjSxYslDHri5PZMrYCb0FFv3elkENgHkRGkZiiD/fFkakWizNlPa+BFZW0Yw==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr3674853wmk.171.1588262298154;
        Thu, 30 Apr 2020 08:58:18 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6E9D.dip0.t-ipconnect.de. [91.63.110.157])
        by smtp.gmail.com with ESMTPSA id w8sm265410wrs.25.2020.04.30.08.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:58:17 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v11 0/6]  Add battery charger driver support for MP2629
Date:   Thu, 30 Apr 2020 17:58:04 +0200
Message-Id: <20200430155810.21383-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v11:
 - module_remove part replaced by devm_add_action_or_reset in charger patch
 - minor review comments solved in mfd and adc patch

changes in v10:
 - fixed typo, \n in dev_err
 - dt bindings Warning (unit_address_vs_reg) reported by bot

changes in v9:
 - fixed review comments in mp2629 power supply such as resource based
   iio channel, replace workqueue by threaded irq, irq get with "_optional"

changes in v8:
 - fixed order of call in probe/remove in iio adc
 - add ABI documentation for mp2629 power supply

changes in v7:
 - fixed probe/remove order, managed and unmanaged call mix use in adc.
 - Documentation dual license, i2c node with controller address

Overall looks good to me, FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One question though in reply to patch 4.

changes in v6:
 - removed includes types.h in mfd, of_device.h in adc.
 - fixed review comments parentheses, err check, kstrtouint

changes in v5:
 - removed platfrom data stored in mfd and directly accessed mfd struct in child
 - fixed spell check and capitalization in mfd and documentation

changes in v4:
 - fixed capitalization in mfg Kconfig and documentation

changes in v3:
 - regmap for children passed using platform data and remove mfd driver info
   access directly from children

changes in v2:
 - removed EXPORT_SYMBOL of register set/get helper
 - regmap bit filed used, fixed other review comments

This patch series add support for Battery charger control driver for Monolithic
Power System's MP2629 chipset, includes MFD driver for ADC battery & input
power supply measurement and battery charger control driver.

Thanks,
Saravanan

Saravanan Sekar (6):
  dt-bindings: mfd: add document bindings for mp2629
  mfd: mp2629: Add support for mps battery charger
  iio: adc: mp2629: Add support for mp2629 ADC driver
  power: supply: Add support for mps mp2629 battery charger
  power: supply: mp2629: Add impedance compensation config
  MAINTAINERS: Add entry for mp2629 Battery Charger driver

 .../ABI/testing/sysfs-class-power-mp2629      |   8 +
 .../devicetree/bindings/mfd/mps,mp2629.yaml   |  62 ++
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  79 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 669 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  26 +
 13 files changed, 1090 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

