Return-Path: <linux-iio+bounces-2192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE81E849C82
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 15:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA91F25537
	for <lists+linux-iio@lfdr.de>; Mon,  5 Feb 2024 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D422F11;
	Mon,  5 Feb 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geHs6myK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3572C183;
	Mon,  5 Feb 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141693; cv=none; b=rQ+xWdIcTolERYHoY/V4dxsRq0FdOxf5WZL8QFTSbKjHubU/L0qzgKwPC54d80GXp3EZgLC/Do/JftWiR+9QOnYbfD4yHg9WPdgavSFsExYeWD2IO1p12LbG+132G4obcEzQG3EwJ5/seyezOAwY0GCDhv6PIYIfSdqQO12kwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141693; c=relaxed/simple;
	bh=JXqQdhVAmct1Dp2vFiUOI3Ld+jvCSvxTnocdtl3EIhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OosF5adfpMexFyFvlzQRGLAQtaNr9z6Bxkd6lsgrbpk2GRmtDB6eLi0vkw8TgiHu0tPpvS8iZBuHBi2c6m8SkjXd4t8YdhJt1fMSTufoCcivnPPn902Fobx2tOvOlP+9cP3o1dN/wUWcvCRMcbmd5K9q+nEfNQFWz0jMI79FjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geHs6myK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BD0C433C7;
	Mon,  5 Feb 2024 14:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707141692;
	bh=JXqQdhVAmct1Dp2vFiUOI3Ld+jvCSvxTnocdtl3EIhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geHs6myKA+tV7VwlCTxRn5E402r/1+XypzSn3sxMv3Ttmltpp8TopvY487/LQPT1Z
	 wmVxAnIhKWmsS4uRgT7Zr3vpU/qJ787VWBgD8F8W3I/uw16Bx5lRsbqdegcP0J5RG3
	 UB0aaGKxV1T67Gthp2NXSZOrmIXjN33RXs4p6K5F2XhzhWKomFxT9HnOeKHQ14kgbw
	 eIaC5kervZtkQU0sQCooj+twVGfzoTXmyFUmZ4iWA1wDFyfEvFkkJArxmj/HGoH3H5
	 GU9hKhzLWJh9jVtXczzqn57BE8mqgProeiLMAgLWIW1RUFmKDzrg+GV8oWwIu4BpdU
	 6N0/qvn7Kqc9Q==
Date: Mon, 5 Feb 2024 14:01:28 +0000
From: Rob Herring <robh@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: jic23@kernel.org, lorenzo.bianconi@redhat.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: imu: st_lsm6dsx: add
 asm330lhhxg1
Message-ID: <170714168769.3273951.16124017499544303407.robh@kernel.org>
References: <cover.1706961432.git.lorenzo@kernel.org>
 <942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942452ec9626bc1166501cec0fa88c369e28ec6f.1706961432.git.lorenzo@kernel.org>


On Sat, 03 Feb 2024 13:01:38 +0100, Lorenzo Bianconi wrote:
> Add device bindings for asm330lhhxg1 IMU sensor.
> The lsm6dsr supports the features and functionality provided by
> the asm330lhhxg1 via identical interfaces and so is a suitable
> fallback compatible.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


