Return-Path: <linux-iio+bounces-18220-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD086A923E2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B73419E81C2
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364825523B;
	Thu, 17 Apr 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od3V0Zqu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618524BD00;
	Thu, 17 Apr 2025 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910584; cv=none; b=o5NxyxDUai2hhF7AccIwOQ7URQeAN2Z4yyT83Ck2/PHNWkCyCAVtr7Mbx62RFS+Kuq693aFjvZwUE0TUdVVhFwVl33zkwcKr2qDVPO6pc+AXPxITciqWHJJhfG8iPf3dn0k9i/kJtDnFojanumoPtong0zACpxq99HEW3ptconM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910584; c=relaxed/simple;
	bh=2n4Yhi3NLlYRVnd9ltNUkqu0ipLpa7E/5e7ig9W8q1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTrW6H6RRnt8cIFlKr6w8zgQg9rMKU7j+HsXImjbVHTe2m4+pB8RPWMO2lT8AWg8IoPR2V1ODKID/6MqQ1Y02275bFO82RxwP1RL96aaWfQUsWV4mmiY3TI9NVXhfVnfMKsx/nBx41UhlzaTpdwGg+1LQk/ABC2MVuKkt2L3LpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od3V0Zqu; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47ae894e9b7so4581981cf.3;
        Thu, 17 Apr 2025 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910582; x=1745515382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjbBi+pjpYF6x4ayVnEMHrCSwrafIYoi1gwG/mlXe+w=;
        b=Od3V0ZquDpiQFfJfP4sC6s1xJJq5y72Qvrh+hMBSYsvEomSzQAtNU6VdaMMs9B2u3U
         YVcYC2ANpoOvq+1If6KA2mXQdTQXYo+J+yKCw+xgiF0wuqLK3eNI1rlopxMCvnzWSsCI
         vdvaHAJRhqevQUjJ+tM2xKTc7I9bOEdDcfTaYqsIdczz6xyDJ42mcvamAeoNWtasTZ5x
         nYUcOyzCQ8ehUTjSYcKr2p9MlK3xrLQji1w4qFyG3vVZAdHFRCfv5ngP3IHkF1VtTGv0
         0B9tTyHacvFC5aaUFR6Q6FDLWs91XllsN7bRp9xpYEme53p/9seVqEdc5vW5UIrOTZhN
         wvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910582; x=1745515382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjbBi+pjpYF6x4ayVnEMHrCSwrafIYoi1gwG/mlXe+w=;
        b=FmKI/InmuiiVzVIb2C7xAnOJfpu+Cfuxj1FzJJJBZ3OzXCAd5/q+2mgC8zrxUesA37
         P+3XufcgmbUqjb4gDjxAtgQ0dwT2FfgESnIrIZZ8pXu7fzYR7OrU8/Gz+QenFlgRe+IK
         TEyg+sqkVqZ5yEEx7onHuwJNUoASz8XF2d/IDkKtxJoN2umTuWp8VPj/msDxiQb5SrfP
         2BIU5SkpLXKksUQTb9FqJDtqOySJv8hwQWS2cZZAq25josi6uqzR8jmd3s/3semR+fAX
         N9IC6LRb47yWR1n+jCOsxhSKsskh4f5qianWpg2ecTFohM9G378Yr1sTZ+6ig9XBqU6L
         lrtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdsld4VfjtT3G0JAdkzEE0w+PGbM91cjsBgfkpYLJlJYiYF9NttzVbbpfWpdinj/dhtkCgqBm17/o=@vger.kernel.org, AJvYcCUh95OdKdEM2de/Ez+Nh/apTvn/+VkOhphCeNIrVHHuJbS+AwI5jxXt4zyy0XDejSHDMlrgWZDNRHD8fuIu@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAbeAmjPEcIiqQYIE04Azm1f51S+2mKOgJuidCG0qVY3ZmY2A
	yqruXJZaOC6r/UwMMlHjmBbV40+E5K5OqP+koEplFHAs5bWR5LbgvxdZJai9jStjwfIyACf4uTE
	IiZv0PlqedKmFGXqcBCNiXt0scvAbOiIUmCM=
X-Gm-Gg: ASbGnct39sn85lysXtj1Gn6l26sDDn7VcZUqrTp96/4k84w435O0QXWqHYbVAffxool
	SJ3dGC4n4pPe12H09Fq+CFcL4GdUqLtFnnf9w7lC6jdoIyuUFaNl2m12JuCyvul5BPmNDmELxvs
	rLChrXOcSSdYrHXZ3orQu8KFwrmFAM6UlDnFaqVB4HNhB3P7WWPURMWA==
X-Google-Smtp-Source: AGHT+IH1R432djUArtqSJrov+jLeeKK7G5xyysfPPLkP7YEzAl8zKUnp6HImxKs4Ip+6mwoVVlinZORD3Tm3ypgijEI=
X-Received: by 2002:ac8:5787:0:b0:476:7199:4da1 with SMTP id
 d75a77b69052e-47ad813bbccmr120921701cf.46.1744910582249; Thu, 17 Apr 2025
 10:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417143220.572261-1-gshahrouzi@gmail.com> <cd50b4eb-ef6c-4842-88cd-932042ca2629@baylibre.com>
In-Reply-To: <cd50b4eb-ef6c-4842-88cd-932042ca2629@baylibre.com>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 17 Apr 2025 13:22:51 -0400
X-Gm-Features: ATxdqUFI0LdVPLpa26nw1ypvRkXPxjdqsVqmWuFga-NKkYCZCKf0ZqJW1TcTCp4
Message-ID: <CAKUZ0zJW6ihoNTu_Lecztn7fqci31Q1sb5oJJHcnAw_TxrDFxg@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data documentation
To: David Lechner <dlechner@baylibre.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 12:17=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> On 4/17/25 9:32 AM, Gabriel Shahrouzi wrote:
> > The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
> > master clock (MCLK) frequency rather than relying on a frequency value
> > passed from platform data.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> Please include the driver name in your patch subjects. Otherwise readers =
will
> assume that this is something that affects all IIO frequency drivers. I n=
oticed
> you are doing this on all of the patches you are sending, not just this o=
ne.
Whoops. I thought that would be redundant because the information is
in the git commit body. However, I realized it would be useful for
people quickly glancing over emails to categorize them or get an
initial idea of it solely based on the git commit title. Therefore, it
makes the most sense to be specify the driver to indicate specifically
what the change is being made towards. I'll use this convention for
future patches.

>
>
> [PATCH] iio: frequency: ad9832: Remove unused parameter from data documen=
tation

