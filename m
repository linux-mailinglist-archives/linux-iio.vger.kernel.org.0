Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64809193F
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 21:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRTWN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 15:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfHRTWM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 15:22:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0712A21872;
        Sun, 18 Aug 2019 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566156131;
        bh=kTL4UDLSXLvmjM03ClypGmxsaii700J02b+vjKQpTNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZerEQf5HkTwb+BuisenhUs8Xp4QLbJjGJbEl3M1nLXOeqW4b5Ftys+gm3NX432uD
         5eQqVvDIF6TzkBiU7TlVe6GirdZ64QcK+kyzwa9KRWUJ1V4oWHY+/fUWxht12VNeyd
         WHgZvHwrWUboM+XiFqYpr2DLx8L+HlY+c0BqM/ek=
Date:   Sun, 18 Aug 2019 20:22:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v1] iio: hid-sensor-attributes: Convert to use int_pow()
Message-ID: <20190818202206.63a5663f@archlinux>
In-Reply-To: <20190813144315.GH30120@smile.fi.intel.com>
References: <20190619140702.18506-1-andriy.shevchenko@linux.intel.com>
        <20190622100642.7a8fb0ff@archlinux>
        <20190813144315.GH30120@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 13 Aug 2019 17:43:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Jun 22, 2019 at 10:06:42AM +0100, Jonathan Cameron wrote:
> > On Wed, 19 Jun 2019 17:07:02 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > Instead of linear approach to calculate power of 10, use generic int_pow()
> > > which does it better.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > Hi Andy,
> > 
> > Looks good to me, but I would like Srinivas to take a look and
> > preferably test this a bit just to check we aren't all missing something
> > subtle!
> > 
> > +CC Srinivas  
> 
> Srinivas, do you have any comments on this?
I think Srinivas got dropped from your CC list for some reason.

