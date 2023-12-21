Return-Path: <linux-iio+bounces-1201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803E681BD2C
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362EF1F2641F
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A365627EC;
	Thu, 21 Dec 2023 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OztrvJuO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F62627EF;
	Thu, 21 Dec 2023 17:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C57C433C7;
	Thu, 21 Dec 2023 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179554;
	bh=cu1KI7LxIe3SAdnTvkuGj2NNJW5ryZHm+ypva87tuTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OztrvJuOuwDtWFcW/GrZanb2N+X6hGIjw8t7c8kxqN57xEFXffexCiZ1VTwsb6CPK
	 WJpr/fOsIObiIvW8A0uB8qO3u8kHdshfhgAYknP1p1AsqfW4Jk3UlzNfxeBXWBtbKW
	 jJRfAJmk7JzvGY+T/cofGMD6/cc2B6yAfL/a8OmRhNuRiKWB3j3YpQCZsVSsANmJLL
	 7R2Gtk+iP8cSZmyZa/2nTct7MxkcDv+JhZBCR9r2IzfQx1Pnn/0a1N3bmnMJD8ojFD
	 EQVeU5kiBAN5xFT/H4fhXWI3c6DfSLYxHj1J26K7gfaWZIdScV7hSsx9BVIUSFRRSl
	 HGPZxz58xaE3Q==
Date: Thu, 21 Dec 2023 17:25:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v4 2/8] dt-bindings: adc: axi-adc: deprecate
 'adi,adc-dev'
Message-ID: <20231221172538.6477b843@jic23-huawei>
In-Reply-To: <20231220-iio-backend-v4-2-998e9148b692@analog.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-2-998e9148b692@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:34:05 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> also remove it from being required.

With my 'specifications language' brain engaged (also know as pedantic)
I think this is a 'should' not a 'must' case. You aren't breaking
backwards compatibility just advising moving to the newer / better interface.


> 
> The reason why it's being deprecated is because the axi-adc CORE is now
> an IIO service provider hardware (IIO backends) for consumers to make use
> of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> of consumer referencing other nodes/devices) and that proved to be wrong
> and to not scale.
> 
> Now, IIO consumers of this hardware are expected to reference it using the
> io-backends property.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index 9996dd93f84b..835b40063343 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -39,12 +39,12 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        A reference to a the actual ADC to which this FPGA ADC interfaces to.
> +    deprecated: true
>  
>  required:
>    - compatible
>    - dmas
>    - reg
> -  - adi,adc-dev

Dropping it from required is fine, but do we have a new condition where one or the other
should be required?  If so good to add the dt-binding magic to enforce that. Look
for a oneOf combined with required. There are a few IIO examples of this either or
type required. You may want to then enforce that both are not provided though I
guess we perhaps don't care - the driver will just prioritise one approach over the other.

Jonathan


>  
>  additionalProperties: false
>  
> @@ -55,7 +55,5 @@ examples:
>          reg = <0x44a00000 0x10000>;
>          dmas = <&rx_dma 0>;
>          dma-names = "rx";
> -
> -        adi,adc-dev = <&spi_adc>;
>      };
>  ...
> 


