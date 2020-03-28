Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE83E196735
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 17:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgC1QCJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 12:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgC1QCJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 12:02:09 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E155F206DB;
        Sat, 28 Mar 2020 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585411329;
        bh=HLNJr3866dNd7FwWdbTyEMZnyPy8zYW7bYSYw7WT+G0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hla6fEDqO2HtBLLgCY1XpDgENq2ZwmkzD3AHlGJv9E57Lvqa/byXuMV1RJw1BEU3B
         6xtV8zy6hXZCiCwShBnJta1Itdh8PR8a5OuOYDehynNfy+zTECsrNlJzTQnROsYExC
         7Q0MgtTWNSprmlCEKTwflmKullvIhcaDO5Y6mRQg=
Date:   Sat, 28 Mar 2020 16:02:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Tolerate IRQ before
 registering
Message-ID: <20200328160203.1d0e378b@archlinux>
In-Reply-To: <CACRpkdagNP6cY353oi0vCAihqvd2ZOHJ8Os7j-cq4EVBCC4+Ug@mail.gmail.com>
References: <20200323104129.60466-1-andriy.shevchenko@linux.intel.com>
        <CACRpkdagNP6cY353oi0vCAihqvd2ZOHJ8Os7j-cq4EVBCC4+Ug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 27 Mar 2020 11:50:25 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Mar 23, 2020 at 11:41 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > With DEBUG_SHIRQ enabled we have a kernel crash
> >
> > [  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000
> >
> > ...
> >
> > [  116.606571] Call Trace:
> > [  116.609023]  <IRQ>
> > [  116.611047]  complete+0x34/0x50
> > [  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]
> >
> > because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
> > ought to be able to handle an interrupt happening before request_irq() returns.
> >
> > Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > v2: put conditional logic back when re-initializing completion (Jonathan)  
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at them.

Thanks,

Jonathan

> 
> Yours,
> Linus Walleij

