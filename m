Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC9CD183
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 13:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfJFLAn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 07:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFLAn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 07:00:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39AD12084D;
        Sun,  6 Oct 2019 11:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570359642;
        bh=GSsaF+gDvD+IVbfP2e5EEGv+XH0J7ztZ5PuixMHDEfs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VLR7egROb+HXvWJhPFlwkKl5itG1rmgoSfqX+bdbk1CPOew8Y+v2o4KYasP8hruUp
         ISekN0WHogDJZ3YqUopUobS0MvuxUpMKf0ZrELYzJup8+njfBcqNxREmQ9T8f8Gsdi
         16sMPO9gqsX3wY/iDY4m8bp+Swa9Qsp5m4AV1LqQ=
Date:   Sun, 6 Oct 2019 12:00:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mboumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: Re: [PATCH 0/7 v3] AB8500 GPADC MFD to IIO conversion
Message-ID: <20191006120036.3ebebca5@archlinux>
In-Reply-To: <20191001221356.19317-1-linus.walleij@linaro.org>
References: <20191001221356.19317-1-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  2 Oct 2019 00:13:49 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> This version should cover Jonathans comments on v2 and
> be ripe for early merge for v5.5.
> 
> Jonathan, do you want to queue them in your tree?
> 
> When Lee applies series like this he usually puts them
> on an isolated immutable branch that he then pulls
> into his own tree and offer to other subsystems.
> It's a good idea I think but maybe you have other
> ways of working.
My tree is lagging a bit at the moment, so I'll wait until
I am based on something after 5.4-rc1 (probably next weekend)
then do an immutable branch based on that.
I have a few other bits waiting for that rebase, so hopefully
I'm remember them all. Give me a shout if I seem to have forgotten.
The jet lag excuse is now nearly gone so it'll just be me being
useless :)

Also, this gives a bit more time for Rob or Mark to sanity check the dt
bindings if they want to.

Thanks,

Jonathan
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

