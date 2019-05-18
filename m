Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161902224C
	for <lists+linux-iio@lfdr.de>; Sat, 18 May 2019 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfERIqN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 May 2019 04:46:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfERIqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 May 2019 04:46:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D41520872;
        Sat, 18 May 2019 08:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558169171;
        bh=BAmzia/juQlU1FpjFzPY18M0wybiA82UzSc67eiEOxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zAhkYO/WuYgMNfFwyeHFO3T2ohMfJb+E5kAZoyyPjvHyI91xAfZCnRy7Qzeh1ci7D
         Iz0xKTZbzrTefspuCi0ZoiMSOYrQAV0UjWHylG6/VPU7Wcl9+4cHBdtpuAYVngiQdz
         TV5fwwrlJfwykxju+jtbZ0LhzjR+t86aBlNKeONs=
Date:   Sat, 18 May 2019 09:46:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de
Subject: Re: [PATCH v2 1/3] iio: Add driver for Infineon DPS310
Message-ID: <20190518094607.50909f16@archlinux>
In-Reply-To: <cf108058-dd50-4651-6c97-a5c7e82ef085@linux.ibm.com>
References: <1557344128-690-1-git-send-email-eajames@linux.ibm.com>
        <1557344128-690-2-git-send-email-eajames@linux.ibm.com>
        <20190511102236.4c5f9585@archlinux>
        <cf108058-dd50-4651-6c97-a5c7e82ef085@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 May 2019 13:46:46 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> On 5/11/19 4:22 AM, Jonathan Cameron wrote:
> > On Wed,  8 May 2019 14:35:26 -0500
> > Eddie James <eajames@linux.ibm.com> wrote:
> >  
> >> From: Joel Stanley <joel@jms.id.au>
> >>
> >> The DPS310 is a temperature and pressure sensor. It can be accessed over
> >> i2c and SPI.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>  
> > Hi Eddie,
> >
> > Ideally we'll get a sign off form Joel as well on this.
> >
> > A few comments inline.
> >
> > I 'think' this is probably fine without any locking to prevent simultaneous reads
> > and /or writes to the registers because the few functions that do multiple reads
> > and writes look fine.  Please do take another look at that though to confirm there
> > are no corner cases.
> >
> > Otherwise there is a race in the remove path that needs fixing.
> > Various minor bits and bobs inline.
> >
> > thanks,
> >
> > Jonathan
> >
> >
> >  
> >> ---
> >>   MAINTAINERS                   |   6 +
> >>   drivers/iio/pressure/Kconfig  |  10 +
> >>   drivers/iio/pressure/Makefile |   1 +
> >>   drivers/iio/pressure/dps310.c | 429 ++++++++++++++++++++++++++++++++++++++++++
> >>   4 files changed, 446 insertions(+)
> >>   create mode 100644 drivers/iio/pressure/dps310.c
> >>  
> 
> >> +};
> >> +MODULE_DEVICE_TABLE(i2c, dps310_id);
> >> +
> >> +static const unsigned short normal_i2c[] = {
> >> +	0x77, 0x76, I2C_CLIENT_END
> >> +};
> >> +
> >> +static struct i2c_driver dps310_driver = {
> >> +	.driver = {
> >> +		.name = "dps310",
> >> +	},
> >> +	.probe = dps310_probe,
> >> +	.remove = dps310_remove,
> >> +	.address_list = normal_i2c,  
> > I'm fairly sure the address list is only used along with the detection
> > infrastructure.  As such it doesn't actually provide any value unless
> > you have a detect callback.  Please remove.
> >
> > I would like to see a DT and/or ACPI binding though as that is the
> > means most people will use to find the device.  
> 
> 
> Somehow the device is already present in the witherspoon device tree 
> where it's currently being used, so I don't have anything to add. 
> arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
Yes, there is a fallback path (which in theory will be removed one day)
in which the vendor is stripped off the dts entry and the rest matched
against the registered i2c device table.

However, it's less than ideal as it'll lead to a potential false match
if some other company uses dps310 as a part number.

Hence it is preferred to always provide and explicit dt binding which is
checked before this fallback path.

As a side note, this is a classic thing for people to pick up on and send
follow up patches for.  Makes everyone's life easier to do it early!

Thanks,

Jonathan

> 
> Thanks,
> 
> Eddie
> 
> 
> >  
> >> +	.id_table = dps310_id,
> >> +};
> >> +module_i2c_driver(dps310_driver);
> >> +
> >> +MODULE_AUTHOR("Joel Stanley <joel@jms.id.au>");
> >> +MODULE_DESCRIPTION("Infineon DPS310 pressure and temperature sensor");
> >> +MODULE_LICENSE("GPL v2");  
> 

