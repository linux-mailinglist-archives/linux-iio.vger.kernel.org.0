Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BBC62750E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Nov 2022 04:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiKNDrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Nov 2022 22:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiKNDrV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2022 22:47:21 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF37EDF53
        for <linux-iio@vger.kernel.org>; Sun, 13 Nov 2022 19:47:18 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id fz10so6175916qtb.3
        for <linux-iio@vger.kernel.org>; Sun, 13 Nov 2022 19:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMLlM1RugDjicwv2uPrRezndHJmdNJQESjnakODr0y8=;
        b=bs1g8nOOrFYNFDw5TZUkhC9BST76R15v4IRt1nlnThADCLRIUrM6PZMMrs/MRp9+Hz
         VyeMIKLVvw+Gj4b15JlN0Rvgu1E09t5MO/URW32Pa3nOo3mwiMugRDLYWJ8sBS/jH+A1
         npw2eMpdg0BTV2LWEqkv/BIZHMPzXLoo5h9+NEI7InLG9q/A6Tdj+bm0fqJoBxtMqjPv
         NFMbfQJ8eCb39DVk7/YCWLTs57eyM4gjqdzMH/O8nyUz7bMPEwfiK87egtPCPVf9B7dJ
         x1byo30l0OFNHJw0c1Uv4v/c/ecih+hE8h7WJmX69KGWOC/eWsi6kQMEZj7jPAAXCG0M
         Xm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMLlM1RugDjicwv2uPrRezndHJmdNJQESjnakODr0y8=;
        b=tpRSKX0g29kt9z6OOV3KSlGeySarQrmeJIoCVEDs49Ax9b/udctvrCwL7SmBwynyMI
         nQhhp5Fg0BB4e5t0TNLWg8QvNc0oEhQGlBZEf59jdEG76/b9ra7d9I2WrKyW6LwLJnqJ
         zISrpqFBKet/lQi+s+KTQ0qVTf4abVa+cLYfCeOOc//JpIB5smEQHxoEiTFk/0u6fi4m
         27AnU3kIfRNb6o24AmV0AjQ1GihJFmhYGJ8UofY3ZJ78zKvDxJH8lqmK4/DcTAxoUFiH
         +O55E2L4gZXzO51erz4e1u7lqOu7U9lKh7+Q4NPU41Ts5F+wqgfy1sFsBDQCEqoH9Hfy
         3Cfw==
X-Gm-Message-State: ANoB5pkwAl6dMs+RznZ0ZBiXjhe8gKpzR66ugSAqpBMc1XZN4BXFFFcR
        xs0ClVHTquf6VPHqYvOFwgSrf4Yfadrdrg==
X-Google-Smtp-Source: AA0mqf79SS7AIsSZ+y34ApBRPZtZ0rwLykQafrGGeuLihaCwDZzB4S/e+doAoCm02yVTwr5vrosgBQ==
X-Received: by 2002:ac8:5c02:0:b0:39c:c7a1:9aca with SMTP id i2-20020ac85c02000000b0039cc7a19acamr10775446qti.158.1668397637710;
        Sun, 13 Nov 2022 19:47:17 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id o12-20020ac841cc000000b0035ce8965045sm5135003qtm.42.2022.11.13.19.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:47:16 -0800 (PST)
Date:   Sun, 13 Nov 2022 22:47:13 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y3G6Qe0KMdo2PgaG@fedora>
References: <20221113171545.282457-1-biju.das.jz@bp.renesas.com>
 <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pNPd1CuVyXKZvUCP"
Content-Disposition: inline
In-Reply-To: <20221113171545.282457-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--pNPd1CuVyXKZvUCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2022 at 05:15:44PM +0000, Biju Das wrote:
> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>=20
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2.
>=20
> This patch adds 3 counters by creating 3 logical channels
> 	counter0: 16-bit phase counter on MTU1 channel
> 	counter1: 16-bit phase counter on MTU2 channel
> 	counter2: 32-bit phase counter by cascading MTU1 and MTU2
> 		  channels.

Within the context of the Counter subsystem, the term "counter"
specifically refers to the device (Counts + Synapses + Signals). Instead
you should use "count" here to refer to the counter value channels (i.e.
count0, count1, and count2).

