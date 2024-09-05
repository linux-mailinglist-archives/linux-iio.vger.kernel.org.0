Return-Path: <linux-iio+bounces-9161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CDF96CF75
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 08:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BE01C215BC
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 06:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9AF18BC21;
	Thu,  5 Sep 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDcOSTJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808F18B49A;
	Thu,  5 Sep 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518211; cv=none; b=YF8zoAF88H+3JLP0OmoE+WT7vkSeZrEITRIj6gfkX6SUrKL/BT+Upcjae2SzaZ5FiqiMDErpXStSHZGOOWXSHIZzs3WO1uVOLiBsDndWaUdH5yVvQuMhecZW2W5Ra+1jR6tRHjCJyuvE28RzC+Z1TG5huwHCBptLlT2AAMEh/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518211; c=relaxed/simple;
	bh=A31KV7gJdttZU27t/gFNq9FlRPFZe8FiyR1UlVMQgRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSvNWTj8oeEQGr8kFDxTDAG0buG9oJo3TLgS02RzkbMMRxn0Nk0R21SsTlzQJKRs/RtoVCGPDL0j0RtdlzKm7+8Tx8OClxYtW80BFg9l2miMn5iji6JgTC346dqVGA96Vs9IDfsafg6luIxq4hDX7ejpz84IaecNFUrlVB8efcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDcOSTJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FBBC4CEC4;
	Thu,  5 Sep 2024 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725518210;
	bh=A31KV7gJdttZU27t/gFNq9FlRPFZe8FiyR1UlVMQgRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDcOSTJm/MGhjGex/lThMzVFbrBdPY0r2g2Tp9m8vZtiLX5bjqaewynn3BVYw/QHz
	 wyl7cqCdzkjkoQCP/SjGkQIb6n4bbzVLrVbbSL0aK6QDqo6rVV3LoSYf92mmn+kljM
	 /v+4pPld09IMXmihOMVMY5VttSwzJLmSiln3X5NtsRtxEpUUhf+VgwBoiuCQ2CRzG1
	 XvXC9C5OA5V4QD5oBYQ04y2qxv2u9lgZjNaQJfvqyXsI7O0+wkdGlaGseOWUulaWT+
	 7K67UYkr+PSLatY3AwehCyT6gFOJY8+O2Vz6zqM8oWlM94U53oHaKh2gswBmatNajW
	 aKT+V0YCbDU+Q==
Date: Thu, 5 Sep 2024 08:36:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v3 6/8] dt-bindings: iio: adc: document diff-channels
 corner case for some ADCs
Message-ID: <je4r6tah5ceevoi3pow7wzz3usxyrdf2mi3zvubdm22ohxfste@2fwuomtvttx5>
References: <20240904072718.1143440-1-aardelean@baylibre.com>
 <20240904072718.1143440-7-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904072718.1143440-7-aardelean@baylibre.com>

On Wed, Sep 04, 2024 at 10:27:14AM +0300, Alexandru Ardelean wrote:
> Some ADCs have channels with negative and positive inputs, which can be
> used to measure differential voltage levels. These inputs/pins are
> dedicated (to the given channel) and cannot be muxed as with other ADCs.
> 
> For those types of setups, the 'diff-channels' property can be specified to
> be used with the channel number (or reg property) for both negative and
> positive inputs/pins.
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


