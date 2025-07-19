Return-Path: <linux-iio+bounces-21774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA551B0AFAC
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 14:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD64564B81
	for <lists+linux-iio@lfdr.de>; Sat, 19 Jul 2025 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B72264D0;
	Sat, 19 Jul 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bH1NxzHq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DE2629C;
	Sat, 19 Jul 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752926931; cv=none; b=l4k16igSWLnZ4Vanv4MmfFFCRPnRKNqbgV7Y0LyCrajXkcEQvO11z8a7B4lwr0kobYZWp5m7uWyuwJmxz5WOWxqnOtwXcWAqSUZ4pxSyroW6fpzkTssfjM05QYKLqwOhn/dZjUvxrSHuNkVHEhoR/dZ+10HFMeB4ExPf7ylxGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752926931; c=relaxed/simple;
	bh=V6+7/IxV8vU8dpSJuED/i3OjmTkW9aA8vLRVkWmQLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uthm3EtdOIRBoqk0zmE6nrw9ZeSV3CYouLTW0qTgwjYVfRO4HpEtBA416uncqO676MvajNSVKLPmwtBKdossOJ9Ac8a3ePhp/iV3Ynz8IN0+FQG98cQ1VDbPaEXCctfcj8HWp+gUWvyDJMPm7THXmSESStAfdXY4ATIS75Gw4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bH1NxzHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFE4C4CEE3;
	Sat, 19 Jul 2025 12:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752926931;
	bh=V6+7/IxV8vU8dpSJuED/i3OjmTkW9aA8vLRVkWmQLMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bH1NxzHqP9JcpLV7DL5umzHTTksAeo/AyyEDcvE4mvLTMzdAtESfyqhCz1TU4L4a4
	 LHFOf1Z9dvHxzcPU01wNmlavrY3T/JzYesl6UhgQVm9A39b2pYLao4LsJAV8kbQxZb
	 DwGb7h1lzUIfXSJLdsTS2q2G1Deoz9rFIRoms0dlrQugTXvCqE9N2u/Ggm+NBxjrjb
	 J6oi1mi4VQRIuAjcv/vY/9+ye1F6XBqSNlXHjiAhFPeTnqYUEskX30Kg8XlsVEcHbO
	 vnPdx6ou19EcvbJE00kFLvcam9D9vVsJSAA3iT9x2LB8x/YLE6lxF/gktx3a0G2fN+
	 XMBnR/lDfgcAg==
Date: Sat, 19 Jul 2025 13:08:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, jonath4nns@gmail.com
Subject: Re: [PATCH] iio: adc: ad7768-1: disable IRQ autoenable
Message-ID: <20250719130844.7559e322@jic23-huawei>
In-Reply-To: <5llfgo2wifyi43zj24rv7ph5gebevcszrxl3hp3yc3ibaglcr3@fqdejauv6rmo>
References: <20250718013307.153281-1-Jonathan.Santos@analog.com>
	<5llfgo2wifyi43zj24rv7ph5gebevcszrxl3hp3yc3ibaglcr3@fqdejauv6rmo>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jul 2025 10:18:56 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, Jul 17, 2025 at 10:33:07PM -0300, Jonathan Santos wrote:
> > The device continuously converts data while powered up, generating
> > interrupts in the background. Configure the IRQ to be enabled and
> > disabled manually as needed to avoid unnecessary CPU load.

This generates interrupts continuously even when in oneshot mode?

> >=20
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> >  drivers/iio/adc/ad7768-1.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index a2e061f0cb08..3eea03c004c3 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -395,8 +395,10 @@ static int ad7768_scan_direct(struct iio_dev *indi=
o_dev)
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > +	enable_irq(st->spi->irq);

Looks racey to me in a number of ways.

Before this patch:
In continuous mode, reinit_completion called then interrupt before we enter
 oneshot mode. What was captured?=20

After this patch
Oneshot mode starts - hardware interrupt happens but enable_irq() is not set
so we miss it - or do we get another pulse later?

I'm not sure how to solve this as a device generating a stream of garbage
interrupts is near impossible to deal with.

I'm not following the datasheet description of this features vs the code=20
though. It refers to oneshot mode requiring a pulse on sync in which I can't
find.

> >  	ret =3D wait_for_completion_timeout(&st->completion,
> >  					  msecs_to_jiffies(1000));
> > +	disable_irq(st->spi->irq);
> >  	if (!ret)
> >  		return -ETIMEDOUT;
> > =20
> > @@ -1130,7 +1132,21 @@ static const struct iio_buffer_setup_ops ad7768_=
buffer_ops =3D {
> >  	.predisable =3D &ad7768_buffer_predisable,
> >  };
> > =20
> > +static int ad7768_set_trigger_state(struct iio_trigger *trig, bool ena=
ble)
> > +{
> > +	struct iio_dev *indio_dev =3D iio_trigger_get_drvdata(trig);
> > +	struct ad7768_state *st =3D iio_priv(indio_dev);
> > +
> > +	if (enable)
> > +		enable_irq(st->spi->irq);
> > +	else
> > +		disable_irq(st->spi->irq);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct iio_trigger_ops ad7768_trigger_ops =3D {
> > +	.set_trigger_state =3D ad7768_set_trigger_state,
> >  	.validate_device =3D iio_trigger_validate_own_device,
> >  };
> > =20
> > @@ -1417,7 +1433,7 @@ static int ad7768_probe(struct spi_device *spi)
> > =20
> >  	ret =3D devm_request_irq(&spi->dev, spi->irq,
> >  			       &ad7768_interrupt,
> > -			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +			       IRQF_TRIGGER_RISING | IRQF_NO_AUTOEN,

Why drop oneshot?

> >  			       indio_dev->name, indio_dev);
> >  	if (ret)
> >  		return ret;
> >=20
> > base-commit: 0a686b9c4f847dc21346df8e56d5b119918fefef
> > --=20
> > 2.34.1
> >  =20
>=20


