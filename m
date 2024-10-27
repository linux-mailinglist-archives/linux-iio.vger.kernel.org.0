Return-Path: <linux-iio+bounces-11413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB169B20DF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 22:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C4AB20D8F
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002FF187862;
	Sun, 27 Oct 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smN7F/0f"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDC187555;
	Sun, 27 Oct 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730064384; cv=none; b=qCYoV7vKARcL+5jy63m59pkJF9Ha4MEHc9tVUPvNeZ4JezkBgbZMVclK1VebK75205vfpwFRr1iJfFV4fxo9eg319xump2Rp27p6Lr/+/YWOsqxQ/895xnRs9RYgl1+/0+mR8oM4I9kwIh6mWH/w6r61FGqtwZ/5FjcaMqVzsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730064384; c=relaxed/simple;
	bh=zfkUXd4isNcVsjRFd0CnnDdETx0R8EqpcbKc4Xx5sDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7sMY0cC15O2yZRvMm9EJFTwB4YpTT34csbrLqAlPuAZcVaBI3s9DWbew5IhhRVjvgMXnNkA39+aC+BSO2dLWz79q6rCGdIxvJcWF+pm6uncKWDASrHXRqs52YfYrAWM8BVYo/VMEtLb5fTpGpctNU1/SDcNEh8tLytwF93ILug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smN7F/0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4612C4CEC3;
	Sun, 27 Oct 2024 21:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730064384;
	bh=zfkUXd4isNcVsjRFd0CnnDdETx0R8EqpcbKc4Xx5sDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smN7F/0fp4bmbU2z7CLYFR35gy7dShJfflBcmx6emp3x4/biWfoD+5IjAOiz7mPE/
	 waSdwltTdZi1+zUHDYTF+ZyTky901y2ApQyhhm7CD41vJtuAmbWKzsmU8EStWChKHO
	 aciHLg8d5dDB4visRKr38k5frpPiW/8NID/aAGsCiL0mqi78bQwxuN8hdtRKCWfeee
	 GzdRNRKCETAZPz6iNS6AW9KXRPrkzpPP7YZ8jNAyBeDPQPOzyDoy9aBpmL2EZpWAVw
	 OiK47ebSZ7gLSsE9xwKXBTdwZXHRmU8yMWJma/WPhalEo2ZWtErHfr1kt7L8B8bhXf
	 POepQdRtc1+pw==
Date: Sun, 27 Oct 2024 16:26:22 -0500
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <20241027212622.GA101617-robh@kernel.org>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
 <20241024171703.201436-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024171703.201436-6-u.kleine-koenig@baylibre.com>

On Thu, Oct 24, 2024 at 07:17:03PM +0200, Uwe Kleine-König wrote:
> For the AD7124 chip the logical irq line (̅R̅D̅Y) is physically on the same
> pin as the spi MISO output (DOUT) and so reading a register might
> trigger an interrupt. For correct operation it's critical that the
> actual state of the pin can be read to judge if an interrupt event is a
> real one or just a spurious one triggered by toggling the line in its
> MISO mode.
> 
> Allow specification of an "interrupt-gpios" property instead of a plain
> interrupt. The semantic is that the GPIO's interrupt is to be used as
> event source and reading the GPIO can be used to differentiate between a
> real event and one triggered by MISO.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 35ed04350e28..feb3a41a148e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -37,6 +37,9 @@ properties:
>      description: IRQ line for the ADC
>      maxItems: 1
>  
> +  interrupt-gpios:

Name it for the pin/signal, not how you are going to use it: rdy-gpios

Rob


