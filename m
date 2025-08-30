Return-Path: <linux-iio+bounces-23458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1D3B3CB71
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04BA1BA2B62
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A082866;
	Sat, 30 Aug 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHnFy4Zr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E80A1DE3C7
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756564215; cv=none; b=Ec9PL7G9umkcB2x0LvugDv/gF4p4AR5TRIl6oonPctaIuoJiT2mHBj0EQu2cs7cScNd2GyiBjLkUyQqZqOXowSjuqzShPs9/R7pz1/MQPu4V7hj7BjOgcO4RO6oREYRdN0A2Ihv/WyFdpcXnEb8bxtkFSeG2eF0sk/TJhrZch0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756564215; c=relaxed/simple;
	bh=J38XcYJ/IHKQap1wLuur+OmXLEoyY3BlCo5K3HxoQfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P60O39bbWUmRvhacEG4LMWgR07NH5PMWNFNeiGeCXvlIjOseUs4U4WtDNiMvy/9/N8bBJs5ptyAvARTkJKR4JP3015T8W9B84aecv19vneh6SF+CaK3esOLyOfkAHD0rrJEgSYakX5iUQ29VHhGtNYVeSEwyC9wYV8l1jhkNGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHnFy4Zr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7722c8d2694so1327341b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 07:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756564213; x=1757169013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J38XcYJ/IHKQap1wLuur+OmXLEoyY3BlCo5K3HxoQfk=;
        b=dHnFy4ZrC8y6ZkjxT94e0NdHM5spoYT/DjavOP+3XE6ltETuzH/ApAMdThhaGQPQwe
         aGkd2l5/XnjTkMLocEUGFMFUmDIosz2lXzaK+rHefVw6JD52mh7Qx6y0tmIfD/yQT0GM
         g5Tip1jmwwtn09vYi9IEkaBfeigBPXERVxXmhUorvxuBU/8Edgq8d1mTRz/EsBLcx35H
         V6DySRdDlWsNxaq4IrHAXkuObF7NOT6kw7tRwFD6xXexMctaM5bZKBkW2S/MW++DHTAU
         UOKt5Zt8uxqMyXCUIZ5D/rODTAanTeg11clHD6rKfkesim4SBiex2klkkpX0dtZzc9k6
         5/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756564213; x=1757169013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J38XcYJ/IHKQap1wLuur+OmXLEoyY3BlCo5K3HxoQfk=;
        b=tPHk+AQe8TrmkRwP5cHiqks1NFk93AU21SbiJhb04MfMtm8iBQ2++qppNwcqmqsI/n
         InR2p4G2jPAl+Hz86x/xcYEp2YC2KW5FaoNkZ8rNCAEB91KVHWzm4EzGq08Wn9+avTHi
         YwsKt/LvgLBI/Ut+EB0ndWuVvWa2yObbbl0gZ1NQX8Vq5VqgCLjzK89qKgpbFSb2KDKz
         NY/vJ9agJ6HSzWYGAOQo+CK94SfobmmrGBLQ6VGH/ET5r+7qN8Emuwja4a1W0uXiSyj6
         3AQmrHztQ4lquYenPJQZDiTjYDnaPXPdrMNzkZyutvcN+SWXIx73two2IP0jx9ztMky8
         fPVg==
X-Forwarded-Encrypted: i=1; AJvYcCVz6pRx76/rqtGzEbCzcfQ3RpccMzj78VlIlwgB5Km3sLGcynVCo/HlsNiTcNYwE3u2EJrpIBGljnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBaDU48gu2svSRO1If28pm7Q4SeB+F5PD0I6tNt6n8Z+oPTTJ
	2AoKLwE7QpgNcON0OipcVGfeOoIZvDDh0tebJ58impJMwCXZVOL391F3lFA+2Q9k4QkJ33NsLOo
	ANNrbnlPkGCTpnJOfjLMSVUsyXBMI/Xk=
X-Gm-Gg: ASbGncs6uiDTsnnnqFlmiTPhV8UbSwIYrnI3vJgmbJRfIi2bIishtupq3M/dalMQsrF
	nTooK+30AoRufiniAU2Ttor3lR/2fiDiXj4sVgdqZ3yAy7ATaUBkty5u2kHvHaWSz7YSR2NPtyD
	yPHLMk7pM3zZ0XDzHlfWSq6JDATQMxVJdDh7Z63MVnnulU1bC9WixI5HgIrEoC8UBAwNYiFBgeN
	VJDng8V1u1oK/48
X-Google-Smtp-Source: AGHT+IFHxyKfZcB6gipMdloa1UR5fJBxD8nHa6//xzF9ojtKiPbdscGOEBNsR/eJG1nalwjYZj7Wa/nuHtuwPsmD24M=
X-Received: by 2002:a05:6a20:6a10:b0:243:9cb4:6e4 with SMTP id
 adf61e73a8af0-243d6f41870mr3244054637.48.1756564213474; Sat, 30 Aug 2025
 07:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
 <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
 <CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com>
 <CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com> <CAJE-K+DXRC6A=1Coj-Yun6_Tzd4XGvnqoQPak2xwTJWWosyQ8w@mail.gmail.com>
In-Reply-To: <CAJE-K+DXRC6A=1Coj-Yun6_Tzd4XGvnqoQPak2xwTJWWosyQ8w@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 30 Aug 2025 23:30:02 +0900
X-Gm-Features: Ac12FXzUy_nDFFtGA0-lbsZddt-pZer4ep7TMiRK76ai4cTH_4zWtFXDdtjMRd0
Message-ID: <CAKbEzns_7VVPbE8BjDkYXviEJ2w-5AwJZLm2KNRYfSJx2F9OZw@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 2:29=E2=80=AFPM Sidharth Seela <sidharthseela@gmail=
.com> wrote:
>
> Hey Gyeyoung, thanks for the reply.
> On Fri, Aug 29, 2025 at 9:48=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> =
wrote:
> >
> > Ah, if the commands for z19c are not documented, then maybe it=E2=80=99=
s not
> > ideal to unify them..
> > But for this driver I don=E2=80=99t think we need to be that strict.
> > So IMO we could just add it to the compatible list for now, with a
> > comment noting the uncertainty.
>
> Alright, Would you allow me to send the changes
> on a patch mail.

Yes, if there are no other issues in the patch mail.

> --
> Thanks,
> Sidharth Seela

