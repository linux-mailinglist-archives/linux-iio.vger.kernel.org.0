Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89747393C74
	for <lists+linux-iio@lfdr.de>; Fri, 28 May 2021 06:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhE1E3t (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 May 2021 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhE1E3t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 May 2021 00:29:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD7C061574
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 21:28:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s4so1012488plg.12
        for <linux-iio@vger.kernel.org>; Thu, 27 May 2021 21:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHQXOXT0XWZGYU40OoFT/qfIaZZSS4sBGKfhpvNFSCM=;
        b=PKwOKY5CyC4P87FGRzPIJ/u8kIK2GzfhmDHsn/rRhxq2v6Dq9FEtAYS4WFTcz9FXIe
         Mu2hleOUj9orIQsnjGAY8/KuAYgnDwp7FXsSRah3HQfZ2iDTr9GMGJ5xAbEkYPmwWMj4
         IE9KeKN9gkevx0a94reqBwztgjLtN56ZDMiOtAl+9bP6KrqFRrv/rIsiNKfGSA9ZvLDi
         YwxwFjjC3t6Vf83zjo9C65ONxdKk4j0ch53l/eJR0BZaVFA8AZ1zNcBX/G8NkniD6qWW
         dOFqhQExzCUd5QZ3yh6cogbTT5CSNACz/WB2jJ4xEsjwt/2al7arfIjGe+/Zx5shu45d
         TJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHQXOXT0XWZGYU40OoFT/qfIaZZSS4sBGKfhpvNFSCM=;
        b=Rba8cvGobhA4bZDA7/Nfg9tkO0GGLJ1cxhTv8eerwa6Ppfs+lGzuz494ADSc5SJdM4
         KlawFkYFewKTnBXOE3qc//uTgf9K8aJeZYX9rvhCNcJZnXLSyWk8Rm9el1NnYPPUlGZp
         ArzJJfbWiVb0FuBEiD26zyQ1SRQVk7PSRm7oqoVbbdffO3X5+nBpGol2V4X8wZA6Z55W
         cZOCbfCVfZYWxdoV52QB1n9xSe4DI+4fhaTTs5ZgdxxqCpqjISvJOlqgZJzX0RnTqR9F
         dvcIfLR4t79wYWP7SS2qWhln9X/YAKXiKaM98Rl9/k2Ok86gL19R26CRBc/BOtuBzFJf
         SxFQ==
X-Gm-Message-State: AOAM5318uLWcDrq9QgYFZ//Foyprkpr9RgmR2imsQPoP62acDkCdsxkx
        MtpxmoCxoQSA4QVF1TkAN4U=
X-Google-Smtp-Source: ABdhPJwQA7HUPlreKuMqltCVmdZ7aBTHFCpnIlg7xyk/GBt9EtzdzxPrpzl1+X5crNbGF1xo5z/WLQ==
X-Received: by 2002:a17:90a:a60d:: with SMTP id c13mr2292819pjq.172.1622176094487;
        Thu, 27 May 2021 21:28:14 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id 21sm3044023pfh.103.2021.05.27.21.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 21:28:13 -0700 (PDT)
Date:   Fri, 28 May 2021 13:28:09 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v3] counter: Add support for Intel Quadrature Encoder
 Peripheral
Message-ID: <YLBxWeABMGCUHL9z@shinobu>
References: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rSBT53Hv2xW3MDze"
Content-Disposition: inline
In-Reply-To: <20210527135838.3853285-1-jarkko.nikula@linux.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rSBT53Hv2xW3MDze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 27, 2021 at 04:58:38PM +0300, Jarkko Nikula wrote:
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

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> v3:
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
>  drivers/counter/Kconfig                     |  10 +
>  drivers/counter/Makefile                    |   1 +
>  drivers/counter/intel-qep.c                 | 546 ++++++++++++++++++++
>  4 files changed, 566 insertions(+)
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

--rSBT53Hv2xW3MDze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmCwcU8ACgkQhvpINdm7
VJL2ihAAyJyYWsvrIjmxkz6hy+GE0G64+hrsvmo7675MI1DBMVH8rbEVh2C7o7Or
h7yPwQ6CILUevXEzhRZtQoB6sfH2V+L+chQhFVIDaxgjxBIfZEF+gebyN4JsYCp1
VR1dNAhCA538m7VJ4FI1NpIvaRfOSKgaV5DHw5lPkHNscizBxcPci+pcoXq21IwU
iEWUuXGNGa4loJD7J3s8VO+tTFonTp2XPBhZuMu9sx+Nzwk1yILoQiM8MgCqncc4
pnABwkbH3dCdv6YfHntp1MAg1JALXey8/C4WFvSvQoI5MlHprcgwnBIyLIK7+l0X
59CYaeh2gOaXilFsf4KHYG5DGYiEi0Snd57jN99uSASKeIYBf7pGXhf9WZBpyXmR
wuBwQMXRlANr+wRn9R33MDnMKaJfiA1Q2Hit3ot0zZnihPT6g5vsis13+u1AC3W/
KHPoeXbTbSO6g1CayX63x7W75cvNlaFwC+qrWbJEAqabrMPsCdkgCfheLBlmfdt7
cpaXBHsGzVSokltO4EHRgwkUWDU+GjWvWww1gO/rP+ukXMDlAx16MEcoVd9MRGrh
l1oi/GRNoz5CaakSNSaHhx+Ac5rq0V6bz6SO8jvO07eyLYh76XrvjbQI4p0LsVHh
rPgKT9MzkrGEwDpAIMDriDFvsqukwvLSmF9iiDu3R8DjhlY2/uA=
=nv70
-----END PGP SIGNATURE-----

--rSBT53Hv2xW3MDze--
