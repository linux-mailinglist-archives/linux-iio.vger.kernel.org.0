Return-Path: <linux-iio+bounces-11336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCB9B17FC
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 14:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE4C1F21ECA
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB51D54C1;
	Sat, 26 Oct 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe/0w62J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520AE1CEABB;
	Sat, 26 Oct 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729945422; cv=none; b=WjewhlstrVrQx7PhFxK4uE18+Ss/fNLLdYmEDtVsrgMnBXYf79SHssNbHTMTBPzguZeZFVYRBjTsMgIVVYHIgyDXoPQHFAVTUzvqngXljuMXDecZ4ZphFoqeATdy/H0uCvQK6VvJ1puMsH+ovW8Qf/h8aSX8rfj3QxsTlqhXwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729945422; c=relaxed/simple;
	bh=7xIivhA1EXxgO1w5r3JW6hnItDJPqu0yDX6zXM57fqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD39rFx3pnw4IDZaOG3jOrWl9rhA7r7JHBWSvLi7dMwInG9y3+YL6o0HDBmyF1X2PdLES9XGT/mVbv2eWjNn2pni+RZOa3tbxNQuzOVsSXeIKBtP4L4+wMwN90rVlYctIuAun8gAzGGDKpejTegElIc6jg61puntvmWE21AlRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe/0w62J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD70AC4CEC6;
	Sat, 26 Oct 2024 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729945421;
	bh=7xIivhA1EXxgO1w5r3JW6hnItDJPqu0yDX6zXM57fqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oe/0w62J1Y5g5F5kDrn728Ij5+DYGbbqEXHIxoBecYUB1+KLqUPEW+s/lroul8odm
	 Gtkbo1OcvJ+WygaZE0LtWLinNvxUI6PcHF1wHMVnlKDc72BkXr8mZJRfR5khJjaGX3
	 4vnEWGR4S7Cg45og2naqlPi5Cl0TuAuz3FR7CDQQdJ+yvdG1J0UoictLIkwsHKKS8a
	 HLHtrV5OFlfhmiPqxBcR4LTSC02i8TNxyL1hEu/7pPHcU8jyn+P36woAxP2lKp7KOm
	 pSyyVV4tTK33tk5xCVZ9R3iO0mVeUfVLjnRKSpmpH0LMXmnVdFAwEdXDqIO5Htxh3E
	 7jkW+4S4s9VMQ==
Date: Sat, 26 Oct 2024 14:23:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: veml6075: document
 rset-ohms
Message-ID: <sn66fvaqxohambw6aijimjek2cjshg2g75oh7baa2yhc4w2yh7@ox7bzsmdbpzk>
References: <20241024-veml6070-integration-time-v2-0-d53272ec0feb@gmail.com>
 <20241024-veml6070-integration-time-v2-1-d53272ec0feb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024-veml6070-integration-time-v2-1-d53272ec0feb@gmail.com>

On Thu, Oct 24, 2024 at 10:44:48PM +0200, Javier Carrasco wrote:
> The veml6070 provides a configurable integration time by means of an
> external resistor (Rset in the datasheet) with values between 75 and
> 1200 kohms.
> 
> Document rset-ohms to select the integration time.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../bindings/iio/light/vishay,veml6075.yaml        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> index 96c1317541fa..dfd64c411658 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
> @@ -22,6 +22,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  rset-ohms:
> +    description:
> +      Resistor used to select the integration time.

Widest constraints should go here. If only one device supports them,
then it even simplifies the if:then.

> +
>    vdd-supply: true
>  
>  required:
> @@ -29,6 +33,29 @@ required:
>    - reg
>    - vdd-supply
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6040
> +            - vishay,veml6075
> +    then:
> +      properties:
> +        rset-ohms: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - vishay,veml6070
> +    then:
> +      properties:
> +        rset-ohms:
> +          default: 270000
> +          minimum: 75000
> +          maximum: 1200000

Move these three to top-level and then you can drop this if:.

Best regards,
Krzysztof


