Return-Path: <linux-iio+bounces-22281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ADFB1A25B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 14:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D62188D254
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082425DD0B;
	Mon,  4 Aug 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGlYVxJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEAD25DB0A
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311985; cv=none; b=Jwj8YPK35CfX0ma9EYOpUfGgcIrtTGk2H4fr05HNk9iIYDFtsM8ot1T3WsRsfZruE90zzvD/Sx1uy6Rpk0ew/Cm9YnAaXhWqk9Xn0wTBZATvVMVuPOxC9DKuBx9QWL0JaHR2//ixGwIOnifleOtpb3SGKRIbLlPacucDyY7rtFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311985; c=relaxed/simple;
	bh=7UpNUBjjQLm0UtJAgHo2lOzM/I68arq0UtQqBMwKbh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAnQMX7zk62XecyQmHBiL4N8tg5kfWbqSgWy9LVEkcwaV4hbt/w2JSnuh8HxEwidKQ7IoExWLnkDy1himOpbyNJeR2Jzf4qorN6zbAE++XHmnAGZ6ALqulhMCe1zUABcJrJtt48l042gRCXoVy2SnhEPRxfwb1nE6/B/4Vw7BwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGlYVxJm; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af94e75445dso304031866b.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754311982; x=1754916782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYY+KsZNS8yBiB/91z2Fe4cRA9Dt6FM/ZdAPacoQbm4=;
        b=mGlYVxJmuu5AORRnGTb2rV18F39HsFR6qifB8Z3aVk+h9SOVn90LT59BW+RPN4kVW/
         f7XlFILv5MKXQvuC9NxQYCXkV4SsT0YSCLTv3jbhmPsRoWYu2I5y7zWDnrqp5yxqT0xK
         NugrFOCnbZ1z5/My3vHseWmpq/P9ULRXQsUqkil1cTrOt8gZ5DC8Q8H3ouGNgWNAEqiD
         GMSkRmQyJnK9MGqGXu8XXTgyt7nbfMaRPuQ9ufV9Fx3GG2u5QN7hBSkfdto9S+ZKzkbw
         /n05B236F+FCvpAjNEx+U0o7pqp8+mVZ01TQ75aScuzcRH35p0jClzVrJrfFq2QGWvML
         P3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311982; x=1754916782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYY+KsZNS8yBiB/91z2Fe4cRA9Dt6FM/ZdAPacoQbm4=;
        b=ErtCUJ8sRASh958ctL+soIJfhqxsZxOM6du6SeMDVceWQK6dhucYAqTL+3w0NAFQND
         dYk5p0kjuFiHSH6T1cn7SVaE5Z380ZKwEfrpfhemV0w9q9WDrp/I9uabIqGRpUIFYEpC
         dSKp8YfyidMiwTP7zn+HHHEnHc5TzdeSFoudrj1uXixzzAuCkjMnaTwd3T7GiX0CjKyg
         b140mIhhB19trGIw3ZCMnr99126I8YAUudQGQK4GBhwWE4ZrZycN3YZqNI2QNaUtJN/p
         N8GyutrTFmywcMs+DJ0ovDskNdq5pswwPT63lwO/mHxqTAR5BL/qZoquSY0KiHb9iZ6G
         kigg==
X-Forwarded-Encrypted: i=1; AJvYcCXYkVj/TB6gDPC/mputZ+8c+CjyFOPKmBp8Dpc47Kxg1JhBwe3nR1iGeOwbUYoafi0HD1gPyg46F/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz29GqCL1OtmyAU5s1PPlET4ea7K7YV/BoDngw6pqZtn2y+qHG9
	J5fOJ+rw3kIrrsMDg+hWHkDna5lxUhdI8r5He4UC7YAJv+CvgwnJ5gz39wS0uTu7vudnfxW55jm
	YzFfuJA96+zTCzhzIO6g/RMAICpjFUw221+S0Wjs=
X-Gm-Gg: ASbGncsJiVqdj+thnKwZ3Lf7N0lBQ4+XiwzpYhNqievrtumbQR4G0Zq+MeCFdWuGh5P
	mH/cggbjChu0FW2pXw9AFP927tD8AYiegpS8RP5HS0FJ/AzdEcuHHRpsSqlufaHJAmvOlvEeWna
	TfxyPRw9qXFRan49P5iZomWxwJ8p6F8HNegn3p74Zt+wTN+OxQBPiRtpDkLoDwKRT+o1ePuTv24
	rqiLScmTg==
X-Google-Smtp-Source: AGHT+IH10BTvlGvnHSZ5XhZq+CwcawRFaxcQcwEl2MKrIqvOwb1fJB1VnqXEapaMQZch8GZJV0R5slmfzYh9uZAn46s=
X-Received: by 2002:a17:907:3fa3:b0:ae0:a1c2:262e with SMTP id
 a640c23a62f3a-af9401d8fc4mr968926966b.50.1754311980740; Mon, 04 Aug 2025
 05:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802171539.518747-1-jic23@kernel.org> <CAHp75VfuLcV5Bv1WG3hbRr3P1-kxusN1Gf2dge1mC68cYGfxvw@mail.gmail.com>
 <20250804114819.0000795a@huawei.com>
In-Reply-To: <20250804114819.0000795a@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 14:52:23 +0200
X-Gm-Features: Ac12FXzE--PWtyepZxmrg7YWV6GFk70FII_Q523q_O3haS5hegCh6lXKI-JLIS4
Message-ID: <CAHp75VeH2R28=kVQcVGOZTZ0wGTtHB_1AmhnwVUofcOsT2g8mw@mail.gmail.com>
Subject: Re: [PATCH RFT] iio: Fix core buffer demux failure to account for
 unwanted channels at tail
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Shen Jianping <Jianping.Shen@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 12:48=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Sun, 3 Aug 2025 21:46:50 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 2, 2025 at 7:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:

...

> > > +       /* Walk remaining bits of active_scan_mask */
> > > +       in_ind =3D find_next_bit(indio_dev->active_scan_mask, masklen=
gth,
> > > +                              in_ind + 1);
> > > +       while (in_ind !=3D masklength) {
> >
> > for_each_set_bit_from() ?
>
> Would work but then takes the style away from the code above that this
> effectively duplicates.  I'd need to have a closer look to see if we
> can potentially convert that as well.  I don't want two very different
> looking bits of code effectively doing the same thing under subtly
> different constraints.

I see. But can we have this as a fix followed by the conversion patch
in one series, so we won't forget about that?

> > > +               ret =3D iio_storage_bytes_for_si(indio_dev, in_ind);
> > > +               if (ret < 0)
> > > +                       goto error_clear_mux_table;
> > > +
> > > +               length =3D ret;
> > > +               /* Make sure we are aligned */
> > > +               in_loc =3D roundup(in_loc, length) + length;
> > > +               in_ind =3D find_next_bit(indio_dev->active_scan_mask,
> > > +                                      masklength, in_ind + 1);
> > > +       }


--=20
With Best Regards,
Andy Shevchenko

