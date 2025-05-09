Return-Path: <linux-iio+bounces-19397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03127AB1A49
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 18:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7691DB41C66
	for <lists+linux-iio@lfdr.de>; Fri,  9 May 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876102367C9;
	Fri,  9 May 2025 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXEfiWzH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D106212B05;
	Fri,  9 May 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807542; cv=none; b=LRIMbTGcGwvcRQZO2Kc6vB2Ar0hU3Cf4FnnCwa9gY6XLsikjtvlmwg8VOW54sj68mCkxHX2Wqm0YM9aFwL59WgRh1xE8XlN/kTvW4AdosGpuu47eep1AkrV9ADJ9M/HdmA5lobvyGef69o+cl7NfafOjvGyxhYOASAFWqE/AB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807542; c=relaxed/simple;
	bh=yxU9epCjfjrkhmIjvYnzwdMNf3n/vyyPrAQQiuM40Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA5DAAz+aH4K5kg3y6ZVt1lKlWnInVJ/YJHQ1ccNhPiuAED2PMjcaW/z7lJi6ycoYQRpqmrZtTORcYc1SUIzjjbXygmAdAzF/z4VLsYLRoPCKtMRDtxEZZ07DUhbkV15KHVBeuIeUj7xJN/w1+7aLhI4FjQ3CvL7ousn4/tboiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXEfiWzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C63C4CEED;
	Fri,  9 May 2025 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746807541;
	bh=yxU9epCjfjrkhmIjvYnzwdMNf3n/vyyPrAQQiuM40Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXEfiWzHYGkIc4V+1gCXViTz3bPgcHWSLcceefx4jNBukedCr7lPTzS/9dspnhlih
	 BrYtXXZ+QqXKI+S9vjT7KWL/ZfteVLPG0fWGdTvS7F4HgQE1nA2e9Jk9hX7ngcD8pA
	 D2NuzIn5vSpry2tMrbtT9MQ48t89bewTuyvJPeG108xOJK8/8In0QQlx6QThwdT9ZT
	 I5vNPtyyuiU48t0j/qSaou6v92r/5eIY9L9PIDuVxV5bLehF64deG/Cm+29hXbzzbY
	 bM+F/AFlUfHWfiGsqZUGipObfb/Chg/wPR8Xmc1vPhH023rStfyzg6fzya+4HqO0KX
	 a+n12/fe+fk+A==
Date: Fri, 9 May 2025 17:18:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com,
	David Lechner <dlechner@baylirbe.com>
Subject: Re: [PATCH v7 03/12] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250509-gala-unfiled-fd273655b89d@spud>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
 <731196750f27eee0bad5493647edb2f67a05a6e2.1746662899.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y3HCj6m+kwEOd5rj"
Content-Disposition: inline
In-Reply-To: <731196750f27eee0bad5493647edb2f67a05a6e2.1746662899.git.Jonathan.Santos@analog.com>


--Y3HCj6m+kwEOd5rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 08, 2025 at 02:03:30PM -0300, Jonathan Santos wrote:
> +dependencies:
> +  adi,sync-in-gpios:
> +    not:
> +      required:
> +        - trigger-sources
> +  trigger-sources:
> +    not:
> +      required:
> +        - adi,sync-in-gpios

Actually, this is normally not written like this. Usually it is done as
an allOf entry:
  - if:
      required:
        - maxim,gpio-poc
    then:
      properties:
        poc-supply: false
        gpio-controller: false

--Y3HCj6m+kwEOd5rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaB4q7wAKCRB4tDGHoIJi
0oZzAPwPUKSBLiMIGUSmw/L5ltSvNBqEyK6Kdh0T6Z4SFo4SSgD/drQHaWB2p1zs
WNQunAze+EjQ+qmUatfORHhmzm4yNwM=
=m/bM
-----END PGP SIGNATURE-----

--Y3HCj6m+kwEOd5rj--

