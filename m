Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1056B1A5E59
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 13:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDLLtx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 07:49:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDLLtx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 07:49:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9968A20708;
        Sun, 12 Apr 2020 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586692193;
        bh=PrpTl0s79HlJ3c4Pqa4ubrsrZU1YRed/3oKXDqo07DU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yMMgxMaUlil1pVEvtn1FfEFQLKy0bMHeJON6YJY6cEGG9/f7gU9zlapxMXSIl9dmD
         ZX41Hxjg6dxib4IJzWIoNlLxG3rSbtQ+CPO3tFe/K1pTiyuHiH9tXItq861+M15Dsg
         Xyfvk6qUuvYVjHVLJPODatPrfapHHVqqgF9FNur4=
Date:   Sun, 12 Apr 2020 12:49:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v4 5/6] iio: imu: Add support for adis16475
Message-ID: <20200412124948.7aacb900@archlinux>
In-Reply-To: <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com>
References: <20200406150846.878-1-nuno.sa@analog.com>
        <20200406150846.878-6-nuno.sa@analog.com>
        <CAHp75VeK8K0WHK3gDwyT3ZAaMaVdfZ5xVG94JY4O8fd2U0HEHg@mail.gmail.com>
        <BN6PR03MB33476ECFB3F8454CC6C67F0E99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
        <CAHp75VcOxjnNRetQxUR=8Z-WA=V6rzAFwCfhjNCmjQE3hgAEEA@mail.gmail.com>
        <BN6PR03MB33475380CFB1AD5B50026A6A99C30@BN6PR03MB3347.namprd03.prod.outlook.com>
        <CAHp75VeAOKXNU+FEYsXBZ65sM1AWxB2zA+LJ2diAxyiJPk60mQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


> 
> > > > > > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > > > > > +                        indio_dev->masklength) {  
> > > > >
> > > > > One line?
> > > > >  
> > > >
> > > > It goes beyond 80 col limit... I know I could initialize these to some local  
> > > const but...
> > >
> > > That's why question mark is there.
> > > Nonetheless, if it ~2-3 characters more, I would leave it on one line anyway.
> > >
> > > JFYI: readability has a priority over 80 limit.
> > >  
> >
> > Thanks! I would say it also depends on the maintainer (not sure)? Some are more
> > strict about checkpatch...
> > Btw, the line will have 84 if one liner...  
> 
> Let's leave it to maintainer then.
> 

I care very little either way :)  In this case I'd argue that not being annoyed
by checkpatch is worth the ever so slightly uglier 2 line option but find it
hard to get worked up about it.


