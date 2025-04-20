Return-Path: <linux-iio+bounces-18355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7130EA9461D
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 02:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7229D175EF9
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 00:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC58C13B;
	Sun, 20 Apr 2025 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChRlgBO/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CF647;
	Sun, 20 Apr 2025 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745110046; cv=none; b=h0G0JsdkupjoQ0kR1qF3MK8etCy6fPdIkimZCgsH2LxGTsYsjn+RecXyJHKjVuQOmlZIeKlJX0S3nor/qX9XP3GN31hfd8rPPu5M6/weGCw7v/J1CdQqz97npoKrscNNeJSQaQzaxve2AvoEaoCTUUTeuXX0voo2xehOhLiwydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745110046; c=relaxed/simple;
	bh=oPEQvbu8JP50TDbHOHgqHxhAKnR79/d/8OgWww/ne2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RypVQQGgZIykF3n1Ud5wspc5cx1k9mikfJfiAQb4E3vhHgjB0b+J2OTxN00W6xOtTrhA5EJqgJrJdLy25PQY/xhOMCVXhEPRIm1dA3K2nicndMBQKlz7oZFBiT/zfsWic3idJcpQGf/4vTIbTFFnqncuLuDke8eNjakhJs0MTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChRlgBO/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22423adf751so31533825ad.2;
        Sat, 19 Apr 2025 17:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745110044; x=1745714844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3UbJ6sVj0Q1eE44m7wvB7g9mVugpdeJOq3atIyJK1o=;
        b=ChRlgBO/yxSB4aI7FJYPCMt0AGtdezHzAiDTOgGhUvwtIVTzSeZ70/3Vna6t/4m9uZ
         Vbj1E9PxQ//K9bPFO45QYoVhBJ3/SQw1BDfh5JGWmFeVBaWna0pcNfp8FJgYkzrB00Jf
         hG/4VMdE8rPuFwD/mAvbtk/q8Y5K3wjQ8ks0nBdr0dkQ2gTHDrTb1mMJ1dLEDPaHMYSY
         uAEj+gWbJX9cAns/kdBMrid3Hj/zhciUFkYwY714fKw4CpdlsPaaacF41cKBltT2uwPI
         IB6h3Di77rrUq0ZhI30qi1VMr9uVnwT5R1rprycKarKBiSxLBzYHFWXJFkZ7L1q1Lu5h
         mu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745110044; x=1745714844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3UbJ6sVj0Q1eE44m7wvB7g9mVugpdeJOq3atIyJK1o=;
        b=KLeAyHfYgorwYBCKWi0d5FrxHmDn5YdvvXGJ6+Mj421UdykEQJlNETgZPBYhj7Klm1
         7uzGgXz/3SstPIAP1ZCRueMUcwTLeP58gKeM8QjkWM3diIL+tmLG1TC7q/yMIu8wzIKT
         VVhghe2YvTcR5hj00g/NjPylyZ7/gzUI6dfv90U0e3wZQzVpX3EMUi6zytI0ykbp0hyl
         3PzLxBe/EXYt8a11c0UhT9tq4tL5FDqKqLhB2q3wPwGzR2+L2SGj4BpnmC6+TMZw5Tnr
         uHYhQaRO4LDj2wEMIxVLwaD/tI6MLY53+Kil0ZFGk4PGeJDYQKShd1g1dPOVgowFIw0+
         wWQw==
X-Forwarded-Encrypted: i=1; AJvYcCVHDxKV0LYxlKaZDU8zTQof0mR4c+W0RMCWigUw/q+tditEO61FzgbIAVGCqOZmWMUHqBHgcTAX@vger.kernel.org, AJvYcCWFipdBupyH52+5J3czwzz0j0CTXPfKruaoWdBaj+3O8c9F6zVZ/zIYUd4XeCvdq9o2+lx8DVtyBkrgPh80@vger.kernel.org, AJvYcCXRnrP5lOVQ/ZkN6cf8pNtCyKGBaKztjkt8IkNU2kN3BINJNUYfkxx16tmMNUhd2DopNAg8kpHk2Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wViQ05IjcNo2YDiPmK1NjF54T4/RlEV6Q3+6TvuV0MqqjelC
	90NWl0eel0jDAIVLJ9Tz5cYVcO6WuDh1yp6bK1N8UlRoiBW7CMbV
