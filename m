Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDED0DB8F2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2019 23:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfJQV1L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Oct 2019 17:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503221AbfJQV1J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 17 Oct 2019 17:27:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF8921A49;
        Thu, 17 Oct 2019 21:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347628;
        bh=IoGi9ekuXMWW2fH3sM1nTllHy+sYRyEqFShiQUEON4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OlQFUgl+cHI6VGh5mG+JI3tXeCslF5ML7p74NuWuOqhbeLyS425SuWvN6urEm+bol
         hXTjXu4gkyqBskoNZt5jZillzErIBvBUnHGCLK0h6HkQMYEqjGsV18Mlqn/YaGbI9U
         tBd4StICiSs4ov10vU5kCtNNHYCfkgZ+FaCLynMQ=
Date:   Thu, 17 Oct 2019 22:27:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 0/7 v4] AB8500 GPADC MFD to IIO conversion
Message-ID: <20191017222703.4e213db4@archlinux>
In-Reply-To: <20191011071805.5554-1-linus.walleij@linaro.org>
References: <20191011071805.5554-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Oct 2019 09:17:58 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> This version should cover Jonathans comments on v2,
> and Rob's comments on missing DT changes in v3 and
> be ripe for early merge for v5.5.
> 
> Jonathan, do you want to queue them in your tree?

For reference immutable branch created at:

Immutable branch created based on 5.4-rc1 at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-ab8500-5.4-rc1

Now pulled into the togreg branch of iio.git which I'll push out in a moment
as testing for the autobuilders to see if they can managed to build this.

There is the small tweak to the DT examples that will need to be a followup
patch for.  That can go through mfd or myself depending on what Lee would
prefer.

Thanks,

Jonathan

> 
> When Lee applies series like this he usually puts them
> on an isolated immutable branch that he then pulls
> into his own tree and offer to other subsystems.
> It's a good idea I think but maybe you have other
> ways of working.
> 
> Linus Walleij (7):
>   power: supply: ab8500_btemp: convert to IIO ADC
>   power: supply: ab8500_charger: convert to IIO ADC
>   power: supply: ab8500_fg: convert to IIO ADC
>   hwmon: ab8500: convert to IIO ADC
>   mfd: ab8500: augment DT bindings
>   iio: adc: New driver for the AB8500 GPADC
>   mfd: Switch the AB8500 GPADC to IIO
> 
>  .../devicetree/bindings/mfd/ab8500.txt        |  119 ++
>  MAINTAINERS                                   |    1 +
>  drivers/hwmon/Kconfig                         |    3 +-
>  drivers/hwmon/ab8500.c                        |   65 +-
>  drivers/iio/adc/Kconfig                       |   10 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ab8500-gpadc.c                | 1218 +++++++++++++++++
>  drivers/mfd/Kconfig                           |    7 -
>  drivers/mfd/Makefile                          |    1 -
>  drivers/mfd/ab8500-debugfs.c                  |  715 ----------
>  drivers/mfd/ab8500-gpadc.c                    | 1075 ---------------
>  drivers/power/supply/Kconfig                  |    2 +-
>  drivers/power/supply/ab8500_btemp.c           |   41 +-
>  drivers/power/supply/ab8500_charger.c         |   78 +-
>  drivers/power/supply/ab8500_fg.c              |   23 +-
>  include/linux/mfd/abx500/ab8500-gpadc.h       |   75 -
>  16 files changed, 1495 insertions(+), 1939 deletions(-)
>  create mode 100644 drivers/iio/adc/ab8500-gpadc.c
>  delete mode 100644 drivers/mfd/ab8500-gpadc.c
>  delete mode 100644 include/linux/mfd/abx500/ab8500-gpadc.h
> 

