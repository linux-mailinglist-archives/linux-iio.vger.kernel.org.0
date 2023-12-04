Return-Path: <linux-iio+bounces-592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB248038E5
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A686EB203B0
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F782C857;
	Mon,  4 Dec 2023 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="S7dVFzbl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB8C0
	for <linux-iio@vger.kernel.org>; Mon,  4 Dec 2023 07:35:07 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8b4670c78so1419850b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Dec 2023 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701704107; x=1702308907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WDUehL7n0JLsz+Gx1lP++nFrAN6gSvo/7fbfTtyTKX4=;
        b=S7dVFzblGdjfaR/oaonbPAS2wykpAXH3rFrumzI63knevYyuGotOER1f42OLCojdEY
         UrjPVERD0zjRVKkkuWhghxuShKitJ12waJMK8r+Qaw2EQKtKiDzYlHVLuoCNthm8G05t
         JSSnavEzmq8/2PreYIwQyNzNwf6OTBYOq348XC51XRLlKUDJx3YC9FmIXhvCquO1bN5j
         4403LreycFSg7C0yE7bVkU+BR+Cy3bV34KHW7x3na9cFCG0/8VmgN9rq+IjIzMX2+nCQ
         Ya/hbWXh20mlrzwaw2Cl/R/7yOL4E/nqXoPnZxCkBbFSi7Q+1ST1cnpjFAJHJocbK06J
         qRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704107; x=1702308907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDUehL7n0JLsz+Gx1lP++nFrAN6gSvo/7fbfTtyTKX4=;
        b=gBMtaUI8ndJ6DoMaGowAmgAyGrf6p/Ut1mIr9/8nf3kacu8I8Y4TxUPgbMdSakad14
         6JNHAcRuZBJ/c6LAz0/sfCRSBs60YNWsMpzOXN7OeanbXdmgXyAK1RGITzXBybIef+GU
         y3RzMZWwLHyBELdJPHTLpv7lZZ6WdIWJHQNI2v/pcLvt64WIBsttr2DIui6Y9uc7UO5H
         nVPSH+r4YLc/R4WJzc6d6GSVOUnmTrOsGony3OL9Fsw8WwdohI6d9Yo5Bb1DIg6IVRUO
         aI52OobVfU/cxO/km8WTG02TiQ+mp0j114jPkqXsW7PULlUuZazcPnerkcPTuFXxEVHk
         fDww==
X-Gm-Message-State: AOJu0YzSCVTm4eVOYN7cmXdUKa3dxgJqPKbldrA1Rxi+2RTFBcEXCRS3
	Al2a40a33nf6+bENwIkSs0R9F7DeKD0N4haEfc5Z8A==
X-Google-Smtp-Source: AGHT+IFQ+nMmWyMzUtIpwAW5pwoYUBw/ReXVhwDWJTDYw7z50qRvpX3wDxkL60hazOe+Yya3f6nE51tRC2kr/Jwdew4=
X-Received: by 2002:a05:6871:82a:b0:1fb:75a:c41d with SMTP id
 q42-20020a056871082a00b001fb075ac41dmr4326491oap.70.1701704106873; Mon, 04
 Dec 2023 07:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701168726.git.cmo@melexis.com> <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
 <20231204142224.51f2ccdf@jic23-huawei>
In-Reply-To: <20231204142224.51f2ccdf@jic23-huawei>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 4 Dec 2023 16:34:30 +0100
Message-ID: <CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:
>
...
> > switches to Continuous power mode where measurements constantly change
> > without triggering.
> >
> > Signed-off-by: Crt Mori<cmo@melexis.com>
>
> Hi Crt,
>
> I don't understand some of the regcache_cache_only() manipulation in here.
> If I understand the aim correctly it is to allow us to write settings whilst
> powered down (in sleep_step) that will then by synced to the device when it enters
> continuous mode?
>
> If so, I'd expect to only see manipulation of whether the caching is or or
> not at places where we transition state.  You currently have them in various
> other place. In some cases I scan see it's to allow a temporary change of
> state, but it's not obvious.  So perhaps a comment ever time you manually
> tweak whether writes hit the device or just stick in the regacache.
> That comment can explain why each of them is needed.
>
> A few other comments inline,
>
> Thanks,
>
> Jonathan
>

