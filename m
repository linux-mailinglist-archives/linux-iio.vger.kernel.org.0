Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8078926461A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 14:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIJMdD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbgIJMaR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2020 08:30:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB04C061573;
        Thu, 10 Sep 2020 05:30:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o16so2950695pjr.2;
        Thu, 10 Sep 2020 05:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbUyJpejCvA3QH4e+Y9L0OkTzMxPfcFa5isJNJNYA7E=;
        b=L83lmbXn62t2KoWiiJa4Ud37GMfgoGFWAg7J/Dc/LIscdl6vRTajTiCs/dMkXzGrt+
         iVmZIHm+AnoSSXfsFfj4YZStKjbvqHIuq+xalIpfLf9Xua45jbFornXmnxodVvBvIdFo
         YVG2n4mQPb707GtkHSmNF2bfWto+INtyObzvTNO/nP4m0sGuJLnSnf4PUneQHaXAvy2z
         5T1T3pAdRbFghk8pNaHCo3oqR4XkO4K7dLyDe3B+wMDBCEfuhpP9NKZgB4LI7fqXLVTc
         D4sMWDRJ1bTXp/Z5YqS72J6sYK6t9QFnSFdxcBSI9+rHOGr2YK9ns2R1BqCmRZHlIwpY
         3OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sbUyJpejCvA3QH4e+Y9L0OkTzMxPfcFa5isJNJNYA7E=;
        b=lza1pPD7VFzAbLswIz2E73CEgVRmfTKMA7AcNzdgHxGxrkL2LSFSRhu5IP8voDJR3Y
         k0yvu6ZHKlGoYdAkCs40VPwMKuJZmz+8vxpIuhgEbVUA/YOjzjgD/VkFT/o2B7L25u4a
         t58kNFwijQyHk+Po3zpGQt6zTiveOJdWnRuKPp9qcC+NYwcFFjtuLH/UqlF/ADKkQw7N
         z+WfpZvfi+mjm1xfmQ/1rT8uBdw4KjjezHUHOOInH8VQfqwYKJhZrwIIHTMH0qU9guz+
         YNHOkNd9qeP/r0kY77BqqChz3+bPAaIwyXNqQw5H8aNXm6YlHlZ5TJjWXpjRYjn5+A7H
         wmwQ==
X-Gm-Message-State: AOAM530vOtCKtdw/6VwCVFMOFNUzk5xcRKS/MCa+Q0Y98992SOCcLAo/
        t+9HKXihyidWeEDm0RScXWQ=
X-Google-Smtp-Source: ABdhPJzekdrlUSUeFneXBL1UfmVjrIpSfafPXKDdBXV15YzmHyjigIVzGsaWWe4H2emR2rkp/hVR4Q==
X-Received: by 2002:a17:90a:d488:: with SMTP id s8mr5244871pju.176.1599741008666;
        Thu, 10 Sep 2020 05:30:08 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6218:54d7:9928:e984:12bb:783d])
        by smtp.gmail.com with ESMTPSA id s8sm6512727pfd.153.2020.09.10.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:30:07 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH v3 0/3] iio: gyro: adxrs290: Add triggered buffer & debugfs support
Date:   Thu, 10 Sep 2020 17:59:57 +0530
Message-Id: <20200910123000.16860-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce DATA_RDY trigger for triggered buffer setup; this enables continuous
data capture. Additionally, add support for direct register access using the debugfs 
iio interface. 

The device-tree bindings documentation illustrates an example of using a GPIO irq
line to trigger a data capture.

Nishant Malpani (3):
  iio: gyro: adxrs290: Add triggered buffer support
  dt-bindings: iio: gyro: adxrs290: Add interrupts support
  iio: gyro: adxrs290: Add debugfs register access support

 .../bindings/iio/gyroscope/adi,adxrs290.yaml  |   6 +
 drivers/iio/gyro/Kconfig                      |   2 +
 drivers/iio/gyro/adxrs290.c                   | 237 ++++++++++++++++--
 3 files changed, 231 insertions(+), 14 deletions(-)

-- 
2.20.1

