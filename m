Return-Path: <linux-iio+bounces-19805-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E722AC0F0B
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606961627E5
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151B28DEFD;
	Thu, 22 May 2025 14:56:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD228D8E7;
	Thu, 22 May 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925770; cv=none; b=IbYmAvI6qTfD+9yIp6D9Ju6GlG7Kk6NJbMeDX8WZ6ktfE4JJ/vOc5afMy+QQCVXOpEBkfHg1adtJJ+tAgoptJ0w8xmZFFV/AaKUF2+ZZA6nf2FIl8akpPrvw06mQwF2JoSn/gyRQU6E063VvMIIriIIDz30ru+JDB/qqcO8XYi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925770; c=relaxed/simple;
	bh=NYJvjVyWZ5DTqLy2C2F52WrdMf9IXrohyaEHnqRLQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdywHPO+r3lKVxE2tgL3uyfUPcVj2YBiwtiYJGp31ekszgGwS5MR8PY3wvTzHJVZo0SoseBMzqnFyyckCXmQvaH+I3r55uPppK7s+X3/15O3/jqZ5xM03qMVRBY5wZYD51+l/iDo8MxEMw0O46ihfxFV6j5vtsNjMMJSeOf2Jto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-87bfa88c10eso1301064241.1;
        Thu, 22 May 2025 07:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925766; x=1748530566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oP0j9pV17FFkWZ8R/alfKDNyj6fTbmxsIhF06TlHwMU=;
        b=SBcF0lAnB5mAS8D3UtO6gkf2Ndrhl6n631ITP7ccKrNFQrbMbqDHo1Y7R3atbc9AtY
         /Rx7sLOegPochiKctbsga0pcertLFJmJOFP5wwlmbZBxaOmUJJu9/33HmOnwb3xksQYL
         nm1Jqw2bdBZtEU3aX+1aU2iTEwf5hjm4XCqhFs2eji9jibfeHncyzND+FrlArNLCbgkm
         anT1TUfLCcBpqJU/pf73+tuSKEkBee0rLVWxuluGGYv0uyrhm9ZQuj2cNngIPepwfmMi
         TVPoLiPbFR8OXc5wZxrArTeli35Ac9zT2e13su/8MiQMqBuA03x00ghAtNe8f9anEitB
         nX2g==
X-Forwarded-Encrypted: i=1; AJvYcCW/daMz6r/hS96sv9rOWBP6L4rWlwwQZy5VFn1Yywqc9BF38W/zv7qjzSD7vp3Y9YZxJbRGYQWvC4Q=@vger.kernel.org, AJvYcCWT5JKSxgaGmQOHQPi91JlipUpKe4W7GNdiPJHORwsFxT5VgtmgtOwr+NvHa0gB32LBRSA0Z9PpMNouL7Us@vger.kernel.org, AJvYcCWnst9VAyl6sjrMNzJxraihhxGG5G8YaXlvGSC9v4iJluNAZ3KTu75Ply4KQcw3PMmj+KrkFzqTFKc=@vger.kernel.org, AJvYcCWwCrjEEKCIPLCg4xmmH8E6F54yETC45zaNMWU+ZSigyacwkTLbLHesiBFXPmkeVbL8mDn0Iun2QmJOznMX/g1Yc2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnYDSTD2uzxSN+CazKCKcCmqDtBC202KPotQcMxR/eRn/oX5S
	LBqSbeEvtQl+1Iy8IemLw0xfKVEtZxFB7A7euP/IDUCahr8SQ2JKyqdPXIorjG5H
X-Gm-Gg: ASbGncv27O+bI3gPYyMW7i4y3RnmHf/5qwH55Zssxxc/s8eWK3e/WI8mV9CsAAoW41Z
	r9h+DspX7jbk0lblrzgjC3Zz6eTZegJqk4ZudR5KU5ZY35AugE3bV5hWxrbaB4qhRXNJK+m7iNd
	m4FlmvBMXFBZtjCj1jzCacXq9tdIW0H5o0WDNW2iwdmgL6YoI7f0thiGCUaibqctY+HDZWmpwxx
	ZTQZ3ZbWOvh9/iKEkGw0QvcKwu3fkkmboSX/pSmk/HPNXLUaQUVDxp6gfkHx9lK9Qiki8k1lmCJ
	FnyvAZwzr7gyp7F12WGO1z+L++0Fu3pyy1PxNHccTy7lJ1s51A2kf9aNpQgWMX1/zLVg+J/VEtZ
	nrisW8oPzj/IUJw==
