Return-Path: <linux-iio+bounces-6762-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F8D913C55
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064E81F2281F
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B6181D09;
	Sun, 23 Jun 2024 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ssrh0gMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F820E6;
	Sun, 23 Jun 2024 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156516; cv=none; b=Dm+OqHEqeequqrLjtm/74ohwAaykNmR3SVfWsxmxipybdzl8mAMqrl2n8HCogLxb+RD1iKNoSzIVIVuJvckRUW1Pt7LfKSODggozx8tgj2lgOk5uPOzuc29QuaxfqcTnIXHZH2uUoe5B7XueRw2ExgKDjeyDCOFXGcbvbdOOp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156516; c=relaxed/simple;
	bh=juAAtNDoXkujZsCYp+htIv9eQw5xQOTNlXW2GleCTnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxJhIj8kR092TZ4oZJvK9BeW9oV217OX6YFaa8RkAtRp/FgwSdDU+J4w7uCjeY1H70di6xXXCbfPkafnbwN4ESy8nAWsAG8fTSDP/8cVJYj81LVzvK6OoWraT0ZgCP84/MNy1iIrBorKQWfp3ZWxWukTIe5T3FL3hEPHMB9clNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssrh0gMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FC7C2BD10;
	Sun, 23 Jun 2024 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719156516;
	bh=juAAtNDoXkujZsCYp+htIv9eQw5xQOTNlXW2GleCTnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ssrh0gMmmwTzfwTdEihNbsE96GNNjPWOPGObkKNNZakIGeBYHQA0BGzqa88VPdIIh
	 PBFGSSx3O68SMMVzu6cnRsBxhrQJbVIfZNu4uT3Fs236FCFqfX06pVXyf6mWQz24Dk
	 bQkB/DGMiNKEY8ZKJ3Sxx8/cmkqVqGjMDAFN9RD38Zp4v0PjCoLCGawmt2SDtDz99F
	 WCJ6fN+vBBfwhy4jXT90zFXcaMi82wWdRf/Ym97umoYtkS9MXWE2vsiSpRR3TKM9rA
	 WxyW/2kH/6J+T625BUVgMN27aKPp4nA49cL8Hec23p+xFlnhuP6VcqypaB1N/O2B0p
	 sh5uoRIJWAUfA==
Date: Sun, 23 Jun 2024 16:28:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com
Subject: Re: [PATCH 3/9] dt-bindings: iio: adc: adi,ad7606: improve
 descriptions
Message-ID: <20240623162827.45220840@jic23-huawei>
In-Reply-To: <20240618-cleanup-ad7606-v1-3-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
	<20240618-cleanup-ad7606-v1-3-f1854d5c779d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jun 2024 14:02:35 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Reword a few descriptions, and normalize the text width to 80 characters.

Don't rewrap text in a patch that does anything else as those real
changes are hidden.

Even if you are changing the text, minimise rewraps to those necessary
to avoid lines getting too long and fix them up in a follow up patch
that just rewraps.

I think most of the changes are fine, but it's really hard to spot
the real changes in here!

>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 61 ++++++++++++----=
------
>  1 file changed, 34 insertions(+), 27 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 00fdaed11cbd..80866940123c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -36,64 +36,71 @@ properties:
>    avcc-supply: true
> =20
>    interrupts:
> +    description:
> +      The BUSY pin falling edge indicates that the conversion is over, a=
nd thus
> +      new data is available.
>      maxItems: 1
> =20
>    adi,conversion-start-gpios:
>      description:
> -      Must be the device tree identifier of the CONVST pin.
> -      This logic input is used to initiate conversions on the analog
> -      input channels. As the line is active high, it should be marked
> -      GPIO_ACTIVE_HIGH.
> +      Must be the device tree identifier of the CONVST pin(s). This logi=
c input

Why plural when it has maxitems 1?

> +      is used to initiate conversions on the analog input channels. As t=
he line
> +      is active high, it should be marked GPIO_ACTIVE_HIGH.

If you drop the plural change don't rewrap this in v2, it is unnecessary no=
ise
that takes away from the real improvements.
>      maxItems: 1
> =20
>    reset-gpios:
>      description:
> -      Must be the device tree identifier of the RESET pin. If specified,
> -      it will be asserted during driver probe. As the line is active hig=
h,
> -      it should be marked GPIO_ACTIVE_HIGH.
> +      Must be the device tree identifier of the RESET pin. If specified,=
 it will
> +      be asserted during driver probe. On the AD7606x, as the line is ac=
tive
> +      high, it should be marked GPIO_ACTIVE_HIGH. On the AD7616, as the =
line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
>      maxItems: 1


> =20
>    adi,range-gpios:
>      description:
> -      Must be the device tree identifier of the RANGE pin. The polarity =
on
> -      this pin determines the input range of the analog input channels. =
If
> -      this pin is tied to a logic high, the analog input range is =C2=B1=
10V for
> -      all channels. If this pin is tied to a logic low, the analog input=
 range
> +      Must be the device tree identifier of the RANGE pin. The state on =
this
> +      pin determines the input range of the analog input channels. If th=
is pin
> +      is tied to a logic high, the analog input range is =C2=B110V for a=
ll channels.
> +      On the AD760X, if this pin is tied to a logic low, the analog inpu=
t range
>        is =C2=B15V for all channels. As the line is active high, it shoul=
d be marked
> -      GPIO_ACTIVE_HIGH.
> +      GPIO_ACTIVE_HIGH. On the AD7616, there are 2 pins, and if the 2 pi=
ns are
> +      tied to a logic high, software mode is enabled, otherwise one of t=
he 3
> +      possible range values is selected.

With max items 1 how do we have 2?

>      maxItems: 1
> =20
>    adi,oversampling-ratio-gpios:
>      description:
> -      Must be the device tree identifier of the over-sampling
> -      mode pins. As the line is active high, it should be marked
> -      GPIO_ACTIVE_HIGH.
> +      Must be the device tree identifier of the over-sampling mode pins.=
 As the
> +      line is active high, it should be marked GPIO_ACTIVE_HIGH. On the =
AD7606X
> +      parts that support it, if all 3 pins are tied to a logic high, sof=
tware
> +      mode is enabled.
>      maxItems: 3



