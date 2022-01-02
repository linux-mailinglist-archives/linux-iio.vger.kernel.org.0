Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E34482C1C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiABQeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 11:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiABQeN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 11:34:13 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48489C061784
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 08:34:13 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e128so37947078iof.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Jan 2022 08:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuJbBOV9KS+DPXgAP7SZAiVv54rXdYxvQCFA9Q3Yh7Y=;
        b=ZgoGoE5/AzAHlQa5hZPjtwXvcaHr/MD5Gp4BzLOeUmmXVGIPnpQ96xJ0FQY+g5QmOB
         LakcXJltuV/ir7NqtqJMY32wmgaUp3qnCIbzqel6zgCj7t/dBva9akdRfjKkPtOOAuV5
         2ChVKvSXDeeRMsH1pUgqJiftnzrMdtSB8/gxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuJbBOV9KS+DPXgAP7SZAiVv54rXdYxvQCFA9Q3Yh7Y=;
        b=yGO60KZvxniCC+6n9sBrZAG/0+QE7CyRxKtTkOMu+O3UoM6Mgz8opSHosFkP0GJi6p
         6B6/HdliLjw5c2LVRT1uDM2+VayKx8+lR76DMd1pSYDN1aM/hA9lldpLTSo0vMCJA4yu
         iPgced37ya3ytamFQ1AjlczdkiuA8+eu6mG6gd6DNAzuxOPif8TKmmM3Em51c5ypXu3m
         FuRWIkIbaqzP8grBHme42FwhTmh298dvaqy5Eoo4jQuUHVxXYnf/dj50Nj4Lle/y3t2/
         /urNSA9AZwmScUW9ft/JHuzR63CLSuTXb+1dldwFZ7P1I5Ormc5sDlM3mrCwt7va1DXF
         nUaA==
X-Gm-Message-State: AOAM531OB23oVsxVAMvykPzCCewy2iM7VgsgWi1vhQyxnA10NOGlNPS6
        GFPs3R+q+2PKihOSsve5mxkO70xCyEfSlCvobgWoqQ==
X-Google-Smtp-Source: ABdhPJxsfVOITi38NVl6nB321pL+oGdiJSuKUzXwAUWoPeBmiAoqsmTKNfWvazIix7btRyfZKbbQnZHZfgedhjkjNtk=
X-Received: by 2002:a05:6602:3422:: with SMTP id n34mr18829326ioz.7.1641141252619;
 Sun, 02 Jan 2022 08:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20220102055333.338456-1-gwendal@chromium.org> <20220102125341.6b4133e0@jic23-huawei>
