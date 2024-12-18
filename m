Return-Path: <linux-iio+bounces-13619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E59F69FB
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 16:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C107A48AA
	for <lists+linux-iio@lfdr.de>; Wed, 18 Dec 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2B1D45FC;
	Wed, 18 Dec 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IssNn2yu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88468481B3;
	Wed, 18 Dec 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535550; cv=none; b=lBsx2VjpJtF027pfzuxKCeUyGvtkrtN+TisWtFgatJlP9RIXgo7VdpoJ8psp8Vt53KnzZwUtqQaHD37yo9+t8fPkQBsg1gz4kYivBjJ7FqujwQmgaHY0lzVlMMVHNnVBsN8kfdLdZHvgXm0cIXfc/3sHqlgiIEryN4gqDrjJWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535550; c=relaxed/simple;
	bh=364jpQG1OxbTmeOMxM6YqE59IW14WKenDGnbbpYd+50=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=QFwClvXXp35KnpdHqz/hrTouLydzGVumulICAE+VwQ2Py8F9nPNBe3JKQUzQ4Wei6ACOhWF5mMJCq5WySRF+6tu8V+bmPmH6u7VA82Eq5mrF8tEtkg9EfXUf1HxMd0HIi0q4pl8jJeA/s1hY17uuFh+/fyZhxHBZUiI3yOMQs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IssNn2yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E0FC4CECD;
	Wed, 18 Dec 2024 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734535550;
	bh=364jpQG1OxbTmeOMxM6YqE59IW14WKenDGnbbpYd+50=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IssNn2yuIU4qBi9b3q0g59lFo7aCHQDEPPrDtpPGYtm7YAczaDUEKtmjZNFF8vrMn
	 CzVcRax7cqdEGhuSnfw1vplTt3APPDwxGCc8rSIz/Y3OnDRw1zUknGQjDUVai/W85B
	 BTd7ffKQrqIxAanJywP0Dp+SKCB6/NO3wGzx0y1kHfBYqdI8RAwJk3C23jmEvK1Ccl
	 TdMGP/73X8XfNK3VUr17TDrWqXceF2D5qPysAhUGoMBxDOaeIlrzOGiyw6fROwkun4
	 yh3uhA9oNR2XTpgO1GYoFI3u7UfggB7pTLCEhWRzt1YPGU7nvKFMay+tyR3OAj9F/w
	 Ht46v7EaqtMww==
Date: Wed, 18 Dec 2024 09:25:48 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, 
 krzk+dt@kernel.org, linux-iio@vger.kernel.org, jic23@kernel.org, 
 conor+dt@kernel.org, lars@metafoo.de, devicetree@vger.kernel.org, 
 ana-maria.cusco@analog.com, marcelo.schmitt1@gmail.com
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
 <caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com>
Message-Id: <173453554826.1716066.2135391856216546705.robh@kernel.org>
Subject: Re: [RFC PATCH 2/4] dt-bindings: iio: adc: Add AD4170


On Wed, 18 Dec 2024 11:37:42 -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD4170 sigma-delta ADCs.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad4170.yaml          | 473 ++++++++++++++++++
>  1 file changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml: adi,config-setup-number: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/caadb73da62e80877eab8b0287d996b52266d912.1734530280.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


