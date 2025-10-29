Return-Path: <linux-iio+bounces-25611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F4BC19FD4
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 12:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DECD357BEC
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 11:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3D32C93B;
	Wed, 29 Oct 2025 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxt7xc37"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22E419995E
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736937; cv=none; b=WA8G3RwsI6UuK1W3d6cQsL66GWcP9SO9TpGqKg0ySLtZKdTCKaEZDoPgfrpuu32VFiBHQHw5ZZmIBaOGNAj+s1u6ZlM6C/9xC2RQ/LoDyx52OJBox/NYpz7caKy/1xYUQ6513jgiFcqIr3jyOZVnWw2vSRf0ALU4VN3RFVgSbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736937; c=relaxed/simple;
	bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfkZCrHeVHJY8znvEFiKeVqvX/H81dyEfNFe7BsX8tO0A2bkDsiaBssIumlDIOgpi+TTqUscNn7bqn49UMq3oUOU7v6FOw9e4AMb6PhgEVa59ztsZa+yjhfDuA809lUVCWyu1JE0QlpXcHVYcYgeJsOxFly0S3I+4vM86FA/d2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxt7xc37; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f600acb3so3852430e87.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736933; x=1762341733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
        b=dxt7xc376bmsPY89zw356rMpGf4Vyp0Axzh+cK6h/NKDJpjxbfQxwtd+sg40RTRd9Z
         Wh9y8IOvu79rKshKWXK/QkzdYlJK2Ducb8646aR4zb1CQqp2bkKFnf7toFACkhUB+7sT
         b8gF1a0ehaGjU4qh1wHX3MZ/pbBaMQ9S7fQXwmaj/gwZx0iC7j/AQVA0tSdHZiV+b/q5
         pAidlLMkSmAVPJQFSxWGa2KynKvd1C3Hhan+Fk2fYLImQvfxkduOggdyzxjVu12dFX+3
         u2ZNEkb5Z4Mr5QMRCvvuDAwsVuBm4eJYiZXdUqfuauxAf9i/cX7b52flY386SnyKeLLb
         VZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736933; x=1762341733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDUtqO8PePY47rqraTgqQcnx+NDx1LFP7gvDlG+r7fU=;
        b=Xrct080pVZbFk93Ex3Vl1oenXLt5glJATQWCW5N9MOSiGKtqaXJ6eG+Icv0+v6rUpW
         DQurWUWx1ryNB54ifKsEb0fve2dMpoYd/Z1gHWd7ZehZi5rlNyasswnWG/dAKyUp9zR8
         LTK/5vhZ5xjUHkeOH35KqD/PLeooHprY2oxO88NWOf6dfatOBM9KE085lMYCwwv7fAPP
         2kYlU0p1oVVHPeqqqmM3ioVhbT6ajIpnCwfx7IVk+oqgyWcUiIvEpPmqliexpjmnYq4/
         6X9AOA3JaG87fHD5DG9INyORXT8PJwUcyUV6rz7NH4ntOpxKuEEuf3Xc1EGKnnVnLIdl
         7Uvg==
X-Forwarded-Encrypted: i=1; AJvYcCXXI3WPv2Q+W8aVabeWItme5NjASeLQ7XOprRuT340PvCkv5DlPSkC4IqMTzCCTlI3nYGqiwt2XE8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXPyzuvSFxUBoyxOzD3idDODUhpA15dBZnHNHPLKeSgGZ1WuL
	dAUbNh/laREfny/okA3JLnlPmcgCAiv+twIeFs8zsxXxVx97zBdHe1RkV6lsP8JpNHpIg8fpN0T
	7C6nfmmInCNyMaPk3W6tQmq4JzHE5c5U=
X-Gm-Gg: ASbGncupP5xKdnuVplJe4P9PhRtgiZfYpUijB8bAAD7hXQW45mwfie+1yQVlXd2Eroj
	qtoMYO70APolnJ+N85xI4ffxVQa0udoNw7jHLzR38PjeGyly3CzOultE3kD+15wLdib/cwarXIg
	/Shf/U5Od/TA4CLd2RyecnWRVBbA/8GUm2hQva4roHwXeqKz2yUuvDM0VEOzxcv1aYxhEmM378k
	fs9kNSjoV1w1ykLzMglGIAjxTbJydrWt+i6/O3+pHVukXCBgRHsAiVeanLPmw5fWFqz91j+54Z1
	YpK7pkHHOCLTcVYnfEGOXU2Y3+gkoEleytadDQ==
X-Google-Smtp-Source: AGHT+IHc4LI3CCYCeXedzWEMPrCQwraenU/iOkhCterIRDyKhtcKSuDxLJCCmfvBj668P02zxck5F1RCdCRawh/y0mQ=
X-Received: by 2002:a05:6512:6c9:b0:560:8b86:75d9 with SMTP id
 2adb3069b0e04-59412a3d1femr855771e87.14.1761736932471; Wed, 29 Oct 2025
 04:22:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029075117.104758-1-hsukrut3@gmail.com> <aQHMvdQXD4eRvPSV@smile.fi.intel.com>
In-Reply-To: <aQHMvdQXD4eRvPSV@smile.fi.intel.com>
From: sukrut heroorkar <hsukrut3@gmail.com>
Date: Wed, 29 Oct 2025 16:52:00 +0530
X-Gm-Features: AWmQ_blOcs28nOwA4mRzZbzsddmE8hj5NWFZNo5p4Pwmd7EkxFCZpTsV9vvv3Oc
Message-ID: <CAHCkknoUyV3erQa2QJUY_MzPXuybQMv1neXJQJsZFS8epsyBiA@mail.gmail.com>
Subject: Re: [PATCH] iio: backend: document @chan in iio_backend_oversampling_ratio_set
 kernel-doc comment
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Pop Ioan Daniel <pop.ioan-daniel@analog.com>, 
	"open list:IIO BACKEND FRAMEWORK" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	shuah@kernel.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 1:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 01:21:16PM +0530, Sukrut Heroorkar wrote:
> > Buidling with W=3D1 reports:
> > Warning: drivers/iio/industrialio-backend.c:727 function parameter 'cha=
n'
> > not described in 'iio_backend_oversampling_ratio_set'
> >
> > The @chan parameter was added when iio_backend_oversampling_ratio_set()=
 was
> > updated so the contexts could specify the channel, but the parameter wa=
s
> > never documented. Document @chan to silence this warning.
>
> There is already more comprehensive patch available:
> https://lore.kernel.org/linux-iio/20251028093326.1087660-1-kriish.sharma2=
006@gmail.com/
Thanks for the update, Andy.
Regards,
Sukurt Heroorkar
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

