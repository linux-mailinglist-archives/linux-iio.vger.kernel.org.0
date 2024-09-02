Return-Path: <linux-iio+bounces-8993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A89686C3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7291D1F22EDC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EB1D6DDB;
	Mon,  2 Sep 2024 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjZtWnsO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037817F394;
	Mon,  2 Sep 2024 11:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278076; cv=none; b=VuzjTi2MUgAAJ/M5Dz4Ri6sKq/Y/ZJT4Rz6blYorTtTxm54NbL2je2fr2weQHZE/wxdaZ6ou8o6XJ4WVJNDbiZq1uM/RPSQK0ZZxe/SUsSxPNLdnjaOUgCoc5BnId/mRSavYfYe7h8YxOr5x98TFZZnYBAB2I4cHjk+PLVIWyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278076; c=relaxed/simple;
	bh=Qoy6TXYrDxb7VDyVoMvrB2KIvBuOAimyxOxwy2B2xwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOdJGOAF2ZlotYxCSMKLaFENMt/sSOSskpqmlEOmtBXnm34IJExjER74CnUxF/1RKA8oOxf6JYKtQQbyqTRw9X0X7QjC6Q0S/usvHk4EgVUHLONPu3tfBK9hyx/p06zlaiJB/UhDYyHRN2ZYsP5WvzItIiezkGFOTYEjQzQrZpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjZtWnsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4A5C4CEC2;
	Mon,  2 Sep 2024 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725278076;
	bh=Qoy6TXYrDxb7VDyVoMvrB2KIvBuOAimyxOxwy2B2xwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjZtWnsOxeRzyuI7Z4qmPAKCdx1AvBKFI2lSofSFykDSP2ZMddVNl1yGd8dQZ/4Us
	 fvzb+3z8YINo3shAunu7qYN8vY3e9m2TJAiW2zNYY3V3pKs+AlUxWxtBMhL+O2DYsh
	 BpPLh+tkTCHB2Sl0UU8/ENIg6Owa3587xsqSGDSRg21Tm+A4TQVFGeX6OjB2akqJRl
	 LyE75B6FBGBpc8H1zssczwP/eGRETY1oMkmyq/KjykAgyPcJJf4ZfzLZxjJ/Az7hG/
	 Zcvhza5hyL7Qq7zpdy+vNYQXMijvD0Fovvva4neFklk6lMbCGngHwickdK6alRoCgt
	 o5NBYK47YP8Dw==
Date: Mon, 2 Sep 2024 13:54:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v2 6/8] dt-bindings: iio: adc: document diff-channels
 corner case for some ADCs
Message-ID: <pu536g76q5xanhwnvhpr52mttonb4gkmxfwwof4fyo4sww2g3l@6s7x3joiuzfa>
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-7-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902103638.686039-7-aardelean@baylibre.com>

On Mon, Sep 02, 2024 at 01:36:29PM +0300, Alexandru Ardelean wrote:
> Some ADCs have channels with negative and positive inputs, which can be
> used to measure differential voltage levels. These inputs/pins are
> dedicated (to the given channel) and cannot be muxed as with other ADCs.
> 
> For those types of setups, the 'diff-channels' property can be specified to
> be used with the channel number (or reg property) for both negative and
> positive inputs/pins.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 8e7835cf36fd..9b7a8e149639 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -37,6 +37,10 @@ properties:
>        to both the positive and negative inputs of a differential ADC.
>        The first value specifies the positive input pin, the second
>        specifies the negative input pin.
> +      There are also some ADCs, where the differential channel has dedicated
> +      positive and negative inputs which can be used to measure differential
> +      voltage levels. For those setups, this property can be configured with
> +      the the 'reg' property (i.e. diff-channels = <reg reg>).

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run  and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


