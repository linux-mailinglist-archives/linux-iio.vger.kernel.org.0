Return-Path: <linux-iio+bounces-24008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479E6B54264
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 08:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC471C21F0D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Sep 2025 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F027F018;
	Fri, 12 Sep 2025 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfvFOTCs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747427B34C
	for <linux-iio@vger.kernel.org>; Fri, 12 Sep 2025 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757656846; cv=none; b=WSB25/WYbGRkpTowYnkRJObOBofaxUCzR/ShjcEH8u8g4oRQyEuWuuPe6g+IqKjtce+eacPuW6zj2Mw4F3n8SpcSpf2DMTYXsAW6lLZ/U0FtDVbrklUKadgZNDuhTPRQn7eszuYKKOHsjF1Kt1cHt02zbIEIMkTK7/GQI/Dipmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757656846; c=relaxed/simple;
	bh=T2bclAseuQSaTyTUuAEtHsQpafXWJetTyW2yE/g9tFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDDpOpVDcmUD9avJT7DJuWU3Wdt4ik7vU+18LfKaKehImG67nGdkhhcA4iWLY+/1XR0bBtHrwCw/TwH4R55J+MdCwFCU9Jq3OjzJN17dV2enrVaKw2vwqHengRB2xvzQdvUx+zuXlGhnNAInePHRrS6YXc5II/tJ94mYl+U0wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfvFOTCs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b00a9989633so298626366b.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Sep 2025 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757656843; x=1758261643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnGLwWMBilL2q3hiy/YDybe9rUMlj5Tpu97SvBLxnSo=;
        b=dfvFOTCsobBi3asx/oA17ovbkKSUqRA/ht5zs0nN8WNEt3UWm7pVz4jRud8pteLTxb
         GpHZYcmnbfcyeDDBaSlw0ipkDPZ3eb9g18MtefENsE0JLJLmSeuF6m1qnJ2w823U79Th
         g/l1zeD90VY4Nqplp8fIY+G7B/IuRudbnatN2LUw9ZQy2kJz2O3M+quYwGPa86TKlfFB
         khVhepk9GetEBq+d/GlyWYRA64T68eb+ndvfwPCWX0FvcLT9e7L7ieSL60mZMt4oQM9g
         Ass6NUibxJdbVR3v/w6E6AjE7kiJtIzPqEuIYKArRrv5pyPQZvZrEPfuSpdJmqAGGicU
         Z0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757656843; x=1758261643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnGLwWMBilL2q3hiy/YDybe9rUMlj5Tpu97SvBLxnSo=;
        b=GVFwmSLXqWNpGN+WdoN+YlnmQCYoYEojbOVPUuoo8rj3vAsij9TCg5l6FFQgWQD8Tu
         /wPuolinqX+tLfNT9Rz11dMhewgjTxsJQyVxG+moakLWk1yJRbZ5AhidOsyOdqbONs0Q
         UD/gWZ93pAAktECT+RvO87kg/hcsw2sTz91HuG+D8/FFwWdMOhfwuHgRbN+F+3QB/XxE
         Tp55rceCrOm/Nc3SSlNjI98PO4bJypZvSb+YZFrqMWAAJ+2CIDwAHO+Vk9O4UERqUHFd
         pKQpbzMeZYGwH09bNwNtbRaYkKL1dK522yXV2SdYi/rz/YGqgBnEa+kh6IDWwNn4Tyox
         Ip9g==
X-Forwarded-Encrypted: i=1; AJvYcCWo77vfceJ041YlfH96CXiOs1c2UOE8YWW/uK0ODYYJ2A5aBD61lT6rwWF0jpkUiCgKLOYdlBUOEJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5+xtKNW5Mi0EQLDnNfQKqBQQUoLalyF8gu2gAGRKKwolzNZan
	ra2rWW9kl22qnnbw+diNOK08SRQWePPbo581AhBq/tjIhmKULVQwNTco00SO1aneVxN1YIfAEI9
	7sUpZDOZ9rbjKnYpUUuNL30blTN+PcvE=
X-Gm-Gg: ASbGncu/Vc6cPL/WzPhzH9ff7YuDgaIRNtistMMNpZTRt+/Z/TA3T2uNyODDKxHVPHt
	WZXqdk5bEsk+/fyv+SSnY/4RKjeI6wS1YJb3EvCkWfqfLem9T+dm8jcBnMsFoSnrM5zSeLxBIA+
	O1uNZDKvBu0pAvJl2PLjEAM4Vu1dhh0WlSI/6Fun+t1EBsivueJ10/HUBWpG/FmKbFJX7+XlfFh
	/59ejQPDWRUAxS11Q==
