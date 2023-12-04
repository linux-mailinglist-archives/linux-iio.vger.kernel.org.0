Return-Path: <linux-iio+bounces-605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A7803B1C
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 18:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EDC280FB7
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 17:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990D2E62E;
	Mon,  4 Dec 2023 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sOGewpoE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF741171D9
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 17:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EF7C433C7;
	Mon,  4 Dec 2023 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701709590;
	bh=yl7UEtwYIXWMb3aLTxITDLeUle/USlV/2Z6boVe2hB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sOGewpoEIzTFye2f4SvUDNjy+MF+Qk4QE+8JRduwLlhDi6ORo5PnBxN4nXL3iFag8
	 Xp7Wm4kwGYD2PP+odkSIz9Ph7/YBbZla0zlpCpInNK5AZf7A0DJWtW7YgrGhmCN54W
	 5crHOeWalZgBVEMZrXMOZI+x8rfD5r8y8L4SWSEyULP8hPrCloxz31M/zMoY+FRLaX
	 sBjwR+l46eMwMAmPN4gRWtUvaGpqI/OSSj0KgSBG19P49kZ881L9qSfjv5dj0h6l+O
	 X5eHiSxfc6JwQhG7Ncx1sA2ws3nUIZF6EeTHmSg1ju3QhzAd+2bZmQLkHLaqsESYyL
	 sAuYMewu6dsXg==
Date: Mon, 4 Dec 2023 17:06:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Crt Mori <cmo@melexis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp
 <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR
 Temperature sensor
Message-ID: <20231204170623.0c0cd598@jic23-huawei>
In-Reply-To: <CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
References: <cover.1701168726.git.cmo@melexis.com>
	<c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
	<20231204142224.51f2ccdf@jic23-huawei>
	<CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 16:34:30 +0100
Crt Mori <cmo@melexis.com> wrote:

> On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> ...
> > > switches to Continuous power mode where measurements constantly change
> > > without triggering.
> > >
> > > Signed-off-by: Crt Mori<cmo@melexis.com>  
> >
> > Hi Crt,
> >
> > I don't understand some of the regcache_cache_only() manipulation in here.
> > If I understand the aim correctly it is to allow us to write settings whilst
> > powered down (in sleep_step) that will then by synced to the device when it enters
> > continuous mode?
> >
> > If so, I'd expect to only see manipulation of whether the caching is or or
> > not at places where we transition state.  You currently have them in various
> > other place. In some cases I scan see it's to allow a temporary change of
> > state, but it's not obvious.  So perhaps a comment ever time you manually
> > tweak whether writes hit the device or just stick in the regacache.
> > That comment can explain why each of them is needed.
> >
> > A few other comments inline,
> >
> > Thanks,
> >
> > Jonathan
> >  
> 
> While in Sleep Step mode, the EEPROM is powered down, but the cache
> buffers those values. Still when you try to write or read a volatile
> register (which should not be prevented by cache enabled as per my
> opinion, but code says differently) in that mode, it returns -EBUSY
> (as we discovered by code), so this kind of manipulation is needed to
> enable write and read operations from volatile registers.

So the cache trick is just meant for the eeprom?  Can you use two regmaps.
(I've seen similar done for devices with different ways of reading which
this 'kind of' corresponds to).
One to cover the eeprom and the other the registers that always work.
That should let you separately control if they are in caching state or
not.
Or just read the eeprom into a manually created cache on boot?

> And you need
> to trigger the measurement (burst mode) in that state, but since you
> cannot read EEPROM, yet still need its values to calculate the final
> temperature, the cache is used for this case. There is nothing to
> re-cache when we get back as all registers I read/write to are marked
> as volatile, so they would not be cached anyway..  
> 
> Thanks for the review - I still have some questions below (and explanation,
> but not sure where to put those).
> 
> > > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile  
> ...
> > > + * @lock: Internal mutex for multiple reads for single measurement  
> >
> > Multiple reads shouldn't be a problem, unless someone else can do something
> > destructive in between.  Perhaps a little more detail on why multiple reads matter?
> >  
> 
> You trigger device to perform measurement in Sleep Step mode, so to
> ensure both object and ambient temperature reads are from the same
> triggered measurement, the mutex needs to be held. If for example in
> between you would retrigger the measurement, then you would operate on
> "invalid" data (shouldn't differ much, but I wanted to prevent that as
> it might be 0).

