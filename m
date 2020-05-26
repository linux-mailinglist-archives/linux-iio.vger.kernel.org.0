Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC76E1E1DD5
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 11:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgEZJHJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZJHI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 May 2020 05:07:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2FC03E97E;
        Tue, 26 May 2020 02:07:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so22939393ejb.10;
        Tue, 26 May 2020 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6UYhgjt30/Z/G4DYA8xqr5Fc2y1n0eveIbzcFms15a4=;
        b=HohC0S3oZosLwnVdaGYJQNK0ABtqTjZCVei35zCr/Pg4Rs06vGrGX2HvU29rd+dq/z
         S9kHdKV/rP631FYX4FwIN/XzVWSUUHemeGkv+xJiwzzvM1xz+8wc+TM09LyYeQ6Zu6ny
         oF9eni5wKT59hWdMZXrRT9HJ+C/F49x7QR8vJlVv93/0xWxNjcuwqdQyCEcNlt53yV7a
         aGNTLndvbz6VEIZxmUs3NEsChWgiqskGRQTXJv956kXAhce8COkgRKeCbDmHrPI98oEH
         n2I5XxPSFKsu5iBQbXeG4meB1iT00yNxxhkGCHqRMbv1HFi1Z4WaI3H6IbOmxdGzHWkf
         ftCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6UYhgjt30/Z/G4DYA8xqr5Fc2y1n0eveIbzcFms15a4=;
        b=BTpHEKalZMhtGQbxDXKryduZJJsvEckNhz2rn8EZHBnUhF/3r0o3kvQ2maeM6/9Ig/
         lghUG/0uUernKN2P3C/xIhE0yd2yVZmmYww/DiG+IawTi3HsD3vIK6KeLB40jQErJ20F
         ckh+JzrE8mbLw3qx52gz3puLS9GeVaCe3nIMKLNN1o6eFpZVRCuFCAfUmP6pI0ETPFKz
         atlJVK7reVtctCUPps4qDG7b9eURsEIbuoHYxrq94y6xFjKTko+OKnj2FhIS/Zv+pACF
         ZYzpdV6f8F7/ZcWBDiBzrBNJ74+Evhq3MNh3Wfn3vyj6UC/6f2vEnnDL35j3tYXa2cjn
         c5Bg==
X-Gm-Message-State: AOAM5327Nhnj02QvW2W9rvE8A+xxq59Cmg7vUVjXLvpPXWg6ZWpB8zme
        QzJMN3urGrUcN5It1AN0H3w=
X-Google-Smtp-Source: ABdhPJyzYunI/i1R25TYINlpWvSkulJF0DUuKtO5cC8KpGJIdTpXzvxx7ocD4EXNacXZ+D2iDaRgvA==
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr287367ejb.90.1590484027017;
        Tue, 26 May 2020 02:07:07 -0700 (PDT)
Received: from localhost.localdomain (p5b3f6e09.dip0.t-ipconnect.de. [91.63.110.9])
        by smtp.gmail.com with ESMTPSA id c7sm17870535edj.54.2020.05.26.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:07:05 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        sravanhome@gmail.com
Subject: [PATCH v12 0/6] Add battery charger driver support for MP2629
Date:   Tue, 26 May 2020 11:06:40 +0200
Message-Id: <20200526090646.25827-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v12:
 - added SOB Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

changes in v11:
 - module_remove part replaced by devm_add_action_or_reset in charger patch
 - minor review comments solved in mfd and adc patch

I expect, that Lee will provide an immutable branch for me and
Jonathan once the MFD bits have been reviewed. Please tell me,
if I should prepare one instead.

-- Sebastian

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