X-Google-Smtp-Source: AGHT+IHuFQl3IkRSpNvtXWpKI09prJCuJuckIVTenPVb76xE9MPDXQRO9v7Wr6YyhaqR4gq3C1ls28SRy5MYs+wa38U=
X-Received: by 2002:a17:907:7faa:b0:b04:5d56:d838 with SMTP id
 a640c23a62f3a-b07a648315amr599793066b.20.1757656842467; Thu, 11 Sep 2025
 23:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910155759.75380-1-daniel.lezcano@linaro.org> <20250910155759.75380-3-daniel.lezcano@linaro.org>
In-Reply-To: <20250910155759.75380-3-daniel.lezcano@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 12 Sep 2025 09:00:05 +0300
X-Gm-Features: Ac12FXxQrCqqIWxBETXAc9UESnxkTjgnC0RkWvfqe5u1IBGSRKZv8N1t-6gt8-M
Message-ID: <CAHp75VfwCLPAD84Rqt7hVC123U7=-GiyCemuQwnMCeR18fmRew@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
	linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 6:58=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
>
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
>
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
>
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.

...

> +#include <linux/bitops.h>

> +#include <linux/circ_buf.h>

Is it used?

> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>

+ err.h

> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>

+ minmax.h

> +#include <linux/module.h>

> +#include <linux/of.h>

Wrong header, should be property.h.

> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>

+ time.h

> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +#define REG_ADC_CTR_INPSAMP_MIN                8
> +#define REG_ADC_CTR_INPSAMP_MAX                0xFF

First of all, the value is written in a different style. Be
consistent. Second, is this limited by a bit field resolution? If so,
form (BIT($x) - 1) is better as it shows the limit in $x ($x should be
replaced with the actual value).

...

> +struct nxp_sar_adc {
> +       void __iomem *regs;
> +       phys_addr_t regs_phys;
> +       struct clk *clk;
> +
> +       u16 value;
> +       u32 vref_mV;
> +       u8 current_channel;
> +       u8 channels_used;

Run `pahole` and act accordingly.

> +       struct completion completion;
> +
> +       u16 buffer[NXP_SAR_ADC_IIO_BUFF_SZ];
> +       u16 buffered_chan[NXP_SAR_ADC_NR_CHANNELS];
> +
> +       struct circ_buf dma_buf;
> +       struct dma_chan *dma_chan;
> +       struct dma_slave_config dma_config;
> +       dma_addr_t rx_dma_buf;
> +       dma_cookie_t cookie;
> +
> +       /* Protect circular buffers access. */
> +       spinlock_t lock;
> +
> +       /*
> +        * Save and restore context
> +        */
> +       u32 inpsamp;
> +       u32 pwdn;
> +};

...

> +static bool __nxp_sar_adc_enable(struct nxp_sar_adc *info, bool enable)
> +{
> +       u32 mcr;
> +       bool pwdn;
> +
> +       mcr =3D readl(REG_ADC_MCR(info->regs));

> +       /*
> +        * Return the current state
> +        */

This is perfectly a single line comment. Same applies to a few
comments in the code.

> +       pwdn =3D mcr & REG_ADC_MCR_PWDN;
> +
> +       if (enable)
> +               mcr &=3D ~REG_ADC_MCR_PWDN;
> +       else
> +               mcr |=3D REG_ADC_MCR_PWDN;
> +
> +       writel(mcr, REG_ADC_MCR(info->regs));
> +
> +       /*
> +        * Ensure there are at least three cycles between the
> +        * configuration of NCMR and the setting of NSTART
> +        */

Missing period at the end. Same applies to a few comments in the code.

> +       if (enable)
> +               ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * =
3U));

Do you need 'U'? AFAIR frequency can't be negative. Same applies to a
few cases in the code.

> +       return pwdn;
> +}

> +       ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80U);

...

> +               ret =3D wait_for_completion_interruptible_timeout
> +                       (&info->completion,
> +                       msecs_to_jiffies(NXP_SAR_ADC_CONV_TIMEOUT_MS));

This is bad style, please reindent in a better way.

...

> +static int sar_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec=
 const *chan,
