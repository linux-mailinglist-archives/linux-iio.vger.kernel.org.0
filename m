Return-Path: <linux-iio+bounces-20072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD308AC9B9E
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89EB3BF9A3
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C301537C8;
	Sat, 31 May 2025 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb2T6rnb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F2DF42;
	Sat, 31 May 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748707498; cv=none; b=acNzAqh96T3fA/juWqrfWC0noaypLd1LVjD0FiNT/C3lVHvZw84WsZH7HTYXHmLd9atXgQ5a2xIL+Wn+zMJnvkTCSaaSGhF8V5Xx1GF/KxXkmaJReDT/p25+9OpdcVXMhaFDIUV8eyJzjk+yzYpwu4EeKizVJSNGpYcnbCxeB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748707498; c=relaxed/simple;
	bh=QwnqlQc8eO59QC1iazn3MfJicRUUxiL9Sp8eFgFfSYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjQfSp50L2bCRrrk9RQZQt9cN0VSJN2rKIxDUGxmUIxtxKRy0xMaiDAc/ce7J3CzD+yNir7fxIDAUqU1PM8jFcUNzMbHw/7L6FPbw0l2HF8CPN8sxXQ3ARgl18d2+WFKi1XkuH94uWXDHLpW4MHXlKYi+JfIZVtVU83eHgYnFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb2T6rnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52BFC4CEE3;
	Sat, 31 May 2025 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748707497;
	bh=QwnqlQc8eO59QC1iazn3MfJicRUUxiL9Sp8eFgFfSYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bb2T6rnbeL11klfDAZkf76s7ljB1hTCcQ9j3PkpMyAug+lI/60Lmy8ihrTP6Z6gqL
	 crMZxzP/pl/9PARi3sQwkrF7KKxxkI2GLt9t/+zP5qkm22//tyHvGYeI8LqkA8Aahl
	 jq5+DlrDPZ2FfOZkJ7nMe7quG78IA37maZajH09xDuPWY8hvV/hFGGvZgurFdDjyXo
	 e9sQqvQA/zIUSfnbe2wcmX+k9/aaHMoe8HAYbhtxKRY10jHMR60Rl29EFkhoS349nA
	 cOT9nYWhNEFEyPzoiNB85RN7/63uC3SK6vPmDz2hvT/2K2hIy4Pq6haf1ZpUK0WxMr
	 oe+jSCxMtipOg==
Date: Sat, 31 May 2025 17:04:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7606: fix dt_schema
 validation warning
Message-ID: <20250531170448.2be25330@jic23-huawei>
In-Reply-To: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
References: <20250526-wip-bl-ad7606-dtschema-fixes-v2-1-9bd56d039489@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 15:19:08 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix following dt_schema warning when offload is used:
> 
>   DTC [C] arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb
> /home/angelo/dev-baylibre/linux-iio/arch/arm/boot/dts/xilinx/zynq-zed-adv7511-ad7606.dtb: adc@0: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'io-backends' is a required property
> 	from schema $id: http://devicetree.org/schemas/iio/adc/adi,ad7606.yaml#
> 
> There isn't any reason that we couldn't have interrupts wired up at the
> same time we are using io-backends or SPI offload, so dropping off the
> related "oneOf" block entirely.
> 
> Fixes: ccf8c3f106a2 ("dt-bindings: iio: adc: adi,ad7606: add SPI offload properties")
That ID seems to be wrong.   Probably down to the messy rebase I had to do pre pull
request.  Fixed up to be 81fe5529e812

Applied to the fixes-togreg-for-6.16 branch that will become fixes-togreg after rc1
is available to rebase on.

Thanks,

Jonathan

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Fix dt_schema validation warning.
> 
> Link: https://lore.kernel.org/linux-iio/20250408-wip-bl-ad3552r-fixes-v4-0-b33c0264bd78@baylibre.com
> ---
> Changes in v2:
> - Change removing the related oneOf block. 
> - Link to v1: https://lore.kernel.org/r/20250523-wip-bl-ad7606-dtschema-fixes-v1-1-d9147fb2a199@baylibre.com
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> index 29f12d650442b8ff2eb455306ce59a0e87867ddd..1a5209139e1338f803c66ad2b4d63ad53cc11d96 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
> @@ -223,12 +223,6 @@ allOf:
>        - required:
>            - pwms
>  
> -  - oneOf:
> -      - required:
> -          - interrupts
> -      - required:
> -          - io-backends
> -
>    - if:
>        properties:
>          compatible:
> 
> ---
> base-commit: 3964c6e5877f054497ffccc7d00f8f7add307d0d
> change-id: 20250523-wip-bl-ad7606-dtschema-fixes-5e6ab342e043
> 
> Best regards,


