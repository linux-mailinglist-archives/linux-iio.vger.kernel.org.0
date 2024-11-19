Return-Path: <linux-iio+bounces-12412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CCA9D2C18
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 18:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A9BB39C9F
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C01E1D0E20;
	Tue, 19 Nov 2024 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbe9filp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C811CCB4E;
	Tue, 19 Nov 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035527; cv=none; b=eqYZ/fhytj2RvNVOMfdYr0gkRuCOEIJuLFku8fEsKQ2cKcqkoVzLUYA+09r3OrrOymJZNmV01jTVWeGlIPM9+dvxIOu2w3zAR6Zv6DpExo+XOrYqrXLFKlgIeu6tiLx1tYi36MtsgNRjj4vBSeRRPcufIrN2vAf/tSybhw6uiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035527; c=relaxed/simple;
	bh=vFWgdRkDADLQpMytr2eTpWNcYRlAxEbkrpfccW/Sgts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHQNGesNetNOdSelfXfELPLa0J5aW7myIixwhewxVZRyfcRxKFfxKa7EhjfZs9Vv1X7ZbTykXMnWcJgWfx9pqSXXZs4AWvqDm3fnXYu6glhTILIDHoTp63p1wfLjQjy2c2oU02eSqmoMPR6pE2FkjTxFRMr1MZQKFNQZWfuLtfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbe9filp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93583C4CED1;
	Tue, 19 Nov 2024 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732035526;
	bh=vFWgdRkDADLQpMytr2eTpWNcYRlAxEbkrpfccW/Sgts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbe9filpvVUbQCcw415clh6wmHRZIvXYC8bo2fFuNv6WhFH+ZGNJWB0K+IgWn7/ZQ
	 V1fLEnKMWVtsTiNkjah5qoyLT3uId0w2/P7Vej8KXS1kmRYEKsEO49+XsxOWDHSHgm
	 x9RdUbgDMBwNO5W5lOdIXgQSXECKh6HP+CwdU/lkzjboojcRYpBewW7XIWCzh96tCj
	 YxSKXFCA17ff1mlw9mpOQtsJ7yCVKN/a+Y9tEgACwZx4S1+uOzqQaPnd2jfGq5gZ27
	 CYW9IjUojBnHZcYbKkzLDbbJ62Hc3ros+ekD8jjKOlUIj0Jddua+nO/XF1sWjtjHkp
	 xJqYM9Q5jhZvg==
Date: Tue, 19 Nov 2024 10:58:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-iio@vger.kernel.org, Han Xu <han.xu@nxp.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: accel: fxls8962af: add
 compatible string 'nxp,fxls8967af'
Message-ID: <173203552441.1804021.16439820699439366987.robh@kernel.org>
References: <20241115-fxls-v2-0-95f3df9228ed@nxp.com>
 <20241115-fxls-v2-1-95f3df9228ed@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-fxls-v2-1-95f3df9228ed@nxp.com>


On Fri, 15 Nov 2024 15:23:57 -0500, Frank Li wrote:
> From: Han Xu <han.xu@nxp.com>
> 
> Add 'nxp,fxls8967af' compatible for the FXLS8967AF sensor, falling back to
> 'nxp,fxls8962af' as the only difference is the ID.
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/iio/accel/nxp,fxls8962af.yaml        | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