> +                        int val, int val2, long mask)
> +{
> +       struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +       u32 inpsamp;
> +
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               /*
> +                * Configures the sample period duration in terms of
> +                * the SAR controller clock. The minimum acceptable
> +                * value is 8. Configuring to a value lower than 8

Configuring it to

> +                * sets the sample period to 8 cycles.  We read the
> +                * clock value and divide by the sampling timing which
> +                * gives us the number of cycles expected. The value
> +                * is 8 bits wide, consequently the max value is 0xFF
> +                */
> +               inpsamp =3D clk_get_rate(info->clk) / val - NXP_SAR_ADC_C=
ONV_TIME;
> +               nxp_sar_adc_conversion_timing_set(info, inpsamp);
> +               return 0;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}

...

> +       /* If everything transferred, avoid an off by one error. */

was/is transfered.

...

> +       /* dma_buf->tail !=3D dma_buf->head condition will become false
> +        * because dma_buf->tail will be incremented with 1.
> +        */

Wrong multi-line comment style. Driver was written by a few people?

...

> +/*
> + * The documentation describes the reset values for the
> + * registers. However some registers do not have these values after a
> + * reset. It is a not desirable situation. In some other SoC family

It is not a

> + * documentation NXP recommend to not assume the default values are

recommends
assuming

> + * set and to initialize the registers conforming to the documentation
> + * reset information to prevent this situation. Assume the same rule
> + * applies here as there is a discrepancy between what is read from
> + * the registers at reset time and the documentation.
> + */

...

> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +       const struct nxp_sar_adc_data *data;
> +       struct nxp_sar_adc *info;
> +       struct iio_dev *indio_dev;
> +       struct resource *mem;
> +       struct device *dev =3D &pdev->dev;
> +       int irq;
> +       int ret;
> +
> +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct nxp_sar_ad=
c));
> +       if (!indio_dev)
> +               return -ENOMEM;

> +       info =3D iio_priv(indio_dev);
> +
> +       data =3D device_get_match_data(dev);
> +
> +       info->vref_mV =3D data->vref_mV;

Instead of split, move data assignment to be before indio_dev allocation.

> +       info->regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &m=
em);
> +       if (IS_ERR(info->regs))
> +               return dev_err_probe(dev, PTR_ERR(info->regs),
> +                                    "failed to get and remap resource");
> +
> +       irq =3D platform_get_irq(pdev, 0);
> +       if (irq < 0)
> +               return irq;
> +
> +       ret =3D devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +                              dev_name(dev), indio_dev);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed requesting irq, ir=
q =3D %d\n", irq);
> +
> +       info->regs_phys =3D mem->start;
> +       spin_lock_init(&info->lock);
> +
> +       info->clk =3D devm_clk_get_enabled(dev, "adc");
> +       if (IS_ERR(info->clk))
> +               return dev_err_probe(dev, PTR_ERR(info->clk),
> +                                    "failed to get the clock\n");

> +       platform_set_drvdata(pdev, indio_dev);


> +       init_completion(&info->completion);
> +
> +       indio_dev->name =3D dev_name(dev);
> +       indio_dev->info =3D &nxp_sar_adc_iio_info;
> +       indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +       indio_dev->channels =3D nxp_sar_adc_iio_channels;
> +       indio_dev->num_channels =3D ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +       nxp_sar_adc_set_default_values(info);
> +
> +       ret =3D nxp_sar_adc_calibration(info);
> +       if (ret) {
> +               dev_err(dev, "Calibration failed: %d\n", ret);
> +               return ret;

return dev_err_probe(...);

> +       }
> +
> +       ret =3D nxp_sar_adc_dma_probe(dev, info);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to initialize the =
dma\n");
> +
> +       ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &nxp_sar_adc_trigger_handle=
r,
> +                                             &iio_triggered_buffer_setup=
_ops);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "Couldn't initialise the b=
uffer\n");
> +
> +       ret =3D devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Couldn't register the dev=
ice\n");
> +
> +       return 0;
> +}
> +
> +static void nxp_sar_adc_remove(struct platform_device *pdev)
> +{
> +       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> +       struct nxp_sar_adc *info =3D iio_priv(indio_dev);
> +
> +       nxp_sar_adc_stop_conversion(info);
> +       nxp_sar_adc_channels_disable(info, REG_ADC_CH_MASK);
> +       nxp_sar_adc_dma_channels_disable(info, REG_ADC_CH_MASK);
> +       nxp_sar_adc_dma_cfg(info, false);
> +       nxp_sar_adc_disable(info);
> +       dmaengine_terminate_sync(info->dma_chan);
> +}

--=20
With Best Regards,
Andy Shevchenko

