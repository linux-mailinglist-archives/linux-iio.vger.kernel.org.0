Return-Path: <linux-iio+bounces-5684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02B8D84F7
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1024C1F21555
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20012EBCA;
	Mon,  3 Jun 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogNirmqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6512E1E9;
	Mon,  3 Jun 2024 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424968; cv=none; b=A1o9Mny5i5Jhnioqpl+DGeIX70SIuQPkgSN5creOM4VAbhHXrze7Gv98zSaKhzcD6CNTMCtZ4Ujq5ucohJHebnZmGtTj81A5xKCvTUzaMXmBJE2aiYQeJvBi7TeHub376EbIfZ+0JI1EX/d6BljKnjaelGGa+ag51lfLJSspykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424968; c=relaxed/simple;
	bh=FRO1GsThD+8G3ac6c2VNDgi7xDQo7ElrPAWbCxkiGG0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=WQ6LHeLKmtkwVAHQ/1NHytFRD3xE8YPKRNaJWiLmJ2mUVH/gja7quyupV6CDbaQPiKiyP1wO2Bkjw9TYXchDc9C98gcJOoSVBM1rGpMCUVraM+WaGBvEniZXXItCdBJWFtfTXzkkuNId8DXkvtRhBDnsw/aevQyWwUt8PA+gIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogNirmqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF2FC2BD10;
	Mon,  3 Jun 2024 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424968;
	bh=FRO1GsThD+8G3ac6c2VNDgi7xDQo7ElrPAWbCxkiGG0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ogNirmqUkVsYlwIKWmQp/sxqgb3P266qOK+5Hpg8XuR3mz4AEnx8KK7TdN82IGzAy
	 xpP+nI6h55UFDSimz6k0e0J97KBzMlB1ZbwF0KcKBCSP6ntFjtawTtM17r1bz7Qdj7
	 ZZR+/CZLfNhxoWR1qkRWJpoVpAK2r0R3OWW0ZbOmLV7GLI9B+utj3TKbuIrAa0M3P/
	 6J+gJlFARURNtb9VO0JRadA/Pvir73AJfVRhjM7qqUTQ4s1CrZDLzS4dtAG8SE0npR
	 JEz2UxLmXqcz3fYfhOB2bnwZ+bIKvHG2Nn72Ig9RZ2WI7HDBzOGTEsmWDx7OkcWtfY
	 lfkBVQ4sxEKKg==
Date: Mon, 03 Jun 2024 09:29:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mudit Sharma <muditsharma.info@gmail.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, lars@metafoo.de, 
 ivan.orlov0322@gmail.com, jic23@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org
In-Reply-To: <20240603134015.70388-1-muditsharma.info@gmail.com>
References: <20240603134015.70388-1-muditsharma.info@gmail.com>
Message-Id: <171742496559.385807.12490894623691830136.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: light: ROHM BH1745


On Mon, 03 Jun 2024 14:40:13 +0100, Mudit Sharma wrote:
> Add ROHM BH1745 - 4 channel I2C colour sensor's dt-bindings.
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> ---
>  .../bindings/iio/light/rohm,bh1745.yaml       | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/light/rohm,bh1745.yaml: maintainers: 'Mudit Sharma <muditsharma.info@gmail.com>' is not of type 'array'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240603134015.70388-1-muditsharma.info@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


