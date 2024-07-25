Return-Path: <linux-iio+bounces-7886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 273B093C33B
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A84B21920
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A6519B3D5;
	Thu, 25 Jul 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs4XhD/1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1924199386;
	Thu, 25 Jul 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915045; cv=none; b=Oxf8HSMd2Pj9Okmhm5V+QwgkGR+voGzGI/qbOf2lZuiYnuQN12M+tzTrYDPwK4MGIgEmjFroGKDJpriCSW/EARm34JTkWMYTkXZSSDI7tC7eGzqkPNsOSTjgRlNBEOql5OQuBqT5BXbgbMSPz42d89hpE/GYZBc9jcQ+g/1/fCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915045; c=relaxed/simple;
	bh=Qi2+dpUJbwuaM7ntbAYVCVncmwnq5qOnkpwH2Mt0img=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9pnEUpzgGtbDOki/wmB4SvZ+i5KlL0JJXLbgYjsGR7Vqz/DOn1pZ42FUhPFmlC287AD8aSkahSJSw68CM6XxqJf3u/jHr76j/yWCtgCDNZIi06mF5dZzbwjsXdA2U4BKOnAscyKXuDLIqX2trG1ZMdkjGvDVFpivdVRv0bq+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hs4XhD/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3946EC116B1;
	Thu, 25 Jul 2024 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721915045;
	bh=Qi2+dpUJbwuaM7ntbAYVCVncmwnq5qOnkpwH2Mt0img=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hs4XhD/1ZP0SwfMb0uLLdOajSaZzjC39xtGP8z10OW2VE2jsEu5oJaooMAlI6qvVN
	 2YbvL0j4zCyI/VDWbqNwxEnJ5F9aOylUGkxCLwfvV8RPGrNU5zROOlpGmgA9o90/bz
	 t99CPtJF/6uHso+xfLsmVEG+R6cG0llgIqQwrdo5hiS4N1z1/23fojXtlXUbnWjPtp
	 fmCHMH77Kz8r5Hshh+K5tUQu8AdXRTS3lZ0vTTq+mg8aWgOCA+UEuREc0w+kz63Qq0
	 kGKyMpiMVtcb7YKb2EbTf1TEgM1NRgpdtChwd/PbtDSLHLCYILdp+MYyWUG9LPCRa3
	 hrQGHhGstXBbg==
Date: Thu, 25 Jul 2024 08:44:03 -0500
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] dt-bindings: iio: add vref support to sd modulator
Message-ID: <20240725134403.GA1847316-robh@kernel.org>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
 <20240724153639.803263-7-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724153639.803263-7-olivier.moysan@foss.st.com>

On Wed, Jul 24, 2024 at 05:36:34PM +0200, Olivier Moysan wrote:
> Allow to specify the reference voltage used by the SD modulator.
> When the SD modulator is defined as an IIO backend, the reference
> voltage can be used to evaluate scaling information of the IIO device.
> The reference voltage is not used otherwise.

You haven't tested that this works. Add 'vref-supply' to the example.

> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/sigma-delta-modulator.yaml           | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> index b245971fecb0..ff04ae08f264 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -31,6 +31,14 @@ anyOf:
>    - required: ['#io-backend-cells']
>    - required: ['#io-channel-cells']
>  
> +if:
> +  required:
> +    - '#io-backend-cells'
> +then:
> +  properties:
> +    vref-supply:
> +      description: Phandle to the vref input analog reference voltage.
> +

Do this instead:

properties:
  vref-supply:
    ...

dependencies:
  vref-supply: [ '#io-backend-cells' ]

>  additionalProperties: false
>  
>  examples:
> -- 
> 2.25.1
> 

