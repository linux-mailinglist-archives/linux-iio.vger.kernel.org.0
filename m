Return-Path: <linux-iio+bounces-23107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A90B2FBD4
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 16:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA484A22A4D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91934221572;
	Thu, 21 Aug 2025 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="XgXgIs3r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65731FAC42
	for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755784877; cv=none; b=RGqQDYUoeaRBvhhcdclWW0Q0gaNBP4cfFP1MmtdhW096egV0/o9PlAUL/atdZEoUIgC70L2e6LJgcsdOMkdgjbv97vFbDa6/4jmNehmMm5RlIjaEDa7W4XAp6yQQn6kh4oG1b9VdgKtv4oZ+DhBWUT11xnSJnN5D2orQhIxF+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755784877; c=relaxed/simple;
	bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VA63PkQMnBKlvYaCl0+LAdv/zHQW72BlEQlOOedMYEUVapxpp/+No9uT/DDWNZPbFw99B9PppSCMsE8esqYFCoZl6XGrQjMe1etHdajxfIjYaix5rf2IV4T00CdnrDhVCPhPloqHOrpLtDskPDE0mOGkySXCBTJ7ayUWAbvLdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=XgXgIs3r; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e8704c52b3so111759785a.1
        for <linux-iio@vger.kernel.org>; Thu, 21 Aug 2025 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1755784874; x=1756389674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
        b=XgXgIs3rSk7ivvqz0AUBUWQSQvlGIjosjPnHdlmp+dmsST9NiZN/x7Sa76WfQZq6qN
         UnnYoZUE6kgKoP+garm/j6OBRZZ7jNoyIPRaPZZAWiKNv1FWhmvuiBJvTAEEIFJRzG+y
         e98sXtRCIpXBLlRYvwb33x50ZdgIF8F/a/lWSP5MkFOZRD0xklua0UwJdL7xECLGG1jT
         t8Z1FYmtb9jKFW1yLzni5IaSZ96LfwlLKKA1Yz9KkITByOBgkjhkdHO43JL0MbrFfpBD
         7EAmv5X3ktPlR7UHsGjYiel8EedWJdm9Z9la7IWvZniGx+PZzFpH+q6wFWa85ax3mpU6
         7r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755784874; x=1756389674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uTdTO/nDUx+eAcgds196YVNmXM00r28OyJIQuGSYR4=;
        b=GOhunv1AgVxc713l6OEziUvOuq+urRtZY8zUcCC9nfPD1BWz8Jo3lXw64l9j52ieM3
         yAhj3ki/j6gsZxieE7Pb1tq/KG1SpmemOVX1yreFAaol1FmxhVvdxPq0wrDcraJmnPnj
         gGRzt3ShhZ9nIoRIRPrKcjpCptGpSOs2yqpW29FKSPWYtrXhx2gmR+8G7i9wflgqz8vO
         wLIz17Nke9sFFjz1iXb1V2jouEmaPdQc6oyqosR6Bh9pgpdkHOFOp1Z+jrDLcpSdw89Z
         5e2v7xPM//CUIEdMVtZzSvBzqhykbnrCAjVl70Ggod7a7coP4OVSaDNFUdIvdKPPD1Eg
         vx2g==
X-Forwarded-Encrypted: i=1; AJvYcCXr9IgPL/ep2ODhYyAURt5SY7a3j10bU59Ji5UMMK947nTLKi04cppArWPFJEf2q0k/4WRryg5XvUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHaBZcrWLUiE7qcDw4JkEB4rlgMMvk75odhR65VdVyoPRYdWw
	W8cdM7m6w2IMieQKOcTeQwrgC+BTy5GjBC/bwGqUCvQWOgl3GvIWc7hr4pIUrvJ0P/faCnRFsNF
	5di5O1EO1wgIwhS/k6qbobaQ1iBapIYGF2mvXEWq4
X-Gm-Gg: ASbGncudAxBXOl0Ojtm5fwMOgefb7SI0u5P5FD4mBaIeHtxVZsCyKXQ7UFadV0MsNX9
	Q6FCSnlAK942uVpu3/1WGEV/kIo1NR6CQ0tYXplEPQu4DgR4zZZXX0kOFOQz3NwgIfk3iXz5RoM
	4LUGZS+HnqGMZdpW8Al7US4Iom6dM1Ha5UY2YBMzcCGF5TylFy1ZBHfEu45Wln0zDAPRx/D9dKU
	2ZA6deqqA==
X-Google-Smtp-Source: AGHT+IFrTmd6PZscCgHOXkg/jLaGOEY9AFZjzY8D6UcfbNdWBrcE8ZI5Z+Or0cCq7HQqU9l75OgLwmXGP6qzjQ+iRcI=
X-Received: by 2002:a05:620a:1a23:b0:7e8:137d:3528 with SMTP id
 af79cd13be357-7ea08d86dffmr264808185a.8.1755784872867; Thu, 21 Aug 2025
 07:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821080723.525379-1-zhao.xichao@vivo.com> <20250821080723.525379-8-zhao.xichao@vivo.com>
 <CAKv63usy7FsiUCjrqibcr196kVGb5_FDeU__OwLWJxasb3MgZg@mail.gmail.com> <CAHp75Vd+p1kPPZyrkOsE7EUpCEjd0ii+uHR69EvGNbbDOFuA6w@mail.gmail.com>
In-Reply-To: <CAHp75Vd+p1kPPZyrkOsE7EUpCEjd0ii+uHR69EvGNbbDOFuA6w@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 21 Aug 2025 16:00:35 +0200
X-Gm-Features: Ac12FXzWKQ44hpbQEumVQBTi8x-Bmw7JFWW4iGNpkw6vhDhhAYvMf5d021Ujt-c
Message-ID: <CAKv63usB4zfOUFHy3WCdQn20egsAjrq76AkaQ2KxdAFO0UjOcw@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: temperature: mlx90635: Remove dev_err_probe() if
 error is -ENOMEM
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:MELEXIS MLX90635 DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok, fair enough. (sorry was html message before)

Acked-by: Crt Mori<cmo@melexis.com>

On Thu, 21 Aug 2025 at 14:47, Andy Shevchenko <andy.shevchenko@gmail.com> w=
rote:
>
> On Thu, Aug 21, 2025 at 2:47=E2=80=AFPM Crt Mori <cmo@melexis.com> wrote:
> >
> > I am not sure I agree with this. It provides an error message with
> > reason and I understand we want as few as possible, but this would be
> > a valid remark inside the logs?
>
> How? dev_err_probe() is no-op for ENOMEM.
>
> Also there is an agreement inside the kernel community that ENOMEM
> errors need no log, as if it's the case, we have much bigger issues
> than that.
>
> > On Thu, 21 Aug 2025 at 10:08, Xichao Zhao <zhao.xichao@vivo.com> wrote:
> > >
> > > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > > Therefore, remove the useless call to dev_err_probe(), and just
> > > return the value instead.
>
> With all that said, the series is correct and good to go. I don't see
> obstacles otherwise.
>
> --
> With Best Regards,
> Andy Shevchenko

