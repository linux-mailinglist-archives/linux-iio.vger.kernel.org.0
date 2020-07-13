Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA821D94F
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 16:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgGMO7s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgGMO7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2020 10:59:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DA5C061755
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k6so16900864wrn.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2020 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiVSo3xlj6ss4Z1I13IdfwQU+nfjMMT6+mU8Bg5YKmM=;
        b=rSp1ckUHPmHljClMQoIDDSw1ZCB7+ygalxtu5lHGTlN5T3q2RVoH60LPL6a4oxo/ty
         z0HQV95Z9mU86Vd/A/IUFtH/uJjLYmNuqYNKD2NYrejOVpNvFarZV+J0Ec+pnQT/Abgb
         HpclKpTNjEG/gl3XYssuh1rDjk5AjdDUrI8OuRabw5IccTvCHZGuWSTAi6tGsC2/FQVF
         nEBBDzZbPQXKqoIyz6Ltu3poOOlhxF3n8CguwS4Q8Xc0MSO0dHDE9sNxR/Y3ADBUUksn
         pu6EXZbVF4tml637IPR+2tIrGMvndreNuw6dnTpm28gZLa9qxm/+P+SfiwGENPndp3P4
         AiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hiVSo3xlj6ss4Z1I13IdfwQU+nfjMMT6+mU8Bg5YKmM=;
        b=HO8p90WuRCcqFMgH94r/+zxhbH89oHe9CNJKb9kemB0QgN7bi4Fgrayl8eRVIYd6N+
         CDFjXDus3FR5+x6nkj4VUxseyvTasz/uPtf3H9l6WhK1Vb5qFRpkcRenLTjVt6+2AS32
         d/2jAW66o0BlYwD8vRUzogLEUT68QjUGpyQtLzYIAbS1JSgm7fRqBkpX7usNH7OGCYGE
         OkzpVosBJj+eiswJXMvplzm1+PwISBHW2mWGYQJoVb/RtZAec9k3rlfZTKoJ8elnuJX7
         o40Zv3KSzmxcfHsscppDyVLqMJNmUOsYgAshGUATQOUtohpTfFnJvG0ZUaLvCwTb/He8
         cNIg==
X-Gm-Message-State: AOAM533cEk/9zpZbJb0aqflAeFZTSsm80jaZSg39gO1ogNA1j46dodLZ
        N2aqZgk1bYqai+OQaPkGoc6g5Q==
X-Google-Smtp-Source: ABdhPJzJvIhOZM1tW3JbhqV6XyxG2YJWfklQ1nvdDw0QVKBI2giA+0EpuZ7a9S9IT9ipoa2QgtDwsQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr82938978wrq.189.1594652385764;
        Mon, 13 Jul 2020 07:59:45 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id u20sm21991145wmm.15.2020.07.13.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:59:45 -0700 (PDT)
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
Subject: [PATCH v4 0/3] devres: provide and use devm_krealloc()
Date:   Mon, 13 Jul 2020 16:59:31 +0200
Message-Id: <20200713145934.18243-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 67 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 +++-----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++---
 include/linux/device.h                        |  2 +
 5 files changed, 87 insertions(+), 27 deletions(-)

-- 
2.26.1

