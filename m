Return-Path: <linux-iio+bounces-12715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6F9D9F13
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E145C281313
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 22:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004DC1DFDBB;
	Tue, 26 Nov 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9yVyEVj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A51B87FF;
	Tue, 26 Nov 2024 22:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732658414; cv=none; b=TebXDIOP3OaWneGDE97S1j3jQvsQMnq+eoyQxT53tQ0Vd/Hy+4u2ESby1/lzfnuq2L4+y+4k801KPildPdVhTrqyB5sBaNb+mluXqcWoOMsbIe63l/zSoG1q7cGSgi3slcyFbE3UWzqZ/ijoMiSzn6QO4QWt6QN2nvEoCnaCcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732658414; c=relaxed/simple;
	bh=a2+/MmWFaijNBOfYzJdymrWHQtSJRpiSmPNIqSVAc8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=IRnQ8al4duGIZjr4D14N09wbr/BW70i8L1SCmsIPHKkDxuohMHtLwwEgnb9koXO/TWZIUUjuesySECOkd4t7unt5m4xyO9J9EsPZxTqMsnN3rvUc3CT8XH+6E++ytyMhxdNl+q0rSc08JsQfuALh+BZStJHf7Cqq17Xt8zilz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9yVyEVj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a8640763so7791795e9.1;
        Tue, 26 Nov 2024 14:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732658411; x=1733263211; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2YAjAUCL19nVhGZ9FKqkp7bPNOtiIRcPPeFNZu8aU8=;
        b=C9yVyEVjABdngaEVt2I8wnG4N+KWoWbJXhDnpxkMWMhCMkaP8+7/oAwGO9SJ8M302p
         xEMmipqAi1iTo+FpdtADHY/xJSt+Ki83jbTfu96yvqfrOfI9T3GwuhBW59lnEuJ1JIKc
         28hQy/5cFAm5xNSIQ7it9Nf2cfxuiW/O1dbaFUyzqArzoh+Djh+LUFIOPhzRjjE2f8/T
         iLN7EF2httHfY7uDg2ZSxlpiIPk6ooYWKyGLC+mgItVe3iIP597hMNvB4bC+dYtU6aOL
         lSXkKLzQr6yEazKwvM+s5GEfGsodmHtddwTPyQ+pM2B7MIQj3h4f7EUgn+jUnqCxrodt
         XiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732658411; x=1733263211;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O2YAjAUCL19nVhGZ9FKqkp7bPNOtiIRcPPeFNZu8aU8=;
        b=OqHwZ8PmjsWfFfZKkOQ5RpmDVqoCku7nUb6zIq64W2Qpuf5CjkNpS5IU3BJS4IcdAG
         A/mhDrKLjEfFo6Hq7/+tBQRY8XXmaBxxb2OpF9FRLLPhBse1w7TlS/mu2wqQIpy4YqC4
         huWh2TY214S3s7gOSa+8hE8shh3xzkRHS08WAAsuvuJn9aawl6B67avS2i0EZ0DtJwSz
         WS/SO42EvTa4i29j2M92siUXYzh68qfrrtng6Wg88uXjAWunAD9sEG731sPOx4Pl1G12
         4lUj6kXd7uBERdtYfFhcPZ2CSd7xExqTmpZ3pStbKRufHOfPr0lY6PVhhLqwPSa3VLDd
         04Og==
X-Forwarded-Encrypted: i=1; AJvYcCU/h1mXTby3QHWvOFxNBO3QP6oaH+TVNoITqIfAUxa941poBYwYolvnbjM3jv4C61npzRQ3NjF1dVk=@vger.kernel.org, AJvYcCWJseH14kMUcuuCgJ+h/DX+5JUJco5ydRaAlx8zejJTQI1dQeD6YzLufNYAJid+IgsX8ElY1wyR3YNAwMqf@vger.kernel.org, AJvYcCWnVrKXtYOjcUXl/PXxpXeXgL27tLSa8J8WFKAb+yVMAokqA1j8cMC2/rF7DA3Z7rBakQGklfUG@vger.kernel.org
X-Gm-Message-State: AOJu0YyrJzn/8q+RIwsY3C3thuXK6/vT6nEInLdtJ25VWxJum/G1JIcZ
	dnJBOYipr1kz9i7ZLGLX1mOwAlrcHyXNLzlJ4YiB4D7bhsHxQhkE
X-Gm-Gg: ASbGncvVFUEP2akVQCvVtWeKiYmu7wyIreCqd7eIi8l0RZBlwNzHq0ae7KDIaLsOfUJ
	ojqcb1axEmNXbmNudId2hDybHbtLbK8CJ3aGfeJEE6PbgSUqZCcBB4raJ6ms6mofV8uXaQbO7bY
	F6DnoSJ0Ie0qxAYxwGy+Ng1Hj9Adz570AdWojLYq5zqUhZMq8cBw/Z/1KEdypGrxeXcQkQRL5fZ
	Zosisk8bIsVF3yHfm4kvZcHT1hGmIsljni77S7xLYYfQ0gOgeAgXmWzeI9U1M45PG2qqN6IOGGQ
	7WhZuEfySotrEbSVUHjyGQG7fU8cB6mlVrAbklw1Baq54Q8vG9jbSe4GHStrUZ2lxrQh
