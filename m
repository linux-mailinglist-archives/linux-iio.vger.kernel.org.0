Return-Path: <linux-iio+bounces-17714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 079F8A7D206
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13023AC3F2
	for <lists+linux-iio@lfdr.de>; Mon,  7 Apr 2025 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C33212D65;
	Mon,  7 Apr 2025 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4pDApen"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A8212FAA;
	Mon,  7 Apr 2025 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991835; cv=none; b=TpdEVyG13E77WjG9GrX1kAKugHo2DD+Z4vEC5Q9c2Cx0zSZzvkU/m5J/OcMTP5U2ArndfATmSyE/KTdcmEcqSj5+QbyTKUtp8XdhUKew1Ah+mHsOBOwkv5SeLyRIcdBJ6OQ15+P+5JSBYESMDX75eIEc4q1ub9+uGFCtS2SUsD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991835; c=relaxed/simple;
	bh=UTE6lTpG+sn88IvwsvquAO8zwzyh9dyWMhNL25m6ABk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxnIlwMgGHWBMQ5cnZ0g50e0m01rulfY6H1pFRnSiq3tusl4fCVUguKUH4+cJe22fX3SS7E7iNZk95+7ZrDOOtKrvAp+mf5Yt0D72WQuKAlkvcqmUufcTRqZIzwA30AuaO87kGSX2vNePVG/2TVFw0pTkAfffbR4hDLeAvt9N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4pDApen; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff64550991so2931336a91.0;
        Sun, 06 Apr 2025 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743991833; x=1744596633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLg21I9kuEHehzsblhpgkhNBT+xY2lgqUX1zd57OuqA=;
        b=l4pDApenUozs8OIyAiCexC2wlru+cnzocvn+MrRZzGAYkgc7kLJeqBslhQ0ZLeFvDK
         T1NT4p4tKxvvZ8FstugY6jYz6iZcUveX3/fXMrHVXbQ/3MfDWkGlal+CaKMYTme0PDP4
         Bqroe3Tpz7PiPoa/CR7fdrf1qtLkPc8X8iI0TqvqUahk3AoZ/xXdqeYV/JuUfSBgIYNA
         6ay2lSPRrjmxC9g9l47psOyK8pSQBHboW50DoigKJYReTRdgAa6+mA3SKIV4DA2jD5Vr
         fqKblpsY4rmnEiUiKpuvkmvuAa5QBtoGltqXWuzsknBiU1Ph8yHjh0jA0pOqVuyEitr8
         lgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743991833; x=1744596633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLg21I9kuEHehzsblhpgkhNBT+xY2lgqUX1zd57OuqA=;
        b=XQOdceF00Zlb1sO3F2b8mvyHSEVU1Yji1rmir2vbaa510sZDf9OdLi5adlmW16ZUGO
         7H9Te07UBgF2opqpHysSgkaOIr5tng0KRSm2qgnPVzreq0kbgDQIgHUD9ukA5UUEHlZ1
         mpE9L7+iyE6Rjvqprhl6yGidqpq3XrmaTtLBZWrh3IgLWmG/T5W6P9pYk11hs/XKgnlc
         A/NfJLlWjVZtx50qfJXq64OSb50GXBmjy8wd9g9li3X1QVju7wq3uRR4AM+0MSj9QMpd
         NRqyFfqZNCpaQRdXtDI7cclcQDZTrjn18+MsYwwoetP2iXOQMFXjTCOWqcZnc4EFBEvh
         8Q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQcfaH1Bvi+j54epyk3H1MdasCcv7eZVzVfnoMCL1ECgXZgdzSLwGgAbAWSzxAEq8Xp06R3oPkPBHF@vger.kernel.org, AJvYcCXnUyWo0orXUajcYonIzq6+FW9q4aslcmuyryuVM50uH9QXP3sbVegeGXWudPBCHDZ/buV+xvjCurCX@vger.kernel.org
X-Gm-Message-State: AOJu0YzroWJJeY3ILCRIPPA2axnyO8ID4REX54j1ah9JJ4ef0bgl80CH
	aSesR3NB3oOVjYztKtrzaLoEisGA5Hwg4mGWoEX2JuzVUpRattao/zKmAVunEzQpN9SG73lipwB
	nSrsQ37JnuytQ1GvlDqdrAOMGWAc=
X-Gm-Gg: ASbGncueMLuELkpivrQPKF5tFRV/3tfjwfDfjaocaqYxrMLBug/pQXKOnCeYHIjXQG9
	KTZp45VvYqOR9KlGSadyzbq7vWEtLe7NdfG2/oZeP7345iSvMVVaDxqHC47SAjgVGhPalmYbHzW
	xFw9FHb0bYo9o6InVC23UW5V+ywmG7hzwr9OW2
X-Google-Smtp-Source: AGHT+IECTC4w6Yp1LLZaOkHmTErXt57xEJqGeOQ1Hm+U8aELUQnAx5cWOPvPTctDtdkNiDJ4a849i9gFHaDsex3zCag=
X-Received: by 2002:a17:90b:5448:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-306a6176454mr11453897a91.19.1743991833180; Sun, 06 Apr 2025
 19:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-4-gye976@gmail.com>
 <20250404123308.00003d72@huawei.com> <CAKbEznsozpnfFgy3Giamv3XJvf_XqPQ8ZF3TSZHPGfQhm+baFA@mail.gmail.com>
 <20250406122048.3d59c2b5@jic23-huawei> <20250406122628.7511e1b0@jic23-huawei>
 <CAKbEzntnZ+SJ07An+tD3ByrxqOR0FrJ09bymoUZODM0XXjYFQQ@mail.gmail.com> <20250406163338.7457f940@jic23-huawei>
In-Reply-To: <20250406163338.7457f940@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 7 Apr 2025 11:10:21 +0900
X-Gm-Features: ATxdqUHqaP3KLDIg6VFhZDAB6F27ad1syGRNvfCVaMRXMBcc70LJY__FqUimB0U
Message-ID: <CAKbEznuHUbzV_gGSvZssPQo_qSdx-saop7f_vPdrEphsB5gpLg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] ABI: iio: add new ABI doc for mhz19b
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, lars@metafoo.de, gustavograzs@gmail.com, 
	javier.carrasco.cruz@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,


> > > Actually - any idea what the gain is doing?  Is it adjusting a analog
> > > amplfier, or messing with the integration time (I have little idea
> > > how these sensors work!)
> > >
> > sorry, I'm not affiliated with the vendor,
> > so I do not have any information other than the datasheet.
> > And the datasheet doesn't specify any trade-offs related to adjusting t=
he range.
> > (only "=C2=B1 (50ppm+3% reading value)" is here)
> >
> > I think this range setting would be better implemented in
> > some other way (like module parameter) rather than IIO subsystem.
>
> I'm not in general keen on module parameters effecting policy (and noise
> vs range is definitely a policy thing) so I think we would want to figure=
 out
> a suitable sysfs ABI.

Or, how about adding IIO_CHAN_INFO_RANGE to the
iio_chan_info_postfix[] array for range setting?
I think there might be examples of devices that expand the range
without affecting scaling,
like this device (though I haven=E2=80=99t found a case yet...)

If this is a valid approach, would it be okay if I submit a patch for it?

Regards,
Gyeyoung

