Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45FB1B877D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 17:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDYPw2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 11:52:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgDYPw2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 11:52:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3416520748;
        Sat, 25 Apr 2020 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587829947;
        bh=sSzcBJpJQDV6XFyy+Mxe6whwFoOrRKDwYzXXoWKA+Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jd99gAHJsOwVZSzFyax2jkh18W+fjYSLNqtyhqF2PT7QyXptbdMHX6llBbNoltt+P
         zZ7osfqjIMzLYdErQie9d8YJoB/g7j1ykdNjFo5uuI+85ZI2uVKn4vNmWIRh2sZEzX
         NdCwAs/BcJQozbd4UlHatGkMwKxhVhhIwSp6gyzw=
Date:   Sat, 25 Apr 2020 16:52:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mathieu Othacehe <m.othacehe@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] iio: vcnl4000: Add sampling frequency support
 for VCNL4010/20.
Message-ID: <20200425165223.0fc0e930@archlinux>
In-Reply-To: <CAHp75VcJ300S8r_f2cueYzB0OaLBJK9oJySgz5Jekb7dGFWnCw@mail.gmail.com>
References: <20200421075532.19192-1-m.othacehe@gmail.com>
        <20200421075532.19192-4-m.othacehe@gmail.com>
        <CAHp75VcJ300S8r_f2cueYzB0OaLBJK9oJySgz5Jekb7dGFWnCw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 15:22:11 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 21, 2020 at 10:56 AM Mathieu Othacehe <m.othacehe@gmail.com> wrote:
> >
> > Add sampling frequency support for proximity data on VCNL4010 and VCNL4020
> > chips.  
> 
> Couple of nitpicks below.
> 
> ...
> 
> > +static const int vcnl4010_prox_sampling_frequency[][2] = {
> > +       {1, 950000},
> > +       {3, 906250},
> > +       {7, 812500},
> > +       {16, 625000},
> > +       {31, 250000},
> > +       {62, 500000},
> > +       {125, 0},  
> 
> > +       {250, 0}  
> 
> Leave comma here, potentially helpful if it will be extended.

Hi Andy,

Doesn't particularly matter either way, but given this is a list of the values
supported by the device, very unlikely it will be extended.

Games like trying to share the first part of a longer array between
multiple device types might occur, but those are usually really ugly.

Jonathan

> 
> > +};  
> 
> ...
> 
> > +static int vcnl4010_write_proxy_samp_freq(struct vcnl4000_data *data, int val,
> > +                                         int val2)
> > +{
> > +       int i;
> > +       const int len = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
> > +
> > +       for (i = 0; i < len; i++) {
> > +               if (val <= vcnl4010_prox_sampling_frequency[i][0])
> > +                       break;
> > +       }
> > +
> > +       if (i == len)
> > +               return -EINVAL;  
> 
> I would refactor this
> 
>   unsigned int i = ARRAY_SIZE(vcnl4010_prox_sampling_frequency);
> 
>   do {
>     if (val > vcnl4010_prox_sampling_frequency[i][0])
>       break;
>   } while (--i);
> 
> You won't need to go full array to return error in this case.
> 
> > +       return i2c_smbus_write_byte_data(data->client, VCNL4010_PROX_RATE, i);
> > +}  
> 

