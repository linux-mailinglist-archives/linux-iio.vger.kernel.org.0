Return-Path: <linux-iio+bounces-7269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D492492673D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 19:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E401C2266E
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 17:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE2185095;
	Wed,  3 Jul 2024 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huhcvFMs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F3183086;
	Wed,  3 Jul 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028033; cv=none; b=BhtV4Tr0Ca6xCd6k8P5KkoLX/pTJuXq8zW6Zx2L09arTZQWe5Fvo15m2HjIwbt9vA5G1zTHsdEZ6MH4WVvCK1B9P0QrtAempazzZOwxAlMFDAH32FoSwCTqnHMhyOJsVZ85snPZspHbfB5OZ5csk0RpZILEFBiAKeAaYwD4KuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028033; c=relaxed/simple;
	bh=ZOEqHxW3PvtIUqCf88aR5sTRlrjOZ4x6nVLtKB663/0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bpJKtOUahi80gPCu/GaBHjdFUrrvnjNfWCXBbGuJY9wO3xr/QAWWRYAdqPGLvL5vSWIrXIHJ5NHuz1J9tIZS9CdzhYPVxTQ5ezgUnwxN25inBAUswZMY/ThlTHHA7cte0pDv0OzZJabjma0WkVYc8ccorY3Vev9HAKA6Fb56NQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huhcvFMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3922FC2BD10;
	Wed,  3 Jul 2024 17:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720028032;
	bh=ZOEqHxW3PvtIUqCf88aR5sTRlrjOZ4x6nVLtKB663/0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=huhcvFMs3qGOIiWMNlbEPTGD8zgZnOlHRuc155lQ8N65KJjTdZgX8RaQPTLjVSQII
	 mOjt+mUA7rUev6Ye9k603HgDnNhP0M7bqNLCiS2hZA9s4CzFkRZaFyblITxbqcmOuC
	 wLSmVfzqyXKCOYI5wAUK1AqEeHn8uybq8Aa96CrOMgNK6M6XGOm6KESSi1076qf3j+
	 v5bOnkc8glCjn3fXjRuMwpHLxXY+ragabJWH53zlkAqp6IR0bBfZuQlemYkY6WLLum
	 seNZ2ujWEtWnfoOysn/LonA8oXpsTetAowVUFkQ7N2e2NX9hyvAb8nPkePFakvXvgL
	 Oex/mQBixUS1w==
Date: Wed, 03 Jul 2024 11:33:51 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20240703160535.2277871-6-olivier.moysan@foss.st.com>
References: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
 <20240703160535.2277871-6-olivier.moysan@foss.st.com>
Message-Id: <172002803113.1236256.3525407174044863174.robh@kernel.org>
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: add backend support to sd
 modulator


On Wed, 03 Jul 2024 18:05:30 +0200, Olivier Moysan wrote:
> The legacy sd modulator driver registers the sigma delta modulator as
> an IIO channel provider. This implementation is not convenient when the
> SD modulator has to be cascaded with another IIO device. The scaling
> information is distributed across devices, which makes it difficult to
> report consistent scaling data on IIO devices.
> 
> The solution is to expose these cascaded IIO devices as an aggregate
> device, which report global scaling information.
> Add IIO backend support to SD modulator to allow scaling information
> management.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../iio/adc/sigma-delta-modulator.yaml        | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml:38:5: [warning] wrong indentation: expected 6 but found 4 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.example.dtb: /example-0/ads1201_0: failed to match any schema with compatible: ['ti,ads1201']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240703160535.2277871-6-olivier.moysan@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


