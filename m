Return-Path: <linux-iio+bounces-7396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2869929804
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 15:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F09E1C2082D
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698201F947;
	Sun,  7 Jul 2024 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcDbMQ2H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234631DFD0;
	Sun,  7 Jul 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720357544; cv=none; b=q+hQiCGFHJsb72xW0fmXCMV2pVMStRhEE2JvElCIjcYpGZfXFq7HzwXJKBOXjOr6CoRggbz4aTx7LkgA9+CrqpqLm35JFGcW0Rej61jawDUMeVkPIe7VQHepgnwmdwiYxENuM7eDjmi6dRzXl1gJMs7+DEuhulf27bAbpO8jLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720357544; c=relaxed/simple;
	bh=M+lisCp633+M0Z1/hAPSKFqxu14ftfZ2Hy+tPvtAqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHssgFBG7q+4aDpDDDCyN1/BNp+jVuCgzQSAVTUrZblciXt8EEjjVDoPApSd7DGJccRXX1mwxncP3fVs+hqIkt8I67JRiaCX7af4EWT8hBGhC7y4PNrq36TdxNmWZXm+I/6pA99B3dcyBTpRVfthLhF1z5Z5R/lzR9gixrziCko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcDbMQ2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB587C3277B;
	Sun,  7 Jul 2024 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720357543;
	bh=M+lisCp633+M0Z1/hAPSKFqxu14ftfZ2Hy+tPvtAqzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WcDbMQ2HNa67OHKexKGMJ0bAjIAni2o4mKq6NVQIt48oR3YZxbkAFbhunpl5JeA+D
	 KM93mIlYPVLrat/0K2cfiUSmrmVgppxTyc/kcHWaLd/bLpCvU7LVqyk8Y8rZyAmv7G
	 KwxPc/uu3NQBvvrErp598+40HK7MFlBh30/uSZLsZAK/3aailDV+MT513giKxo0ARU
	 g8QiS8Gh+Uuz1tUKpDS/Cfe2mkdNI460M4Nm9lqHBbmSZ0CuasjD7E/OGGpl9Xxwa5
	 ZfbjXlCA12vYD9xJpCdamnpsfk4x+GZUZKifwDa3lP/0NDlZJ7MWe4VTO2R/wjJizv
	 7AGNWShD0y+zA==
Date: Sun, 7 Jul 2024 14:05:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: BU27034 => BU27034ANUC
Message-ID: <20240707140536.1dbb989b@jic23-huawei>
In-Reply-To: <c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>
References: <cover.1720176341.git.mazziesaccount@gmail.com>
	<c39f9c67b3c07a27d7a13109c7b69cff9cfd2b9b.1720176341.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 13:54:12 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The BU27034NUC was cancelled before it entered mass production. It was
> replaced by a new variant BU27034ANUC (note, added 'A'). The new
> variant gained a few significant changes, like removal of the 3.rd data
> channel and dropping some of the gain settings. This means that, from
> software point of view these ICs are incompatible. Lux calculation based
> on the data from the sensors needs to be done differently, and on the
> BU27034ANUC the channel 3 data is missing. Also, the gain setting
> differencies matter.
> 
> Unfortunately, the identification register was not changed so there is no
> safe way for the software to distinguish the variants.
> 
> According to the ROHM HQ engineers, the old BU27034NUC should not be
> encountered in the wild. Hence it makes sense to remove the support for
> the old BU27034NUC and add support for the new BU27034ANUC. Change the
> compatible in order to not load the incompatible old driver for new sensor
> (or, if someone had the old sensor, the new driver for it).
> 
> Drop the compatible for old sensor which should not be in the wild and
> add a new compatible for the new model with accurate model suffix
> 'anuc'.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Rename indeed makes sense.  One minor, 'whilst you are here' comment inline.

> 
> ---
> A patch renaming the file according to the new compatible will follow.
> If renaming is not needed or appropriate, that patch can be dropped.
> 
> Revision history:
> v2: New patch
> ---
>  .../devicetree/bindings/iio/light/rohm,bu27034.yaml      | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> index 30a109a1bf3b..535bd18348ac 100644
> --- a/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/rohm,bu27034.yaml
> @@ -4,20 +4,19 @@
>  $id: http://devicetree.org/schemas/iio/light/rohm,bu27034.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: ROHM BU27034 ambient light sensor
> +title: ROHM BU27034ANUC ambient light sensor
>  
>  maintainers:
>    - Matti Vaittinen <mazziesaccount@gmail.com>
>  
>  description: |
> -  ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> +  ROHM BU27034ANUC is an ambient light sesnor with 2 channels and 2 photo diodes

 sensor

>    capable of detecting a very wide range of illuminance. Typical application
>    is adjusting LCD and backlight power of TVs and mobile phones.
> -  https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu27034nuc-e.pdf
>  
>  properties:
>    compatible:
> -    const: rohm,bu27034
> +    const: rohm,bu27034anuc
>  
>    reg:
>      maxItems: 1
> @@ -37,7 +36,7 @@ examples:
>        #size-cells = <0>;
>  
>        light-sensor@38 {
> -        compatible = "rohm,bu27034";
> +        compatible = "rohm,bu27034anuc";
>          reg = <0x38>;
>          vdd-supply = <&vdd>;
>        };


