Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072A413810C
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2020 12:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgAKLI6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Jan 2020 06:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgAKLI6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Jan 2020 06:08:58 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1C82082E;
        Sat, 11 Jan 2020 11:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578740937;
        bh=MvZS5WNLqGW/doVpAC+w0vfPLEIYo0Xh8CvN9CODJMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W71HK4nQVFWYKXO6PQmIEYQacdiYUhe84vSF8z0aNinhUlqnsJA5H1t+E3MPqyhES
         oxshknnX5UWpQCJNOpFjV3dtVuXEAh/Yv4gpf3SJVcsgdB8g4WvXnx0YDSWLcR06z7
         ZwsH34HdzX+e51ZbHSWI6E+eWYT/L1u8fWJlWGOs=
Date:   Sat, 11 Jan 2020 11:08:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>
Subject: Re: [PATCH] iio: frequency: adf4371: Fix divide by zero exception
 bug
Message-ID: <20200111110848.7c45a4f3@archlinux>
In-Reply-To: <20200107131559.17772-1-beniamin.bia@analog.com>
References: <20200107131559.17772-1-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Jan 2020 15:15:59 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> During initialization adf4371_pll_fract_n_get_rate() is called on all
> output channels to determine if the device was setup. In this case
> mod2 is zero which can cause a divide by zero exception.
> Return before that can happen.
I'm confused by this description vs the code.

As far as I can see fract_n_get_rate is only called on a sysfs read of
the frequency. 

mod2 is set when fract_n_compute is called in the relevant set_freq calls.
This seems to occur on a sysfs set frequency call.

So the issue here is that a sysfs read before a write of the frequency
will cause a div zero?  If so, is there a sane set of initial values we
can put in mod2 and friends before exposing them via the device register?

If mod2==0 is a valid value and indicates for example that the channel
is turned off, then the description should make that clear.

Jonathan

> 
> Fixes: 7f699bd149134 ("iio: frequency: adf4371: Add support for ADF4371 PLL")
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
>  drivers/iio/frequency/adf4371.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
> index e2a599b912e5..c21462238314 100644
> --- a/drivers/iio/frequency/adf4371.c
> +++ b/drivers/iio/frequency/adf4371.c
> @@ -191,6 +191,9 @@ static unsigned long long adf4371_pll_fract_n_get_rate(struct adf4371_state *st,
>  	unsigned long long val, tmp;
>  	unsigned int ref_div_sel;
>  
> +	if (st->mod2 == 0)
> +		return 0;
> +
>  	val = (((u64)st->integer * ADF4371_MODULUS1) + st->fract1) * st->fpfd;
>  	tmp = (u64)st->fract2 * st->fpfd;
>  	do_div(tmp, st->mod2);

