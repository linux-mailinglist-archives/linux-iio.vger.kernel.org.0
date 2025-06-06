Return-Path: <linux-iio+bounces-20274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44008AD065C
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 18:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868DF3A8109
	for <lists+linux-iio@lfdr.de>; Fri,  6 Jun 2025 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612701DF26E;
	Fri,  6 Jun 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN/v7igt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBBE19D06A;
	Fri,  6 Jun 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749225647; cv=none; b=JQSbAhwkHxIdOmtXyUs0q/NJP2NolcshPPTYkRAVExTd9mafPbIXTdyJde+vivKb9sIZQ68KGWjyOr2avQtv0D12lunt4093QmQcLS3s8sxNWp9cco0F0m6wuMDichj5Wxx6zG6zbgy6uAm3lR1lalBwueiik34aielky8d9GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749225647; c=relaxed/simple;
	bh=0+E08hRwywKhkjx7JnQt4se8cvECsmAoG8+aEI0QaTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+gHVu9XlfDjPuOPCDEXE52RoG6V3UoQ7uPaA5q3TyDJbbGz7jkkNd47EEV1GMXn1+sZcVo3c2rGwtvVR2ksyXxoECv8TqNvLJe7no83ZzlByEC8bA5SmyZIgrpOZqnI69iHX2CjUWoZm2nrJoPQCoIr++Ld070Ql9WT6AlpPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN/v7igt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41F6C4CEF6;
	Fri,  6 Jun 2025 16:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749225646;
	bh=0+E08hRwywKhkjx7JnQt4se8cvECsmAoG8+aEI0QaTw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aN/v7igtpEDVhwIJFRhxmY7E4gZfzp/s4XbROI0iBLJbLV+MylVl6it9hyqNkQiWg
	 Fjol823KWKYUP+c4P4B0Ldc3JaOCL2RUHcG6umTiCiwD2ve0ZNuRuuk8d95c4pOL8j
	 SB9jsu67mvFHyYraWhBQWv33/WRdXBEj5jbsoTy/k2UkluRNhoy55ThC2M8Ahk1SYj
	 5Keo1BaKYkYgjA9TxHzyWPHygXFTR6cOrSnIDaPI1Sb/r0CqrG7JsGjdNCylI1A39/
	 MfWVpv2CReJ8CXeN1A+Q8eZoL17vdRV6eiGMnvaVetJ935abpTNtMIrIpVH6SWp0SB
	 NiUR6Y/fmo7PQ==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4074997ce2bso650153b6e.3;
        Fri, 06 Jun 2025 09:00:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFBI4OuEr0M23yJvo2SH+0HIjiYpOyZvWZl5J0Rnz1NeDSi43/9pYKxC6T25SuFRxzFgwChzseD8iLfCtd@vger.kernel.org, AJvYcCUQQe9pXdosMGvRooK2J3vDWNP86dNnxZLouBEOjHvAP99kFGKxeEEOn0QTh331nDQZPVL/X+hvPuY=@vger.kernel.org, AJvYcCWP1DHMU6+aIdTXD5BcZqBD+x2FhpM0ajgHYM2MckLma8c3ZrbPouipTvv1YpXDGYLnP/+KYakdRAAFESR5Kgzwk+8=@vger.kernel.org, AJvYcCX8GJ1ptLXKF1O4sV1vZeOw10yIBBjB2CbTQrRrxySiwGSKnQ7G4mMhCHwOP4l3sHB10nq7nDAAUS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxsEKcLbCh4dCGqisl3st1LPfBAeZLahvFGp4DTpvW6r9uCgH
	PUeLjT/cFUaKDzHQBu8jKj2gk+lJx0fCiuQ6V3AwUaqUDrrldCLjZzrcXNqtX0KKcowBbsm6S65
	UxSaYHIaBgD2FVVf03Hmk7fVbiddOwm0=
X-Google-Smtp-Source: AGHT+IG+/p8dPlsG+i+bKyi4+OPGxOvAlCFygsy2kq8Yd4lHK8Rtxzkc4gi25tmt3K47CNUiAhq8jyV80f/PLw6impg=
X-Received: by 2002:a05:6808:288f:b0:402:b0f:4ccc with SMTP id
 5614622812f47-409051d725bmr1988228b6e.16.1749225645925; Fri, 06 Jun 2025
 09:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com> <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Jun 2025 18:00:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
X-Gm-Features: AX0GCFuO1uRWb5NWOssOUUfHKn6m_s_TDNlqKwT50_Lx4DRONBgPCZFQvedB7Bs
Message-ID: <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for dev_pm_domain_attach()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	len.brown@intel.com, pavel@kernel.org, ulf.hansson@linaro.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, dmitry.torokhov@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com, 
	geert@linux-m68k.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, fabrizio.castro.jz@renesas.com, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 1:18=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The dev_pm_domain_attach() function is typically used in bus code alongsi=
