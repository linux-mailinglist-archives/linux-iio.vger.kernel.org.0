Return-Path: <linux-iio+bounces-20721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD7ADB7A9
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 19:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3E23A1738
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 17:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B55E288C15;
	Mon, 16 Jun 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVB2KOSi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0B2BEFE1;
	Mon, 16 Jun 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094052; cv=none; b=GRrYIye+WHa9dzVGJByIIatD2uvzNQFDK/gjiFKlxISJeX41or3SwyIUin2czbhAipaL25EGfyNcqq5BtvpXGgCQ/ucnbicK6BNUK8pzSqb0POKTbhO+oc9FsN51lZXzqb+7v3q9jOve3mGcwn7tPEXYjH+nTzXMH8Fvt8qVFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094052; c=relaxed/simple;
	bh=UwjggO9gJnjfl6+Ixw0I0bYEyFGok+qYdoeeLeS+z8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAQwlskrTwQuJPWZUi69WSkFH53mqvv4/CCP/2anw0ldL6jy5AWnr4BBbJrFLc7TogZhPZMT3oQ/IvU8OX1NQydFTpXYb2NmsxrkkNV68CpwT2kAYXJRsJz1fEqwuc0V+2b0YEoAsjFOCsgwKizMYtyRqRDR6lgFdqMxDENPY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVB2KOSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A775FC4CEED;
	Mon, 16 Jun 2025 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750094051;
	bh=UwjggO9gJnjfl6+Ixw0I0bYEyFGok+qYdoeeLeS+z8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UVB2KOSimzOXfYnK2DRr3Ybka3oheq7ROCKbXhmFgrLmwNKXVLA614nnhOtP6gCB+
	 mFAtxrXm0otuAZ2m4j9NFVmQFDjAijl1VkmIK48MMw2jl2APkRgaONYEvlvIKwxtTE
	 TXEJZzYvos9YuW/VF2u4xVRSYuO9GWrKAmb+DgTdVXdDWGFv4bPm5QGpMjqnAM8BpG
	 uuVua5/nv57MzBWuwBeEktAOxxvWwj/JohPYLG8n7/bgOshDzstyCP8jVHVpa5RctG
	 3RowQkKQIFEh/d6G0eU2eajlcbN8CwnMw+EoY5K1mcjqi7Uw5wJX/zvxoEzyzhHdZk
	 /ITGJv5lNK6Wg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-408d7e2ad03so3135668b6e.1;
        Mon, 16 Jun 2025 10:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3t/fG+cvN/TcZvOqng4+Wv6QXrK6ks9sdEtaFOpasMF+lj5InryyZhIFHP8sFsR6b2mDgn9GOY+73FGJw1071Irg=@vger.kernel.org, AJvYcCVYbSG55lRNxkBmaAOo+ve0U7g0ETDEzS3g6l/MDQEXo/BvYjT/8TT16qmn7wJ+HmezbcbILdI4/d8=@vger.kernel.org, AJvYcCW18bkU9bhL9xGZeS01HS9DLRPmZE5lcpnhbc8yISPDkFztgLdCym+XYE1JtY9jfHEuJglskp73dRw=@vger.kernel.org, AJvYcCXgwzW1yRDpknj6hy1dgcMk1c+RGvb+mnGTO9jg+9wgPJ8fTlVLf1DY/LShXbySBr9nnSGwr8i3eavi+XhC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Rje4MyR6dt1JttrnEDVAnwaeTGXMTmAZbQ6UKI1sI6pdEeUW
	ErF/0sbkPT2K4aBoDi3DqlHeWMVjTvn02+Fd8Cbm2wL31zKAioZziHh7GoSjcqJv3UNtI7JCV79
	v1hP64PeQ78IZ3SYEnSmZsMhiis/D+pY=
