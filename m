Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 339B8D80A5
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfJOUFj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 16:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfJOUFj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Oct 2019 16:05:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFFC20854;
        Tue, 15 Oct 2019 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571169938;
        bh=cz+FgLEYoBaGtttZKt1UmWqPSQRHlaMlaMLMLKGNLSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kM2ctrj0HyZU+MkP1JR69J1ynDXJMDhfHyxsdnHQKEaJBKdqEOFtSy0/aUZXH9Adw
         Hosli4xhu5kK2nutfLw333fIojUZun2KaSAI3gt+XIHrRaXNG8nfRmiqBCCe79ZiLZ
         EXS8jk871BqsZyGUHlf4y8KU+gzzuMOYhTSrkPs8=
Date:   Tue, 15 Oct 2019 21:05:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
Message-ID: <20191015210532.0a9ac342@archlinux>
In-Reply-To: <08f114477eb3ec15219f58a3d7d1b3ae@kernel.org>
References: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
        <20190330153140.7bfecadf@archlinux>
        <20190902131301.GI2680@smile.fi.intel.com>
        <20190903185119.2328cf86@archlinux>
        <20191001081933.GD32742@smile.fi.intel.com>
        <20191015151450.GL32742@smile.fi.intel.com>
        <08f114477eb3ec15219f58a3d7d1b3ae@kernel.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Oct 2019 16:40:42 +0100
jic23@kernel.org wrote:

> On 15.10.2019 16:14, Andy Shevchenko wrote:
> > On Tue, Oct 01, 2019 at 11:19:33AM +0300, Andy Shevchenko wrote:  
> >> On Tue, Sep 03, 2019 at 06:51:19PM +0100, Jonathan Cameron wrote:  
> >> > On Mon, 2 Sep 2019 16:13:01 +0300
> >> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> >> > > On Sat, Mar 30, 2019 at 03:31:40PM +0000, Jonathan Cameron wrote:  
> >> > > > On Tue, 26 Mar 2019 16:51:38 +0200
> >> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> >>   
> >> > > > Give me a poke if I seem to have forgotten it.  
> >>   
> >> > > Lee applied the main driver to his tree [1].
> >> > > Should I do anything for this one or is it applicable clean?
> >> > >
> >> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=b9a801dfa591
> >> > >  
> >> > Hmm. It's very late in the cycle and Lee doesn't have that in an immutable
> >> > branch (presumably because it's very late or it wasn't clear there was
> >> > a need to do so).  In theory I've done my last pull request to Greg
> >> > (though I messed it up so that's not quite true).
> >> >
> >> > Will have to pick this up towards the start of the next cycle now I think.  
> >> 
> >> Now everything needed is in v5.4-rc1. Your move!  
> > 
> > Jonathan, anything I can do to make this accepted?  
> Nearly  there.  Upstream from iio.git should now have the dependencies
> and I'm in a state to rebase (as of yesterday).  If it's a quiet day
> I'll get it done this evening!
> 
> Sorry for the delay - my fault for picking a random point at which to
> base  my tree rather than waiting for rc1.
> 
> Jonathan

Yikes, getting the driver to actually build doesn't half require chasing
down a lot of dependencies.  Anyhow, now applied to the togreg branch of
iio.git and pushed out as testing for the autobuilders to poke at it.

Thanks,

Jonathan