>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5->v6:
>  * Updated KConfig and commit description
>  * Sorted header
>  * Fixed RZ_MTU3_GET_HW_CH Macro for argument reuse 'id' -=20
>    possible side-effects?
>  * Replaced SET_RUNTIME_PM_OPS->DEFINE_RUNTIME_DEV_PM_OPS and removed
>    __maybe_unused from suspend/resume()
> v4->v5:
>  * Updated the Kconfig with SoC vendor name
>  * Introduced rz_mtu3_is_counter_invalid()
>  * replaced pointer to an array of struct rz_mtu3_channel with
>    a simple pointer to struct rz_mtu3_channel.
>  * Added long_word_access_ctrl_mode sysfs entry for 16-bit and
>    32-bit access
>  * Added external_input_phase_clock_select sysfs entry for
>    selecting input clocks.
>  * used preprocessor defines represent SIGNAL_{A,B,C,D}_ID instead of
>    signal ids.
> v3->v4:
>  * There is no resource associated with "rz-mtu3-counter" compatible
>    and moved the code to mfd subsystem as it binds against "rz-mtu".
>  * Removed struct platform_driver rz_mtu3_cnt_driver.
>  * Updated commit description
>  * Updated Kconfig description
>  * Added macros RZ_MTU3_16_BIT_MTU{1,2}_CH for MTU1 and MTU2 channels
>  * Added RZ_MTU3_GET_HW_CH macro for getting channel ID.
>  * replaced priv->ch[id]->priv->ch[0] in rz_mtu3_count_read()
>  * Cached counter max values
>  * replaced cnt->tsr in rz_mtu3_count_direction_read()
>  * Added comments for RZ_MTU3_TCR_CCLR_NONE
>  * Replaced if with switch in rz_mtu3_initialize_counter() and
>    rz_mtu3_count_ceiling_write()
>  * Added locks in initialize, terminate and enable_read to prevent races.
>  * Updated rz_mtu3_action_read to take care of MTU2 signals.
>  * Added separate distinct array for each group of Synapse.
>  * Moved pm handling to parent.
>=20
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
>  drivers/counter/Kconfig       |  11 +
>  drivers/counter/Makefile      |   1 +
>  drivers/counter/rz-mtu3-cnt.c | 717 ++++++++++++++++++++++++++++++++++
>  3 files changed, 729 insertions(+)
>  create mode 100644 drivers/counter/rz-mtu3-cnt.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index d388bf26f4dc..daa352c7392d 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -39,6 +39,17 @@ config INTERRUPT_CNT
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called interrupt-cnt.
> =20
> +config RZ_MTU3_CNT
> +	tristate "Renesas RZ/G2L MTU3a counter driver"
> +	depends on RZ_MTU3 || COMPILE_TEST
> +	help
> +	  Enable support for MTU3a counter driver found on Renesas RZ/G2L alike
> +	  SoCs. This IP supports both 16-bit and 32-bit phase counting mode
> +	  support.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rz-mtu3-cnt.
> +
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
> index 000000000000..cfddbbe38ed1
> --- /dev/null
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -0,0 +1,717 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L MTU3a Counter driver
> + *
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/counter.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +#include <clocksource/rz-mtu3.h>
> +
> +#define RZ_MTU3_TSR_TCFD	BIT(7)

It is not always clear what these acronyms represent to someone not as
familiar with the hardware, so I recommend including a comment block
above these defines that provides a brief table of registers
descriptions. Something like:

    TSR: Timer Status Register
    TCFD: Count Direction Flag
    TMDR: Timer Mode Register
    TIOR: Timer I/O Control Register
    TCNT: Timer count
    ...

