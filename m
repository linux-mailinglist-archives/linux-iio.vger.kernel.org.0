Return-Path: <linux-iio+bounces-14124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF6A0A231
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 10:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D6F3A6BEB
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1407188596;
	Sat, 11 Jan 2025 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QBZ8NuzR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBF15666D
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736587065; cv=none; b=BAhttponnB0n5fNKJiAAFbv0qtKV4kmtJACIFbOiESdTpzNIPAGMPjwzCUyk2APkW20rYDP85q4mSGA4qkcME52B2c8mU8tzDu6ttaq2HMfYIR/rfn+0rMHwTI1RUTpffYLBWcPzD8dJnQtHXuXoy/BYkz3p9to6F9WEIwk8l3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736587065; c=relaxed/simple;
	bh=kSz2ozfM+GDCUl2noTxMIW/0mQvo0ucpjYOvKWX2YDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpR9NaKfcT1crud5smDHvgUMNetLTrBmDTv6Tq8nFmKjpfdE/ZBf/PJMpMHJzo63CN/85Ki4JDg6/chCsffNRbJevosknAmUe+dr787IIGrCUcOXg50O3s3f7zH/kxUpQFieLfruFXAClcDOrO8ol31LAaj9rP37aMglQFfnwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QBZ8NuzR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3022484d4e4so26392041fa.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 01:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736587062; x=1737191862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tisWqy82G+U2up76UdxFU1XP7JkgoC4pn3Hzy6vKW3s=;
        b=QBZ8NuzRy0JLE9wEu7vMK5TEv6CDp2C6XBCZZEN9+qCvWgc9YuWEPepNhHf741h3g4
         3erccNaoi4Ecd9fzNssHSSLLVUQVNRgnC6w7KfoRu8IHuj+wbh+iYcDtwmPRHsYaVFsr
         QvdKyP2NTFXNR3BY+RVDWSbn8yuZydKo1JzZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736587062; x=1737191862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tisWqy82G+U2up76UdxFU1XP7JkgoC4pn3Hzy6vKW3s=;
        b=oTyndWL+RZyifYqT9gOcii+ODTXntd8rIZRxVBEtk7F/zuptFX40m/1/fCcCHjh7m5
         yYWI0VE4nDad/SgqcC20+AOMWNdzfSFZRoIC+K4hO3CdTjBKry6ZI2rTY3xzhNx0iOMm
         UmZb97HejjWSiUY5NDvpIfTFYUqpjSiI2n21Mh8NkmVnQ2DyWmb3kyhnM2pySo42ULzQ
         BdER099kYyE+OAU/uMZo7fAzMLprKFUWSaLzZK334ByrVt1UoN1JEX1EYFvxMKG0VYJv
         GKg3O+iiL+q5RmgScDpmTZsvAo4YLGPsWEsKlir+01KZBxsKgyCXgRtD9sGH6ZmOhcpF
         fTkg==
X-Forwarded-Encrypted: i=1; AJvYcCXuOZkBC7SnTwKqgyMlhikbGxPzTLvYF/l75AfIm1Tlqo1CKmSKXiTrGMZZM4P+ShQPGkBxDoJXtKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGGbEN7jBre3vqlOdsiCr1zw4sJ3wAHFLMwu2tvVjxaag55hw
	i9tWjNUYbhVc+Y3RB4D01CizjWTH+MZPpWsiFsskhEtpDuMFL4XkchGla9fQkKXtaXzm3g1sfnc
	=
X-Gm-Gg: ASbGncsighbeisEIfaXMj7iyScWxYD+xKT8Qit6jiw6MtbCkxARP62kgvuVKZ1TOysR
	tptMbJ4PTiWhklipWDsJSV6CuVD5tooQZ6f2rdXVipUXP5f1+DJ20cGikOrT7IjxwboktXnXYhv
	9e83WTcApDMV70T8PW4nzsWvCaUZR/greC3ISfIcWVtyE4pSK8xRLtxNX/rGr6+mNmHn1z+dRsH
	/kmmoMGUsqmR2N4l3wHW3TXp+KDD30U3ShgP4HTWiL6X8UmM4/lttCzuHSuoID7EyQ1hgNztVZI
	UZgu0tccb1NdAlwGDc4=
