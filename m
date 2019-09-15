Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C097B2F87
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfIOKWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfIOKWM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:22:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07FD220692;
        Sun, 15 Sep 2019 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568542931;
        bh=jQ+dE0FqCn4YmPt8H5tQ6UZBzpg1F2BEc20j8Ptglzk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5BbD16mnzz7OhM8IfFnS1ggxaS2GA7BFcYFp/ccokTArfJNqni/tOl8YgI7yBU1a
         02MB/74LKXFKXF/CZtGJW3ui1b5ObbJmJeNgeAeV4H9IUbuVJb7IUfH4AHojzPQ2RJ
         MHoECe9e7kfh2HZwSU+AzNE8mmhDT2tYuMWweIsI=
Date:   Sun, 15 Sep 2019 11:22:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <broonie@kernel.org>,
        <f.fainelli@gmail.com>, <linus.walleij@linaro.org>,
        <orsonzhai@gmail.com>, <baolin.wang@linaro.org>,
        <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 00/15] Unify SPI delays into an `struct spi_delay`
Message-ID: <20190915112205.0007d62d@archlinux>
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 14:45:35 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Initially, I started this patchset thinking: "we need a new delay for
> something-something" (in case someone is curios, we need a CS-hold-time for
> the first transfer, because the CS wakes a chip from sleep-mode).
> 
> Then I added the delay, and felt a bit dirty-inside about adding a new one
> (just like that), and decided to look at maybe cleaning things up a bit,
> and a few days later, I got here.
> 
> Full disclaimer: this patchset is not complete. It's an RFC.
> It's based on top of Jonathan's `iio/togreg` branch which also includes the
> ADIS driver library changes and also includes `cs_change_delay`.
> 
> I'll send a V2 patchset, which just the first 4 patches, since I feel that
> those are a bit more complete.
> 
> I thought about just sending the first 4 patches on-their-own, but I
> figured that the whole series (even if not complete) serves as a better
> explanation about the whole "why?".
> 
> Hopefully, this can sort-of-explain things.
> I'll reference this RFC on the next series.

General approach looks sensible to me. Over to SPI specialists on
whether this is a sensible bit of unification to do.

Jonathan

> 
> Thanks
> 
> Alexandru Ardelean (15):
>   spi: move `cs_change_delay` backwards compat logic outside switch
>   spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
>   spi: make `cs_change_delay` the first user of the `spi_delay` logic
>   iio: imu: adis: convert cs_change_delay to spi_delay struct
>   spi: sprd: convert transfer word delay to spi_delay struct
>   spi: orion: use new `word_delay` field for SPI transfers
>   spi: spidev: use new `word_delay` field for spi transfers
>   spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for
>     spi_device
>   spi: introduce `delay` field for `spi_transfer` + spi_transfer_exec()
>   spi: use new `spi_transfer_delay` helper where straightforward
>   spi: tegra114: use `spi_transfer_delay` helper
>   spi: spi-loopback-test: use new `delay` field
>   spi: spidev: use new `delay` field for spi transfers
>   spi: tegra114: change format for `spi_set_cs_timing()` function
>   spi: implement SW control for CS times
> 
>  drivers/iio/imu/adis.c           |  24 ++---
>  drivers/spi/spi-atmel.c          |  29 +++++-
>  drivers/spi/spi-bcm63xx-hsspi.c  |   3 +-
>  drivers/spi/spi-cavium.c         |   3 +-
>  drivers/spi/spi-fsl-dspi.c       |   3 +-
>  drivers/spi/spi-fsl-espi.c       |   3 +-
>  drivers/spi/spi-fsl-spi.c        |   3 +-
>  drivers/spi/spi-loopback-test.c  |  12 ++-
>  drivers/spi/spi-mpc512x-psc.c    |   3 +-
>  drivers/spi/spi-mpc52xx-psc.c    |   3 +-
>  drivers/spi/spi-omap-100k.c      |   3 +-
>  drivers/spi/spi-orion.c          |   6 +-
>  drivers/spi/spi-pl022.c          |  25 +++--
>  drivers/spi/spi-sc18is602.c      |   3 +-
>  drivers/spi/spi-sh-hspi.c        |   3 +-
>  drivers/spi/spi-sprd.c           |  11 ++-
>  drivers/spi/spi-tegra114.c       |  39 +++++---
>  drivers/spi/spi-tegra20-sflash.c |   2 +-
>  drivers/spi/spi-topcliff-pch.c   |   7 +-
>  drivers/spi/spi-txx9.c           |   3 +-
>  drivers/spi/spi-xcomm.c          |   3 +-
>  drivers/spi/spi.c                | 162 +++++++++++++++++++++++++------
>  drivers/spi/spidev.c             |   6 +-
>  include/linux/spi/spi.h          |  65 ++++++++++---
>  24 files changed, 293 insertions(+), 131 deletions(-)
> 

