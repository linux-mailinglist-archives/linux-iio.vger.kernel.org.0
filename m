Return-Path: <linux-iio+bounces-20842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40FBAE2F8C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 13:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69D83B48DF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 11:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E81DE2A5;
	Sun, 22 Jun 2025 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omg6hZVZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2115F3597E;
	Sun, 22 Jun 2025 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750591720; cv=none; b=HHPURaIjlruOFlPOj3rj4SLdXBOEKGNzmYSK+ltcVgN7nkwRZ06ZoOwT/KwwiOgstY04CJzvFeEltCpVgOXzsJXmNG4FVFZ/eG8VCvS192JT9r5RTl/6BvWOmUwq3eTXRRyKtW4gIG80mGKaHhI/Qd7woqmARJMOYjrbrp2AE1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750591720; c=relaxed/simple;
	bh=ccM+5sy/6LKqUPj2PgVcorSMUeYj0bS0wfIWWu4+I2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxqAUgv0bBNiJ5CmasUYCYr9xb6RQeZFEgpg5F+GGk4hNXiV2F6jUXCTymIU3EIMz34c0NoIH2nkgleTCNOiqhHcZs01y/U2ZF8csI2ULloM75vEptuAmDDf2OlCM8ZOFC9yDKCWiDkYIUwo6rk1/lPTfF8y3J7tFKFMRddG5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omg6hZVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22B7C4CEE3;
	Sun, 22 Jun 2025 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750591719;
	bh=ccM+5sy/6LKqUPj2PgVcorSMUeYj0bS0wfIWWu4+I2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omg6hZVZho1+29wHipxVg/mmZLJNeKAcFHMMc7/+fYJZCUc33zWXje40rF55SiX3q
	 re4JgRlYMuotXA+KNmDrUBG5OhIKUocwFVM4wW1t3zlDaE5dPORhCbeQzbKzkkkLXD
	 3RpjOnxZSim7osLzFQxcvOCDqIqIngZDBlXn8BdDvDXeOQr/tJqPOqTBL+Db1ITC2c
	 qZSCVOu4MkMHMa/CRcMXLByU6HxI/OaA9TDmCvT8a5ZCGz7JHOIkGHbMdDOaNpvzyz
	 24HBIkUJWYxUcbp9H2z1m6slSSLVGqPpNqIF9I/6sEzcPzJ+0lwDCGkiYjdZU4xvVT
	 en2SfLWJJphGA==
Date: Sun, 22 Jun 2025 12:28:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, bagasdotme@gmail.com,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
Message-ID: <20250622122832.5bd40e1a@jic23-huawei>
In-Reply-To: <20250615222258.117771-4-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
	<20250615222258.117771-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Jun 2025 22:22:53 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Cover the following tasks:
> =E2=80=93 Add scan_mask and scan_index to the IIO channel configuration. =
The
> scan_index sets up buffer usage. According to the datasheet, the ADXL313
> uses a 13-bit wide data field in full-resolution mode. Set the
> signedness, number of storage bits, and endianness accordingly.
>=20
> =E2=80=93 Parse the devicetree for an optional interrupt line and configu=
re the
> interrupt mapping based on its presence. If no interrupt line is
> specified, keep the FIFO in bypass mode as currently implemented.
>=20
> =E2=80=93 Set up the interrupt handler. Add register access to detect and
> evaluate interrupts. Implement functions to clear status registers and
> reset the FIFO.
>=20
> =E2=80=93 Implement FIFO watermark configuration and handling. Allow the
> watermark level to be set, evaluate the corresponding interrupt, read
> the FIFO contents, and push the data to the IIO channel.
>=20
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Just the follow on comment that I posted on v4 thread after you sent this.
(obviously in addition to what you've been discussing with Andy)

> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313=
_core.c
> index 99a7f3755031..488680807a8f 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c

> +
> +static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i =3D 0; i < samples; i++) {
> +		ret =3D regmap_bulk_read(data->regmap, ADXL313_REG_XYZ_BASE,
> +				       data->fifo_buf + (i * ADXL313_NUM_AXIS),
> +				       2 * ADXL313_NUM_AXIS);

the sizeof() thing that I gave a late reply to in v4 thread applies here.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

