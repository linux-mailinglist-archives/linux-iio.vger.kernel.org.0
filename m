Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD55F81F8
	for <lists+linux-iio@lfdr.de>; Sat,  8 Oct 2022 03:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJHBhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Oct 2022 21:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJHBhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Oct 2022 21:37:11 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3B198C83
        for <linux-iio@vger.kernel.org>; Fri,  7 Oct 2022 18:37:09 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id i12so4129644qvs.2
        for <linux-iio@vger.kernel.org>; Fri, 07 Oct 2022 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtvEeRwnTfBOVFaN2nINWtzncSqXq0GDoNbq+EoKnM4=;
        b=cq8NaG1cwGH+06GuuCFPdaeAMG0aggHDMjzEmFwkLfpapH91nzSxXcuxns1536Pmhp
         t0GYMkT09Jps6PVNpOPH7K8msCQdX55JWkcG9yTt57OGEgr7X7sP6kYsrsrAm++eBDEH
         9F4FiFMiX2VNUGtCD8Kr/PNgMBoaAViWRCT5W+19YdF7c9iIPbLLDk8GM7wC5ssbWG+F
         yxOnQ1rRxr1HAVZ8PmbGHCX8vWl/6zywmjZrsTXDUUqneSiSFA7oU0z2jDSlYXGt/De6
         IyhpMdU4e9hcoNRu971PNA2RjJiDf+s5oidISWl/wTyspU7vh+2bRJ7D3fzBBcinym8G
         KWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtvEeRwnTfBOVFaN2nINWtzncSqXq0GDoNbq+EoKnM4=;
        b=YNX7kiblFuGJVqJeLeCsz+4k6SZ4J17hSzPlLRtx9qI3hrCzimDwMsiHAer05FCGAI
         rIaliMKy1jMENVs36GDk9XSa95IrsZwNmmpNZcByMoQOOEcQlBHNfkQxsZeZ44f89Qzv
         vUG10//6aIrYEXecX31gL5Ro8vpzLEm0T5FM5Jr72xCwqUUTmTKNy2Q2FgtDxkWJvQlQ
         N12B7qubiSngyuKnh+bw/zUzdMj58Ie4HFksV/ksP4yL6jcFuH5vzRgiwfJxD1N/JBYs
         6N9c9xIsYV06niKD56TcqixR5twMfOxKQXhRjuiHMbG29QSM74vU5Zam4EGCrU6wPyfh
         H3LQ==
X-Gm-Message-State: ACrzQf3VZRBqdeO1b9QN4WO2HIOdwAOIKylFt61ANkrf/vZAJTXa2Mf+
        JOa1YtbDHSh/R/EqlTVu8K5FwA==
X-Google-Smtp-Source: AMsMyM7f+xfAgB/ECWx5W2jfnZe1soWmU0hK53ZrosGU2y4/umrF1wwJt/+YJi+1P0KxRMsyfRjdKA==
X-Received: by 2002:a05:6214:2a83:b0:4b1:cdc6:821d with SMTP id jr3-20020a0562142a8300b004b1cdc6821dmr6665312qvb.36.1665193028426;
        Fri, 07 Oct 2022 18:37:08 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o19-20020a05620a2a1300b006cddf59a600sm3688455qkp.34.2022.10.07.18.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:37:07 -0700 (PDT)
Date:   Fri, 7 Oct 2022 21:37:05 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] counter: Add RZ/G2L MTU3 counter driver
Message-ID: <Y0DUQTMd2TpFTnZS@fedora>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sci+pYcYRVWKnbE8"
Content-Disposition: inline
In-Reply-To: <20221006135717.1748560-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Sci+pYcYRVWKnbE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 06, 2022 at 02:57:17PM +0100, Biju Das wrote:
> Add RZ/G2L MTU3 counter driver.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju,

This commit message is rather brief for an introduction of a new driver.
Provide a description of the functionality provided (e.g. two 16-bit
Counts or one 32-bit Count) as well as the hardware this driver supports
for context (e.g. what does MTU3 mean; is this a SoC; etc.).

