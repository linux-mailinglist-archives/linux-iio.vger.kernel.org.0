Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1591AADC1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415570AbgDOQUq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415560AbgDOQUl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 12:20:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252AC061A0E;
        Wed, 15 Apr 2020 09:20:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so542570wrv.10;
        Wed, 15 Apr 2020 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mFzMem1epN+M9aq3TwIVVdu8mwf/kZGYgwT4xmROzGI=;
        b=L6vFOOxQYGv3gVjLWmsSwz9qxv06UmjfrEaTzVDG/QtcvFvljG1hlaV0NOprSrkceN
         +/UDBYbyX8+yLbIU1EYL+gFMPoThtATdcpoJfTe+08LbF4lfxjpP/J6sAlZsRlrFNN1p
         yXypPj5e18EvDe5+Yy7s7U1Pr1aWKkW2KOv9yACaCMaFGR7t8GgF2sf7VJMNh3ukSfDE
         J0ujg6gpRRWO6qNpDX+RyiET3UewqM0FqeWM2s2mZcDAVS4HNqvkrWrcZN2XObzoObXY
         iTzA/8L0lTcSt/qO2MsXO8BmnWCFX0zRPZfgY8+Lwb8iG+JIRdFPUWmCLQhWNaYSlAoP
         qlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mFzMem1epN+M9aq3TwIVVdu8mwf/kZGYgwT4xmROzGI=;
        b=MeyIpbO4XlfCIDjOVC/VqaSrVjVgSQzWVhqvR+tP1UuX/1m6yHu1hJxrmhj2Lwox5p
         l3YCDQKfkDnpTG0BQpNBJNSCztkdT9hNwmP7dvuTP0DifkSK/eMVktVbYTUbIwymhU3j
         JySSMngYPaMGiXPUhhYMLzeDam7QRIedYlDDwzmktLgl5PZ4+0QTE/D0uCDZFCNi9lbz
         Kl9OseUxoGN+MoTx8SILlynm1qgqRbl5CCavP3NMSQSUBfzWmwQSIEZOqUMqIPzS6kW5
         qFGk60nFCow1iJ7zTmTiCWLOtAmX9FnUm01ubZiW2a0UIiAowrom0HH+bz7DDUZh2gXj
         tsSw==
X-Gm-Message-State: AGi0Pub6NONL0ejLAr8tKJJfo1TxtBmlYQF5xbSDA278Gyd5KDHBIQqT
        bxS50TjKafAdr/laqvJwntY=
X-Google-Smtp-Source: APiQypLXoZAJ9FM2wqyI/7jypcQdh3roJTEErg8J2yFpaAcz7RGu8uVTgySZYcTcQGmhJ+JypGUewQ==
X-Received: by 2002:adf:df82:: with SMTP id z2mr21121457wrl.58.1586967638621;
        Wed, 15 Apr 2020 09:20:38 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6CCC.dip0.t-ipconnect.de. [91.63.108.204])
        by smtp.gmail.com with ESMTPSA id 17sm102526wmo.2.2020.04.15.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:20:37 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v9 0/6] Add battery charger driver support for MP2629
Date:   Wed, 15 Apr 2020 18:20:24 +0200
Message-Id: <20200415162030.16414-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
  power: supply: mp2629: Add impedance compenstation config
  MAINTAINERS: Add entry for mp2629 Battery Charger driver

 .../ABI/testing/sysfs-class-power-mp2629      |   8 +
 .../devicetree/bindings/mfd/mps,mp2629.yaml   |  60 ++
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  86 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 667 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  28 +
 13 files changed, 1095 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