X-Google-Smtp-Source: AGHT+IENdHN3S0+/AJ48hd1G5VfOrsAlSi1xyptiND94+qyMdvtUbI3fcqFn659eFO6cyHDU4A3F9NLax2NQGrFUZdg=
X-Received: by 2002:a05:6808:690b:b0:401:cae9:4dc3 with SMTP id
 5614622812f47-40a7c13a8b6mr6692272b6e.8.1750094050962; Mon, 16 Jun 2025
 10:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616135357.3929441-1-claudiu.beznea.uj@bp.renesas.com> <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250616135357.3929441-2-claudiu.beznea.uj@bp.renesas.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 19:14:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
X-Gm-Features: AX0GCFs4MChoTlgVHYwMUsgHoWrzBXwH3xptS7eJ6TN2twbvPobpEJ4Vzj_inP8
Message-ID: <CAJZ5v0j_nm_z4ma2AsRkjiZn-AJ2bK982+Mwa8+_PoUAveNATQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: domains: Detach on device_unbind_cleanup()
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

On Mon, Jun 16, 2025 at 3:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
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
> If the driver specific runtime PM APIs access registers directly, this
> will lead to accessing device registers without clocks being enabled.
> Similar issues may occur with other devres actions that access device
> registers.
>
> Add detach_power_off member to struct dev_pm_info, to be used later in
> device_unbind_cleanup() as the power_off argument for
> dev_pm_domain_detach(). This is a preparatory step toward removing
> dev_pm_domain_detach() calls from bus remove functions. Since the current
> PM domain detach functions (genpd_dev_pm_detach() and acpi_dev_pm_detach(=
))
> already set dev->pm_domain =3D NULL, there should be no issues with bus
> drivers that still call dev_pm_domain_detach() in their remove functions.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - save dev->power.detach_power_off in dev_pm_domain_attach() and use
>   it in device_unbind_cleanup() when detaching
> - adjusted patch description
>
> Changes in v3:
> - dropped devm_pm_domain_detach_off(), devm_pm_domain_detach_on()
>   and use a single function devm_pm_domain_detach()
>
> Changes in v2:
> - none; this patch is new
>
>  drivers/base/dd.c           | 2 ++
>  drivers/base/power/common.c | 3 +++
>  include/linux/pm.h          | 1 +
>  3 files changed, 6 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index b526e0e0f52d..13ab98e033ea 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -25,6 +25,7 @@
>  #include <linux/kthread.h>
>  #include <linux/wait.h>
>  #include <linux/async.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/slab.h>
> @@ -552,6 +553,7 @@ static void device_unbind_cleanup(struct device *dev)
>         dev->dma_range_map =3D NULL;
>         device_set_driver(dev, NULL);
>         dev_set_drvdata(dev, NULL);
> +       dev_pm_domain_detach(dev, dev->power.detach_power_off);
>         if (dev->pm_domain && dev->pm_domain->dismiss)
>                 dev->pm_domain->dismiss(dev);
>         pm_runtime_reinit(dev);
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 781968a128ff..a8f302ed27a5 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -111,6 +111,9 @@ int dev_pm_domain_attach(struct device *dev, bool pow=
er_on)
>         if (!ret)
>                 ret =3D genpd_dev_pm_attach(dev);
>
> +       if (dev->pm_domain)
> +               dev->power.detach_power_off =3D power_on;

I'm assuming that you have checked all of the users of
dev_pm_domain_attach() and verified that the "power off" value is the
same as the "power on" one for all of them.

> +
>         return ret < 0 ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index f0bd8fbae4f2..dcbe2c1ef59b 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -720,6 +720,7 @@ struct dev_pm_info {
>         struct pm_subsys_data   *subsys_data;  /* Owned by the subsystem.=
 */
>         void (*set_latency_tolerance)(struct device *, s32);
>         struct dev_pm_qos       *qos;
> +       bool                    detach_power_off:1;

Please put the new flag under #ifdef CONFIG_PM after memalloc_noio and
comment it as "Owned by the driver core".

Otherwise LGTM.

>  };
>
>  extern int dev_pm_get_subsys_data(struct device *dev);
> --
> 2.43.0
>

