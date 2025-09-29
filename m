Return-Path: <linux-iio+bounces-24563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7FABA9D0C
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338C716C47D
	for <lists+linux-iio@lfdr.de>; Mon, 29 Sep 2025 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B9A30B511;
	Mon, 29 Sep 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ef1LdPO5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17914214A6A
	for <linux-iio@vger.kernel.org>; Mon, 29 Sep 2025 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160303; cv=none; b=jXL/45RX+RaBFk/l/7jtcHveGkyUs56oSRKJhG7ym1bELA4VwrxCiMP2MDTJjPitbIpwUKfOQQeok2BL3XceKA3sQ/voT1yaUHSBsdbTlfWbBChk3ZsqXKUX8+bSB33ADe4yIZ9+vQNF+gutgZpZCoqoh+GfulxQ1f0u2LMI64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160303; c=relaxed/simple;
	bh=FBv5ZdGu2UjBYj7Q0c2JIqzYKMrQD4uTKs0ZYPb9IWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UY4EvQI8E8JLA+slywhv8ZVMGtbWH5bgjYM8lY6qKOl2IMpLa7DY/WBXqIzNiQGrXb+QeYop59VqytMyr2hPulFjMSsAz7O8rwSe0X0sXp7v1cdrW0+RShq9/MWqEeuiJSEq4Qij101WJt/s75tQhM4Fsu6WlvhSLNLo50B7/mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ef1LdPO5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 472C44E40CEF;
	Mon, 29 Sep 2025 15:38:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B6A7606AE;
	Mon, 29 Sep 2025 15:38:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD8A9102F19E7;
	Mon, 29 Sep 2025 17:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1759160297; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yTJdS3woupRsBMy0Zf0m8reGQJmYQlgaKoJKrrMf0C0=;
	b=Ef1LdPO5kTe3B1y6nxaFN3UWDawERCWgFi7K5qEKq82v5D1zSgdLnr/JJYY4ZIFSxzccBx
	TREMKJnfOKsaCeyqcZlpqb1ubQyUKBBJiNLADLvUe7GpRiOYTJ6xIQF6lK/As1j3jAhP8u
	0pured7HzXTjmNA01Yy85ctp9wpIG+De4Kvwnv89dwEnDVyo+NgGUOjTx4q2MYEFvO1EPX
	W6yVrfOiyM+bEpBhhpAupkbqGa9C+QkOFEYPAD06C230daO2yAw4rD0dfuHDs+KJq6B5xT
	s4jIvwsRNgayPNoPabyujGOTZcTtNhqFxv3B+mEW0yu0i7+K7znfOFx+CSwVIQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,  Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>,  Nuno
 =?utf-8?Q?S=C3=A1?=
 <nuno.sa@analog.com>,  Andy Shevchenko <andy@kernel.org>,
  linux-i3c@lists.infradead.org,  linux-kernel@vger.kernel.org,
  imx@lists.linux.dev,  linux-iio@vger.kernel.org,  Carlos Song
 <carlos.song@nxp.com>
Subject: Re: [PATCH v2 2/4] i3c: master: svc: Add basic HDR mode support
In-Reply-To: <20250924-i3c_ddr-v2-2-682a0eb32572@nxp.com> (Frank Li's message
	of "Wed, 24 Sep 2025 10:30:03 -0400")
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
	<20250924-i3c_ddr-v2-2-682a0eb32572@nxp.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 29 Sep 2025 17:38:03 +0200
Message-ID: <87seg5i810.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

