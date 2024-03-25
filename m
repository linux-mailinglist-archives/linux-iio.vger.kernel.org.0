Return-Path: <linux-iio+bounces-3799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC388B209
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 21:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9442E7F2D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602FC5B5DD;
	Mon, 25 Mar 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q467sobo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138775B5BB;
	Mon, 25 Mar 2024 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399752; cv=none; b=of1q5n2JmgYnUh5lhgAP7tBDK0xFW+8xU2DcX8dAyz4kY7ymlD5yl27Mmakd/kTz2F3+BfAnxovQJBJcFSdY9khWKXPmLe0vd6lDoC0/QO5mT3uIVEjjuCAtnR1U6NMuFXaKZ4yMG9PYh7j65NwGsE3a+jhdw/WVlG7xJtORoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399752; c=relaxed/simple;
	bh=2/tJjYaChwKoUIZNWSKrYXTYyR7FoNjhOyq9PrLA9l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKZevCdZy8c+inil5K+KMWHQkPj0xwVe8B2pbvi80FlpEe2QtbDd6TlXcMDE5bhtyVjvSXS9gYKNmJUNb0qLY34S8Chcn2IPigLWhvSybDA0OeHz8wgV2OfoL82qN2h61Ls5V+vCfObw8GGoChlwqiHxU5UrGRxIJmR/HHx34U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q467sobo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43E4C433C7;
	Mon, 25 Mar 2024 20:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711399751;
	bh=2/tJjYaChwKoUIZNWSKrYXTYyR7FoNjhOyq9PrLA9l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q467soboeijf6ZyXUjIBAhV3BL14+VRU5BLt37zHnsqwQINq0PcTKrQ5mDn9MDlkm
	 v/Nt/Ujogvs8RaD6LLmCM4/ExwSFEIMDYpJvHwv+uPgy1zOy/rLNb/ItHjBaCCMxwm
	 uzahUIrKmMNEzuXQtG5yMatPBlT4KzPdXaakaPyBE2mC1Y1FrbYg16Wg1SrpP3P9Rf
	 qpPDvPeYE0JMddd1zUn1BWLxCs1wFGJ6iIrNThBe1EIPWpaJ5bPy2+P87HzoQd846L
	 iSeaONv/aYd1UfZyf9JWNJDrn9R45zGDocVNWpqrCpeRjgQgtgcFfrdXnTkDus6FpR
	 v50uYLEmgvUKw==
Date: Mon, 25 Mar 2024 20:48:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Trevor Zaharichuk
 <trevor@au-zone.com>, Greg Lytle <greg@au-zone.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: iio: dac: ti,dac5571: Add DAC081C081
 support
Message-ID: <20240325204857.4f2fd468@jic23-huawei>
In-Reply-To: <20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
References: <20240325203245.31660-1-laurent.pinchart@ideasonboard.com>
	<20240325203245.31660-2-laurent.pinchart@ideasonboard.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 22:32:41 +0200
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> The DAC081C081 is a TI DAC whose software interface is compatible with
> the DAC5571. It is the 8-bit version of the DAC121C081, already
> supported by the DAC5571 bindings. Extends the bindings to support this
> chip.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Hi Laurent,

Given it's a part number where no one is going to guess it is compatible
with the DAC5571 and that we don't have a history of fallback compatibles
I'm fine with this change, but just wanted to ask is a fallback compatible
useful to you to run with older kernels?

I should have noticed when Peter added the dac121c081. If we add a fallback
should do that one as well.

Jonathan
> ---
>  Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> index 79da0323c327..e59db861e2eb 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
> @@ -21,6 +21,7 @@ properties:
>        - ti,dac5573
>        - ti,dac6573
>        - ti,dac7573
> +      - ti,dac081c081
>        - ti,dac121c081
>  
>    reg:


