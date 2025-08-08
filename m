Return-Path: <linux-iio+bounces-22451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032E6B1E89B
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864677B02B0
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FA72110;
	Fri,  8 Aug 2025 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4FBdxyf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE6A25F963;
	Fri,  8 Aug 2025 12:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657264; cv=none; b=i/FJwEU6bOfb7mTPU1YRN/jhwumdgcpyVCIFvrctl6roKI4vu6xwUaKSr5QfpVOK6Yd84z83ruXYqccKZKbwpyO1Km7S6A5YPhKLDDigO86Oo34lF6CVA4Gd1ZiTDeP+psJWwovMUc/BQ0O5BHJyNHlY9MbN7XkEW/Rc59xtias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657264; c=relaxed/simple;
	bh=DMRmtI5vfjflBWV5IYbOF8or8OWG8tHzfN0UjAlhblo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jto6mJMr0XKj1cb/GUXQ6YrKowpJJinGKq9zu25XLgoY0ffNipyKPCuvLB+0GMSQHpy8i1ATiI8Dowm5NZfbA6YoEN0+LK3jtqwStfogbOJ6e6sz5m4wOjbLOtU9+3JzEkIA7swZXThVW7ZLt33Lpr4ISB80YkwemxoZ7o9uVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4FBdxyf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af95d5c0736so338215866b.2;
        Fri, 08 Aug 2025 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754657260; x=1755262060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL5wSCSzPKKT2qv06rDW308qSqj4y5bPXidLbR3fQVI=;
        b=d4FBdxyfsujgjABIe8l0HWaXQ7OBjg+l+aq+EwtIDqf13BlYRENyJBtN7UG013zZHx
         3jQC4cToh6tz5Dfb9neMZyM0Jq+ulmpeKjHiZI+TDjLnCy3wkDDWq071CVYOxZw/z+hQ
         n6GNeHDobWrJ7w6d91ChA0n4cOIPTPjuVdJxsMdHf0q7z+LdM8DPt1rSJcn7ymo7JkJh
         jNCZjU36uF70p5IlOCzsL12hpKMRENdYelmBcHR7P8rZmUI/sLB/Xt7gLKt8OCf5uWrO
         BUfScUg0owAIcpJeCDxq/FdCnwqJma6O/73u5tm47Lm69lQPF7VFvuvu9iNwLLzeljgs
         WLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754657260; x=1755262060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kL5wSCSzPKKT2qv06rDW308qSqj4y5bPXidLbR3fQVI=;
        b=wmW5Qjo0A1PIJdqINbKaRr9PL0AkPPEL6QshdthCOWHh1npIrliwXMNjBgBdjkB1CE
         38/nuKUV4rQ6uG1WS5ZSKOKwZhubZAoI8A9aH9zyaVn4jBBwXFni9xICL7/dN4+xJbP+
         FSBdESjZ4DHrsEO3d6NUsJ6dOokfC73HPvoxcT+gF2C6RxvCv5hURZt0PelaXBkIihHu
         4qh4031IqTO3v5Zt1tOgj+jQQ6fLvRSriL+1uZw4Oj76XZv5WqqBkZn3AyIrPsmBbLiU
         cuiUfYliFmPHYUKh+ZmY20z+IrVRSoDyDSlZvpgHMsdRq965c71BVhYi4aBwhhhu337b
         O3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUXDgBLUnARzOo3xXcc5RI2psJ15pEQH1lusNh906EoYuY+NcVIjn48M5cgqQJRyA5BljYvOE10/rt7syor@vger.kernel.org, AJvYcCV+zABcY7oqDKeD22l/gv2TI2d3Sf0AP7i5QKztL7oTCqVHc223wn7tVW3a9gtwfWkNJi7yExO7zX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXgUG7jXcVd+TDc+Aj4vaJPYdyPqP2A3xQam2HhTUquQGKEmM
	0/ySYY1PdgxNDef6WboYdC3yY/jZ2T4bddDoN+QGZkd+6VsEEn+VgVC9ZB0ninqgZfczlPSCpT0
	3X+Hv+MGJoDUhVgHGdxC7+n65IWRZygw=
X-Gm-Gg: ASbGncvskxKH0pREtQoWkwuHA43Fi43gDxn/LWuAXGbwxIAtVH9jFUuIJLbQ9FqTfZ6
	J+mCLeAtXjNgpWwE6RZyVwwxzWgKv5F+0q18g/CIdnsBMPRLqR4f/JIptBRvUnVH+ThKTngFcHs
	DwzZT9zwRPp1GjxB0w0yBSSPEV7cUygt/bT2SXUKbjns+YGPxbtgmUUtW8lGTUceEaIzK8jE7m2
	653K9SmjQ==
