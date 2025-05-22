Return-Path: <linux-iio+bounces-19814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FCAC16A3
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 00:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14CEA27855
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C635270567;
	Thu, 22 May 2025 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b4Kymxef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBE27054F
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952703; cv=none; b=c02+9vho5c3muKbRum7rXvfLj3ZRtTzNXRmtSXADNt2WozYj5pra2aXDrm+lCpYk1qWStMcSK3GIWcNrm/FQvtYQGA8tOF+hPdm74Tixuv7bGluOfnVnVJFrdSZMCW/QJQyJvCl1XhG77HHlq9mbu7xcVxFieKNU3DqDz9WKrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952703; c=relaxed/simple;
	bh=D4gXf7k9CUNciIPNoD2d5KCpK3nE9hEh+TOs0VegVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIVK86pYL5oulrYSWDumMofySDIs7cqUiain3Q0NVnMhFPEypYgCK5lksuMMrJyz+ukocNikERjVy8lpmLDnA4GVVFD2lEOcAsMvztsrTHbAWa11UjmCS95Nq0P6XyWysTMGgwa5K6fb9h742lzOljFOocY9i5ZsTvJqwU2QF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b4Kymxef; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e75668006b9so8847605276.3
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747952700; x=1748557500; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NxvStOnrhhdHpMl3yQwpKdFC4CaZgST0YwPJdz+2jlk=;
        b=b4Kymxefn57MH8NGpFP18ojN00ommkF1eBK+DW+GsA55syu3B7RL0ms+Mn0qy9S/JK
         Xt8FFPO+f0yNhAKj/93ETc2fcUkhKX3G3Gi9CRHxKYBGbfe4rZ29t7R18H6ErwdosM0a
         ZuSah0+5s8b4D7yexmp2KerldTwUYIhEXBAAGSs+cOrNUA1IevUUJMK0Q8aSwr7j8CwF
         E2590UPX34cvDGL/eUDlK8WFJO1Dc1LbI5RaUbn9hDeZS7xEt90DSAhnl1Bl5zrmWr8N
         PQEuHWsiBEhBLxUmo0/NvttidBCuG0sm5lIhSWbmQLqikPgKvk+qr86XRyj7oni/3NFe
         a+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952700; x=1748557500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxvStOnrhhdHpMl3yQwpKdFC4CaZgST0YwPJdz+2jlk=;
        b=MhqzUGge5EsDWFygZUEJV6cUOIZOM3WSNWYl2mZoRw1HrBCrj73GFmn2YuPbRMKZOD
         5Sdkr5u+JjdR7C57atx3EZrN/fENHp0cWvXezbJdju1YhWOjPmiQRcIDA1JJm+1geyxx
         YOy4+WMd9O2ydXiFnJsuqt/kKxgvqR9MI0WpmhVGLCF1PMo8xUzHZZk6zUE7giqoVHKk
         Ux9gjTLhL3cfODjBu920iQxd5qFa7IiY6OptBNImICvi+49S78puOhIrMmc21ex/uwYL
         HKk2dnoBtpqkqYS7uCXC7FGTo0G7tjzAu1WHJIyHPFPNUTBbtnExQ5lOX1PvMeT5Xw8X
         1XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl8ScqmOApb7Jfk4FV2Pjh0+OJR0DEE1V46bXnSgUz/v/wg0tEelkxA4xbkzFT1HbruxdicOISv8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG8rEBOjtyUlrnQsTmy2yS4GSPt94I9P+A25+c48qELqHeybq2
	CxSpM4RmPfk+umDAf+aV0eh0XDpTbMiOFff3jowLvyP1cZo+nZkm43H8Uf/FgyJjdzTpDLGyMqX
	3FnCYiQK8GMJVrSad966h4vGYksLL23FtoHiJ0Hvw6w==
X-Gm-Gg: ASbGncser1GHm45MxU6FtmjWid1nzlvFaVeTJsqUtcc4gL0bN+AwMjUWuBGPB1l1AA9
	vxWRsKfyTHbL6HarLMmklO6Rvi66YAw6+MZWK0sLatTlgUOr5O72dIzhLOYZ8ElXJD+FMduDbKS
	n67xfkPfMeLPLgFfI4jb+eGhbD/7HZkBsetA==
X-Google-Smtp-Source: AGHT+IEo+69w2SsM6WMoVy+VU1iqNjeWOLIwlyMXV18izZtek9qzw2edQkf8SeO0U8a6gS+XaVviMhz0QFnpEijXRvY=
X-Received: by 2002:a05:6902:1247:b0:e7d:702d:9342 with SMTP id
 3f1490d57ef6-e7d7e0a37acmr1367189276.8.1747952700109; Thu, 22 May 2025
 15:25:00 -0700 (PDT)
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
 <CAMuHMdWxeKWJ8hDG=GHngJzGxs_pDe3oGeok38S_PhxQy194RA@mail.gmail.com>
In-Reply-To: <CAMuHMdWxeKWJ8hDG=GHngJzGxs_pDe3oGeok38S_PhxQy194RA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 May 2025 00:24:23 +0200
X-Gm-Features: AX0GCFuXinMJhLA931XICspXqJ6iaQgPA7OkwAdTsyiI_m91Si1IspTyACa7VnU
Message-ID: <CAPDyKFq1iFCan+jB8oSh7z9CRogYWTZPj8x_jbFAu-U93QEMiQ@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 16:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Thu, 22 May 2025 at 13:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 22 May 2025 at 11:48, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > > I may have missed considering things when describing the case 2 (which is
> > > what is proposed by this patch) as I don't have the full picture behind the
> > > dev_pm_domain_detach() call in platform bus remove. If so, please correct me.
> >
> > The dev_pm_domain_attach|detach() calls in bus level code
> > (probe/remove) were added there a long time ago, way before devres was
> > being used like today.
> >
> > Currently we also have devm_pm_domain_attach_list(), which is used
> > when devices have multiple PM domains to attach too. This is *not*
> > called by bus-level code, but by the driver themselves. For these
> > cases, we would not encounter the problems you have been facing with
> > clocks/IRQ-handler, I think - because the devres order is maintained
> > for PM domains too.
> >
> > That said, I think adding a devm_pm_domain_attach() interface would
> > make perfect sense. Then we can try to replace
> > dev_pm_domain_attach|detach() in bus level code, with just a call to
> > devm_pm_domain_attach(). In this way, we should preserve the
> > expectation for drivers around devres for PM domains. Even if it would
> > change the behaviour for some drivers, it still sounds like the
> > correct thing to do in my opinion.
>
> IMO that sounds like going in the wrong direction.  Why would a driver
> need to care if the device it manages is not located in a PM domain,
> located in a single PM domain, or located in multiple PM domains?

Before we added support for multiple PM domains for a device, it was
more or less transparent for drivers. It still is, as long as there
are not multiple PM domains to consider for the device in question.

The problem with making this transparent/common for the multiple PM
domain case too, was in principle that it could not be done flexible
enough from bus level code. It was discussed at conferences and at
LKML, sorry but I don't have the references to those chats at hand.
Anyway, that was the conclusion back when we introduced this around
2018. See the below commits:

82e12d9e0bd5 PM / Domains: Add dev_pm_domain_attach_by_id() to manage
multi PM domains
3c095f32a92b PM / Domains: Add support for multi PM domains per device to genpd

> All of this depends on SoC integration, not on the device that's
> being driven. The nice thing about doing all this in the bus level
> code is that it is abstracted away for the device driver (modulo using
> pm_runtime_*() calls).

Right, I would have been nice, but we couldn't make it work back then.

[...]

Kind regards
Uffe

