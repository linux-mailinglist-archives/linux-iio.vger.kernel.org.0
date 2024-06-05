Return-Path: <linux-iio+bounces-5837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 712DA8FD370
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC521F265FA
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09AA188CDF;
	Wed,  5 Jun 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5KRPFLC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AA1CD25;
	Wed,  5 Jun 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606717; cv=none; b=T4bim64hRdfV3h8bEfBfOuHzhmdNL+JG3AUrcN9/XtSggtVefzrtZ+rwugFmZvy6gY+MtwZHJT7PwDUpbO5k4qJpkASKXcRziBrgv9M3yGzS6AcMIPMC3dzunodCCdr3lUGZzwE74vp9GfmAIA5R39xU0dT3fGiNYQtOE/6t39E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606717; c=relaxed/simple;
	bh=y1dZJ8vNM9lhOuh+/XbBtRYjaxOHJLUue9NVr17fWL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJcV5tB961Uapkhi1vPA51bgfw2aXRIBdif73QwyFxfDTKNNLZNfVdD7eBUw3LO44gQ0eqnimcCnz58gCoInzqb0m3BFV2RLtUxsPwlibLjTzK25nJzF/e/N8rBHcudwwoBRZn4ptSpUotGSnZ0AiKD5DjpoGllWmZiv/UD01CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5KRPFLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C0C2BD11;
	Wed,  5 Jun 2024 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717606717;
	bh=y1dZJ8vNM9lhOuh+/XbBtRYjaxOHJLUue9NVr17fWL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5KRPFLCWESpqX/8tx55LSPg//Y/NY+cG+D3FaYcI9ay7NlTrE65pQiH86kN9S5Im
	 kIalpke02BuBB2/Sz8NXAKUYxRx2xij9PWRtucJsxhf2RbCa6tp0pswi1m3H+M7Rb5
	 IWFldkIZm8DkUbcAHM+45MEyOpv5gFAdCdpttPVslHvWCwi+1tEfl9aF9QJYciE5ly
	 zldCd/+tOuLZV0uM7DFN579svDBE1zTk6Kwfvt8pyjtpQMta3SX4qKDYPOD77ieEeg
	 3UDEuVbRNILs4m5pYF0pCyN+JnnVug6e345fZ8GVmDy8cFTC/DkYsKIodDSyqkmCor
	 QNST7qnkb2KQw==
Date: Wed, 5 Jun 2024 17:58:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: amlogic,meson-saradc: add
 optional power-domains
Message-ID: <20240605-abdomen-starch-4fd4d7ead431@spud>
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WFIeevaQAu8dnksl"
Content-Disposition: inline
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-sardac-v1-1-40a8de6baa59@linaro.org>


--WFIeevaQAu8dnksl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2024 at 11:37:08AM +0200, Neil Armstrong wrote:
> On newer SoCs, the SAR ADC hardware can require a power-domain to operate,
> add it as optional.

What about the older socs that don't have power domains, the property is
now usable there?

--WFIeevaQAu8dnksl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmCZOAAKCRB4tDGHoIJi
0p9tAP9Q1Lzbf5N1VQfKderTZKLcQY8ND6Nvcw+SgZ1tiYKD9QD/bp3ABMjrpCdn
Z4LvNlFSOpdYuSZJGBv9gcVsHJlUJQQ=
=Idog
-----END PGP SIGNATURE-----

--WFIeevaQAu8dnksl--

