Return-Path: <linux-iio+bounces-4430-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A998ACC13
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 13:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8D31C222F4
	for <lists+linux-iio@lfdr.de>; Mon, 22 Apr 2024 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ABE1465B0;
	Mon, 22 Apr 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPbUvWpK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F0D1465A2
	for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785678; cv=none; b=TnhD81z4uue3fXnzlELimZnW7IaHdgGgehgx64UjfJeaC8neXXYG0A2Vzik+dlPiP86J5tXwvKZz3DQl4hETOJ3KCH5ZA2XCBtCm4j0JbVJmyQ6LDb5RV3VvjkBZVm+u8B1HyU3k6w3l3cg/USCfJYU23e6Czte475cRET40xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785678; c=relaxed/simple;
	bh=wqq7GZgOXK0DWctXKOkDDT81YbOj9+LPdPIAH4+k7TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=san6hsabhJkYuQbnbw+rdm7gkcONxiWoL04DRbh1arjS62r8KE+XxerAaXD0B3wb/NEu2MMZXYSorNWJybp36YqfqDyzgJiZHj+AWN1VUMGynCqMfFjbADLFQLnpaElIiL+NjX8AAGRVg5PRFpk6I42u0VA/WhTWvQhn8u2JnB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPbUvWpK; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db13ca0363so66594581fa.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2024 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713785675; x=1714390475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqq7GZgOXK0DWctXKOkDDT81YbOj9+LPdPIAH4+k7TA=;
        b=nPbUvWpKTa+0fyBqJP+Z3IfBSA6vg5HoX081CGbxs6sLpkiufg6v5IvH52jExowtws
         UzyHcQV/v7ur/yH2GPCfZOmuybpMb22JLFWr6Dx2ByNnwBY3VRtolc7CrglY18RsB75d
         8E+QdRJXcdBMTtzLPpYOWPrMW4MVEBrYavJfU1E9cZOxmy7eL2mRVm+7qJqHIcfStmsL
         Jpavo8mpUnqrBW2cJuOo2S3KMBcEaOuQHlGWTqWX+nHT5WSE+BaK8QARqzzlhz9yqEQd
         WiviMLnyYU1IhSl5pTtl8xSGahX1RJP8/ge1Qlm/boUaiIBaF9jkoEY6m04JKkBtTzXq
         96mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785675; x=1714390475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqq7GZgOXK0DWctXKOkDDT81YbOj9+LPdPIAH4+k7TA=;
        b=YXNquSgoEakSFTnDfz4jrMXljpLTvXXk5Sg6qt5GUMpClWnSYhBuhbx91wiT1XS36L
         H3p1pwcnhSLpmr+TU041O/+nK0HQJu44LbBYxMogq58z12bpasFRPIZmDUq8NvgP4aYJ
         xM/K+8sJwdmHn/bIxC/Ari//5QBeUlwAua1r7Ja6s3+U2Hke7W6LfD3FRIBJx3qudaWH
         J/itGYaEUbIwB+EQ+cC0Rc4YYX0FqbMh4Pq1e46CYD+3LVAPMUmXzcIz8UCFU3mUQmO3
         03ZnAwMA4FHU3ihqdKUCLq7dUZQgY2UlcI3AVVX51yjg2Arjm9bSbO66Ow4gKtXnQIXt
         w1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVu0NCFIj2Rko80lQd9W8JEaBbw9JPhW+4fBZncP5ElgiBGLYGIztIzEVv4kOFPI9ldWOX4x3hNeZPt48PKhBc/UEe9qdbwIxub
X-Gm-Message-State: AOJu0YxRHLf/+22q7igKcptjflATan5ZhXJNzYy1sIt+7I61sCuvSY3Q
	59udkNyLkCcfwiheoVjhSWEatPtg1jACzQZmhQJTVSk0E7bp73C8KPn0bklOzjV6ryO+XEmex3+
	/H27fVCT3FrAWLhoEVbIFK3PApR0=
X-Google-Smtp-Source: AGHT+IGLS3WpiD0rq3S6s9z/a2yXTKgRrqlmcYiq4hw1aAmtY8KmR32vJZm6B69Bi7eFiCbZ4RGpUXsPLW2gBUl3GJg=
X-Received: by 2002:a2e:7006:0:b0:2dd:c9ad:f748 with SMTP id
 l6-20020a2e7006000000b002ddc9adf748mr775315ljc.40.1713785674436; Mon, 22 Apr
 2024 04:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417164616.74651-1-hdegoede@redhat.com> <ZiYX5JlwS9nGkS2Q@surfacebook.localdomain>
 <81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com>
In-Reply-To: <81f83cd6-6d17-4e11-97b6-7f1f11bc3078@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 14:33:57 +0300
Message-ID: <CAHp75Vfsnffq8J=j9-8w2VWHyMp4e5gw7F11S8XMdMN8TXMwKg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: accel: Share ACPI ROTM parsing between drivers
 and add it to mxc4005
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Sean Rhodes <sean@starlabs.systems>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:24=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
> On 4/22/24 9:55 AM, Andy Shevchenko wrote:
> > Wed, Apr 17, 2024 at 06:46:12PM +0200, Hans de Goede kirjoitti:

...

> > I have briefly looked into this and I like this, except the part of the=
 big
> > function being in the header. Why? Why can't it be in a C-file?
> >
> > Note, 3 users justify very well to me that shared code, should be share=
d in
> > binary as well. (I.o.w. you may argue that IRL there will be no more th=
an
> > one of such device connected, but in case of DIY and prototyping it mig=
ht
> > still be the use case.)
>
> It is only 1 function and it is not that big. IMHO the static inline
> in a header solution here is much better then making this a separate .ko
> file with all the associated overhead.

Look how the i8042 RTC header became a disaster. :-)
Nevertheless, this can be part of the IIO core for the ACPI enabled
kernels. Which eliminates a need for a separate module.

--=20
With Best Regards,
Andy Shevchenko

