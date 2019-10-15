Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2186AD79F8
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2019 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfJOPkp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Oct 2019 11:40:45 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:38232 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJOPkp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2019 11:40:45 -0400
Received: from roundcube.retrosnub.co.uk (hati.retrosnub.co.uk [IPv6:2a00:1098:86::4:1])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8CBAE9E79F2;
        Tue, 15 Oct 2019 16:40:43 +0100 (BST)
Received: from [86.188.218.117]
 by roundcube.retrosnub.co.uk
 with HTTP (HTTP/1.1 POST); Tue, 15 Oct 2019 16:40:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Oct 2019 16:40:42 +0100
From:   jic23@kernel.org
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver
In-Reply-To: <20191015151450.GL32742@smile.fi.intel.com>
References: <20190326145138.19717-1-andriy.shevchenko@linux.intel.com>
 <20190330153140.7bfecadf@archlinux>
 <20190902131301.GI2680@smile.fi.intel.com>
 <20190903185119.2328cf86@archlinux>
 <20191001081933.GD32742@smile.fi.intel.com>
 <20191015151450.GL32742@smile.fi.intel.com>
Message-ID: <08f114477eb3ec15219f58a3d7d1b3ae@kernel.org>
X-Sender: jic23@kernel.org
User-Agent: Roundcube Webmail/1.2.5 (Retrosnub)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 15.10.2019 16:14, Andy Shevchenko wrote:
> On Tue, Oct 01, 2019 at 11:19:33AM +0300, Andy Shevchenko wrote:
>> On Tue, Sep 03, 2019 at 06:51:19PM +0100, Jonathan Cameron wrote:
>> > On Mon, 2 Sep 2019 16:13:01 +0300
>> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > > On Sat, Mar 30, 2019 at 03:31:40PM +0000, Jonathan Cameron wrote:
>> > > > On Tue, 26 Mar 2019 16:51:38 +0200
>> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> 
>> > > > Give me a poke if I seem to have forgotten it.
>> 
>> > > Lee applied the main driver to his tree [1].
>> > > Should I do anything for this one or is it applicable clean?
>> > >
>> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=b9a801dfa591
>> > >
>> > Hmm. It's very late in the cycle and Lee doesn't have that in an immutable
>> > branch (presumably because it's very late or it wasn't clear there was
>> > a need to do so).  In theory I've done my last pull request to Greg
>> > (though I messed it up so that's not quite true).
>> >
>> > Will have to pick this up towards the start of the next cycle now I think.
>> 
>> Now everything needed is in v5.4-rc1. Your move!
> 
> Jonathan, anything I can do to make this accepted?
Nearly  there.  Upstream from iio.git should now have the dependencies
and I'm in a state to rebase (as of yesterday).  If it's a quiet day
I'll get it done this evening!

Sorry for the delay - my fault for picking a random point at which to
base  my tree rather than waiting for rc1.

Jonathan
