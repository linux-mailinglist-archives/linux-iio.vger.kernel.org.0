Return-Path: <linux-iio+bounces-24005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3EB541C2
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 06:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CBA1C23435
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 04:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B739726D4DD;
	Fri, 12 Sep 2025 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWFJqk0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA625A321
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 04:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757652639; cv=none; b=BC+88eUEWNLuSWiqg+2ZKOL9jC4vgADOw2fQMR7V38O+BUt5NBNNd08+9ROt1xadSSvIsc8D9rBlD1tsn8bvbTUJXen8Ma9J8co1sxM9F1nW5pYap5Gu0mTE6YSdxeuJpjrpV2i2FM/uGK0EDTs/d+ndb63aIrNDIYsAa496ysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757652639; c=relaxed/simple;
	bh=ZZZC5ID6Dmql9sLkOkKSqFgni0vwgmQc2djTCjy1b+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzwjWQQ20cpVWhKBb36RgGF/hzFBdD6nEJB9s95A6V+89Y0CMtBkQtKRZqtarmAha+fxju8fmKsRFH6P6aXNLYSUstzxDeZ35BP0WxQ2NGXezA7VB8JNTfqTTbYUfFpquz8N9oBT5wxaf3GIXVWYXujp99inCo5Sjqxt5SM/KOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWFJqk0u; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso226225a12.1
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 21:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757652636; x=1758257436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSbP+5U1920kReaRVhFD02z/dLBf/KIwYOUnhUmfjZM=;
        b=mWFJqk0uJBoyo9q/JHb11fVA4CTlYcjrFH/Cqs6HbpjNcFTqHi77HeNh0NYzPcsBWW
         sxCoR5jWbnpabkqTW2DEsuYb6QahiFideXTvRJi3BaK+FRdlODzHjzMu5SavBEn/6HVp
         h3zj2k1wuyijXrazgkq9i/xsLO9A7hqaPKUpZfaOHUdioOiwWrq3YJgIw9hZgqfo3fjk
         VhfsmWcsFSl+88ljQVH0AiAIvJaqGjvdfzd27g6HJtxhUkpHVLUPI9THUN1YLe3ieQmj
         6yuxqU65crDjxNn4jNvyk9zGZT6UQRcqyDMo5DTl26XwsiLHvfFhnW75mA3UsFGF8EeH
         AIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757652636; x=1758257436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSbP+5U1920kReaRVhFD02z/dLBf/KIwYOUnhUmfjZM=;
        b=MJvMLEOenq8zq1lObGRcSDIgurC5d561xCDfGsdXWmo6BQ1rFYQIKPKFidNEo4l/cx
         osRlhOX+wrlDkHl6sdHB0kf5rXI8xtH5DkqAcicCkpSq+q5OKZf+tWzNNcTLDo+cNYND
         jsosHuMMeTazc0ZVQgLaF15MIYxb7SwWJl7+Y5EkZsuDN1lgiS896DkSOrUBRUBWdvm/
         SBG3BU4iJzAL+nzaVoIaoYSZinhgfBbT+moxaVN2xCVa/mcNUz8hTjr7w1QMKuXitQ8f
         QDprKkYhHxktP/VXvT1DvE92MT+zUHViOqkG7n06LN1stQ/yzhTS7/gDCZmf515otpgp
         axSA==
X-Forwarded-Encrypted: i=1; AJvYcCW053Rkpc4+kn3hUe6M/VF9d5FnPGiQd8kLEvrqLB+XJ/GPStckHjIv6g7pUCwpVo8E2JsBdOqNYMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxWKZKewWOujXNTdRlGL3/K8cyW3NjdBImh0CJqQvK3wSZWZN
	EIgWaLdEqQ33O3mrLFVsXJTJYgkvdKQot1fy0vBEizjESFksD3dsZtBnDedjj1q67xRqDxVOse4
	U+uSqg6mRO0e+L9OnkA5T04kXAB2optE=
X-Gm-Gg: ASbGncsUAhjzGzxEZKQdw9KK6Z3rt6w4zp3dFbfNzLjz+mVDbXywId++S7X8ZfFTHv5
	Hio8PuD85w6HBB/yi8Ud1HARhDs/Mn69tX2EFZ/GSFKgxqlMCmcMD7bBy6Ej6XwRU09sE0tB6KP
	6RN6yqCZWPCuap3aPbaBhryOSoTNv7hPbLGV7N6EUUfsgax1RMyBeO3ESUqRuKMPq0tWKfvIkO6
	p52qOvBNWlSLR8c6Q==
X-Google-Smtp-Source: AGHT+IEr9QdS+8LdEAtRlXI7ckRg+OWnLwA6rpusj1+cersmlsUpBu+P8ucShtwzA+WLwEoSfK7SMZfF+Khe66NJ1Jk=
X-Received: by 2002:a17:906:9f8e:b0:b04:82bc:1dd2 with SMTP id
 a640c23a62f3a-b07c35f1021mr145304366b.29.1757652635872; Thu, 11 Sep 2025
 21:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
 <20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-5-b09f492416c7@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 07:49:59 +0300
X-Gm-Features: Ac12FXz7RWVY2rw2n6KAFXegbg6NhMjrRCZKE1Hp0hZ0URfG36z9HMWG8eMr7_8
Message-ID: <CAHp75Vf69X4PmGx2c_9KvQwu1opLDyfL0+TyjwX2wTG9bgtMZw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] iio: adc: ad7124: add filter support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 12:43=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Add support to the ad7124 driver for selecting the filter type.
>
> The filter type has an influence on the effective sampling frequency of
> each channel. For sinc3+pf{1,2,3,4}, the sampling frequency is fixed.
> For sinc{3,4} (without post filter), there is a factor of 3 or 4
> depending on the filter type. For the extra +sinc1, there is an extra
> averaging factor that depends on the power mode.
>
> In order to select the closest sampling frequency for each filter type,
> we keep a copy of the requested sampling frequency. This way, if the
> user sets the sampling frequency first and then selects the filter type,
> the sampling frequency will still be as close as possible to the
> requested value.
>
> Since we always either have the SINGLE_CYCLE bit set or have more than
> one channel enabled, the sampling frequency is always using the
> "zero-latency" calculation from the data sheet. This is only documented
> for the basic sinc{3,4} filters, so the other filter types had to be
> inferred and confirmed through testing.
>
> Since the flat filter type list consists of multiple register fields,
> the struct ad7124_channel_config::filter_type field is changed to the
> enum ad7124_filter_type type to avoid nested switch statements in a
> lot of places.

...

> -       factor =3D 32 * 4; /* N =3D 4 for default sinc4 filter. */
> -       odr_sel_bits =3D DIV_ROUND_CLOSEST(fclk, odr * factor +
> -                                              odr_micro * factor / MICRO=
);
> -       odr_sel_bits =3D clamp(odr_sel_bits, 1, 2047);
> +       divisor =3D cfg->requested_odr * factor +
> +                 cfg->requested_odr_micro * factor / MICRO;
> +       odr_sel_bits =3D clamp(DIV_ROUND_CLOSEST(fclk, divisor), 1, 2047)=
;

I have a d=C3=A9j=C3=A0 vu feeling here. Is this similar code to elsewhere?=
  Can
it be factored out to a helper?


--=20
With Best Regards,
Andy Shevchenko

