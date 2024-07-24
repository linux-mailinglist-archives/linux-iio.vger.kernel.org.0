Return-Path: <linux-iio+bounces-7865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1093B539
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB681F22397
	for <lists+linux-iio@lfdr.de>; Wed, 24 Jul 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DF215ECEC;
	Wed, 24 Jul 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxZHiUvg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E022561B;
	Wed, 24 Jul 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839433; cv=none; b=AZZOfpNCr9ARe9hfX+maBCEMhuLp/r/iufjF0Q5YlKzNdnGLNArkMjBjbCPmT4U7WG5Y+Ge7Pf5T0vFXswrAWKKGfK855UfVNz79ptTAmmhTKGCC2HNBCi1fFYM0m5EojO1nGZlOaOqzb/K9uuwhqPKDUJBoAlaanUO5KTYSZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839433; c=relaxed/simple;
	bh=5JmJLMt7znCx017pyPoIq7UZLeqlEodflBEYHrF8fZE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=l8Zoj8ANgcZbCYcazivfQvBYnH1s/XUZu4U27sUadIjmaAjaa2zRZYi/7JJZ40nJ9+F4nCtlhE7wkkp6RB7SNXblOv1ubOpGy5LJ7HJ2EJz3CVEQK9PgfhKQWvQoC8KTu6e/2nB+xfy+FxfszWrmUGjr14LcjA87Zm1b21l1gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxZHiUvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C00C32781;
	Wed, 24 Jul 2024 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721839433;
	bh=5JmJLMt7znCx017pyPoIq7UZLeqlEodflBEYHrF8fZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bxZHiUvgdMDRZyD+uEK7AGz9ydWj6piRkVdNTEMzXbUgH6a9S8WhJK2WlTH/UAQT+
	 i1O5hFChGTrC1kpcn7tU65mAQuQEPTMJkdMls38ULic5J9qhKqHmxETrZb9o2m5JGB
	 8rsnE9PHCFOljmgiF+JvLIds1sd/s1QgyA/uMat7+ATCfZ6Muc9WTrcxJtYVR4uNe1
	 S2MmpN+xVRZnM+beliSZALPZo010JzwpZ06hj+9ZVH+KYQ+Q5E+0xbEXD0x0D0iMC/
	 biOORFTmwTJyQ6jD1ZiD73Yyr6i/Q2TDRKnI7UqhshKwXnzPqlzCvkBp3XWMOuiZNd
	 IhDYJMcXZfPPQ==
Date: Wed, 24 Jul 2024 11:43:51 -0500
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
Cc: fabrice.gasnier@foss.st.com, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, 
 Jonathan Cameron <jic23@kernel.org>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-iio@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240724153639.803263-5-olivier.moysan@foss.st.com>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
 <20240724153639.803263-5-olivier.moysan@foss.st.com>
Message-Id: <172183943127.3135721.14675824897973213166.robh@kernel.org>
Subject: Re: [PATCH v5 4/9] dt-bindings: iio: dfsdm: move to backend
 framework


On Wed, 24 Jul 2024 17:36:32 +0200, Olivier Moysan wrote:
> Change the DFSDM binding to use the new IIO backend framework,
> along with the adoption of IIO generic channels.
> This binding change allows to add scaling support to the DFSDM.
> 
> Keep the legacy binding as deprecated for backward compatibility.
> 
> The io-backends property is supported only in generic IIO channel
> binding.
> 
> - Channel description with the generic binding (Audio and Analog):
> 
>   Properties superseded by generic properties:
>     st,adc-channels: becomes "reg" property in channel node
>     st,adc-channel-names: becomes "label" property in channel node
>   Properties moved to channel child node:
>     st,adc-channel-types: becomes st,adc-channel-type
>     st,adc-channel-clk-src, st,adc-alt-channel
> 
> - Analog binding:
> 
>   DFSDM filter channel is configured as an IIO backend consumer.
>   Add io-backends property in channel child nodes.
> 
>   DFSDM is no more configured as a channel consumer from SD modulator.
>   Use of io-channels in DFSDM node is deprecated.
> 
> - Audio binding:
> 
>   DFSDM audio DAI is configured as a channel consumer from DFSDM filter.
>   No change compare to legacy.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 124 +++++++++++++++---
>  1 file changed, 108 insertions(+), 16 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml:421:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240724153639.803263-5-olivier.moysan@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