X-Google-Smtp-Source: AGHT+IGvgRXk4D4VKZNKxidgv3B+igOKa6hjyopdhCh95FJBs6H/igQMnbzCZirtIai1eRFVFtZrfQ==
X-Received: by 2002:a05:600c:458b:b0:431:5ce4:bcf0 with SMTP id 5b1f17b1804b1-434a9dc6753mr7596535e9.15.1732658411345;
        Tue, 26 Nov 2024 14:00:11 -0800 (PST)
Received: from localhost (2a02-8389-41cf-e200-d42c-04c9-936b-d14b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d42c:4c9:936b:d14b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74fec9sm619785e9.6.2024.11.26.14.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 14:00:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Nov 2024 23:00:08 +0100
Message-Id: <D5WG58I3QIEL.7Y7EGKOC7AS8@gmail.com>
Subject: Re: [PATCH 02/11] iio: adc: ti-ads1119: fix information leak in
 triggered buffer
From: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>
Cc: "Francesco Dolcini" <francesco@dolcini.it>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "Antoni Pokusinski" <apokusinski01@gmail.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, "Gregor Boirie"
 <gregor.boirie@parrot.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "Francesco Dolcini"
 <francesco.dolcini@toradex.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20241125-iio_memset_scan_holes-v1-0-0cb6e98d895c@gmail.com>
 <20241125-iio_memset_scan_holes-v1-2-0cb6e98d895c@gmail.com>
 <20241126085958.GA13577@francesco-nb>
 <59a4b096-101b-419d-8a19-1063d759b4e2@gmail.com>
 <20241126185211.385f82c4@jic23-huawei>
In-Reply-To: <20241126185211.385f82c4@jic23-huawei>

On Tue Nov 26, 2024 at 7:52 PM CET, Jonathan Cameron wrote:
> On Tue, 26 Nov 2024 10:46:37 +0100
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
>
> > On 26/11/2024 09:59, Francesco Dolcini wrote:
> > > On Mon, Nov 25, 2024 at 10:16:10PM +0100, Javier Carrasco wrote:
> > >> The 'scan' local struct is used to push data to user space from a
> > >> triggered buffer, but it has a hole between the sample (unsigned int=
)
> > >> and the timestamp. This hole is never initialized.
> > >>
> > >> Initialize the struct to zero before using it to avoid pushing
> > >> uninitialized information to userspace.
> > >>
> > >> Cc: stable@vger.kernel.org
> > >> Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> > >> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > >> ---
> > >>  drivers/iio/adc/ti-ads1119.c | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads11=
19.c
> > >> index e9d9d4d46d38..2615a275acb3 100644
> > >> --- a/drivers/iio/adc/ti-ads1119.c
> > >> +++ b/drivers/iio/adc/ti-ads1119.c
> > >> @@ -506,6 +506,8 @@ static irqreturn_t ads1119_trigger_handler(int i=
rq, void *private)
> > >>  	unsigned int index;
> > >>  	int ret;
> > >>
> > >> +	memset(&scan, 0, sizeof(scan));
> > >
> > > Did you consider adding a reserved field after sample and just
> > > initializing that one to zero?
> > >
> > > It seems a trivial optimization not adding much value, but I thought =
about
> > > it, so I'd like to be sure you considered it.
> > >
> > > In any case, the change is fine.
> > >
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > Thanks,
> > > Francesco
> > >
> >
> > Hi Francesco, thanks for your review.
> >
> > In this particular case where unsigned int is used for the sample, the
> > padding would _in theory_ depend on the architecture. The size of the
> > unsigned int is usually 4 bytes, but the standard only specifies that i=
t
> > must be able to contain values in the [0, 65535] range i.e. 2 bytes.
> > That is indeed theory, and I don't know if there is a real case where a
> > new version of Linux is able to run on an architecture that uses 2 byte=
s
> > for an int. I guess there is not, but better safe than sorry.
> Using an unsigned int here is a bug as well as we should present consiste=
nt
> formatted data whatever the architecture.

Would you prefer that in the same patch as they are related issues? I
could switch to u32 in v2 along with anything else that might arise in
the reviews of the rest of the series.
If you prefer a separate patch, that's fine too.

> >
> > We could be more specific with u32 for the sample and then add the
> > reserved field, but I would still prefer a memset() for this small
> > struct. Adding and initializing a reserved field looks a bit artificial
> > to me, especially for such marginal gains.
> Issue with reserved fields is we would have to be very very careful to sp=
ot them
> all.  A memset avoids that care being needed.
>
> Jonathan
>
> >
> > Moreover, the common practice (at least in IIO)is a plain memset() to
> > initialize struct holes, and such common patterns are easier to maintai=
n :)
> >
> > Best regards,
> > Javier Carrasco


