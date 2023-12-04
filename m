Return-Path: <linux-iio+bounces-575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F58803471
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE077B20A99
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA024B41;
	Mon,  4 Dec 2023 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJs1P8Qd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E727D24B38;
	Mon,  4 Dec 2023 13:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1285BC433C7;
	Mon,  4 Dec 2023 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701696216;
	bh=ek3ANT87AWqPR1Eca9OZQtmPMVo5VRMPorN42gdYvgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AJs1P8QdLhwxhurk24vb8kK4mxKFCklvfs+/zuUF4DXHatRF3YJgx0ZchAXpYEjNz
	 EuYCkY2kQPoYoDmbMOCXxzsB3h2MRgnkvN9skNHMwLDqYL4bzfwsuVCzHjoZMQ4zta
	 Gpnmrng3JciT7HY/s8+FAbyCWCkdHjntdre9726t7QtijJAhMpJT0CFDm7cpUZdK1k
	 TSm+5+bdNA16U6UZg1cOFK1Hyx/AJ8hBjjVOEcHKwm2LpUrMaq+WyX1RSPvxMXfbmR
	 fAsAiZsnMZTh6OApYM0BtuNZvEhBjELSLRH/ow6Ia9x3ITVFvkjCDe2nBP6JugC9JY
	 GAlBSp6/x+qig==
Date: Mon, 4 Dec 2023 13:23:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio/adc: ti,palmas-gpadc: Drop incomplete
 example
Message-ID: <20231204132327.227588d8@jic23-huawei>
In-Reply-To: <87771c1f-17fd-4895-aafc-4fe0c38a59ee@linaro.org>
References: <20231128214803.3975542-1-robh@kernel.org>
	<87771c1f-17fd-4895-aafc-4fe0c38a59ee@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 09:30:23 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 28/11/2023 22:48, Rob Herring wrote:
> > The example for the TI Palmas ADC is incomplete as the binding is the
> > full PMIC, not just the sub-functions. It is preferred for MFD examples
> > to be complete in the top-level MFD device binding rather than piecemeal
> > in each sub-function binding.
> > 
> > This also fixes an undocumented (by schema) compatible warning for
> > '"ti,twl6035-pmic", "ti,palmas-pmic"'.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

