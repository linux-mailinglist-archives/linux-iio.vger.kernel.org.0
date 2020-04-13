Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8D1A6B67
	for <lists+linux-iio@lfdr.de>; Mon, 13 Apr 2020 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgDMRhH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732835AbgDMRhG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 13:37:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F5AC0A3BDC;
        Mon, 13 Apr 2020 10:37:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so10809234wml.2;
        Mon, 13 Apr 2020 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4qxTkcHl6N0UyqcZicmKtRt4TNllmPv3Es3wEM33D6Y=;
        b=Nu60P9lRbYJGRzKDmP6N0d+O8zNaI9W/10CW9NbgVWKODKWmXq18Sr7sSFQD5CiHZs
         3hEXu0+KlbLt8fNTP6zReYl8S+mvg76uTXgAcmW5WjArXDlaef+0RlUL3s5oIL+jtrfK
         GM5IXFnmEyP/7/Ibt3WdXEKZHijkbvWe/FO+nD+tCSrxeeE0KwSN1mOMIKy3ZQlTJV8C
         W6JR35ox2XH7MJAkqAtb+5eQStYgrByA7bwIyeLc+d3Scbd4jocpiusaFNUTYUx/Q/Sk
         S3m5uEMNKVF/GlV5A1zH6Ux7+gmjmaRbkg7sA3v0K/QtSvbb4z/C52uDDzpe5OmcYmfl
         0JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4qxTkcHl6N0UyqcZicmKtRt4TNllmPv3Es3wEM33D6Y=;
        b=l2kiFuiPvuf46QhOvFfwqTQiXsKNROR8XGEZk0zaQIbhxOYSeiefF5cLXexbVR/hEC
         8JOyKAZlJsVxTJc+wBM2naI4EmAz/ySKuc4x0OGyl1/W8K5iUYDROjSvVd8x1fZVd7w8
         W4L9ifs1CO5GyN4aYKfDKPIK1UvJsY/+zIeVqkraybli6eFq+LNd7ExWSsLAgIByJztq
         auyjCfCjd/NgZRAzY+WI+Cbr5cnHuZe74HlmKOFUKiNEKyes0QRM3Qcl7hXYLHX8pbx1
         QvIWlOdBA/EJhWQlntxcZtwRfm6EMzUAvIzUa14Dy1zA8PaoBwKYjQUHUkGWW3/K5NYC
         X3RQ==
X-Gm-Message-State: AGi0Pua5sXXmSqMg2TuIKo7vqZBDvdqhniFZgfRbg2olu7M06ceHcBOA
        nAF/YqJPSYuTmKBbOdMPuvs=
X-Google-Smtp-Source: APiQypKmjb37yW1hU7Kiy+NVmLei3M0xqktoJJ90AHbisd6y8uUW4daEz6C2zp0HZT5bAwQKsRWCYA==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr20552601wmj.95.1586799424443;
        Mon, 13 Apr 2020 10:37:04 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6AD5.dip0.t-ipconnect.de. [91.63.106.213])
        by smtp.gmail.com with ESMTPSA id a205sm11141465wmh.29.2020.04.13.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:37:03 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v8 0/6] Add battery charger driver support for MP2629
Date:   Mon, 13 Apr 2020 19:36:50 +0200
Message-Id: <20200413173656.28522-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

changes in v8:
 - fixed order of call in probe/remove in iio adc
 - add ABI documentation for mp2629 power supply

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
 drivers/power/supply/mp2629_charger.c         | 687 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  28 +
 13 files changed, 1115 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

