Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4582D63F7EC
	for <lists+linux-iio@lfdr.de>; Thu,  1 Dec 2022 20:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLATKY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Dec 2022 14:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiLATKO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2022 14:10:14 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26697C23FD
        for <linux-iio@vger.kernel.org>; Thu,  1 Dec 2022 11:10:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id l2so2099344qtq.11
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2022 11:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibJi/wn+aAgdaYcLr3zLKu9T346HCJJDMnxkbBIngNg=;
        b=utVG1A8vtn5ugUFSSegFbL/EjHXkVOjveRhRTj/QHENW9UJ6DZubgHdaHqR0hupqX6
         kP4TTCqP9pzs0HkE2dn/wSq46Ch9XLDjyDKH1o5eic6CZvuoz0Z2rBzGYDAc8G4wKbxV
         ZWP2a8gWY1EJxniBEA276LZXbJRitN4PD3yknMlSNZloSuUZ0jNX2NJp+v/YBy7phpjl
         97lwe7hhF/cQZ8fYYTC+brPbS6nLR2EfIOcimyxCk4+NBEohQsLEjoCy9PjeCHS2winP
         71veBdaanZ9mWHI+KNUqLkPzyXyP/6GjWfx4f16EpGYddW96TyamdD5OQWaxZWZTM0kQ
         sAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibJi/wn+aAgdaYcLr3zLKu9T346HCJJDMnxkbBIngNg=;
        b=SeWpVcU3FU+clwOIfuJH5Cf0YOacfyzRjXk4MArISQxpXNlKsvXLjVPJnRGBRCCuO5
         j6BHoEpLaD8cLySl9dKnmNB3JKbyqaE5jlhChNRbKAgpaqQYV7KpST0Ayg0p8vkVU7M/
         3GdNeLWdxTLtiXxjxBPovQ6nF5sq9KJSpVIPcbQzuWhv5C2qSZD8z3dfbXKbqfK1QoJy
         W7a20O9t9zPrzWcy2DM5+NWhn3oaad6aYI4wMjRpjp+89AiiP+fJtxcWg4o2pf67fzPn
         nE7j/0HeabNyt8zTvtiH1QzL6XujLSPZvBpeh1Z0zMJkkVosSVGCTvbiW4koP3yWe/p1
         XEvg==
X-Gm-Message-State: ANoB5pkIzS+909fii8sA8NbhUSsUwPv4jAmYqXdZnHvpsHDXu14HOSnu
        VcSTZ9T74h55W/bF9MgfLQqGXB8Q0jp8ew==
X-Google-Smtp-Source: AA0mqf45/RXYxwQhUsczFJiCe1F4wJ7oSttkYQUw5CygWPL8EjJQcixNAX1rSOOHoD5CM1F8eVXBZg==
X-Received: by 2002:ac8:5bd1:0:b0:3a5:7994:3943 with SMTP id b17-20020ac85bd1000000b003a579943943mr43354422qtb.204.1669921810815;
        Thu, 01 Dec 2022 11:10:10 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u25-20020a37ab19000000b006eeca296c00sm3755499qke.104.2022.12.01.11.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:10:10 -0800 (PST)
Date:   Thu, 1 Dec 2022 14:10:08 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 4/5] counter: Add Renesas RZ/G2L MTU3a counter driver
Message-ID: <Y4j8EPSCx0N6aAm4@fedora>
References: <20221124170018.3150687-1-biju.das.jz@bp.renesas.com>
 <20221124170018.3150687-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fMvz7r65sWnwYDdm"
