Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4544F381FBF
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEPQXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhEPQXN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8BB961026;
        Sun, 16 May 2021 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182118;
        bh=feuH88ldjTKNpaHd0e6qdzKNupf9LZLdMOPuktNQl/E=;
        h=From:To:Cc:Subject:Date:From;
        b=qP9NAa8au8iPipa/TKMMTGhSxMJIj55vbfsYUBSRjozgDlf/EUecKjwjHva6L/8gy
         iMHdF8xl2JgwA/JIYuELREV75TcELMQ/hRb3QtwUPS8cXfPrrrAO58eV5+BxjyUdOA
         Uk0XqYO62nmhDN+p9LHppFFlhg0JX/HkQRmfVSX+tPoTDthViSOkuFowDaBJ7pFkxL
         e5vbih6Q0zh6VwgPHDlX2W9tfD3fAPc/ZtUSymxxn/OOZALXVpqjHk3FGZYnhnAZbE
         ZAo72NmojZ3pM+/2VPdPqss/REPKmjYBiFQXNMaoV6n9y4bT9rl1pZSN1BKBBFnVfJ
         l7uAIW9Q1f6Kg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 0/6] IIO: Runtime PM related cleanups.
Date:   Sun, 16 May 2021 17:20:57 +0100
Message-Id: <20210516162103.1332291-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Changes since v1:
* Drop all patches since applied.
* Clean up some more unbalanced cases that Mauro pointed out.
* One additional fix for lack of put in an error path.
* Dropped zpa2326 patch for now.  The use of runtime pm in that driver
  is sufficiently odd that it needs a closer look before any changes.

Note the unbalanced put is not a bug as such, because the runtime pm core
protects against the reference count going negative.  However, it is
a bad pattern to have copied into new drivers (as it confuses me)
so I'd like to clear it out.

Inspired by Mauro's work on similar issues in media and Julia's
coccicheck script.

There will be at least one more set of these once this first set
have flushed out any mistakes I may have made.

I checked my assumptions around the excess pm_runtime_put_noidle
calls in QEMU but may well be missing something even so.

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Jonathan Cameron (6):
  iio: imu: mpu6050: Balance runtime pm + use
    pm_runtime_resume_and_get()
  iio: adc: ads1015: Balance runtime pm +  pm_runtime_resume_and_get()
  iio: chemical: atlas-sensor: Balance runtime pm +
    pm_runtime_resume_and_get()
  iio: prox: pulsed-light-v2: Fix misbalance runtime pm in error path
  iio: prox: pulsed-light-v2: Use pm_runtime_resume_and_get()
  iio: pressure: icp10100: Balance runtime pm + use
    pm_runtime_resume_and_get()

 drivers/iio/adc/ti-ads1015.c                  |  5 +----
 drivers/iio/chemical/atlas-sensor.c           | 13 ++++---------
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 19 ++++++-------------
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  6 ++----
 drivers/iio/pressure/icp10100.c               |  5 +++--
 .../iio/proximity/pulsedlight-lidar-lite-v2.c |  7 +++++--
 6 files changed, 21 insertions(+), 34 deletions(-)

-- 
2.31.1