de
> dev_pm_domain_detach(), often following patterns like:
>
> static int bus_probe(struct device *_dev)
> {
>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
>     struct bus_device *dev =3D to_bus_device(_dev);
>     int ret;
>
>     // ...
>
>     ret =3D dev_pm_domain_attach(_dev, true);
>     if (ret)
>         return ret;
>
>     if (drv->probe)
>         ret =3D drv->probe(dev);
>
>     // ...
> }
>
> static void bus_remove(struct device *_dev)
> {
>     struct bus_driver *drv =3D to_bus_driver(dev->driver);
>     struct bus_device *dev =3D to_bus_device(_dev);
>
>     if (drv->remove)
>         drv->remove(dev);
>     dev_pm_domain_detach(_dev);
> }
>
> When the driver's probe function uses devres-managed resources that depen=
d
> on the power domain state, those resources are released later during
> device_unbind_cleanup().
>
> Releasing devres-managed resources that depend on the power domain state
> after detaching the device from its PM domain can cause failures.
>
> For example, if the driver uses devm_pm_runtime_enable() in its probe
> function, and the device's clocks are managed by the PM domain, then
> during removal the runtime PM is disabled in device_unbind_cleanup() afte=
r
> the clocks have been removed from the PM domain. It may happen that the
> devm_pm_runtime_enable() action causes the device to be runtime-resumed.

Don't use devm_pm_runtime_enable() then.

> If the driver specific runtime PM APIs access registers directly, this
> will lead to accessing device registers without clocks being enabled.
> Similar issues may occur with other devres actions that access device
> registers.
>
> Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() an=
d
> dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
> device is detached from its PM domain in device_unbind_cleanup(), only
> after all driver's devres-managed resources have been release.
>
> For flexibility, the implemented devm_pm_domain_attach() has 2 state
> arguments, one for the domain state on attach, one for the domain state o=
n
> detach.

dev_pm_domain_attach() is not part driver API and I'm not convinced at
all by the arguments above.

Thanks!

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
>   and use a single function devm_pm_domain_detach()
>
> Changes in v2:
> - none; this patch is new
>
>  drivers/base/power/common.c | 50 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  6 +++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 781968a128ff..82ea20b343f5 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -115,6 +115,56 @@ int dev_pm_domain_attach(struct device *dev, bool po=
wer_on)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>
> +/**
> + * devm_pm_domain_detach - devres action for devm_pm_domain_attach() to
> + * detach a device from its domain.
> + * @dev: device to detach.
> + * @res: indicate if the device should be powered off
> + *
> + * This function reverse the actions from devm_pm_domain_attach().
> + * It will be invoked during the remove phase from drivers implicitly.
> + */
> +static void devm_pm_domain_detach(struct device *dev, void *res)
> +{
> +       bool *power_off =3D res;
> +
> +       dev_pm_domain_detach(dev, *power_off);
> +}
> +
> +/**
> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attac=
h()
> + * @dev: Device to attach.
> + * @power_on: Use to indicate whether we should power on the device
> + *            when attaching.
> + *
> + * NOTE: this will also handle calling dev_pm_domain_detach() for
> + * you during remove phase.
> + *
> + * Returns 0 on successfully attached PM domain, or a negative error cod=
e in
> + * case of a failure.
> + */
> +int devm_pm_domain_attach(struct device *dev, bool power_on)
> +{
> +       bool *power_off;
> +       int ret;
> +
> +       power_off =3D devres_alloc(devm_pm_domain_detach, sizeof(*power_o=
ff), GFP_KERNEL);
> +       if (!power_off)
> +               return -ENOMEM;
> +
> +       ret =3D dev_pm_domain_attach(dev, power_on);
> +       if (ret) {
> +               devres_free(power_off);
> +               return ret;
> +       }
> +
> +       *power_off =3D power_on;
> +       devres_add(dev, power_off);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach);
> +
>  /**
>   * dev_pm_domain_attach_by_id - Associate a device with one of its PM do=
mains.
>   * @dev: The device used to lookup the PM domain.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 0b18160901a2..f78b6b4dd734 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -509,6 +509,7 @@ struct device *dev_pm_domain_attach_by_name(struct de=
vice *dev,
>  int dev_pm_domain_attach_list(struct device *dev,
>                               const struct dev_pm_domain_attach_data *dat=
a,
>                               struct dev_pm_domain_list **list);
> +int devm_pm_domain_attach(struct device *dev, bool power_on);
>  int devm_pm_domain_attach_list(struct device *dev,
>                                const struct dev_pm_domain_attach_data *da=
ta,
>                                struct dev_pm_domain_list **list);
> @@ -539,6 +540,11 @@ static inline int dev_pm_domain_attach_list(struct d=
evice *dev,
>         return 0;
>  }
>
> +static inline int devm_pm_domain_attach(struct device *dev, bool power_o=
n)
> +{
> +       return 0;
> +}
> +
>  static inline int devm_pm_domain_attach_list(struct device *dev,
>                                              const struct dev_pm_domain_a=
ttach_data *data,
>                                              struct dev_pm_domain_list **=
list)
> --
> 2.43.0
>

