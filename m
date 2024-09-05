Return-Path: <linux-iio+bounces-9159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF4696CF51
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABF52854D3
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14018950D;
	Thu,  5 Sep 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLTgGy20"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD41714A8;
	Thu,  5 Sep 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725517974; cv=none; b=H4gj7mFzG11HWRSQarMmWB5L6P1nZ85nDtLOy/igLO/j09Gr7BQHoCp1PeDfDCMpr8qb8kHFslQPq2Prln0+kEoBPvbqLjty/35IITgo0dS8KNvaPwljE+zDMdMUKnYQwRTZssH9v+US0y6iMcO0agWNXRdT9l2BWJhAS3X3g2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725517974; c=relaxed/simple;
	bh=R6prcIlRfo8GFBxwtUGN+FDnthZrRlPyg2w3vgABOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuK7YPM5bu64hku96SMMK+H0KwBxQEsSA0isY0k9QPsnRLBHqECWq7zgm5R5PDLPXUe9w2XU1fVylDP5NdUj75d26I5puh1WX4MnmV5G+XIwNoRBuktMuoxwSiLbEjp0pYhwYfG7rNkiRFagQQ/I9j2IREQqa8DyuZssJD8sAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLTgGy20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8720C4CEC4;
	Thu,  5 Sep 2024 06:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725517974;
	bh=R6prcIlRfo8GFBxwtUGN+FDnthZrRlPyg2w3vgABOxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLTgGy20KSu87n66SddEa0XFL6YrMVOcNss8SRkty/J6aMDN8TWJ0/qdfp9iMSdPk
	 lpPi2VQdjVTIUrn2ztQAb9FeOFEPc5bwlJz2XiyVc7WlF6ww9jM6Q0RPxM6WAiwduw
	 oq8kzRDo/h6Ni0mvIDZfAp/d+Ze1U9DOYCniL5dDbDUPI0ENV2H6B30pFSkBOoKNQ0
	 9uo5araILoDeGVm4PErk82EO3Gq78YavdzjuQGWyu3iasn8RHw26rfJmi7/9LPZTWa
	 Ff9VB5Myh/3ZknMzBBJ7HMkL7R0n8rLSvm+d0GoRp9cXwKYplUjEyya7j0LhWebrNX
	 dk3uleaaoUyVg==
Date: Thu, 5 Sep 2024 08:32:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianping.Shen@de.bosch.com
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dima.fedrau@gmail.com, marcelo.schmitt1@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian.Lorenz3@de.bosch.com, Ulrike.Frauendorf@de.bosch.com, Kai.Dolde@de.bosch.com
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: imu: smi240: add Bosch smi240
Message-ID: <6hfic3qxdus2x5d24yi2kfj6s6bqaxif6b65gb2nm6bsuge2gc@6nfnmnpj3dqf>
References: <20240904140506.4741-1-Jianping.Shen@de.bosch.com>
 <20240904140506.4741-2-Jianping.Shen@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904140506.4741-2-Jianping.Shen@de.bosch.com>

On Wed, Sep 04, 2024 at 04:05:05PM +0200, Jianping.Shen@de.bosch.com wrote:
> From: Shen Jianping <Jianping.Shen@de.bosch.com>
> 
> Add devicetree binding for Bosch imu smi240.
> The smi240 is a combined three axis angular rate and
> three axis acceleration sensor module.
> 
> * The smi240 requires VDD and VDDIO
> * Provides only spi interface.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Shen Jianping <Jianping.Shen@de.bosch.com>
> ---
>  .../bindings/iio/imu/bosch,smi240.yaml        | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,smi240.yaml
>

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run  and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


