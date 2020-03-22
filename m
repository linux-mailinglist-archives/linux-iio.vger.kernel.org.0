Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDEB218ECFA
	for <lists+linux-iio@lfdr.de>; Sun, 22 Mar 2020 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVWa2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Mar 2020 18:30:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38486 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCVWa2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 18:30:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so12691147wmi.3;
        Sun, 22 Mar 2020 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KmhmWvbFQMFZ6mT9PflSCZYk2Q9MLpXo0b38vOV/huo=;
        b=qKvlR8UZo869TWuxLhPj8rpzsiltXBzAlT8WI42WTOceU8atrga9CuPmv4Bnw3fn8F
         bSsTGM7U+3owTwyqllmdY6qxE6nEnCqks8a5gYvS7+8mHpMZ9CliLDApm4zZ2omZAREh
         ZTG2alF7LpL0izJGtBQzlEpPZaPvZgklu+gSMJN6Fzcsu/pGiQ2QOi/tHHYqUCZQZi0V
         2l8+W/dEOJSWdzlIqJHFFW0odLvsqWLOd5y0rxEE7u9+nN8HVfDg4C9/li9kGKj0apAI
         7Vy8fB2EdH3kMIgAy+79T+OWAaFW8rqptClSP7dBQpid9x3ghcjnwHwxx3Q+3iwIfYLK
         hgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KmhmWvbFQMFZ6mT9PflSCZYk2Q9MLpXo0b38vOV/huo=;
        b=rgA9tv7uhWwGqA7H7HyYEuBnhnF7znuWIVW1x4Uz2i3N0dVSo+V8kfZ6ub5UM/jZe0
         ds0B/Dl0JVSLY5p8b+Ta3DFxXKQqYrt3IN1WXxsWBwj4M/gZZVWmtTAHwDpme5RI7yHM
         MCQr1KhBAvHe/nwynbcb5sD32UY+qVDIkuXYYZcTljN06WeHYdkQn+1dYBTx4ichnjdw
         peh2UJ+LwSTWJuCo9ReSjeoEIVGMZwWx+tAU+mw4pEjxChsy79laY5/GGbX4qExpwZ2+
         5Skff1bwLTfywklCylzGlGh62Tc8SyX02bptJfx9waBkigosee1nI4vyx6A43zxlXk5x
         ZDDw==
X-Gm-Message-State: ANhLgQ0U5km8VJfNxHKNZLr6eavigzpb+JFpOXEFp5hGuWTHnl9T9bMR
        jgsHpIc3npw2WOxKTv9KJfD2pAa8OQ4=
X-Google-Smtp-Source: ADFU+vuTT5bbQSh/KefTnt7J+1b6IkHfRE4nG4EyJnPppSag2VG4qFm60LoTifwIDV0fS0MH0Z8Fiw==
X-Received: by 2002:a1c:a908:: with SMTP id s8mr24539211wme.133.1584916223913;
        Sun, 22 Mar 2020 15:30:23 -0700 (PDT)
Received: from localhost.localdomain (p5DCFFFE5.dip0.t-ipconnect.de. [93.207.255.229])
        by smtp.gmail.com with ESMTPSA id p13sm8060517wru.3.2020.03.22.15.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 15:30:22 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v3 0/5] Add battery charger driver support for MP2629
Date:   Sun, 22 Mar 2020 23:30:11 +0100
Message-Id: <20200322223016.11509-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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

 .../devicetree/bindings/mfd/mps,mp2629.yaml   |  62 ++
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
 12 files changed, 1158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

