Return-Path: <linux-iio+bounces-24480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAB2BA54D8
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 00:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5909A17490D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC329A307;
	Fri, 26 Sep 2025 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3WbqDKP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283D1D6187;
	Fri, 26 Sep 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924622; cv=none; b=qpxzLyShQiL+rOMu0g9VXKkTG5xgESDh6moPGCZImcWc5jJwzdMu5T7o28X7dWV0fRVw9UtnnWLOR2bzF0HL/s1JucAKcehLlan5RpReR8ZM8a/ONH9xKbmVAFvYnZj/UHTgKj7DhyMGCv7Fi9IWkNaSRep8XamDhksKPqM1EcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924622; c=relaxed/simple;
	bh=5k5GZfdKV636YzsUk/ZKQso2EF0o1VhSCWjjXGLdNd8=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=om6K9Iil56EbMU13q5pOl55b05syf5UtpnFZO64fDSy+w7bq7tlKBJrqERmb+p6jlhPOD9C+veHgosaUHIFch8dlA4T/qulQhjJ1bXeQMAkFUO/SvI/a3/lVfIogM5+ZmBencVIx5GXlIcwajTX+uwsO3k/GEg+Zvfmb+kUVzek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3WbqDKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA93C4CEF4;
	Fri, 26 Sep 2025 22:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758924622;
	bh=5k5GZfdKV636YzsUk/ZKQso2EF0o1VhSCWjjXGLdNd8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=a3WbqDKPdhJf1QoUkTz+56eW3S1Bba9SDnT7JxlSE+Gn6GaaB/T/BubJbSug+kCc9
	 IZow7S6JkAguxSSxdO6qjwFTKzPcYZ/JzVw09iGGMYpAKriDuTHwT+RW772vbZKUp5
	 J6ab+VpkbXKFj2+6qffQEq0Cg1i/L/D3Rvq5ap8+rwkHNSZqc5hmcavk6qGhuQ6kUB
	 uDBj5h1wUG0aCEYi0qMV8sGATFDA/yhs0EhIE+nAAj8hWOSHExprMuMGt9F6XLuey5
	 ZjlObPt13DDN3hPVT4IGJlQuhQ4TKjOONyK27mhbZIvwfnI456H09vWZP1ik/9w4eP
	 66AgRriMNkNvw==
Date: Fri, 26 Sep 2025 17:10:21 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, jic23@kernel.org, conor+dt@kernel.org, 
 corbet@lwn.net, eblanc@baylibre.com, devicetree@vger.kernel.org, 
 nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org, 
 michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
 marcelo.schmitt1@gmail.com, linux-doc@vger.kernel.org, 
 linux-spi@vger.kernel.org, dlechner@baylibre.com
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
In-Reply-To: <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
 <5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com>
Message-Id: <175892462162.1836299.14644550889187111452.robh@kernel.org>
Subject: Re: [PATCH v3 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224


On Fri, 26 Sep 2025 17:40:47 -0300, Marcelo Schmitt wrote:
> ADAQ4216 and ADAQ4224 are similar to AD4030 except that ADAQ devices have a
> PGA (programmable gain amplifier) that scales the input signal prior to it
> reaching the ADC inputs. The PGA is controlled through a couple of pins (A0
> and A1) that set one of four possible signal gain configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3
> - PGA gain now described in decibels.
> 
> The PGA gain is not going to fit well as a channel property because it may
> affect more than one channel as in AD7191.
> https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
> 
> I consulted a very trustworthy source [1, 2] and learned that describing signal
> gains in decibels is a common practice. I now think it would be ideal to describe
> these PGA and PGA-like gains with properties in decibel units and this patch
> is an attempt of doing so. The only problem with this approach is that we end up
> with negative values when the gain is lower than 1 (the signal is attenuated)
> and device tree specification doesn't support signed integer types. As the
> docs being proposed fail dt_binding_check, I guess I have to nack the patch myself.
> Any chance of dt specification eventually support signed integers?
> Any suggestions appreciated.
> 
> [1] https://en.wikipedia.org/wiki/Decibel
> [2] https://en.wikipedia.org/wiki/Gain_(electronics)
> 
> Thanks,
> Marcelo
> 
>  .../bindings/iio/adc/adi,ad4030.yaml          | 84 +++++++++++++++++--
>  1 file changed, 79 insertions(+), 5 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/adc/adi,ad4030.example.dts:68.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/iio/adc/adi,ad4030.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1527: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/5dc08b622dac1db561f26034c93910ccff75e965.1758916484.git.marcelo.schmitt@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


