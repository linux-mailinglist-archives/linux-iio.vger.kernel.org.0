Return-Path: <linux-iio+bounces-5944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC118FF60F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 22:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5923CB2358D
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8612AAE2;
	Thu,  6 Jun 2024 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISkKSuK7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BA4762C1;
	Thu,  6 Jun 2024 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706966; cv=none; b=RXlKIFlFCh4lpTIywlvVv6iU6IOkPiIOSm8LDdHDXN8Bbxsfco4ux9vxq/bUhm0Sxt9StLeE6hw6bMFTFk7sSEvaAnwY+9CEbfMF5ZEc+4o5ZiwN3T8OmxE4iwnahuVRMMO1D5KeAop5hfdc9srtBTGyXqLsAlEh95qgDzXvDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706966; c=relaxed/simple;
	bh=RFULZ5kbXH4pWawUttHhrKUEKFuQo39Nf1voIsadOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/7EEDw/CF1Tu/R2OlUFcU8GBGenDbsMfjw6LFdLLxthCw5ioZPO3tyJBZp7aR7Erc+HWrhWpQxIepc3KjbxRgv4/lbgiQbkT24GCxFzIkfP/ZkHf40kFKG2rCidrWXrHNq8WiEPw589dJBVgRsKOejnmrnFWgUc3IGnXlWoSZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISkKSuK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4C0C2BD10;
	Thu,  6 Jun 2024 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717706965;
	bh=RFULZ5kbXH4pWawUttHhrKUEKFuQo39Nf1voIsadOqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISkKSuK775Ho1duwSP2qy7qNLwQJ7SYPjq/g85auOFDGYODQ1A3wLJPL9L567XWAb
	 ba5Ww+cahVYZo8Tc16v+jDSShKDU4z9XLNN8pn3YPlE79jiXJBU2JTbPM3iOOYD3IR
	 Y/T5IAfbsON7g97nFuJxR5nJc3+EyLiFdHOhLAwuUFoznEktNai4jPXikKDlHA/Uc/
	 kyO31Yd3jIH7P7IiYA5qjqggiXX1OtLBhmMXchU8wNxdqJDuobgK5aSrVqAvmksxpn
	 0Q+oVREbxR5IiJRvS6DrI/Dy+VVxpDxQafv8w+4IJc3MCgqbIYxe6JG0gS4Pm8fK3w
	 KJRcINW6U5X0g==
Date: Thu, 6 Jun 2024 14:49:24 -0600
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add ti,ads1119
Message-ID: <20240606204924.GA3830246-robh@kernel.org>
References: <20240606163529.87528-1-francesco@dolcini.it>
 <20240606163529.87528-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240606163529.87528-2-francesco@dolcini.it>

On Thu, Jun 06, 2024 at 06:35:28PM +0200, Francesco Dolcini wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
> with I2C interface.
> 
> Datasheet: https://www.ti.com/lit/gpn/ads1119
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - add diff-channels and single-channel

Running the checks gives this error:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml: single-channel: missing type definition

