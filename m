Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3389A468D1B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 20:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbhLEUBP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:01:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58184 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLEUBP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:01:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A6E61121
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 19:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8CBC00446;
        Sun,  5 Dec 2021 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638734266;
        bh=wrh4MRxflDumNtTgVRYbWkv20Oz75uJu8IlkCxSxJNk=;
        h=From:To:Cc:Subject:Date:From;
        b=kkVXvoaGX1Pz1ICPas14p76SWBG1vkUg6PHnCur2gvFlDwqD5r8qdMxzn4RVdY971
         0g3qy1a5RKGWClOQ3O0y5kVyMYDNqnYznOiGI0XXkXY8Hok2Ug0MzbGhNYoQ8INgBe
         wlicwKHfs9uIvU4FHGyCKePyOUSRAuZB353R3mCMLXDKs+qCkRCqKtOH6MQQSKveJg
         KxRPvjEJfbT97A8lB9JBWfZuZCpKUhvmlkkMpONz8ZwPJ33GOxd5t+eheXdIu+lb23
         RrrvpTrWVSDr5vMW5kJfUie4q8AWH+gKFcWkNzIT5ZkBfW4kics5LYqjYnFZvEob8H
         AN5VZFai4sFqA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 0/5] iio: accel: mma9551/mma9553 Cleanup and update
Date:   Sun,  5 Dec 2021 20:02:45 +0000
Message-Id: <20211205200250.2840902-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst testing would be ideal, getting some eyes on this should be sufficient
if we can't find anyone with a test part.  Note that patch 3 needs most
attention as it currently has no review tags. 

v3: Updated commit log for patch 3 which didn't reflect the v2 changes (oops).
    Picked up Hans' tag for patch 1 (thanks)
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
2.34.1

