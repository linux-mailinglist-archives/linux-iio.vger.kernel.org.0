Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1293097C5
	for <lists+linux-iio@lfdr.de>; Sat, 30 Jan 2021 20:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhA3TFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Jan 2021 14:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231923AbhA3TFi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Jan 2021 14:05:38 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D82A64E11;
        Sat, 30 Jan 2021 19:04:55 +0000 (UTC)
Date:   Sat, 30 Jan 2021 19:04:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     fabrice.gasnier@foss.st.com, fabrice.gasnier@st.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        benjamin.gaignard@st.com
Subject: Re: [PATCH v2 0/2] Remove the IIO counter ABI
Message-ID: <20210130190452.34c6bf37@archlinux>
In-Reply-To: <cover.1611973018.git.vilhelm.gray@gmail.com>
References: <cover.1611973018.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 30 Jan 2021 11:37:02 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> Changes in v2:
>  - Add missing argument to devm_kzalloc() call in quad8_probe().
>  - Remove superfluous 'err' variable from quad8_probe().
> 
> The IIO counter driver has been superseded by the Counter subsystem as
> discussed in [1]. This patchset removes the IIO counter ABI code and
> documentation.
> 
> A patch to remove the IIO counter ABI code from the stm32-lptimer-cnt
> counter driver has been submitted to the list separately [2]; if you
> would like me to combine it with this patchset, please let me know.

No problem, I've already picked that one.

> 
> One final user of the IIO counter ABI code is still remaining for now:
> drivers/iio/trigger/stm32-timer-trigger.c. Is this driver related to the
> drivers/counter/stm32-timer-cnt.c driver? Can it be migrated to the
> Counter subsystem ABI instead?

I'm going to guess that we could probably drop the iio_dev part of the
stm32-timer-trigger entirely, though I'm not totally sure so wouldn't be
confident doing it without someone having hardware to test.  In particular
there may be some connections between whether the device is enabled and
the triggers working that isn't documented anywhere that I can spot.

Whilst that's still in place, I'm going to pick up patch 1 of this set, but
leave patch 2. The ABI is clearly marked deprecated so we shouldn't get
new users and we can pick up that patch hwen the stm32-timer-trigger has
been tidied up as well.

Applied patch 1.  Thanks,

Jonathan

> 
> [1] https://lore.kernel.org/lkml/20210119104105.000010df@Huawei.com/
> [2] https://marc.info/?l=linux-arm-kernel&m=161192667926697
> 
> William Breathitt Gray (2):
>   counter: 104-quad-8: Remove IIO counter ABI
>   iio: Remove the IIO counter ABI documentation
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  40 --
>  .../testing/sysfs-bus-iio-counter-104-quad-8  | 133 ----
>  MAINTAINERS                                   |   1 -
>  drivers/counter/104-quad-8.c                  | 653 ++----------------
>  drivers/counter/Kconfig                       |   2 +-
>  5 files changed, 65 insertions(+), 764 deletions(-)
>  delete mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
> 