Content-Disposition: inline
In-Reply-To: <20221124170018.3150687-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--fMvz7r65sWnwYDdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2022 at 05:00:17PM +0000, Biju Das wrote:
> Add RZ/G2L MTU3a counter driver. This IP supports the following
> phase counting modes on MTU1 and MTU2 channels
>=20
> 1) 16-bit phase counting modes on MTU1 and MTU2 channels.
> 2) 32-bit phase counting mode by cascading MTU1 and MTU2 channels.
>=20
> This patch adds 3 counter value channels.
> 	count0: 16-bit phase counter value channel on MTU1
> 	count1: 16-bit phase counter value channel on MTU2
> 	count2: 32-bit phase counter value channel by cascading
>                 MTU1 and MTU2 channels.
>=20
> The external input phase clock pin for the counter value channels
> are as follows:
> 	count0: "MTCLKA-MTCLKB"
> 	count1: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
> 	count2: "MTCLKA-MTCLKB" or "MTCLKC-MTCLKD"
>=20
> Use the sysfs variable "external_input_phase_clock_select" to select the
> external input phase clock pin and "cascade_enable" to enable/disable
> cascading of channels.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Hi Biju,

Some comments inline below.

> ---
> v6->v7:
>  * Updated commit description
>  * Added Register descriptions
>  * Opimized size of cache variable by using union
>  * Used test_bit() in rz_mtu3_is_counter_invalid()
>  * Replaced val->timer_mode in rz_mtu3_count_function_{read,write}
>  * Added TODO comment phase3 and phase5 modes.
>  * replaced if-else with ternary expression in rz_mtu3_count_direction_re=
ad()
>  * Used switch statement in rz_mtu3_count_ceiling_read to consistent with=
 write
>  * Provided default case for all switch statement.
>  * Add mutex lock for avoiding races with other devices
>  * Updated comments in rz_mtu3_action_read
>  * Replaced COUNTER_COMP_DEVICE_BOOL->COUNTER_COMP_DEVICE_BOOL for=20
>    cascade_enable
>  * Replaced RZ_MTU3_GET_HW_CH->rz_mtu3_get_hw_ch
>  * Added rz_mtu3_get_ch() to get channels
>  * used rz_mtu3_shared_reg_update_bit for cascade_enable and
>    selecting phase input clock.
>  * Added rz_mtu3_is_counter_invalid() check in rz_mtu3_count_ceiling_read=
()
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
>  drivers/counter/rz-mtu3-cnt.c | 793 ++++++++++++++++++++++++++++++++++
>  3 files changed, 805 insertions(+)
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
> index 000000000000..0b0c5f9b2993
> --- /dev/null
> +++ b/drivers/counter/rz-mtu3-cnt.c
> @@ -0,0 +1,793 @@
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
> +/*
> + * Register descriptions
> + *   TSR: Timer Status Register
> + *   TMDR1: Timer Mode Register 1
> + *   TMDR3: Timer Mode Register 3
> + *   TIOR: Timer I/O Control Register
> + *   TCR: Timer Control Register
> + *   TCNT: Timer Counter
> + *   TGRA: Timer general register A
> + *   TCNTLW: Timer Longword Counter
> + *   TGRALW: Timer longword general register A
> + */
> +
> +#define RZ_MTU3_TSR_TCFD	BIT(7) /* Count Direction Flag */
> +
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_1	(4) /* Phase counting mode 1 */
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_2	(5) /* Phase counting mode 2 */
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_3	(6) /* Phase counting mode 3 */
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_4	(7) /* Phase counting mode 4 */
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_5	(9) /* Phase counting mode 5 */
> +#define RZ_MTU3_TMDR1_PH_CNT_MODE_MASK	(0xf)
> +
> +/*
> + * LWA: MTU1/MTU2 Combination Longword Access Control
> + * 0: 16-bit, 1: 32-bit
> + */
> +#define RZ_MTU3_TMDR3_LWA	(0)
> +
> +/*
> + * PHCKSEL: External Input Phase Clock Select
> + * 0: MTCLKA and MTCLKB, 1: MTCLKC and MTCLKD
> + */
> +#define RZ_MTU3_TMDR3_PHCKSEL	(1)
> +
> +#define RZ_MTU3_16_BIT_MTU1_CH	(0)
> +#define RZ_MTU3_16_BIT_MTU2_CH	(1)
> +#define RZ_MTU3_32_BIT_CH	(2)
> +
> +#define RZ_MTU3_TIOR_NO_OUTPUT	(0) /* Output prohibited */
> +#define RZ_MTU3_TIOR_IC_BOTH	(10) /* Input capture at both edges */
> +
> +#define SIGNAL_A_ID	(0)
> +#define SIGNAL_B_ID	(1)
> +#define SIGNAL_C_ID	(2)
> +#define SIGNAL_D_ID	(3)
> +
> +#define RZ_MTU3_MAX_HW_CNTR_CHANNELS	(2)
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
> +	union {
> +		u16 mtu_16bit_max[RZ_MTU3_MAX_HW_CNTR_CHANNELS];
> +		u32 mtu_32bit_max;
> +	};
> +};
> +
> +static const enum counter_function rz_mtu3_count_functions[] =3D {
> +	COUNTER_FUNCTION_QUADRATURE_X4,
> +	COUNTER_FUNCTION_PULSE_DIRECTION,
> +	COUNTER_FUNCTION_QUADRATURE_X2_B,
> +};
> +
> +static inline size_t rz_mtu3_get_hw_ch(const size_t id)
> +{
> +	return (id =3D=3D RZ_MTU3_32_BIT_CH) ? 0 : id;
> +}
> +
> +static inline struct rz_mtu3_channel *
> +rz_mtu3_get_ch(struct counter_device *counter, int id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D rz_mtu3_get_hw_ch(id);
> +
> +	return &priv->ch[ch_id];
> +}
> +
> +static bool rz_mtu3_is_counter_invalid(struct counter_device *counter, i=
nt id)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	unsigned long tmdr;
> +
> +	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH && test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> +		return false;
> +
> +	if (id !=3D RZ_MTU3_32_BIT_CH && !test_bit(RZ_MTU3_TMDR3_LWA, &tmdr))
> +		return false;
> +
> +	return true;
> +}
> +
> +static int rz_mtu3_count_read(struct counter_device *counter,
> +			      struct counter_count *count, u64 *val)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;

