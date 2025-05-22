Return-Path: <linux-iio+bounces-19813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928BAC1670
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 00:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEEBA27E7E
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 22:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB7926A0E5;
	Thu, 22 May 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Db2sMen9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB4026A082
	for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951799; cv=none; b=b8VLIybeLG400OS4IvH5Wu/gGHDKhaNywz4udQOdRsK0ZD8tJGLV1+cjwFQZXdrJhJclPWrgBuhALYzcy1S6OPmZsKamrhMFZb0xlXcjP9/42t5iFfuqXQWu7/pAkMy5iT6J/PsXyUth8SZoXGDznX8KrFdh81vCv7AIxtaqQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951799; c=relaxed/simple;
	bh=aGU5joKlmsc4tJLp/ZjJC18En5pCyl2YsaUdNZBEyNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrWxMq5R2ZcLjonVFtcAY1pZx22yCONvCbjB24PWUcOTa68DdX6QdcaCCzlnKOiNCX98WkZJnB/v67qmsRlJyPcJje+NC2cTovH8ro77gNxg8X6vb56YgSnCJRTmg2GTOojy1LrDD56p+jb6YPFTBdzRF6uSoHjunUvAz1TWGkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Db2sMen9; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7d6bedd114so1343353276.0
        for <linux-iio@vger.kernel.org>; Thu, 22 May 2025 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747951796; x=1748556596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ytKn/xAm5fG7iosGiXWkgx37JTIZsw4UDMYhapgMJtk=;
        b=Db2sMen99TP5ZmpVNWKQjy8BAU3klGIs2rEeIQuIX86dBrhgTdEwCDah9avpcYtJcM
         ze4q/parmadmeieF1aHZS9ighx0AAdA8a2eXIkFbyv3tiK2NcPjiwQ3UxPrRrjdWqEXl
         F6v18XyYdW93wPXEhwSfKD+V7ma07cwUiN0FsMl0JmaZMzVO6tncq28OieNwDBVYw44F
         7U4v60Xt0zYMe+WntsL9b2NxFXFPfprf/6eXGU+XJKW/UE9+kECxmXdcMeZDCSCatKqI
         jNQZltJrRqkZNTjZBB0V/Gxv28UEHAlIXlJUrcFbIB0IGPuI6YJwWnz0FK6slem0V6cs
         gfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747951796; x=1748556596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytKn/xAm5fG7iosGiXWkgx37JTIZsw4UDMYhapgMJtk=;
        b=MMWuSh3hV3v98N5uj+o3Fj+QaVr5i+h0nqh3xkwutvrJhyQZ+anViiIuJMg6T4Rwe8
         93SR6H+VFdzq10tekr3pthdz8dzD9AIGC8mgh8qi4f4R5k7D8GNbRJMyWC4Et4je2hdB
         9+U6tCvBTIzE0tNWTcHBNkz/R4ULPr/dE1Hq1Z6PAymeU4S3gt8kFAhavGbuDaPMB1Mk
         mf7YRfQBStrAYjgrrEB6KrxI9t2bRJoKWrw/53Aiu24ogWTamzapIXhMnyEv14VlsQUT
         GSDH0QDvFaxtvbwduQ4P4KvYlQEZioiHqm2GCdOyVR0gOZWtMMNgdveTSlInZMd5dmCu
         DUVw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+xFIKITtQLIw0VSyujBaUjx6Ac1uu7ChBSzHXmm092t3aIOsBGZ/odglk/o8sgBwo2dy9+MNNuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKTG2pGjCtoMV96lolbPPjZS6kJDMj4tYyT40SIt/OgIVdfkm
	c0ObSBApsMUBRYH1X7+tVna8YSWC63e6uB39R2JoJ30Y1h/aiwj/wNiOuGOYmKeS/DgqbkQg6c7
	SD9PP4GpklWltg1pUBxqlP0HehpckVvtuLzFrtYN8Ig==
X-Gm-Gg: ASbGncu+0IIGQa+nJSvmV3paqeDG6wSlVQEkeaDK87G/P1PPAbxUOenpX9zvDtmRWnQ
	alpLf7JgFzF69DiMoIZ0/pkoPZr0dW7X411IFzob4KPPmRMiyg69cv/7oFAR24eQYRqX5/Ge4su
	aDV7YTxQ4GW2qOWp/kbeGJjOl2Yc30ph5ffw==