While in Sleep Step mode, the EEPROM is powered down, but the cache
buffers those values. Still when you try to write or read a volatile
register (which should not be prevented by cache enabled as per my
opinion, but code says differently) in that mode, it returns -EBUSY
(as we discovered by code), so this kind of manipulation is needed to
enable write and read operations from volatile registers. And you need
to trigger the measurement (burst mode) in that state, but since you
cannot read EEPROM, yet still need its values to calculate the final
temperature, the cache is used for this case. There is nothing to
re-cache when we get back as all registers I read/write to are marked
as volatile, so they would not be cached anyway.

Thanks for the review - I still have some questions below (and explanation,
but not sure where to put those).

> > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
...
> > + * @lock: Internal mutex for multiple reads for single measurement
>
> Multiple reads shouldn't be a problem, unless someone else can do something
> destructive in between.  Perhaps a little more detail on why multiple reads matter?
>

You trigger device to perform measurement in Sleep Step mode, so to
ensure both object and ambient temperature reads are from the same
triggered measurement, the mutex needs to be held. If for example in
between you would retrigger the measurement, then you would operate on
"invalid" data (shouldn't differ much, but I wanted to prevent that as
it might be 0).

> > + * @regmap: Regmap of the device
> > + * @emissivity: Object emissivity from 0 to 1000 where 1000 = 1.
> > + * @regulator: Regulator of the device
> > + * @powerstatus: Current POWER status of the device
> > + * @interaction_ts: Timestamp of the last temperature read that is used
> > + *               for power management in jiffies
> > + */
...
> > +     mutex_lock(&data->lock);
> > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP) {
> > +             regcache_cache_only(data->regmap, false);
> > +             ret = mlx90635_perform_measurement_burst(data);
>
> Why is a burst needed here?  Perhaps a comment?
>

Burst is from 90632 terminology (and our chip register map), but maybe
more general would be "trigger_measurement"?

> > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > +                                  unsigned int *refresh_rate)
> > +{
> > +     unsigned int reg;
> > +     int ret;
> > +
> > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > +             regcache_cache_only(data->regmap, false);
>
> Definitely needs a comment on why this is needed in this case.
>

Here and below (where we turn it back to true?), but then I assume in
all other instances as well? Maybe a more general comment in the
sleep_step mode function?

> > +
> > +     ret = regmap_read(data->regmap, MLX90635_REG_CTRL1, &reg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > +             regcache_cache_only(data->regmap, true);
> > +
> > +     *refresh_rate = FIELD_GET(MLX90635_CTRL1_REFRESH_RATE_MASK, reg);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct {
> > +     int val;
> > +     int val2;
> > +} mlx90635_freqs[] = {
> > +     {0, 200000},
> Prefer spaces after { and before }

ok.

> > +     {0, 500000},
> > +     {0, 900000},
> > +     {1, 700000},
> > +     {3, 0},
> > +     {4, 800000},
> > +     {6, 900000},
> > +     {8, 900000}
> > +};
...
> > +             if (i == ARRAY_SIZE(mlx90635_freqs))
> > +                     return -EINVAL;
> > +
> > +             if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > +                     regcache_cache_only(data->regmap, false);
>
> So here you want the rate to get through even though we otherwise have the
> device powered down?  Is that because some registers are safe for writes
> and not others?  If so you may need some locking to stop a race where you
> turn on writes here and someone else writes.
>

Yes, exactly the case. Read/Write into registers (REG_) is possible in
all modes, but read of EEPROM is not (to save power the EEPROM is
turned off). I do not see how write race would get us into trouble
here since it is only 1, and as long as chip powerstatus is not
changed we should end up in correct state. I can wrap a mutex around
though.



> > +
> > +             ret = regmap_write_bits(data->regmap, MLX90635_REG_CTRL1,
> > +                                     MLX90635_CTRL1_REFRESH_RATE_MASK, i);
> > +
> > +             if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > +                     regcache_cache_only(data->regmap, true);
> > +             return ret;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
>

