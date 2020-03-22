Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8016418ED11
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCVWqg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:46:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44393 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:46:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so5718540wrw.11;
        Sun, 22 Mar 2020 15:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=o2Zu+j8P+f4r+VMWXgJycgQcebRHifBm3aep97iCeYc=;
        b=i6q2zHw5e3v/Bv1Ti8xb8UC3wrFZF5Y2NzXiYHoezWpnnmPMfBa11qJ/czxMjs0a4b
         3ME0kmPo1YBv7Vi/ODRZzUS+SWH8gwKmTvsOZukUUNUiGmA/W7bPR77c2+XkWqCZ3dwp
         tVtyzBaEjz1OKxq5Gh1OTHt9aTxHu1k/H/9lkQICjqh04OrRG5OvKaHTdq7E3KCLN7FE
         QWNeIF2QcSHaBJNWNfPfYAUxy3S86BRbwDmnVxraqc4ANZf6DxiFwmIDRJz1loEoFqT7
         4JyYhoFsGlSFlYiapUJ7Oz2v+Z7DhsLpFAdetPjM8NgGlWNCy1xqWzW9ltep8EOlPjhN
         sggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o2Zu+j8P+f4r+VMWXgJycgQcebRHifBm3aep97iCeYc=;
        b=aLgrPya4+O/y1DU81V+KA+/JEpBfGAY8ugesiDBrETQ0vVprs89LK5nqFPJGg5JxE7
         UKU12bwh0jhDcU4TiUyevQcA7exqS+xdiDN7NQPUoFD3Gzoym7T845TKkKy1UcaVcTr3
         RsYPAuHymRle5hYyDOTbQeECj1W2sqSX4vhX0/r6CUmyOirCwdZ8GXlcWoBvWBWdkliS
         T4SfVbm1R2dBK7ixKmTOxiECmgf9HVKHGn7lWcHzvzieYsGLz7CW0cKFQXFw9uLutvpJ
         cfBpdB0JXJypVahY5cPD6c4oSBai75kxv7z9hnZTUrdRqOD7QF3kr/I+wXp9k//ey2PZ
         PP3Q==
X-Gm-Message-State: ANhLgQ2gcyRlnMTWdteWVbrvEVceys6jZBRLhOeKSwdM5pIfFVRe8tZ0
        NDpYPV5+EqewZ2kgV31OICA=
X-Google-Smtp-Source: ADFU+vuF+nIMFx+uARwPok3PqoTGjFj7Z0HDAFVkthukCztCuVi9zZSn8kAKqjkr/uovgbT69PdRBA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr25536009wrx.130.1584917193906;
        Sun, 22 Mar 2020 15:46:33 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id r9sm19158549wma.47.2020.03.22.15.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:46:33 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v4 0/5] Add battery charger driver support for MP2629
Date:   Sun, 22 Mar 2020 23:46:21 +0100
Message-Id: <20200322224626.13160-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

Saravanan Sekar (5):
  dt-bindings: mfd: add document bindings for mp2629
  mfd: mp2629: Add support for mps battery charger
  iio: adc: mp2629: Add support for mp2629 ADC driver
  power: supply: Add support for mps mp2629 battery charger
  MAINTAINERS: Add entry for mp2629 Battery Charger driver

 .../devicetree/bindings/mfd/mps,mp2629.yaml   |  60 ++
 MAINTAINERS                                   |   5 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/mp2629_adc.c                  | 214 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          | 116 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 697 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  31 +
 12 files changed, 1156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

