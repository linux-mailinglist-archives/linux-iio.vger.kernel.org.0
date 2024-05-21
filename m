Return-Path: <linux-iio+bounces-5159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6559D8CAE2A
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7231C21D7E
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727BA76057;
	Tue, 21 May 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxT3tGBq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2955D524C9;
	Tue, 21 May 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716294461; cv=none; b=mXX4l5B1tkeB+FvNT5BP1U3D0+OV492lOfhF04HWsP45qJt11DMsSzpkLMVRzRsTFrq+fUAEWeVWrVQ80lcWY4f42usfSYQDuz8wIVkmS5W8zJ8pBK/LkAqxJseb9nb3dQycJAWPrUjwam+qUlfRTUAxptSjIOdtBxi3XTYeLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716294461; c=relaxed/simple;
	bh=5DKr0URRu3WXGP+64uYearjadYJhWwEWBAiX/LGf+1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U/qQ6sAiIOk01kDROD0xClQn7P0iTEHZQ1Qm5od6EKKui1qoJOuHtK5kF65hN9bsEyK5qj7df4oEukkb1cWzCVJ6fwdOrXHiittUPpsOw2VKo+fXZ23LgYk/oX8xd5FWQuAQ/7oqwAgL1WUAxhR2WzmYgzyU9mLiAlArW6XCs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxT3tGBq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fdc9af005so7392021e87.3;
        Tue, 21 May 2024 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716294457; x=1716899257; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYGHL1LDa2Mvx1QpEmaJ5OoxLbKyEIFkerAv7AIWdjQ=;
        b=JxT3tGBqpTxMsMRjim1Fvkv8bmdPg6VXNLfuLzakQyVYeppQvEhTu36zbFozFw29KU
         SQ7jia58pYNtBvrTCgopV6iQcGwo5wwLIOchPrG2IHPCsa5YiXgI/LKz7kJER0OAcxU9
         Yl2LnwCLPl9MQqxilFaG1E+SyGfmymMkfjB1zKa0H/SPrzGs4FS5liB1OM0qNQeGuHD9
         pPPAsH7BPpoDED+6EDa24Iyg+FU9PVjKGRonVmksTB5188qUit3Gt1kG28T3vMgmH573
         seO9PZGgDdd7JxZXz5/ndkkiOn5sYJeJvyGBH2gOFFwEdZzCLuxlEQK8vtWnmuUiVPxv
         vglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716294457; x=1716899257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYGHL1LDa2Mvx1QpEmaJ5OoxLbKyEIFkerAv7AIWdjQ=;
        b=QSMNYszL78KzdFrQlAuJKnen9C0YAYcJbjjnCghemcKO1Xbhvm9uO6E036ulswOEjK
         MwI4UYzl6wWlzuHStZXGwP0/OK4EcXGLv4RVOXd9pkwR8NjWSds1VfQ4Tz/VnEJQ+Xe6
         T4ensirWbhVMxDbYmT0FU8iDscaTwKZgcJa/iajL27wlcpfW4zbXUNviYNeP5Z+1xGHL
         s/1YiikA2dPtdL3M/pEfKoSDMRoNA3r0/ndnPIgriEf+Su0/plmuWuzrhl3tKnfR8s7s
         NdJNdmbi3txiUqEP2udyRoLHEeqWSwrUsghQrjHGFhmiFiBIgLKtPizdELIGk7XnCfs0
         B0GA==
X-Forwarded-Encrypted: i=1; AJvYcCVcwMrWhQk+tZCRkK7jbpday+vdhnI3h4rnQurX0zzQbNGAjGf9zvPpgTOJYOpJ3bEYRsQ06p1vxiQoaKk07yYSeiJ4FXxBapiipmRCk6HMpY+fLYrhpyF0RravEO2YaqDllr4zHZfAJdRh39AE8Dgl2AX1UcWRiuJl28mHOrTmZm9OjZ3LHMnM2UOhbeoWUpDX2JJjMi+N8fvjPKZe7A==
X-Gm-Message-State: AOJu0Yyhx03FGw9zeHYdeulY9r97GRgSfhTkjNQXYUwah4O2VO9+kJNd
	AEbEbb/URX9+hYDf07F02ShZod4XvRJpWlEF9TDFEmWgsIzaILoh
X-Google-Smtp-Source: AGHT+IHTwAqo4+asNVNDWNtzu542SRBSkgGqfE2wKBmmx2JxS/Zeim+49muD7slkuirIjUXH4t338A==
X-Received: by 2002:ac2:521a:0:b0:51a:c3b8:b9cf with SMTP id 2adb3069b0e04-5221047590amr22069610e87.69.1716294456869;
        Tue, 21 May 2024 05:27:36 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5d10b3ef82sm536264266b.158.2024.05.21.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 05:27:36 -0700 (PDT)