X-Google-Smtp-Source: AGHT+IEtrWu8bq+XSNp1vGzHgnuwCgi4ZHnz3i+bb4WqcrSrB8TuP0xHqe9b8G02gp8VF/S6nuHtxA==
X-Received: by 2002:a05:6512:a8c:b0:53e:368c:ac4c with SMTP id 2adb3069b0e04-542847f9e04mr4292700e87.39.1736587061592;
        Sat, 11 Jan 2025 01:17:41 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bec0768sm786371e87.207.2025.01.11.01.17.39
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:17:40 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so2753029e87.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 01:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOd07JhD+U7FORVIf503G3KNP0GAPSKq2WeZQHgPaFYSWGlhIddj8nk4I9sP7NB4q7MkKwVMMZqM0=@vger.kernel.org
X-Received: by 2002:a05:6512:3994:b0:542:29a6:a063 with SMTP id
 2adb3069b0e04-542847f9de7mr4891846e87.43.1736587059313; Sat, 11 Jan 2025
 01:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-fix-hid-sensor-v2-1-ff8c1959ec4a@chromium.org> <20241219171718.2af17d6d@jic23-huawei>
In-Reply-To: <20241219171718.2af17d6d@jic23-huawei>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 11 Jan 2025 10:17:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
X-Gm-Features: AbW1kvb3kmA3hlXu6jsQWY_mgIugqbft_Rz5Xg5Vgrmik685pNeK1ZCM9EUmt1o
Message-ID: <CANiDSCvkKX68UqSuKiGiys8nwm5BX-FbKmHPtxJK=Hh=B4RqZQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Split difference from multiple channels
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan

Happy new year!

Friendly ping about this patch so we can change the ABI before the
kernel release happens

On Thu, 19 Dec 2024 at 18:17, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 16 Dec 2024 10:05:53 +0000
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> > When the driver was originally created, it was decided that
> > sampling_frequency and hysteresis would be shared_per_type instead
> > of shared_by_all (even though it is internally shared by all). Eg:
> > in_proximity_raw
> > in_proximity_sampling_frequency
> >
> > When we introduced support for more channels, we continued with
> > shared_by_type which. Eg:
> > in_proximity0_raw
> > in_proximity1_raw
> > in_proximity_sampling_frequency
> > in_attention_raw
> > in_attention_sampling_frequency
> >
> > Ideally we should change to shared_by_all, but it is not an option,
> > because the current naming has been a stablished ABI by now. Luckily we
> > can use separate instead. That will be more consistent:
> > in_proximity0_raw
> > in_proximity0_sampling_frequency
> > in_proximity1_raw
> > in_proximity1_sampling_frequency
> > in_attention_raw
> > in_attention_sampling_frequency
> >
> > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I got lost somewhere in the discussion.  This is still an ABI change compared
> to original interface at the top (which is the one that has been there
> quite some time).
>
> However we already had to make one of those to add the index that wasn't there
> for _raw. (I'd missed that in earlier discussion - thanks for laying out the
> steps here!)  Srinivas, Jiri, do you think we are better off just assuming users
> of this will be using a library that correctly deals with sharing and just
> jump to
> in_proximity0_raw
> in_proximity1_raw
> in_attention_raw
> (should have indexed that but it may never matter) and
> sampling_frequency
>
> Which is what I think Ricardo originally asked.
>
> Do we have any guarantee the sampling_frequency will be shared across the
> sensor channels?  It may be the most common situation but I don't want to
> wall us into a corner if it turns out someone runs separate sensors at
> different rates (no particularly reason they should be one type of sensor
> so this might make sense).  If we don't have that guarantee
> then this patch is fine as far as I'm concerned.
>
> Jonathan
>
>
>
> > ---
> > Changes in v2:
> > - Use separate
> > - Link to v1: https://lore.kernel.org/r/20241205-fix-hid-sensor-v1-1-9b789f39c220@chromium.org
> > ---
> >  drivers/iio/light/hid-sensor-prox.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> > index c83acbd78275..71dcef3fbe57 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -49,9 +49,10 @@ static const u32 prox_sensitivity_addresses[] = {
> >  #define PROX_CHANNEL(_is_proximity, _channel) \
> >       {\
> >               .type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
> > -             .info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > -                                   BIT(IIO_CHAN_INFO_PROCESSED),\
> > -             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
> > +             .info_mask_separate = \
> > +             (_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
> > +                             BIT(IIO_CHAN_INFO_PROCESSED)) |\
> > +             BIT(IIO_CHAN_INFO_OFFSET) |\
> >               BIT(IIO_CHAN_INFO_SCALE) |\
> >               BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
> >               BIT(IIO_CHAN_INFO_HYSTERESIS),\
> >
> > ---
> > base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> > change-id: 20241203-fix-hid-sensor-62e1979ecd03
> >
> > Best regards,
>


-- 
Ricardo Ribalda

