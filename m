Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA17037081B
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhEARQN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 663A361284;
        Sat,  1 May 2021 17:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889323;
        bh=/Tr0La5NuMLkIuzuwYe6coD6WU45ko6gyXPjUIjWkrw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZkXkw3MW9jYplSBGdr+W/Q7Qaj/xiqsZ4c8Gufqq9KYISajTMG8cOxWTAyeF6VXNd
         dKAEuIxkDksUOl6VLF4pLNwQMYL+sTZFqgMv0Toa5e1tQ1gzsJT6zVV7k37CKfTkVb
         aIMlaj3Iu2SppLk3p6thI7oKgzCbCMTxgK+kJP3AmA+8Iuzeo/YZ28HFhARWn8TnVA
         2DZB8QNlClLPtQdO11gFwM/yUyaylMIqMK46CcGsli6kHQLRrRJ1XA0W7869GfLHpc
         D5IuwRojaT/wfathBcswJovotXDOpJDmGUBHfzOr9fgvjjCefqWtf9/zE1Y1wRED9G
         q0I/4k5VZsG5Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andreas Klinger <ak@it-klinger.d>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Song Qiang <songqiang1304521@gmail.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH 00/11] IIO: Alignment fixes part 3 - __aligned(8) used to ensure alignment
Date:   Sat,  1 May 2021 18:13:41 +0100
Message-Id: <20210501171352.512953-1-jic23@kernel.org>
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
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Song Qiang <songqiang1304521@gmail.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: Parthiban Nallathambi <pn@denx.de>

Jonathan Cameron (11):
  iio: adc: at91-sama5d2: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: hx711: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: mxs-lradc: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: adc: ti-ads8688: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: chemical: atlas: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: cros_ec_sensors: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: potentiostat: lmp91000: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: magn: rm3100: Fix alignment of buffer in
    iio_push_to_buffers_with_timestamp()
  iio: light: vcnl4000: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: light: vcnl4035: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()
  iio: prox: isl29501: Fix buffer alignment in
    iio_push_to_buffers_with_timestamp()

 drivers/iio/adc/at91-sama5d2_adc.c              | 3 ++-
 drivers/iio/adc/hx711.c                         | 4 ++--
 drivers/iio/adc/mxs-lradc-adc.c                 | 3 ++-
 drivers/iio/adc/ti-ads8688.c                    | 3 ++-
 drivers/iio/chemical/atlas-sensor.c             | 4 ++--
 drivers/iio/light/vcnl4000.c                    | 2 +-
 drivers/iio/light/vcnl4035.c                    | 3 ++-
 drivers/iio/magnetometer/rm3100-core.c          | 3 ++-
 drivers/iio/potentiostat/lmp91000.c             | 4 ++--
 drivers/iio/proximity/isl29501.c                | 2 +-
 include/linux/iio/common/cros_ec_sensors_core.h | 2 +-
 11 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.31.1

