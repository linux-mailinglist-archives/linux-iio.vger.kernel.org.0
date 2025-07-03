Return-Path: <linux-iio+bounces-21280-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFAAAF6851
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 04:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E4A522431
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 02:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D571F0E47;
	Thu,  3 Jul 2025 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL6WS4PQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF91AA1D5;
	Thu,  3 Jul 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511137; cv=none; b=tDiS53KxEu76/CUHI7TR2KhcIX92Y3FJRbOSrKXpa46C1nhw1GIuISYmwBQUtJCdnrECidb/bQORuodbRBanTdMGGbSdDAnd7L/CeSsWac35fIaw5XCFCG9AkLEXLNrkjMA+gwN27VW5vf9PVNVjPA89vss+rzisSvs+vJ6Niz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511137; c=relaxed/simple;
	bh=zPpCHqeNq9ubsyD+eSPF34L63IwETpH3TV/cdq7hzvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFngVDDVP4ZNCELXjKDm72Kai/3ryO9QgHG3A0TFCQGRIzghZLsQxg/0Fo8aW7+8zNUsTPz61PgUjSvxhW2I8qOQlR1w0y08us1afHnJQc3BymCz9yCeBLPQs1NlVQCxEKtGcIMNoHPWJ1HcjOq/CiZHHPfcbb6dRMeUzVcCD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL6WS4PQ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4e9a7b4a412so3316352137.0;
        Wed, 02 Jul 2025 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751511133; x=1752115933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hqOgLvM5cpEDE69yGTdJg3JqR+5f/IljRV3pU1cFz8=;
        b=NL6WS4PQGsuo40hJUZyzgEkER5vY/Iw2p58fbskBxWJp0sCaiRhL2grETV8++JV545
         ZUhdhygP0fjqP1Rm3Xxn9F3bA9I6BwY2W8haDsYQQJLVdrK1QFnRhKl7TXMDQs2UTP6f
         eBokFAv9f+X0UTH5vN3b50ZCn/qtp+xUKLB9t4jTB/B94JLZ9qfiSaQsjRaj9xmkiPEI
         qBjnCdLvNA810wVzLpEegJNM/0mdh4ROVeNxlVaVwu+iKpgeFYuHskvt4V9NFEMdIjPU
         6c9q+gv4pSlY+OkwCNoCzQjoL+bb4h3D6QljdgBvEx4alCXwJGIAHXHgj0qxO0AeHfB6
         j9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751511133; x=1752115933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hqOgLvM5cpEDE69yGTdJg3JqR+5f/IljRV3pU1cFz8=;
        b=nStAZkizKVM0jfu34EUyYFz6mR61lIEDa1tRcqQhj7X9iw6retb4zbNMmBTL2LC0OE
         8TFuct68uVY9n2EnBLx+vi9qZPM5NJn4jAS0OL7EAdP/axMJnHbC9wgjFMcAbMw8OHbZ
         UbNCb/X98L/dQxrNFvjkG2STFgg/Qs+kP7uxMIDWS5ewfLNp5SoLVlthFq/L+prlmP5r
         6ivXbcznwToPiDPNX0s1Lf68VL24a8qPJlay+IzrmZ1CYIQeK5a/tqkX5IlFc2b960+i
         nWUhtUU8E0VNW9cxb1EeEAiUSkInSB9CwPmI7SuGmbc+FD2MQZ2n0G7Az0V6BvQzQ+5i
         TkXA==
X-Forwarded-Encrypted: i=1; AJvYcCUcTI+hr0bnO6Qy4jbyAHsfeKOxPl3P8vFdiOwjT/37YI/V1OjH5Fm0h4Ix2gUAOrB+RD7IUPurw/I=@vger.kernel.org, AJvYcCXrmaDN1zEJsxvx6Mtqs1S8/I/n6i+gIBdk6HU+8kkLJX9My0VdJmNUlyQY7INYM+eKnBRppiuK2ubw+GDa@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+g8+mJXNJWEML+8tBDa5HjgM96vyxeOrNHQ1mhT33VQJHu+Mh
	udkTl4Sv8FjDFuM4eJJgPGmEBY1x0ZYnABWUIPnqDKmYvuwm25vF+0japz3CMwc6xU225fbONJo
	xP9JXEUcdmbvTDzcVqM5UGBwYfW0wUY2G0qTq
X-Gm-Gg: ASbGnctFpqUyuU+De3H1dnpmY5+Av1w845mRqdhPG/w+II+LMJqdyJPXmBwZQs/fLII
	AWGMJFPLfV3fYfYau0V26ZRjPsNAfh6CHLBNG1FZw8HMjH/tULt4tF5UvT+xxAQZ/Qhemvj/g7s
	TWTEj0ZHlTdYAYvrUb2UnPpSaJ566zYz0enXCvDLKfIhc=
X-Google-Smtp-Source: AGHT+IEvTsjj7sQvdIbP0qIKAQgKS6fd3xFJQp8JC0qxGchbr8oAX86ZgI6lLm3yfWdMsHZPB5VOT4/PSnFTOkWy4tI=
X-Received: by 2002:a05:6102:f98:b0:4e6:d7af:a7b1 with SMTP id
 ada2fe7eead31-4f16110d4b3mr3774274137.10.1751511133247; Wed, 02 Jul 2025
 19:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
 <aGUh7uXenHc7NYB2@smile.fi.intel.com> <20250702164022.000027e8@huawei.com>
In-Reply-To: <20250702164022.000027e8@huawei.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Wed, 2 Jul 2025 23:52:02 -0300
X-Gm-Features: Ac12FXzNWmTAl2CMlR5pzag85NttUzDlX_AoFhXd7yX8Qi_WW5G-3OHix-4EVCo
Message-ID: <CANZih_Rc3aht-ZTuuEytad8A1d5eC8Z_Dq2GQD8K2QiyFjcBZQ@mail.gmail.com>
Subject: Re: iio: accel: sca3000: dead code issue
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	"Colin King (gmail)" <colin.i.king@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	Andy Shevchenko <andy@kernel.org>, Gustavo Bastos <gustavobastos@usp.br>, 
	Julien Stephan <jstephan@baylibre.com>, linux-iio@vger.kernel.org, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:40=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 2 Jul 2025 15:11:26 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Wed, Jul 02, 2025 at 10:00:55AM +0100, Colin King (gmail) wrote:
> >
> > >                 ret =3D spi_w8r8(st->us,
> > > SCA3000_READ_REG(SCA3000_REG_BUF_COUNT_ADDR));
> > >
> > > >>>  the call to spi_w8r8 returns 0 on success or -ve on an error
> >
> > Where did you get this from, please?  Any link to elixir or Git repo?
> >
>
> Hmm.  Just for reference the docs of spi_w8r8 are:
>
> * Return: the (unsigned) eight bit number returned by the
> * device, or else a negative error code.
>
> Not 0 on success (well not unless it is zero.
>
> So the check indeed looks wrong as should be if (ret < 0)
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=
=3Dtesting&id=3Dca66d8208762492df8442a503db568d9aab65f2f
> It's in my tree.
>
> I'll drop the patch when I'm on the right machine.  Andrew, could
> you do a new version fixing this up?  If not can make the changes
> but will be at least the weekend before I get a chance.
>

Hey, guys! Thanks for pointing this out, I totally missed this problem
before. I'll try to fix this tomorrow.

In this case, should I send a new version of the patchset fixing the
problem or a single patch following this commit with the fix?

Thanks,
Andrew