X-Google-Smtp-Source: AGHT+IGYyJxLMA8/8GOi2bmSkwfU/WISSYVhRusNzbVkFPw+Z4WEurkZHKkq6Z3/hyy3zkRDJ4/v8Z7Q+C1zdP3A248=
X-Received: by 2002:a05:6902:2190:b0:e7d:3b61:e24a with SMTP id
 3f1490d57ef6-e7d3b61e544mr19540272276.32.1747951784370; Thu, 22 May 2025
 15:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev> <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
 <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
 <3b1963ba-f93f-48f2-8fb0-a485dd80ffcb@tuxon.dev> <CAPDyKFqrAS4iV59S-zJ9H7_3VuGr9JdZABhfUGBwTzQNDCasaw@mail.gmail.com>
 <482b55c9-a210-4b2d-8405-e9f30d48a8fd@tuxon.dev> <CAPDyKFpLF2P438GGWSgbXzpT7JNdUjtZ2ZxYf1_4=fNUX3s-KQ@mail.gmail.com>
 <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
In-Reply-To: <4fzotopz57igmiyssgkogfbup6uu7qgza3t53t5qsouegmj7ii@wfiz4g3eiffs>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 May 2025 00:09:08 +0200
X-Gm-Features: AX0GCFugZ72jR4N4Zhb7o7hjSV-HtwPLk02fPFYwEJ3WEVVCfay8AKrTsrcY3DI
Message-ID: <CAPDyKFoxs6wDCLp5EGHVqkqSstBLNmngps2KfanRezV_EN8tuA@mail.gmail.com>
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Jonathan Cameron <jic23@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, bhelgaas@google.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 May 2025 at 20:47, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Thu, May 22, 2025 at 06:28:44PM +0200, Ulf Hansson wrote:
> > On Thu, 22 May 2025 at 16:08, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >
> > > Hi, Ulf,
> > >
> > > On 22.05.2025 14:53, Ulf Hansson wrote:
> > > >
> > > > That said, I think adding a devm_pm_domain_attach() interface would
> > > > make perfect sense. Then we can try to replace
> > > > dev_pm_domain_attach|detach() in bus level code, with just a call to
> > > > devm_pm_domain_attach(). In this way, we should preserve the
> > > > expectation for drivers around devres for PM domains. Even if it would
> > > > change the behaviour for some drivers, it still sounds like the
> > > > correct thing to do in my opinion.
> > >
> > > This looks good to me, as well. I did prototype it on my side and tested on
> > > all my failure cases and it works.
> >
> > That's great! I am happy to help review, if/when you decide to post it.
>
> So you are saying you'd be OK with essentially the following (with
> devm_pm_domain_attach() actually being elsewhere in a real patch and not
> necessarily mimicked by devm_add_action_or_reset()):

Correct!

>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index cfccf3ff36e7..1e017bfa5caf 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1376,6 +1376,27 @@ static int platform_uevent(const struct device *dev, struct kobj_uevent_env *env
>         return 0;
>  }
>
> +
> +static void platform_pm_domain_detach(void *d)
> +{
> +       dev_pm_domain_detach(d, true);
> +}

Well, I would not limit this to the platform bus, even if that is the
most widely used.

Let's add the new generic interface along with
dev_pm_domain_attach|detach* and friends instead.

Then we can convert bus level code (and others), such as the platform
bus to use it, in a step-by-step approach.

> +
> +static int devm_pm_domain_attach(struct device *dev)
> +{
> +       int error;
> +
> +       error = dev_pm_domain_attach(dev, true);
> +       if (error)
> +               return error;
> +
> +       error = devm_add_action_or_reset(dev, platform_pm_domain_detach, dev);
> +       if (error)
> +               return error;
> +
> +       return 0;
> +}
> +
>  static int platform_probe(struct device *_dev)
>  {
>         struct platform_driver *drv = to_platform_driver(_dev->driver);
> @@ -1396,15 +1417,12 @@ static int platform_probe(struct device *_dev)
>         if (ret < 0)
>                 return ret;
>
> -       ret = dev_pm_domain_attach(_dev, true);
> +       ret = devm_pm_domain_attach(_dev);
>         if (ret)
>                 goto out;
>
> -       if (drv->probe) {
> +       if (drv->probe)
>                 ret = drv->probe(dev);
> -               if (ret)
> -                       dev_pm_domain_detach(_dev, true);
> -       }
>
>  out:
>         if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
> @@ -1422,7 +1440,6 @@ static void platform_remove(struct device *_dev)
>
>         if (drv->remove)
>                 drv->remove(dev);
> -       dev_pm_domain_detach(_dev, true);
>  }
>
>  static void platform_shutdown(struct device *_dev)
>
>
> If so, then OK, it will work for me as well. This achieves the
> same behavior as with using devres group. The only difference is that if
> we ever need to extend the platform bus to acquire/release more
> resources they will also have to use devm API and not the regular one.

Sounds reasonable to me! Thanks for a nice discussion!

When it comes to the devm_pm_runtime_enable() API, I think we
seriously should consider removing it. Let me have a closer look at
that.

Kind regards
Uffe

