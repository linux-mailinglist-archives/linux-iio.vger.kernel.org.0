Return-Path: <linux-iio+bounces-11809-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A789B96DD
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 18:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BF91C21430
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 17:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3721CEAA8;
	Fri,  1 Nov 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xu/CAZd+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0901C729E;
	Fri,  1 Nov 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483493; cv=none; b=oYAKGoNA3/kAtTudmTZfh4Y7+SiO7bVKnU5udyHYj2fJe0zAzBbGT012F9u+ur4UafcQmHog3cIio0IG9MsieqEGVuVQ8V6tfmHAhhvBsXr7xton7f8M6/fmmLugSpKHBIHL4lXNhvNs/qD0cCsddOFgjdPOecimSfd9HR7rv+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483493; c=relaxed/simple;
	bh=GTi73bIjgcmiYNkVlbjFB/3s9dtDLvL4416eQTrZHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9A5LsshNgoCySzLKj8X0R4aeoZhWgZ+PoueXbV7s1xkpKYV6YdHezMcpIKfGEr1DuEA8KeJOZCdEpa6w2xVIqF8F3uZwYlTD1GfdNs+RT0h1Puo76A1Cc1RnCJubkna27W1nxfdMeVCiTjzTcOT/HDjRZbYDVykCDd8j7FwfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xu/CAZd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87D6C4CECD;
	Fri,  1 Nov 2024 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730483493;
	bh=GTi73bIjgcmiYNkVlbjFB/3s9dtDLvL4416eQTrZHsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xu/CAZd+WcX5yN9vACy5o1bgnqTJCC0I2V9sPNl+utukYvsflSsTHfcx8eRxFK+az
	 UDLecUWASjyR7srLSzElda+Wpcdn4HmC/+bLRLQI2AfyHUMvtDXeNulsXhFrsIcdfs
	 13+ksxlw055XiMhzuOO1GtgJ/FgWxxle3SRwrd2VoxhLx8gijcGTApwDDHMf8EcnFD
	 I9ldlMOhA7TL1gko0N1MBFgTDUGVPKiLpfVtOcuiXvuwKOiA+saQdQpSbwfLsBBVBX
	 /LNPYPIx07/yGOAx670+rf6HXJAyotEyIGnQKxY7jri1GU7SyNTTulVLdenSUIXwcb
	 FkqYnnlOfj0HQ==
Date: Fri, 1 Nov 2024 17:51:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: events.h: add event identifier macros for
 differential channel
Message-ID: <20241101175126.27acd238@jic23-huawei>
In-Reply-To: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-1-b452c90f7ea6@baylibre.com>
References: <20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-0-b452c90f7ea6@baylibre.com>
	<20241028-iio-add-macro-for-even-identifier-for-differential-channels-v1-1-b452c90f7ea6@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Oct 2024 17:38:11 +0100
Julien Stephan <jstephan@baylibre.com> wrote:

> Currently, there are 3 helper macros in iio/events.h to create event
> identifiers:
> - IIO_EVENT_CODE : create generic event identifier for differential and n=
on
>   differential channels
> - IIO_MOD_EVENT_CODE : create event identifier for modified (non
>   differential) channels
> - IIO_UNMOD_EVENT_CODE : create event identifier for unmodified (non
>   differential) channels
>=20
> For differential channels, drivers are expected to use IIO_EVENT_CODE.
> However, only one driver in drivers/iio currently uses it correctly,
> leading to inconsistent event identifiers for differential channels that
> don=E2=80=99t match the intended attributes (such as max1363.c that suppo=
rts
> differential channels, but only uses IIO_UNMOD_EVENT_CODE).

The max1363 is a weird beast IIRC. It's only been about 15 years since I im=
plemented
events :(
When events are enabled it is really fiddly to read the data, so we never
bothered. Mind you, it does indeed seem to set up the differential mode
but not return differential events. oops.

>=20
> To prevent such issues in future drivers, a new helper macro,
> IIO_DIFF_EVENT_CODE, is introduced to specifically create event identifie=
rs
> for differential channels. Only one helper is needed for differential
> channels since they cannot have modifiers.
>=20
> Additionally, the descriptions for IIO_MOD_EVENT_CODE and
> IIO_UNMOD_EVENT_CODE have been updated to clarify that they are intended
> for non-differential channels,
>=20
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Given comment below doesn't really matter, series applied.

I'm tempted to just say break ABI and fix these. It's a bug
even if a long standing one so a valid reason to cause people
problems if they are checking for wrong event.=20

Thanks,

Jonathan

> ---
>  include/linux/iio/events.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iio/events.h b/include/linux/iio/events.h
> index a4558c45a548834e33702927609ca9ad447c67de..eeaba5e1525e44fd3b51985ff=
a99837efc6cdd00 100644
> --- a/include/linux/iio/events.h
> +++ b/include/linux/iio/events.h
> @@ -30,7 +30,8 @@
> =20
> =20
>  /**
> - * IIO_MOD_EVENT_CODE() - create event identifier for modified channels
> + * IIO_MOD_EVENT_CODE() - create event identifier for modified (non
> + * differential) channels

Whilst subtle and maybe ok to state here, there is no such thing as a modif=
ied
differential channel (because they both use chan2).

So we could not mention it, but I guess it is harmless addition.

>   * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
>   * @number:	Channel number.
>   * @modifier:	Modifier for the channel. Should be one of enum iio_modifi=
er.
> @@ -43,7 +44,8 @@
>  	IIO_EVENT_CODE(chan_type, 0, modifier, direction, type, number, 0, 0)
> =20
>  /**
> - * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified chann=
els
> + * IIO_UNMOD_EVENT_CODE() - create event identifier for unmodified (non
> + * differential) channels
>   * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
>   * @number:	Channel number.
>   * @type:	Type of the event. Should be one of enum iio_event_type.
> @@ -53,4 +55,16 @@
>  #define IIO_UNMOD_EVENT_CODE(chan_type, number, type, direction)	\
>  	IIO_EVENT_CODE(chan_type, 0, 0, direction, type, number, 0, 0)
> =20
> +/**
> + * IIO_DIFF_EVENT_CODE() - create event identifier for differential chan=
nels
> + * @chan_type:	Type of the channel. Should be one of enum iio_chan_type.
> + * @chan1:	First channel number for differential channels.
> + * @chan2:	Second channel number for differential channels.
> + * @type:	Type of the event. Should be one of enum iio_event_type.
> + * @direction:	Direction of the event. One of enum iio_event_direction.
> + */
> +
> +#define IIO_DIFF_EVENT_CODE(chan_type, chan1, chan2, type, direction)	\
> +	IIO_EVENT_CODE(chan_type, 1, 0, direction, type, 0, chan1, chan2)
> +
>  #endif
>=20


