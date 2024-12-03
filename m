Return-Path: <linux-iio+bounces-13032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5B9E29EC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 18:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94AF7161287
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453831FBCA1;
	Tue,  3 Dec 2024 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkUoZW5s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9DA1632F3;
	Tue,  3 Dec 2024 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733248114; cv=none; b=WBbnkEGEsB9cUW3p6+Kif7/FfISE/E8xmyvXL2Nz1VgKwnWtutj0VqiP/IMv3QhJ2uOfraXj38IX5+ihuE6XIj+/LLTFR/6gIVZL8/hhrKsGZ/gynRXf2zAIttJqKoC1ypeJ1n7ZbE2ekp+7wOQCi3UEaOeP72ePU01xiBVDqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733248114; c=relaxed/simple;
	bh=d+jCWgo6EElY4bwZaJas/PG3O2tTB+4SzeRZqKzyQtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkG7KD6p6/pPNXX2K2k+p6x9hcQfXgDPRTG3oDEqspNr1MB9SK3mOf+u6cMVVbZkOtV5+S946/U+uT3RIlN9J+msIuYNZoQRDHs2AjRkEPjWTSSxUSeECdprfcOTdTyDHObB3xOqAl8CnRrL38ujemJrizARMj3Ykq4f0viP3mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkUoZW5s; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5325af6a0so820209066b.2;
        Tue, 03 Dec 2024 09:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733248111; x=1733852911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnvbEAC2YtLls/04SGMg6SxSWMbA6kNxrt6oKTJKjMY=;
        b=bkUoZW5smniVO+z6U5Crh9kb7aRUre/YHyGf94xoCcXtlyDpi2xDdkn747Tie9R/ce
         HviNAytrPXgZrKqJKWZASWRV5smyMc7htz7q6b+XAxrzPAnTAySOq9BsxLALNBqfXKkM
         0lA9SdPiRQi2ZfsatRKUTXjkLt5UG2oTCH+Y5oCdlkZAq1MGmF8/3MzfJ/QbFcYsqBYn
         cNkAITZ29J9MxC2fRj7hTnBWwSEDYtLDtOeCxVaLWjJvC7K1fTEPh5gZuEFaGGPiZkJG
         XroVO5x+pf2dQfXH/fyXYz0A9B5E6FuwG3GONu9vrSPCCDfwKVdZHnOmENKQA5e/VUwj
         qE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733248111; x=1733852911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnvbEAC2YtLls/04SGMg6SxSWMbA6kNxrt6oKTJKjMY=;
        b=t+ePXTYqKLe99sPPpYae+DKe4Y6B3KoTWic/08QN/XtP1FEuwcL5n1FILGMMuF3YWr
         /sUDxAIwwJZkdgcVD2r7K4jL4rqtEfn+ADjud9H1utE8g+Jj3iHdEqVVQl5XnFOR/DXM
         xKbyc20mMUlilmyfX7+qH3y/1/3WSx5dsnnFRsYB4+U+hCemVxtuE9muHCnPoGrBLpOd
         fYjhovbXCTSN6NBRIhzDp2XvicLi6XFMsri4hRD6e4v4dVKDLKGRxVYGOATRX8t7i+7u
         0BbQX87rCLzpH86IGjnPK60zNGwJ9aPXsNXmpmNoVrY9aAbqu6pZQWw5vD1raPQdau/O
         rydw==
X-Forwarded-Encrypted: i=1; AJvYcCUMJzkRQhDPI4a7rCH8IR1f/OSE90TwGUqZjflvuA70pmLkfL9cHFhW3V9dDU2azDOHj5k26jLaFWpU@vger.kernel.org, AJvYcCWQ963iMwxpAH3wbFLzWJXLxdgkTqCjE/XmGIZQytEJy+OYMvwnE7RXYUUMEVJXJm7SW3ZVhcjZ79b7@vger.kernel.org
X-Gm-Message-State: AOJu0YwWcCk5t/5Msel9gCyVvqyAU4KvTjTo6Ya4qGy+yYJsMMKyt8nD
	Wv4TuRrYgSmsWkietJXx7Qx1frLbJuvcmz3X5WXpqo4DHaBl9cU5iqiMVScgutNZI217J7gfM0r
	ygfveR3yyBLc0TL8rHqSy2pWEz7E=
