Return-Path: <linux-iio+bounces-23386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8AB3C035
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 18:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC567BF186
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7832E339B;
	Fri, 29 Aug 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyDZmyoy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6EA3A1DB
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483417; cv=none; b=OkV7nK/5eUdZQ0H00IquWS0o7nxaoMxlWZf4gxIEkdLdzKo+iIQgyp94tYIQdpwVkYhyYEskagC6bZFCtSr7W38F50jB5O2tf/8eC8szR1h9p48sBNmG9R9nc5coSvtV5g/eGtgSu0xdR/FzlOV8GlSQEDFW0aLk9Gg+7MhuZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483417; c=relaxed/simple;
	bh=x3z8yAuewT7a1wTvpnL22z8CXN1sKQAB0I+z9J5lhbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLqwFkeJnkECrnXWbWgm1/XxllYp157uT+yuICD+sH3HFAMWP5a9qwcQIs1qnXoHQW//uCXN7UriN1DIyXxQTaZqsxi487YK/7nC+LGtFw4rVDaxqPKqqw429exiqmGY+Nrp/8qyzrZAzcHIlOKc7Z9HC8qEVsG/j7ltbzTr15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyDZmyoy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-327b657924dso1659491a91.0
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756483415; x=1757088215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3z8yAuewT7a1wTvpnL22z8CXN1sKQAB0I+z9J5lhbQ=;
        b=NyDZmyoyeDwrJtXtR4cg9hZ2EhPHHUGBWx13oGTE0UFeiQDM3rUQVk4hc9NUG9Ad/2
         M2s1prF0CypvAAl3pcrVMxB6V6s4v9PvkEZmwe5zNTGCVdRQdY+0tGNefvVGc/Ce8p7e
         8GC7lKe+xU3SpKvBQV7nHfJ0g1qUDJ0sXGhakBT04Di/HZehgMLFLq9cz0CPz1UHe3LI
         xfDHv/INsZb+OhRpwiHe8ESnfqkQQSL4PhPdVRYQVSt0TbPBHhf+ziJOAR+mNwzcDxlv
         XHCDjTj0gs1x6bhLrQAYD7OlKIB96yrsioB5SBOcjXXB2bgPYeQT2PFJHGib5crCLKzf
         RB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483415; x=1757088215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3z8yAuewT7a1wTvpnL22z8CXN1sKQAB0I+z9J5lhbQ=;
        b=jhihdP3QdcMuPgi8CkSI4ZCnqC4vRylKGQJ2Fv106vwrr1u6Pxy3b8OKW2FQ44EU7n
         t8SUsQPODQOcxkfyTPShV8JQz9Fy0Rjg7RTyZBugcSxgZGbq1y8cirs8fp/hq0DrMGvz
         g5BVcE81g2a4De+W55q0BPeQgCuTqaceccqwy4F80v3p4QMjSxIbUGZANcEM470YyzsN
         wWOP6JvgvPG9EA//mSinKUR1W0OeW7PgaTz+QyBwQ1kpynGgh+v0JDRUjK9VE9ln+/e9
         UsM/jVy5eNK5AUBdR2Se1QL7X7zi6mlq1B6Bca/dUW/QiIpWIwS5WM/07fQmk0Cr8EWV
         unlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuXG6zK00jDpcLIsdnamsHB6FMneNqdkk3G0ibczps7lpk6TCILfifYqY1T/jDRcfOC5SffDt3idg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbaw0vb4Faalt64oxTqiwLCOp876XqZKO96H1aWoDKCo92zw6
	ANkJjz8Qywfbc3ZyoFFWSwnuMzL8xYGtaRDd8f79pAGPZXm8WO6EjxCG8aGVZ4DeR+3OoJHe4/l
	KSwXmFKDn/xwueVdzNdM8JtWLb0aom20=
X-Gm-Gg: ASbGncslYsFMFZsrpBJpd8Xg8mCzIq0QuyEFMIOPEyieY4uGZuda21EA7vfk2cogHt9
	2U92Ucb4qBbfQw7IoB1aEBVKrOg0uHo350QpZdgZqSPWOd5xIuGfkEZwk78x6zmaViPhyfgOs/2
	iZcSjsObXAZiv8vuCrcVX1O4H3QMAMhEcMe3x4OZkglXyNALa2vx9Jq+xtf+QBroQTSzNet1mND
	tJSkQ==
X-Google-Smtp-Source: AGHT+IHuD2iC3ZMfvzq9i+FOE4hPdJQz11dLwdEw/oEnE1rYqmACc3cQ5Ap1ndjyOYETrOopmJnEXAoJKz5jTouxb+0=
X-Received: by 2002:a17:90b:1c0b:b0:327:f050:cc6f with SMTP id
 98e67ed59e1d1-327f050d3cemr3144023a91.20.1756483415144; Fri, 29 Aug 2025
 09:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
 <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com> <CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com>
In-Reply-To: <CAJE-K+A1MG1rg1-y15GqWUravy9xsjYgemFhgJpEBEitzM3wzA@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sat, 30 Aug 2025 01:03:23 +0900
X-Gm-Features: Ac12FXxkKxH0spRV1W41RMI70G6seb9cP0gjlA0fkBibzIeFsPZKMgGYmpFxAVY
Message-ID: <CAKbEznu_LH9azd-xF3hizsrqzJm51K-ixi32VNXe93vvR4WrAA@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sidharth,

On Fri, Aug 29, 2025 at 3:58=E2=80=AFAM Sidharth Seela <sidharthseela@gmail=
.com> wrote:
>
> Thank You for your response Gyeyoung,
>
> On Thu, Aug 28, 2025 at 7:18=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com> =
wrote:
> > Yes, that sounds good.
> > As David suggested, using compatible =3D "winsen,mh-z19c",
> > "winsen,mh-z19b" looks simple and appropriate.
>
> But How can we confirm if mh-z19c supports Range settings, Zero-calibrate=
,
> Span-calibrate? which Winsen's documentation skipped.

Ah, if the commands for z19c are not documented, then maybe it=E2=80=99s no=
t
ideal to unify them..
But for this driver I don=E2=80=99t think we need to be that strict.
So IMO we could just add it to the compatible list for now, with a
comment noting the uncertainty.


> I still am worried just about this, all the other specs are almost too si=
milar.
> Would anyone be having a mhz-19c with them to check those 3 commands.
> --
> Thanks,
> Sidharth Seela

--=20
Thanks,
Gyeyoung

