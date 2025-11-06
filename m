Return-Path: <linux-iio+bounces-25931-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A679DC39BCA
	for <lists+linux-iio@lfdr.de>; Thu, 06 Nov 2025 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94273189C641
	for <lists+linux-iio@lfdr.de>; Thu,  6 Nov 2025 09:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84AA309DDF;
	Thu,  6 Nov 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5ukcegI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D64239E9E;
	Thu,  6 Nov 2025 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419877; cv=none; b=OtmSdmATiGp9cNuvG2idRkWbrApKn9GF42xDySPIrMwnz0OYkkRqCtee96eCLoM7R7uI95PuIgqX6xc6usixvMHe+dRzrTEkztfeqe4i3LC6Le9Eh8j4cprS+mzet1MjjhdO92lk+C0+EaMCg+TgwH9K30hUDLgXIBvaIN9lkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419877; c=relaxed/simple;
	bh=rUwPmkH8kWk1exxLyZIry9wcfD3f8VL+DC2RWEsGmo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ska1KyWYwKwtnyTTE7gJKHr8Af/scyUfBbHGbbgnYBH5rqYKTooy0ckSGmE4atBNnC6LN9FGRpyNqRQpyF8B2z1NRY4jU3v3Mi7b2xYak8GiVaJ8/Rt79V9ZGl5QButTU7WWo7WxatBAQRx4GyiaQF+6mFGltH8VrHfOgDCzRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5ukcegI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980E6C4CEF7;
	Thu,  6 Nov 2025 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762419877;
	bh=rUwPmkH8kWk1exxLyZIry9wcfD3f8VL+DC2RWEsGmo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5ukcegIHkGGfbGe3wBEjUx4e/bYvj7mlBFbcVuGTAfCQ/uPDpPBA0ziewrXbXAnr
	 8vLXcDHOFfke7Be96lL3zrGcJ04I9IFB8XbsjUYgM7Ehn6b3CXMjAvZ/hr2K6XWRmF
	 gJVasCBiyF4VXdQq3QmEOCfR7ZzGF153e6DmU5luVzN99O1j7QuGBTMNTptoFSrpnH
	 RbQLnIfdMZcHxtRVlgbhXZA9XKO563UQcRBuBafYIn3vJfuukZOar/7BxuLzrsgeki
	 Q6COZwX8m9sTpHv5SYm4C8hkWS0HZqsgsCOR1e9ExD+ZVRZc7tkCZm2P7RRKmKl4A9
	 SNk9NZm7JArtA==
Date: Thu, 6 Nov 2025 10:04:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, ramona.gradinariu@analog.com, 
	antoniu.miclaus@analog.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: accel: adxl380: add new supported
 parts
Message-ID: <20251106-adorable-beluga-of-admiration-4dbd17@kuoka>
References: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2b8fc2ea006d06660c83f1e9e1ccfc865803dafb.1762281527.git.Jonathan.Santos@analog.com>

On Wed, Nov 05, 2025 at 09:40:24AM -0300, Jonathan Santos wrote:
> Include ADXL318 and ADXL319 accelerometers to the documentation.
> The ADXL318 is based on the ADXL380, while the ADXL319 is based on the
> ADXL382. However, the ADXL318/319 do not support some built-in features
> like single tap, double tap and triple tap detection, and also activity
> and inactivity detection.
>=20
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  .../devicetree/bindings/iio/accel/adi,adxl380.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml=
 b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> index f1ff5ff4f478..f38f384dd818 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl380.yaml
> @@ -11,18 +11,21 @@ maintainers:
>    - Antoniu Miclaus <antoniu.miclaus@analog.com>
> =20
>  description: |
> -  The ADXL380/ADXL382 is a low noise density, low power, 3-axis
> -  accelerometer with selectable measurement ranges. The ADXL380
> -  supports the =C2=B14 g, =C2=B18 g, and =C2=B116 g ranges, and the ADXL=
382 supports
> -  =C2=B115 g, =C2=B130 g, and =C2=B160 g ranges.
> +  The ADXL380/ADXL382 and ADXL318/ADXL319 are low noise density,
> +  low power, 3-axis accelerometers with selectable measurement ranges.
> +  The ADXL380 and ADXL318 support the =C2=B14 g, =C2=B18 g, and =C2=B116=
 g ranges,
> +  while the ADXL382 and ADXL319 support =C2=B115 g, =C2=B130 g, and =C2=
=B160 g ranges.
> =20
>    https://www.analog.com/en/products/adxl380.html
> +  https://www.analog.com/en/products/adxl318.html

318 < 380

> =20
>  properties:
>    compatible:
>      enum:
>        - adi,adxl380
>        - adi,adxl382
> +      - adi,adxl318
> +      - adi,adxl319

Same here. Please keep this sorted.

Best regards,
Krzysztof


