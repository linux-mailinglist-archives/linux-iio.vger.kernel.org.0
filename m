Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5743246E6A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 19:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgHQR3b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 13:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388445AbgHQRFm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2020 13:05:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6DBC061389
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so13596269wmd.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2020 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ch+bM0/nUYIOT7cRcwubqqUU36WUEhTLPi7zotN6dio=;
        b=ITRrUO21ngebvWm9j+03QV3n0tPRcS57uZLesFg4Fh73jpL38IRqaUiFq1ht2His/g
         kwv8RvVgsdoEOzEV0e3sf6Fon8eelIScjRJWN6ShAhQcqGU1azZ9eiAZQNtOB9BxIswP
         o9PsFIooXcNuqKqc110bJg8pddoTCQT+iUOu2nJOA54wkClOHHdURoLj6FPntf0ZR4X/
         OB4lxJCMFv15zZ4MLzOc5jbQqqxU0XoHhO7mJLyiJBwTOu4zjU1JJHVBhK9qvV7sX1NY
         w6jDFZq0L8f5Xwwev6/20uZQT9/OJZsERAmwn9ehlKmuWVBNvDYgXdVoZLToQw7TbpLy
         D4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ch+bM0/nUYIOT7cRcwubqqUU36WUEhTLPi7zotN6dio=;
        b=tanef5fvizvdVhGWKBUrKTP1wdPW4FwLEkkgaH23CSss13RbvNPKhZtqv9PsHs1Pr0
         yCreCX82y6MFxPtowfJTeB3wLZCQfchqcTHjCEYerEKjpDVSwd0Nphf+fg/5y6kP4/y0
         9ymSE16Mz4G7X6nv2esTPZrI54gr0ppeB+/fHerCwchrni30YjacY1piZzKBEt1XKl3q
         PNI8Uy7H1xqDxO9b/iipETXCj+VfSVyp7+/HeauflyeyhFG0BZ5m9++UzKPboWIf/Psi
         I5zqbfdyEmOdzsClRWo7inmSBl7WugrXPjih14mfFLD1T0ks3bfLLJZD8oLbmwMzr0Uc
         oioQ==
X-Gm-Message-State: AOAM533CasczC9i/j/+tECa+Bs4067dhp/7UmlaFDiEtxMFAUXulg5bg
        zhBCqecsjGbCkqj8DuTZKIUqrA==
X-Google-Smtp-Source: ABdhPJy54z0Stss+3IUESXNQ+OZuPidLgQs6L/EOj7nJxU8HbSFzXIkZDadL+9l32ahhBkJk1YCBsw==
X-Received: by 2002:a7b:c242:: with SMTP id b2mr16109424wmj.90.1597683939473;
        Mon, 17 Aug 2020 10:05:39 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id k184sm29747177wme.1.2020.08.17.10.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:05:38 -0700 (PDT)
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
Subject: [PATCH v7 0/3] devres: provide and use devm_krealloc()
Date:   Mon, 17 Aug 2020 19:05:32 +0200
Message-Id: <20200817170535.17041-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Greg, Andy,

this is another reworked version of devm_krealloc(). This time without the risk
of sleeping with spinlock taken but still with enough protection for the devres
list. We're using slab's ksize() to determine whether the new size is larger
than the current real size of the chunk and then either return the same pointer
or manually alloc a new, larger chunk outside of the spinlock.

===

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

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 93 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 ++----
 drivers/iio/adc/xilinx-xadc-core.c            | 16 ++--
 include/linux/device.h                        |  2 +
 5 files changed, 113 insertions(+), 27 deletions(-)

-- 
2.26.1

