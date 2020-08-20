Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89324C5D2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Aug 2020 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHTSvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Aug 2020 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHTSvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Aug 2020 14:51:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F392C061386
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so3101047wrm.12
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2020 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ameYpcCA2W6630D7Ht8ESefas4lH/iMvLqK3bNcEnI=;
        b=mC1/OzJHy2Q6KdGaj8c/Xxnq3vlZKin57UYP/FhZHGChWhTrRL0+zkQNFqeZolsP2J
         93Dbh46OdIPyFugBQlqsm1gAhoYg4CwJpsZjeaw47CIsY7/tocWRIX5Mmj4W7Cm3whb2
         gbjsgb1YIruGDmtvd8CUqcIYdejOUMNNX0pUMqwOo6YhW0fOlP25apL8VD1vnaV53qz7
         ekb6+3Whv94Y70IDNeS7JggOgM63GK5mz2Wy6bdpJI3PtAECGqsdp/Sie6jqhgfn3yci
         F359UzzzTBoRxkBu4ltLiPfO5j9iRssEhfpu33LwtAn0mqS3PzVQu2LpSR7BilSCPcA9
         44Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ameYpcCA2W6630D7Ht8ESefas4lH/iMvLqK3bNcEnI=;
        b=NRiksfXwMZJm+gziqP4EFub2QI1hDwI0CzSV5ICE5YZcDh8fg0o2/vbG2o+mU8/jip
         C9Yj+xTOVEc3vz9MGOMO2x+3uw2xa47naH6rPzdi8xUi6x9b3z7qlss3OgReNqcnw6Bb
         YCIos2WE0BWU5MF6d49ieu6AdkiCMKqnN5yZcCMzR9MCmxy3kmEXL2QVyzcipedF2LP4
         CaEblw0c4Oqk/Ujh+j7hwQeeYyysWE2XkVesf8nz8IgvDMGtZJuYLY+H9+r4jV1q9O/F
         VZPL251u3v6vMN8++4jygJHSy/5OrcaCAXgKC707BMq44ue5VZzayiv1WJSHQ5UlDZhu
         b1kg==
X-Gm-Message-State: AOAM5311S4uz363psVPyJ5IruF9FVzEECo0P2MboedJHHCmQ2jQ+QoT+
        w3PHVv+JJbMOpjElGfiTfHkCbtnkzbyFhA==
X-Google-Smtp-Source: ABdhPJx7JoCSuUmAo6zDhTt4HTnEcwB1mBZ6Nf/XfN5adGcmnixz1MRo1Mz+9qa1RMBohOjLfw1ktg==
X-Received: by 2002:adf:82d5:: with SMTP id 79mr96433wrc.282.1597949476975;
        Thu, 20 Aug 2020 11:51:16 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q2sm5694019wro.8.2020.08.20.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:51:16 -0700 (PDT)
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
Subject: [PATCH v8 0/3] devres: provide and use devm_krealloc()
Date:   Thu, 20 Aug 2020 20:51:07 +0200
Message-Id: <20200820185110.17828-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Regular krealloc() obviously can't work with managed memory. This series
implements devm_krealloc() and adds two first users with hope that this
helper will be adopted by other drivers currently using non-managed
krealloc().

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

v5 -> v6:
- tweak the devres_lock handling in devm_krealloc()

v6 -> v7:
- rework devm_krealloc() to avoid calling krealloc() with spinlock taken

v7 -> v8:
- drop unnecessary explicit pointer casting in to_devres()
- check the return value of ksize() to make sure the pointer actually
  points to a dynamically allocated chunk
- add more comments to explain the locking strategy and resource handling

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         | 114 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              |  28 ++---
 drivers/iio/adc/xilinx-xadc-core.c            |  16 +--
 include/linux/device.h                        |   2 +
 5 files changed, 134 insertions(+), 27 deletions(-)

-- 
2.26.1

