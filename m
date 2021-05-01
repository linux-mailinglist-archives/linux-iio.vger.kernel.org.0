Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9053707F9
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhEAQzk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 12:55:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEAQzk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 12:55:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A66761446;
        Sat,  1 May 2021 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888090;
        bh=aQvVRklySAPrKrnRFAduQW785FO8dLHIuhlB9+pEyac=;
        h=From:To:Cc:Subject:Date:From;
        b=ARVJL+S+O4WU/zI6D1qyGxVE8qsv/fCjNHGi96GpmyZQWN63SVgklqF2xSNokB6tB
         aa7tKYEQCjtr6J39COUfsG7mI79Wpa3+vZvXJRcHfVR9zZccfOemLFbEvJD5bpz8nF
         g1MyRUIzWGQ9Vhesiezwkdf0jK1QUemKhC4pZ5PannW9blotnWZRuUVVyrWAfeXn1m
         VkyTvqz74hD9P3c5zmwnp/LY75JZ/XZMpmO89aS6+No6XiiH+XzqFzLI9/n6y7RSCl
         +fo74zrlbKcjbhp42NUW/0PKjjRymvsqhs/k2/LmGfzI38AfPGZ2sJloWLcFLCCnnq
         Jl0Mth1GIs7EA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Junho <djunho@gmail.com>
Subject: [PATCH 0/2] IIO: Alignment fixes part 1 - sizes too small as well.
Date:   Sat,  1 May 2021 17:53:12 +0100
Message-Id: <20210501165314.511954-1-jic23@kernel.org>
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

As discussed previous in
https://lore.kernel.org/linux-iio/20200920112742.170751-1-jic23@kernel.org/
it is not easy to fix the alignment issue without requiring a bounce buffer
(see part 4 of the alignment fixes for a proposal for that where it is
absolutely necessary).

In these cases the buffer is neither big enough, nor correctly aligned
so fix both issues in one go.

Cc: Daniel Junho <djunho@gmail.com>

Jonathan Cameron (2):
  iio: adc: ad7768-1: Fix too small buffer passed to
    iio_push_to_buffers_with_timestamp()
  iio: adc: ad7923: Fix undersized rx buffer.

 drivers/iio/adc/ad7768-1.c | 8 ++++++--
 drivers/iio/adc/ad7923.c   | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.31.1

