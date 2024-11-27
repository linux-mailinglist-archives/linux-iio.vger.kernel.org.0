Return-Path: <linux-iio+bounces-12726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4A9DA461
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A26B25A00
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA5619004A;
	Wed, 27 Nov 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZEMJQ0o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61051272A6;
	Wed, 27 Nov 2024 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698156; cv=none; b=i8VIfC60yucgW+1yOGLpKXQ8Wp4dgbZtVAjGg4WJTg99JMuyzfLnKprs6Lr+xwVnGl/BH+wad0CS+AofHGJpo8qFq+xyRTTXFsE+mdCXnDWc5n5FMJ56fNshG6jAVmc0JDgnf4LDUVVieSH4u1ARsgGboQp2KXk3SOS2qfBDq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698156; c=relaxed/simple;
	bh=zI3tcTtmLsGEF/ZYpgvlGONdju5QRp4hq4ERcnhankE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv8QewJSazD17dmLLpNu9/vUtaAI1p5SuvcpzvYUw3e7L7wLqrX3XQPKQpylOlIbYENjD4PqVT+2WxHHdlNTkq3Xgg/FBqSzMBwRJJRVGLBZI4EKkefxvakZrkVELvRU63TVArtO5utxC0kTZsE8/gfcLN1CNz+/8YIo+eG0FoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZEMJQ0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87425C4CECC;
	Wed, 27 Nov 2024 09:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732698154;
	bh=zI3tcTtmLsGEF/ZYpgvlGONdju5QRp4hq4ERcnhankE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZEMJQ0ooWC+ju1FTjm99P/wWkSlZbFL+CKudDblrQ4YMnz8s/+DjUNUNaMWOY+IB
	 d6ZPpgEtHYYelYHZh+Z6DfcrIObxTygcsUoohvWgA2ogjnhIhQXamO0e0p3HghaLXF
	 EKpgPMnqPB/mNyn3+MFJEW8hLUDYOvglpjGz5d5ftws7Npfn5pWfYfrqqpGmho2UUS
	 rP3rkZKQLMoewoIwKGh9IDurYe0APfIVeXgcPiXZhB2qq7gHbQnkr69gXuwa4cD/BH
	 o1r0G2mvNbWb0NvMfDY7IQ1ENVQ8hDsdbn1XMmyBzu1VMeVpP7puwWWo4NIRke34ET
	 pMf4l99Bd8t5A==
Date: Wed, 27 Nov 2024 10:02:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Message-ID: <dldrwflupel5j7jycxpcgml5is54xzdnu5gecwyuqydwak5sw3@j7ikkvs7erzo>
References: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
 <20241126-veml6031x00-v1-1-4affa62bfefd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241126-veml6031x00-v1-1-4affa62bfefd@gmail.com>

On Tue, Nov 26, 2024 at 10:51:54PM +0100, Javier Carrasco wrote:
> These ambient light sensors share their properties with the ones
> from the same manufacturer that are supported by this bindings.
> 
> Note that only two datasheets are provided as every one of them covers
> two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../bindings/iio/light/vishay,veml6030.yaml        | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> index 4ea69f1fdd63..e01e8747e47c 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> @@ -4,7 +4,9 @@
>  $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


