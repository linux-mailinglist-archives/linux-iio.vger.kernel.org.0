Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2F39AA76
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCSwQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCSwQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:52:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01369613D2;
        Thu,  3 Jun 2021 18:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622746231;
        bh=PhJQosXdxrQ+g+QKSnUNc5H/3QGVWLm1R+9Uf9sdBFo=;
        h=From:To:Cc:Subject:Date:From;
        b=jnzc+VjTKHraNlwnGvfHEK8nyiSPv4BR5ZFYtfFdN7y+DOyYDps20JRrWTFD1c57l
         ziIUluc2MDT0lO/w8PhGp1oO5/sSQBssVqSV31jDQmGxbcE9p1tk6qR2qZT1smXMOk
         Zj4pxR2FGsv70L8T0OkBeiXhf6mJnHdwV0dRyFkmTUsrDtNz1m0ni4DEO7QwREtpdi
         RB3dEsHvkac1VD53c9MczG7wfRD1Xed3CpfLNig6u6pLvuWHx09is3h3pBQRiMi5ql
         mYzIsXgmO698eqVW82Bqk1bUSvyXwb+/5qx0W4syvpgaNWmSlfA5t5VrHhC4qMx0r+
         ABn+4MK0PWXyA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/5] iio: accel: mma9551/mma9553 Cleanup and update
Date:   Thu,  3 Jun 2021 19:52:02 +0100
Message-Id: <20210603185207.3646368-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

v2: mma9551: Drop the gpio based irq support as not known to be used
    and adds complexity which is nice to get rid of.

This series came about because I was looking to write a dt-binding for these
two (currently missing entirely) and I discovered the mma9551 driver in
particular was doing some unusual things.

Note however, I've only tested the fwnode_irq_get() patch using a hacked
up version of QEMU and stubbing out some error paths because I'm too
lazy to emulate it properly ;)

The ACPI entries seem unlikely, but please shout if anyone knows of
them being used in the wild.

It would be particularly helpful if anyone who has either of these
parts could both give this a spin and let me know so I can ask
for testing in future.

Thanks,

Jonathan

Jonathan Cameron (5):
  iio: accel: mma9551/mma9553: Drop explicit ACPI match support
  iio: accel: mma9551/mma9553: Simplify pm logic
  iio: accel: mma9551: Add support to get irqs directly from fwnode
  iio: accel: mma9551: Use devm managed functions to tidy up probe()
  iio: accel: mma9553: Use devm managed functions to tidy up probe()

 drivers/iio/accel/mma9551.c | 151 ++++++++++++------------------------
 drivers/iio/accel/mma9553.c | 121 +++++++++--------------------
 2 files changed, 85 insertions(+), 187 deletions(-)

-- 
2.31.1

