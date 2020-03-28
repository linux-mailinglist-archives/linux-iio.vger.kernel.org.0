Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CED196257
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 01:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgC1AMG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 20:12:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45431 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgC1AMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 20:12:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so13812882wrw.12;
        Fri, 27 Mar 2020 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ETNuk5HoFRvajcPB5SGInXBPTRaocJmabwQ1Y7pZBVg=;
        b=szKTbn7Jiys934mZuxreqLLDFQrlEVHV/AofHqRdBXdaHFq6+Pua50d4ivqc9PL5qg
         zZ+YfUqR/nYf3ck6yyOt1vOjn6w1UdkKL2+UgdJk8totMH2ndHqWQqZAR2CTBr+jIetc
         4GLiuTqXtcX1xgMUyEEUxmfWk/EK7SRca4o6l8wrIaaYvrbmczx0mJUBqeH85RDzwcaB
         nlR9RdemOAKNJObKVj7xNvbsDOUtZwNR+aAIouAQWrCjgO3tbzdb2nfb10VH7MXQr+i7
         NSKQwq1Jo6gST/SBpnTP4OE2EDg4Y+XLLM7u66a3QGtyc+OGNMIt7QhVt0RtYGC4PiwU
         7k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ETNuk5HoFRvajcPB5SGInXBPTRaocJmabwQ1Y7pZBVg=;
        b=kZFTonwd8zOhLEs9bEjyv54o74S0U9DrVp+2baSrvHmNBH6Bw42y4oUFFZ+gIpyAz0
         HprWTlYwm9HA/vQSoprv7wXVxqsSAfhIORD3oR9/+Ec5vi1mF5UJ9NpL++gGW9eDgA66
         dxFHlFKnGiEILEYl6XIr6zQ5AA2P70kU9dFXvDxk0rx+nUu92l3UNUmBbydXtkz5X6kY
         /SSwMk7mxrEaVvZorS4yEUjervD7spr076OW1yXC6K7ZvwWq10L3/Pbu9SFvQNCOyFFC
         xWd41XKKJ6ZdP9S8TYJU+Z/yklK6EZ/uidD0dX5LF5y/B6fo92DwoegBQgKO5J3Om5pR
         PQ2w==
X-Gm-Message-State: ANhLgQ0KED/oyICmHeneUYxfEUdFf2TVpGdyFsWlWkYLzsBNkPGMZh2q
        I1Su8z97wjnOzGmehP6YtGqvcBXsZpc=
X-Google-Smtp-Source: ADFU+vvGP/WBIzxxjjBTJSg0UHtTPuXBpCde+gIzwWpVYnjVPJ1UEIOppTESL3dr3zDiVzMU6zZgtg==
X-Received: by 2002:adf:a387:: with SMTP id l7mr2086993wrb.250.1585354323958;
        Fri, 27 Mar 2020 17:12:03 -0700 (PDT)
Received: from localhost.localdomain (p5B3F7536.dip0.t-ipconnect.de. [91.63.117.54])
        by smtp.gmail.com with ESMTPSA id 61sm11237956wrn.82.2020.03.27.17.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 17:12:03 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     lee.jones@linaro.org, andy.shevchenko@gmail.com,
        robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, sre@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 0/5] Add battery charger driver support for MP2629
Date:   Sat, 28 Mar 2020 01:11:49 +0100
Message-Id: <20200328001154.17313-1-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

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
 drivers/iio/adc/mp2629_adc.c                  | 209 ++++++
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   2 +
 drivers/mfd/mp2629.c                          |  86 +++
 drivers/power/supply/Kconfig                  |  10 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/mp2629_charger.c         | 686 ++++++++++++++++++
 include/linux/mfd/mp2629.h                    |  29 +
 12 files changed, 1108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/mp2629.h

-- 
2.17.1