X-Google-Smtp-Source: AGHT+IECPrqeObsCZqT5CRIX+XrgsQBeCQf5z8IXv4JXjm/KlN5U526iDKVtr4z5se/rcTQp3/WjAn386p3AX0WvqZE=
X-Received: by 2002:a17:907:94ca:b0:af9:b4e9:8638 with SMTP id
 a640c23a62f3a-af9c60797b4mr245311166b.0.1754657260294; Fri, 08 Aug 2025
 05:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIdKAJVnskdAVUMi@bhairav-test.ee.iitb.ac.in> <2025072835-singer-penny-a421@gregkh>
 <aIeDDsRurrgXqRQn@bhairav-test.ee.iitb.ac.in> <2025072808-evict-snorkel-8998@gregkh>
 <aJJ0npFx1mwJ-MoV@smile.fi.intel.com> <aJXJ8PRPNT+kgozU@bhairav-test.ee.iitb.ac.in>
In-Reply-To: <aJXJ8PRPNT+kgozU@bhairav-test.ee.iitb.ac.in>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Aug 2025 14:47:03 +0200
X-Gm-Features: Ac12FXwaJ5Nfwg8ibclwjckIALyJVF9dUrO_kA13KenCYeCfF5jOTtu67n0BDMs
Message-ID: <CAHp75VeUbi0Y7DgdAcw+bwSoB4w89Z0A_muery-aCAVwaiBbVA@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: ad5933: Fix implicit fall-through in switch()
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, gregkh@linuxfoundation.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	marcelo.schmitt1@gmail.com, gshahrouzi@gmail.com, hridesh699@gmail.com, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 11:57=E2=80=AFAM Akhilesh Patil <akhilesh@ee.iitb.ac=
.in> wrote:
> On Wed, Aug 06, 2025 at 12:16:14AM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 28, 2025 at 04:23:49PM +0200, Greg KH wrote:
> > > On Mon, Jul 28, 2025 at 07:32:54PM +0530, Akhilesh Patil wrote:
> > > > On Mon, Jul 28, 2025 at 12:39:21PM +0200, Greg KH wrote:
> > > > > On Mon, Jul 28, 2025 at 03:29:28PM +0530, Akhilesh Patil wrote:

...

> > > > > > +     default:
> > > > > > +             return -EINVAL;
> > > > >
> > > > > What tool is requiring this to be added?  It's totally redundant =
and
> > > > > needs to have the tool fixed instead.
> > > >
> > > > This patch is not inspired by any tool as such.
> > > > I observed this code pattern while manually reading the staging are=
a iio
> > > > code. From my eyes, there is implicit intention to return from swit=
ch block if
> > > > no match is found which can be improved in readibility by explicit
> > > > default block returning error.
> > > > I agree this is redundant and will not have any functional impact.
> > > > However, imo - this can help support kernel wide efforts to
> > > > clarify switch() blocks.
> > > >
> > > > The motivation for this patch is from a035d552 which talks about
> > > > eleminating ambiguity by clearly defining swich() case blocks.
> > >
> > > Yes, but the code right after this does the "default return", so that=
 is
> > > now dead code.
> >
> > Hmm... If I read the code correctly it is either already was a dead cod=
e before
> > that patch, or it's still accessible via goto label.
> >
> > > I'd recommend the "pattern" that the current code is in, it's simpler=
.
> >
> > The pattern to return from all switch cases, including default is commo=
nly used
> > in IIO drivers.

> Thanks Andy for your view here. Yes, this pattern is seen in iio drivers
> including dead code as we discussed here.
> For example, v6.16: drivers/iio/chemical/sgp30.c:406-411 shows same
> pattern as this patch will introduce.
>
> hence, IMO this patch can help this staging code align with coding
> pattern of iio drivers. However even without this patch there is no
> functional impact and it can be skipped also, I am okay either ways :)

Still, this leaves a goto label and makes code not really easy to
read. What I recommend for all to be satisfied is to refactor the
function so that it won't have a goto label after the switch. In this
case it will be okay to use the above pattern and also for people not
questioning the correctness of the code. Without that done I would
tend to agree with Greg on the basis of unneeded churn.

--=20
With Best Regards,
Andy Shevchenko