> +#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
> +
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9)
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
> +
> +#define RZ_MTU3_TMDR3_LWA	BIT(0)
> +#define RZ_MTU3_TMDR3_PHCKSEL	BIT(1)
> +
> +#define RZ_MTU3_16_BIT_MTU1_CH	(0)
> +#define RZ_MTU3_16_BIT_MTU2_CH	(1)
> +#define RZ_MTU3_32_BIT_CH		(2)
> +
> +#define RZ_MTU3_TIOR_NO_OUTPUT	(0)
> +#define RZ_MTU3_TIOR_IC_BOTH	(10)
> +
> +#define RZ_MTU3_GET_HW_CH(id) \
> +({ \
> +	size_t _id =3D (id); _id =3D (_id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : _id; \
> +})

I probably missed a discussion about this change in a previous thread;
what is the purpose of using a local size_t variable here? Is this due
to the "possible side-effects" mentioned in the patch changes note?

> +
> +#define SIGNAL_A_ID	(0)
> +#define SIGNAL_B_ID	(1)
> +#define SIGNAL_C_ID	(2)
> +#define SIGNAL_D_ID	(3)
> +
> +/**
> + * struct rz_mtu3_cnt - MTU3 counter private data
> + *
> + * @clk: MTU3 module clock
> + * @lock: Lock to prevent concurrent access for ceiling and count
> + * @ch: HW channels for the counters
> + * @mtu_16bit_max: Cache for 16-bit counters
> + * @mtu_32bit_max: Cache for 32-bit counters
> + */
> +struct rz_mtu3_cnt {
> +	struct clk *clk;
> +	struct mutex lock;
> +	struct rz_mtu3_channel *ch;
> +	u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> +	u32 mtu_32bit_max;

Does the ceiling set on the device get clobbered when you change between
16-bit and 32-bit phase modes (i.e. writing to TGRALW vs TGRA)? You have
a separate cache for the 32-bit ceiling value here, but if it is getting
clobbered then as a small optimization you may reimplement this cache as
a union such as:

    union {
            u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
            u32 mtu_32bit_max;
    }

> +};
> +
> +static const enum counter_function rz_mtu3_count_functions[] =3D {
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +};
> +
> +static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, i=
nt id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 val;
> +
> +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3) & RZ_MTU3_TMDR=
3_LWA;

You should use a more descriptive variable name for this such as
"lwa_mode_enabled" to make its meaning clearer.

> +	if (id =3D=3D RZ_MTU3_32_BIT_CH && val)
> +		return false;
> +
> +	if (id !=3D RZ_MTU3_32_BIT_CH && !val)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int rz_mtu3_count_read(struct counter_device *counter,
> +			      struct counter_count *count, u64 *val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*val =3D rz_mtu3_32bit_ch_read(priv->ch + ch_id, RZ_MTU3_TCNTLW);
> +	else
> +		*val =3D rz_mtu3_16bit_ch_read(priv->ch + ch_id, RZ_MTU3_TCNT);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_write(struct counter_device *counter,
> +			       struct counter_count *count, const u64 val)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	u32 ceiling;
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		ceiling =3D priv->mtu_32bit_max;
> +	else
> +		ceiling =3D priv->mtu_16bit_max[ch_id];
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(priv->ch + ch_id, RZ_MTU3_TCNTLW, val);
> +	else
> +		rz_mtu3_16bit_ch_write(priv->ch + ch_id, RZ_MTU3_TCNT, val);
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
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	u8 val;
> +
> +	val =3D rz_mtu3_8bit_ch_read(priv->ch + ch_id, RZ_MTU3_TMDR1);

A more descriptive name for this variable would be helpful to make
clearer what this value represents (maybe "timer_mode").

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

Sorry if I asked this before: what are counting modes 3 and 5, and are
they not supported by this device? If they are not supported, please
include a comment stating so in the default case block so that it is
clear for future reviewers as well.

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_function_write(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_function function)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
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
> +	rz_mtu3_8bit_ch_write(priv->ch + ch_id, RZ_MTU3_TMDR1, mode);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_direction_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_count_direction *direction)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	u8 tsr;
> +
> +	tsr =3D rz_mtu3_8bit_ch_read(priv->ch + ch_id, RZ_MTU3_TSR);
> +
> +	if (tsr & RZ_MTU3_TSR_TCFD)
> +		*direction =3D COUNTER_COUNT_DIRECTION_FORWARD;
> +	else
> +		*direction =3D COUNTER_COUNT_DIRECTION_BACKWARD;

The following is completely up to you if you want to do so, but I think
this conditional looks nicer as a ternary expression:

    *direction =3D (tsr & RZ_MTU3_TSR_TCFD) ? COUNTER_COUNT_DIRECTION_FORWA=
RD :
            COUNTER_COUNT_DIRECTION_BACKWARD;

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      u64 *ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*ceiling =3D priv->mtu_32bit_max;
> +	else
> +		*ceiling =3D priv->mtu_16bit_max[ch_id];

Use a switch statement here to be consistent with the ceiling_write()
callback.

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u64 ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;
> +
> +	switch (count->id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		if (ceiling > U16_MAX)
> +			return -ERANGE;
> +		priv->mtu_16bit_max[ch_id] =3D ceiling;
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		if (ceiling > U32_MAX)
> +			return -ERANGE;
> +		priv->mtu_32bit_max =3D ceiling;
> +		break;
> +	}

