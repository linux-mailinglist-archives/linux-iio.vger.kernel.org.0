Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB16A3A5955
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhFMPXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhFMPXM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA81E61040;
        Sun, 13 Jun 2021 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597671;
        bh=j9rxfkeZK+NUgKav5L4fcL1m3Xleic0eEFhJOuAL1yU=;
        h=From:To:Cc:Subject:Date:From;
        b=A5TxCBlzj0H43S6G5nS7m03NHw11OcH35JEwp43aNR9WZi0aTTyOx+68quDMKUbZs
         h9OZ8j1Mcljzxji56ly8fGWhOjfxpdfMRLWsJYfNrvPGQO5fC7SO5IoQOduJa7+9nT
         rSjMLXSwfP99gtcQzOkirm90tyooovxiw3xeGoHMZYxX7TFv4JnkSfUx1mxp7x5d/T
         RTAeq4yRHpAmjZ1NjdXiED66mSvUqKeR8Ov8EXLyA3JsfYnVNmv+QBZIf2yPL/8XOq
         PBtPX0rGFeAkaXv/8zJjzRCjBEVHg0thvxJMNLY4S3FnIdBoGj+DxoS47Gt/Bsk7MT
         9/zPYwLY1c+AQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.d>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH RESEND 0/8] IIO: Alignment fixes part 3 - __aligned(8) used to ensure alignment
Date:   Sun, 13 Jun 2021 16:22:53 +0100
Message-Id: <20210613152301.571002-1-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resent as none of these have had any comments since being sent out over
a month ago.  Note these are very straight forward, but I've messed up
such things in the past so really appreciate it if someone takes the time
to do a quick sanity check.

I have picked up those patches that did get review in first posting and
dropped them from this posting.

Cover letter from first posting.

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
it is not easy to fix the alignment issue without requiring a bounce buffer
(see part 4 of the alignment fixes for a proposal for that where it is
absolutely necessary).

Part 3 contains the cases where the struct approach in part 2 did not seem
appropriate.  Normally there are two possible reasons for this.
1.  Would have required an additional memset operation to avoid any
    possibility of leaking kernel data.
2.  The location of the timestamp may depend on the channels enabled.
    This normally happens when the max sizeof channels is greater than
    8 bytes.

Once all cases are fixes, I'll take a look at hardening against any
accidental reintroductions. Note that on many platforms and usecases the
bug in question will never occur.

Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Andreas Klinger <ak@it-klinger.d>
Cc: Song Qiang <songqiang1304521@gmail.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Parthiban Nallathambi <pn@denx.de>

Jonathan Cameron (8):
  iio: adc: at91-sama5d2: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: hx711: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: mxs-lradc: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: ti-ads8688: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: magn: rm3100: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: light: vcnl4000: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: light: vcnl4035: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: prox: isl29501: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()

 drivers/iio/adc/at91-sama5d2_adc.c     | 3 ++-
 drivers/iio/adc/hx711.c                | 4 ++--
 drivers/iio/adc/mxs-lradc-adc.c        | 3 ++-
 drivers/iio/adc/ti-ads8688.c           | 3 ++-
 drivers/iio/light/vcnl4000.c           | 2 +-
 drivers/iio/light/vcnl4035.c           | 3 ++-
 drivers/iio/magnetometer/rm3100-core.c | 3 ++-
 drivers/iio/proximity/isl29501.c       | 2 +-
 8 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.32.0

