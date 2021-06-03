Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9D439A9B7
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jun 2021 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFCSHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 3 Jun 2021 14:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhFCSGz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 3 Jun 2021 14:06:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C972613EE;
        Thu,  3 Jun 2021 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622743479;
        bh=l0Q2+w0IcZeS/tPmAbra2vth/gynqA3f4MVhFpsfgGg=;
        h=From:To:Cc:Subject:Date:From;
        b=rhFYkvPjAl7V7dx1xfktUIRnO0S4Pajcnkt8pMmEs2FDqPXX/uh07FI03pAJcKyiN
         l6xKnZlNaInnVLZbmmovl5LHfu4mF0G0tM/Q6yua8h7ki4/6Gjy0XYph/or3keNYG7
         OVHEJDoljl6v3hxxi2QXbytOevBR8FLfnCN2cN9DXbCx0CFQV7a45DJZfF/h8g5UaN
         aWGXYpgjHExDDE2+xUtP1uiExNndMDMU5fEMz2dYZd2s2XEkZ6+uEyyc4EHb5UYYEw
         aAOlmcIVUU2sHZ5MMzFffHos67Ox1fdp762tFJCRBrOzQpXmGjwhGHloWysH4EU6Ru
         pkqklTTh/6mog==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 0/4] iio: Drop use of %hhx and %hx format strings
Date:   Thu,  3 Jun 2021 19:06:08 +0100
Message-Id: <20210603180612.3635250-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

A wrong use of one of these in
https://lore.kernel.org/linux-iio/20210514135927.2926482-1-arnd@kernel.org/
included a reference from Nathan to a patch discouraging the use of
these strings in general:
https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

I did a quick grep and established we only have a few instances of these in
IIO anyway, so in the interests of avoiding those existing cases getting
cut and paste into new drivers, let's just clear them out now.

Note that patch from Arnd is now also part of this series, due to the
length specifier related issue Joe raised.

I have chosen to go with 0x%02x rather than %#04x as I find it more readable.

V2:
Use 0x%02x (Joe Perches)
Include Arnd's original patch, modified for the above.

Arnd Bergmann (1):
  iio: si1133: fix format string warnings

Jonathan Cameron (3):
  iio: light: si1133: Drop remaining uses of %hhx format string.
  iio: imu: inv_mpu6050: Drop use of %hhx format string.
  iio: light: si1145: Drop use of %hhx format specifier.

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  5 ++---
 drivers/iio/light/si1133.c                 | 18 +++++++++---------
 drivers/iio/light/si1145.c                 | 10 +++++-----
 3 files changed, 16 insertions(+), 17 deletions(-)

-- 
2.31.1