X-Google-Smtp-Source: AGHT+IGYpNMsrIUNBsUmeANyljSIDMmEsBns73FKku4rNKRR1m/zl4iySNcwtuiXac4qw6AACHzteg==
X-Received: by 2002:a05:6102:2049:b0:4e2:83db:82cd with SMTP id ada2fe7eead31-4e283db82e4mr11771982137.15.1747925766455;
        Thu, 22 May 2025 07:56:06 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec22768fsm10461643241.30.2025.05.22.07.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 07:56:06 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so2059121241.2;
        Thu, 22 May 2025 07:56:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkKl9IHkm/yOplPTgMydYj5alVRr2j3Wbq3Y6LNJc901wA4qSPZ/DGK7DS8CD1AC6ihjbVnUsk0uc=@vger.kernel.org, AJvYcCVlJJIHbJqbZDIcbtgqaoN7b+WRJ4+ApIUwNfMPFSHECRTSTG9xSq8o8b2BzwzjiWo6DfYdEisYxIk=@vger.kernel.org, AJvYcCVo8NpOMowE5GnGxbdaSlKRBKJ93QB086DFPXWJipRP4lsm2ojso9CXTF3xyHfW8dJjFiUjI++PZxLV5szteFqCTJE=@vger.kernel.org, AJvYcCWJn5vC07Z19AUXZFD2Y/zF+Ki6ASYGIuPjNaRv4298UjxOYPG+DrOsvuB8JSXkwC0emhwiOsUBEfzy32CH@vger.kernel.org
X-Received: by 2002:a05:6102:50a4:b0:4bc:82f:b4e0 with SMTP id
 ada2fe7eead31-4dfa6c4654bmr23423017137.22.1747925765571; Thu, 22 May 2025
 07:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330163129.02f24afb@jic23-huawei> <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev> <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev> <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev> <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev> <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
In-Reply-To: <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 May 2025 16:55:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxeKWJ8hDG=GHngJzGxs_pDe3oGeok38S_PhxQy194RA@mail.gmail.com>
X-Gm-Features: AX0GCFscAejGATVLf32FZ3zb7da-a_NFq9dpjeQEYvH9yG-Iw_s5Pnys5J7LY1I
Message-ID: <CAMuHMdWxeKWJ8hDG=GHngJzGxs_pDe3oGeok38S_PhxQy194RA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Thu, 22 May 2025 at 13:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 22 May 2025 at 11:48, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > I may have missed considering things when describing the case 2 (which is
> > what is proposed by this patch) as I don't have the full picture behind the
> > dev_pm_domain_detach() call in platform bus remove. If so, please correct me.
>
> The dev_pm_domain_attach|detach() calls in bus level code
> (probe/remove) were added there a long time ago, way before devres was
> being used like today.
>
> Currently we also have devm_pm_domain_attach_list(), which is used
> when devices have multiple PM domains to attach too. This is *not*
> called by bus-level code, but by the driver themselves. For these
> cases, we would not encounter the problems you have been facing with
> clocks/IRQ-handler, I think - because the devres order is maintained
> for PM domains too.
>
> That said, I think adding a devm_pm_domain_attach() interface would
> make perfect sense. Then we can try to replace
> dev_pm_domain_attach|detach() in bus level code, with just a call to
> devm_pm_domain_attach(). In this way, we should preserve the
> expectation for drivers around devres for PM domains. Even if it would
> change the behaviour for some drivers, it still sounds like the
> correct thing to do in my opinion.

IMO that sounds like going in the wrong direction.  Why would a driver
need to care if the device it manages is not located in a PM domain,
located in a single PM domain, or located in multiple PM domains?
All of this depends on SoC integration, not on the device that's
being driven. The nice thing about doing all this in the bus level
code is that it is abstracted away for the device driver (modulo using
pm_runtime_*() calls).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

