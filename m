Return-Path: <linux-iio+bounces-25566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC7C13EA8
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1713A6EEB
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 09:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CA2D7390;
	Tue, 28 Oct 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH++043s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10813AA2F
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644828; cv=none; b=BpxGBJTVwGVhXz+R+dV5yuH8TbI7NTCvO4yPMDwjADeqRZvJZUOCHhbubpPNDTKTk8rkxTNOXvJ1qdUIVILmuwW8KRLyJ0iaDdogoQ94MFolLsF9bYoDHVSLenTbMzXzEQxLKU5gHRN5DWDhkyAV+BWpGVuOFc4KPNmgbBr6UAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644828; c=relaxed/simple;
	bh=hSWOe53S2QH3pVgKVB9TrVijS+TcXb/7kNtx/H2jVds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/lvZxNaPa/kB8A2x3+S0dq9pepdtHmr2Xn5nk1Ls1kaXURlQUyqeTzyPoWuiZc/W8PEDTyiFAXMk8IMYOk0OuGdzplrfnt8FdWbSyShEOLApVfZzLi3IsI+TgZJp9vc/wjc2OSc+yxE6fAAUOyz3Ott2AcvKZ+Wg5ijjyfehT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH++043s; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-64e5f669511so2840156eaf.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644826; x=1762249626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRcEviLpCpzNbLcGaqosnVGor2ewNPnssN8Q7KbkRtE=;
        b=gH++043stkwOBSwbobKc79hFO2W3CPytqSSxp8/WBT/76s2CyWMiPq6n0LdlW54xQ7
         P7pgXMCcbLNyPjFAy9Cxk5ozWkujCN/U/H8yiPFV1Q96UFpFky5Y5Xd6U9RJXMERTLau
         NFSH1WHp6+wJ53hcqjsjci23GigykdSIwRqahcQkltJK+qoZEgH8WEOye/TIFZumDvei
         Yfo/okhTq8koEQKNW+8/dfa2Yu3NhmpnECGKc0pLBjp3VMQIn9Hjzv0iTyt3sgXjW3VU
         0P4NRq1Dk0PxDt7tZcurw5cURtJozQ6GUHMl2KkDkRxO6NGoqJPUMK2UA2DS5d1i7zG0
         Cwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644826; x=1762249626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRcEviLpCpzNbLcGaqosnVGor2ewNPnssN8Q7KbkRtE=;
        b=J7LX+k6+iZGloTQuy87c9/lxK0kfdbBJrLCBbestzpz+wbe6ZUwjKj7/3UEJhTo/rn
         k61tpYgpwarwXhBjsscrgyTs4/xBM3231jLREhqy8WQSNBeC3iEiW6KDS9YoBUzpJ/2s
         6ndlbYwHz6NsnKZFCn/ZfXw4QvhnJg9MFUVTj0IQIozfSgRuFMsxs/soXGSnxsH3n6bL
         rBLElSWCUa9P9P0Ne0CT0WI7ibUHVmbVqUZRwd515X2oejar4h+bfzF0gn/KWmKlYF4/
         FOnHXSD3h+OpPFmi7SeGfIof+WoyHlX4i3btXqOyZ2afs3mzzE8IMR/vbbye2z1GlWVP
         iTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS1O1Knqwb53p9CUg05SsUn3Wk6CMeqdM2TOuyVelayPLwuMfHa6oZsdBP2acDvztbj9f3IZWHjrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQPhBwSFC2+to3Os2798hx4wlHl8Rd/HhQ/oou6TbDnqdhNAu
	AbU3p1px6iYjgRJxZ24bn/G2JxUVqo0vlaUAO6qjo8TsPNIfItmKZTr6IKCTSo/K9b+0AZhJCjZ
	X7TxMqhzExp2qNNd0sTRQybutkuimPpE=
X-Gm-Gg: ASbGncu+9cRCv9owVc9Ln56N7Rwv2Xr3iB4gfXn4DsJcdbGqIB7QNLxCsF7DF43giXw
	1UMbg6Yt68pWdI4Q3LsTFhlzCfUk4pB4DD8qJcZI5yFy4EEtzbL4LeUjaMz2ZZdRXBbsDj9XUYG
	VD8h+39iPiJDXlhqvZKS84GjkzGWkADR3/GEhIcTx56vngIIleUo4CHHr78hkiyQ44PPNzdqxg8
	84byoJN2jXyWejiy1y3RN62r3tvOMf/nqyCb+zN8NcrwrnGMbRJ+HEC3cI0
X-Google-Smtp-Source: AGHT+IFw8a2DTtRPDokUw0E0HICi9syLpcF47ySoZkOb+tzllRPpMha+vYjNZRtSyWsUbq0R+JTaLVdCjMUDXP0/UC0=
X-Received: by 2002:a05:6820:2188:b0:654:18f9:cfdc with SMTP id
 006d021491bc7-6566f2a0dc4mr1298750eaf.4.1761644825696; Tue, 28 Oct 2025
 02:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027150713.59067-1-linmq006@gmail.com> <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com> <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
In-Reply-To: <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Tue, 28 Oct 2025 17:46:53 +0800
X-Gm-Features: AWmQ_bkMzCWltp8_0lWU6LTq8diCXGtcBzjewll59CoFnsgQA3j4_8Ni5MdIpMM
Message-ID: <CAH-r-ZEG5qN5QNCJTnX_oK2uyheNjvzoAEgzuyTYyUWF4kf+wQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Markus Burri <markus.burri@mt.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andy

Thanks for you review.

Andy Shevchenko <andriy.shevchenko@intel.com> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 17:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
>
> +Cc: Markus Burri for the da9374819eb3
>
> ...
>
> > > > + if (count >=3D sizeof(buf))
> > > > +         return -ENOSPC;
> > >
> > > But this makes the validation too strict now.
> > >
> > > >   ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbu=
f,
> > > >                                count);
> > >
> > > You definitely failed to read the code that implements the above.
> > >

I previously read the simple_write_to_buffer(), but add the check and
think it can help to catch error eariler. My mistake.

> > > >   if (ret < 0)
> > > >           return ret;
> >
> > > > - buf[count] =3D '\0';
> > > > + buf[ret] =3D '\0';
> >
> > Maybe this line is what we might need, but I haven't checked deeper if =
it's a
> > problem.
>
> So, copy_to_user() and copy_from_user() are always inlined macros.
> The simple_write_to_buffer() is not. The question here is how
> the __builit_object_size() will behave on the address given as a paramete=
r to
> copy_from_user() in simple_write_to_buffer().
>
> If it may detect reliably that the buffer is the size it has. I believe i=
t's
> easy for the byte arrays on stack.
>
> That said, without proof that compiler is unable to determine the destina=
tion
> buffer size, this patch and the one by Markus are simple noise which actu=
ally
> changes an error code on the overflow condition.
>
> The only line that assigns NUL character might be useful in some cases
> (definitely when buffer comes through indirect calls from a heap, etc).
>

I believe it is still necessray to use buf[ret] =3D '\0'; intead of
buf[count] =3D '\0';
If you argee with this, I send a v2 with just this fix. Thanks.

> > > NAK.
> > >
> > > This patch is an unneeded churn.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

