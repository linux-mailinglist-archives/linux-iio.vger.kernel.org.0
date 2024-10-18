Return-Path: <linux-iio+bounces-10725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BC9A3F9E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 15:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBEE1F241E2
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E131D79B3;
	Fri, 18 Oct 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt5EGiMx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400D23D2;
	Fri, 18 Oct 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258187; cv=none; b=Sef9aC3VIC5788dURAobx9IkjExgK1/ge1geIi8exDcFW7W1nt5lCofK71fxMVnLd95yEFaBiBvPmtZXj8alwf7frqVohgUneXtk+6ziSdOaIqPvbuG4FC0BdCc1SG+g52MhDQl+S5i3bwdz3TQpY24LWO0/GJPwroG2lWjLgwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258187; c=relaxed/simple;
	bh=0sbHRBsjbGBA1Ac2oOqCpC5kRRswpuyAvkL1Df298O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCR21SvuGBVhJsfTAsKuhCgNlZ1i/WnxRmfG+Wo0p6mBPd2Kp5JVy+jwOck5EoVexPnMUDzrDumwDVNBj0TxYp+ZH+ZEMcR7nj6oNA/LV6xIrFaVioyUF6TN1AA8mZAqUZUuT+Jia7oi9dF4o9Mn273WRbmXv5TSfpPY16RwEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt5EGiMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7CEC4CEC3;
	Fri, 18 Oct 2024 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258186;
	bh=0sbHRBsjbGBA1Ac2oOqCpC5kRRswpuyAvkL1Df298O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xt5EGiMxdtTvBrlIYoC2Zt58IyLf2Rx5nM/TcPNJkLspAQmkTMtsuu1/JRcCX4jp/
	 96zjvhmdAqV/CBGu0jYU22mrd53EM5IHvRIQMCu2LanUzgItKEH+nhKaU6QszrfAwZ
	 noqVvK5qwy1pR/IflRl/NgVHbR0ZPGujjjbGrWMHmxTjPghZLjhPH0XMCNxZd69X8b
	 ZwU8bF2b2zObQ8sMAczUto/Dksz6ldzJe6G/cgY54m1EbvZgPfAT7NJzcb2toPHv6G
	 YyLVESYPYXxYEGxhHbi9cXZBsoXWaQ7tpybXTwBOI1QaZC+NO7damluju7Hcj018cr
	 otsx37Uof178w==
Date: Fri, 18 Oct 2024 08:29:45 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: iio: light: veml6075: document
 rset-kohms
Message-ID: <20241018132945.GA70244-robh@kernel.org>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
 <20241017-veml6070-integration-time-v1-3-3507d17d562a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-veml6070-integration-time-v1-3-3507d17d562a@gmail.com>

On Thu, Oct 17, 2024 at 11:39:27PM +0200, Javier Carrasco wrote:
> The veml6070 provides a configurable integration time by means of an
> extertnal resistor (Rset in the datasheet) with values between 75 and
> 1200 kohms.
> 
> Document rset-kohms to select the integration time.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6075.yaml   | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> index 96c1317541fa..3d3ffeaa22df 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -29,6 +29,22 @@ required:
>    - reg
>    - vdd-supply
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6070
> +    then:
> +      properties:
> +        rset-kohms:

Use the documented '-ohms' suffix.

Properties should be defined at the top-level and then restricted here.

> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: |
> +            Value in kilo Ohms of the Rset resistor used to select
> +            the integration time.
> +          minimum: 75
> +          maximum: 1200
> +
>  additionalProperties: false
>  
>  examples:
> 
> -- 
> 2.43.0
> 

