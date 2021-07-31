Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE1F3DC637
	for <lists+linux-iio@lfdr.de>; Sat, 31 Jul 2021 16:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhGaOGz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Jul 2021 10:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhGaOGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Jul 2021 10:06:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7409860E94;
        Sat, 31 Jul 2021 14:06:47 +0000 (UTC)
Date:   Sat, 31 Jul 2021 15:09:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: Fix flags in sigma-delta drivers
Message-ID: <20210731150926.42a2da31@jic23-huawei>
In-Reply-To: <20210729084731.79135-1-alexandru.tachici@analog.com>
References: <20210729084731.79135-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 29 Jul 2021 11:47:28 +0300
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Some sigma-delta drivers use wrong irq_flags specified in the
> ad_sigma_delta_info struct. Add the flags corresponding to the
> interrupt type specified in the data-sheets of each chip.
> 

The complexity here is that we normally now leave this to the
firmware description of the interrupt.  The reason for that is
people have an annoying habit of building boards where there is
an inverter used as a cheap level converter on the interrupt line.

It an also be somewhat 'fun' to identify from a datasheet if
the signal is actually an edge interrupt or a level interrupt and
in the case of devices that don't have any autonomous triggering
(i.e. won't grab new data unless you tell the to) the difference
is irrelevant.  Take the ad7780 for example.  It has an interrupt
that remains low unless
a) The data is read - normal case I'd imagine
b) New data capture occurs (slowly at 10Hz)

So we aren't dealing with a short pulse, or a situation where we
have an interrupt that will stay set after the data is read
(both of which would make this definitely an edge interrupt to avoid
 possibility of either missing or double triggering).

Hence whilst it will work as an edge interrupt, it will also work
fine with the existing level interrupt and in some ways level is
more appropriate as the interrupt will remain set if you don't read
it (for a while anyway and after that it's not safe to read).

For extra fun / background for anyone else reading this thread,
this interrupt line is also the data out line, so
we absolutely 'must' keep the interrupt disabled until we are done
with the read out, but that's handled in the ad_sigma_delta core.

Conclusion, I'm not sure these are actually wrong, and if we were
doing this today we wouldn't have them anyway...  So have we seen
any problems with current code?

Jonathan


> Alexandru Tachici (3):
>   iio: adc: ad7192: Fix IRQ flag
>   iio: adc: ad7780: Fix IRQ flag
>   iio: adc: ad7923: Fix IRQ flag
> 
>  drivers/iio/adc/ad7192.c | 1 +
>  drivers/iio/adc/ad7780.c | 2 +-
>  drivers/iio/adc/ad7793.c | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> --
> 2.25.1

