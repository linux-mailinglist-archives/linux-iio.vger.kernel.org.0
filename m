Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 770151156AE
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFRnG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:43:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfLFRnF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:43:05 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95B4E21823;
        Fri,  6 Dec 2019 17:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575654184;
        bh=AmTJBa8MWxN/nfhHA44NQeIpAd7sgnoFexRxCPac5Mc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t97jSZJ44m8ygZ0UkY4C9SduX5XYL5yTYaZgy/g2gghUx0b5HIAIqmGk20GBl1Tn7
         0KejI/KfHFsMb3GUvO9lQ9MW6CLnpJM3D0dsn2jmAqNpuYPdDUBHewUCJBTq1Pb8iN
         g6PgaBBszFgGJPxs1+nodVfgxMojJWK4KUlDqOf8=
Date:   Fri, 6 Dec 2019 17:43:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH] iio: ak8975: Convert to use GPIO descriptor
Message-ID: <20191206174300.03541cf4@archlinux>
In-Reply-To: <20191202125756.GF32742@smile.fi.intel.com>
References: <20191202081730.61707-1-linus.walleij@linaro.org>
        <20191202125148.GE32742@smile.fi.intel.com>
        <20191202125756.GF32742@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Dec 2019 14:57:56 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Dec 02, 2019 at 02:51:48PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 02, 2019 at 09:17:30AM +0100, Linus Walleij wrote:  
> > > The end-of-conversion (EOC) GPIO line is better to grab using
> > > a GPIO descriptor. We drop the pdata for this: clients using board
> > > files can use machine descriptor tables to pass this GPIO from
> > > static data.  
> 
> > >  		dev_err(&client->dev,
> > > -			"irq %d request failed, (gpio %d): %d\n",
> > > -			irq, data->eoc_gpio, rc);
> > > +			"irq %d request failed: %d\n",
> > > +			irq, rc);  
> > 
> > Now it fits one line.  
> 
> I meant including dev_err().
> 

Tidied up whilst applying.  Applied to the togreg branch of iio.git.
Pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
