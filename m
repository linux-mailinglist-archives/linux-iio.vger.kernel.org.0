Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770F3D4F0E
	for <lists+linux-iio@lfdr.de>; Sun, 25 Jul 2021 19:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhGYQmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Jul 2021 12:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhGYQmF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 25 Jul 2021 12:42:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D79E160698;
        Sun, 25 Jul 2021 17:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627233755;
        bh=bn1YvA29ZVIK2zKDMBx/XTa3nPLF3KkGhWnHFOyMlFc=;
        h=From:To:Cc:Subject:Date:From;
        b=B9tn6IPBceSqLyitMDDrTZsh1JexnbzLWWIjRv3BBzm0zLDyBGCJSFrndT8iCv8R+
         FOwU2oQdu+ltwX35yhIlV+35GggmQ6w2b1ObLWlNn3m+QAA1h9TKxF2hG4Y8wkk07k
         upyj+2YSCRxYwQJUHkG7cMRZOJZZmsvaVZvtcaslwoeJbhkWtEqUORX8tu0uvKTUeJ
         nqylmIDC8DzcfF3/POP0crXhOpDDZlbUfpcFvcq083xvu/WBvBmqe/XqKUlI+QZX9M
         zxwD9N0CUnIoXcT+Hl9dGfFxMh/IRuaYoNW8NERbD45Mt1Ak9NPCWNkwruD93bqOgZ
         ugUijSQIIYNfA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] iio:adc:ad7124: Convert to generic firmware handling
Date:   Sun, 25 Jul 2021 18:24:56 +0100
Message-Id: <20210725172458.487343-1-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The fix was something noticed whilst editing adjacent code.

Testing (minimal) done with hacked QEMU and a the device ID checks
commented out. The driver handling of channel subnodes could be
made more forgiving than it currently is, but this series doesn't
attempt to change that and I'd be wary doing so without hardware.

Andy pointed out we had a bunch of this of_ specific stuff still in IIO
and it would be good to reduce this.  I'm not that bothered about
cases tied directly to specific SoCs but for general SPI / I2C devices
it would be nice if ACPI uses of PRP0001 worked for all of them and
we ensure there are no 'bad' examples for people to base new drivers
on.

Jonathan Cameron (2):
  iio:adc:ad7124: Parse configuration into correct local config
    structure.
  iio:adc:ad7124: Convert to fwnode handling of child node parsing.

 drivers/iio/adc/ad7124.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

-- 
2.32.0

