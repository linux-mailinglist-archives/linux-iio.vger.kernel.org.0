Return-Path: <linux-iio+bounces-23681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F078B41D08
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E17B3BB244
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 11:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEC12D97B8;
	Wed,  3 Sep 2025 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQOjj9NB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E22ED865;
	Wed,  3 Sep 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898884; cv=none; b=Vbo5pGBY4BzcuMQwfY67DzqRMAmOEJO7D/BlcS0kjuGs9QMB+AdEwwjojEsPV2DmKd6CGT3ZU+LVAcisTAOYXdeS/lcMjE3TqgxAS1VD0V49bSXBdOiJS96CICFr4c4L17HHLWxReZq5jbKgEyJL9GO8Ka3thfbLG58vVkRy7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898884; c=relaxed/simple;
	bh=GIgLcxbwnwSAfiha/MHT7Dx5kHmzzy7HMfYHQgzGioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RttvDQE8IggkTSBtqEG3KVAZ+wfypc/PQw0hqyiPGeB1+ExOcLyurTV5JuYfbqrfC7d52LYFPwk3nySpQc63Y4yzEwz1CyeagVx8BcwY5eKbH/JrDNOv+UJ/26CnHepCmwQBS8jL6y+Z8erkVfUs4nYgb3RPTM5Lc/M0jW6LyB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQOjj9NB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-337cc414358so22517781fa.3;
        Wed, 03 Sep 2025 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756898881; x=1757503681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkaC3Tgxp7Uad3QOUecKH0LKLqCp29o68NQMX+/5KB4=;
        b=IQOjj9NBFTggHzKjkpIGrw3Y6wjhvYUutyXHfM1Lo/MFInk9VtrOq0LKm4ftYvyNnw
         ajB96MHl+zG7j9ihDKeM/wiFx2K/xEIfBsE+fn+21m7OyYo67HWt6mQf/fUCeLbMEmqF
         EgYTVCuuPUp2R6eIsqtdeFeRO7ZwVfasjl4vIl1BuX/MxULtjSNveu+evTW/Xf/NhUPu
         tyaHAOHxhXQ+cTSBQ0YeumVuOdTmzybZ2gMNgI1LJaTf8I8HXkAIfRlITfMSKLueiF3O
         DD9gh9jbUuteMNC91SW3O3dCtHeAU+IgdurqIA/ZUPki3F3gCMbYiraHBTuJaDIDeEEP
         u2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898881; x=1757503681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkaC3Tgxp7Uad3QOUecKH0LKLqCp29o68NQMX+/5KB4=;
        b=Q3n4MRmpeeDEJ9+Pj3rBfKXvaCxGkx3qSWyy4womurwEtfCiMPwzTbu6mgZCS+8vZ6
         PoH+ebBBg9ZOSYyFTlCErOaxuG0Iaklib6v3SuL2kjF1Ozrg1yR72jBqCsKIJqSJSWmf
         HdRbPxd8w0lghnPSHQXl+WrA9B2Ii7jX2Ov2dEQIlHU7gEE46Gage8REhbLXUxRC8ChS
         GeBltnHFJV2YxDMji8xgCHlO/FBBToM6vhMvyeFD7RlIBBLgn/WR417vlcjCDyWp/ZY+
         kHVV4HoIaXuyxdKDJGBQqzus+yOE9HNkvvxJUiQRnAv0hK3ddNTo+mtv+gIE2CJIgbtc
         Q/1w==
X-Forwarded-Encrypted: i=1; AJvYcCX9GnB/sxF9omwtB01l+SJdc5zJDFicQHJYiyk2E0I4gnNoZlBVXi+ubfjUBzQztqNRNUJDHp5BtJiqRcNT@vger.kernel.org, AJvYcCXWrF/hFLBA4iMxK3PnIdYJm6YE9NZA/kbC+Rc0c1bZC+IxvZUNKs5XkNAjvo/i/O8O5SF6RFjClEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlX4OEKvUu7vpc8H/Krm/GAELowbLuJM8+nda8AyvBPPfzkmEq
	23mEj/A37WO877HSLLE3xUKgA6qiOPWV0FoR+PLY3coy8V1PKwGGLAFdzHMWA9BFMFCO/PXjBLa
	Dm0AlQWnV6/5pM+mYt504Sq2ah/KlISh3RA==
