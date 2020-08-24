Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639122506A6
	for <lists+linux-iio@lfdr.de>; Mon, 24 Aug 2020 19:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHXRjI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Aug 2020 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgHXRjG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2020 13:39:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1E6C061573
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o21so9025845wmc.0
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2020 10:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHqg/CRd3ImS5C9/z0529f/sgF1Y8XoJ8ekTa/Kbeao=;
        b=ua8GVG/wkZhFJ0nIz55IgC5mKz64cCXHEZh8OOq+bgoz7H1Jx6HwMl4N1S5vVT5wnd
         mno1udnNO1eRtrBmID3NCP+QZTMJBaA9kail1BX9zI42pqVXxqgOeUeLmdrUc61fF8UZ
         ZXUjrZ+W9pm2GwriQ3Gwfdbr3wYQKqGAsgh7CLuJJqCswrR0Kl3ZctHiDD9vGCLUZcA1
         Ctai4tRtrkCU5qZ+6GHuWGppBdzhu1cSWG4XtZv7xUghqrOajjhVCWRlBXmLGXNTIAgm
         Knw1sB06QFJU8qfzkuhkFoid/ptQrThXWttttA7kvk2NviUj9k6mBc01BxwBImLvlKwy
         bLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHqg/CRd3ImS5C9/z0529f/sgF1Y8XoJ8ekTa/Kbeao=;
        b=Eb5Ez4gRzICPRBbn9cwukKW/v9TxqsZQ2sbdhg6TXiDe5r3N/Rfin3yplkFT4rS6kB
         JSNyY8QLvNyZAhIrFsmYk7mCRe1uPiORdetDNYKXisLtBZO7zathKOiVm9oVUiIONDyT
         8aYFbLdc9LqPL+wFCqHEP7TLzvFZOPSRdXhUcKIqZB2rmxgCUwXbqkFfmzuDw52FbUuV
         FfztfNylfMs6Lf/FbpxOw+0kkxjCtPVWJJ/af12e6wt5b814y8CSt4Tikqdb592Dh0oR
         NNqD8wo/KKscJMrBhVHU9ar2nuA7gTFggrUBunrDB4S9uy3z21nBZx/eZsjROca8LZCA
         SOfQ==
X-Gm-Message-State: AOAM532oeUBC5ssxHEgEEQSqa7pKDJZ37dqQ/cu25Jc+i3YYNOGBjul7
        jtygSTtDtylW+xhCgC7lt9iB5A==
X-Google-Smtp-Source: ABdhPJyzldmOEXlL6891aI7qL7sR+2Tl5GOk5HnmHxIL3oR6HsnWwls74S99vrVXQdme8MY2daqqOw==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr344446wmb.67.1598290743340;
        Mon, 24 Aug 2020 10:39:03 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id y24sm471977wmi.17.2020.08.24.10.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 10:39:02 -0700 (PDT)
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
Subject: [PATCH v9 0/3] devres: provide and use devm_krealloc()
Date:   Mon, 24 Aug 2020 19:38:56 +0200
Message-Id: <20200824173859.4910-1-brgl@bgdev.pl>
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

v8 -> v9:
- use container_of() and offsetoff() instead of manual offset calculations
- use kfree() instead of devres_free() in error path as the latter expects
  the pointer to devres data, not devres node

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |   1 +
 drivers/base/devres.c                         | 105 ++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              |  28 ++---
 drivers/iio/adc/xilinx-xadc-core.c            |  16 +--
 include/linux/device.h                        |   2 +
 5 files changed, 125 insertions(+), 27 deletions(-)

-- 
2.26.1

