Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656732355FA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Aug 2020 10:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHBIfE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Aug 2020 04:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgHBIfD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2020 04:35:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071FC06174A
        for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2020 01:35:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so27902748wrm.12
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2020 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwR0cSDRK1MacipoHZSBkL1yx2DzBEYBuItL8wnBzYY=;
        b=sJFO8/dNG2dGuiR/gT54hMqO6QnQtqhcCLkM5HmWg/NVzNUCWmPXvt4Bd510UemOzm
         GN/QfXIpMzu/oAX81Bv7GBpyPrJk4vph5MByjFxysIGgsnBGEVAG5jkaX8f/LCNpOQNQ
         Vaw0z/czRYrMJOgIcPbhpJEsaLTaG8fop7KNF7PqAsJ3ho3gBkUk5x0d3uiyNe8swLTq
         2Lz70pmXu5+HB+9aa20R6jZ6/ViVkuAtWZnlgM1y7CcrwwtPis639LaCxdLFIXC6q9Uk
         b/SZz3MPXR0A24BbjHVD82xsyKT4FUSxzlVWYOlgICNrOMThzAgEtmASAbNgnv4Ut4W+
         VQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nwR0cSDRK1MacipoHZSBkL1yx2DzBEYBuItL8wnBzYY=;
        b=qXEWP8EUu3JH/bFiKElezeVohIQ1YOip4RXzh0Up61js7GJ1HSFA/bvWSFi+QcN02e
         VtsllAhgyAQqzzmoBRJTxS+8PjtcEHv+Y1kE2PjoYQEt0OqkY8AjEJSsIaue9NUVvbEG
         hN+bsEWzU8CAoSD6bKD7/dWpHOXMrsz74E0HJthdO9acqglO76NyNa8isJvkVwxjTnN7
         qpuRBVf//fkIcs0vow1gc+7Fo1fCXlAe+uL9oZwLKJe5o/pVX1KsObdoUCGwovS519Nu
         gH64y5/FIRMdYKwDTptH8RuKVJQaTxOQrfW14VbPueV1hDQ9Zgobxrt/gC3yFswROSwn
         LGYw==
X-Gm-Message-State: AOAM532NXOWbe42EiBCATaYNGbZBTOlNQVt/l/9rNr1KXn4zzPq2fggi
        zWAUYTErKnYiuKZNS18Z2yWn6QhMF18=
X-Google-Smtp-Source: ABdhPJysVYxzaXR2wk/8PBfHv2MvKUCCN0LllR0j3hUk2LNHkM3/+4zmSNtDZppkp6vg4/90vF9krA==
X-Received: by 2002:adf:bbca:: with SMTP id z10mr9899567wrg.425.1596357302104;
        Sun, 02 Aug 2020 01:35:02 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id d14sm19281466wre.44.2020.08.02.01.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 01:35:01 -0700 (PDT)
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
Subject: [PATCH v6 0/3] devres: provide and use devm_krealloc()
Date:   Sun,  2 Aug 2020 10:34:55 +0200
Message-Id: <20200802083458.24323-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Greg, Andy,

this is a reworked version of devm_krealloc(). This time without the risk
of sleeping with spinlock taken. I noticed that devres_lock is only there
to protect the integrity of the devres list - we can assume users are sane
enough to not devm_kfree() chunks that they devm_krealloc() at the same time
so we only take the lock when manipulating the list now.

I dropped Andy's review tag due to this change.

===

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

v5 -> v6:
- tweak the devres_lock handling in devm_krealloc()

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 65 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 +++-----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++---
 include/linux/device.h                        |  2 +
 5 files changed, 85 insertions(+), 27 deletions(-)

-- 
2.26.1

