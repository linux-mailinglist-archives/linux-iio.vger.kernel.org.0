Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFBA18582D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 02:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCOB4H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Mar 2020 21:56:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36614 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCOB4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Mar 2020 21:56:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id b18so12782632edu.3;
        Sat, 14 Mar 2020 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BopwVe4YzpInbeND4HoB58qSHy7vjLOFIWj76C7HJ64=;
        b=jIBD9ifs4mqDJGCcXHWyyW4bwywFeg9+6yHHOUcdIDUaT+xtzwY4T4DmL0fklGpEJT
         Ya8cBHOFTp5RKjq2QnYK8/W0Q9b58FmhUwK20Wa0nUvarbUUGniizcB3QIq58YKE2iF0
         Iivx/vDt2LOiECyl1cfd/14aGsyOcK86OoACDKq1OQ7ES6j5+t4skGG/5YuYwJgR5mn/
         chOlX3gq3Y74vabPBWz/6YDPLp7KYua94R63gIS25+rpCFaKvFfh231BG8uehc+QuktT
         TWluHN5ALuc3dDe1XWpZagzrG8gFYiFoyxh9b7EvoBu57xPlv+Pyk3O5QeotBdTHq5Rt
         /h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BopwVe4YzpInbeND4HoB58qSHy7vjLOFIWj76C7HJ64=;
        b=lNFszkY7kHTmStT+M0fCW7SdEoqpIB0GyCpM9rzfwEthkzgfkl/KYz+/O94g+4hf21
         2RwkjCHreUvVfg/OHYnQlZH/qHL1jouGsXFE/DZjOG8+U417Ad6T8XusR1vIkhQ/vP6c
         AmQv7vnqAwMhDoHhBevD3EQrwRXxxauCa5IwoeP1f23R0fad484S2DGbKfi7LWHAnnf4
         oBY0WkGFoAUS78kMp4WvDnTUX9s+x4tqQDUv6H3jN6pFPcu9K5C74oS7s03pX3VY60yn
         EY5TPFnEwO077xsvh1RT3bGGUDh39YsVK/Vb+cHC1KiEmBI9tzqAc9sb41i/hsPHQORD
         hIrw==
X-Gm-Message-State: ANhLgQ3rCvufpsStgO+f2OWq8f4gGKpLS8f5//mbV9QvspKMDm2q5oTu
        aqSbAd+4/6g8DNT5SswbCM2JBXshLpI=
X-Google-Smtp-Source: ADFU+vuZ1bb7nbzzZHgugXobRAs4Tc2epJw3o79U0dRRej5zhyAlZo+HB775rGLgmAKAWw6rifbKIQ==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr27443866wro.207.1584230424960;
        Sat, 14 Mar 2020 17:00:24 -0700 (PDT)
Received: from localhost.localdomain (p5B3F731E.dip0.t-ipconnect.de. [91.63.115.30])
        by smtp.gmail.com with ESMTPSA id 7sm11394469wmf.20.2020.03.14.17.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 17:00:23 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v2 0/5] Add battery charger driver support for MP2629
Date:   Sun, 15 Mar 2020 01:00:08 +0100
Message-Id: <20200315000013.4440-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/adc/mp2629_adc.c                  | 209 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  96 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 702 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  32 +
 12 files changed, 1139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

