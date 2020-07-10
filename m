Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0352E21BA95
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jul 2020 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGJQPW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Jul 2020 12:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGJQPV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jul 2020 12:15:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7F1C08C5CE
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so6544088wrm.4
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2020 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vPUXxzXeGlnq1ZiHx0yDQxVggNKEEBwatkvINr5b3U=;
        b=D3z2EgQ3LfL5O6tfLeHTEAqFU/QuxHc6dLUveKrSeu8pCTk+DWU6wwowhGSwcqSp17
         dlID+mPfggDJRpNSdp8sc5scypx9H/ZEBg4tJDxgqU/1DTnIWG0KQdiD+Uimo2y5oCQh
         sK5aK2/Trj4yQ1DII0Xfwvg4xdV8wry9DUVHbkMecPKDM7DUR+fPj/un/E0yHCOcXs5y
         Tywdj2iQNcP+DFk2boREchX3VQUrdtI/5tVGRKhu7tH/xsT6TBHOsght5Swb4n+cVGvr
         5ST8ht05dAa+6WYeqYhg4KXYy2nLPKeQlY9jGKH22SYQGq0ORluCE6oy4DMRpk2baJU/
         irPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/vPUXxzXeGlnq1ZiHx0yDQxVggNKEEBwatkvINr5b3U=;
        b=HOhiSVgNqZCg2Qbm8oVb+vwI6yb9Jf187mscNwE+ZiLMRWHyMbqikE/wJ8BtCHt5Hg
         vOzClc+32UEPY86ewuIlsn2sy6V7ZGHfw1djz5H8+yU0utzd4fszkxSedtvrzCqeiRpa
         vViTnMKw24E3WO0KnALgeUxv8H+4KkQrmlmbFNkdp0IRv513nMiLPDoJSsFWMtRDSmMx
         bUGNhbE1/7m0oZUERT0QDcRTVaYNJGmJ6LLY46rv3LMJTy0K1TrulChF63Y9Ww4OVokB
         aWIf86FHpHp4fEpZCbpGeuEtZxBbq1/bNhbTxh577RUBu1NHuJTIoIglqWsF/6LBINcI
         KhRQ==
X-Gm-Message-State: AOAM530XlIOfdKQmpmOXE9RxKDyUxRyvzbUyWSCSx5ldReqvKbak1n8o
        +MmkEiFfN01MBQzveSSltbgzcQ==
X-Google-Smtp-Source: ABdhPJzyp5bJ8ltFB6zHj7EKTwCY5Eopz4BIDAohnS82UPKO8R6qn1ZyOecy2+fAN4nrQX5rouwPAw==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr73581485wrn.392.1594397720362;
        Fri, 10 Jul 2020 09:15:20 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id e8sm11179359wrp.26.2020.07.10.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:15:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 0/3] devres: provide and use devm_krealloc()
Date:   Fri, 10 Jul 2020 18:15:13 +0200
Message-Id: <20200710161516.11625-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Greg,

As discussed, resending the remaining devm_krealloc() patches.

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

Bartosz Golaszewski (3):
  devres: provide devm_krealloc()
  hwmon: pmbus: use more devres helpers
  iio: adc: xilinx-xadc: use devm_krealloc()

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/base/devres.c                         | 50 +++++++++++++++++++
 drivers/hwmon/pmbus/pmbus_core.c              | 28 ++++-------
 drivers/iio/adc/xilinx-xadc-core.c            | 16 +++---
 include/linux/device.h                        |  2 +
 5 files changed, 70 insertions(+), 27 deletions(-)

-- 
2.26.1

