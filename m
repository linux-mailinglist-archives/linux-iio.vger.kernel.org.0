Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E02576F9
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHaJzM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 05:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgHaJzI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 05:55:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 757C320EDD;
        Mon, 31 Aug 2020 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598867708;
        bh=pI/y/jMzh+SnnOjfB9DzECZXCWam8lPvxUfgF5W9pyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o/rpJpu1L9r2GwZZjL6Ls3sdicnDXX40yJ2zoe5ClR2QbiW2eteJBqgCyx1D4/vqo
         g3+oAQPRpP8jTQi/ZkRLUjztwRprId6PbgwW5vjz74DBGKV7EcB9KoA58kQyu+VApm
         9wptiJ7dSUSuvYGPPrl0+DkUTBV3oM4a5g3NFne0=
Date:   Mon, 31 Aug 2020 10:55:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 5/8] iio: accel: bma220: Drop ACPI_PTR() and
 accompanying ifdeffery
Message-ID: <20200831105504.2837cdb1@archlinux>
In-Reply-To: <CAHp75Ve=p2fNWWAJ5SpQNfA0rH9vDg27YZhFh4vJgzXVhHxL8w@mail.gmail.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
        <20200831090813.78841-5-andriy.shevchenko@linux.intel.com>
        <20200831101908.52cb216e@archlinux>
        <CAHp75Ve=p2fNWWAJ5SpQNfA0rH9vDg27YZhFh4vJgzXVhHxL8w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Aug 2020 12:39:10 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 31, 2020 at 12:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Mon, 31 Aug 2020 12:08:10 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  
> > > The driver is quite likely used only on ACPI based platforms and
> > > rarely build with CONFIG_ACPI=n. Even though, the few dozens of bytes
> > > is better than ugly ifdeffery and inclusion of heavy header.  
> >
> > Given this part is readily available on maker type break out boards
> > I doubt it is mostly ACPI.  Rest of the comment is fine though.  
> 
> In-kernel use seems only ACPI (I grepped for pure SPI driver by name
> and didn't find anything).
> I hope we will have DT support for that as well (basically means
> adding OF ID table).
> 

Good to add the explicit DT support, but I think the nasty fallback is
still in place in which the old style ID table is used if we get a match
without manufacturer ID.

So should be possible to instantiate it from DT even without the table.

Jonathan


