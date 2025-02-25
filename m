Return-Path: <linux-iio+bounces-16068-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21853A44DDF
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 21:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80DF7A1799
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 20:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AC4212D67;
	Tue, 25 Feb 2025 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV8LbgxD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90164210180;
	Tue, 25 Feb 2025 20:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515743; cv=none; b=k33uoxHTUvh/+vQK953CH5utGw5m7n2MtZ90fITE4mGpZ1e+TekISbRFgUS5fhH8abBh/1G4t/d+asnqzdlaV6wxIM5/k8M+lT7CrEjf9ZY2X9P1AH4VpPPV0toCLvRRViGeFanBzaOuL0oX7w+JkZ3om64Q7rSDNhkZL4XP5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515743; c=relaxed/simple;
	bh=Tz59V4906cizkmnAyLwAF7UMXQmgEg8hAksuM9UAhYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG8MtAx6rSG7hrd3Z3PW5NUMJoe9TxTq1hp5iTC5imvAqnfNr21XZlC31tBm40/5vfZwHHd26r+s7ucgMd+Xx3KAdCHpja+mf9txeHjIW+CCHVkXVur5y0R4QPnAPY5v2MDZGEmmsCFqDnwvj3UK9lQH84jlMzFym6MAlnqrNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV8LbgxD; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52096b4e163so1375009e0c.1;
        Tue, 25 Feb 2025 12:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740515740; x=1741120540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XwywpaYtj2l46Dle33DDpq7qxGEX6r8LCnpx6a8Ja0=;
        b=EV8LbgxDI5EIWVpdT6s4awSLNk+BlGiOgehBJ0hxEzlLgZAnMxPddnHRqRrTQ6k+mk
         vivNg12YYuVIK+XI0ffJX0EZHChx8XvEg17AKg20DzU/ojOeTmZLBqoLqsoP3GDfDJjn
         k9/Y3285EzOTnvQeMQ9tRe+vErbrr+cwtWlwgCbqC/79CfLCruNnvXxCC4aSv4v4wIRw
         ZyB75huYP/42N7mwjtop+MONEJHUHQ2XpoPOMm5MT60ecBHgIXc5fwCvaYKV3XicDmBy
         5TMUbBBTk11BJTknwXmPvJ/uRlu90065cdmUz3ri9dvs1ViJeDbSlXCjlHEj7OkFr/EM
         SYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740515740; x=1741120540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XwywpaYtj2l46Dle33DDpq7qxGEX6r8LCnpx6a8Ja0=;
        b=ho4CtyXB877UNEXPRhqq2wogkn0VV/ATfN+Y5ZQE9W/pLDuzaLj8t4HkhvXQ/v4mFP
         2EWhspQkMcuCGiIyJcXMTxhnqQzY5gQPbN+/AQeLNu0FLhUrpv8im2MmpE4fRN9HIx5Q
         Ptguusrad1VZYo7mCTQ4G5NqPk8TEVsUBayCNja7JaVkruHKtNYM6H7Lt0aONxQTT4y4
         0hbQrFY5Qxy/LNqkD+CRywkKzhQUjzXaTS3QM9qrQnTwx+5lHZ/jBBOnHfwFDKNXEp59
         pzjsVPRsqWCdwcaG+kodeVEN36X3gIvmtVCPVvlidgGTF1bYN84r4/h4SMXbf8Wb2j25
         aM5g==
X-Forwarded-Encrypted: i=1; AJvYcCVLM8P8c+Mn3mdaKlAe3tvYrBTivyfaX6c0cvFB1rHAVjKIBnhNl8WxOt9+oqWi5AK18oKiE0EPP15wZyL4@vger.kernel.org, AJvYcCVPwagQjzqH77C5aP1tBVTCagDlgIBnNi80xOZs5C/Ku5x3MLE+S/UobXHXp0Z/9rEI/i1+Tx+G62t1mS8BZzKcukw=@vger.kernel.org, AJvYcCXuQEsn1/0OUE2b071AhZaarGm0x6SGp8+LnnEd0FANNTJn1ksZBYSgFRK7zd7JiNt1I+IRqDLxGA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+ZN8uVDfSH5lDSBcBEHLuIDRC3ntco9O+is70Er6IKWdsgEO
	WivPmNFZabaQWlO9AxmdPjc5dAQbkwFirNc8DNNawJM9Tjjum1d3t+Txy7ohJ+6GluodQ3QA/zj
	POHQnZGHJH7CNhhR9IBHKmXgyG4Lp4nAFp9A=
