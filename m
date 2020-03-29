Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1FEE196D4C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgC2MbT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 08:31:19 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:46686 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgC2MbT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 08:31:19 -0400
Received: by mail-wr1-f50.google.com with SMTP id j17so17501993wru.13;
        Sun, 29 Mar 2020 05:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DLCZrMaHPWvggXWGu2AXl1Ge3rACIAAO1GldAOLGL4c=;
        b=D8GnJcapGvU+PH3ZGmoLH0c0D7CaY3o1I9yCeVLNijTY653KJ6m1smTyZk0kI7LbiZ
         le1syhZ99k5PTKiGbVPIUzG1K751wEzAqMhJPngYRoGqI1xYrJxqJj5R/97HKJURHPLt
         nXsEyFobsd3z8Pqyi8AH6gG6ksHgtV3S1/DVDk+0wJMcBYNjmq+qVLiSReNYZGC0ETAR
         h5KIHN7yHs0LfSmR/1fXIJlYfFtKEu5O6L+i8OUnYWv+77Blm/WX9MwO+kPJ7rskvc6d
         lcUuv5OeFglESH+3XV26F1vYODWrSO8WOfWQf+9SiSdT5J4mon7vo9yNjjLn9AJC3jVB
         vb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DLCZrMaHPWvggXWGu2AXl1Ge3rACIAAO1GldAOLGL4c=;
        b=AyoSzHU84YpJYbvM+APfR0gpGnXgMQwWWDXeIGiXlKKUBVt3E3Vc9xyGgqNTRqQxjc
         OJonSYMh0DbkbyibVBJFx7c74TEOCDn6u6+u9pNVcdn2rRfiS9TEmeHTOAK51aJQXVhg
         sYVCCXz7MevmnK5ckXJtk6MgDKFhO9eRuD9D23TOB1tNzCoiZbGDddksd1yU67BNzIbr
         PG63AQGXuYDHDaan1ya5Jc28RLspHjiTvll1i5SWm79BRQGVsx+0EoGJfN6T90QZ9cwa
         znxyUrQUVtTl3LhvSqhR2Bzvg7X2goj3HPevhPASdOOgS9Ll25Ufy09Ii5rAycJUX/EQ
         KqVA==
X-Gm-Message-State: ANhLgQ0oSw7bvDZJWkHQVx9HpaSscqkJ9MEjR8h4kU8qOckZxQY9Ai2D
        rPAJZzR0L/QDOsMzdWumS5LG2NUl01M=
X-Google-Smtp-Source: ADFU+vvVzVBCsunK/Zx2Of6dHq6E4OhDh0yMUD+R2tH7v0oSXW4vgJzSeigjFx8xx0BdhhRqATnYTw==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr9913638wrn.237.1585485077208;
        Sun, 29 Mar 2020 05:31:17 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id f9sm17259108wrc.71.2020.03.29.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 05:31:16 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v6 0/5] Add battery charger driver support for MP2629
Date:   Sun, 29 Mar 2020 14:31:05 +0200
Message-Id: <20200329123110.26482-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/adc/mp2629_adc.c                  | 207 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  86 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 687 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  28 +
 12 files changed, 1106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