ok.  Just give a little bit more of that detail.  I'd not understood
intent is to ensure one trigger -> one measurement.
> 
> > > + * @regmap: Regmap of the device
> > > + * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
> > > + * @regulator: Regulator of the device
> > > + * @powerstatus: Current POWER status of the device
> > > + * @interaction_ts: Timestamp of the last temperature read that is used
> > > + *               for power management in jiffies
> > > + */  
> ...
> > > +     mutex_lock(&data->lock);
> > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
> > > +             regcache_cache_only(data->regmap, false);
> > > +             ret = mlx90635_perform_measurement_burst(data);  
> >
> > Why is a burst needed here?  Perhaps a comment?
> >  
> 
> Burst is from 90632 terminology (and our chip register map), but maybe
> more general would be "trigger_measurement"?

ok. But why only if in SLEEP_STEP?

> 
> > > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > > +                                  unsigned int *refresh_rate)
> > > +{
> > > +     unsigned int reg;
> > > +     int ret;
> > > +
> > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > +             regcache_cache_only(data->regmap, false);  
> >
> > Definitely needs a comment on why this is needed in this case.
> >  
> 
> Here and below (where we turn it back to true?), but then I assume in
> all other instances as well? Maybe a more general comment in the
> sleep_step mode function?

If we keep this, then yes I think we need comments on these - even if
it's as simple as 'not accessing an eeprom register so we want to
talk to the device'.
> 
> > > +
> > > +     ret = regmap_read(data->regmap, MLX90635_REG_CTRL1, &reg);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +
> > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > +             regcache_cache_only(data->regmap, true);
> > > +
> > > +     *refresh_rate = FIELD_GET(MLX90635_CTRL1_REFRESH_RATE_MASK, reg);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct {
> > > +     int val;
> > > +     int val2;
> > > +} mlx90635_freqs[] = {
> > > +     {0, 200000},  
> > Prefer spaces after { and before }  
> 
> ok.
> 
> > > +     {0, 500000},
> > > +     {0, 900000},
> > > +     {1, 700000},
> > > +     {3, 0},
> > > +     {4, 800000},
> > > +     {6, 900000},
> > > +     {8, 900000}
> > > +};  
> ...
> > > +             if (i == ARRAY_SIZE(mlx90635_freqs))
> > > +                     return -EINVAL;
> > > +
> > > +             if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > +                     regcache_cache_only(data->regmap, false);  
> >
> > So here you want the rate to get through even though we otherwise have the
> > device powered down?  Is that because some registers are safe for writes
> > and not others?  If so you may need some locking to stop a race where you
> > turn on writes here and someone else writes.
> >  
> 
> Yes, exactly the case. Read/Write into registers (REG_) is possible in
> all modes, but read of EEPROM is not (to save power the EEPROM is
> turned off). I do not see how write race would get us into trouble
> here since it is only 1, and as long as chip powerstatus is not
> changed we should end up in correct state. I can wrap a mutex around
> though.

Assuming regcache_cache_only() isn't refcounted, you could end up with a
second copy of this racing through and accessing the data after the
first one turned the cache back on so the -EBUSY your mentioned.

> 
> 
> 
> > > +
> > > +             ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL1,
> > > +                                     MLX90635_CTRL1_REFRESH_RATE_MASK, i);
> > > +
> > > +             if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > +                     regcache_cache_only(data->regmap, true);
> > > +             return ret;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +}  
> >  


