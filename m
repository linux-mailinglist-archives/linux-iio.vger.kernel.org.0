Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5438DBE5
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 18:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhEWQZ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 12:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhEWQZ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 May 2021 12:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EAE260FE6;
        Sun, 23 May 2021 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621787040;
        bh=p1lvkdO0YAFhvRtbFerW6lWL7JO+aoSukfQX5+aGr9c=;
        h=From:To:Cc:Subject:Date:From;
        b=hMgN1G6MGLx3KtLsBikgBlPR7e301MtRSOfR3+WVCu+dXdrAFFBJMC15Cr7O1Vg/J
         O70DyQucPw+81zCa18uZF6Lhzidw4XfQ32UVKBW4j7/M3+yE+ZAzp58zahHyEWnTsN
         wy7UvxMrir+KnWjzu5Pdtow4WPEqVETztjzTl7E0yQ0w1AZ4xlbAMPtqdJY5XQCCDI
         j+uN3/2eRC++7SQmQXvlPAEQ7Hz4DsS9aH7r96b/PTYgVSx1WesW3013sU7vyPfngG
         t6Nw7OLp8GVTRn/ItnHltLp/88yZXOMIVRJ5/7oy98WpZUk1lHrkoxayYGdbzzHUql
         wtkUaKSrxWOgg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/5] iio: accel: mma9551/mma9553 Cleanup and update
Date:   Sun, 23 May 2021 17:23:10 +0100
Message-Id: <20210523162315.1965869-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This series came about because I was looking to write a dt-binding for these
two (currently missing entirely) and I discovered the mma9551 driver in
particular was doing some unusual things.

I've left the gpio based interrupt stuff in there because it's possible
there are boards out there using it.  Note however, I've only tested the
fwnode_irq_get() patch using a hacked up version of QEMU and stubbing out
some error paths because I'm too lazy to emulate it properly ;)

The ACPI entries seem unlikely, but please shout if anyone knows of
them being used in the wild.

It would be particularly helpful if anyone who has either of these
parts could both give this a spin and let me know so I can ask
for testing in future.

Thanks,

Jonathan

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

Jonathan Cameron (5):
  iio: accel: mma9551/mma9553: Drop explicit ACPI match support
  iio: accel: mma9551/mma9553: Simplify pm logic
  iio: accel: mma9551: Add support to get irqs directly from fwnode
  iio: accel: mma9551: Use devm managed functions to tidy up probe()
  iio: accel: mma9553: Use devm managed functions to tidy up probe()

 drivers/iio/accel/mma9551.c | 156 ++++++++++++++----------------------
 drivers/iio/accel/mma9553.c | 121 +++++++++-------------------
 2 files changed, 96 insertions(+), 181 deletions(-)

-- 
2.31.1

