Return-Path: <linux-iio+bounces-19148-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB10AA9BC0
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D385817C2E1
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A626F444;
	Mon,  5 May 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKc/2tY7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D21B0F31;
	Mon,  5 May 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470537; cv=none; b=hBeaFNChOsWuqVTTNQWfYAIqmREenIixPEy5JJJY8a+tM5Fb8Yh+pTqIwkov0mppZh+m3HJG9EeruT8C23iIlK0K8EC8+fensEFu5MA4eo4mDo/Z3VNwwZ+TAOAkmm9JwV+jBmmfp8RWZckAqNDNT8eKHFhPuJvm7R2MdrdJl6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470537; c=relaxed/simple;
	bh=WsVm1VWhGB/q4UiDgJw4yMWmXTJdExntWW8us53Bh/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S628Ge3R53BUfRwr6GW/JM6cTUu4khSh/ReZAnhOxLmr7tW8MR6yuUyVgonIYD8USLxnk0Lr/pQWx2Ldv6R/PQ+27/LOv+I0WniFGGz7DOw8cGSvej6BqEv5rPhD3rP7HiYRpn7DL4jlrWa+QmI29tDsyxVYy5hiegbM6rGdmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKc/2tY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2312C4CEE4;
	Mon,  5 May 2025 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746470537;
	bh=WsVm1VWhGB/q4UiDgJw4yMWmXTJdExntWW8us53Bh/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cKc/2tY7I2KB0TePdp8Ms5GA6WLpmkSNtLG4wW++4Ho1tEwdtjNXd2kMLh/eMf6vy
	 vX6b94sG5BXKyh4McwhxanJbFRFwCwRmJBuJQRtZ2hBNAKW5lwCoxbO0BxCKFU1Q5n
	 1QxTLBV1Zv7f90aZXNEOldeZgw02NJNGlNIcvZszYb6tTlX1U4XwBBpSuqS1xv738G
	 DUbqRBCwrnRkLrvfebmHXSwxVXuqoNZ3Se3/EqUXCtJlg40b4eMD6ws71Ky5UQHAZR
	 fEUG1tp6twf0tNT3+KKSAjsNe+j957+tok2IS2J2QVzHWmWNBZkH2D8ghiYePwxWhp
	 s2LH5kGSH2ldw==
Date: Mon, 5 May 2025 19:42:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 javier.carrasco.cruz@gmail.com, alisadariana@gmail.com,
 olivier.moysan@foss.st.com, tgamblin@baylibre.com, eblanc@baylibre.com,
 antoniu.miclaus@analog.com, andriy.shevchenko@linux.intel.com,
 gstols@baylibre.com, ramona.nechita@analog.com, matteomartelli3@gmail.com,
 marcelo.schmitt@analog.com, chanh@os.amperecomputing.com,
 KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <20250505194204.3ef319a2@jic23-huawei>
In-Reply-To: <20250505092600.962675-3-j2anfernee@gmail.com>
References: <20250505092600.962675-1-j2anfernee@gmail.com>
	<20250505092600.962675-3-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 May 2025 17:26:00 +0800
Eason Yang <j2anfernee@gmail.com> wrote:

> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

As below. Setup of threshold events seems to be here, but not the interrupt
handler that would call iio_push_event() to actually notify userspace they
occurred.  Is the intent they are getting wired to something else?

Even if that is the intent we normally cross wire them to the host as well
so as to be able to find out what happened.  The use in here of client->irq
implies such wiring but no sign of it being handled.


Jonathan


> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/adc/Kconfig   |  11 +
>  drivers/iio/adc/Makefile  |   1 +
>  drivers/iio/adc/nct7201.c | 462 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 475 insertions(+)
>  create mode 100644 drivers/iio/adc/nct7201.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85b031ad7082..065202ab8fe7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17378,6 +17378,7 @@ M:	Eason Yang <j2anfernee@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
> +F:	drivers/iio/adc/nct7201.c
>  
>  NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
>  M:	Antonino Daplas <adaplas@gmail.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 6529df1a498c..6d6af1b51b5e 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1092,6 +1092,17 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
>  
> +config NCT7201
> +	tristate "Nuvoton Instruments NCT7201 and NCT7202 Power Monitor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  If you say yes here you get support for the Nuvoton NCT7201 and
> +	  NCT7202 Voltage Monitor.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nct7201.
> +
>  config NPCM_ADC
>  	tristate "Nuvoton NPCM ADC driver"
>  	depends on ARCH_NPCM || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 3e918c3eec69..54e8a7541af6 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
>  obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
>  obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
> +obj-$(CONFIG_NCT7201) += nct7201.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
> diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
> new file mode 100644
> index 000000000000..0dadf699162a
> --- /dev/null
> +++ b/drivers/iio/adc/nct7201.c
> @@ -0,0 +1,462 @@

> +static const struct iio_event_spec nct7201_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_ENABLE),
> +	},
I'd missed this before but you spend lots of time setting up event
detectors etc which all looks good, but where are they actually signalled?

The irq handler seems to be missing.

> +};

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	struct device *dev = regmap_get_device(chip->regmap);
> +	__le16 data = cpu_to_le16(GENMASK(chip->num_vin_channels - 1, 0));
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +			   NCT7201_BIT_CONFIGURATION_RESET);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to reset chip\n");
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then the power-up
> +	 * bit will be set to 1. If not, wait for it.

Trivial but you don't "wait for it."  That's the right choice here but the comment is
misleading.

> +	 */
> +	fsleep(25 * USEC_PER_MSEC);
> +
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to read busy status\n");
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(dev, -EIO, "Failed to power up after reset\n");
> +

