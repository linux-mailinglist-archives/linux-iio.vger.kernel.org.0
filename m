Return-Path: <linux-iio+bounces-26397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB99C7E6DD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 20:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E05D341841
	for <lists+linux-iio@lfdr.de>; Sun, 23 Nov 2025 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E0A2586E8;
	Sun, 23 Nov 2025 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KESPAWi7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4025EFAE
	for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763927335; cv=none; b=Kk/reN6uVZf4cVdD6rVtJ0FiYAuU5J4uNy+3ChUK8eRd2Ir8CPvGVdA0yz/GEPOZx/9lsFKHL+M2upVeV324oyC92Y6nMym4E2l1vqoEQ5m5cSTbW+q7LUmPP0FXJPKXsEaF20ClQG48Lo9tSr8nksEFE2LKPkIfcMUdjguycek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763927335; c=relaxed/simple;
	bh=+fNKvMvpCmvV9cI0Va6TcyljsLu3F06cewuvY7FNh7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux1b8iIgzazEHEQXMT1Iz3lmFYmeZ6W563eDft+6LbRurc4okgfNtfCd7rD8G9X7Nja2RSPLPdkpxo2ooGdeAlubaUGYqmQSIkc19iAl3WMf89GrzuUMeRRhTjBOIEiHxOkf2YStkiI4bRWVbL5wwNMI1r5opsoqreQchnv0ybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KESPAWi7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b735b7326e5so799268666b.0
        for <linux-iio@vger.kernel.org>; Sun, 23 Nov 2025 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763927330; x=1764532130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NY48Fn40WcoOX8kcxK9n3pmoY2MNt9A/pKD1eZjB+vI=;
        b=KESPAWi7V8eTC9/U7ZZBTAs9mw0zsiGiH5FZw63OJG6U9Mob5i6Mx/qPMXhP3dnLZC
         ZO0LamDWvVZBFZKuxBW4Bw0pwXhcn4yxW20Ud24Wxw6MN2WuKyAGlWQ5wNCPtQbYvQLI
         78TtyaUAifoGwRgKmengJVVdv5daAqJzZVDS61YE4U2iJMs/3fy5Zllmg+Ey84gQRE4H
         rJTZ8VgnjIO6PRgvmXjAVhDCNOoQ2qm1ndphtJdzarXoN4khb0zK3Mu4ISCsOSFEdyIA
         gHtSSthcOX5rAXr49s9VD/lwRM3Ue0kzwoN2Yg+gdllPrOB53KUqXxslelup24V+TiWs
         woVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763927330; x=1764532130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY48Fn40WcoOX8kcxK9n3pmoY2MNt9A/pKD1eZjB+vI=;
        b=GgoKb4z/ilYK5BOi+A/qkDpwK+hBG0ttGIR2CphL7n03IdUoHZ0/wEtgQUtEvecdwD
         /8IJ0NAfHvcKoOuYGx0baTj4nxosvBntN2t6Gw83LN8/33FT6NU90B7wyA1RF2cH5qIV
         146wgBrU+ELKAzClx+HxKYcpcdEXFwzy5on3L3kKLJazECZoC14Fe+ahVMcjXGdIhk+X
         NFm8x8/3lj4Sk4xd2OJVGaRFM1TCuiQ9c5rDgjoUSa+TTaDwNgwlDAYkvZ9W6CTfiHjn
         bZiOnHv1ZlMBfysgIOU5KCHvrY1FBaYENQyBv9gH7pi9ZBh+aQIb+36ydi5qV2Juc7AX
         Ca1g==
X-Forwarded-Encrypted: i=1; AJvYcCUa5sYAM5HwePtwzBT4qfBzNkTz4xLtbJvAVdEYBInxh/5u/p3Sf4iA2/igDpnCYopmcRp1OwIrp2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbCZgw/xsI1Ay9py1EjD0RlprWL6VCOk49/d1PHz9gNZU+4ZS
	DajgD0LirusP0QnNK6FmXvahLXXT94Qcz1mApFZbxOSKRGGsA9BMevTo