X-Gm-Gg: ASbGncu3cwUcDZ//SdFf0iVIlu0YF+j9L2rJ9EPM+TgIxk3eDuM7wZsGoWrWyODh+7B
	FV8HRpptvye+7ZFmXZ/+1DZkR6DGkRywyFo7dR1Xd1/9+Upp+6hQ9vsYRVZjPfuACTuHynsbun5
	ud9f6nWDQ=
X-Google-Smtp-Source: AGHT+IEOg3FN4XhV8eDdeGzHvTE/i8yhURPWnZYtSByTKQHBWCTONJ80ukzBmtui63GXiQHBKHd/9pVKUJn4HYNnCqI=
X-Received: by 2002:a05:6122:3c94:b0:518:791a:3462 with SMTP id
 71dfb90a1353d-521ee45c3e6mr8864926e0c.9.1740515740115; Tue, 25 Feb 2025
 12:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com> <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 25 Feb 2025 20:35:14 +0000
X-Gm-Features: AQ5f1JqEjlRTnX7gXKwgOoeBVHxzXc63ua0nEMVxP_m_ype3EgDDhW-oZn_cCeM
Message-ID: <CA+V-a8s+-ZS-Y7D1FmdKfVoH5i3Ee86KgYQC6QyfdE0ygDMt+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: adc: rzg2l_adc: Open a devres group
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:13=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On all systems where the rzg2l_adc driver is used, the ADC clocks are par=
t
> of a PM domain. The code that implements the PM domains support is in
> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commi=
t
> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> the documentation, instructs genpd to use the PM clk framework while
> powering on/off attached devices.
>
> During probe, the ADC device is attached to the PM domain
> controlling the ADC clocks. Similarly, during removal, the ADC device is
> detached from the PM domain.
>
> The detachment call stack is as follows:
>
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     __device_release_driver() ->
>       device_remove() ->
>         platform_remove() ->
>           dev_pm_domain_detach()
>
> During driver unbind, after the ADC device is detached from its PM domain=
,
> the device_unbind_cleanup() function is called, which subsequently invoke=
s
> devres_release_all(). This function handles devres resource cleanup.
>
> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup proces=
s
> triggers the action or reset function for disabling runtime PM. This
> function is pm_runtime_disable_action(), which leads to the following cal=
l
> stack of interest when called:
>
> pm_runtime_disable_action() ->
>   pm_runtime_dont_use_autosuspend() ->
>     __pm_runtime_use_autosuspend() ->
>       update_autosuspend() ->
>         rpm_idle()
>
> The rpm_idle() function attempts to runtime resume the ADC device. Howeve=
r,
> at the point it is called, the ADC device is no longer part of the PM
> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> APIs directly modifies hardware registers, the
> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> being enabled. This is because the PM domain no longer resumes along with
> the ADC device. As a result, this leads to system aborts.
>
> Open a devres group in the driver probe and release it in the driver
> remove. This ensures the runtime PM is disabled (though the devres group)
> after the rzg2l_adc_remove() finishes its execution avoiding the describe=
d
> scenario.
>
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - open a devres group in probe and release it in remove; the failure
>   path of probe() was also updated to close the devres group
> - dropped Ulf's Rb tag as the patch is different now
> - updated the patch description to match the new approach
>
> Note: a generic approach was proposed in [1] to have this in the platform
> bus itself but wasn't seen acceptable.
>
> [1] https://lore.kernel.org/all/20250215130849.227812-1-claudiu.beznea.uj=
@bp.renesas.com/
>
> Changes in v2:
> - collected Ulf's tag
> - add a comment above pm_runtime_enable() explaining the reason
>   it shouldn't be converted to devres
> - drop devres calls that request IRQ and register IIO device
>   as proposed in the review process: Ulf, I still kept you Rb
>   tag; please let me know otherwise
>
>  drivers/iio/adc/rzg2l_adc.c | 88 ++++++++++++++++++++++++++++---------
>  1 file changed, 67 insertions(+), 21 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 883c167c0670..7db04416e1cf 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -85,6 +85,7 @@ struct rzg2l_adc {
>         struct reset_control *adrstn;
>         const struct rzg2l_adc_data *data;
>         const struct rzg2l_adc_hw_params *hw_params;
> +       void *devres_group_id;
>         struct completion completion;
>         struct mutex lock;
>         u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> @@ -429,60 +430,88 @@ static int rzg2l_adc_probe(struct platform_device *=
pdev)
>         struct device *dev =3D &pdev->dev;
>         struct iio_dev *indio_dev;
>         struct rzg2l_adc *adc;
> +       void *devres_group_id;
>         int ret;
>         int irq;
>
> -       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> -       if (!indio_dev)
> +       /*
> +        * Open a devres group to allow using devm_pm_runtime_enable()
> +        * w/o interfeering with dev_pm_genpd_detach() in the platform bu=
s
> +        * remove. Otherwise, durring repeated unbind/bind operations,
> +        * the ADC may be runtime resumed when it is not part of its powe=
r
> +        * domain, leading to accessing ADC registers without its clocks
> +        * being enabled and its PM domain being turned on.
> +        */
> +       devres_group_id =3D devres_open_group(dev, NULL, GFP_KERNEL);
> +       if (!devres_group_id)
>                 return -ENOMEM;
>
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(*adc));
> +       if (!indio_dev) {
> +               ret =3D -ENOMEM;
> +               goto release_group;
> +       }
> +
>         adc =3D iio_priv(indio_dev);
>
> +       adc->devres_group_id =3D devres_group_id;
>         adc->hw_params =3D device_get_match_data(dev);
> -       if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_M=
AX_CHANNELS)
> -               return -EINVAL;
> +       if (!adc->hw_params || adc->hw_params->num_channels > RZG2L_ADC_M=
AX_CHANNELS) {
> +               ret =3D -EINVAL;
> +               goto release_group;
> +       }
>
>         ret =3D rzg2l_adc_parse_properties(pdev, adc);
>         if (ret)
> -               return ret;
> +               goto release_group;
>
>         mutex_init(&adc->lock);
>
>         adc->base =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(adc->base))
> -               return PTR_ERR(adc->base);
> +       if (IS_ERR(adc->base)) {
> +               ret =3D PTR_ERR(adc->base);
> +               goto release_group;
> +       }
>
>         adc->adrstn =3D devm_reset_control_get_exclusive_deasserted(dev, =
"adrst-n");
> -       if (IS_ERR(adc->adrstn))
> -               return dev_err_probe(dev, PTR_ERR(adc->adrstn),
> -                                    "failed to get/deassert adrst-n\n");
> +       if (IS_ERR(adc->adrstn)) {
> +               ret =3D dev_err_probe(dev, PTR_ERR(adc->adrstn),
> +                                   "failed to get/deassert adrst-n\n");
> +               goto release_group;
> +       }
>
>         adc->presetn =3D devm_reset_control_get_exclusive_deasserted(dev,=
 "presetn");