Message-ID: <6c5fd2cef9a6412e63f2534243eda37c321ffcd2.camel@gmail.com>
Subject: Re: [PATCH RFC v2 6/8] spi: axi-spi-engine: add offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, David Jander <david@protonic.nl>, Martin Sperl
	 <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org
Date: Tue, 21 May 2024 14:31:19 +0200
In-Reply-To: <20240510-dlech-mainline-spi-engine-offload-2-v2-6-8707a870c435@baylibre.com>
References: 
	<20240510-dlech-mainline-spi-engine-offload-2-v2-0-8707a870c435@baylibre.com>
	 <20240510-dlech-mainline-spi-engine-offload-2-v2-6-8707a870c435@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 19:44 -0500, David Lechner wrote:
> This implements SPI offload support for the AXI SPI Engine. Currently,
> the hardware only supports triggering offload transfers with a hardware
> trigger so attempting to use an offload message in the regular SPI
> message queue will fail. Also, only allows streaming rx data to an
> external sink, so attempts to use a rx_buf in the offload message will
> fail.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
>=20
> This patch has been reworked to accommodate the changes described in all
> of the other patches.
> ---
> =C2=A0drivers/spi/spi-axi-spi-engine.c | 267
> ++++++++++++++++++++++++++++++++++++++-
> =C2=A01 file changed, 264 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-
> engine.c
> index e358ac5b4509..95327df572a0 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -2,6 +2,7 @@
> =C2=A0/*
> =C2=A0 * SPI-Engine SPI controller driver
> =C2=A0 * Copyright 2015 Analog Devices Inc.
> + * Copyright 2024 BayLibre, SAS
> =C2=A0 *=C2=A0 Author: Lars-Peter Clausen <lars@metafoo.de>
> =C2=A0 */
> =C2=A0
> @@ -16,6 +17,7 @@
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/spi/spi.h>
> =C2=A0
> +#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
> =C2=A0#define SPI_ENGINE_REG_RESET			0x40
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_INT_ENABLE		0x80
> @@ -23,6 +25,7 @@
> =C2=A0#define SPI_ENGINE_REG_INT_SOURCE		0x88
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_SYNC_ID			0xc0
> +#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
> =C2=A0
> =C2=A0#define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
> =C2=A0#define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
> @@ -33,10 +36,24 @@
> =C2=A0#define SPI_ENGINE_REG_SDI_DATA_FIFO		0xe8
> =C2=A0#define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
> =C2=A0
> +#define SPI_ENGINE_MAX_NUM_OFFLOADS		32
> +
> +#define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_RESET(x)		(0x108 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(x)	(0x110 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +#define SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(x)	(0x114 +
> SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
> +
> +#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO	GENMASK(15, 8)
> +#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD	GENMASK(7, 0)
> +
> =C2=A0#define SPI_ENGINE_INT_CMD_ALMOST_EMPTY		BIT(0)
> =C2=A0#define SPI_ENGINE_INT_SDO_ALMOST_EMPTY		BIT(1)
> =C2=A0#define SPI_ENGINE_INT_SDI_ALMOST_FULL		BIT(2)
> =C2=A0#define SPI_ENGINE_INT_SYNC			BIT(3)
> +#define SPI_ENGINE_INT_OFFLOAD_SYNC		BIT(4)
> +
> +#define SPI_ENGINE_OFFLOAD_CTRL_ENABLE		BIT(0)
> =C2=A0
> =C2=A0#define SPI_ENGINE_CONFIG_CPHA			BIT(0)
> =C2=A0#define SPI_ENGINE_CONFIG_CPOL			BIT(1)
> @@ -74,6 +91,10 @@
> =C2=A0#define SPI_ENGINE_CMD_SYNC(id) \
> =C2=A0	SPI_ENGINE_CMD(SPI_ENGINE_INST_MISC, SPI_ENGINE_MISC_SYNC, (id))
> =C2=A0
> +/* default sizes - can be changed when SPI Engine firmware is compiled *=
/
> +#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
> +#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
> +
> =C2=A0struct spi_engine_program {
> =C2=A0	unsigned int length;
> =C2=A0	uint16_t instructions[] __counted_by(length);
> @@ -101,6 +122,12 @@ struct spi_engine_message_state {
> =C2=A0	uint8_t *rx_buf;
> =C2=A0};
> =C2=A0
> +struct spi_engine_offload {
> +	struct spi_device *spi;
> +	unsigned int id;
> +	bool prepared;
> +};
> +
> =C2=A0struct spi_engine {
> =C2=A0	struct clk *clk;
> =C2=A0	struct clk *ref_clk;
> @@ -111,6 +138,10 @@ struct spi_engine {
> =C2=A0	struct spi_engine_message_state msg_state;
> =C2=A0	struct completion msg_complete;
> =C2=A0	unsigned int int_enable;
> +
> +	unsigned int offload_ctrl_mem_size;
> +	unsigned int offload_sdo_mem_size;
> +	struct spi_engine_offload offload_priv[SPI_ENGINE_MAX_NUM_OFFLOADS];
> =C2=A0};
> =C2=A0
> =C2=A0static void spi_engine_program_add_cmd(struct spi_engine_program *p=
,
> @@ -154,7 +185,7 @@ static void spi_engine_gen_xfer(struct spi_engine_pro=
gram
> *p, bool dry,
> =C2=A0
> =C2=A0		if (xfer->tx_buf)
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_WRITE;
> -		if (xfer->rx_buf)
> +		if (xfer->rx_buf || (xfer->offload_flags &
> SPI_OFFLOAD_XFER_RX_STREAM))
> =C2=A0			flags |=3D SPI_ENGINE_TRANSFER_READ;
> =C2=A0
> =C2=A0		spi_engine_program_add_cmd(p, dry,
> @@ -202,16 +233,24 @@ static void spi_engine_gen_cs(struct spi_engine_pro=
gram
> *p, bool dry,
> =C2=A0 *
> =C2=A0 * NB: This is separate from spi_engine_compile_message() because t=
he latter
> =C2=A0 * is called twice and would otherwise result in double-evaluation.
> + *
> + * Returns 0 on success, -EINVAL on failure.
> =C2=A0 */
> -static void spi_engine_precompile_message(struct spi_message *msg)
> +static int spi_engine_precompile_message(struct spi_message *msg)
> =C2=A0{
> =C2=A0	unsigned int clk_div, max_hz =3D msg->spi->controller->max_speed_h=
z;
> =C2=A0	struct spi_transfer *xfer;
> =C2=A0
> =C2=A0	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		/* If we have an offload transfer, we can't rx to buffer */
> +		if (msg->offload && xfer->rx_buf)
> +			return -EINVAL;
> +
> =C2=A0		clk_div =3D DIV_ROUND_UP(max_hz, xfer->speed_hz);
> =C2=A0		xfer->effective_speed_hz =3D max_hz / min(clk_div, 256U);
> =C2=A0	}
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static void spi_engine_compile_message(struct spi_message *msg, boo=
l dry,
> @@ -503,8 +542,11 @@ static irqreturn_t spi_engine_irq(int irq, void *dev=
id)
> =C2=A0static int spi_engine_optimize_message(struct spi_message *msg)
> =C2=A0{
> =C2=A0	struct spi_engine_program p_dry, *p;
> +	int ret;
> =C2=A0
> -	spi_engine_precompile_message(msg);
> +	ret =3D spi_engine_precompile_message(msg);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	p_dry.length =3D 0;
> =C2=A0	spi_engine_compile_message(msg, true, &p_dry);
> @@ -539,6 +581,11 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	unsigned int int_enable =3D 0;
> =C2=A0	unsigned long flags;
> =C2=A0
> +	if (msg->offload) {
> +		dev_err(&host->dev, "Single transfer offload not
> supported\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> =C2=A0	/* reinitialize message state for this transfer */
> =C2=A0	memset(st, 0, sizeof(*st));
> =C2=A0	st->cmd_buf =3D p->instructions;
> @@ -579,6 +626,204 @@ static int spi_engine_transfer_one_message(struct
> spi_controller *host,
> =C2=A0	return msg->status;
> =C2=A0}
> =C2=A0
> +static struct spi_engine_offload *spi_engine_get_offload(struct spi_devi=
ce
> *spi,
> +							 unsigned int id,
> +							 unsigned int
> *offload_num)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	int i;
> +
> +	for (i =3D 0; i < SPI_ENGINE_MAX_NUM_OFFLOADS; i++) {
> +		priv =3D &spi_engine->offload_priv[i];
> +
> +		if (priv->spi =3D=3D spi && priv->id =3D=3D id) {
> +			*offload_num =3D i;
> +			return priv;
> +		}
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static int spi_engine_offload_map_channel(struct spi_device *spi,
> +					=C2=A0 unsigned int id,
> +					=C2=A0 unsigned int channel)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +
> +	if (channel >=3D SPI_ENGINE_MAX_NUM_OFFLOADS)
> +		return -EINVAL;
> +
> +	priv =3D &spi_engine->offload_priv[channel];
> +
> +	if (priv->spi)
> +		return -EBUSY;

I wonder if we need to be this strict? Is there any problem by having two
devices requesting the same offload engine? I would expect that having mult=
iple
peripherals trying to actually use it at the same time (with the prepare()
callback) to be problematic but if they play along it could actually work,
right? In reality that may never be a realistic usecase so this is likely f=
ine.

> +
> +	priv->spi =3D spi;
> +	priv->id =3D id;
> +
> +	return 0;
> +}
> +
> +static int spi_engine_offload_prepare(struct spi_device *spi, unsigned i=
nt
> id,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_program *p =3D msg->opt_state;
> +	struct spi_engine_offload *priv;
> +	struct spi_transfer *xfer;
> +	void __iomem *cmd_addr;
> +	void __iomem *sdo_addr;
> +	size_t tx_word_count =3D 0;
> +	unsigned int offload_num, i;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	if (priv->prepared)
> +		return -EBUSY;
> +
> +	if (p->length > spi_engine->offload_ctrl_mem_size)
> +		return -EINVAL;
> +
> +	/* count total number of tx words in message */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->tx_buf)
> +			continue;
> +
> +		if (xfer->bits_per_word <=3D 8)
> +			tx_word_count +=3D xfer->len;
> +		else if (xfer->bits_per_word <=3D 16)
> +			tx_word_count +=3D xfer->len / 2;
> +		else
> +			tx_word_count +=3D xfer->len / 4;
> +	}
> +
> +	if (tx_word_count > spi_engine->offload_sdo_mem_size)
> +		return -EINVAL;
> +
> +	cmd_addr =3D spi_engine->base + SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv-
> >id);
> +	sdo_addr =3D spi_engine->base +
> SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(offload_num);
> +
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		if (!xfer->tx_buf)
> +			continue;
> +
> +		if (xfer->bits_per_word <=3D 8) {
> +			const u8 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		} else if (xfer->bits_per_word <=3D 16) {
> +			const u16 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len / 2; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		} else {
> +			const u32 *buf =3D xfer->tx_buf;
> +
> +			for (i =3D 0; i < xfer->len / 4; i++)
> +				writel_relaxed(buf[i], sdo_addr);
> +		}
> +	}
> +
> +	for (i =3D 0; i < p->length; i++)
> +		writel_relaxed(p->instructions[i], cmd_addr);
> +
> +	msg->offload_state =3D (void *)(intptr_t)offload_num;
> +	priv->prepared =3D true;
> +
> +	return 0;
> +}
> +
> +static void spi_engine_offload_unprepare(struct spi_device *spi, unsigne=
d int
> id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv)) {
> +		dev_warn(&spi->dev, "failed match offload in unprepare\n");
> +		return;
> +	}
> +
> +	writel_relaxed(1, spi_engine->base +
> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> +	writel_relaxed(0, spi_engine->base +
> SPI_ENGINE_REG_OFFLOAD_RESET(offload_num));
> +
> +	priv->prepared =3D false;
> +}
> +
> +static int spi_engine_offload_enable(struct spi_device *spi, unsigned in=
t id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num, reg;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +	reg |=3D SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +
> +	return 0;
> +}
> +
> +static void spi_engine_offload_disable(struct spi_device *spi, unsigned =
int
> id)
> +{
> +	struct spi_controller *host =3D spi->controller;
> +	struct spi_engine *spi_engine =3D spi_controller_get_devdata(host);
> +	struct spi_engine_offload *priv;
> +	unsigned int offload_num, reg;
> +
> +	priv =3D spi_engine_get_offload(spi, id, &offload_num);
> +	if (IS_ERR(priv)) {
> +		dev_warn(&spi->dev, "failed match offload in disable\n");
> +		return;
> +	}
> +
> +	reg =3D readl_relaxed(spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +	reg &=3D ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
> +	writel_relaxed(reg, spi_engine->base +
> +			=C2=A0=C2=A0=C2=A0 SPI_ENGINE_REG_OFFLOAD_CTRL(offload_num));
> +}
> +
> +static const struct spi_controller_offload_ops spi_engine_offload_ops =
=3D {
> +	.map_channel =3D spi_engine_offload_map_channel,
> +	.prepare =3D spi_engine_offload_prepare,
> +	.unprepare =3D spi_engine_offload_unprepare,
> +	.hw_trigger_enable =3D spi_engine_offload_enable,
> +	.hw_trigger_disable =3D spi_engine_offload_disable,

I guess this is what you and Conor are already somehow discussing but I wou=
ld
expect this to be the actual offload trigger to play a spi transfer. As it
stands, it looks weird (or confusing) to have the enable/disable of the eng=
ine
to act as a trigger... Maybe these callbacks could be used to enable/disabl=
e the
actual trigger of the offload engine (in our current cases, the PWM)? So th=
is
would make it easy to move the trigger DT property where it belongs. The DM=
A one
(given it's tight relation with IIO DMA buffers) is another (way more diffi=
cult)
story I think.

- Nuno S=C3=A1