So what rz_mtu3_is_counter_invalid() does is check if the respective
Count component is available for the 16-bit or 32-bit operation mode.
It'll make sense to return -EBUSY in these cases rather than -EINVAL,
because semantically the user request here isn't due to an invalid
argument by the user -- rather the request can't be fulfilled because
the device is currently busy in the other operation mode.

> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*val =3D rz_mtu3_32bit_ch_read(ch, RZ_MTU3_TCNTLW);
> +	else
> +		*val =3D rz_mtu3_16bit_ch_read(ch, RZ_MTU3_TCNT);

It looks like you have a race condition here: after passing the
rz_mtu3_is_counter_invalid() check earlier, the operation mode could
change before you perform the subsequent channel read here. You should
protect this callback with a lock to make sure the operation mode isn't
changed by rz_mtu3_cascade_enable_set() or otherwise.

> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_write(struct counter_device *counter,
> +			       struct counter_count *count, const u64 val)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D rz_mtu3_get_hw_ch(count->id);
> +	u32 ceiling;
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);

Move this lock above the rz_mtu3_is_counter_invalid() check for the same
reason as in the count_read() callback.

> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		ceiling =3D priv->mtu_32bit_max;
> +	else
> +		ceiling =3D priv->mtu_16bit_max[ch_id];
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TCNTLW, val);
> +	else
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TCNT, val);
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
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	u8 timer_mode;
> +
> +	timer_mode =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TMDR1);
> +
> +	switch (timer_mode & RZ_MTU3_TMDR1_PH_CNT_MODE_MASK) {
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
> +		/*
> +		 * TODO:
> +		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
> +		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
> +		 */
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
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	u8 timer_mode;
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		timer_mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_1;
> +		break;
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		timer_mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_2;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		timer_mode =3D RZ_MTU3_TMDR1_PH_CNT_MODE_4;
> +		break;
> +	default:
> +		/*
> +		 * TODO:
> +		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_3
> +		 *  - need to add RZ_MTU3_TMDR1_PH_CNT_MODE_5
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, timer_mode);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_direction_read(struct counter_device *counter,
> +					struct counter_count *count,
> +					enum counter_count_direction *direction)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	u8 tsr;
> +
> +	tsr =3D rz_mtu3_8bit_ch_read(ch, RZ_MTU3_TSR);
> +	*direction =3D (tsr & RZ_MTU3_TSR_TCFD) ?
> +		COUNTER_COUNT_DIRECTION_FORWARD : COUNTER_COUNT_DIRECTION_BACKWARD;
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_ceiling_read(struct counter_device *counter,
> +				      struct counter_count *count,
> +				      u64 *ceiling)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D rz_mtu3_get_hw_ch(count->id);
> +
> +	if (rz_mtu3_is_counter_invalid(counter, count->id))
> +		return -EINVAL;
> +
> +	switch (count->id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		*ceiling =3D priv->mtu_16bit_max[ch_id];
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		*ceiling =3D priv->mtu_32bit_max;
> +		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		*ceiling =3D priv->mtu_32bit_max;
> +	else
> +		*ceiling =3D priv->mtu_16bit_max[ch_id];
> +
> +	return 0;
> +}

Protect the rz_mtu3_count_ceiling_read() function with a lock to make
sure the cascade operation mode doesn't not change and that the priv
data structure accesses don't race when they are changed in the
ceiling_write() callback.

> +
> +static int rz_mtu3_count_ceiling_write(struct counter_device *counter,
> +				       struct counter_count *count,
> +				       u64 ceiling)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	const size_t ch_id =3D rz_mtu3_get_hw_ch(count->id);
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
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&priv->lock);
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH)
> +		rz_mtu3_32bit_ch_write(ch, RZ_MTU3_TGRALW, ceiling);
> +	else
> +		rz_mtu3_16bit_ch_write(ch, RZ_MTU3_TGRA, ceiling);
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	mutex_unlock(&priv->lock);
> +
> +	return 0;
> +}

Same comments as for the ceiling_read() callback.

> +
> +static void rz_mtu3_32bit_cnt_setting(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_channel *const ch1 =3D rz_mtu3_get_ch(counter, 0);
> +	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
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
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, id);
> +
> +	/* Phase counting mode 1 is used as default in initialization. */
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TMDR1, RZ_MTU3_TMDR1_PH_CNT_MODE_1);
> +
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TCR, RZ_MTU3_TCR_CCLR_TGRA);
> +	rz_mtu3_8bit_ch_write(ch, RZ_MTU3_TIOR, RZ_MTU3_TIOR_NO_OUTPUT);
> +	rz_mtu3_enable(ch);
> +}
> +
> +static int rz_mtu3_initialize_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, id);
> +	struct rz_mtu3_channel *const ch1 =3D rz_mtu3_get_ch(counter, 0);
> +	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
> +
> +	switch (id) {
> +	case RZ_MTU3_16_BIT_MTU1_CH:
> +	case RZ_MTU3_16_BIT_MTU2_CH:
> +		mutex_lock(&ch->lock);
> +		if (ch->function =3D=3D RZ_MTU3_NORMAL)
> +			ch->function =3D RZ_MTU3_16BIT_PHASE_COUNTING;
> +		mutex_unlock(&ch->lock);
> +
> +		if (ch->function !=3D RZ_MTU3_16BIT_PHASE_COUNTING)
> +			return -EBUSY;
> +
> +		rz_mtu3_16bit_cnt_setting(counter, id);
> +
> +		break;
> +	case RZ_MTU3_32_BIT_CH:
> +		/*
> +		 * 32-bit phase counting need MTU1 and MTU2 to create 32-bit
> +		 * cascade counter.
> +		 */
> +		mutex_lock(&ch1->lock);
> +		if (ch1->function =3D=3D RZ_MTU3_NORMAL)
> +			ch1->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> +		mutex_unlock(&ch1->lock);
> +
> +		mutex_lock(&ch2->lock);
> +		if (ch2->function =3D=3D RZ_MTU3_NORMAL)
> +			ch2->function =3D RZ_MTU3_32BIT_PHASE_COUNTING;
> +		mutex_unlock(&ch2->lock);
> +
> +		if (ch1->function !=3D RZ_MTU3_32BIT_PHASE_COUNTING ||
> +		    ch2->function !=3D RZ_MTU3_32BIT_PHASE_COUNTING)
> +			return -EBUSY;
> +
> +		rz_mtu3_32bit_cnt_setting(counter, id);
> +		break;
> +	default:
> +		/* should never reach this path */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void rz_mtu3_terminate_counter(struct counter_device *counter, in=
t id)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, id);
> +	struct rz_mtu3_channel *const ch1 =3D rz_mtu3_get_ch(counter, 0);
> +	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
> +
> +	if (id =3D=3D RZ_MTU3_32_BIT_CH) {
> +		mutex_lock(&ch1->lock);
> +		ch1->function =3D RZ_MTU3_NORMAL;
> +		mutex_unlock(&ch1->lock);
> +
> +		mutex_lock(&ch2->lock);
> +		ch2->function =3D RZ_MTU3_NORMAL;
> +		mutex_unlock(&ch2->lock);
> +
> +		rz_mtu3_disable(ch2);
> +		rz_mtu3_disable(ch1);
> +	} else {
> +		mutex_lock(&ch->lock);
> +		ch->function =3D RZ_MTU3_NORMAL;
> +		mutex_unlock(&ch->lock);
> +
> +		rz_mtu3_disable(ch);
> +	}
> +}
> +
> +static int rz_mtu3_count_enable_read(struct counter_device *counter,
> +				     struct counter_count *count, u8 *enable)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_channel *const ch1 =3D rz_mtu3_get_ch(counter, 0);
> +	struct rz_mtu3_channel *const ch2 =3D rz_mtu3_get_ch(counter, 1);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	if (count->id =3D=3D RZ_MTU3_32_BIT_CH) {
> +		mutex_lock(&priv->lock);
> +		*enable =3D rz_mtu3_is_enabled(ch1) &&
> +			rz_mtu3_is_enabled(ch2);
> +		mutex_unlock(&priv->lock);
> +	} else {
> +		*enable =3D rz_mtu3_is_enabled(ch);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_count_enable_write(struct counter_device *counter,
> +				      struct counter_count *count, u8 enable)
> +{
> +	struct rz_mtu3_channel *const ch =3D rz_mtu3_get_ch(counter, count->id);
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		pm_runtime_get_sync(ch->dev);
> +		mutex_lock(&priv->lock);
> +		ret =3D rz_mtu3_initialize_counter(counter, count->id);
> +		mutex_unlock(&priv->lock);
> +	} else {
> +		mutex_lock(&priv->lock);
> +		rz_mtu3_terminate_counter(counter, count->id);
> +		mutex_unlock(&priv->lock);
> +		pm_runtime_put(ch->dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rz_mtu3_cascade_enable_get(struct counter_device *counter,
> +				      u8 *cascade_enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	unsigned long tmdr;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	*cascade_enable =3D test_bit(RZ_MTU3_TMDR3_LWA, &tmdr);
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
> +}
> +
> +static int rz_mtu3_cascade_enable_set(struct counter_device *counter,
> +				      u8 cascade_enable)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
> +				      RZ_MTU3_TMDR3_LWA, cascade_enable);
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
> +}

You need to lock rz_mtu3_cascade_enable_set() to make sure the other
callbacks don't try to read the LWA state while you're updating it.

> +
> +static int rz_mtu3_ext_input_phase_clock_select_get(struct counter_devic=
e *counter,
> +						    u32 *ext_input_phase_clock_select)
> +{
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	unsigned long tmdr;
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +	*ext_input_phase_clock_select =3D test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr=
);
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
> +
> +	pm_runtime_get_sync(priv->ch->dev);
> +	rz_mtu3_shared_reg_update_bit(priv->ch, RZ_MTU3_TMDR3,
> +				      RZ_MTU3_TMDR3_PHCKSEL,
> +				      ext_input_phase_clock_select);
> +	pm_runtime_put(priv->ch->dev);
> +
> +	return 0;
> +}

