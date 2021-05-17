Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1022382CA0
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 14:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhEQM6E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 08:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEQM6D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 May 2021 08:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 431326100C;
        Mon, 17 May 2021 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621256207;
        bh=cjntvkJ61ExY3di2urvM2qQxQpf5OMmmSarndTV/U/U=;
        h=From:To:Cc:Subject:Date:From;
        b=j6XxWrhqYgBkW/+feQRqijfPDqd14XbDjFMF+PoUemL6gQrW7JTU55uAWi/QsbJoV
         YPgymu2aocA8heLKHwb99V42BRo/5BiIbgSw2awg8gaG2AlSV1xVGWXvlMpX+tr58r
         syn43xk2s24LU3ro16eRNfJYmEYJSYMiNEyUniPF8oYHctIZZh8SSL8Ni+9b7pc1OZ
         HschoBP6Mgizggrap+647a6UwFQsrAHB0Vdhd/7wf0Eky3diG6xBb7mJGWWZv36J2Y
         0bbgTcjygqgCVB9MeP2aXxrEbBkM1NSq/E9ibEfhINO+Ys7F9ptOGMQezBbKxhLMcD
         7Hb/XgKDbwJ6w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [RESEND PATCH 0/4] iio: Drop use of %hhx and %hx format strings
Date:   Mon, 17 May 2021 13:55:50 +0100
Message-Id: <20210517125554.1463156-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resent because for some reason this didn't reach the mailing list
(I'm not sure it reached anywhere at all!)

A wrong use of one of these in
https://lore.kernel.org/linux-iio/20210514135927.2926482-1-arnd@kernel.org/
included a reference from Nathan to a patch discouraging the use of
these strings in general:
https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/

I did a quick grep and established we only have a few instances of these in
IIO anyway, so in the interests of avoiding those existing cases getting
cut and paste into new drivers, let's just clear them out now.

Cc: Nathan Chancellor <nathan@kernel.org>
Jonathan Cameron (4):
  iio: imu: inv_mpu6050: Drop use of %hhx format string.
  iio: light: si1133: Drop remaining uses of %hhx format string.
  iio: light: si1145: Drop use of %hhx format specifier.
  iio: chemical: sgp30: Drop use of %hx in format string.

 drivers/iio/chemical/sgp30.c               |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  5 ++---
 drivers/iio/light/si1133.c                 | 14 +++++++-------
 drivers/iio/light/si1145.c                 | 10 +++++-----
 4 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.31.1

