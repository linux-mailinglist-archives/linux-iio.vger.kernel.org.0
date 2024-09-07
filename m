Return-Path: <linux-iio+bounces-9311-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C11970388
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1454B2275C
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 18:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CD165F00;
	Sat,  7 Sep 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mfA2s23R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E211494B2
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 18:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725732626; cv=none; b=V4XyW2pwMyGmKEqbL6zLLMJ0Ezi+pj6x7KvigxJaab9yP2/8C8TF5DxZdUtK1g0nLMmMbbgLynEF9F+TwrVS5mRwLVx5EczX/B1UG3X/GFseZZoVjkgrXDjfKHQlISlpq0tPNrXAfe9WcC8/lkIm36Yjh6gZdGc3p/Bq2HvIcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725732626; c=relaxed/simple;
	bh=DF7M/JMqN3rhN1QP1dvYJQuX4WPqN8Hy79cHkWJFgR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0ks4I/IT4AUrA+/VC2YEE1gvZR5fcNGyNQYOYIz7ePRsN+caGgsfwxZMzMOt9LazLEE4Hx67GRVk7ngkSTXp/IEEsutHbig5nCmOig3Af5N65DfSPVEQCZpMa8GJ5AiEN47UFodzEvewx+biDd2K5pnIrkeFH7v/kqiWZR2yZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mfA2s23R; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-502b405aa6dso514995e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Sep 2024 11:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725732622; x=1726337422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64trEv5Ti+s4aL8hbBtOVKS0J0Gs2vDARM9xGEh0Vcg=;
        b=mfA2s23RBT5qt8MkDraIMIDducEolroQHZ/AqsShKqGwmbl/c9MhVuNKw4ZJbrSGDB
         psChrnTH25hZvriv6qUHtJu0kzJ/svGuKElMPXDuT2vGAj7YuK4XHyfqtOQFnz2VR5+j
         59Y0RX952z3VbpDGiDDE5s1IoocZiCe7Lwc5HUvuvS3yiv7UaawFwxGLcjwmfb+DaFUO
         vK7rrt9zCvcIQJvaTKRBF2i9JHwNa2vkmp4NMEWgDclrUW/lanfrhLwABz0mYW4nBAwe
         k3UR9hQ15SyE69Xbf5sRrCrAM4AHH6x2qi2md7Ybub+17tE/fZEwZ0VhMQFfmQgG3vP3
         S87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725732622; x=1726337422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64trEv5Ti+s4aL8hbBtOVKS0J0Gs2vDARM9xGEh0Vcg=;
        b=aWR4+RqM/lD3xHeXURl/hu3rdfkm2GrCRW5r2JHRMpfk+THxsY0uvXVsn/nlmVatHj
         XFqDNKI+Ta/WBaUjXa4soAmwuF+W7zOIYz9s+ACkZUyypcuzdjCF79DFG3IsaRcOU90w
         zi4AoRlplyndlO/WCMj/s7BynvOR3e4q0t2AXN+o169kliZepiVyPwtb3D5msrKCyxwc
         yv3xaR7bYE38rJewy0Wd3zdjnuuW/KqOa+HR5Qf9zFYo6nCj9kdp7jmEAxOmx8skCz+8
         ie2SNldSOyA/Y+Bd2IR2QLv8DVi2eiuY8vaZ9GduwBcBP+8yvsRVOKAseI3TF4gtlkSJ
         eAHA==
X-Gm-Message-State: AOJu0YwR4o1Jv9IPfT7K90gEl8AXbrpbegtrfuz5cWHrfEFcb94hvLYy
	75OD7DEIiKd1aaLekOwzGFMU/mQDhhVmTBXOBzOKGwfv3VxoriRUFTe1FhCfK/3Dff9DHMUq1k9
	fFaqXiV//DuBqQCetAcgGL5S8XItlM3qTuRpXyQ==
X-Google-Smtp-Source: AGHT+IFY/zJt5fHTmcetHeQotk1btjcPMr9+nAr73v3Ma456djVUd9TlTWfzO44m2X5Trmssaw9XcfcbOLUsI+EPgH4=
X-Received: by 2002:a05:6122:7c6:b0:501:22e5:2bb9 with SMTP id
 71dfb90a1353d-5021327c609mr8799556e0c.5.1725732622416; Sat, 07 Sep 2024
 11:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907065043.771364-1-aardelean@baylibre.com>
 <20240907065043.771364-7-aardelean@baylibre.com> <20240907160356.3de047b0@jic23-huawei>
In-Reply-To: <20240907160356.3de047b0@jic23-huawei>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Sat, 7 Sep 2024 21:10:10 +0300
Message-ID: <CA+GgBR99R=PEyTR_KZO6M_YiRepa5ZFhXcRRq=AtD65rn5MCZg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iio: adc: ad7606: rework available attributes for
 SW channels
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sat,  7 Sep 2024 09:50:39 +0300
> Alexandru Ardelean <aardelean@baylibre.com> wrote:
>
> > For SW mode, the oversampling and scales attributes are always present.
> > So, they can be implemented via a 'read_avail' hook in iio_info.
> >
> > For HW mode, it's a bit tricky, as these attributes get assigned based =
on
> > GPIO definitions.
> >
> > So, for SW mode, we define a separate AD7606_SW_CHANNEL() macro, and us=
e
> > that for the SW channels.
> > And 'ad7606_info_os_range_and_debug' can be renamed to
> > 'ad7606_info_sw_mode' as it is only used for SW mode.
> >
> > For the 'read_avail' hook, we'll need to allocate the SW scales, so tha=
t
> > they are just returned userspace without any extra processing.
> > The allocation will happen when then ad7606_state struct is allocated.
> > The oversampling available parameters don't need any extra processing; =
they
> > can just be passed back to userspace (as they are).
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
>
> One question inline.
>
> >
> >  int ad7606_probe(struct device *dev, int irq, void __iomem *base_addre=
ss,
> > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > index 635407c2acc0..fa175cff256c 100644
> > --- a/drivers/iio/adc/ad7606.h
> > +++ b/drivers/iio/adc/ad7606.h
>
> >  #define AD7616_CHANNEL(num)  AD7606_SW_CHANNEL(num, 16)
> >
> >  /**
> > @@ -65,11 +84,15 @@ struct ad7606_chip_info {
> >  /**
> >   * struct ad7606_chan_scale - channel scale configuration
> >   * @scale_avail              pointer to the array which stores the ava=
ilable scales
> > + * @scale_avail_show a duplicate of 'scale_avail' which is readily for=
matted
> > + *                   such that it can be read via the 'read_avail' hoo=
k
> >   * @num_scales               number of elements stored in the scale_av=
ail array
> >   * @range            voltage range selection, selects which scale to a=
pply
> >   */
> >  struct ad7606_chan_scale {
> > +#define AD760X_MAX_SCALE_SHOW                (AD760X_MAX_CHANNELS * 2)
>
> Why is the number of scales dependent on the number of channels?

Well, that was just a lazy implementation.
I doubt there would be 16 scales (channel range values) for any newer part.
A value for a channel-range is 4-bits (for 0 to 15).

In IIO the current highest scale-count is 5; I guess I can update this
to a macro, and use that.


>
> >       const unsigned int              *scale_avail;
> > +     int                             scale_avail_show[AD760X_MAX_SCALE=
_SHOW];
> >       unsigned int                    num_scales;
> >       unsigned int                    range;
> >  };
>

