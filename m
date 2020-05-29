Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D341E7ED1
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgE2Nd4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 09:33:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46728 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2Nd4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 May 2020 09:33:56 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C71731C0388; Fri, 29 May 2020 15:33:54 +0200 (CEST)
Date:   Fri, 29 May 2020 15:33:46 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200529133346.GC1339@bug>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518133645.19127-4-jonathan.albrieux@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

> AK09911 has a reset gpio to handle register's reset. If reset gpio is
> set to low it will trigger the reset. AK09911 datasheed says that if not
> used reset pin should be connected to VID and this patch emulates this
> situation
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
>  	/*
> -	 * According to the datasheet the power supply rise time i 200us
> +	 * According to the datasheet the power supply rise time is 200us
>  	 * and the minimum wait time before mode setting is 100us, in
> -	 * total 300 us. Add some margin and say minimum 500us here.
> +	 * total 300us. Add some margin and say minimum 500us here.
>  	 */
>  	usleep_range(500, 1000);

I'd assume that datasheet added some safety margin too, and there's another one in usleep...
So I believe usleep..(300) should be okay..

Best regards,
										Pavel
