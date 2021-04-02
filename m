Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A060E3529C2
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhDBKav (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 06:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBKav (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 06:30:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9576CC0613E6
        for <linux-iio@vger.kernel.org>; Fri,  2 Apr 2021 03:30:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so4414391pjq.5
        for <linux-iio@vger.kernel.org>; Fri, 02 Apr 2021 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9wG0FtdP79JeKyAmrXy3Hu5FXP3+EKA4DDqkkc1wKtc=;
        b=g1IyvWwClgneLY5+gV9OK79K1Uy2AtsO/HP16SHY/75n1SG/AVeUNpYuzFRmNgqrgM
         TIurUtMjDHbEqCMjXQN6bZi6BRhM540ixMiQKxKfvyLpdzCLUbFWP7OmSuYHjppJd7sY
         KLDMo0epPs5Panj98spM/t80rV8RUCL9vH2UT5ecr+uAOKTt0UI8OEWQhg5KNgIdgRrQ
         X4K6iEZ5yySa0G01XeFYyiOTp3HP5/V9mpzkaxGUcXtsoeGzzL+OPiNH02wzyaaLuZGA
         gwYsyJILTMbUURDrEOM+AWpOj6Mq0rgE3d+lDz8qLTvK0nu/903pps++Q6IDYFm9vBa/
         U0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9wG0FtdP79JeKyAmrXy3Hu5FXP3+EKA4DDqkkc1wKtc=;
        b=UE4cNE0fUpZzQQwvyi44dA8mMS45i3lmJ9rzCG8G7f3nEEdlwbRLXLJPCC+6VfznxU
         7pb7dMlX6b8d8E0Nx/L4azhgB9FLuui0kMXg9yBqy1nVR5ULU07AIcrtk+MBBkxHafgJ
         oCnjmop3YXcGw3+XvA2NY9jASPmEp3ukfeDzc4KU/kC60qLo8qQSSauV/Kl/Ep7ydRW0
         +R/sSR7avUG0TObR25M0jMgUpHOoD8poeBwMp/wiaV28mlApj9KJ6HLVnvOxS3i9g1at
         1zukXym+zZbJkKUtw+PPYYNWbugXXyEpp1xkTDcc+Wu4kucesrJlZPUAbpoheUwNqed1
         2SMA==
X-Gm-Message-State: AOAM5317fOoXJH+wIGsXgRHrJaR8DE0L7eaTTd2ULo8OYWyGSxze08sB
        NxpaPDEjmO7nFiMnZsuCDho=
X-Google-Smtp-Source: ABdhPJw0OH+41cpbykBAsEcx59U/t2br0Fb+4UvEqKLP/E+7aYx0kaNn6yca7YT0VZFek6IH0bfLVA==
X-Received: by 2002:a17:90a:5106:: with SMTP id t6mr2348008pjh.177.1617359449296;
        Fri, 02 Apr 2021 03:30:49 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id c12sm8077029pfp.17.2021.04.02.03.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:30:48 -0700 (PDT)
Date:   Fri, 2 Apr 2021 19:30:44 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH 2/2] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YGbyVHNY/55akU9I@shinobu>
References: <20210401153228.2773560-1-jarkko.nikula@linux.intel.com>
 <20210401153228.2773560-2-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VwNjnTqz2PtAXrZW"
Content-Disposition: inline
In-Reply-To: <20210401153228.2773560-2-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--VwNjnTqz2PtAXrZW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 01, 2021 at 06:32:28PM +0300, Jarkko Nikula wrote:
> Add support for Intel Quadrature Encoder Peripheral found on Intel
> Elkhart Lake platform.
>=20
> Initial implementation was done by Felipe Balbi while he was working at
> Intel with later changes from Raymond Tan and me.
>=20
> Co-developed-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Signed-off-by: Felipe Balbi (Intel) <balbi@kernel.org>
> Co-developed-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Raymond Tan <raymond.tan@intel.com>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Hello Jarkko,

Please see the questions and suggestions inline below.

> ---
>  drivers/counter/Kconfig     |  10 +
>  drivers/counter/Makefile    |   1 +
>  drivers/counter/intel-qep.c | 636 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 647 insertions(+)
>  create mode 100644 drivers/counter/intel-qep.c
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 5328705aa09c..d5d2540b30c2 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -91,4 +91,14 @@ config MICROCHIP_TCB_CAPTURE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called microchip-tcb-capture.
> =20
> +config INTEL_QEP
> +	tristate "Intel Quadrature Encoder Peripheral driver"
> +	depends on PCI
> +	help
> +	  Select this option to enable the Intel Quadrature Encoder Peripheral
> +	  driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called intel-qep.
> +
>  endif # COUNTER
> diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> index cb646ed2f039..19742e6f5e3e 100644
> --- a/drivers/counter/Makefile
> +++ b/drivers/counter/Makefile
> @@ -12,3 +12,4 @@ obj-$(CONFIG_STM32_LPTIMER_CNT)	+=3D stm32-lptimer-cnt.o
>  obj-$(CONFIG_TI_EQEP)		+=3D ti-eqep.o
>  obj-$(CONFIG_FTM_QUADDEC)	+=3D ftm-quaddec.o
>  obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+=3D microchip-tcb-capture.o
> +obj-$(CONFIG_INTEL_QEP)		+=3D intel-qep.o
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> new file mode 100644
> index 000000000000..6a05b97e2163
> --- /dev/null
> +++ b/drivers/counter/intel-qep.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Quadrature Encoder Peripheral driver
> + *
> + * Copyright (C) 2019-2021 Intel Corporation
> + *
> + * Author: Felipe Balbi (Intel)
> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> + * Author: Raymond Tan <raymond.tan@intel.com>
> + */
> +#include <linux/bitops.h>
> +#include <linux/counter.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +
> +#define INTEL_QEPCON			0x00
> +#define INTEL_QEPFLT			0x04
> +#define INTEL_QEPCOUNT			0x08
> +#define INTEL_QEPMAX			0x0c
> +#define INTEL_QEPWDT			0x10
> +#define INTEL_QEPCAPDIV			0x14
> +#define INTEL_QEPCNTR			0x18
> +#define INTEL_QEPCAPBUF			0x1c
> +#define INTEL_QEPINT_STAT		0x20
> +#define INTEL_QEPINT_MASK		0x24
> +
> +/* QEPCON */
> +#define INTEL_QEPCON_EN			BIT(0)
> +#define INTEL_QEPCON_FLT_EN		BIT(1)
> +#define INTEL_QEPCON_EDGE_A		BIT(2)
> +#define INTEL_QEPCON_EDGE_B		BIT(3)
> +#define INTEL_QEPCON_EDGE_INDX		BIT(4)
> +#define INTEL_QEPCON_SWPAB		BIT(5)
> +#define INTEL_QEPCON_OP_MODE		BIT(6)
> +#define INTEL_QEPCON_PH_ERR		BIT(7)
> +#define INTEL_QEPCON_COUNT_RST_MODE	BIT(8)
> +#define INTEL_QEPCON_INDX_GATING_MASK	GENMASK(10, 9)
> +#define INTEL_QEPCON_INDX_GATING(n)	(((n) & 3) << 9)
> +#define INTEL_QEPCON_INDX_PAL_PBL	INTEL_QEPCON_INDX_GATING(0)
> +#define INTEL_QEPCON_INDX_PAL_PBH	INTEL_QEPCON_INDX_GATING(1)
> +#define INTEL_QEPCON_INDX_PAH_PBL	INTEL_QEPCON_INDX_GATING(2)
> +#define INTEL_QEPCON_INDX_PAH_PBH	INTEL_QEPCON_INDX_GATING(3)
> +#define INTEL_QEPCON_CAP_MODE		BIT(11)
> +#define INTEL_QEPCON_FIFO_THRE_MASK	GENMASK(14, 12)
> +#define INTEL_QEPCON_FIFO_THRE(n)	((((n) - 1) & 7) << 12)
> +#define INTEL_QEPCON_FIFO_EMPTY		BIT(15)
> +
> +/* QEPFLT */
> +#define INTEL_QEPFLT_MAX_COUNT(n)	((n) & 0x1fffff)
> +
> +/* QEPINT */
> +#define INTEL_QEPINT_FIFOCRIT		BIT(5)
> +#define INTEL_QEPINT_FIFOENTRY		BIT(4)
> +#define INTEL_QEPINT_QEPDIR		BIT(3)
> +#define INTEL_QEPINT_QEPRST_UP		BIT(2)
> +#define INTEL_QEPINT_QEPRST_DOWN	BIT(1)
> +#define INTEL_QEPINT_WDT		BIT(0)
> +
> +#define INTEL_QEPINT_MASK_ALL		GENMASK(5, 0)
> +
> +#define INTEL_QEP_COUNTER_EXT_RW(_name) \
> +{ \
> +	.name =3D #_name, \
> +	.read =3D _name##_read, \
> +	.write =3D _name##_write, \
> +}
> +
> +struct intel_qep {
> +	struct counter_device counter;
> +	struct mutex lock;
> +	struct device *dev;
> +	void __iomem *regs;
> +	bool enabled;
> +	/* Context save registers */
> +	u32 qepcon;
> +	u32 qepflt;
> +	u32 qepmax;
> +};
> +
> +#define counter_to_qep(c)	(container_of((c), struct intel_qep, counter))

You don't need this macro; just use counter->priv where necessary.

> +
> +static inline u32 intel_qep_readl(struct intel_qep *qep, u32 offset)
> +{
> +	return readl(qep->regs + offset);
> +}
> +
> +static inline void intel_qep_writel(struct intel_qep *qep,
> +				    u32 offset, u32 value)
> +{
> +	writel(value, qep->regs + offset);
> +}
> +
> +static void intel_qep_init(struct intel_qep *qep)
> +{
> +	u32 reg;
> +
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	reg &=3D ~INTEL_QEPCON_EN;
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	qep->enabled =3D false;
> +	/*
> +	 * Make sure peripheral is disabled by flushing the write with
> +	 * a dummy read
> +	 */
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +
> +	reg &=3D ~(INTEL_QEPCON_OP_MODE | INTEL_QEPCON_FLT_EN);
> +	reg |=3D INTEL_QEPCON_EDGE_A | INTEL_QEPCON_EDGE_B |
> +	       INTEL_QEPCON_EDGE_INDX | INTEL_QEPCON_COUNT_RST_MODE;
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	intel_qep_writel(qep, INTEL_QEPINT_MASK, INTEL_QEPINT_MASK_ALL);
> +}
> +
> +enum intel_qep_synapse_action {
> +	INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE,
> +	INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE,
> +};
> +
> +static enum counter_synapse_action intel_qep_synapse_actions[] =3D {

This enum can be const too.

> +	[INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE] =3D
> +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> +
> +	[INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE] =3D
> +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> +};

Quadrature x4 mode is expected to evaluate on both edges on both phase
signals. Shouldn't this array have COUNTER_SYNAPSE_ACTION_BOTH_EDGES?

> +
> +enum intel_qep_count_function {
> +	INTEL_QEP_ENCODER_MODE_NORMAL,
> +	INTEL_QEP_ENCODER_MODE_SWAPPED,
> +};
> +
> +static const enum counter_count_function intel_qep_count_functions[] =3D=
 {
> +	[INTEL_QEP_ENCODER_MODE_NORMAL] =3D
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +
> +	[INTEL_QEP_ENCODER_MODE_SWAPPED] =3D
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4_SWAPPED,
> +};
> +
> +static int intel_qep_count_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				unsigned long *val)
> +{
> +	struct intel_qep *const qep =3D counter->priv;
> +	unsigned long cntval;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	cntval =3D intel_qep_readl(qep, INTEL_QEPCOUNT);
> +	*val =3D cntval;

I think *val can be set directly here so cntval can go away.

> +	pm_runtime_put(qep->dev);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_function_get(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  size_t *function)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (reg & INTEL_QEPCON_SWPAB)
> +		*function =3D INTEL_QEP_ENCODER_MODE_SWAPPED;
> +	else
> +		*function =3D INTEL_QEP_ENCODER_MODE_NORMAL;

Would it make sense to place this conditional after pm_runtime_put()?

> +	pm_runtime_put(qep->dev);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_function_set(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  size_t function)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	int ret =3D 0;
> +	u32 reg;
> +
> +	mutex_lock(&qep->lock);
> +	if (qep->enabled) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (function =3D=3D INTEL_QEP_ENCODER_MODE_SWAPPED)
> +		reg |=3D INTEL_QEPCON_SWPAB;
> +	else
> +		reg &=3D ~INTEL_QEPCON_SWPAB;
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	pm_runtime_put(qep->dev);
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +	return ret;
> +}
> +
> +static int intel_qep_action_get(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_synapse *synapse,
> +				size_t *action)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	pm_runtime_put(qep->dev);
> +
> +	*action =3D (reg & synapse->signal->id) ?
> +		INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE :
> +		INTEL_QEP_SYNAPSE_ACTION_FALLING_EDGE;