Provide a default case for this switch statement. In theory we should
never reach that code path, but it's good practice to have in case a bug
appears in the Counter subsystem:

    default:
            /* should never reach this path */
            return -EINVAL;

Make sure to provide similar default cases in the other switch
statements as well.

> +
> +	mutex_lock(&priv->lock);
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(priv->ch + ch_id, RZ_MTU3_TGRALW, ceiling);
> +	else
> +		rz_mtu3_16bit_ch_write(priv->ch + ch_id, RZ_MTU3_TGRA, ceiling);
> +
> +	rz_mtu3_8bit_ch_write(priv->ch + ch_id, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_T=
GRA);
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> +
> +	/*
> +	 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit cascade
> +	 * counter.
> +	 */
> +	ch1->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> +	ch2->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;

Can these "function" members be modified from outside this driver? If
so, you could have a race condition here.

> +
> +	/* Phase counting mode 1 is used as default in initialization. */
> +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_IC_BOTH);
> +
> +	rz_mtu3_enable(ch1);
> +	rz_mtu3_enable(ch2);
> +}
> +
> +static void rz_mtu3_16bit_cnt_setting(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch =3D priv->ch + id;
> +
> +	ch->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> +
> +	/* Phase counting mode 1 is used as default in initialization. */
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	rz_mtu3_enable(ch);
> +}
> +
> +static int rz_mtu3_initialize_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;

No need to complicate this, just use priv->ch[0], priv->ch[1], and
priv->ch[id]. Same advice applies to the other functions as well.

> +
> +	mutex_lock(&priv->lock);
> +	rz_mtu3_8bit_ch_write(ch1, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
> +	switch (id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		if ((priv->ch + id)->function !=3D RZ_MTU3_NORMAL) {
> +			mutex_unlock(&priv->lock);
> +			return -EBUSY;
> +		}
> +
> +		rz_mtu3_16bit_cnt_setting(counter, id);
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		if (ch1->function !=3D RZ_MTU3_NORMAL ||
> +		    ch2->function !=3D RZ_MTU3_NORMAL) {
> +			mutex_unlock(&priv->lock);
> +			return -EBUSY;
> +		}
> +		rz_mtu3_32bit_cnt_setting(counter, id);
> +		break;
> +	}
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_terminate_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> +
> +	mutex_lock(&priv->lock);
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> +		ch1->function =3D RZ_MTU3_NORMAL;
> +		ch2->function =3D RZ_MTU3_NORMAL;
> +		rz_mtu3_disable(ch2);
> +		rz_mtu3_disable(ch1);
> +	} else {
> +		(priv->ch + id)->function =3D RZ_MTU3_NORMAL;
> +		rz_mtu3_disable(priv->ch + id);
> +	}
> +	mutex_unlock(&priv->lock);
> +}
> +
> +static int rz_mtu3_count_enable_read(struct counter_device *counter,
> +				     struct counter_count *count, u8 *enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	struct rz_mtu3_channel *ch1 =3D priv->ch;
> +	struct rz_mtu3_channel *ch2 =3D ch1 + 1;
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH) {
> +		mutex_lock(&priv->lock);
> +		*enable =3D rz_mtu3_is_enabled(ch1) &&
> +			rz_mtu3_is_enabled(ch2);
> +		mutex_unlock(&priv->lock);
> +	} else {
> +		*enable =3D rz_mtu3_is_enabled(priv->ch + count->id);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> +				      struct counter_count *count, u8 enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D RZ_MTU3_GET_HW_CH(count->id);
> +	struct rz_mtu3_channel *ch =3D priv->ch + ch_id;
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		pm_runtime_get_sync(ch->dev);
> +		ret =3D rz_mtu3_initialize_counter(counter, count->id);

The "enable" Count component serves to pause/resume counting operation;
that means the existing count should not be lost when a Count is
disabled. The rz_mtu3_initialize_counter() function will clear the
current Count, so you'll need to restore it before returning.

Alternatively, the "enable" Count component is optional so you can
remove it if you don't want to implement it; just initialize the counter
at probe time instead.

> +	} else {
> +		rz_mtu3_terminate_counter(counter, count->id);
> +		pm_runtime_put(ch->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_mtu3_long_word_access_ctrl_mode_get(struct counter_device =
*counter,
> +						  u32 *lwa_ctrl_mode)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 val;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	*lwa_ctrl_mode =3D val & RZ_MTU3_TMDR3_LWA;
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_long_word_access_ctrl_mode_set(struct counter_device =
*counter,
> +						  u32 lwa_ctrl_mode)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 val;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	if (lwa_ctrl_mode)
> +		val |=3D RZ_MTU3_TMDR3_LWA;
> +	else
> +		val &=3D ~RZ_MTU3_TMDR3_LWA;
> +
> +	rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, val);
> +	pm_runtime_put(priv->ch->dev);

When you want to assign a bit to a buffer, you can use __assign_bit() to
simplify your code:

    unsigned long tmdr;
    ...
    tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
    __assign_bit(RZ_MTU3_TMDR3_LWA, &tmdr, !!lwa_ctrl_node);
    rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, tmdr);

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_devic=
e *counter,
> +						    u32 *ext_input_phase_clock_select)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 val;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	*ext_input_phase_clock_select =3D (val & RZ_MTU3_TMDR3_PHCKSEL) >> 1;
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_ext_input_phase_clock_select_set(struct counter_devic=
e *counter,
> +						    u32 ext_input_phase_clock_select)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	u16 val;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	val =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	if (ext_input_phase_clock_select)
> +		val |=3D RZ_MTU3_TMDR3_PHCKSEL;
> +	else
> +		val &=3D ~RZ_MTU3_TMDR3_PHCKSEL;
> +
> +	rz_mtu3_shared_reg_write(priv->ch, RZ_MTU3_TMDR3, val);
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
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
> +	enum counter_function function;
> +	int err;
> +
> +	err =3D rz_mtu3_count_function_read(counter, count, &function);
> +	if (err)
> +		return err;
> +
> +	/* Default action mode */
> +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;