X-Gm-Gg: ASbGncvwp0kGILod2xuyY3g0rEIhvDsoZN2XmzHukS0XNsttkZaPSR5h+wsdi8T6X92
	YVETaJxEhbHNpBWR1z2p5lnWPYlMhzNU90J6EPNF4bl4a8gKuqACxeNT9dQsxxiBso7h0dydS2G
	Ai8WH4Af2tmKuMkwQt5780yo0f7ogCvq30Ru++QfEnncirYNQGzI4lOuwh/NicxIWGdkxCb0h83
	/S4rh2pJG5Xr1THJ1dc0sscbVstWR3HrXgjuXYZ2izmSJZI0Ive7GZsCRo7k/7AGQs1Tzf+XjUB
	nElEWO9UUcrTg0Lq+M8fOS2zrMBGGmXyZF9AHZr5P28XdvU=
X-Google-Smtp-Source: AGHT+IHX4JfCAGLHU+bXJ/YVu1CcsjhWotihBQ6Qsp9Bb6qEvbmSQUbeTDYj5k85HbBPZGMXyXD7TA==
X-Received: by 2002:a17:902:d549:b0:215:4a4e:9262 with SMTP id d9443c01a7336-22c5356deb7mr97366575ad.8.1745110044318;
        Sat, 19 Apr 2025 17:47:24 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bf543esm39858255ad.95.2025.04.19.17.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 17:47:23 -0700 (PDT)
Date: Sat, 19 Apr 2025 21:48:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: ad5933: Correct settling cycles encoding per
 datasheet
Message-ID: <aAREYg1uAc8NSVKY@debian-BULLSEYE-live-builder-AMD64>
References: <20250416142219.554938-1-gshahrouzi@gmail.com>
 <aAPEUUAHsG2CvFbr@debian-BULLSEYE-live-builder-AMD64>
 <CAKUZ0zJoV6pLEFh6mEjz5awousn4o8Mq2D9AL8CfvqqW620X4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUZ0zJoV6pLEFh6mEjz5awousn4o8Mq2D9AL8CfvqqW620X4A@mail.gmail.com>

...
> > > @@ -411,14 +417,15 @@ static ssize_t ad5933_store(struct device *dev,
> > >               ret = ad5933_cmd(st, 0);
> > >               break;
> > >       case AD5933_OUT_SETTLING_CYCLES:
> > > -             val = clamp(val, (u16)0, (u16)0x7FF);
> > > +             val = clamp(val, (u16)0, (u16)AD5933_MAX_SETTLING_CYCLES);
> > >               st->settling_cycles = val;
> > >
> > > -             /* 2x, 4x handling, see datasheet */
> > > +             /* Encode value for register: D10..D0 */
> > > +             /* Datasheet Table 13: If cycles > 1022 -> val/4, set bits D10=1, D9=1 */
> > >               if (val > 1022)
> > > -                     val = (val >> 2) | (3 << 9);
> > > -             else if (val > 511)
> > > -                     val = (val >> 1) | BIT(9);
> > > +                     val = (val >> 2) | AD5933_SETTLE_MUL_4X;
> > then this would become something like
> >
> >                 reg_data &= ~AD5933_SETTLE_MUL_MSK;
> >                 reg_data |= FIELD_PREP(AD5933_SETTLE_MUL_MSK, AD5933_SETTLE_MUL_4X);
> >                 reg_data &= ~AD5933_SETTLING_TIME_CYCLES_MSK;
> >                 reg_data |= FIELD_PREP(AD5933_SETTLING_TIME_CYCLES_MSK, val >> 2);
> I currently have:
>                         val >>= 2;
>                         val |= FIELD_PREP(AD5933_SETTLING_MULTIPLIER_MASK,
>                                         AD5933_SETTLING_MULTIPLIER_VAL_X4);
> which assumes val only has bits within a certain range which I believe
> is the case here but not completely sure. Would it be better to clear
> the bits regardless and then apply said operations?
Nah, since val is being clamped to max settling time value, I think this is good.

> > ...
> >
> > Though, I guess it would then be preferable to use masks and bitfield macros for
> > all other places where we handle register data in ad5933 driver. Probably
> > something for a different patch (if worth it).
> I separated the original fix from the refactoring so the patches stay
> modular. I can apply the use of masks and bitfield macros for other
> register data. Should the refactoring be all in one patch or spread
> across multiple?

I believe all mask/bitfield refactoring can be done in one patch.

