Return-Path: <linux-iio+bounces-8066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A11D941990
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940B3B2B813
	for <lists+linux-iio@lfdr.de>; Tue, 30 Jul 2024 16:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD51A619A;
	Tue, 30 Jul 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbYm0LQq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A31A6161;
	Tue, 30 Jul 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356707; cv=none; b=TsHsaLjAZRvZKeWsUAAe4hB6H4iDEuZiLIPu+IyTKqg90vC+Wq1DxY3RkwmmgZWgL0tWXnwYcg/RGXrSEw8Hk/p5MJqr8M0RdL7TqYyBu+nlrmfKYD//0ylW5DJJZ15RZnc+LMA4SE7PwRI4JjRg6cK2T68o47TeXrJBIIYmUBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356707; c=relaxed/simple;
	bh=VbCyqmc1UmLWidPvbHAC5GqzsjxRL2iBn6qJtaqPnsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXoOtZth9clPBeApxiSp9WLmGhLqWS4g7yNd1Vr+NIN4TB/HXQ16u3jRyWEKwIqkotkngKNmGJy/aug9OPy5TMrIWWW0ibZITte/2utWSv69d1clkgjeH86/6QNzj1FNK5bKy1YF9QIjJpSJ08TMlU9rYu9M3ssjawzQ/JFHn9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbYm0LQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D1AC4AF0F;
	Tue, 30 Jul 2024 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722356707;
	bh=VbCyqmc1UmLWidPvbHAC5GqzsjxRL2iBn6qJtaqPnsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbYm0LQqKCtNbS4u8e0uJNqqCMttSAhtjgrQo0ZfKTeqvunODGNmnAr+L+LxIIS4a
	 2lS5o87dSbf44tTRTanXK+QtZDlePupluFa+dZ/pFMhk1Vdm+7LGNSaCrtXUoI94Wn
	 TVhzmvXsvlzj1d9QofF2f0z2elpj3G5aADBtHbhuz+yxku2wMDE0xiPXDw75CwhZC/
	 xrsHR4/moe5JnTBAF/mRVsnt5fdz5OyDi6K1H2dio/jmWpuABJzGwb5JNp5x7hBmrB
	 nVk4Id4rjIv2dQl9EEag+W8tzpBisfpzIkampAeQ9Brrk2REow5dZPogZo2p9vMv4g
	 MQrsnObGgygAA==
Date: Tue, 30 Jul 2024 10:25:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <172235670545.1485713.10394540280750747057.robh@kernel.org>
References: <20240727-stk3310-v4-0-02497b1407ba@disroot.org>
 <20240727-stk3310-v4-3-02497b1407ba@disroot.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727-stk3310-v4-3-02497b1407ba@disroot.org>


On Sat, 27 Jul 2024 00:23:33 +0530, Kaustabh Chakraborty wrote:
> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
> being marketed as a proximity sensor, it also appears to have ambient
> light sensing capabilities.
> 
> The part is fully compatible with the existing implementation of the
> device driver. Add the compatible string of stk3013 to the existing
> list, with a fallback of stk3310.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


