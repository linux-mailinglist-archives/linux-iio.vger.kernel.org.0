Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C61A4AFF
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 22:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJUT5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 16:19:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50468 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJUT5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 16:19:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id x25so3626646wmc.0;
        Fri, 10 Apr 2020 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c0e+/KBVc/nobaXkJrTJrhiH2MWb5NU2UiIxXfMzlcE=;
        b=ppavkZBLmnDZyYFzfQI2VnEXeS3xcqKugv8XTxOnumjZOK48cLVbcwhuYhSJI+4PzH
         9uh5aNTqXV4nNJcF+xJ6acFv661+hGDvy6fkxsCYP+cXjfgSh0zK/A6WPumZL+XTnJSr
         P7Ezml3+eG4HHt7QyKSH3vab8XEqn4oUPxKRKaE7+dxy9YKtuUYIRoYyOKoIhSMd+qfK
         JF6PY0G4THYL2iz1IBlvayoXzZZ7CdYtk2s1qDYNMYda0PDQyBzvM2108kuw7iW6OMGL
         /Wtg00b/EA0XrJLurV1abvL3S83erFDDRbC06nCvEPq04JgETKbkdgOtKp5znFKbJjyu
         lueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c0e+/KBVc/nobaXkJrTJrhiH2MWb5NU2UiIxXfMzlcE=;
        b=ZjDgTKUbE3zlC2jafQqGnef7ceTEGj9q/reN3LWZ4ahp/I0MeJ/nTyVpqAZ+2H0cyc
         C4EtnsQi+ws6hO3RT+SmUDH3M98Id5J746f1KLE0aRPfYPfaXS3Je0+ibpFVEEoJaaAs
         pgECdcOv26nv6zwveCvAV8TvOTyBGxKK6aBoLqyEnV9IFoBDx+4nObzW7M7DB8WWLewG
         9UXSG2oBrc4psACAA6YerndzHRzgQKwOAAEcjPAXp8iQ9hj32uP295uM3JW7noldb/RM
         qpka/G6lc3U/sjSATqRkYzwdMCYug38mxBNBktou8WfsuhL5nkbFwUKvI+LeYD7j/bCT
         /HKw==
X-Gm-Message-State: AGi0PuY5gaB90L6jegbsfDc2MDtfytdVo31cu6q+rjO2wszhGGs2dI4I
        6/42yl61Ep2g70hnK/utaSU=
X-Google-Smtp-Source: APiQypK1BaglDoLnSEUss0hxYNRBfBl24Gpqh1wAASwcxiZycB1f7Q+RTNm+SDmsZl82vHWJG62yAg==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr4319008wma.30.1586549995637;
        Fri, 10 Apr 2020 13:19:55 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6388.dip0.t-ipconnect.de. [91.63.99.136])
        by smtp.gmail.com with ESMTPSA id n11sm4405187wrg.72.2020.04.10.13.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:19:54 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v7 0/5] Add battery charger driver support for MP2629
Date:   Fri, 10 Apr 2020 22:19:43 +0200
Message-Id: <20200410201948.1293-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v7:
 - fixed probe/remove order, managed and unmanaged call mix use in adc.
 - Documentation dual license, i2c node with controller address

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
 drivers/iio/adc/mp2629_adc.c                  | 208 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  86 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 687 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  28 +
 12 files changed, 1107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