I'm a bit confused about this quadrature encoding. Is this counting only
one edge on each phase signal?

> +
> +	return 0;
> +}
> +
> +static int intel_qep_action_set(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_synapse *synapse,
> +				size_t action)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	int ret =3D 0;
> +	u32 reg;
> +
> +	mutex_lock(&qep->lock);
> +	if (qep->enabled) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (action =3D=3D INTEL_QEP_SYNAPSE_ACTION_RISING_EDGE)
> +		reg |=3D synapse->signal->id;
> +	else
> +		reg &=3D ~synapse->signal->id;
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	pm_runtime_put(qep->dev);
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +	return ret;
> +}

Are you actually able to set the action mode for the phase signals? My
expectation is that the action mode for the phase signals will always be
"both edges" because the encoding is quadrature x4. What exactly is
happening for the device when you write INTEL_QEPCON?

> +
> +static const struct counter_ops intel_qep_counter_ops =3D {
> +	.count_read =3D intel_qep_count_read,
> +
> +	.function_get =3D intel_qep_function_get,
> +	.function_set =3D intel_qep_function_set,
> +
> +	.action_get =3D intel_qep_action_get,
> +	.action_set =3D intel_qep_action_set,
> +};
> +
> +static struct counter_signal intel_qep_signals[] =3D {
> +	{
> +		.id =3D INTEL_QEPCON_EDGE_A,
> +		.name =3D "Phase A",
> +	},
> +	{
> +		.id =3D INTEL_QEPCON_EDGE_B,
> +		.name =3D "Phase B",
> +	},
> +	{
> +		.id =3D INTEL_QEPCON_EDGE_INDX,
> +		.name =3D "Index",
> +	},
> +};