> ---
> v1->v3:
>  * Modelled as a counter device supporting 3 counters(2 16-bit and=20
>    32-bit)
>  * Add kernel-doc comments to document struct rz_mtu3_cnt
>  * Removed mmio variable from struct rz_mtu3_cnt
>  * Removed cnt local variable from rz_mtu3_count_read()
>  * Replaced -EINVAL->-ERANGE for out of range error conditions.
>  * Removed explicit cast from write functions.
>  * Removed local variable val from rz_mtu3_count_ceiling_read()
>  * Added lock for RMW for counter/ceiling updates.
>  * Added different synapses for counter0 and counter{1,2}
>  * Used ARRAY for assigning num_counts.
>  * Added PM runtime for managing clocks.
>  * Add MODULE_IMPORT_NS(COUNTER) to import the COUNTER namespace.
> ---
>  drivers/counter/Kconfig       |   9 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/rz-mtu3-cnt.c | 568 ++++++++++++++++++++++++++++++++++
>  3 files changed, 578 insertions(+)
>  create mode 100644 drivers/counter/rz-mtu3-cnt.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index d388bf26f4dc..531b187e4630 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -39,6 +39,15 @@ config INTERRUPT_CNT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called interrupt-cnt.
> =20
> +config RZ_MTU3_CNT
> +	tristate "RZ/G2L MTU3 counter driver"
> +	depends on MFD_RZ_MTU3 || COMPILE_TEST
> +	help
> +	  Select this option to enable RZ/G2L MTU3 counter driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rz-mtu3-cnt.
> +

Provide a bit more description of the hardware here; you should at least
mention this is a Renesas RZ/G2L as opposed to some other manufacturer.

>  config STM32_TIMER_CNT
>  	tristate "STM32 Timer encoder counter driver"
>  	depends on MFD_STM32_TIMERS || COMPILE_TEST
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index b9a369e0d4fc..933fdd50b3e4 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -8,6 +8,7 @@ counter-y :=3D counter-core.o counter-sysfs.o counter-chr=
dev.o
> =20
>  obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
>  obj-$(CONFIG_INTERRUPT_CNT)		+=3D interrupt-cnt.o
> +obj-$(CONFIG_RZ_MTU3_CNT)	+=3D rz-mtu3-cnt.o
>  obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
>  obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
> diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
> new file mode 100644
> index 000000000000..26b5ea3852f8
> --- /dev/null
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -0,0 +1,568 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a Counter driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +#include <linux/counter.h>
> +#include <linux/mfd/rz-mtu3.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +#define RZ_MTU3_TSR_TCFD	BIT(7)
> +#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
> +
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
> +
> +#define RZ_MTU3_TCR_CCLR	GENMASK(7, 5)
> +#define RZ_MTU3_TCR_CCLR_NONE	FIELD_PREP(RZ_MTU3_TCR_CCLR, 0)
> +
> +#define RZ_MTU3_TMDR3_LWA	BIT(0)
> +#define RZ_MTU3_32_BIT_CH	(2)

Providing a define to identify the 32-bit channel is a good idea.
Defines for the other two 16-bit channels would also be good.

> +
> +#define RZ_MTU3_TIOR_IC_BOTH	(10)
> +
> +/**
> + * struct rz_mtu3_cnt - MTU3 counter private data
> + *
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for ceiling and count
> + * @rz_mtu3_channel: HW channels for the counters
> + */
> +struct rz_mtu3_cnt {
> +	struct clk *clk;
> +	struct mutex lock;
> +	struct rz_mtu3_channel *ch[RZ_MTU3_MAX_HW_CNTR_CHANNELS];

Does this need to be a pointer to an array of struct rz_mtu3_channel?
You can avoid the double dereferences in your code if you leave it as a
simple pointer to struct rz_mtu3_channel and use subscripts directly as
you would an array. Or is there something I'm missing?

> +};
> +
> +static const enum counter_function rz_mtu3_count_functions[] =3D {
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +};
> +
> +static bool rz_mtu3_is_16_bit_cnt_mode(struct rz_mtu3_cnt *const priv)
> +{
> +	return (priv->ch[0]->function =3D=3D RZ_MTU3_16BIT_PHASE_COUNTING ||
> +		priv->ch[1]->function =3D=3D RZ_MTU3_16BIT_PHASE_COUNTING);

Is there ever a situation where one channel is equal to
RZ_MTU3_16BIT_PHASE_COUNTING while the other channel is equal to
RZ_MTU3_32BIT_PHASE_COUNTING?

> +}
> +
> +static bool rz_mtu3_is_32_bit_cnt_mode(struct rz_mtu3_cnt *const priv)
> +{
> +	return (priv->ch[0]->function =3D=3D RZ_MTU3_32BIT_PHASE_COUNTING &&
> +		priv->ch[1]->function =3D=3D RZ_MTU3_32BIT_PHASE_COUNTING);
> +}
> +
> +static int rz_mtu3_count_read(struct counter_device *counter,
> +			      struct counter_count *count, u64 *val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

It is not immediately clear why you are ANDing the Count id here. After
looking at the rest of the code in this function I realized it's because
you want to call rz_mtu3_32bit_ch_read() with id =3D 0 when you have
count->id =3D RZ_MTU3_32_BIT_CH.

I wouldn't even bother with the local id variable in this function and
instead just hardcode priv->ch[0] in the rz_mtu3_32bit_ch_read() call
below directly.

> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*val =3D rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TCNTLW);
> +	else
> +		*val =3D rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TCNT);

