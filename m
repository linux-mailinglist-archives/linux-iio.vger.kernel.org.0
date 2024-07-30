Return-Path: <linux-iio+bounces-8046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7592994095F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 09:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28AC61F25C26
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 07:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3E218FC85;
	Tue, 30 Jul 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bILk69M0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29138B;
	Tue, 30 Jul 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323846; cv=none; b=kvuEaYQiZCY7xMetI9ZxsDyABkDspwjBs5OTpo4F5SnanB/SfeifX5lanblHQkqSXSVcz2WONmP7/zJKsbCQqaqaznQcqy1JzKodBOC6OPv6er+8cnxVYJZUOLNViA7XQcArIIqQj52C+ghFJ5vme4Fdms9T4NazQMwPC4mP0sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323846; c=relaxed/simple;
	bh=XcmupE1Ud6f59uZriwGid5ey5LMkkHhfgGhLIoG5Idw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntXF1J695OPFNxdpjDSO5rMGQIEC8UYMcbiZaDwwlv2vkieGE2qPxk5a5wp6XmZDkgSF70j07jkgQk/Ig4emqmrsqA2VRliwnpDjVY+Epx4S/Rldravo3hVqNRAS5NpI1HaJbslQFg4tZiM/NLL9LN71mfxffuUSMT+NbNFWSDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bILk69M0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f025ab3a7so6645134e87.2;
        Tue, 30 Jul 2024 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722323842; x=1722928642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldS7VLFYx4sIrwzuVLb7MPZlQOq5ka3sCS/nDmd1nds=;
        b=bILk69M0eLTODEt7mT4F1NYtsgMUkgjha1sgSm4mSwyFKCHUoF65BvDbPMjQck6J/2
         hMpluGDOtn3fSXK6GyvTPxei/MjV9WZKBp1VZO19QIT1hR7SIerf3mkIep3u3XRw03kl
         gf3FoI2JTZMMaCvqaYoa3ZfstM7+i+hToZ+wKu1S4ey2hZUa1zAXwp4Ix8XKGdRjYkdQ
         mFTUoolLBL4ZaZ5CndBGUWlyjqiIsF2M/Ff+m+Fu7T1BjEKiBQVdRrh3QcJJzQ+JoAiZ
         KdbQPeUp/W3vWWgeX3y77z8q0EuEVFTEfamiOirJ6ikRTEr4taKBkxmxI3WHmUdQ2++s
         PKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722323842; x=1722928642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldS7VLFYx4sIrwzuVLb7MPZlQOq5ka3sCS/nDmd1nds=;
        b=be8RRgFackFv4rDRqkrkaKTaNzUQEDPF2wdcN4JEi9wcNgm+O2hP3zeJsPce9EDXYq
         hF7uPVsLmkBzl/iBQYAxl7F7s0/NiOIF6Mue0WTeiWG6/qUDY1oKgAHSk+6iip2BJbVL
         UPn6kmkHKL2csfeeml7WD6bFwIVpggfXH7gwYUm2N4vvWydvZj5cTITr8B4wc6vu5eso
         3WBSSZInucYwtFSHfTMMtPa+iTKJBWkvVjfVWwszlNQYBdqymWuzOb/1NWTnYaEKKQE/
         RhcmCMuxz7eWEWkQMUqv5/ID4t49hD7uRfBuNp6gQAEEhYNUrO+MgASmip1jp/qVybU0
         aTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV24KAoYLilofjdEXV9g/ylaCaURzh0xmemiiuTe+0nW0CC4okkbiY+LFq89ZtBSM09uOmpY3rf1VKBwGGx3hA95Rmn920paSFwuxBM
X-Gm-Message-State: AOJu0Yw8siy0BPn4Kb0Ypw8+/iZZ57GW7IXIpOvqThtdAkwLkBi/bs03
	9rfd+PB1z8yfGlYNhQHZmMIeBh8+8WZpQgyZuB/nUuREgnW8T/wyl6bYWi3xPwI+zr9Rn7tgn8d
	pJOwQi9om8nJPSr2SxPM6I5AtfwI=
X-Google-Smtp-Source: AGHT+IFSLjo/Uo/C3SQw84ZGy0FZOtnM+o0dZwZkEpOawt26qeINYI8tlx/Dy51fiV489jiGd5KMZiFBwu4ksttmwww=
X-Received: by 2002:ac2:5bc6:0:b0:52c:8a12:3d3b with SMTP id
 2adb3069b0e04-5309b2e0afemr5307584e87.56.1722323842117; Tue, 30 Jul 2024
 00:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
 <20240729115056.355466-3-abhashkumarjha123@gmail.com> <20240729205329.57390e20@jic23-huawei>
In-Reply-To: <20240729205329.57390e20@jic23-huawei>
From: Abhash jha <abhashkumarjha123@gmail.com>
Date: Tue, 30 Jul 2024 12:47:10 +0530
Message-ID: <CAG=0RqKuhn-WHjMbEqq4bCQOs9ERPKZR_udeCf3noqz+TzULyA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: light: ltr390: Add ALS channel and support
 for gain and resolution
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, anshulusr@gmail.com, lars@metafoo.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:23=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 29 Jul 2024 17:20:54 +0530
> Abhash Jha <abhashkumarjha123@gmail.com> wrote:
>
> > Add new ALS channel and allow reading raw and scale values.
> > Also provide gain and resolution configuration for ALS channel.
> > Add automatic mode switching between the UVS and ALS channel
> > based on which channel is being accessed.
> > The default mode in which the sensor start is ALS mode.
> >
> > Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
> Hi Abhash,
>
> Patch looks good but one quick question.
> Why not present an IIO_LIGHT channel?  Needs to be converted
> to be illuminance (with scale / offset applied) rather than IIO_INTENSITY
> which we use when the frequency response is different from the requiremen=
ts
> to measure Lux (and the units get very vague!)
>
> Looks like what you have here is close, but not quite the right scale
> factor as not including integration time and the mysterious 0.6 on the da=
tasheet.

Yes, I just noticed it now. I will provide the integration time and
0.6 as part of the
scale calculation in the next version.

>
> If we can provide a signal scaled to illuminance that tends to be a lot
> more useful for things like screen brightness control because it should
> be close at least to other light sensors.
>
Hi Jonathan,
It did not occur to me that the IIO_LIGHT channel could be used
directly and hence I
went with the IIO_INTENSITY approach.
Yes we could provide the IIO_LIGHT channel and perform lux calculation
in the driver.
Would that mean forgoing the IIO_INTENSITY channel? Or do we keep both?

Abhash

> Jonathan

