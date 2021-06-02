Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245FD398C9D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 16:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBOXd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 10:23:33 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35344 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFBOXW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 10:23:22 -0400
Received: by mail-pf1-f180.google.com with SMTP id g18so2324306pfr.2
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=37FoAB4GXx0//+ETpDgTlAExItEML80SpneSHBFLma4=;
        b=Cw6/iZVZfek6eXdizhvN1+4b0fGUCGfB6d3Kx/nhKz8HTZY5ch4vrNpFog4cCrjY0x
         AJHDL7CGZbxZuYsN3saLdAWapLGq0UqmRSpstzPXcDQIItEBF7XCL7d46ay0spngAFXy
         +/FT9jJWucqp1ph+MM8Bs3tLVfP3tDzModFA/N3/M7PJW+5q7F20PVS3BDJ9lSCn0FSq
         Pnv45ezu3RHQFjWnFJTanEU8nS2Udcsc8ZDyQ/F0soiRoAjyzZgal/DT+/sqhN7XAcsY
         PnC2DRdTNyB3Og5ltpojyNvD7mAcejnRTBU7/+COxgOyUr6nNxEkI0zEc17Z69lEAc0m
         aDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=37FoAB4GXx0//+ETpDgTlAExItEML80SpneSHBFLma4=;
        b=q88A9f8/tHHl0mCOP5zQFdGLe3VhfbEs5+gyOUzNsqf49Z9gR60kXW4G+wtdU5EDUB
         J5HiqIDmiqNf/R2K35dJgmLfU9LgutWskrXwS2kyxKYhqmsyl2GNDLiLLoGqRBVxepni
         Mxen2T1sKCwTafWCqD5k7cz/AcRMJZh4bXp9ses5rtDlOa/I98rgXuZwJRoXFBRbtq/y
         FA4vf9yPz7JeqLk8Pdvr3DyQvyA+7suddZrEa4x3NdtOLJ3MlNzXUHFf8p7df0oySqbE
         pUv9WT0mgW3i4YEt9ri6UQGstxBLjnfebrXnxiHSweMBQ0KKwx6dkq+V3VzFopI3HYbd
         GQPA==
X-Gm-Message-State: AOAM532pOTi+90n121SNCObGYuCOC0DmAfjad510oEBBiPxQZqyoBKDC
        aVQeiUGAQPF5OJLpynOXjYFvZn4gFNOjPg==
X-Google-Smtp-Source: ABdhPJxQUYJj7KmBywFqpoXkeVS/1oQElEXuqB8/hAyeIH0+awA33iS8EGKVtru4CWUh0uZpWgWKLQ==
X-Received: by 2002:a05:6a00:856:b029:2dc:bd34:9f7e with SMTP id q22-20020a056a000856b02902dcbd349f7emr28028993pfk.0.1622643639339;
        Wed, 02 Jun 2021 07:20:39 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id u8sm7040pgg.51.2021.06.02.07.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:20:38 -0700 (PDT)