In-Reply-To: <20220102125341.6b4133e0@jic23-huawei>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sun, 2 Jan 2022 08:34:00 -0800
Message-ID: <CAPUE2utL9YJkBju0CTQJo445qb50Od4xFj0aBksRFAF5PAC2wg@mail.gmail.com>
Subject: Re: [PATCH] drivers/iio: Use SIMPLE_DEV_PM_OPS when possible
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 2, 2022 at 4:48 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat,  1 Jan 2022 21:53:33 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Use SIMPLE_DEV_PM_OPS macro instead of "const struct dev_pm_ops...".
> > Use spatch and sed to fix the drivers. A simple .cocci file is used:
> > @Replacement@
> > identifier operation;
> > expression suspend, resume;
> > @@
> > - const struct dev_pm_ops operation = { SYSTEM_SLEEP_PM_OPS(suspend, resume) };
> > + gg_fc operation = gg_arg(suspend, resume);
> >
> > spatch -sp_file simple.cocci -dir drivers/iio | patch -p 1 -drivers/iio/
> > sed -i 's/gg_fc \(.*\) = gg_arg(/SIMPLE_DEV_PM_OPS(\1, /' \
> > $(git diff --name-only)
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Hi Gwendal,
>
> Rather unfortunate timing.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=1a3c7bb088266fa2db017be299f91f1c1894c857
> is queued up for the merge window.
>
> That changes the way most of these should be done.  I'll be sending out
> a first series covering the CONFIG_PM* ones shortly and have
> patches queued behind those to convert the majority of these.
Looking forward to reviewing these, and applying my nascent cocci-fu
for the missing cases.
Thanks,
Gwendal.
>
> A couple of them will still be possibly worthwhile changing after
> those series (the ones where symbol is exported), but
> I believe the plan is to eventually drop SIMPLE_DEV_PM_OPS()
> once the tree is converted to DEFINE_SIMPLE_DEV_PM_OPS / pm[_sleep]_ptr()
> so introducing more cases may be a bad idea even if they
> temporarily remove some boilerplate.
>
> Thanks,
>
> Jonathan
>
>
> > ---
> >  drivers/iio/adc/palmas_gpadc.c               | 5 +----
> >  drivers/iio/common/ssp_sensors/ssp_dev.c     | 4 +---
> >  drivers/iio/dac/stm32-dac.c                  | 5 ++---
> >  drivers/iio/humidity/hts221_core.c           | 4 +---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +---
> >  drivers/iio/light/cm3232.c                   | 3 +--
> >  drivers/iio/light/cm3605.c                   | 5 +----
> >  drivers/iio/light/st_uvis25_core.c           | 4 +---
> >  drivers/iio/magnetometer/mmc35240.c          | 4 +---
> >  drivers/iio/proximity/sx9310.c               | 4 +---
> >  drivers/iio/proximity/sx9500.c               | 4 +---
> >  11 files changed, 12 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> > index f9c8385c72d3d9..558861bd342279 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -824,10 +824,7 @@ static int palmas_gpadc_resume(struct device *dev)
> >  };
> >  #endif
> >
> > -static const struct dev_pm_ops palmas_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(palmas_gpadc_suspend,
> > -                             palmas_gpadc_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(palmas_pm_ops, palmas_gpadc_suspend, palmas_gpadc_resume);
> >
> >  static const struct of_device_id of_palmas_gpadc_match_tbl[] = {
> >       { .compatible = "ti,palmas-gpadc", },
> > diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> > index 1aee8710003817..4ce08283ca9f1a 100644
> > --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> > +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> > @@ -663,9 +663,7 @@ static int ssp_resume(struct device *dev)
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> >
> > -static const struct dev_pm_ops ssp_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
> >
> >  static struct spi_driver ssp_driver = {
> >       .probe = ssp_probe,
> > diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> > index cd71cc4553a730..c94208a9a6cad6 100644
> > --- a/drivers/iio/dac/stm32-dac.c
> > +++ b/drivers/iio/dac/stm32-dac.c
> > @@ -386,9 +386,8 @@ static int __maybe_unused stm32_dac_suspend(struct device *dev)
> >       return pm_runtime_force_suspend(dev);
> >  }
> >
> > -static const struct dev_pm_ops stm32_dac_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(stm32_dac_suspend, pm_runtime_force_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(stm32_dac_pm_ops, stm32_dac_suspend,
> > +                                    pm_runtime_force_resume);
> >
> >  static const struct of_device_id stm32_dac_of_match[] = {
> >       { .compatible = "st,stm32-dac", },
> > diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
> > index 6a39615b696114..ccba2f253a5b8a 100644
> > --- a/drivers/iio/humidity/hts221_core.c
> > +++ b/drivers/iio/humidity/hts221_core.c
> > @@ -694,9 +694,7 @@ static int __maybe_unused hts221_resume(struct device *dev)
> >       return err;
> >  }
> >
> > -const struct dev_pm_ops hts221_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(hts221_suspend, hts221_resume)
> > -};
> > +SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
> >  EXPORT_SYMBOL(hts221_pm_ops);
> >
> >  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 727b4b6ac69663..10a84b3c7b6889 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2358,9 +2358,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
> >       return err;
> >  }
> >
> > -const struct dev_pm_ops st_lsm6dsx_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
> > -};
> > +SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend, st_lsm6dsx_resume);
> >  EXPORT_SYMBOL(st_lsm6dsx_pm_ops);
> >
> >  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
> > diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> > index 18a410340dc563..7e6aaefe382674 100644
> > --- a/drivers/iio/light/cm3232.c
> > +++ b/drivers/iio/light/cm3232.c
> > @@ -403,8 +403,7 @@ static int cm3232_resume(struct device *dev)
> >       return ret;
> >  }
> >
> > -static const struct dev_pm_ops cm3232_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
> > +static SIMPLE_DEV_PM_OPS(cm3232_pm_ops, cm3232_suspend, cm3232_resume);
> >  #endif
> >
> >  MODULE_DEVICE_TABLE(i2c, cm3232_id);
> > diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
> > index 50d34a98839c0e..7b1d27286ba3b0 100644
> > --- a/drivers/iio/light/cm3605.c
> > +++ b/drivers/iio/light/cm3605.c
> > @@ -303,10 +303,7 @@ static int __maybe_unused cm3605_pm_resume(struct device *dev)
> >       return 0;
> >  }
> >
> > -static const struct dev_pm_ops cm3605_dev_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(cm3605_pm_suspend,
> > -                             cm3605_pm_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(cm3605_dev_pm_ops, cm3605_pm_suspend, cm3605_pm_resume);
> >
> >  static const struct of_device_id cm3605_of_match[] = {
> >       {.compatible = "capella,cm3605"},
> > diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
> > index 41a2ce5a2d5388..997432a0b2dca0 100644
> > --- a/drivers/iio/light/st_uvis25_core.c
> > +++ b/drivers/iio/light/st_uvis25_core.c
> > @@ -346,9 +346,7 @@ static int __maybe_unused st_uvis25_resume(struct device *dev)
> >       return 0;
> >  }
> >
> > -const struct dev_pm_ops st_uvis25_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(st_uvis25_suspend, st_uvis25_resume)
> > -};
> > +SIMPLE_DEV_PM_OPS(st_uvis25_pm_ops, st_uvis25_suspend, st_uvis25_resume);
> >  EXPORT_SYMBOL(st_uvis25_pm_ops);
> >
> >  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>");
> > diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> > index 65f3d1ed0d597f..0a1ada247bfbfd 100644
> > --- a/drivers/iio/magnetometer/mmc35240.c
> > +++ b/drivers/iio/magnetometer/mmc35240.c
> > @@ -550,9 +550,7 @@ static int mmc35240_resume(struct device *dev)
> >  }
> >  #endif
> >
> > -static const struct dev_pm_ops mmc35240_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(mmc35240_pm_ops, mmc35240_suspend, mmc35240_resume);
> >
> >  static const struct of_device_id mmc35240_of_match[] = {
> >       { .compatible = "memsic,mmc35240", },
> > diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> > index a3fdb59b06d220..13b340de40b76b 100644
> > --- a/drivers/iio/proximity/sx9310.c
> > +++ b/drivers/iio/proximity/sx9310.c
> > @@ -1529,9 +1529,7 @@ static int __maybe_unused sx9310_resume(struct device *dev)
> >       return 0;
> >  }
> >
> > -static const struct dev_pm_ops sx9310_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(sx9310_suspend, sx9310_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(sx9310_pm_ops, sx9310_suspend, sx9310_resume);
> >
> >  static const struct acpi_device_id sx9310_acpi_match[] = {
> >       { "STH9310", SX9310_WHOAMI_VALUE },
> > diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> > index 3e4ddb2e8c2bd8..39a32fc5c096d5 100644
> > --- a/drivers/iio/proximity/sx9500.c
> > +++ b/drivers/iio/proximity/sx9500.c
> > @@ -1032,9 +1032,7 @@ static int sx9500_resume(struct device *dev)
> >  }
> >  #endif /* CONFIG_PM_SLEEP */
> >
> > -static const struct dev_pm_ops sx9500_pm_ops = {
> > -     SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
> > -};
> > +static SIMPLE_DEV_PM_OPS(sx9500_pm_ops, sx9500_suspend, sx9500_resume);
> >
> >  static const struct acpi_device_id sx9500_acpi_match[] = {
> >       {"SSX9500", 0},
>