Is there a risk of these read calls returning an error code?

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_write(struct counter_device *counter,
> +			       struct counter_count *count, const u64 val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

Same comment about local id variable as in rz_mtu3_count_read().

> +	u32 ceiling;
> +
> +	mutex_lock(&priv->lock);
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		ceiling =3D rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TGRALW);
> +	else
> +		ceiling =3D rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TGRA);

The ceiling value isn't expected to change unless the user executes your
ceiling_write() function, right? It might make sense to cache the
current ceiling value in your rz_mtu3_cnt structure so that you don't
have to read it out from the device every time you check it.

> +
> +	if (val > ceiling) {
> +		mutex_unlock(&priv->lock);
> +		return -ERANGE;
> +	}
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TCNTLW, val);
> +	else
> +		rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TCNT, val);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_function_read(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       enum counter_function *function)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

As mentioned before, this AND operation obscures the intention of your
code. Instead, rename this variable and account for RZ_MTU3_32_BIT_CH
explicitly with something like this:

    const size_t ch_id =3D (count->id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : count=
->id;

You could wrap this into a preprocessor macro to reuse again in your
code, but I'll leave it up to you if you want.

> +	u8 val;
> +
> +	val =3D rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TMDR1);
> +
> +	switch (val & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
> +	case RZ_MTU3_TMDR1_PH_CNT_MODE_1:
> +		*function =3D COUNTER_FUNCTION_QUADRATURE_X4;
> +		break;
> +	case RZ_MTU3_TMDR1_PH_CNT_MODE_2:
> +		*function =3D COUNTER_FUNCTION_PULSE_DIRECTION;
> +		break;
> +	case RZ_MTU3_TMDR1_PH_CNT_MODE_4:
> +		*function =3D COUNTER_FUNCTION_QUADRATURE_X2_B;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_function_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_function function)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

Same comment as in rz_mtu3_count_function_read().

> +	u8 mode;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_1;
> +		break;
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_2;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1, mode);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_direction_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_count_direction *direction)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

Same comment as in rz_mtu3_count_function_read().

> +	u8 cnt;
> +
> +	cnt =3D rz_mtu3_8bit_ch_read(priv->ch[id], RZ_MTU3_TSR);

This is the timer status register, right? A variable name of 'cnt' seems
a bit strange to me; would 'tsr' be a better name here?

> +
> +	if (cnt & RZ_MTU3_TSR_TCFD)
> +		*direction =3D COUNTER_COUNT_DIRECTION_FORWARD;
> +	else
> +		*direction =3D COUNTER_COUNT_DIRECTION_BACKWARD;
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      u64 *ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

Same comment about local id variable as in rz_mtu3_count_read().

> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*ceiling =3D rz_mtu3_32bit_ch_read(priv->ch[id], RZ_MTU3_TGRALW);
> +	else
> +		*ceiling =3D rz_mtu3_16bit_ch_read(priv->ch[id], RZ_MTU3_TGRA);

Assuming you're able to cache the ceiling value, you can set it here
directly and avoid the reads out to the device.

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u64 ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u32 id =3D count->id & 1;

Same comment as in rz_mtu3_count_function_read().

> +	if (ceiling > U16_MAX && rz_mtu3_is_16_bit_cnt_mode(priv))
> +		return -ERANGE;
> +
> +	if (ceiling > U32_MAX && rz_mtu3_is_32_bit_cnt_mode(priv))
> +		return -ERANGE;

You can determine which maximum to consider by checking the count->id.
Instead of those two conditional statments, try this instead:

    switch (count->id) {
    case 0:
    case 1:
            if (ceiling > U16_MAX)
                    return -ERANGE;
            break;
    case RZ_MTU3_32_BIT_CH:
            if (ceiling > U32_MAX)
                    return -ERANGE;
            break;
    }

