Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69A93FBA1D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhH3Q1x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 12:27:53 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38073 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhH3Q1x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2021 12:27:53 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B48AA60007;
        Mon, 30 Aug 2021 16:26:56 +0000 (UTC)
Date:   Mon, 30 Aug 2021 18:27:46 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210830162746.3xe3tjtjjk5rm5i4@uno.localdomain>
References: <20210822184927.94673-3-jacopo@jmondi.org>
 <20210823073639.13688-1-jacopo@jmondi.org>
 <20210829175413.7ce30bfa@jic23-huawei>
 <20210830162051.rjqlhwvtguaivt3p@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210830162051.rjqlhwvtguaivt3p@uno.localdomain>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 30, 2021 at 06:20:55PM +0200, Jacopo Mondi wrote:
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		/* Chip temperature scale = 1/100 */
> >
> > IIO temperatures are measured in milli degrees.  1lsb = 1/100*1000 degrees centigrade seems very accurate
> > for a device like this!  I'm guessing this should be 10.
>
> Ah yes, I thought it had to be given in the chip's native format,
> which is 1/100 degree.
>
> I guess I should then multiply by 10 the temperature raw read and
> return IIO_VAL_INT here.

Of course I don't have to multiply by 10 the raw value, and that's
what the _scale attribute is for.

Fingers faster than brain it seems. And I'm a slow typer.
