Return-Path: <linux-iio+bounces-5773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807648FBA88
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 19:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E16288B9D
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBA0149E05;
	Tue,  4 Jun 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvrHJ2qc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF86149C58;
	Tue,  4 Jun 2024 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522479; cv=none; b=nP1NfNr2PNXtNkgtLpZFcSOBEIbsJas7fcqh6wbhKCHyKUJ7f28kCcoOzPJt60R+6kSdn4CL3xlwnLJTiCrI2ZSmw8EzkCwebWZQlUAWwLSyzesuwxJG2IF/jxFCok+zU0bjb5RYxB1aXh/eSsVyprPveCw5XG9VYKizO1R4+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522479; c=relaxed/simple;
	bh=mBjS3PkyPZqLidoYSO/7OG/yx3lWsxvuDm8eBxTFLZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEEsGR1LjKEDpPtTZpALcjGSB8uj3AdSWPSCt4gvW0gXtFual2pYoGgMTCXP97WRlv2bmrGKXcQEi4rEolhT2y79ihuZcNzXr7F+RZLUkTfnP1cVPFCgBxXY7WSQW1URZuRMxX3XQziBf91ud/5UTyO75ZhzydC+fUNK3fu0Vws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvrHJ2qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95037C2BBFC;
	Tue,  4 Jun 2024 17:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522479;
	bh=mBjS3PkyPZqLidoYSO/7OG/yx3lWsxvuDm8eBxTFLZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvrHJ2qcH4XDdneMTN2vrA1Pw4nVUqdU8X8ZVPnJzuoig9BsP2hb2pGeG8OCVodDY
	 vlEvQTHyZZ2ez/8dN81zicSqN+JZveHSrFHVe4WB4jkXRkeeaoKKXdp2l+4BFVQd6a
	 s+qMGRma6z0epuuQnuTDOWNR1oTRRZ5mfyBj3oXQ+fIK9DyT/vEFtbmbp9smsn2dBK
	 N3RYOMl/jd7gF+1JRMbmvJ79D0/k87xp9/Y3qkwWiq832iUJKwIDm+K1kRV2c9IapZ
	 r2sRm8wIMt2fv3T/qLqDi5NH/KHrq8S690sl0T6jE7WaK8JLjIhjYKmdjm3xdkHJat
	 h1QVUKweHW27g==
Date: Tue, 4 Jun 2024 18:34:34 +0100
From: Conor Dooley <conor@kernel.org>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v5 2/9] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240604-darkish-paprika-351ad2f72e96@spud>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
 <20240603-ad4111-v5-2-9a9c54d9ac78@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ICeoNF/w62bKpKgP"
Content-Disposition: inline
In-Reply-To: <20240603-ad4111-v5-2-9a9c54d9ac78@analog.com>


--ICeoNF/w62bKpKgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 07:23:00PM +0300, Dumitru Ceclan via B4 Relay wrote:
> +      common-mode-channel:
> +        description:
> +          This property is used for defining the negative input of a
> +          single-ended or pseudo-differential voltage channel.
> +
> +          Special inputs are valid as well.
> +        minimum: 0
> +        maximum: 31

I think this property, since it purports to be a common one due to the
lack of a vendor prefix, should be documented in adc.yaml.

> +
>        adi,reference-select:
>          description: |
>            Select the reference source to use when converting on
> @@ -154,9 +213,31 @@ patternProperties:
>            - avdd
>          default: refout-avss
> =20
> +      adi,current-channel:
> +        description: |
> +          Signal that the selected inputs are current channels.
> +          Only available on AD4111 and AD4112.

> +        type: boolean
Instead of boolean, use:
    $ref: /schemas/types.yaml#/definitions/flag

Otherwise, I think this all looks okay.

--ICeoNF/w62bKpKgP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZl9QKgAKCRB4tDGHoIJi
0opdAPdU6LlCW4TffD6ame5jjBfZLhk26hiOVuyNlT53peXSAQDWQrG9YcGs8XyW
xH1awVu8+MXKYRpbKhXBTh+nSqahDw==
=TIka
-----END PGP SIGNATURE-----

--ICeoNF/w62bKpKgP--