You need to lock rz_mtu3_ext_input_phase_clock_select_set() to ensure
the other callbacks don't try to read the PHCKSEL state while you're
updating it.

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
> +	struct rz_mtu3_cnt *const priv =3D counter_priv(counter);
> +	enum counter_function function;
> +	bool mtclkc_mtclkd;
> +	unsigned long tmdr;
> +	int err;
> +
> +	err =3D rz_mtu3_count_function_read(counter, count, &function);

You have a race here if rz_mtu3_count_function_write() is called and
changes the Count function. Protect your rz_mtu3_action_read() function
with a lock to make sure the Count function doesn't change until you're
finished.

> +	if (err)
> +		return err;
> +
> +	/* Default action mode */
> +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> +
> +	if (count->id !=3D RZ_MTU3_16_BIT_MTU1_CH) {
> +		tmdr =3D rz_mtu3_shared_reg_read(priv->ch, RZ_MTU3_TMDR3);
> +		mtclkc_mtclkd =3D test_bit(RZ_MTU3_TMDR3_PHCKSEL, &tmdr);
> +		if (mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_A_ID ||
> +				      synapse->signal->id =3D=3D SIGNAL_B_ID))
> +			return -EINVAL;
> +
> +		if (!mtclkc_mtclkd && (synapse->signal->id =3D=3D SIGNAL_C_ID ||
> +				       synapse->signal->id =3D=3D SIGNAL_D_ID))
> +			return -EINVAL;