Anyhow, it's been a while so let's conclude Srinivas is busy and
rely on it being as obviously correct as it seems to be ;)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> 
> > 
> > Thanks,
> > 
> > Jonathan  
> > > ---
> > >  .../hid-sensors/hid-sensor-attributes.c       | 53 ++++++++-----------
> > >  1 file changed, 22 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > index a8a3fe428d8d..b9dd19b34267 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/module.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/irq.h>
> > > +#include <linux/kernel.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/hid-sensor-hub.h>
> > >  #include <linux/iio/iio.h>
> > > @@ -68,16 +69,6 @@ static struct {
> > >  	{HID_USAGE_SENSOR_HUMIDITY, 0, 1000, 0},
> > >  };
> > >  
> > > -static int pow_10(unsigned power)
> > > -{
> > > -	int i;
> > > -	int ret = 1;
> > > -	for (i = 0; i < power; ++i)
> > > -		ret = ret * 10;
> > > -
> > > -	return ret;
> > > -}
> > > -
> > >  static void simple_div(int dividend, int divisor, int *whole,
> > >  				int *micro_frac)
> > >  {
> > > @@ -96,14 +87,14 @@ static void simple_div(int dividend, int divisor, int *whole,
> > >  			rem *= 10;
> > >  			exp++;
> > >  		}
> > > -		*micro_frac = (rem / divisor) * pow_10(6-exp);
> > > +		*micro_frac = (rem / divisor) * int_pow(10, 6 - exp);
> > >  	}
> > >  }
> > >  
> > >  static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
> > >  {
> > > -	*val1 = no/pow_10(exp);
> > > -	*val2 = no%pow_10(exp) * pow_10(6-exp);
> > > +	*val1 = no / int_pow(10, exp);
> > > +	*val2 = no % int_pow(10, exp) * int_pow(10, 6 - exp);
> > >  }
> > >  
> > >  /*
> > > @@ -125,7 +116,7 @@ static void convert_from_vtf_format(u32 value, int size, int exp,
> > >  	}
> > >  	exp = hid_sensor_convert_exponent(exp);
> > >  	if (exp >= 0) {
> > > -		*val1 = sign * value * pow_10(exp);
> > > +		*val1 = sign * value * int_pow(10, exp);
> > >  		*val2 = 0;
> > >  	} else {
> > >  		split_micro_fraction(value, -exp, val1, val2);
> > > @@ -145,10 +136,10 @@ static u32 convert_to_vtf_format(int size, int exp, int val1, int val2)
> > >  		sign = -1;
> > >  	exp = hid_sensor_convert_exponent(exp);
> > >  	if (exp < 0) {
> > > -		value = abs(val1) * pow_10(-exp);
> > > -		value += abs(val2) / pow_10(6+exp);
> > > +		value = abs(val1) * int_pow(10, -exp);
> > > +		value += abs(val2) / int_pow(10, 6 + exp);
> > >  	} else
> > > -		value = abs(val1) / pow_10(exp);
> > > +		value = abs(val1) / int_pow(10, exp);
> > >  	if (sign < 0)
> > >  		value =  ((1LL << (size * 8)) - value);
> > >  
> > > @@ -211,12 +202,12 @@ int hid_sensor_write_samp_freq_value(struct hid_sensor_common *st,
> > >  	if (val1 < 0 || val2 < 0)
> > >  		return -EINVAL;
> > >  
> > > -	value = val1 * pow_10(6) + val2;
> > > +	value = val1 * int_pow(10, 6) + val2;
> > >  	if (value) {
> > >  		if (st->poll.units == HID_USAGE_SENSOR_UNITS_MILLISECOND)
> > > -			value = pow_10(9)/value;
> > > +			value = int_pow(10, 9) / value;
> > >  		else if (st->poll.units == HID_USAGE_SENSOR_UNITS_SECOND)
> > > -			value = pow_10(6)/value;
> > > +			value = int_pow(10, 6) / value;
> > >  		else
> > >  			value = 0;
> > >  	}
> > > @@ -311,34 +302,34 @@ static void adjust_exponent_nano(int *val0, int *val1, int scale0,
> > >  	int rem;
> > >  
> > >  	if (exp > 0) {
> > > -		*val0 = scale0 * pow_10(exp);
> > > +		*val0 = scale0 * int_pow(10, exp);
> > >  		res = 0;
> > >  		if (exp > 9) {
> > >  			*val1 = 0;
> > >  			return;
> > >  		}
> > >  		for (i = 0; i < exp; ++i) {
> > > -			x = scale1 / pow_10(8 - i);
> > > -			res += (pow_10(exp - 1 - i) * x);
> > > -			scale1 = scale1 % pow_10(8 - i);
> > > +			x = scale1 / int_pow(10, 8 - i);
> > > +			res += int_pow(10, exp - 1 - i) * x;
> > > +			scale1 = scale1 % int_pow(10, 8 - i);
> > >  		}
> > >  		*val0 += res;
> > > -		*val1 = scale1 * pow_10(exp);
> > > +		*val1 = scale1 * int_pow(10, exp);
> > >  	} else if (exp < 0) {
> > >  		exp = abs(exp);
> > >  		if (exp > 9) {
> > >  			*val0 = *val1 = 0;
> > >  			return;
> > >  		}
> > > -		*val0 = scale0 / pow_10(exp);
> > > -		rem = scale0 % pow_10(exp);
> > > +		*val0 = scale0 / int_pow(10, exp);
> > > +		rem = scale0 % int_pow(10, exp);
> > >  		res = 0;
> > >  		for (i = 0; i < (9 - exp); ++i) {
> > > -			x = scale1 / pow_10(8 - i);
> > > -			res += (pow_10(8 - exp - i) * x);
> > > -			scale1 = scale1 % pow_10(8 - i);
> > > +			x = scale1 / int_pow(10, 8 - i);
> > > +			res += int_pow(10, 8 - exp - i) * x;
> > > +			scale1 = scale1 % int_pow(10, 8 - i);
> > >  		}
> > > -		*val1 = rem * pow_10(9 - exp) + res;
> > > +		*val1 = rem * int_pow(10, 9 - exp) + res;
> > >  	} else {
> > >  		*val0 = scale0;
> > >  		*val1 = scale1;  
> >   
> 