>  struct svc_i3c_cmd {
>  	u8 addr;
> -	bool rnw;
> +	u8 rnw;

You used a union in the core, which makes sense I believe. I guess you
should do it here as well?


>  	u8 *in;
>  	const void *out;
>  	unsigned int len;
> @@ -383,6 +386,21 @@ svc_i3c_master_dev_from_addr(struct svc_i3c_master *=
master,
>  	return master->descs[i];
>  }

Maybe we should:
- First change the type of the command and make use of the helper to
derive the fact that it is a read
then
- Introduce HDR support.

Because there seems to be a lot of changes which are induced by this
internal API change and not related to HDR introduction at all.

>=20=20
> +static bool svc_is_read(u8 rnw_cmd, u32 type)

Can we name this helper svc_cmd_is_read() ?

> +{
> +	return (type =3D=3D SVC_I3C_MCTRL_TYPE_DDR) ? !!(rnw_cmd & 0x80) : rnw_=
cmd;
> +}
> +
> +static void svc_i3c_master_emit_force_exit(struct svc_i3c_master *master)
> +{
> +	u32 reg =3D 0;
> +
> +	writel(SVC_I3C_MCTRL_REQUEST_FORCE_EXIT, master->regs + SVC_I3C_MCTRL);
> +	readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> +			   SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> +	udelay(1);
> +}
> +
>  static void svc_i3c_master_emit_stop(struct svc_i3c_master *master)
>  {
>  	writel(SVC_I3C_MCTRL_REQUEST_STOP, master->regs + SVC_I3C_MCTRL);
> @@ -1272,7 +1290,7 @@ static int svc_i3c_master_write(struct svc_i3c_mast=
er *master,
>  }
>=20=20
>  static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> -			       bool rnw, unsigned int xfer_type, u8 addr,
> +			       u8 rnw, unsigned int xfer_type, u8 addr,
>  			       u8 *in, const u8 *out, unsigned int xfer_len,
>  			       unsigned int *actual_len, bool continued, bool repeat_start)
>  {
> @@ -1283,12 +1301,22 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
>  	/* clean SVC_I3C_MINT_IBIWON w1c bits */
>  	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
>=20=20
> +	if (xfer_type =3D=3D SVC_I3C_MCTRL_TYPE_DDR) {
> +		/* DDR command need prefill into FIFO */
> +		writel(rnw, master->regs + SVC_I3C_MWDATAB);
> +		if (!svc_is_read(rnw, xfer_type)) {
> +			/* write data also need prefill into FIFO */
> +			ret =3D svc_i3c_master_write(master, out, xfer_len);
> +		if (ret)
> +			goto emit_stop;
> +		}
> +	}
>=20=20
>  	while (retry--) {
>  		writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
>  		       xfer_type |
>  		       SVC_I3C_MCTRL_IBIRESP_NACK |
> -		       SVC_I3C_MCTRL_DIR(rnw) |
> +		       SVC_I3C_MCTRL_DIR(svc_is_read(rnw, xfer_type)) |
>  		       SVC_I3C_MCTRL_ADDR(addr) |
>  		       SVC_I3C_MCTRL_RDTERM(*actual_len),
>  		       master->regs + SVC_I3C_MCTRL);
> @@ -1373,15 +1401,14 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
>  			break;
>  		}
>  	}
> -
> -	if (rnw)
> +	if (svc_is_read(rnw, xfer_type))
>  		ret =3D svc_i3c_master_read(master, in, xfer_len);
> -	else
> +	else if (xfer_type !=3D SVC_I3C_MCTRL_TYPE_DDR)
>  		ret =3D svc_i3c_master_write(master, out, xfer_len);
>  	if (ret < 0)
>  		goto emit_stop;
>=20=20
> -	if (rnw)
> +	if (svc_is_read(rnw, xfer_type))
>  		*actual_len =3D ret;
>=20=20
>  	ret =3D readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@ -1389,10 +1416,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_mas=
ter *master,
>  	if (ret)
>  		goto emit_stop;
>=20=20
> +	if (xfer_type =3D=3D SVC_I3C_MCTRL_TYPE_DDR &&
> +	    (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_CRC)) {
> +		ret =3D -ENXIO;
> +		goto emit_stop;
> +	}
> +
>  	writel(SVC_I3C_MINT_COMPLETE, master->regs + SVC_I3C_MSTATUS);
>=20=20
>  	if (!continued) {
> -		svc_i3c_master_emit_stop(master);
> +		if (xfer_type !=3D SVC_I3C_MCTRL_TYPE_DDR)
> +			svc_i3c_master_emit_stop(master);
> +		else
> +			svc_i3c_master_emit_force_exit(master);
>=20=20
>  		/* Wait idle if stop is sent. */
>  		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> @@ -1402,7 +1438,11 @@ static int svc_i3c_master_xfer(struct svc_i3c_mast=
er *master,
>  	return 0;
>=20=20
>  emit_stop:
> -	svc_i3c_master_emit_stop(master);
> +	if (xfer_type !=3D SVC_I3C_MCTRL_TYPE_DDR)
> +		svc_i3c_master_emit_stop(master);
> +	else
> +		svc_i3c_master_emit_force_exit(master);
> +
>  	svc_i3c_master_clear_merrwarn(master);
>  	svc_i3c_master_flush_fifo(master);
>=20=20
> @@ -1449,6 +1489,11 @@ static void svc_i3c_master_dequeue_xfer(struct svc=
_i3c_master *master,
>  	spin_unlock_irqrestore(&master->xferqueue.lock, flags);
>  }
>=20=20
> +static int mode_to_type(enum i3c_hdr_mode mode)

Maybe "i3c_mode_to_svc_type()"?
> +{
> +	return (mode =3D=3D I3C_SDR) ? SVC_I3C_MCTRL_TYPE_I3C : SVC_I3C_MCTRL_T=
YPE_DDR;
> +}
> +
>  static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *mast=
er)
>  {
>  	struct svc_i3c_xfer *xfer =3D master->xferqueue.cur;
> @@ -1638,9 +1683,8 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_m=
aster_controller *m,
>  	return ret;
>  }
>=20=20
> -static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> -				     struct i3c_priv_xfer *xfers,
> -				     int nxfers)
> +static int svc_i3c_master_i3c_xfers(struct i3c_dev_desc *dev, struct i3c=
_priv_xfer *xfers,
> +				    int nxfers, enum i3c_hdr_mode mode)
>  {
>  	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
>  	struct svc_i3c_master *master =3D to_svc_i3c_master(m);
> @@ -1648,22 +1692,33 @@ static int svc_i3c_master_priv_xfers(struct i3c_d=
ev_desc *dev,
>  	struct svc_i3c_xfer *xfer;
>  	int ret, i;
>=20=20
> +	if (mode !=3D I3C_SDR) {
> +		/*
> +		 * Only support data size less than FIFO SIZE when use
> DDR mode.

when using DDR mode.

> +		 * First entry is cmd in FIFO, so actual available FIFO for data
> +		 * is SVC_I3C_FIFO_SIZE - 2 since DDR only support even
> length.

supports

> +		 */
> +		for (i =3D 0; i < nxfers; i++)
> +			if (xfers[i].len > SVC_I3C_FIFO_SIZE - 2)
> +				return -EINVAL;
> +	}
> +
>  	xfer =3D svc_i3c_master_alloc_xfer(master, nxfers);
>  	if (!xfer)
>  		return -ENOMEM;
>=20=20
> -	xfer->type =3D SVC_I3C_MCTRL_TYPE_I3C;
> +	xfer->type =3D mode_to_type(mode);
>=20=20
>  	for (i =3D 0; i < nxfers; i++) {
> +		u8 rnw_cmd =3D (mode =3D=3D I3C_SDR) ? xfers[i].rnw : xfers[i].cmd;
>  		struct svc_i3c_cmd *cmd =3D &xfer->cmds[i];
> -

Spurious change?

>  		cmd->xfer =3D &xfers[i];
>  		cmd->addr =3D master->addrs[data->index];
> -		cmd->rnw =3D xfers[i].rnw;
> -		cmd->in =3D xfers[i].rnw ? xfers[i].data.in : NULL;
> -		cmd->out =3D xfers[i].rnw ? NULL : xfers[i].data.out;
> +		cmd->rnw =3D rnw_cmd;
> +		cmd->in =3D svc_is_read(rnw_cmd, mode_to_type(mode)) ? xfers[i].data.i=
n : NULL;
> +		cmd->out =3D svc_is_read(rnw_cmd, mode_to_type(mode)) ? NULL : xfers[i=
].data.out;
>  		cmd->len =3D xfers[i].len;
> -		cmd->actual_len =3D xfers[i].rnw ? xfers[i].len : 0;
> +		cmd->actual_len =3D svc_is_read(rnw_cmd, mode_to_type(mode)) ? xfers[i=
].len : 0;
>  		cmd->continued =3D (i + 1) < nxfers;
>  	}
>=20=20
> @@ -1858,7 +1913,7 @@ static const struct i3c_master_controller_ops svc_i=
3c_master_ops =3D {
>  	.do_daa =3D svc_i3c_master_do_daa,
>  	.supports_ccc_cmd =3D svc_i3c_master_supports_ccc_cmd,
>  	.send_ccc_cmd =3D svc_i3c_master_send_ccc_cmd,
> -	.priv_xfers =3D svc_i3c_master_priv_xfers,
> +	.i3c_xfers =3D svc_i3c_master_i3c_xfers,

Didn't you change this name in patch 1? If you kept both naming, it's
fine, otherwise you must do the switch in patch 1 as well to make sure
you don't break the build in the middle of the series.

>  	.i2c_xfers =3D svc_i3c_master_i2c_xfers,
>  	.request_ibi =3D svc_i3c_master_request_ibi,
>  	.free_ibi =3D svc_i3c_master_free_ibi,
> @@ -1947,6 +2002,8 @@ static int svc_i3c_master_probe(struct platform_dev=
ice *pdev)
>=20=20
>  	svc_i3c_master_reset(master);
>=20=20
> +	master->base.mode_mask =3D BIT(I3C_SDR) | BIT(I3C_HDR_DDR);
> +
>  	/* Register the master */
>  	ret =3D i3c_master_register(&master->base, &pdev->dev,
>  				  &svc_i3c_master_ops, false);

Thanks,
Miqu=C3=A8l

