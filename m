Return-Path: <linux-iio+bounces-8233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F7946F1D
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506A91F20EE1
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CD13FBA5;
	Sun,  4 Aug 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+panVms"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FC1E4A4;
	Sun,  4 Aug 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722779466; cv=none; b=rAJlMkHV3B4MliIapYUElsKwrNg/qfB6BaoMnvXP8d7Fb/6DXif7XqbH3I6BYyZzSBSM8am87aYX112f2BELV2D1r2vpxLd3qvurkDIG2jo7gXvgSO1abuHlFU9BBu9LbXSkp8Xm91tzWLBvwzRcYDTkRv1jOccs6s7bOYLT1bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722779466; c=relaxed/simple;
	bh=175VUQXYqBPmqsQIhPMarRcqfNi9qWQ2ty77lcOKVJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dARU3F+tGvVmetMtLn9Uu+HBhMAWkydiJPg0LrPciTEVsSpUURjWvaeIcrFbuEhrfk3tPOWZ5nega15flMDvTGB2B9Wd9R08jpovW7NBWIPnmdIPugeZpuhbt4r7vplHrXN/DXezgdsSrnO66YD6nDcM73495xAPwjd7O67ih3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+panVms; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee920b0781so104537951fa.1;
        Sun, 04 Aug 2024 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722779463; x=1723384263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAVYC7RgC3yQ04uDo4VvZrhZODGj0o9hLbXZ0jYoRW8=;
        b=K+panVmsmD5B1w0AvNTGJU9wt7sNnso8hdWaBeU2flJlag3IvNO6QZMhpvvoIG8RCv
         bLBeoGdNC8QWgtmfbFZy66sT+XrR0Fs+1HNChKAGzyM2DHgBXMaVnXl4Rn/QzwPBjlvW
         dr2UiNSgYIr3Ya7ZJIXNaE+aPvTNTJVndXgWz0p0BiFVag3of0U3GC6R7K3tuqxmGFjU
         ihw/OanOuEOTWAga1ecFETCKtrNt5M3cNkyhTrTCMwsEIRdjsGoaivgnHRG24TLo8Z6I
         u0fPMyZR2hiYPfv4b6mkx7bWv6cCz/4Hc+xWRtDuuJe3SwoLJFupiwAZWikb90siEuhH
         FHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722779463; x=1723384263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAVYC7RgC3yQ04uDo4VvZrhZODGj0o9hLbXZ0jYoRW8=;
        b=j1e8dKPBBJDN1e8TUliW/wzTR7E9mRFPc6kVx3joSXjG7jzcvCeuvBV57Sq/3k6eb8
         HXZ3noZQIiLwGUPvOLJei+QouO6q2vnln43fYp/7T8liO6ZB6vB8YC+OlcCc5iSpdUk7
         FpN3KQDouhZVuxnaTrZ/qbX8UB7plcJYyaUGBk9v3SkC/nRo3trkhB6uGQYTynLSNgwo
         kS7TJ52ifIi0JAY/zX1hyo07CuTyQe0CYHh3OpGJM1N7ssRjWz9Cf+b0gNl4ejvPtMq2
         HBgUmR0ZC30ZE96sxIe3k1sON22U2uCOfyVFMTLHKBvugTutrr58nHsZGuRSoF7yOjvn
         Xd0g==
X-Forwarded-Encrypted: i=1; AJvYcCWzTROqfJrR7vt/me4GF/sQBcaJxOLCFNbBy8pUYFX94ZzpB6f4BTPpZrejzgFqAjGWKiaTf7qLLSBxO3EN+3P7O5/9xkKj9kCp+tLHhgQlF8VzAQ2PWgI9DgWvlMYhQO9NHKZADuwL
X-Gm-Message-State: AOJu0YwRvY7i0rHpI7qh+ybVusUbxL1/XLYpl7ktRhOGGs9WWCamOelj
	tPLphTCGghg8Sdi1sIe6KKYtTxrEGhX+m/Wyp/5vctSjDY8QIMe93YI/MqWhfsk/5KU1ZX8QJi6
	yioRh7ckNchaK5hz3cQToRMuITy0w/Lmhircd3A==
X-Google-Smtp-Source: AGHT+IGj7s1AYfBH74str8ItNPnQ/f7oGGLpksLbBFQenaSeV6QnV1CAyftLcGUHTOeDakwfDJuPF0HM12OYGwvzqIo=
X-Received: by 2002:a2e:2c11:0:b0:2ef:243b:6dce with SMTP id
 38308e7fff4ca-2f15aa84ec7mr54170511fa.10.1722779462473; Sun, 04 Aug 2024
 06:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
 <20240803180950.32821-2-abhashkumarjha123@gmail.com> <9927c607-5740-406a-8cd6-0550e8b92038@wanadoo.fr>
In-Reply-To: <9927c607-5740-406a-8cd6-0550e8b92038@wanadoo.fr>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Sun, 4 Aug 2024 19:20:50 +0530
Message-ID: <CAG=0Rq+UaWrZXnhfctYQobR_v6P8dtbZg2==rqFUP-qM+7UBEw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: anshulusr@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi,
>
> >
> > +static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
> > +{
> > +     if (data->mode == mode)
> > +             return 0;
> > +
> > +     switch (mode) {
> > +     case LTR390_SET_ALS_MODE:
> > +             regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
>
> Should this be:
>         ret = regmap_clear_bits();
>         if (ret)
>                 return ret;
> ?
>
> Otherwise, 0 is returned in all cases and ltr390_read_raw() could be
> simplified.
>
> > +             break;
> > +
> > +     case LTR390_SET_UVS_MODE:
> > +             regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
>
> Same.
>
Yeah, I totally missed this. I will make the change and send a v7.
Thank you for pointing it out.

