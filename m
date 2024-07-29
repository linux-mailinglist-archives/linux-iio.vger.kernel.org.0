Return-Path: <linux-iio+bounces-8021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C32C93F4C8
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C925B21904
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 12:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F9146A85;
	Mon, 29 Jul 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK7fm5zw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C23146580;
	Mon, 29 Jul 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254529; cv=none; b=k3f+3ADUej9AHjRqwEJT+2YTmxqRRFHXksO74068sBDuXReeTUp33g8h0Ai5UN8+JzGMx+kmUEYLxMVjtGbwZMxa0b5GswkUgm5cZazddLDV0WfdUk5/jciHsfIWNcLtkJ9OKgeWdys9fAtYK4iw3S+1BCl9bBhAA5FN/EvW29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254529; c=relaxed/simple;
	bh=9kb62gkH3Z44gtQcuKflBAKWMM7IYVLpV3e5GzQAYqU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZddSdhkBzQ4+VaAG7UBuOnK/Az+1fh6DQPXKaUGqOf6CRKxr7AajStC0yh2GvswXi9+OEyC1rqQZ3ES6aACz0m6Qe1KPNGcSY+mY9rR4uSyfbdoqdG7ACNbh9+VOVOUkPA4CMM0noSyhoaoBOeILWOB316n0p1c/d/AOo1nSoLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK7fm5zw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-428163f7635so14332935e9.2;
        Mon, 29 Jul 2024 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722254525; x=1722859325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tesCVEIIxKTa3SOhbxjtJvDeXUXRgrGHtGTNVfB+cl8=;
        b=ZK7fm5zw8Q+T77BBSac9ldlljRXczYq3/iFQwqs1N9i6MbAmjWnAPZSP/zwkBYsktG
         nqjFkpY6xKhVnRxZJDLtW5uecSy7pqYyELaxLW2kckh41yi2nT5+KDR/80O7JFUStNZ6
         Hp881Qk8aff4B3dL2qSI24MnOeztq02ybn2i4LdxL/0NL1iuIzvAQNhxfyFiIgEU2Uxv
         viScMwRMWhPu/ud3yf3j8vjpZn7FdApYVPFHF5xeUl0PDkDRyD6hQpAyU71eTqrL3gsa
         uZCAGqh3Mm3t4/srfcBvFY+4gekKrU9ubCILR03IZ/Tsg5xh+mQf0JzlLaNaxgsLjuvD
         zFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254525; x=1722859325;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tesCVEIIxKTa3SOhbxjtJvDeXUXRgrGHtGTNVfB+cl8=;
        b=A2sR9NSGTp7W7RhzkKW2Md0mCJdy3dTEBL304jHcZ2eeE6LoviwdNhAwaKM4ikH3YP
         3VzckVGs1RD1IxGXM8zsfioV75bmSsDjUCS7w1c4tjF+Nw7GZgRriyTUNtLVieveWoUZ
         QU97VUXIkTlIQKMGVAwvLwmCBHTAVUNOs8KdG98e6CFcYxbQxNmlcn6zTiWfTDEIpdcj
         7v/MyNlUs767WZ2GwdtI2wDC8T4GYLjePfj+FkPp1lU/tzAqFvR75jSnvaqBuTOG7sA1
         Kvyr60LpjNt0RDDGpmxFIE2zIPQEyX5wPHa/k/f82x0X4P9pZiMfOdG/34ciCShALINS
         GkzA==
X-Forwarded-Encrypted: i=1; AJvYcCXsdkFR1wNFW2GVjR8nScKgUpSfahh7/RAtaFqB+K0iq8zUS5Q9ltTg5DTvKs2AckNY61cm9Afw0SuYWsDb1mjEZMpHkE9WXPToLyb/4KYVZnsKP11c7ewiQ/bEoSZnBpi0hFeUPMT5ySBr3art4w17Rzo9rEYvuSCHZGSH0RR6nsUcSQ==
X-Gm-Message-State: AOJu0YxXQMYYPfscEwHg63qe0hnkyc1N3Htm1FiJUK0xIwgLmv8Gk+L/
	lOk6WCgRc5WFunnCbsrAvy4QaFPz18P5bSQGEq4TiGoX/+viENSK