You are using the "id" member correctly here, but there is a problem I
foresee that we should try to avoid. The behavior of "id" will change in
the coming Counter character device interface patches. Currently, the
signal sysfs attribute's suffix is set to the value of the signal's id,
but once the Counter character device interface patchset is merged, the
sysfs attribute's suffix will match the index of the signal in the
intel_qep_signals array.

Because of this change, it'll be best to use the counter_signal "priv"
member here instead of "id". That should ensure that the userspace paths
do not change for users once the Counter character device interface
changes are merged.

> +
> +static struct counter_synapse intel_qep_count_synapses[] =3D {
> +	{
> +		.actions_list =3D intel_qep_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal =3D &intel_qep_signals[0],
> +	},
> +	{
> +		.actions_list =3D intel_qep_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal =3D &intel_qep_signals[1],
> +	},
> +	{
> +		.actions_list =3D intel_qep_synapse_actions,
> +		.num_actions =3D ARRAY_SIZE(intel_qep_synapse_actions),
> +		.signal =3D &intel_qep_signals[2],
> +	},
> +};
> +
> +static ssize_t ceiling_read(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPMAX);
> +	pm_runtime_put(qep->dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", reg);

Use sysfs_emit() where possible.

> +}
> +
> +static ssize_t ceiling_write(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 max;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 0, &max);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&qep->lock);
> +	if (qep->enabled) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	pm_runtime_get_sync(qep->dev);
> +	intel_qep_writel(qep, INTEL_QEPMAX, max);
> +	pm_runtime_put(qep->dev);
> +	ret =3D len;
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +	return ret;
> +}
> +
> +static ssize_t enable_read(struct counter_device *counter,
> +			   struct counter_count *count,
> +			   void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", qep->enabled);
> +}
> +
> +static ssize_t enable_write(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 0, &val);