X-Gm-Gg: ASbGncuwzo3iXFUOSZi1l3GZTwyPXqLIzlnENfdqXj9lqZD7vcppJCK9C4ULOrqpUR5
	5zxQ4vS8Fst088UEsIBMLzBz9U62yAi77metzXz+mJTuH6VNNX9t8aUcpnFNKpVAUGmYdT04F8w
	oq+P7HvdNq/2QrMWy22xpDTHQfS5U7ff5dc46LBYQcdn+DJXk96V75Xy6qGHWnf2v+KyQN+Yvp7
	l4ZWAnDr/m2tRZyIZxNvZ49ruYhN8VJcXK6Ipf/6w==
X-Google-Smtp-Source: AGHT+IEr0NToOeBxlCXC2s0xh9HSrVbrah+k5D6njQOIdyzoTgbJRk2tTZe5eOImrZ+ZbjUzm494DvKVPv1TDlvc8XA=
X-Received: by 2002:a05:651c:23c5:20b0:32c:ab57:126b with SMTP id
 38308e7fff4ca-336ca9a301emr38550331fa.16.1756898880338; Wed, 03 Sep 2025
 04:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901184238.34335-1-akshayaj.lkd@gmail.com>
 <aLbptFRh9ZvAVfLn@smile.fi.intel.com> <CAE3SzaTnNckFDRMDqGPDAg471bRskJ=_n5C_qSLKQeq3F-Lu_g@mail.gmail.com>
 <aLgacK0MMojkaKuW@smile.fi.intel.com>
In-Reply-To: <aLgacK0MMojkaKuW@smile.fi.intel.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 3 Sep 2025 16:57:47 +0530
X-Gm-Features: Ac12FXxZHHXOy9Lc0rzCA0LWoq6-Au1BdNgrOi54YuPc4lWSauKg9-QRh-ZShnE
Message-ID: <CAE3SzaQCjoin+ToiD7iS9ev-v37H45gBkFmbXNcskET1m8rrgg@mail.gmail.com>
Subject: Re: [PATCH v4] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 09:15:53AM +0530, Akshay Jindal wrote:
> > On Tue, Sep 2, 2025 at 6:27=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Tue, Sep 02, 2025 at 12:12:36AM +0530, Akshay Jindal wrote:
>
> ...
>
> > > >       /* Ensure that power off and interrupts are disabled */
> > > > -     if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > > > -                             LTR390_LS_INT_EN) < 0)
> > > > -             dev_err(&data->client->dev, "failed to disable interr=
upts\n");
> > > > +     if (data->irq_enabled) {
> > > > +             if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > > > +                                     LTR390_LS_INT_EN) < 0)
> > >
> > > Wrong indentation, hard to read line, either one line, or do better.
> > > Actually why not assign it to ret? The above not only simple style is=
sue,
> > > but also makes readability much harder as the semantics of '0' is
> > > completely hidden. This style is discouraged.
> > Earlier did not use ret here, because powerdown function is of type voi=
d.
> > But if readability is the issue, I have used ret.
> >
> > Regarding clubbing into 1 line, I have my reservations there. I think w=
e
> > should not violate the 80 char line limit.
>
> Shouldn't !=3D mustn't, esp. when it's about readability.
Ok, made the changes.
>
> > Also since the line is already 1-level indented (begins at 9th column, =
due to
> > if(data->irq_enabled) check), the spillover will be too much. The reada=
bility
> > does not seem to be taking a substantial hit here. Let me know if this =
is
> > non-negotiable for you. Will happily make the changes.
>
>                 ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG, L=
TR390_LS_INT_EN);
>
> only 88 characters. One can make it shorter, yes
>
>         struct regmap *map =3D data->regmap;
>
>                 ret =3D regmap_clear_bits(map, LTR390_INT_CFG, LTR390_LS_=
INT_EN);
>
>
> 79 characters.
>
Sent a v5. Kindly review.

Thanks,
Akshay