> -       if (IS_ERR(adc->presetn))
> -               return dev_err_probe(dev, PTR_ERR(adc->presetn),
> -                                    "failed to get/deassert presetn\n");
> +       if (IS_ERR(adc->presetn)) {
> +               ret =3D dev_err_probe(dev, PTR_ERR(adc->presetn),
> +                                   "failed to get/deassert presetn\n");
> +               goto release_group;
> +       }
>
>         pm_runtime_set_autosuspend_delay(dev, 300);
>         pm_runtime_use_autosuspend(dev);
>         ret =3D devm_pm_runtime_enable(dev);
>         if (ret)
> -               return ret;
> +               goto release_group;
>
>         platform_set_drvdata(pdev, indio_dev);
>
>         ret =3D rzg2l_adc_hw_init(dev, adc);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "failed to initialize ADC HW\n");
> +       if (ret) {
> +               ret =3D dev_err_probe(&pdev->dev, ret,
> +                                   "failed to initialize ADC HW\n");
> +               goto release_group;
> +       }
>
>         irq =3D platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> +       if (irq < 0) {
> +               ret =3D irq;
> +               goto release_group;
> +       }
>
>         ret =3D devm_request_irq(dev, irq, rzg2l_adc_isr,
>                                0, dev_name(dev), adc);
>         if (ret < 0)
> -               return ret;
> +               goto release_group;
>
>         init_completion(&adc->completion);
>
> @@ -492,7 +521,23 @@ static int rzg2l_adc_probe(struct platform_device *p=
dev)
>         indio_dev->channels =3D adc->data->channels;
>         indio_dev->num_channels =3D adc->data->num_channels;
>
> -       return devm_iio_device_register(dev, indio_dev);
> +       ret =3D devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               goto release_group;
> +
> +       return 0;
> +
> +release_group:
> +       devres_release_group(dev, devres_group_id);
> +       return ret;
> +}
> +
> +static void rzg2l_adc_remove(struct platform_device *pdev)
> +{
> +       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +       struct rzg2l_adc *adc =3D iio_priv(indio_dev);
> +
> +       devres_release_group(&pdev->dev, adc->devres_group_id);
>  }
>
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params =3D {
> @@ -614,6 +659,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops =3D {
>
>  static struct platform_driver rzg2l_adc_driver =3D {
>         .probe          =3D rzg2l_adc_probe,
> +       .remove         =3D rzg2l_adc_remove,
>         .driver         =3D {
>                 .name           =3D DRIVER_NAME,
>                 .of_match_table =3D rzg2l_adc_match,
> --
> 2.43.0
>
>

