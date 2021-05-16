Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F97382031
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhEPR1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 13:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhEPR1b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 13:27:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5EAA6113C;
        Sun, 16 May 2021 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185976;
        bh=BU9n8k/YaTKmh8gVDCPdYF1vdSQt6lrt4nPok7J6Zw8=;
        h=From:To:Cc:Subject:Date:From;
        b=ttFT0PQgyJlAfr86MUoyBJnsWZSKNsrs1w4R1mhzu+Xp2NT+Tgc5e5hkmx1KM7mMQ
         t9vcThfriR+D15O9tXjaJZaYO7yeIONpYX+d2zkLjmZIvfO76rAlCJmfJWTz0I/tkG
         2GiYKvsmbnF8sPHl4MHg8/RoAQh1fop2vVXCfMrq3zgrYwTT64sEuT170xoDP65+Q5
         USeW3o5osNiunQW42xZ5+09UWGa5BDYKSnTX1hVlc4Q4rKtzR7l1TaqsebVsgl3R4z
         Mf4HrIL+ggxK3T9xVY8/tlFOx2hQxpUSgs6LR38qqOxr/oyE56yMHRIQYs/BEQKPWQ
         PPbccrPlxDVgw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] iio: adc: Maxim and TI ADC driver cleanups
Date:   Sun, 16 May 2021 18:25:12 +0100
Message-Id: <20210516172520.1398835-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A few random bits of tidying up for a Sunday evening.
Mostly devm stuff, but other things in here as well that came up whilst
I was looking.

Note this was a fairly random selection, so isn't implying there
aren't similar cleanups to be done in other TI and Maxim drivers.
(there definitely are plenty more of these if anyone is bored ;)

Cc: Alexandru Ardelean <aardelean@deviqon.com>

Jonathan Cameron (8):
  iio: adc: max11100: Use get_unaligned_be16() rather than opencoding.
  iio: adc: max11100: Use devm_ functions for rest of probe()
  iio: adc: max1118: Use devm_ managed functions for all of probe
  iio: adc: max1118: Avoid jumping back and forth between spi and iio
    structures
  iio: adc: ti-adc081c: Use devm managed functions for all of probe()
  iio: adc: ti-adc0832: Use devm managed functions for all of probe()
  iio: adc: ti-adc108s102: Use devm managed functions for all of probe()
  iio: adc: ti-adc161s626: Use devm managed functions for all of probe.

 drivers/iio/adc/max11100.c      | 32 ++++++----------
 drivers/iio/adc/max1118.c       | 68 ++++++++++++---------------------
 drivers/iio/adc/ti-adc081c.c    | 43 +++++++--------------
 drivers/iio/adc/ti-adc0832.c    | 39 ++++++-------------
 drivers/iio/adc/ti-adc108s102.c | 45 ++++++++--------------
 drivers/iio/adc/ti-adc161s626.c | 50 +++++++++---------------
 6 files changed, 94 insertions(+), 183 deletions(-)

-- 
2.31.1

