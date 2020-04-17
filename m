Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C338F1AD8EE
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 10:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgDQIuV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 04:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729746AbgDQIuV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 04:50:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841FC061A0C;
        Fri, 17 Apr 2020 01:50:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so2084701wmk.5;
        Fri, 17 Apr 2020 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GjBJFkKLa/NFlRpqz0VJbdCwa9jpkCmcatT7tQnjlpM=;
        b=UrhLAt29c4SK2A8nYYCAhfujRcZ91Er7FUOF9SEURdyEjP9JzheNDev3XedzjOxVWk
         7y0cLNgAt9XLpinLxe3BKckRI9pWGPX12UtXcugflOcB1Co22o+0l0CYwPZrt96QWljf
         4C5AMowIVrrBrR6rCec932FF5jU9mvWZwnbLYtVMNDQgKqNSD9b+fsVK66wUKdojtAms
         MZ3PQMrQE2luUlWdtk1uCrzk83PP0iCBGEM1GXxbSIGI7IqoMHhK1XhZYMOfPU1fK/md
         XrG9HhHkf9wexGonsPcTZO/wKkSe998X/UQbQ+n/w2gKOFbzf9c7AV/JrkHUiezxMcKT
         w8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GjBJFkKLa/NFlRpqz0VJbdCwa9jpkCmcatT7tQnjlpM=;
        b=alg3CoQEVqQLGEwZcLZRdkN3ZjJrmPzzKMu4L5wYWKs+oEwPyG6tw/T3K7d8924VJZ
         vOwqyfr1FuK2rmFePRTsN5K3DFpOpc1FCurBqTxyHGNDfx2YGQcejY7sHC2+yEKr8hj+
         lKtGF9BtTHZB0L4V0N2+DqNyUr2w8OacBVkUUsl/FUUF5l/RrnTVuo7cdWz5pP/LHr3i
         Zm9L1EeuNwFjGQ5Ma3iMS52GlS6cxOc68EPnrQo83r5Ewr1QOd1R2PqlrsN7lgoM7g0/
         4abdik80wprqAXcXDvzjlDStUz+ILJrkOt2fmjTb5MC4aKhMuJKa9A5gxC5rzLDQLtTW
         cYGw==
X-Gm-Message-State: AGi0Pua/BMkbvfaTVjKnZD4gs1kVyt3HXNBF/pSD4R9mIG44EC5uTiCG
        ZPkl3Wo6SmF+JaVSzsuxb2s=
X-Google-Smtp-Source: APiQypJP5Go4lIErygFmGDZqACzmLazz32jw8sUVlm0Ryfr4mph9iwc8YSOJtZija6mv5Mtt/Qszxw==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr2178472wmb.71.1587113418278;
        Fri, 17 Apr 2020 01:50:18 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7443.dip0.t-ipconnect.de. [91.63.116.67])
        by smtp.gmail.com with ESMTPSA id l5sm6807527wmi.22.2020.04.17.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 01:50:17 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v10 0/6] Add battery charger driver support for MP2629
Date:   Fri, 17 Apr 2020 10:49:57 +0200
Message-Id: <20200417085003.6124-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

*** BLURB HERE ***

Saravanan Sekar (6):
  dt-bindings: mfd: add document bindings for mp2629
  mfd: mp2629: Add support for mps battery charger
  iio: adc: mp2629: Add support for mp2629 ADC driver
  power: supply: Add support for mps mp2629 battery charger
  power: supply: mp2629: Add impedance compensation config
  MAINTAINERS: Add entry for mp2629 Battery Charger driver

 .../ABI/testing/sysfs-class-power-mp2629      |   8 +
 .../devicetree/bindings/mfd/mps,mp2629.yaml   |  61 ++
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
 13 files changed, 1096 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