"enable" is expected to handle boolean values so use kstrtobool here.

> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&qep->lock);
> +	if (val && !qep->enabled) {
> +		pm_runtime_get_sync(qep->dev);
> +		reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +		reg |=3D INTEL_QEPCON_EN;
> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
> +		qep->enabled =3D true;

Are you missing pm_runtime_put() here?

> +	} else if (!val && qep->enabled) {

Are you missing pm_runtime_get_sync() here?

> +		reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +		reg &=3D ~INTEL_QEPCON_EN;
> +		intel_qep_writel(qep, INTEL_QEPCON, reg);
> +		qep->enabled =3D false;
> +		pm_runtime_put(qep->dev);
> +	}
> +	mutex_unlock(&qep->lock);

If you have both val and qep->enabled as bool, you can make this logic
clearer by evaluating their xor to determine if there's a change. So
something like this:

	bool changed =3D val ^ qep->enabled;
	if (!changed)
		return len;
	mutex_lock(&qep->lock);
	pm_runtime_get_sync(qep->dev);
	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
	if (val)
		reg |=3D INTEL_QEPCON_EN;
	else
		reg &=3D ~INTEL_QEPCON_EN;
	intel_qep_writel(qep, INTEL_QEPCON, reg);
	qep->enabled =3D val;
	pm_runtime_put(qep->dev);
	mutex_unlock(&qep->lock);

