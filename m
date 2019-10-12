Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25E6D4E9F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfJLJbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 05:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJLJ3Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 05:29:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A310206A1;
        Sat, 12 Oct 2019 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570872563;
        bh=gxaRUVY8E1/KFigUY3uva7Oja1DegcG2ZBJ0mfjL7JI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slJ4SI6YVMHjn95c8ZAJVo0qfYC8I6roX1VrsAMPeoNOJQhQn5co9n8WXQF4IMg7m
         CBR/mg8+05q4j/HBP0QAe2nYgq1EEfwRVapOnC+d8c0QJEF8+WuNzCO0aui9uhp6/c
         PA+e07/n285aMevlrXozpPI+jE6nXatljd04aNHs=
Date:   Sat, 12 Oct 2019 10:29:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dan Robertson <dan@dlrobertson.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: (bma400) add driver for the BMA400
Message-ID: <20191012102917.7e85275f@archlinux>
In-Reply-To: <CAHp75VeBrR0Ln5XOw5zA+JSoXM9BdoYw7p9D5c7u+2=Lfht75w@mail.gmail.com>
References: <20191012035420.13904-1-dan@dlrobertson.com>
        <20191012035420.13904-3-dan@dlrobertson.com>
        <d6f44aea-81b9-eb5f-71e2-637246c89491@infradead.org>
        <CAHp75VeBrR0Ln5XOw5zA+JSoXM9BdoYw7p9D5c7u+2=Lfht75w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 12 Oct 2019 10:39:54 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Oct 12, 2019 at 10:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 10/11/19 8:54 PM, Dan Robertson wrote:  
> 
> > > +config BMA400_I2C
> > > +     tristate
> > > +     depends on BMA400
> > > +     depends on I2C
> > > +     select REGMAP_I2C
> > > +  
> >
> > The bma400_i2c driver seems to use some OF interfaces.
> > Should it also depend on OF?  
> 
> Please, avoid unnecessary and strict dependencies when it's limiting
> the area of use the driver.
> The driver does not depend to OF. Why to stick with OF?
> 
> The actual change has to be done is to switch from
> 
> > #include <linux/of.h>  
> 
> to
> 
> #include <linux/mod_devicetable.h>
> 

Good point Andy.  There are numerous drivers in IIO that do the same
over enthusiastic including of linux/of.h just to get of_device_id
definition.  Would be good to clean those up to just include this
instead.

This is going to cause very little noise so if there are any new
contributors reading this it would be a nice sensible cleanup to get
started with!

Thanks,

Jonathan

