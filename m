Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8918376B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Mar 2020 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCLR1K (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Mar 2020 13:27:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56056 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgCLR1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Mar 2020 13:27:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so6988378wmi.5;
        Thu, 12 Mar 2020 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tRTDOcE7fsHdxjFeBfBurtdDlWQU7ALainfjoKXuLXI=;
        b=TjcM4aRz1p/IqKh4CQdcsbwb2mgAPvnbhOmgUrimuwIXMpQVbERUjJDZmrOpOarfsv
         bn9yID81q+YU12MHrYQXR8vHmjsYXTPJ6WrrDgq6deBLyVCxPlAxvJPG1P6UEG9g0qvQ
         47cqkrfUKaUa463o+u1JB8FrdF20ib0cHxUq6pHy/vtrtb0lrGflpK0bwe8+6nGpZrEu
         oPtb89RqXEGkW1paPiSIgnTwfixG6EwyK9+i1ROtkjq4s2dffq7F61MlbP+LUuXtPMO/
         MRI3h2tLYB+7Kc9T2ZWUt6ITMVSisKcshx0nTMN67inQyaA7Ms+5XhmZX3pKgYoOl2lk
         ibzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tRTDOcE7fsHdxjFeBfBurtdDlWQU7ALainfjoKXuLXI=;
        b=MWHv6Pg7ToE7pJCnGr7WBLvo1iA6NS/RxQnryDMCmolaggStQg68guwUXge6Xf3cKL
         2xoHwvWn+c47bs+syz36ja1vFkAU3B1ruEjdynDKYaqcLDCxeOiVaY/ILIqW1TtUzMIa
         s9xQi91u7+QCz6XYwcA4sYAz8H0dDTpsr+DMjHgimQt29pLL43BrwTkvkNPO3q4VmnVc
         Y6EMDlKAN8i27EiNrxGlPD7s3+iSR94prhpVpJ8jskfTJqu4WQbZHScwMQbsM35oAPPi
         y9j4f0Nr9edFF83TjQlVzq8f1SL8NzBnU8nSOCmpthHTBouK9CAxIxLFNq0t6UMA+jEO
         EzyQ==
X-Gm-Message-State: ANhLgQ2+G9KdCSJUf0LOWMhEpSrJpLxPCNrEUOwV+f2MuknkFAYo46XH
        gxAAAG+foyBhiH4HvcCZN5M=
X-Google-Smtp-Source: ADFU+vv2JNeETUkjt4XRMjD4pOUY3SEKCruuQnXZ1av+RQOoWdPdemVl/9NQ0PuV5rljgBWWyEb1FA==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr5661568wml.76.1584034027225;
        Thu, 12 Mar 2020 10:27:07 -0700 (PDT)
Received: from localhost.localdomain (p5B3F6C4B.dip0.t-ipconnect.de. [91.63.108.75])
        by smtp.gmail.com with ESMTPSA id c11sm76254500wrp.51.2020.03.12.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:27:05 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        fabrice.gasnier@st.com, beniamin.bia@analog.com,
        linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
        fabrizio.castro@bp.renesas.com, info@metux.net,
        hancock@sedsystems.ca, gregory.clement@bootlin.com,
        renatogeh@gmail.com, plr.vincent@gmail.com,
        miquel.raynal@bootlin.com, marcelo.schmitt1@gmail.com,
        paul@crapouillou.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH 0/5] Add battery charger driver support for MP2629
Date:   Thu, 12 Mar 2020 18:26:44 +0100
Message-Id: <20200312172649.13702-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/adc/mp2629_adc.c                  | 211 ++++++
 drivers/mfd/Kconfig                           |  43 +-
 drivers/mfd/Makefile                          |   4 +-
 drivers/mfd/mp2629.c                          | 109 +++
 drivers/power/supply/Kconfig                  |  14 +-
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 709 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  34 +
 12 files changed, 1169 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

