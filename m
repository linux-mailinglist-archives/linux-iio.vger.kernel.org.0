Return-Path: <linux-iio+bounces-15484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34EBA33AD5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 10:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEBA3A304D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Feb 2025 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4321323B;
	Thu, 13 Feb 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzT9UTXT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054220C490;
	Thu, 13 Feb 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437887; cv=none; b=IHir14wNOKwl0iZmlq2vmx45MZ+s2px3XqdWN86X4Hbz5HgAPoUSovHyZI85yrBeB34WQH1F0d3TBh08NkqY+YnnI3BS2sOsN5e+cRHLwBtPwr6L1EPR7BbtlV3kBXyLzEh8N+cmhJCyf2YZVfHx/G40AEuRFszFzlHFJUQkyG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437887; c=relaxed/simple;
	bh=9CDFhqfIxeQyHTbZH1uStYMdZmrLJeZxIzxr01pm+PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIrBReL+79GONQknIK/S1WLKwh6McOdj/YlRgcSf+Cd4B3OtaeHckGf+Wmy3zWp08Alz5XRcEuT3344m2OBWTT9kbot69DH4QBwtvU3F12sbkSY0PLtVctUVyiEt66dr0gPu1kM8rSLKyuxjMKCEkvQMVUsUVwGvDkxzGIAmOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzT9UTXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CAEC4CED1;
	Thu, 13 Feb 2025 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739437887;
	bh=9CDFhqfIxeQyHTbZH1uStYMdZmrLJeZxIzxr01pm+PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzT9UTXT/D9QXKFlWezDobk5v57dZEPTqBaR9qeB3QpUZUfbCKFCH2MjTCyYZsvXh
	 jfVpPTqQmiSClH/j01gZ1HGsMmARasUaWFxk2aO2hGH0H19y7z8hJQC0KEHRmca9Wv
	 RvCoBtcSiFcG59rfAsMVt46DuZTKBEUZpm/0gqLBWlZhYaGTnpysU1g4eJAqCzxpze
	 IpG93cYVjrrdPZwxN9+xUe/U7qEPhYZSIXQVMgsO42O6Q5HtSY7orIAK9MTFABK615
	 j8TZTYQbxhGuFewDDKU0dRS0qXXq8hFOvh5Ao3PZ0lgZz4WJK1nacPQZ43F2kvCa7U
	 qqYjPSpbbWGqw==
Date: Thu, 13 Feb 2025 10:11:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: iio: light: al3010: add al3000a
 support
Message-ID: <20250213-eminent-antique-koala-5a68fd@krzk-bin>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212064657.5683-2-clamor95@gmail.com>

On Wed, Feb 12, 2025 at 08:46:55AM +0200, Svyatoslav Ryhel wrote:
> AL3000a is an ambient light sensor quite closely related to
> exising AL3010 and can re-use exising schema for AL3010.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/dynaimage,al3010.yaml     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> index a3a979553e32..6db4dfd5aa6c 100644
> --- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
> @@ -4,14 +4,16 @@
>  $id: http://devicetree.org/schemas/iio/light/dynaimage,al3010.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Dyna-Image AL3010 sensor
> +title: Dyna-Image AL3000a/AL3010 sensor
>  
>  maintainers:
>    - David Heidelberg <david@ixit.cz>
>  
>  properties:
>    compatible:
> -    const: dynaimage,al3010
> +    enum:
> +      - dynaimage,al3010
> +      - dynaimage,al3000a

If this stays here, keep alphabetical order.

Best regards,
Krzysztof