You can exit early here depending on which ext_input_phase_clock mode is
currently selected: if "MTCLKA-MTCLKB" then return early if id is signal
C or D, while if "MTCLKC-MTCLKD" return early if id is signal A or B.

> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		/*
> +		 * Rising edges on signal A updates the respective count.
> +		 * The input level of signal B determines direction.
> +		 */

Since this also applies for signal C and signal D, you should make that
clear in this comment block; maybe adjust to "signal A (signal C)" and
"signal B (signal D)" will do.

> +		if (synapse->signal->id =3D=3D SIGNAL_A_ID ||
> +		    synapse->signal->id =3D=3D SIGNAL_C_ID)
> +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		/*
> +		 * Any state transition on quadrature pair signal B updates
> +		 * the respective count.
> +		 */
> +		if (synapse->signal->id =3D=3D SIGNAL_B_ID ||
> +		    synapse->signal->id =3D=3D SIGNAL_D_ID)
> +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;

Same suggestion as above.

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
> +	RZ_MTU3_PHASE_SIGNAL(SIGNAL_A_ID, "MTU1 MTCLKA"),
> +	RZ_MTU3_PHASE_SIGNAL(SIGNAL_B_ID, "MTU1 MTCLKB"),
> +	RZ_MTU3_PHASE_SIGNAL(SIGNAL_C_ID, "MTU2 MTCLKC"),
> +	RZ_MTU3_PHASE_SIGNAL(SIGNAL_D_ID, "MTU2 MTCLKD"),
> +};
> +
> +static struct counter_synapse rz_mtu3_mtu1_count_synapses[] =3D {
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals,
> +	},
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals + 1,
> +	}
> +};
> +
> +static struct counter_synapse rz_mtu3_mtu2_count_synapses[] =3D {
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals,
> +	},
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals + 1,
> +	},
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals + 2,
> +	},
> +	{
> +		.actions_list =3D rz_mtu3_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(rz_mtu3_synapse_actions),
> +		.signal =3D rz_mtu3_signals + 3,
> +	}
> +};
> +
> +static struct counter_count rz_mtu3_counts[] =3D {
> +	{
> +		.id =3D RZ_MTU3_16_BIT_MTU1_CH,
> +		.name =3D "Channel 1 Count",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_mtu1_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu1_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D RZ_MTU3_16_BIT_MTU2_CH,
> +		.name =3D "Channel 2 Count",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_mtu2_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	},
> +	{
> +		.id =3D RZ_MTU3_32_BIT_CH,
> +		.name =3D "Channel 1 and 2 (combined) Count",
> +		.functions_list =3D rz_mtu3_count_functions,
> +		.num_functions =3D ARRAY_SIZE(rz_mtu3_count_functions),
> +		.synapses =3D rz_mtu3_mtu2_count_synapses,

I'm just checking again for my benefit of understanding: in 32-bit phase
counting mode, if ext_input_phase_clock_select is "MTCLKC-MTCLKD", is
signal C and D used instead of signal A and B? In other words, is the
ext_input_phase_clock_select only valid for 16-bit phase counting mode,
or does it also apply for 32-bit phase counting mode?

> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	}
> +};
> +
> +static const char *const rz_mtu3_long_word_access_ctrl_modes[] =3D {
> +	"16-bit",
> +	"32-bit",
> +};
> +
> +static DEFINE_COUNTER_ENUM(rz_mtu3_long_word_access_ctrl_mode_enum,
> +			   rz_mtu3_long_word_access_ctrl_modes);
> +
> +static const char *const rz_mtu3_ext_input_phase_clock_select[] =3D {
> +	"MTCLKA-MTCLKB",
> +	"MTCLKC-MTCLKD",
> +};
> +
> +static DEFINE_COUNTER_ENUM(rz_mtu3_ext_input_phase_clock_select_enum,
> +			   rz_mtu3_ext_input_phase_clock_select);
> +
> +static struct counter_comp rz_mtu3_device_ext[] =3D {
> +	COUNTER_COMP_DEVICE_ENUM("long_word_access_ctrl_mode",

Cascading Counts seems like a feature that other counter devices may
also want to expose so it'll be prudent to rename this to something more
general that other drivers can expose. Perhaps reimplement this as a
COUNTER_COMP_DEVICE_BOOL and call it "cascade_enable", or something
similar.

> +				 rz_mtu3_long_word_access_ctrl_mode_get,
> +				 rz_mtu3_long_word_access_ctrl_mode_set,
> +				 rz_mtu3_long_word_access_ctrl_mode_enum),
> +	COUNTER_COMP_DEVICE_ENUM("external_input_phase_clock_select",
> +				 rz_mtu3_ext_input_phase_clock_select_get,
> +				 rz_mtu3_ext_input_phase_clock_select_set,
> +				 rz_mtu3_ext_input_phase_clock_select_enum),
> +};
> +
> +static int rz_mtu3_cnt_pm_runtime_suspend(struct device *dev)
> +{
> +	struct clk *const clk =3D dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(clk);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_cnt_pm_runtime_resume(struct device *dev)
> +{
> +	struct clk *const clk =3D dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(clk);
> +
> +	return 0;
> +}

Do the current counts need to be saved and restored when the pm
suspend/resume ops occur?

William Breathitt Gray

> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_cnt_pm_ops,
> +				 rz_mtu3_cnt_pm_runtime_suspend,
> +				 rz_mtu3_cnt_pm_runtime_resume, NULL);
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
> +	priv->mtu_32bit_max =3D U32_MAX;
> +	priv->ch =3D &ddata->channels[RZ_MTU1];
> +	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
> +		(priv->ch + i)->dev =3D dev;
> +		priv->mtu_16bit_max[i] =3D U16_MAX;
> +	}
> +
> +	mutex_init(&priv->lock);
> +	platform_set_drvdata(pdev, priv->clk);
> +	clk_prepare_enable(priv->clk);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +	ret =3D devm_add_action_or_reset(&pdev->dev, rz_mtu3_cnt_pm_disable, de=
v);
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
> +	counter->ext =3D rz_mtu3_device_ext;
> +	counter->num_ext =3D ARRAY_SIZE(rz_mtu3_device_ext);
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
> +static struct platform_driver rz_mtu3_cnt_driver =3D {
> +	.probe =3D rz_mtu3_cnt_probe,
> +	.driver =3D {
> +		.name =3D "rz-mtu3-counter",
> +		.pm =3D pm_ptr(&rz_mtu3_cnt_pm_ops),
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

--pNPd1CuVyXKZvUCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3G6QQAKCRC1SFbKvhIj
K72JAQDIAhu8uekJ9arKQFuvu3RHn1H3cqio9uRX3N61egB9swEAkjU2ZBaqPLFW
yGMSGEz+iFF6Nptwb3QER6uK8kqz7QY=
=TGDv
-----END PGP SIGNATURE-----

--pNPd1CuVyXKZvUCP--
