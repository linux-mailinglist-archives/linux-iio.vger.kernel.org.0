Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472B34889EE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jan 2022 15:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiAIOy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Jan 2022 09:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiAIOy1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jan 2022 09:54:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E703C06173F
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 06:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C284B60E75
        for <linux-iio@vger.kernel.org>; Sun,  9 Jan 2022 14:54:25 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 7AD1AC36AEB;
        Sun,  9 Jan 2022 14:54:21 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:00:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Parthiban Nallathambi <pn@denx.de>,
        Nikita Travkin <nikita@trvn.ru>,
        Maslov Dmitry <maslovdmitry@seeed.cc>,
        Andreas Klinger <ak@it-klinger.de>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Subject: Re: [PATCH 00/16] IIO: Tidy up inconsistent spacing in ID tables.
Message-ID: <20220109150016.0a593e46@jic23-huawei>
In-Reply-To: <20211230174911.78291-1-jic23@kernel.org>
References: <20211230174911.78291-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Dec 2021 17:48:55 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Andy's review of Gwendal's sx9324 patch included a comment on having
> a space before the } in id tables. It is a more general comment, but
> this series only addresses the id table cases where things are
> inconsistent.  I said I would send a clean up set when I got bored. That
> happened sooner than expected (I blame tax returns).
> 
> Found using:
>   git grep -re "[0-9A-Za-z]}" drivers/iio/ | grep "{\ "
> 
> Note that the fact that we have a clump of these in proximity drivers
> suggests that copy and paste is leading to this odd bit of formatting
> getting copied into new drivers.
> 
> As ever, some of these don't have active driver maintainers so please
> take a quick look at the whole series if you have time.

Series applied to the togreg branch of iio.git, pushed out as testing for
0-day to poke at it until after the merge window.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> Cc: Parthiban Nallathambi <pn@denx.de>
> Cc: Nikita Travkin <nikita@trvn.ru>
> Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
> Cc: Andreas Klinger <ak@it-klinger.de>
> Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Cc: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Cc: Hui Liu <hui.liu@mediatek.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
> 
> Jonathan Cameron (16):
>   iio:chemical:atlas: Trivial white space cleanup to add space before }
>   iio:light:pa12203001: Tidy up white space change to add spaces after {
>     and before }
>   iio:light:vcnl4035: Trivial whitespace cleanup to add space before }
>   iio:light:us5182: White space cleanup of spacing around {} in id
>     tables
>   iio:light:ltr501: White space cleanup of spacing around {} in id
>     tables
>   iio:proximity:ping: White space cleanup of spacing around {} in id
>     tables
>   iio:proximity:rfd77402: White space cleanup of spacing around {} in id
>     tables
>   iio:proximity:srf04: White space cleanup of spacing around {} in id
>     tables
>   iio:proximity:srf08: White space cleanup of spacing around {} in id
>     tables
>   iio:frequency:admv1013: White space cleanup of spacing around {} in id
>     tables
>   iio:adc:mt6577_auxadc: Tidy up white space around {} in id tables
>   iio:adc:hi8435: Tidy up white space around {} in id tables
>   iio:adc:ti-adc084s021: Tidy up white space around {}
>   iio:light:tsl2722: Fix inconsistent spacing before } in id table
>   iio:proximity:vl53l0x: Tidy up white space around {} in id tables
>   iio:accel:dmard09: Tidy up white space around {} in id table
> 
>  drivers/iio/accel/dmard09.c         |  2 +-
>  drivers/iio/adc/hi8435.c            |  2 +-
>  drivers/iio/adc/mt6577_auxadc.c     | 10 +++++-----
>  drivers/iio/adc/ti-adc084s021.c     |  2 +-
>  drivers/iio/chemical/atlas-sensor.c | 10 +++++-----
>  drivers/iio/frequency/admv1013.c    |  2 +-
>  drivers/iio/light/ltr501.c          | 14 +++++++-------
>  drivers/iio/light/pa12203001.c      |  4 ++--
>  drivers/iio/light/tsl2772.c         |  2 +-
>  drivers/iio/light/us5182d.c         |  6 +++---
>  drivers/iio/light/vcnl4035.c        |  2 +-
>  drivers/iio/proximity/ping.c        |  4 ++--
>  drivers/iio/proximity/rfd77402.c    |  2 +-
>  drivers/iio/proximity/srf04.c       | 12 ++++++------
>  drivers/iio/proximity/srf08.c       |  6 +++---
>  drivers/iio/proximity/vl53l0x-i2c.c |  2 +-
>  16 files changed, 41 insertions(+), 41 deletions(-)
> 