These two return -EINVAL should simply be a return 0 to exit early.
These are valid Synapses -- they just happen to be in a
COUNTER_SYNAPSE_ACTION_NONE state until the respective phase clock is
selected for them.

William Breathitt Gray

> +	}
> +
> +	switch (function) {
> +	case COUNTER_FUNCTION_PULSE_DIRECTION:
> +		/*
> +		 * Rising edges on signal A (signal C) updates the respective
> +		 * count. The input level of signal B (signal D) determines
> +		 * direction.
> +		 */
> +		if (synapse->signal->id =3D=3D SIGNAL_A_ID ||
> +		    synapse->signal->id =3D=3D SIGNAL_C_ID)
> +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X2_B:
> +		/*
> +		 * Any state transition on quadrature pair signal B (signal D)
> +		 * updates the respective count.
> +		 */
> +		if (synapse->signal->id =3D=3D SIGNAL_B_ID ||
> +		    synapse->signal->id =3D=3D SIGNAL_D_ID)
> +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	case COUNTER_FUNCTION_QUADRATURE_X4:
> +		/* counts up/down on both edges of A (C)  and B (D) signal */
> +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> +		break;
> +	default:
> +		/* should never reach this path */
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
> +		.num_synapses =3D ARRAY_SIZE(rz_mtu3_mtu2_count_synapses),
> +		.ext =3D rz_mtu3_count_ext,
> +		.num_ext =3D ARRAY_SIZE(rz_mtu3_count_ext),
> +	}
> +};
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
> +	COUNTER_COMP_DEVICE_BOOL("cascade_enable",
> +				 rz_mtu3_cascade_enable_get,
> +				 rz_mtu3_cascade_enable_set),
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
> +	struct rz_mtu3_channel *ch;
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
> +	ch =3D &priv->ch[0];
> +	for (i =3D 0; i < RZ_MTU3_MAX_HW_CNTR_CHANNELS; i++) {
> +		ch->dev =3D dev;
> +		priv->mtu_16bit_max[i] =3D U16_MAX;
> +		ch++;
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

--fMvz7r65sWnwYDdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY4j8EAAKCRC1SFbKvhIj
K5JzAP4/DtfeDte2Q//GzFoDae72xzO/JWZauM3GXmzyp3SO4AEA4lI1cjiqmqme
SDB9NS0QhlZbjrbo4Ra4kNrde4UrRwo=
=s6sQ
-----END PGP SIGNATURE-----

--fMvz7r65sWnwYDdm--