X-Gm-Gg: ASbGncul5Ip1TQwmmRsdh//KDWj+i9D+CZC30xepeEH3up0B+mQ5Aa1eBD7B419+9/r
	6tFZV2DQXoLt+wbZuKhZ1zIMHPcj7yIsn9tV8WpN9nZfmuL4P9j+HYESD4+ZQV7TNRDD4D/5ccK
	yk3B25s7f89JdgqxPb4m8LP6zbl8CmvD2V6o2n/nzZNkvuQmzYlqZNcwsuXZrnqug33CXhdhsJb
	l8GN0foBO4ZaOhdzpsgdLRvTiE0uAe8OT3aT/RPUsnx9sdsYZKMZ02zD/Jdepy9TYV7NR2VyOhC
	xEOZvmicUzz4Rptwamomgdftqv/PwyXXq2e8bn+upXtLG6owEAm6zRdcYX0QBKYBAv2UDkuuPIr
	qdV9eBC76yjhMMPs2ivCfVeYZcb3SrLiop6BU02j9WEogET4Mizj0HfZKuhaHx/s9GrBr7ILrlQ
	M2J8GhTRhokdVeWUMrlykjw1tSX3rURzVN1VYKEHnJ2mQf/uZudKXCsGfo493vq5WCNvE=
X-Google-Smtp-Source: AGHT+IEbd/yP3QJ65f1rfYvuIyzrG6WSCnDa64fB/u4r54gEgSqi1csW3UDCsVIvIHmm0BrHp5Rk6A==
X-Received: by 2002:a17:906:d54a:b0:b72:6a39:49e6 with SMTP id a640c23a62f3a-b766ef1d09fmr1145143766b.18.1763927329276;
        Sun, 23 Nov 2025 11:48:49 -0800 (PST)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:123e:4501:38ae:e5e8:159a:3b69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7cb3bsm1096357666b.27.2025.11.23.11.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 11:48:49 -0800 (PST)
Date: Sun, 23 Nov 2025 20:48:47 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: adc: ad4062: Add IIO Events support
Message-ID: <xxwczo3pno3dkyn3jmtj7hwupeo3ywp27bwbtohexfgpdoo56j@apapxa2pymyw>
References: <20251013-staging-ad4062-v1-0-0f8ce7fef50c@analog.com>
 <20251013-staging-ad4062-v1-7-0f8ce7fef50c@analog.com>
 <20251018172625.42f13f4a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018172625.42f13f4a@jic23-huawei>

