Return-Path: <linux-iio+bounces-7038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B094091CDE0
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 17:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18051C2110B
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E484DE0;
	Sat, 29 Jun 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atMMRmil"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491C1E4AF;
	Sat, 29 Jun 2024 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719674957; cv=none; b=QomHl8RyoFYiBpAdJTRpVu3LWqaqBN4EUvAdBFq+bpafuvCNTKJGpe7hcDI+SIJBNcuIYuTODzMXvP4FEKkvH1rEiNKNF2pxdsvQa9ICf8sX71hlvD0LDV/StdjmS8qM4BG9Jqtug9T+lPbxB0BC/wtvfa7v9jvJoBpyz2HkmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719674957; c=relaxed/simple;
	bh=Erjel+X1YZk+F2BMvV3MLMF/avImFt5detEsk83oFW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmUSCaWWgyljfvGWyC73rhZjzSFt4Gqp8daFBuBENsjhiPXh5y6OA8S0KpL3UCCJ0Dhn9laRwLJ1YcMQONLDj8HUsYsbaQWlJ6WKWS+Wy8q0BDoH8AG6h/wAonw3ubP/AefuHujr2CqDxkxsbXrTbciSYIfHXRTxLvUuxm8RMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atMMRmil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9145C2BBFC;
	Sat, 29 Jun 2024 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719674956;
	bh=Erjel+X1YZk+F2BMvV3MLMF/avImFt5detEsk83oFW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atMMRmilT/2CuR825T5oeCA5ZfUqgTehLUwIxNJX6OlPkWVvK30bUd4hA54y0BTRu
	 9JwxROW17J+3dyqS8YcT6wgnPPBUMJZDDbyonoF6dhnyhQE40MRS/W0zPEz5BnEN96
	 usFshYh4IUhA+d3AujDmQnnbpUo0+rz3CsFhy1jH73qGkEb8F4DGLhsNxOrp+v70Lf
	 /r9jBymnMSci3qMP144TUkG1jfuIAKxPYYzQI8CAMpe4W7e99hscMK5+iGKwGPlhcu
	 sntcLItN3iECaPFjS3mu7elP6KckTMhPbIi69g+YNRwxSSuU4L1uVM1QQX/ou6C/C/
	 9ltUQosGdpX3w==
Date: Sat, 29 Jun 2024 16:29:07 +0100
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
Subject: Re: [PATCH v2 04/10] dt-bindings: iio: adc: adi,ad7606: improve
 descriptions
Message-ID: <20240629162907.0f5b234e@jic23-huawei>
In-Reply-To: <20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
	<20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jun 2024 14:48:22 +0000
Guillaume Stols <gstols@baylibre.com> wrote:

> Reword a few descriptions, and normalize the text width to 80 characters.
>=20
> Signed-off-by: Guillaume Stols <gstols@baylibre.com>

One minor comment inline.  I can tidy it up whilst applying if
everything else is fine in the rest of the series.

Jonathan

> ---
>  .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 33 +++++++++++++---=
------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 32caa9fc00e4..509970922cda 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -36,6 +36,9 @@ properties:
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
> @@ -48,8 +51,9 @@ properties:
>    reset-gpios:
>      description:
>        Must be the device tree identifier of the RESET pin. If specified,=
 it will
> -      be asserted during driver probe. As the line is active high, it sh=
ould be
> -      marked GPIO_ACTIVE_HIGH.
> +      be asserted during driver probe. On the AD7606x, as the line is ac=
tive
> +      high, it should be marked GPIO_ACTIVE_HIGH. On the AD7616, as the =
line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
>      maxItems: 1
> =20
>    standby-gpios:
> @@ -62,36 +66,39 @@ properties:
> =20
>    adi,first-data-gpios:
>      description:
> -      Must be the device tree identifier of the FRSTDATA pin.  The FRSTD=
ATA
> +      Must be the device tree identifier of the FRSTDATA pin. The FRSTDA=
TA
>        output indicates when the first channel, V1, is being read back on=
 either
> -      the parallel, byte or serial interface.  As the line is active hig=
h, it
> +      the parallel, byte or serial interface. As the line is active high=
, it
>        should be marked GPIO_ACTIVE_HIGH.
>      maxItems: 1
> =20
>    adi,range-gpios:
>      description:
> -      Must be the device tree identifier of the RANGE pin. The polarity =
on this
> +      Must be the device tree identifier of the RANGE pin. The state on =
this
>        pin determines the input range of the analog input channels. If th=
is pin
>        is tied to a logic high, the analog input range is =C2=B110V for a=
ll channels.
> -      If this pin is tied to a logic low, the analog input range is =C2=
=B15V for all
> -      channels. As the line is active high, it should be marked
> +      On the AD760X, if this pin is tied to a logic low, the analog inpu=
t range
> +      is =C2=B15V for all channels. As the line is active high, it shoul=
d be marked
>        GPIO_ACTIVE_HIGH.
>      maxItems: 1
> =20
>    adi,oversampling-ratio-gpios:
>      description:
>        Must be the device tree identifier of the over-sampling mode pins.=
 As the
> -      line is active high, it should be marked GPIO_ACTIVE_HIGH.
> +      line is active high, it should be marked GPIO_ACTIVE_HIGH. On the =
AD7606X
> +      parts that support it, if all 3 pins are tied to a logic high, sof=
tware
> +      mode is enabled.
>      maxItems: 3
> =20
>    adi,sw-mode:
>      description:
> -      Software mode of operation, so far available only for ad7616 and a=
d7606b.
> +      Software mode of operation, so far available only for AD7616 and A=
D7606b.
>        It is enabled when all three oversampling mode pins are connected =
to high
> -      level. The device is configured by the corresponding registers. If=
 the
> -      adi,oversampling-ratio-gpios property is defined, then the driver =
will set
> -      the oversampling gpios to high. Otherwise, it is assumed that the =
pins are
> -      hardwired to VDD.
> +      level for the AD7606B, or all two range selection pins are connect=
ed to
If rolling again for some reason=20

       level for the AD7606B, or both the range selections are connected to=
 high
       level for the AD7616.

> +      high level for the AD7616. The device is configured by the corresp=
onding
> +      registers. If the adi,oversampling-ratio-gpios property is defined=
, then
> +      the driver will set the oversampling gpios to high. Otherwise, it =
is
> +      assumed that the pins are hardwired to VDD.
>      type: boolean
> =20
>  required:
>=20


