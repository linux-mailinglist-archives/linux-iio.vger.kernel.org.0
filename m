Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8A37083B
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEAR13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhEAR13 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:27:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60D56610EA;
        Sat,  1 May 2021 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889998;
        bh=Z/8J3tEtnPmliYVnE6MzXaXCcUrw/IkcYjBD0EHp5ks=;
        h=From:To:Cc:Subject:Date:From;
        b=R89U2hQE516++iFOnmwo5LblofbRgmOHgJFekv/Xzc+4Tt8cTE94GbTtbji6WIeJh
         ljRbkL1qZ5t4KW2eRKA7ZBkROj42v84z5GffVxH7WWH/wYTzCWeCbnt+qaEEWOz1G6
         kCW3xDNHdg8/F9+101d8J9eR/MZerYp/eulcd73ju8UiQ0Q3g+grRVY1C8UpToTnuL
         2KLo1aNFzTI1g6HWpG6BzKLv+p94o77DfEsiyaVpSpsJbdUZ/kpBAMGMlu3uppCBs8
         wqdNzagA5sr1vNxdzLFClTGGdvL7Attfn0100DxH43BndYYxn/w2L3M4EnVMFn1jp/
         SmxR9PfHERliw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [RFC PATCH 0/4] IIO: Alignment fixes part 4 - bounce buffers for the hard cases.
Date:   Sat,  1 May 2021 18:25:11 +0100
Message-Id: <20210501172515.513486-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I finally got around to do a manual audit of all the calls to
iio_push_to_buffers_with_timestamp() which has the somewhat odd requirements
of:
1. 8 byte alignment of the provided buffer.
2. space for an 8 byte naturally aligned timestamp to be inserted at the
   end.

Unfortunately there were rather a lot of these left, but time to bite the bullet
and clean them up.

As discussed previous in
https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
it is not easy to fix the alignment issue without requiring a bounce buffer.
This final part of the 4 sets of fixes is concerned with the cases where
bounce buffers are the proposed solutions.

In these cases we have hardware that reads a prefix that we wish to
drop. That makes it hard to directly read the data into the correct location.

Rather than implementing bouce buffers in each case, this set provides some
magic in the core to handle them via a new function.
iio_push_to_buffers_with_ts_na() - non aligned

Note this is totally untested as I don't have suitable hardware or emulation.
I can fake something up in the dummy driver or via QEMU but I definitely want
both eyes and testing on this series!

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Nuno Sa <nuno.sa@analog.com>

Jonathan Cameron (4):
  iio: core: Introduce iio_push_to_buffers_with_ts_na() for non aligned
    case.
  iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio
    buffers.
  iio: gyro: mpu3050: Fix alignment and size issues with buffers.
  iio: imu: adis16400: Fix buffer alignment requirements.

 drivers/iio/adc/ti-adc108s102.c   | 11 +++++-----
 drivers/iio/gyro/mpu3050-core.c   | 24 ++++++++++-----------
 drivers/iio/imu/adis16400.c       | 20 ++++++++++++-----
 drivers/iio/industrialio-buffer.c | 36 +++++++++++++++++++++++++++++++
 include/linux/iio/buffer.h        |  4 ++++
 include/linux/iio/iio-opaque.h    |  4 ++++
 6 files changed, 76 insertions(+), 23 deletions(-)

-- 
2.31.1

