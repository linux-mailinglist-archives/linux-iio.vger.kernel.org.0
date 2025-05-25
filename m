Return-Path: <linux-iio+bounces-19883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295F5AC34C5
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA31D175A3E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0001F1931;
	Sun, 25 May 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2v/uEUY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6DA26AF3;
	Sun, 25 May 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748178599; cv=none; b=TDkTEpc0gOg7nKrkL7B8HJvv260vFgPRB+QpHa9sEcmP4JPbO1hcnjMKP7iGlrmHCKyeq6q3wQmiU4D33EOBMf+DkPAkI0RDAqm19pOGcx6iW9WqmeT+HWCjoESQ00EbKNnmb1WNJE01JxtLDN+Z23UTeyYRkqEBzKctUqWx8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748178599; c=relaxed/simple;
	bh=WFnrzdwffDQrot3q6ZmBUqt+jd6v+agWz9yfZaf5PhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWQWTfj6qRnkTzvMNp+chcRU3GvBzCus7DoS24A5+XIZsCTS10g3A6b0NItPxuCfkLL4e+s/CCr9+SrO4rtx3wR+31lOgnyhwRYxbT/O/a2S5+sZQpaPHXXpv8X5LspX6c7WYl3z0529r/Pob7+PNAsJ9howGBINzJrWLW7y0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2v/uEUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CCDC4CEEA;
	Sun, 25 May 2025 13:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748178598;
	bh=WFnrzdwffDQrot3q6ZmBUqt+jd6v+agWz9yfZaf5PhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n2v/uEUY62MnVnk4bPiuso1CdFD98sV8XaalLHTTZ/gKHn0IDzeKL6tB9Sx8cwnf4
	 HKS5lMTEHwpcI0V8B4joDR8tg4sVPvtY5vHaxSBtLFB5s4Ge3DByk8eEgTVKGtIxbX
	 688lQTLlJqK9gd1sboc0K4zQBXWybN4fLdzArmIHuJKOIcrE6+3GcGFrzDdGdhTFDh
	 hwVTpT32YbavpPIubP+hpbvA/zXYQNDXF2bw85G0YfXrDCUNc2aPSj/ZQ6DqF6FhFJ
	 t6P7jULFwSI7GsL7/SHEtUhy9H3nxoX6cPpiUcL8cdTtp8lkJINtrGnaelCezke4r2
	 8jCeRSmpRlXrw==
Date: Sun, 25 May 2025 14:09:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/12] iio: accel: adxl313: add activity sensing
Message-ID: <20250525140951.37039f49@jic23-huawei>
In-Reply-To: <20250523223523.35218-10-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
	<20250523223523.35218-10-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

m adxl313_chans {
>  	chan_x, chan_y, chan_z,
>  };
> @@ -238,6 +264,14 @@ static const struct iio_chan_spec adxl313_channels[]=
 =3D {
>  	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
>  	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
>  	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
> +	{
> +		.type =3D IIO_ACCEL,
> +		.modified =3D 1,
> +		.channel2 =3D IIO_MOD_X_AND_Y_AND_Z,
I'm confused. If this is for activity it would be very unusual for it
to be X&Y&Z.=20

"A setting of 1 enables x-, y-, or z-axis participation in detecting
activity or inactivity. A setting of 0 excludes the selected axis from
participation. If all axes are excluded, the function is disabled. For
activity detection, all participating axes are logically OR=E2=80=99ed, cau=
sing
the activity function to trigger when any of the participating axes
exceeds the threshold. For inactivity detection, all participating axes
are logically AND=E2=80=99ed, causing the inactivity function to trigger on=
ly
if all participating axes are below the threshold for the specified
period of time."

Which matches with what I'd expect.

> +		.scan_index =3D -1, /* Fake channel for axis AND'ing */
> +		.event_spec =3D adxl313_fake_chan_events,
> +		.num_event_specs =3D ARRAY_SIZE(adxl313_fake_chan_events),
> +	},
>  };
> =20
>  static const unsigned long adxl313_scan_masks[] =3D {
> @@ -300,6 +334,60 @@ static int adxl313_read_freq_avail(struct iio_dev *i=
ndio_dev,
>  	}
>  }