> +
> +	return len;
> +}
> +
> +static const struct counter_count_ext intel_qep_count_ext[] =3D {
> +	INTEL_QEP_COUNTER_EXT_RW(ceiling),
> +	INTEL_QEP_COUNTER_EXT_RW(enable),
> +};
> +
> +static struct counter_count intel_qep_counter_count[] =3D {
> +	{
> +		.id =3D 0,
> +		.name =3D "Channel 1 Count",
> +		.functions_list =3D intel_qep_count_functions,
> +		.num_functions =3D ARRAY_SIZE(intel_qep_count_functions),
> +		.synapses =3D intel_qep_count_synapses,
> +		.num_synapses =3D ARRAY_SIZE(intel_qep_count_synapses),
> +		.ext =3D intel_qep_count_ext,
> +		.num_ext =3D ARRAY_SIZE(intel_qep_count_ext),
> +	},
> +};
> +
> +static ssize_t noise_read(struct counter_device *counter,
> +			  void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (!(reg & INTEL_QEPCON_FLT_EN)) {
> +		pm_runtime_put(qep->dev);
> +		return snprintf(buf, PAGE_SIZE, "0\n");
> +	}
> +	reg =3D intel_qep_readl(qep, INTEL_QEPFLT);
> +	pm_runtime_put(qep->dev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%d\n", INTEL_QEPFLT_MAX_COUNT(reg));

Please print this as an unsigned integer.

> +}
> +
> +static ssize_t noise_write(struct counter_device *counter,
> +			   void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +	u32 max;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 0, &max);
> +	if (ret < 0)
> +		return ret;
> +	if (max > INTEL_QEPFLT_MAX_COUNT(max))
> +		return -EINVAL;
> +
> +	mutex_lock(&qep->lock);
> +	if (qep->enabled) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (max =3D=3D 0) {
> +		reg &=3D ~INTEL_QEPCON_FLT_EN;
> +	} else {
> +		reg |=3D INTEL_QEPCON_FLT_EN;
> +		intel_qep_writel(qep, INTEL_QEPFLT, max);
> +	}
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	pm_runtime_put(qep->dev);
> +	ret =3D len;
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +	return ret;
> +}
> +
> +static ssize_t preset_enable_read(struct counter_device *counter,
> +				  void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	pm_runtime_put(qep->dev);
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			!(reg & INTEL_QEPCON_COUNT_RST_MODE));
> +}
> +
> +static ssize_t preset_enable_write(struct counter_device *counter,
> +				   void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter_to_qep(counter);
> +	u32 reg;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&qep->lock);
> +	if (qep->enabled) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (val)
> +		reg &=3D ~INTEL_QEPCON_COUNT_RST_MODE;
> +	else
> +		reg |=3D INTEL_QEPCON_COUNT_RST_MODE;
> +
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	pm_runtime_put(qep->dev);
> +	ret =3D len;
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +
> +	return ret;
> +}
> +
> +static const struct counter_device_ext intel_qep_ext[] =3D {
> +	INTEL_QEP_COUNTER_EXT_RW(noise),
> +	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
> +};

