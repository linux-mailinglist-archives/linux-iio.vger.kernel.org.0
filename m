Return-Path: <linux-iio+bounces-20304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E9FAD0E93
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 18:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B46A188C8E7
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396741E98E3;
	Sat,  7 Jun 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbjyhX+m"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2D3234;
	Sat,  7 Jun 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749314012; cv=none; b=tFDiUdzY4/z4K00S2+qDX1CVwC3vbUwjgSbpxm5MkKV8R0JRhmcsTp17KaFrx7kQHJrRkLJf6j8BeCQ4l+wRNaECEciSI6GPpEtML7mqmR51FWxyUuAraEu4L6xYlFGlSuXUeF1xeCmz/7sM82x3h4KbsL+CGBeLAVuZA8RTqvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749314012; c=relaxed/simple;
	bh=ItlNIMhrEEQrBgbuPGB0ZnEfrVvrrPFCmx6bzFw4fcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7TMT9+otV9BwTEsYIEcJaOpnyQCkUc6wIgz7N7lsS2DdSzhvFEkYYnyf8K1p+fA3QdV4kqdftoYF+hpmt/XLnlOVSrmQussoHIZiARApl/0YT4SAvq0yOSH2xlCLipw+3OTQCvok73InqqXZHsyUuygZffQkr+s//schEuDfQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbjyhX+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C34C4CEE4;
	Sat,  7 Jun 2025 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749314011;
	bh=ItlNIMhrEEQrBgbuPGB0ZnEfrVvrrPFCmx6bzFw4fcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbjyhX+mq0xyAvfxkvjPmS1YtYDGJlFCjXWoNL6X6XwcoRj208tsnnpHOdWXnVS2J
	 YegLikoroSWZIf29rRH+lCfeCAYpoCCqRi1wjSrPISkdFTvbpxFryjQgpspDJwQbE5
	 L2dG55xorOm/KcFKImh+DaVUlOWWXsp5vGoKPv6QIw1kpp2KRwKStIhkva7QMWqBbQ
	 mfXCGampCtaSY35VzJasX4hHCj/BmmcfMxEkvPJZbxZFESYpMf8fIJPpDDIoRob9F5
	 D7ezTa94/o9pF0R96+LEz0mHxL57WVmfbo4JciCzTzo/Ziqn/qxrZ65cwlRCFjkChO
	 RPkhXdjmJkC3Q==
Date: Sat, 7 Jun 2025 17:33:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, nuno.sa@analog.com, andy@kernel.org,
 linus.walleij@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, brgl@bgdev.pl,
 dlechner@baylibre.com, lars@metafoo.de, krzk+dt@kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/11] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250607173320.46e88253@jic23-huawei>
In-Reply-To: <aD4PD4tBdbTFWNju@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<187e038cb9e7dbe3991149885cb0a4b30376660c.1748829860.git.marcelo.schmitt@analog.com>
	<174886697998.948762.16527380744873036141.robh@kernel.org>
	<aD4PD4tBdbTFWNju@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 17:52:31 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 06/02, Rob Herring (Arm) wrote:
> > 
> > On Mon, 02 Jun 2025 08:36:24 -0300, Marcelo Schmitt wrote:  
> > > Add device tree documentation for AD4170 and similar sigma-delta ADCs.
> > > The AD4170 is a 24-bit, multichannel, sigma-delta ADC.
> > > 
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>  
> >   
> ...
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad4170.yaml: properties:interrupt-names: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
> > 	hint: Scalar and array keywords cannot be mixed
> > 	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#  
> 
> Removing maxItems from under interrupt-names seems to solve the issue.

As per feedback on v3.  I don't think we should be limiting the max
of interrupt-names anyway.  We should allow two interrupts if they
are both wired - it's a driver choice on which one to use.

> 
> Thanks
> 