Date:   Wed, 2 Jun 2021 23:20:34 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v4] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YLeTsqD7CWZivJe5@shinobu>
References: <20210602113259.158674-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oum/R+zaHtLz+wGw"
Content-Disposition: inline
In-Reply-To: <20210602113259.158674-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--oum/R+zaHtLz+wGw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 02, 2021 at 02:32:59PM +0300, Jarkko Nikula wrote:
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

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> v4:
> - Added MAINTAINERS entry
>=20
> v3: https://marc.info/?l=3Dlinux-iio&m=3D162212392207734&w=3D2
> - Support for Quadrature x4 with swapped inputs and inverted inputs
>   removed. It turned out in review discussion both are board specific
>   features and questionable should they be even exposed to userspace.
>   Both features are postponed to future contribution if such need arises.
>   Patch 1/2 removed becaused of this.
> - Error out if trying to set 1 clock period long spike filter. Previous
>   version silently disabled the filter and also sysfs behavior in that
>   case was inconsistent: write 10 but read returns 0.
> - Line-continuation characters in INTEL_QEP_COUNTER_EXT_RW() aligned the
>   same way than others.
>=20
> v2: https://marc.info/?l=3Dlinux-iio&m=3D162204156231555&w=3D2
> - counter_to_qep() macro -> counter->priv
> - Use sysfs_emit for user space returned values
> - Use kstrbool for boolean values from userspace
> - enable_write() reworked to be more readable
> - Reworked synapse action control and new sysfs attribute "invert"
>   * Action control before was wrong - what HW does is signal inversion.
>     Implemented "invert" sysfs attribute for it and read-only action
>     mode sysfs returning constant "both edges"
> - Renamed sysfs attribe "noise" as "spike_filter_ns" and define
>   programmable spike filter in terms of nanoseconds instead of raw
>   register value
> - Above and "ceiling" sysfs attribe changed as count extensions instead
>   of device extensions
> - Signal IDs rearranged to be zero based in order to prepare for counter
>   character device interface patches in order to ensure same userspace
>   sysfs paths
> - Initializer macros for counter_signal and counter_synapse
>   initialization
> - Grouping intel_qep_counter_ops, intel_qep_signal_ext and enums near to
>   their callback functions and use
> - "invert" and "spike_filter_ns" sysfs attributes documented
> - Other minor changes like local variable and empty line removal, etc
>=20
> v1: https://www.spinics.net/lists/linux-iio/msg59652.html
> ---
>  Documentation/ABI/testing/sysfs-bus-counter |   9 +
>  MAINTAINERS                                 |   5 +
>  drivers/counter/Kconfig                     |  10 +
>  drivers/counter/Makefile                    |   1 +
>  drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++++
>  5 files changed, 571 insertions(+)
>  create mode 100644 drivers/counter/intel-qep.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/=
ABI/testing/sysfs-bus-counter
> index 566bd99fe0a5..e9d9e50f03be 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -193,6 +193,15 @@ Description:
>  		both edges:
>  			Any state transition.
> =20
> +What:		/sys/bus/counter/devices/counterX/countY/spike_filter_ns
> +KernelVersion:	5.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		If the counter device supports programmable spike filter this
> +		attribute indicates the value in nanoseconds where noise pulses
> +		shorter or equal to configured value are ignored. Value 0 means
> +		filter is disabled.
> +
>  What:		/sys/bus/counter/devices/counterX/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a2517768404a..2489a6d6a2e4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9428,6 +9428,11 @@ L:	linux-pm@vger.kernel.org
>  S:	Supported
>  F:	drivers/cpufreq/intel_pstate.c
> =20
> +INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
> +M:	Jarkko Nikula <jarkko.nikula@linux.intel.com>
> +L:	linux-iio@vger.kernel.org
> +F:	drivers/counter/intel-qep.c
> +
>  INTEL RDMA RNIC DRIVER
>  M:	Faisal Latif <faisal.latif@intel.com>
>  M:	Shiraz Saleem <shiraz.saleem@intel.com>
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
> index 000000000000..ab10ba33f46a
> --- /dev/null
> +++ b/drivers/counter/intel-qep.c
> @@ -0,0 +1,546 @@
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
> +#define INTEL_QEP_CLK_PERIOD_NS		10
> +
> +#define INTEL_QEP_COUNTER_EXT_RW(_name)				\
> +{								\
> +	.name =3D #_name,						\
> +	.read =3D _name##_read,					\
> +	.write =3D _name##_write,					\
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
> +static int intel_qep_count_read(struct counter_device *counter,
> +				struct counter_count *count,
> +				unsigned long *val)
> +{
> +	struct intel_qep *const qep =3D counter->priv;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	*val =3D intel_qep_readl(qep, INTEL_QEPCOUNT);
> +	pm_runtime_put(qep->dev);
> +
> +	return 0;
> +}
> +
> +static const enum counter_count_function intel_qep_count_functions[] =3D=
 {
> +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> +};
> +
> +static int intel_qep_function_get(struct counter_device *counter,
> +				  struct counter_count *count,
> +				  size_t *function)
> +{
> +	*function =3D 0;
> +
> +	return 0;
> +}
> +
> +static const enum counter_synapse_action intel_qep_synapse_actions[] =3D=
 {
> +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> +};
> +
> +static int intel_qep_action_get(struct counter_device *counter,
> +				struct counter_count *count,
> +				struct counter_synapse *synapse,
> +				size_t *action)
> +{
> +	*action =3D 0;
> +	return 0;
> +}
> +
> +static const struct counter_ops intel_qep_counter_ops =3D {
> +	.count_read =3D intel_qep_count_read,
> +	.function_get =3D intel_qep_function_get,
> +	.action_get =3D intel_qep_action_get,
> +};
> +
> +#define INTEL_QEP_SIGNAL(_id, _name) {				\
> +	.id =3D (_id),						\
> +	.name =3D (_name),					\
> +}
> +
> +static struct counter_signal intel_qep_signals[] =3D {
> +	INTEL_QEP_SIGNAL(0, "Phase A"),
> +	INTEL_QEP_SIGNAL(1, "Phase B"),
> +	INTEL_QEP_SIGNAL(2, "Index"),
> +};
> +
> +#define INTEL_QEP_SYNAPSE(_signal_id) {				\
> +	.actions_list =3D intel_qep_synapse_actions,		\
> +	.num_actions =3D ARRAY_SIZE(intel_qep_synapse_actions),	\
> +	.signal =3D &intel_qep_signals[(_signal_id)],		\
> +}
> +
> +static struct counter_synapse intel_qep_count_synapses[] =3D {
> +	INTEL_QEP_SYNAPSE(0),
> +	INTEL_QEP_SYNAPSE(1),
> +	INTEL_QEP_SYNAPSE(2),
> +};
> +
> +static ssize_t ceiling_read(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPMAX);
> +	pm_runtime_put(qep->dev);
> +
> +	return sysfs_emit(buf, "%u\n", reg);
> +}
> +
> +static ssize_t ceiling_write(struct counter_device *counter,
> +			     struct counter_count *count,
> +			     void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter->priv;
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
> +	struct intel_qep *qep =3D counter->priv;
> +
> +	return sysfs_emit(buf, "%u\n", qep->enabled);
> +}
> +
> +static ssize_t enable_write(struct counter_device *counter,
> +			    struct counter_count *count,
> +			    void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg;
> +	bool val, changed;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&qep->lock);
> +	changed =3D val ^ qep->enabled;
> +	if (!changed)
> +		goto out;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (val) {
> +		/* Enable peripheral and keep runtime PM always on */
> +		reg |=3D INTEL_QEPCON_EN;
> +		pm_runtime_get_noresume(qep->dev);
> +	} else {
> +		/* Let runtime PM be idle and disable peripheral */
> +		pm_runtime_put_noidle(qep->dev);
> +		reg &=3D ~INTEL_QEPCON_EN;
> +	}
> +	intel_qep_writel(qep, INTEL_QEPCON, reg);
> +	pm_runtime_put(qep->dev);
> +	qep->enabled =3D val;
> +
> +out:
> +	mutex_unlock(&qep->lock);
> +	return len;
> +}
> +
> +static ssize_t spike_filter_ns_read(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	if (!(reg & INTEL_QEPCON_FLT_EN)) {
> +		pm_runtime_put(qep->dev);
> +		return sysfs_emit(buf, "0\n");
> +	}
> +	reg =3D INTEL_QEPFLT_MAX_COUNT(intel_qep_readl(qep, INTEL_QEPFLT));
> +	pm_runtime_put(qep->dev);
> +
> +	return sysfs_emit(buf, "%u\n", (reg + 2) * INTEL_QEP_CLK_PERIOD_NS);
> +}
> +
> +static ssize_t spike_filter_ns_write(struct counter_device *counter,
> +				     struct counter_count *count,
> +				     void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg, length;
> +	bool enable;
> +	int ret;
> +
> +	ret =3D kstrtou32(buf, 0, &length);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Spike filter length is (MAX_COUNT + 2) clock periods.
> +	 * Disable filter when userspace writes 0, enable for valid
> +	 * nanoseconds values and error out otherwise.
> +	 */
> +	length /=3D INTEL_QEP_CLK_PERIOD_NS;
> +	if (length =3D=3D 0) {
> +		enable =3D false;
> +		length =3D 0;
> +	} else if (length >=3D 2) {
> +		enable =3D true;
> +		length -=3D 2;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	if (length > INTEL_QEPFLT_MAX_COUNT(length))
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
> +	if (enable)
> +		reg |=3D INTEL_QEPCON_FLT_EN;
> +	else
> +		reg &=3D ~INTEL_QEPCON_FLT_EN;
> +	intel_qep_writel(qep, INTEL_QEPFLT, length);
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
> +				  struct counter_count *count,
> +				  void *priv, char *buf)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg;
> +
> +	pm_runtime_get_sync(qep->dev);
> +	reg =3D intel_qep_readl(qep, INTEL_QEPCON);
> +	pm_runtime_put(qep->dev);
> +	return sysfs_emit(buf, "%u\n", !(reg & INTEL_QEPCON_COUNT_RST_MODE));
> +}
> +
> +static ssize_t preset_enable_write(struct counter_device *counter,
> +				   struct counter_count *count,
> +				   void *priv, const char *buf, size_t len)
> +{
> +	struct intel_qep *qep =3D counter->priv;
> +	u32 reg;
> +	bool val;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
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
> +static const struct counter_count_ext intel_qep_count_ext[] =3D {
> +	INTEL_QEP_COUNTER_EXT_RW(ceiling),
> +	INTEL_QEP_COUNTER_EXT_RW(enable),
> +	INTEL_QEP_COUNTER_EXT_RW(spike_filter_ns),
> +	INTEL_QEP_COUNTER_EXT_RW(preset_enable)
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

--oum/R+zaHtLz+wGw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmC3k6UACgkQhvpINdm7
VJIqGBAA5Kj96GqNTIPdpwG0cO5yY9CZ1JPMznFNpl0TdQpiiGmd+gW1BqrQ18wS
UvlGtXUVXwYPYmExkGt58XtXyUfYARUqTbviebTssqww5Y41nqt2VEOTq8C5GZaY
0T8Gvmaiz9achIQXfaCZtkz7YHZqlD5ecEuVa44mQG4fP/RmF6PlRmA/RXc6qGwy
zkS57pz5MidBY7DGNvMI4fL16q3kWTJ7SQ7ExBDErxiuhzPB52b1Xm9cXGAehyWP
5K1xvoVRVqZcpoJRSm4u3RFNJ/JRBqAwcUorYC0CXgZkePw5s6KfIBw/8LWd6KLx
iMqI8HYayYG/BrKy7y9Dy42zXOEidBvBeYD1cf8m7SC9ZZOPHog9iNTGRWsk8FJ7
3k7OKPBcxV4Sz9Vb/xuB+zDeiIh2f/U2F1TAcagyU73PFVM9T+pDOBE7n0GxPO20
wXveWM6qWZLX/Mhzqd3ukia7ykh5GWd9T575nFiLDpGctPCrTxvTOWZE7ZoIR8Wf
bGrwprhtCJc8sdk+pa15AfJsCe8BAG1NwSuTn5PV2PW6zUk24y8ppKsUaMYpAwnz
VJI6TQwLbzAPuSCKqIVqnc7hYO3QvMQYhJaH1h1WqdUinUiXIisSj+rubBIRWZLv
TDCutmo7mAGlO58SYv8YeQbfZZOIOJMrLDbrAQ3+k1WKwN3YdrQ=
=Wjio
-----END PGP SIGNATURE-----

--oum/R+zaHtLz+wGw--
