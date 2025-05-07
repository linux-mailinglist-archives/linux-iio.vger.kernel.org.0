Return-Path: <linux-iio+bounces-19254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36279AAEADC
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85849C8215
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B8728DF21;
	Wed,  7 May 2025 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n57AGIS3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3E28DB4B;
	Wed,  7 May 2025 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644439; cv=none; b=RNNyVf9+lzItBLe80LbAB+xBFe52IFGnC7TB/i9+rC8VdoDQ9lbXRN+0LI/LvCYe2b5YUKwP18GhVRoH2K3sc461H0dgaKGjG+kZUFWxLPA1W/qTCZDowO/95Txr6/OxRplod/wwEzyBbHVYT+SVcVVXKytCNYEi9li1Au1cYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644439; c=relaxed/simple;
	bh=s1L2tMHQisK0SllhSSdlvmk+QQ18DHmsa3NmqAmeRKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4cZ3TCZBiSgAaD0J3X4Iaca7R7m4BiQbftM+GBd33qqHzxxm8i9Y8qkJA2L3Y1+GFnX1ywpY3lZJ2NTe2tQmq+Bb/BwTFPvLv7UW3QSFZ8bCGPwYKfijJABczyWP602cHxXwFjlhNn7LyoDpmeWupMQs7b6A5vci1B0t57DymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n57AGIS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59939C4CEE2;
	Wed,  7 May 2025 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746644438;
	bh=s1L2tMHQisK0SllhSSdlvmk+QQ18DHmsa3NmqAmeRKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n57AGIS3kxuf5WLo8nWDSBPtQwJwPB5p037Rz0IWO22xLx/79xWb6QA0MmafIsW9U
	 R92XlUHmYHp0etCEV5kwIyYsWVC3JsZ0Jq06oxcW7CoIDx3jfewqNIzv7vQVfwdQK3
	 zdFee2IR9eZ2GA0UU3Qi11k1yR0IZx9wdBZKqAe+AXfwTvYXL3rt9zQRh1QCgV+0UU
	 lQYPSIx7gg+69mNBLAthJsjKHLrCSGyAGco3uUh9TeBBpsGoP3/mZVYLgg7nhfn1OX
	 iSMzGCvyKli9vhNYgdP+q8Kd+s3UEMCmSF20vaLgYyO8z+HGQZfKLZr16ayGC76PId
	 rARXXSJrHkYNg==
Date: Wed, 7 May 2025 14:00:36 -0500
From: Rob Herring <robh@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: light: apds9160: add missing type
 definition
Message-ID: <20250507190036.GA2210433-robh@kernel.org>
References: <20250507135147.1328639-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507135147.1328639-1-dario.binacchi@amarulasolutions.com>

On Wed, May 07, 2025 at 03:51:38PM +0200, Dario Binacchi wrote:
> Fix the following warning:
> 
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml: ps-cancellation-current-picoamp: missing type definition
> 
> raised by command:
> 
>  make dt_binding_check  DT_SCHEMA_FILES=fsl.yaml
> 
> Fixes: be464661e7532 ("dt-bindings: iio: light: Add APDS9160 binding")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml | 1 +
>  1 file changed, 1 insertion(+)

Not needed. Fixed in the latest dtschema.

Rob

