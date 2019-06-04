Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5A34AD0
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2019 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFDOrS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Jun 2019 10:47:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfFDOrS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2019 10:47:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so316791wrv.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Jun 2019 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yt/EFsCTs+eDRjlI5s+86AEQql4J6OURFSWUEUgIwAY=;
        b=baN6M5vHHdMEdDHA0nFhNKLj1v4lrLz/nftyieuU/YsutbB14+ZqYNEpKCERpyYdyY
         KfEROAB6KrYiQaz93M0J8PVgz13m3NGtdNqWJ1xTE5o2foyUiaCSXV1JL/NRcBmGMvii
         Igmta3mK59BorfpKlfs37UGYDEGK5rp0n81uMXCIiOgan1fD60rzo4kR5YisoxmAWia6
         vzGYjx+CQtuzF1TmS9ujEEMpgUpHBYYjhhhq1ssiw9JXBe4+LuEAHms+mXr6Dm/R/pVW
         vXIpo/MBppn4+0+HVYXy4hCWQl4om89a3HrTgOGakjpMG6DfKaviPoF+h4o3KgzIkCQc
         FgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yt/EFsCTs+eDRjlI5s+86AEQql4J6OURFSWUEUgIwAY=;
        b=XMFibhB5jykl3rUeAYAWB0tOKyxNbCXfXTAsPJ+HWbWKZv8RZcBB/wcJsuOxlyvciN
         3lzRni17dCJRmOZLC1fXhtWCui+2ADwPG0zIpEy0I8wrAl0CdM6+PnwNOaMMJ16AWEUa
         RiH3adafgI3WMwQzZB1HH6Z+ocRWNHAAy7jypUjZYK7PJ6OLL1i0CetOpesKSi8XtowE
         cwzEkEi6WyzL0qUxT0kSb6QHN0UkNnqz/+47WeIDuC/mb8Vbsj3BS3qJXBhYXganDn19
         anj0VKiSDFuIDd4CxrAC6eKz+eoGaa0bCqICat6dM0SvhM/+8B5eTC3jnXfO7xZf/vd1
         dK2g==
X-Gm-Message-State: APjAAAUHn9F4yRlfsVmZ8P5j4i2XsZwi9lTlsW6mEvENu8omY+bW0Q6t
        rlqd7z4ixt7erEPAtaiwYuC30w==
X-Google-Smtp-Source: APXvYqyK0vyzpLP2eyzKVrPgI3zNMenfqmRUVBELbtN9DV8WNr9ZkE1mQYmA68w6uUDtIpRGyxFb0w==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr6899078wra.132.1559659636696;
        Tue, 04 Jun 2019 07:47:16 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v184sm3649639wme.10.2019.06.04.07.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:47:15 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jic23@kernel.org, khilman@baylibre.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3]  Add support of New Amlogic temperature sensor for G12A SoCs
Date:   Tue,  4 Jun 2019 16:47:11 +0200
Message-Id: <20190604144714.2009-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patchs series add support of New Amlogic temperature sensor.
This driver is based on IIO frameworks.
formulas and calibration values come from amlogic.

Dependencies :
- patch 2: temperature sensor clock are needed [1]

[1] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com

Guillaume La Roque (3):
  Documentation: dt-bindings: add the Amlogic Meson Temperature Sensor
  arm64: dts: meson: g12a: add temperature sensor node
  iio: temperature: add a driver for the temperature sensor found in
    Amlogic Meson G12 SoCs

 .../iio/temperature/amlogic,meson-tsensor.txt |  31 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  22 +
 drivers/iio/temperature/Kconfig               |  11 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/meson_tsensor.c       | 416 ++++++++++++++++++
 5 files changed, 481 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
 create mode 100644 drivers/iio/temperature/meson_tsensor.c

-- 
2.17.1