X-Gm-Gg: ASbGnct9RBx/7P6tOjJfW99gKCKQHfXqQ0byTbhl9Ivi/275ovQcYfDGtxPLCB3PVur
	5zc/7Pnldaxt3ovd3pDQDPq7uSGijPEM=
X-Google-Smtp-Source: AGHT+IFPH92JOHin4lcnT8ALlS3vdDckialsLIKMTdkjKzkL/svqP/DjzraFQ8836uT+1lr3ybN+nBezNIpef0RTSEw=
X-Received: by 2002:a17:907:75d3:b0:aa5:2a71:1646 with SMTP id
 a640c23a62f3a-aa5f7da975cmr305957566b.33.1733248110449; Tue, 03 Dec 2024
 09:48:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203110019.1520071-12-u.kleine-koenig@baylibre.com>
 <20241203110019.1520071-20-u.kleine-koenig@baylibre.com> <CAHp75VfuTRDAjOD73re8tCWWJsAFUq_P6hPiPd4j_mOFM8oKGw@mail.gmail.com>
 <wfcqlw3xqs2farpvkn3jjlot2bhmsgfa7lfpyzrjwuwuininsn@ni5rcnm3zdxs>
In-Reply-To: <wfcqlw3xqs2farpvkn3jjlot2bhmsgfa7lfpyzrjwuwuininsn@ni5rcnm3zdxs>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 3 Dec 2024 19:47:53 +0200
Message-ID: <CAHp75VdYagk3Rk=ZwhrONHmJBQ=oxQuJc0-RHZwj7E_wGim-OA@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] iio: adc: ad_sigma_delta: Check for previous
 ready signals
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Renato Lui Geh <renatogeh@gmail.com>, 
	Ceclan Dumitru <dumitru.ceclan@analog.com>, devicetree@vger.kernel.org, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Alexandru Ardelean <aardelean@baylibre.com>, Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 6:16=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> On Tue, Dec 03, 2024 at 03:10:30PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 3, 2024 at 1:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > It can happen if a previous conversion was aborted the ADC pulls down
> > > the =CC=85R=CC=85D=CC=85Y line but the event wasn't handled before. I=
n that case enabling
> >
> > Interesting use of Unicode, but I suggest to avoid it when it can be
> > avoided, i.e.
> > using the notation of #RDY_N might be appropriate as that is how
> > usually the HW people refer to the active low signals.
>
> Usage of =CC=85R=CC=85D=CC=85Y has the advantage to match the reference m=
anual and data
> sheet. So I tend to keep it.

Not sure it's strictly the same. The above has two dashes on top
(actually misaligned a bit) of two letters out of three, this is quite
confusing (as to me to an electrical engineer) and I hardly believe
it's the same in the datasheet (however nowadays everything is
possible with (ab)use of Unicode).

> > > the irq might immediately fire (depending on the irq controller's
> >
> > controller
>
> That matches the way I spelled it. Do you mean s/'s//?

Yes.

> > > capabilities) and even with a rdy-gpio isn't identified as an unrelat=
ed
> > > one.
> > >
> > > To cure that problem check for a pending event before the measurement=
 is
> > > started and clear it if needed.

...

> > > +       data =3D kzalloc(data_read_len + 1, GFP_KERNEL);
> >
> > Yes, I know that's not needed right now, but would make code robust
> > against changes. I'm talking about using __free() here.
>
> Given that I expect this commit to be backported to stable and
>
>         $ git show stable/linux-4.19.y:include/linux/cleanup.h
>         fatal: path 'include/linux/cleanup.h' exists on disk, but not in =
'stable/linux-4.19.y'
>
> I'd not do that *now* and in this commit. But in general I agree.

Good!

--=20
With Best Regards,
Andy Shevchenko

