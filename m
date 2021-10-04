Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F1E421747
	for <lists+linux-iio@lfdr.de>; Mon,  4 Oct 2021 21:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbhJDTXV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Oct 2021 15:23:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232043AbhJDTXV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Oct 2021 15:23:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F14C61130;
        Mon,  4 Oct 2021 19:21:30 +0000 (UTC)
Date:   Mon, 4 Oct 2021 20:25:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kunyang Fan <Kunyang_Fan@aaeon.com.tw>
Subject: Re: [PATCH] iio: adc: ti-adc081c: Partial revert of removal of ACPI
 IDs
Message-ID: <20211004202529.36b2e1dd@jic23-huawei>
In-Reply-To: <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
References: <20211003162417.427260-1-jic23@kernel.org>
        <CAHp75VfduySLoeLUS0QsjVhqm7bfh9pbwreMmBYkTva7EH6jPg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 Oct 2021 19:28:06 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Oct 3, 2021 at 7:20 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Unfortuanately a non standards compliant ACPI ID is known to be  
> 
> Unfortunately

One day I'll actually remember to spell check my patch descriptions.
Sorry!

> 
> > in the wild on some AAEON boards.
> >
> > Partly revert the removal of these IDs so that ADC081C will again
> > work + add a comment to that affect for future reference.  
> 
> affect?! Okay, you are native speaker.

Doesn't make me competent at writing my native language :)

> 
> ...
> 
> > +#include <linux/acpi.h>  
> 
> > +       if (ACPI_COMPANION(&client->dev)) {
> > +               const struct acpi_device_id *ad_id;
> > +
> > +               ad_id = acpi_match_device(client->dev.driver->acpi_match_table,
> > +                                         &client->dev);
> > +               if (!ad_id)
> > +                       return -ENODEV;
> > +               model = &adcxx1c_models[ad_id->driver_data];
> > +       } else {
> > +               model = &adcxx1c_models[id->driver_data];
> > +       }  
> 
> Can we please use device_get_match_data() instead (with corresponding
> property.h inclusion instead of acpi.h)?
> This may require adding driver_data to OF IDs.
> 

Sure. I was going for minimal change + most revert like, but fair enough
we'll clean that up whilst here.

Jonathan