"noise" is a new attribute so you'll need to provide an entry in
Documentation/ABI/testing/sysfs-bus-counter explaining it.

Would it make sense for these two Extensions to be part of the
intel_qep_count_ext array instead? It seems at the very least
"preset_enable" should be moved there because it relates solely to the
Count.

William Breathitt Gray

> +
> +static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_=
id *id)
> +{
> +	struct intel_qep *qep;
> +	struct device *dev =3D &pci->dev;
> +	void __iomem *regs;
> +	int ret;
> +
> +	qep =3D devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
> +	if (!qep)
> +		return -ENOMEM;
> +
> +	ret =3D pcim_enable_device(pci);
> +	if (ret)
> +		return ret;
> +
> +	pci_set_master(pci);
> +
> +	ret =3D pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> +	if (ret)
> +		return ret;
> +
> +	regs =3D pcim_iomap_table(pci)[0];
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	qep->dev =3D dev;
> +	qep->regs =3D regs;
> +	mutex_init(&qep->lock);
> +
> +	intel_qep_init(qep);
> +	pci_set_drvdata(pci, qep);
> +
> +	qep->counter.name =3D pci_name(pci);
> +	qep->counter.parent =3D dev;
> +	qep->counter.ops =3D &intel_qep_counter_ops;
> +	qep->counter.counts =3D intel_qep_counter_count;
> +	qep->counter.num_counts =3D ARRAY_SIZE(intel_qep_counter_count);
> +	qep->counter.signals =3D intel_qep_signals;
> +	qep->counter.num_signals =3D ARRAY_SIZE(intel_qep_signals);
> +	qep->counter.ext =3D intel_qep_ext;
> +	qep->counter.num_ext =3D ARRAY_SIZE(intel_qep_ext);
> +	qep->counter.priv =3D qep;
> +	qep->enabled =3D false;
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_allow(dev);
> +
> +	return devm_counter_register(&pci->dev, &qep->counter);
> +}
> +
> +static void intel_qep_remove(struct pci_dev *pci)
> +{
> +	struct intel_qep *qep =3D pci_get_drvdata(pci);
> +	struct device *dev =3D &pci->dev;
> +
> +	pm_runtime_forbid(dev);
> +	if (!qep->enabled)
> +		pm_runtime_get(dev);
> +
> +	intel_qep_writel(qep, INTEL_QEPCON, 0);
> +}
> +
> +#ifdef CONFIG_PM
> +static int intel_qep_suspend(struct device *dev)
> +{
> +	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> +	struct intel_qep *qep =3D pci_get_drvdata(pdev);
> +
> +	qep->qepcon =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	qep->qepflt =3D intel_qep_readl(qep, INTEL_QEPFLT);
> +	qep->qepmax =3D intel_qep_readl(qep, INTEL_QEPMAX);
> +
> +	return 0;
> +}
> +
> +static int intel_qep_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
> +	struct intel_qep *qep =3D pci_get_drvdata(pdev);
> +
> +	/*
> +	 * Make sure peripheral is disabled when restoring registers and
> +	 * control register bits that are writable only when the peripheral
> +	 * is disabled
> +	 */
> +	intel_qep_writel(qep, INTEL_QEPCON, 0);
> +	intel_qep_readl(qep, INTEL_QEPCON);
> +
> +	intel_qep_writel(qep, INTEL_QEPFLT, qep->qepflt);
> +	intel_qep_writel(qep, INTEL_QEPMAX, qep->qepmax);
> +	intel_qep_writel(qep, INTEL_QEPINT_MASK, INTEL_QEPINT_MASK_ALL);
> +
> +	/* Restore all other control register bits except enable status */
> +	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon & ~INTEL_QEPCON_EN);
> +	intel_qep_readl(qep, INTEL_QEPCON);
> +
> +	/* Restore enable status */
> +	intel_qep_writel(qep, INTEL_QEPCON, qep->qepcon);
> +
> +	return 0;
> +}
> +#endif
> +
> +static UNIVERSAL_DEV_PM_OPS(intel_qep_pm_ops,
> +			    intel_qep_suspend, intel_qep_resume, NULL);
> +
> +static const struct pci_device_id intel_qep_id_table[] =3D {
> +	/* EHL */
> +	{ PCI_VDEVICE(INTEL, 0x4bc3), },
> +	{ PCI_VDEVICE(INTEL, 0x4b81), },
> +	{ PCI_VDEVICE(INTEL, 0x4b82), },
> +	{ PCI_VDEVICE(INTEL, 0x4b83), },
> +	{  } /* Terminating Entry */
> +};
> +MODULE_DEVICE_TABLE(pci, intel_qep_id_table);
> +
> +static struct pci_driver intel_qep_driver =3D {
> +	.name =3D "intel-qep",
> +	.id_table =3D intel_qep_id_table,
> +	.probe =3D intel_qep_probe,
> +	.remove =3D intel_qep_remove,
> +	.driver =3D {
> +		.pm =3D &intel_qep_pm_ops,
> +	}
> +};
> +
> +module_pci_driver(intel_qep_driver);
> +
> +MODULE_AUTHOR("Felipe Balbi (Intel)");
> +MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
> +MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Intel Quadrature Encoder Peripheral driver");
> --=20
> 2.30.2
>=20

