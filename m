Return-Path: <linux-iio+bounces-9750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40D984318
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 12:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BAB286DFE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FA166F13;
	Tue, 24 Sep 2024 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqgDsw8Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9B13B780;
	Tue, 24 Sep 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172423; cv=none; b=m2IXwPWmkKTr7G8nKomoJMBdptF9G8/r5AICkY0Sputy21ssthEQAY+9vasLScSQqgp4Xf2pzUr6rSXm+Qpc/R/7IwSAQfx85vryLZEoFTjw6//QsZ1CWBqChe6+Ryy5eP37DSgK63xLAyKoVmFFbywAVG7bbdWvcTLm2LTLE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172423; c=relaxed/simple;
	bh=NNpPCDCmogO6p91duNeLKDWJxcotWnDmbCaTck59iZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDEt/6jHibVEb5NnU1Y74u5X3HdhLXwBUKnvcbuO5j+t9umOCATV8oE03PitC6Ee+9rSrbIbVGwRYvwczOrRpkK+LRZpimv5II7R9mBivs3OSTht1JCQ1WfybbAXz1+mf5/VYKatDdHYlVNPo8MTOCUPzkObVVaEyhTtx/rwtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqgDsw8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99722C4CEC4;
	Tue, 24 Sep 2024 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172423;
	bh=NNpPCDCmogO6p91duNeLKDWJxcotWnDmbCaTck59iZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uqgDsw8ZqWOGpuh418XARAbynPCGbqKqK3fsdDARIafYmZjr16YTCmoPrkn1MAW/m
	 gfRDYAk0KpNY/V50Rc6LAuGGRwQMYexiOQObC5C1EdcUgiHKbeZHT283FsUim2QNO7
	 puebPJBZqxvOEeZK7d4f1/8jNkcg5qI4vgHAR/a5ewoy7qIqQNd4vcw8aLZRQdpfPs
	 hVaDQIcpk62r+lUXazDJsvXoIO9SdFrASEHJYgN38fLuBedE0/Y5rsvVPo64j5o2t5
	 y51nAL+gkMW9qwcv9sqJQs2pquo2GX0BSsZXkqUZyFUtsGIBBpYypICJk69R4/LfX2
	 Fn0WDJdqheLEQ==
Date: Tue, 24 Sep 2024 12:06:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: iio: light: veml6030: add
 vdd-supply property
Message-ID: <s7ylc7uxh376hmessk3mnuxsmjpmgnvgnxbu7vxect3evqjsfp@ifou7lugbxae>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
 <20240923-veml6035-v2-4-58c72a0df31c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240923-veml6035-v2-4-58c72a0df31c@gmail.com>

On Mon, Sep 23, 2024 at 12:17:52AM +0200, Javier Carrasco wrote:
> Add vdd-supply to account for the sensor's power source.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


