Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11934CDC6
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 12:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC2KNu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Mar 2021 06:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232243AbhC2KNn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 06:13:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEAD617C9;
        Mon, 29 Mar 2021 10:13:41 +0000 (UTC)
Date:   Mon, 29 Mar 2021 11:13:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to
 sysfs_emit()
Message-ID: <20210329111346.64af72ab@jic23-huawei>
In-Reply-To: <5fda4359734f5b008040090d1bad96e36473e307.camel@perches.com>
References: <20210320071405.9347-1-lars@metafoo.de>
        <20210320071405.9347-5-lars@metafoo.de>
        <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
        <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
        <5fda4359734f5b008040090d1bad96e36473e307.camel@perches.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 20 Mar 2021 08:13:55 -0700
Joe Perches <joe@perches.com> wrote:

> On Sat, 2021-03-20 at 13:52 +0100, Lars-Peter Clausen wrote:
> > On 3/20/21 12:01 PM, Joe Perches wrote:  
> > > On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:  
> > > > Update DAC drivers powerdown attribute show callback to use the new
> > > > sysfs_emit() function.
> > > > 
> > > > sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
> > > > knows about the sysfs buffer specifics and has some built-in sanity checks.  
> > > Thanks.
> > > 
> > > unrelated trivia:
> > >   
> > > > diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c  
> > > []  
> > > > @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
> > > >   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > > >   	struct ad5360_state *st = iio_priv(indio_dev);
> > > >   
> > > > 
> > > > -	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> > > > +	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));  
> > > rather than cast to bool, perhaps standardize to use !!(val & test)  
> > I very much prefer the cast to bool since it semantically stronger. You 
> > don't have to know that the !! idiom is used to cast an int to bool.  
> 
> Using !! does not cast to bool, it's an int.
> 
> casting to bool and using %d in a printf equivalent ends up with an
> integer promotion/implicit type conversion from bool to int.
> 
> Anyway, it's not my code so it's author's choice, but similar
> code using different styles is, at a minimum, inconsistent.
> 
I'm certainly not against cleaning this up at somepoint, but it's not strictly
part of what this particular patch set is doing, so I'd rather do
it separately anyway.

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