On Sat, Oct 18, 2025 at 05:26:25PM +0100, Jonathan Cameron wrote:
> On Mon, 13 Oct 2025 09:28:05 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Adds support for IIO Events. Optionally, gp0 is assigned as Threshold
> > Either signal, if not present, fallback to an I3C IBI with the same
> > role.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jonathan,
> The one bit of this that I'm not sure on is the apparent dropping out
> of monitor mode on most userspace interactions that cause register accesses.
> That seems like a fairly unintuitive ABI. It might be better to block the access
> until the events are turned off. Perhaps I missed something?
> 
I will change the behaviour to block access until monitor mode is disabled:

          if (!iio_device_claim_direct(indio_dev))
                  return -EBUSY;
          if (st->wait_event) {
                  ret = -EBUSY;
                  goto out_release;
          }
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/iio/adc/ad4062.c | 351 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 347 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> > index 40b7c10b8ce7145b010bb11e8e4698baacb6b3d3..b5b12f81c71b52f244600ed23dad11253290b868 100644
> > --- a/drivers/iio/adc/ad4062.c
> > +++ b/drivers/iio/adc/ad4062.c
> > @@ -13,6 +13,7 @@
> 
> > +/**
> > + * A register access will cause the device to drop from monitor mode
> > + * into configuration mode, update the state to reflect that.
> > + */
> > +static void ad4062_exit_monitor_mode(struct ad4062_state *st)
> > +{
> > +	if (st->wait_event) {
> > +		pm_runtime_mark_last_busy(&st->i3cdev->dev);
> 
> > +		pm_runtime_put_autosuspend(&st->i3cdev->dev);
> As elsewhere, no longer need to have the mark_last_busy() call here.
> 
Ack.
> > +		st->wait_event = 0;
> > +	}
> > +}
> 
> > +static ssize_t sampling_frequency_available_show(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 char *buf)
> > +{
> > +	struct ad4062_state *st = iio_priv(dev_to_iio_dev(dev));
> > +	int ret = 0;
> > +
> > +	for (u8 i = AD4062_FS_OFFSET(st->chip->grade);
> > +	     i < AD4062_FS_LEN(st->chip->grade); i++)
> > +		ret += sysfs_emit_at(buf, ret, "%s ", ad4062_conversion_freqs[i]);
> > +
> > +	ret += sysfs_emit_at(buf, ret, "\n");
> > +	return ret;
> 
> Has slightly ugly format of " \n" at end rather than "\n"
> There are various ways to handle this perhaps easiest is something like
> 	for (u8 i = AD4062_FS_OFFSET(st->chip->grade);
> 	     i < AD4062_FS_LEN(st->chip->grade); i++)
> 		ret += sysfs_emit_at(buf, ret, "%s%c", ad4062_conversion_freqs[i],
> 				      i != (AD4062_FS_LEN(st->chip_grade) - 1) ? "\n", " ");
Thanks for the suggestion, I will use.
> 
> 
> > +}
> 
> >  static irqreturn_t ad4062_poll_handler(int irq, void *p)
> > @@ -523,6 +645,24 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
> >  	struct device *dev = &st->i3cdev->dev;
> >  	int ret;
> >  
> > +	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp0");
> > +	if (ret >= 0) {
> > +		ret = devm_request_threaded_irq(dev, ret, NULL,
> > +						ad4062_irq_handler_thresh,
> > +						IRQF_ONESHOT, indio_dev->name,
> > +						indio_dev);
> > +		if (ret)
> > +			return ret;
> > +	} else if (ret != -EPROBE_DEFER) {
> > +		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> > +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN,
> > +					 AD4062_REG_ADC_IBI_EN_MAX | AD4062_REG_ADC_IBI_EN_MIN);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		return ret;
> 
> As before. I'd prefer error cases handled first. The earlier code suggestion
> doesn't quite work but something along those lines should be doable.
> 
Ack.
> > +	}
> > +
> >  	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
> >  	if (ret >= 0) {
> >  		ret = devm_request_threaded_irq(dev, ret, NULL,
> 
> > @@ -779,6 +923,196 @@ static int ad4062_write_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > +static int ad4062_monitor_mode_enable(struct ad4062_state *st, bool enable)
> > +{
> > +	int ret = 0;
> > +
> > +	if (!enable)
> > +		goto out_suspend;
> > +
> > +	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = ad4062_conversion_frequency_set(st, st->events_frequency);
> > +	if (ret)
> > +		goto out_suspend;
> > +
> > +	ret = ad4062_set_operation_mode(st, AD4062_MONITOR_MODE);
> > +	if (ret)
> > +		goto out_suspend;
> > +
> > +	return ret;
> return 0;
>  
Ack.
> > +out_suspend:
> > +	pm_runtime_put_autosuspend(&st->i3cdev->dev);
> > +	return ret;
> > +}
> 
> >  static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >  {
> >  	struct ad4062_state *st = iio_priv(indio_dev);
> > @@ -788,6 +1122,7 @@ static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> >  	ret = pm_runtime_resume_and_get(&st->i3cdev->dev);
> >  	if (ret)
> >  		return ret;
> > +	ad4062_exit_monitor_mode(st);
> Hmm. So you always exist monitor mode if we enable the buffer. I assume that doesn't
> change detection of events because the buffered mode also allows that?
> 
> Do we not need something to turn monitor mode on again once we disable buffered capture?
No, the buffer mode does not work alongside monitor mode, I will add the
lock 

          if (st->wait_event)
                  return -EBUSY;

> >  
> >  	ret = ad4062_set_operation_mode(st, st->mode);
> >  	if (ret)
> > @@ -833,6 +1168,7 @@ static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg
> >  
> >  	if (!iio_device_claim_direct(indio_dev))
> >  		return -EBUSY;
> > +	ad4062_exit_monitor_mode(st);
> 
> This probably needs a comment. Not obvious to me how you end up in with it enabled
> again after the debugfs read / write finishes.
> 
You don't. Once a register access is done, it will drop of monitor mode
or sample/buffer mode. But since it is a debug interface, that may be
alright?
> >  
> >  	if (readval)
> >  		ret = regmap_read(st->regmap, reg, readval);

Best regards,
Jorge

