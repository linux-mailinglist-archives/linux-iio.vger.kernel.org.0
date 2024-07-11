Return-Path: <linux-iio+bounces-7510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494E992F0D3
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8D2B22FD1
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46860155741;
	Thu, 11 Jul 2024 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/5R5FjF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FBDF43;
	Thu, 11 Jul 2024 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732562; cv=none; b=Z3+7r4yVMbUrll/H/UTYwAjpVUcIbSxmmdHTQqpVmE4djlVci4D3LAL0UA2qJjbp80761fdvyPT1KDHF/rjOZC7z3o6L4HbkudSAOr3K592U94Itsxlio5sPPoaPXzFvT0wg6miftd0HlZkVzeOvtQiBxPInbFwVmhVDcP+3n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732562; c=relaxed/simple;
	bh=dudi4sdtVeovT/K8wDx3sBrqYXG8ImoAnYu5rdEU5aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGgl9Lolal1EDewtBJ+swmBWWuiYuzQlx4FWZI2r+kYWgW69jSRgzjekaXqFu9VEShoSBojZ7feBFJMbuNHouBcSjalGLzAibN+FDtFmXm59BcgjDolYShgzHqHn8KNLGRop1NxwSiCV7AqVUHA8/YhM+E2p5QFl4r5vdXhgswI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/5R5FjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEA3C116B1;
	Thu, 11 Jul 2024 21:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720732561;
	bh=dudi4sdtVeovT/K8wDx3sBrqYXG8ImoAnYu5rdEU5aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K/5R5FjFU5bNGAXmSMR6Cgc9CUG6P93dVt1nsNU+RAvPdPhGZtN+JJPsl9TdWv6hQ
	 9ZDqRufcnwroc2w1uT3NrkG+ETdMfHwtPTesbG4ppM1u/nP05BA9XOO+O9sdDNX+/N
	 7SskSd7RpKTnizdMPDC5/kovJq/jwI1KYkPQldUDcAMpxawy7bNir6hu0TtQ6O3RWV
	 ftXHB1s9FQL6i9Q6wdgX3AKUkK1yskGlu9yT2qDNkal2mP0eIEDw3noY5tsABKObej
	 /d4pVmxU3dqar2sL9Fl6WKWaiJOuIQmnlDlR1LP/QHiWB0jsdBHY7+jtXxBRX/9ykP
	 Cp2iMA7O0vBMw==
Date: Thu, 11 Jul 2024 15:16:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: humidity: add ENS21x sensor
 family
Message-ID: <172073255962.3023307.17444377298694934166.robh@kernel.org>
References: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
 <20240710-ens21x-v3-1-4e3fbcf2a7fb@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-ens21x-v3-1-4e3fbcf2a7fb@thegoodpenguin.co.uk>


On Wed, 10 Jul 2024 14:24:04 +0100, Joshua Felmeden wrote:
> Add device tree documentation for ENS21x family of temperature and
> humidity sensors
> 
> Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
> ---
>  .../bindings/iio/humidity/sciosense,ens21x.yaml    | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


