Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94E62208A6
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgGOJZc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbgGOJZc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:25:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D9C08C5C1
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so4847892wmf.5
        for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2020 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxEQuTmqko+pgzijDd2lGbDRaEjjMMNtGU3cvLEaE6E=;
        b=S/n86HB008axGB6WKz9m+NdU+bqcERxKeXWGb+MQoYnuj23/rvTNA/HzyJOsXElTUa
         kMBNN09IM8T7a410mbjPH9IrXuuq340M4y9PK7byTyrJZwHUOHbvhm7AcYY/eX7etFel
         PKOEE2Wvi3JJ4qp+02qOQoiegkfD09R+TPpAE6T9dQRDlJ4ur15/kQcEXisqt5SV0+FP
         g1INpsSjpPPU24d3RlzcCgeZRT2zHFjOo7M9e3gyMNpFQxGUEWqVc+AfDmhQCsXvGSb6
         M1/x90AKy+XbFF5iozX5hX48gucEuA3aZypkMMHdbHnDxOnOPyH4JuSphmOgqZyH6kXn
         JOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxEQuTmqko+pgzijDd2lGbDRaEjjMMNtGU3cvLEaE6E=;
        b=QHkkEjSpJO2VfWtGp7mWtnvkxUhyn8xuz+Yr6w7ArmlGwDNeo0EACxvwRu/SxUAF5S
         uPUsxS2cWzswEICFrGcvvSn6QPGlsyvtITNX//U9tI5a7BTnTIJJUuBK2SknvT+bc6GQ
         l689rcUMxJ8mel/JDoNgJxlYJJ/L96JGhTmytt81Fbp20UE+vb8133gOdqVScFRpj6oa
         GmQzxHlQrTjQvSeFh6VlDJC5cP3/ErTGmLU/BnjZDqCcA1cKlJQXWAwR5hiHytWyhBUN
         vBeQLNARxz3lUJv8gLWhm8UJLyPwknFDiLA9do7Yt+rJHK8Z1Xbd6XGRwAwF7ZavVJc1
         Oajw==
X-Gm-Message-State: AOAM533KEYf6ifdGp3P2P0I85fuAhjpWOapFvJGv8mNSiiNvd4pnFxhQ
        fhRmawN7scZuorifyTo36RBNvQ==
X-Google-Smtp-Source: ABdhPJyommb1Qc2v2rVIuSC6qsOykeoBwgjcpJYFj8Qs7T2/nah5bDGTDtY6INNmZRnI240Jm9Mvyw==
X-Received: by 2002:a1c:2805:: with SMTP id o5mr7861943wmo.25.1594805130724;
        Wed, 15 Jul 2020 02:25:30 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id v11sm12083419wmb.3.2020.07.15.02.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:25:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v5 0/3] devres: provide and use devm_krealloc()
Date:   Wed, 15 Jul 2020 11:25:25 +0200
Message-Id: <20200715092528.8136-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds the first users with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

Some additional changes to the code modified by main patches are included.

v1 -> v2:
- remove leftover call to hwmon_device_unregister() from pmbus_core.c
- add a patch extending devm_kmalloc() to handle zero size case
- use WARN_ON() instead of WARN_ONCE() in devm_krealloc() when passed
  a pointer to non-managed memory
- correctly handle the case when devm_krealloc() is passed a pointer to
  memory in .rodata (potentially returned by devm_kstrdup_const())
- correctly handle ZERO_SIZE_PTR passed as the ptr argument in devm_krealloc()

v2 -> v3:
- drop already applied patches
- collect Acks
- add an additional user in iio

v3 -> v4:
- add the kerneldoc for devm_krealloc()
- WARN() outside of spinlock
- rename local variable

v4 -> v5:
- tweak the kerneldoc

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 68 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 +++-----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++---
 include/linux/device.h                        |  2 +
 5 files changed, 88 insertions(+), 27 deletions(-)

-- 
2.26.1

