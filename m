Return-Path: <linux-iio+bounces-16078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C223A45799
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 09:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA868169B03
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D212AE9A;
	Wed, 26 Feb 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVbO9hy9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD610258CCC;
	Wed, 26 Feb 2025 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556998; cv=none; b=qZuef24nSKjBHnpgTI5+RkYO2IQnge/9BjUiXry6xVY6SZ3T7dgcTSnNVPtKJHwwrVIHp7T2dTJl275p5ihMAjKMiWK8dmlk1S8MEk5X6EeV1HUeneA4U+YTJBohbmBK5BUYnQXBtOuaICFO9WlbaJx5RNIejHDnkRy6kfptZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556998; c=relaxed/simple;
	bh=WvdsTX+kie7pfosoex48vbu0w68lsCt6RTskLnOQE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gao+Vw1Up2Rdqhe2c44MBaJNdgbfsvCflHYpXmiY4CHGpxK5JuY31DSUTYx92oJZMOAqkQAiDm3jIsjFFqepkN2kSOR7dR3sR1eR2tGIOynaqDgzsK2RmlyGhb8OK2D18xrwEAs5J2yZftGV4ctyCvJy+6e/0Lp/kmL2XbpXimE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVbO9hy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1B5C4CED6;
	Wed, 26 Feb 2025 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740556996;
	bh=WvdsTX+kie7pfosoex48vbu0w68lsCt6RTskLnOQE84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVbO9hy96wu26vXIswNocbTecJKp5t1Nx6UzOZvd6FeNVGmWieJmGQUa7tVU4ZzuK
	 kEf6wunOoKDu48Kxdr97OEthdz1vjJAjnf+HBsmHHxxzZXFlmN8aRuSx3bAjpIcUZe
	 k035zL4/T4o4VJJ+douQVuWdYy8oAtV8sBCHUYcEg4er7YcfSR1udofSdCtNDep89r
	 wClsbCQfV4XvkPpy6py5DU7CHgE22T+oV60RY7+DUKfpZeDPcaDBHSYGR2T2WfB2V2
	 XqdNBGawblqLlk+0IaykbzR2wCdDHOwc/VLYnP6VUCyTf6TQbp+tne2+J8vFVV/jK+
	 bXEiNuJccy8zw==
Date: Wed, 26 Feb 2025 09:03:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225134612.577022-2-sam.winchenbach@framepointer.org>

On Tue, Feb 25, 2025 at 08:46:12AM -0500, Sam Winchenbach wrote:
> Adds two properties to add a margin when automatically finding the
> corner frequencies.
> 
> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml          | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Bindings are before users (see DT submitting patches), so this should be
re-ordered.

> 
> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> index b77e855bd594..2acdbd8d84cb 100644
> --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> @@ -44,6 +44,18 @@ properties:
>    '#clock-cells':
>      const: 0
>  
> +  adi,lpf-margin-hz:
> +    description:
> +      Sets minimum low-pass corner frequency to the frequency of rf_in plus
> +      this value when in auto mode.
> +    default: 0
> +
> +  adi,hpf-margin-hz:
> +    description:
> +      Sets maximum high-pass corner frequency to the frequency of rf_in minus
> +      this value when in auto mode.

IIUC, these are two bounds - lower and upper - in relation to something
else (like rf_in frequency)? If so, make it an array (naming to be
discuss, I assume you know better what's that):

adi,filter-margin-hz:
  items:
    - description: low-pass corner frequency to the freq.....
      minimum: xxxx?
      maximum: xxxx?
      default: 0
    - description: high-pass ....
      minimum: xxxx?
      maximum: xxxx?
      default: 0

Best regards,
Krzysztof


