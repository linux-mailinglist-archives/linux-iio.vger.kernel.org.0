Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52A42027F
	for <lists+linux-iio@lfdr.de>; Sun,  3 Oct 2021 17:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJCQAK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Oct 2021 12:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230426AbhJCQAK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Oct 2021 12:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 220FA61166;
        Sun,  3 Oct 2021 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633276702;
        bh=tNbC5V7nm8EK+mMEgnJJtukqmLRg2bR3cB1bQnifsrs=;
        h=From:To:Cc:Subject:Date:From;
        b=lJxuRZ20ZsG9yYbGbPtEJ+jcuunVhiOMeKNknar2r1miahU5XT3TDpENglEEfesCi
         HoLZN73b6bFStin/w2kx0l+Xd81pFEQPH0IrxnZENmjLBQX/F8n/Ip+j21bZy4jp2P
         ngaV9QIm2djczGhBUBxXd/SHJAC0gclTG5EJ8zhbTaAYFLm3XOqhL6FDfjVA6jycmt
         lmcm0I0xtaN2nkofhySaM4zMnJODpPCVFnBtrxhd4pbnJIXo8LW1H8Us0S14eikBVO
         UoJzxPJgQeFPBTefX0fKk8c6OAiHD2Czk+dW5d3s+SsfwtKyEcQxODBRHLMjk4ta+h
         zwvagjNNgrGdw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND v2 0/5] iio: accel: mma9551/mma9553 Cleanup and update
Date:   Sun,  3 Oct 2021 17:02:07 +0100
Message-Id: <20211003160212.417909-1-jic23@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resend to get it back to the top of people's inboxes given lack of
review since posting in June.  No changes.
Whilst testing would be ideal, getting some eyes on this should be sufficient
if we can't find anyone with a test part.

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
2.33.0