X-Google-Smtp-Source: AGHT+IHHGO30D/Du18Ivi3uUdiusxJj59xWIffItjZ80sNJBfqcYcDn9Sdw9s9EQzUDTHWmguy4Osg==
X-Received: by 2002:a05:600c:3111:b0:428:151b:e8e with SMTP id 5b1f17b1804b1-428151b1210mr42450725e9.10.1722254524594;
        Mon, 29 Jul 2024 05:02:04 -0700 (PDT)
Received: from localhost (host-82-58-19-206.retail.telecomitalia.it. [82.58.19.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281ef5a416sm19660595e9.33.2024.07.29.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:02:04 -0700 (PDT)
Date: Mon, 29 Jul 2024 14:02:02 +0200
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66a784bac1db7_89a37017@njaxe.notmuch>
In-Reply-To: <20240728135306.422713ea@jic23-huawei>
References: <20240724-iio-pac1921-v4-0-723698e903a3@gmail.com>
 <20240724-iio-pac1921-v4-3-723698e903a3@gmail.com>
 <20240728135306.422713ea@jic23-huawei>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for pac1921
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jonathan Cameron wrote:
> On Wed, 24 Jul 2024 11:08:33 +0200
> Matteo Martelli <matteomartelli3@gmail.com> wrote:
> 
> > Add support for Microchip PAC1921 Power/Current monitor.
> > 
> > Implemented features:
> > * capture of bus voltage, sense voltage, current and power measurements
> >   in free-run integration mode
> > * support for both raw and triggered buffer reading
> > * support for overflow events
> > * scale attributes to control voltage and current gains
> > * oversampling ratio attribute to control the number of integration
> >   samples
> > * sampling rate attribute that reflects the integration period
> > * userspace attribute and DT parameter to control shunt resistor
> > * simple power management support
> > 
> > Limitations:
> > * operation mode fixed to free-run integration
> > * READ/INT pin and OUT pin not supported
> > * no controls for measurement resolutions and filters
> > 
> > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> I had a few more bits of feedback + one change was necessary because of
> this crossing with Nuno's series making iio_dev->masklength private.
> Rather than go around again for such trivial things, 
> I've applied it to the testing branch of iio.git with the following diff.
> Note I'll rebase that tree on rc1 once available at which point it'll become
> the togreg branch and get picked up by linux-next etc.
> 
> There are a few things inline that I commented on but didn't touch, so
> please also take a look at those and shout if I messed anything up!
> I've been known to make trivial changes that break a driver completely :(
> 
> Thanks,
> 
> Jonathan
> 

Thanks Jonathan,

I reviewed your diff and also tested this version on the HW. All looks good to
me. Please check also my comments below.

> 
> diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> index a21dd772467e..d04c6685d780 100644
> --- a/drivers/iio/adc/pac1921.c
> +++ b/drivers/iio/adc/pac1921.c
> @@ -75,12 +75,12 @@ enum pac1921_mxsl {
>   * Vbus scale (mV) = max_vbus (mV) / dv_gain / resolution
>   */
>  static const int pac1921_vbus_scales[][2] = {
> -       {31, 280547409},        /* dv_gain x1 */
> -       {15, 640273704},        /* dv_gain x2 */
> -       {7, 820136852},         /* dv_gain x4 */
> -       {3, 910068426},         /* dv_gain x8 */
> -       {1, 955034213},         /* dv_gain x16 */
> -       {0, 977517106}          /* dv_gain x32 */
> +       { 31, 280547409 },      /* dv_gain x1 */
> +       { 15, 640273704 },      /* dv_gain x2 */
> +       { 7, 820136852 },       /* dv_gain x4 */
> +       { 3, 910068426 },       /* dv_gain x8 */
> +       { 1, 955034213 },       /* dv_gain x16 */
> +       { 0, 977517106 },       /* dv_gain x32 */
>  };
>  
>  /*
> @@ -91,14 +91,14 @@ static const int pac1921_vbus_scales[][2] = {
>   * Vsense scale (mV) = max_vsense (mV) / di_gain / resolution
>   */
>  static const int pac1921_vsense_scales[][2] = {
> -       {0, 97751710},          /* di_gain x1 */
> -       {0, 48875855},          /* di_gain x2 */
> -       {0, 24437927},          /* di_gain x4 */
> -       {0, 12218963},          /* di_gain x8 */
> -       {0, 6109481},           /* di_gain x16 */
> -       {0, 3054740},           /* di_gain x32 */
> -       {0, 1527370},           /* di_gain x64 */
> -       {0, 763685}             /* di_gain x128 */
> +       { 0, 97751710 },        /* di_gain x1 */
> +       { 0, 48875855 },        /* di_gain x2 */
> +       { 0, 24437927 },        /* di_gain x4 */
> +       { 0, 12218963 },        /* di_gain x8 */
> +       { 0, 6109481 },         /* di_gain x16 */
> +       { 0, 3054740 },         /* di_gain x32 */
> +       { 0, 1527370 },         /* di_gain x64 */
> +       { 0, 763685 },          /* di_gain x128 */
>  };
>  
>  /*
> @@ -334,7 +334,7 @@ static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
>         if (ret)
>                 return ret;
>  
> -       *val = (u16)FIELD_GET(PAC1921_RES_MASK, get_unaligned_be16(val));
> +       *val = FIELD_GET(PAC1921_RES_MASK, get_unaligned_be16(val));
>  
>         return 0;
>  }
> @@ -612,7 +612,7 @@ static int pac1921_update_int_num_samples(struct pac1921_priv *priv,
>         if (priv->n_samples == n_samples)
>                 return 0;
>  
> -       reg_val = (u8)FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, n_samples);
> +       reg_val = FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, n_samples);
>  
>         ret = pac1921_update_cfg_reg(priv, PAC1921_REG_INT_CFG,
>                                      PAC1921_INT_CFG_SMPL_MASK, reg_val);
> @@ -1017,7 +1017,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
>         if (ret)
>                 goto done;
>  
> -       for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
> +       iio_for_each_active_channel(idev, bit) {
>                 u16 val;
>  
>                 ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> @@ -1054,8 +1054,8 @@ static int pac1921_init(struct pac1921_priv *priv)
>                 return ret;
>  
>         /* Configure gains, use 14-bits measurement resolution (HW default) */
> -       val = (u8)FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
> -             (u8)FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);
> +       val = FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
> +             FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);
>         ret = regmap_write(priv->regmap, PAC1921_REG_GAIN_CFG, val);
>         if (ret)
>                 return ret;
> @@ -1067,7 +1067,7 @@ static int pac1921_init(struct pac1921_priv *priv)
>          * - set READ/INT pin override (RIOV) to control operation mode via
>          *   register instead of pin
>          */
> -       val = (u8)FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, priv->n_samples) |
> +       val = FIELD_PREP(PAC1921_INT_CFG_SMPL_MASK, priv->n_samples) |
>               PAC1921_INT_CFG_VSFEN | PAC1921_INT_CFG_VBFEN |
>               PAC1921_INT_CFG_RIOV;
>         ret = regmap_write(priv->regmap, PAC1921_REG_INT_CFG, val);
> @@ -1080,8 +1080,8 @@ static int pac1921_init(struct pac1921_priv *priv)
>          * - OUT pin full scale range: 3V (HW detault)
>          * - no timeout, no sleep, no sleep override, no recalc (HW defaults)
>          */
> -       val = (u8)FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
> -                            PAC1921_MXSL_VPOWER_FREE_RUN);
> +       val = FIELD_PREP(PAC1921_CONTROL_MXSL_MASK,
> +                        PAC1921_MXSL_VPOWER_FREE_RUN);
>         ret = regmap_write(priv->regmap, PAC1921_REG_CONTROL, val);
>         if (ret)
>                 return ret;
> @@ -1153,7 +1153,6 @@ static void pac1921_regulator_disable(void *data)
>  
>  static int pac1921_probe(struct i2c_client *client)
>  {
> -       const struct i2c_device_id *id = i2c_client_get_device_id(client);
>         struct device *dev = &client->dev;
>         struct pac1921_priv *priv;
>         struct iio_dev *indio_dev;
> @@ -1202,8 +1201,7 @@ static int pac1921_probe(struct i2c_client *client)
>         ret = devm_add_action_or_reset(dev, pac1921_regulator_disable,
>                                        priv->vdd);
>         if (ret)
> -               return dev_err_probe(
> -                       dev, ret,
> +               return dev_err_probe(dev, ret,
>                         "Cannot add action for vdd regulator disposal\n");
>  
>         msleep(PAC1921_POWERUP_TIME_MS);
> @@ -1214,7 +1212,7 @@ static int pac1921_probe(struct i2c_client *client)
>  
>         priv->iio_info = pac1921_iio;
>  
> -       indio_dev->name = id->name;
> +       indio_dev->name = "pac1921";
>         indio_dev->info = &priv->iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = pac1921_channels;
> 
> 
> > +
> > +/*
> > + * Emit on sysfs the list of available scales contained in scales_tbl
> > + *
> > + * TODO:: this function can be replaced with iio_format_avail_list() if the
> > + * latter will ever be exported.
> 
> You could just have added a precursor patch doing that.
> If you have time I'd certainly consider a patch that does export that function
> and uses it here.
>
I wasn't sure that one usage was enough to justify the export. I could
definitely do it, I am assuming it would now go to a new patch series since
this has already been merged into testing, right?

> > + *
> > + * Must be called with lock held if the scales_tbl can change runtime (e.g. for
> > + * the current scales table)
> > + */
> > +static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
> > +					  size_t size, char *buf)
> > +{
> > +	ssize_t len = 0;
> > +
> > +	for (unsigned int i = 0; i < size; i++) {
> > +		if (i != 0) {
> > +			len += sysfs_emit_at(buf, len, " ");
> > +			if (len >= PAGE_SIZE)
> > +				return -EFBIG;
> > +		}
> > +		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
> > +				     scales_tbl[i][1]);
> > +		if (len >= PAGE_SIZE)
> > +			return -EFBIG;
> > +	}
> > +
> > +	len += sysfs_emit_at(buf, len, "\n");
> > +	return len;
> > +}
> > +
> > +/*
> > + * Read available scales for a specific channel
> > + *
> > + * NOTE: using extended info insted of iio.read_avail() because access to
> > + * current scales must be locked as they depend on shunt resistor which may
> > + * change runtime. Caller of iio.read_avail() would access the table unlocked
> > + * instead.
> 
> That's a corner case we should think about closing. Would require an indicator
> to read_avail that the buffer it has been passed is a snapshot that it should
> free on completion of the string building.  I don't like passing ownership
> of data around like that, but it is fiddly to do anything else given
> any simple double buffering is subject to race conditions.
>
If I understand your suggestion the driver would allocate a new table and copy
the values into it at each read_avail() call. Then
iio_read_channel_info_avail() would free the buffer if some sort of
free-after-use indicator flag is set. I guess such indicator might be set via an
additional read_avail function argument (would be an extensive API change) or
maybe via a new iio_chan_spec attribute.

> An alternative would use a key of sometype to associate individual read_avail
> calls with new ones to read_avail_release_resource. That might be cleaner.
> 
Are you referring to introduce a new read_avail_realease_resource callback that
would be called at the end of iio_read_channel_info_avail() if set? Similarly
to the previous point the driver would allocate a new table and copy the values
into it at each read_avail() call, but the driver would also define a release
callback to free such table. If otherwise you are referring to something less
trivial, is there a similar API in the kernel that can be referred to for
clarity?

> oh well, a cleanup job for another day.   I suspect we have drivers today
> that are subject to tearing of their available lists.
> 
I've just taken a quick look at the other drivers and the following twos seem
to have the race condition issue since they are updating an available table
during a write_raw() call and also exposing it during a read_avail() call:
* drivers/iio/light/as73211.c: see int_time_avail table
* drivers/iio/adc/ad7192.c: see filter_freq_avail table

There might be others, I've only looked into those that seemed likely to have
this issue after some trivial greps.

Is there already a common way for iio to keep track of open issues (e.g. Issue
tracker/TODO lists/etc)?

> > + */
> > +static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
> > +					uintptr_t private,
> > +					const struct iio_chan_spec *chan,
> > +					char *buf)
> > +{
> > +	struct pac1921_priv *priv = iio_priv(indio_dev);
> > +	const int (*scales_tbl)[2];
> > +	size_t size;
> > +
> > +	switch (chan->channel) {
> > +	case PAC1921_CHAN_VBUS:
> > +		scales_tbl = pac1921_vbus_scales;
> > +		size = ARRAY_SIZE(pac1921_vbus_scales);
> > +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> > +
> > +	case PAC1921_CHAN_VSENSE:
> > +		scales_tbl = pac1921_vsense_scales;
> > +		size = ARRAY_SIZE(pac1921_vsense_scales);
> > +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> > +
> > +	case PAC1921_CHAN_CURRENT: {
> > +		guard(mutex)(&priv->lock);
> > +		scales_tbl = priv->current_scales;
> > +		size = ARRAY_SIZE(priv->current_scales);
> > +		return pac1921_format_scale_avail(scales_tbl, size, buf);
> > +	}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +#define PAC1921_EXT_INFO_SCALE_AVAIL {					\
> > +	.name = "scale_available",					\
> > +	.read = pac1921_read_scale_avail,				\
> > +	.shared = IIO_SEPARATE,						\
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
> > +	PAC1921_EXT_INFO_SCALE_AVAIL,
> > +	{}
> > +};
> 
> 
> > +
> > +static irqreturn_t pac1921_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *idev = pf->indio_dev;
> > +	struct pac1921_priv *priv = iio_priv(idev);
> > +	int ret;
> > +	int bit;
> > +	int ch = 0;
> > +
> > +	guard(mutex)(&priv->lock);
> > +
> > +	if (!pac1921_data_ready(priv))
> 
> Interesting corner case that maybe could have done with a comment.
> Seems could be triggered by a spurious interrupt, or sampling too early.
> 
> I think only the second one is likely to happen, so shouldn't be a
> problem to acknowledge that trigger.
> 
Yes, my intent here was to prevent userspace from receiving invalid data if
sampled too early: for example the user could arm a timer that would trigger an
interrupt before the first integration is complete. This could happen not just
after the first driver initialization phase but also after a configuration
change (gains or number of integration samples reflecting a user change of
scale or oversampling_ratio respectively).

> > +		goto done;
> > +
> > +	ret = pac1921_check_push_overflow(idev, pf->timestamp);
> > +	if (ret)
> > +		goto done;
> > +
> > +	for_each_set_bit(bit, idev->active_scan_mask, idev->masklength) {
> 
> This needs an update as we crossed with Nuno's series that removes access
> to masklength. I can fix whilst applying by using
> iio_for_each_active_channel()
> 
> 
> > +		u16 val;
> > +
> > +		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > +		if (ret)
> > +			goto done;
> > +
> > +		priv->scan.chan[ch++] = val;
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(idev, &priv->scan, pf->timestamp);
> > +
> > +done:
> > +	iio_trigger_notify_done(idev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Initialize device by writing initial configuration and putting it into
> > + * integration state.
> > + *
> > + * Must be called with lock held when called after first initialization
> > + * (e.g. from pm resume)
> > + */
> > +static int pac1921_init(struct pac1921_priv *priv)
> > +{
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	/* Enter READ state before configuration */
> > +	ret = regmap_update_bits(priv->regmap, PAC1921_REG_INT_CFG,
> > +				 PAC1921_INT_CFG_INTEN, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Configure gains, use 14-bits measurement resolution (HW default) */
> > +	val = (u8)FIELD_PREP(PAC1921_GAIN_DI_GAIN_MASK, priv->di_gain) |
> > +	      (u8)FIELD_PREP(PAC1921_GAIN_DV_GAIN_MASK, priv->dv_gain);
> 
> Why are these cases needed?
> Each of those values is going to fit in a u8 just fine and it's getting
> written to a much larger variable.
> 
FIELD_PREP result type would be a long unsigned int due to the GENMASK type and
-Wconversion would trigger a warning. The explicit casts is just to address
-Wconversion warnings and to "state" that such casts are safe.  In this way
with -Wconversion (KBUILD_EXTRA_WARN=3) one could easily spot those other
implicit casts that would end up with unwanted data corruption. I thought it to
be a common practice and I also saw it in some other kernel patches, for
example https://lore.kernel.org/all/1540883612.2354.2.camel@smigroup.net/ , but
maybe it's not that common as I thought.
I also see that maybe in this case casting to unsigned int would have likely
been more clear.

Thanks,
Matteo Martelli