If you need to check whether you're in 32-bit phase mode before setting
the ceiling for the RZ_MTU3_32_BIT_CH Count (and similarly for the
16-bit Counts), check that separately and return -EBUSY as appropriate.

> +	mutex_lock(&priv->lock);
> +	if (ceiling =3D=3D 0) {
> +		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_NONE);

Looks like something different is done when ceiling is set to 0. Would
you explain what's happening in this case and why it's different that
then else case below; in other words, what's the difference between
RZ_MTU3_TCR_CCLR_NONE and RZ_MTU3_TCR_CCLR_TGRA?

> +

You can remove this empty line.

> +	} else {
> +		if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +			rz_mtu3_32bit_ch_write(priv->ch[id], RZ_MTU3_TGRALW, ceiling);
> +		else
> +			rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA, ceiling);
> +
> +		rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR,
> +				      RZ_MTU3_TCR_CCLR_TGRA);
> +	}
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	/*
> +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascade
> +	 * counter.
> +	 */
> +	priv->ch[0]->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> +	priv->ch[1]->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> +
> +	rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, RZ_MTU3_TMDR3_LWA);
> +
> +	/* Phase counting mode 1 is used as default in initialization. */
> +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TMDR1,
> +			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	rz_mtu3_8bit_ch_write(priv->ch[0], RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
> +
> +	rz_mtu3_enable(priv->ch[0]);
> +	rz_mtu3_enable(priv->ch[1]);
> +}
> +
> +static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	priv->ch[id]->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;

If 16-bit phase counting is selected for one 16-bit counter, does the
other 16-bit counter need to be configured as well?

> +
> +	/* Phase counting mode 1 is used as default in initialization. */
> +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TMDR1,
> +			      RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	rz_mtu3_8bit_ch_write(priv->ch[id], RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	rz_mtu3_16bit_ch_write(priv->ch[id], RZ_MTU3_TGRA, U16_MAX);
> +
> +	rz_mtu3_enable(priv->ch[id]);
> +}
> +
> +static int rz_mtu3_initialize_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH && rz_mtu3_is_16_bit_cnt_mode(priv))
> +		return -EBUSY;
> +
> +	if (id !=3D RZ_MTU3_32_BIT_CH && rz_mtu3_is_32_bit_cnt_mode(priv))
> +		return -EBUSY;
> +
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_cnt_setting(counter, id);
> +	else
> +		rz_mtu3_16bit_cnt_setting(counter, id);

I think this code would flow better using a switch statement like this:

    switch (id) {
    case 0:
    case 1:
            if (rz_mtu3_is_32_bit_cnt_mode(priv))
                    return -EBUSY;
            rz_mtu3_16bit_cnt_setting(counter, id);
            break;
    case RZ_MTU3_32_BIT_CH:
            if (rz_mtu3_is_16_bit_cnt_mode(priv))
                    return -EBUSY;
            rz_mtu3_32bit_cnt_setting(counter, id);
            break;
    }

You should also protect this with a lock to prevent any races while
you're accessing and modifying the settings.

> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_terminate_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> +		priv->ch[0]->function =3D RZ_MTU3_NORMAL;
> +		priv->ch[1]->function =3D RZ_MTU3_NORMAL;
> +		rz_mtu3_shared_reg_write(priv->ch[0], RZ_MTU3_TMDR3, 0);
> +		rz_mtu3_disable(priv->ch[1]);
> +		rz_mtu3_disable(priv->ch[0]);
> +	} else {
> +		priv->ch[id]->function =3D RZ_MTU3_NORMAL;
> +		rz_mtu3_disable(priv->ch[id]);
> +	}

You probably need a lock in this function to prevent races.

