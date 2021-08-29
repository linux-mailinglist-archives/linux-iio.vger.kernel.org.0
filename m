Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2E3FACFF
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhH2QDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235167AbhH2QDF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 12:03:05 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431D060F42;
        Sun, 29 Aug 2021 16:02:10 +0000 (UTC)
Date:   Sun, 29 Aug 2021 17:05:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210829170525.2e84dac1@jic23-huawei>
In-Reply-To: <20210818080213.d56phfmjlwbgzlca@uno.localdomain>
References: <20210817154951.50208-1-jacopo@jmondi.org>
        <20210817154951.50208-3-jacopo@jmondi.org>
        <YRvqvt4qVVe1+K1/@smile.fi.intel.com>
        <20210818080213.d56phfmjlwbgzlca@uno.localdomain>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> Ack
> 
> > > +			ret = sunrise_read_co2_filtered(client, &co2);
> > > +			*val = co2;
> > > +			mutex_unlock(&sunrise->lock);
> > > +
> > > +			return ret ? ret : IIO_VAL_INT;  
> >
> > Can be written as
> >
> > 			return ret ?: IIO_VAL_INT;
> >
> > but up to maintainers.
> >  
> 
> You know I never saw this syntax before ? :D
> I'll use it!
I'm rather late to the party, but I'd keep all error handling in driver of the form

	if (ret)
		return ret;

	return IIO_VAL_INT;

That means lazy reviewers like me have one less thing to think about ;)



