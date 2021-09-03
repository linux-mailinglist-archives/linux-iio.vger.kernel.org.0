Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3FD23FFB13
	for <lists+linux-iio@lfdr.de>; Fri,  3 Sep 2021 09:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347902AbhICHac (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Sep 2021 03:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347849AbhICHac (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Sep 2021 03:30:32 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86028C061760
        for <linux-iio@vger.kernel.org>; Fri,  3 Sep 2021 00:29:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j13so6665900edv.13
        for <linux-iio@vger.kernel.org>; Fri, 03 Sep 2021 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekf0tTe+UksiJZAe0IEXYzcP2+qOht3uGqxEaoxjwBA=;
        b=OlxauCCLhYYRz4elA1LozM/5bZUzuO3pj13UWhdg0v1DmyuFma0D9zVOBKePiJYidS
         bfgS9EYJHEtAGxSnuNjoSACEfmjfgxap3hqKMDA+GkioMkxXvhuRa8/0+qno5OgsWW5M
         bo++q4NOBQ4zDTHL0h1VQ/RR0OH3LxjmDheEZBTisfVpcwQjVwvZwHzSeRUonZhhRUFy
         EzKjB64OBsdas2+9lI/wZMZZYo+P5l1BeASQNURkKgOA0vi/tTxYEKRMROKUiYLMQvmg
         gqyE9xrOYvJr/bHCDbJzVXZ+ENAAeXjRVodD0nKVlhRDP8bXbsXZzV3MDlUJ5kBoA7Bz
         RHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ekf0tTe+UksiJZAe0IEXYzcP2+qOht3uGqxEaoxjwBA=;
        b=omPzqTp3WjNkBbtltoezVgMUr7VtXV8jof+DKa/J8CRV2XoqaNefqKaioSSoo2n4nl
         aYb9qR1mhFwggiMQ78+OmM3T7sTP0q9tzums2bAt9Y1Q9MFNAPncBKrn0SRB3MFKhUrq
         sHZosdybhVMpJgdvRRN64PyOJcmYZuCJD1BQBR9K1JLz5eJNWqylOoJK2B+K7xcLVrzA
         EDBozgW51jeXhjZ74xaDCENpLeyeTPQIfAoNIdZ1Wt+I3JG5o2GnzDyEY6UZ2ZvBbVnz
         1tf+nqeQyc/YE5D2NGLm1YVfxy+rMlJVWbVErdha4idhHtWmGiItYecGJwMq1l2QSE9A
         e1Og==
X-Gm-Message-State: AOAM533p/ff7q0Pt0ajd1mJpMKopzr4LmpRmJ27Dpl2MxQjRmmttTIqS
        w6g1H+gvg55V8Vh5CcHtMk4UL9KArKSQKA==
X-Google-Smtp-Source: ABdhPJz2809/gReIm8coYbjtkoU3QN26LBeWDWkavUne/fWFR+uTGPNqn7tfcg1JgfFeon9uGsc0aQ==
X-Received: by 2002:aa7:cfcb:: with SMTP id r11mr2595018edy.14.1630654170805;
        Fri, 03 Sep 2021 00:29:30 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id a15sm2376969edr.2.2021.09.03.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 00:29:30 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     jic23@kernel.org, hdegoede@redhat.com, wens@csie.org,
        andriy.shevchenko@linux.intel.com,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH 0/5] iio: device-managed conversions with devm_iio_map_array_register() 
Date:   Fri,  3 Sep 2021 10:29:12 +0300
Message-Id: <20210903072917.45769-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change introduces a devm_iio_map_array_register() variant for the
iio_map_array_register() function.

And converts 4 drivers to full device-managed.
These 4 drivers only call iio_map_array_unregister() and
iio_device_unregister() in their remove hooks.

These 4 drivers should make a reasonably good case for introducing this
devm_iio_map_array_register() function.

There are 7 more drivers that would use the devm_iio_map_array_register()
function, but they require a bit more handling in the remove/unwinding
part.
So, those 7 are left for later.

Alexandru Ardelean (5):
  iio: inkern: introduce devm_iio_map_array_register() short-hand
    function
  iio: adc: intel_mrfld_adc: convert probe to full device-managed
  iio: adc: axp288_adc: convert probe to full device-managed
  iio: adc: lp8788_adc: convert probe to full-device managed
  iio: adc: da9150-gpadc: convert probe to full-device managed

 .../driver-api/driver-model/devres.rst        |  1 +
 drivers/iio/adc/axp288_adc.c                  | 28 +++--------------
 drivers/iio/adc/da9150-gpadc.c                | 27 ++--------------
 drivers/iio/adc/intel_mrfld_adc.c             | 24 ++------------
 drivers/iio/adc/lp8788_adc.c                  | 31 +++----------------
 drivers/iio/inkern.c                          | 17 ++++++++++
 include/linux/iio/driver.h                    | 14 +++++++++
 7 files changed, 45 insertions(+), 97 deletions(-)

-- 
2.31.1

