Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256393F45AC
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhHWHQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 03:16:23 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55279 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbhHWHQU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 03:16:20 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B2AC860015;
        Mon, 23 Aug 2021 07:15:33 +0000 (UTC)
Date:   Mon, 23 Aug 2021 09:16:22 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] iio: chemical: Add Senseair Sunrise CO2 sensor
Message-ID: <20210823071622.3apzw2pxlfebls3m@uno.localdomain>
References: <20210822184927.94673-1-jacopo@jmondi.org>
 <CAHp75VcM8Z58_EdzZKxy8r=BojYsfgSM+F6fSuDgwTbg1zvXVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcM8Z58_EdzZKxy8r=BojYsfgSM+F6fSuDgwTbg1zvXVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Andy,

On Sun, Aug 22, 2021 at 11:11:59PM +0300, Andy Shevchenko wrote:
> On Sun, Aug 22, 2021 at 9:49 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > The driver supports continuous reads of temperature and CO2 concentration
> > through two dedicated IIO channels. It also supports calibration and error
> > inspection through the concentration channel ext_info.
> >
> > Minor changes in v3
>
> Not sure, I have found bigger issues. See my comments in patch 2.
> So, since it's obvious you haven't tested the patch and we are at rc7
> I think you can take a few weeks of time to have a look and carefully
> address all comments and to test.

I'm sorry if the patches I sent out contain a leftover debug (the
pr_err) and I cannot explain how the :q commands ended up in the final
patch, most probably they come from me inspecting the generated patch
and being sloppy with vim on a sunday night, as they are not in the
git tree. They won't have even compiled otherwise, and it's obvious
where they come from if you've ever used vim.

Aprt from that, this is a v3, not v7, I've tested it several times, there's
no need to paternalize me as the only thing to fix is to re-add back
the ending commas in arrays declarations as a result of a comment from
you which I interpreted as a request from removing them. To me commas
at the end of an array declaration is mostly nit picking, which I
accept given the context and given I don't know the subsystem rules,
but please consider the last version of the patch mostly fixes minor
style issue which are questionable (lines that can span over 80 cols,
terminating commas, empty line at the beginning of the switch which I
liked but you didn't, 'Typically' in the bindings etc)).

So please consider that it took me a sunday
afternoon to please your preferences. If a debug printout leftover has
escaped I'm sorry, I've been sloppy. The ':q' in the final patch are
another obvious stupid mistake but the assumption that I've not tested
the patches it's really not appropriate.

As I appreciate your effort in review and I've silently gone over all
your comments, even the questionable ones, I don't think it's fair to
crucify someone which has sent a fully working driver with no major issues
(none that has been found so far at least) for two stupid leftovers.

I'll send v4 re-adding back the commas at the end of arrays.
>
> --
> With Best Regards,
> Andy Shevchenko