--VwNjnTqz2PtAXrZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmBm8kAACgkQhvpINdm7
VJJlhw/+P1zp3ZPb4XKzYCS1510n1W+Ay/6WeUyDnWam+9P8kzA1/8mt0zLJ9D+P
T6JHAUI8SmsQ6fVL0n0SMg7NBn/NzSiWb4par/ojSVRevOUfR6OvpquLXO7+9xh6
g6eOUMwAQDq7l4uc21LuUQz1tJ89c0+nO7MBzVGsz5YlgaGOdzZCVE1hV4KzfsUD
Maez5HZseswA/nfQfCwFdap3x/MGL3git36XyARfCCBJUKBZvu+ls/jH8706IJWG
GGzcB815XNdVJD1uf9aDd8IuLH0h8qbUzK0g3zBfLLDOcVZzb/Z90vvP1DTULSn9
7C0g7LmyLam8/sDMSnAA9rixbP15DjD2ypTTs6Zb7Hn54qN315B82aGV8ONQQR8i
WMmE8Y524on5z6m/jkkOCmGS+Fg0mWnk63uRJq0ItK88VtFF7PbwzF8rBJyIzHva
+YrnN2S/FuJn8clzYDw4TQ778WeOD9airhayaam5pAiY2d7yd0Ax+Kxu0zGChXk1
ezZE2sWnz4IRVG2gxB6tr8k1OofyGy04gAVG9HmPj9i/Tt0tNIUJZGgA8YLHqbmQ
rIhNxeafZJNSx21VKAZiFab/nTGlDc14TwbbNb9M/Ybi+NOlE7d7xUU9FubBCZkq
Ahdl7FJq+ynljAr3rXPiwh8mwD6UIEUEFhCYVzK3+Zht/StVBXM=
=DDCF
-----END PGP SIGNATURE-----

--VwNjnTqz2PtAXrZW--