> +}
> +
> +static int rz_mtu3_count_enable_read(struct counter_device *counter,
> +				     struct counter_count *count, u8 *enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*enable =3D rz_mtu3_is_enabled(priv->ch[0]) &&
> +			rz_mtu3_is_enabled(priv->ch[1]);

There's a race between checking for channel 0 and channel 1, so use a
lock to prevent that.

> +	else
> +		*enable =3D rz_mtu3_is_enabled(priv->ch[count->id]);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> +				      struct counter_count *count, u8 enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch =3D priv->ch[count->id & 0x1];

Same comment about the AND operation as mentioned before.

> +	int ret =3D 0;
> +
> +	if (enable) {
> +		pm_runtime_get_sync(ch->dev);
> +		ret =3D rz_mtu3_initialize_counter(counter, count->id);

Are you using the Count's "enable" extension to switch between 16-bit
and 32-bit phase modes?

> +	} else {
> +		rz_mtu3_terminate_counter(counter, count->id);
> +		pm_runtime_put(ch->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static struct counter_comp rz_mtu3_count_ext[] =3D {
> +	COUNTER_COMP_DIRECTION(rz_mtu3_count_direction_read),
> +	COUNTER_COMP_ENABLE(rz_mtu3_count_enable_read,
> +			    rz_mtu3_count_enable_write),
> +	COUNTER_COMP_CEILING(rz_mtu3_count_ceiling_read,
> +			     rz_mtu3_count_ceiling_write),
> +};
> +
> +static const enum counter_synapse_action rz_mtu3_synapse_actions[] =3D {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +	COUNTER_SYNAPSE_ACTION_NONE,
> +};
> +
> +static int rz_mtu3_action_read(struct counter_device *counter,
> +			       struct counter_count *count,
> +			       struct counter_synapse *synapse,
> +			       enum counter_synapse_action *action)
> +{
> +	const size_t signal_a_id =3D count->synapses[0].signal->id;
> +	const size_t signal_b_id =3D count->synapses[1].signal->id;

If this is "Channel 2" Count then you will have four Synapses for
four possible Signals (MTCLKA, MTCLKB, MTCLKC, MTCLKD), so you'll need
to account for those two other Signals as well.

> +	enum counter_function function;
> +	int err;
> +
> +	err =3D rz_mtu3_count_function_read(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	/* Default action mode */
> +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		/*
> +		 * Rising edges on signal A updates the respective count.
> +		 * The input level of signal B determines direction.
> +		 */
> +		if (synapse->signal->id =3D=3D signal_a_id)
> +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		/*
> +		 * Any state transition on quadrature pair signal B updates
> +		 * the respective count.
> +		 */
> +		if (synapse->signal->id =3D=3D signal_b_id)
> +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		/* counts up/down on both edges of A and B signal*/
> +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct counter_ops rz_mtu3_cnt_ops =3D {
> +	.count_read =3D rz_mtu3_count_read,
> +	.count_write =3D rz_mtu3_count_write,
> +	.function_read =3D rz_mtu3_count_function_read,
> +	.function_write =3D rz_mtu3_count_function_write,
> +	.action_read =3D rz_mtu3_action_read,
> +};
> +
> +#define RZ_MTU3_PHASE_SIGNAL(_id, _name) {		\
> +	.id =3D (_id),				\
> +	.name =3D (_name),			\
> +}
> +
> +static struct counter_signal rz_mtu3_signals[] =3D {
> +	RZ_MTU3_PHASE_SIGNAL(0, "MTU1 MTCLKA"),
> +	RZ_MTU3_PHASE_SIGNAL(1, "MTU1 MTCLKB"),
> +	RZ_MTU3_PHASE_SIGNAL(2, "MTU2 MTCLKC"),
> +	RZ_MTU3_PHASE_SIGNAL(3, "MTU2 MTCLKD"),
> +};

These names can be in a human-readable form (e.g. "Multi-function Timer
Clock A") if you think it's easier to understand, but I'll leave it up
to you if you want to change it.

> +
> +#define RZ_MTU3_COUNT_SYNAPSES(_id) {					\
> +	{								\
> +		.actions_list =3D rz_mtu3_synapse_actions,		\
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),	\
> +		.signal =3D rz_mtu3_signals + 2 * (_id)			\
> +	},								\
> +	{								\
> +		.actions_list =3D rz_mtu3_synapse_actions,		\
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),	\
> +		.signal =3D rz_mtu3_signals + 2 * (_id) + 1		\
> +	}								\
> +}
> +
> +static struct counter_synapse rz_mtu3_count_synapses[][2] =3D {
> +	RZ_MTU3_COUNT_SYNAPSES(0), RZ_MTU3_COUNT_SYNAPSES(1)
> +};

I know the 104-quad-8 module also creates a multidimensional array to
represent the synapses, but I would advise against this pattern because
it obscures the intention of the code.

Instead, create a separate distinct array for each group of Synapses; I
suppose there will be two arrays in this case judging from your existing
code.

> +
> +static struct counter_count rz_mtu3_counts[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Channel 1 Count(16-bit)",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_count_synapses[0],
> +		.num_synapses =3D 2,

As mentioned in the comment above, refer to the distinct Synapse array
for the particular Count and then use ARRAY_SIZE for that array to set
num_synapses.

> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D 1,
> +		.name =3D "Channel 2 Count(16-bit)",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_count_synapses[0],
> +		.num_synapses =3D 4,
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D 2,

Set id =3D RZ_MTU3_32_BIT_CH to make it more obvious here.

> +		.name =3D "Channel3 Count(32-bit)",

We probably don't need the "(32-bit)" in the name when it's obvious
already from the channel id and ceiling value.

I wonder how this counter is described in the RZ/G2L user documentation;
is it named "Channel 3" or "Channel 1 and 2"?

> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_count_synapses[0],
> +		.num_synapses =3D 4,
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	}
> +};
> +
> +static int __maybe_unused rz_mtu3_cnt_pm_runtime_suspend(struct device *=
dev)
> +{
> +	struct rz_mtu3_cnt *const priv =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rz_mtu3_cnt_pm_runtime_resume(struct device *d=
ev)
> +{
> +	struct rz_mtu3_cnt *const priv =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(priv->clk);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops rz_mtu3_cnt_pm_ops =3D {
> +	SET_RUNTIME_PM_OPS(rz_mtu3_cnt_pm_runtime_suspend, rz_mtu3_cnt_pm_runti=
me_resume, NULL)
> +};
> +
> +static void rz_mtu3_cnt_pm_disable(void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +}
> +
> +static int rz_mtu3_cnt_probe(struct platform_device *pdev)
> +{
> +	struct rz_mtu3 *ddata =3D dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev =3D &pdev->dev;
> +	struct counter_device *counter;
> +	struct rz_mtu3_cnt *priv;
> +	unsigned int i;
> +	int ret;
> +
> +	counter =3D devm_counter_alloc(dev, sizeof(*priv));
> +	if (!counter)
> +		return -ENOMEM;
> +
> +	priv =3D counter_priv(counter);
> +	priv->clk =3D ddata->clk;
> +
> +	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
> +		priv->ch[i] =3D &ddata->channels[RZ_MTU1 + i];
> +		priv->ch[i]->dev =3D dev;
> +		if (priv->ch[i]->function !=3D RZ_MTU3_NORMAL)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "channel '%u' is already claimed\n", i);
> +	}
> +
> +	mutex_init(&priv->lock);
> +	clk_prepare_enable(priv->clk);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       rz_mtu3_cnt_pm_disable,
> +				       dev);
> +	if (ret < 0)
> +		goto disable_clock;
> +
> +	counter->name =3D dev_name(dev);
> +	counter->parent =3D dev;
> +	counter->ops =3D &rz_mtu3_cnt_ops;
> +	counter->counts =3D rz_mtu3_counts;
> +	counter->num_counts =3D ARRAY_SIZE(rz_mtu3_counts);
> +	counter->signals =3D rz_mtu3_signals;
> +	counter->num_signals =3D ARRAY_SIZE(rz_mtu3_signals);
> +	platform_set_drvdata(pdev, priv);

It looks like you only ever use clk in your callbacks; how about setting
your drvdata to clk instead and removing it from your rz_mtu3_cnt
structure?

William Breathitt Gray

> +
> +	/* Register Counter device */
> +	ret =3D devm_counter_add(dev, counter);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to add counter\n");
> +		goto disable_clock;
> +	}
> +
> +	return 0;
> +
> +disable_clock:
> +	clk_disable_unprepare(priv->clk);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rz_mtu3_cnt_of_match[] =3D {
> +	{ .compatible =3D "renesas,rz-mtu3-counter", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rz_mtu3_cnt_of_match);
> +
> +static struct platform_driver rz_mtu3_cnt_driver =3D {
> +	.probe =3D rz_mtu3_cnt_probe,
> +	.driver =3D {
> +		.name =3D "rz-mtu3-counter",
> +		.pm =3D &rz_mtu3_cnt_pm_ops,
> +		.of_match_table =3D rz_mtu3_cnt_of_match,
> +	},
> +};
> +module_platform_driver(rz_mtu3_cnt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_ALIAS("platform:rz-mtu3-counter");
> +MODULE_DESCRIPTION("Renesas RZ/G2L MTU3a counter driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(COUNTER);
> --=20
> 2.25.1
>=20

--Sci+pYcYRVWKnbE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY0DUQQAKCRC1SFbKvhIj
K+6nAQD6iyWB5f+uivxSDxFfFitxcI6K7rLJtldtZhf1NEeyhgD+Kk3EFhMPhHU0
2ACyJwkgmU0682vJdbF+sZ9CrEKWagU=
=gHz2
-----END PGP SIGNATURE-----

--Sci+pYcYRVWKnbE8--
