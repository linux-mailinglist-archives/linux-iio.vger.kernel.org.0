Return-Path: <linux-iio+bounces-15416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B34A31FD3
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22F03A1DBF
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5862040A7;
	Wed, 12 Feb 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLrMKbRa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1224202C26;
	Wed, 12 Feb 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739344662; cv=none; b=EW2XUaLBT813kEqTEWBXP1/WNGbdWFa7+WnzSjDpmqOVPAyn4YRTyzfAtzBv3kpLvoYHeyak5rp1cVMIfsgR7mK+oEQddkKviP5o1B3pAiwV0yhcs6lf3z5Xvqyk6BgybiUFjEhQRtdftVcmSZBiNCPZLyDxHe7J75OoyGmd1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739344662; c=relaxed/simple;
	bh=M0TCl9ruWebYVpXDJMwU6dNYVy2BWrny5aV2GLhyWvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lizZsLjyQfepJp4aaE7ge6KAjDuTnl6DdW7bH8Vz/7oQ+2vICzKCjqfWHDBZytD5d/8hTRfS3XfFU+DXYVJA+J4FIZBERsdouBpLLRT1oRxKv9nCdm1rHcEafeNIgjoH9xW5pC//DpIBZq58+ytrNLvXxSUEzBsywXStMfLR9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLrMKbRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B07C4CEDF;
	Wed, 12 Feb 2025 07:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739344661;
	bh=M0TCl9ruWebYVpXDJMwU6dNYVy2BWrny5aV2GLhyWvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kLrMKbRaETei6Rm9BsZLwh7ulvGsFzKWxATUwGYPGTTnUXOIJg9AUacaAhvNHypVe
	 sA6alhnFUbx64MGolpEsPwgBhpIhXPzaVWgbPWwmvfcfSt1SyEz1OV8ah6Th396gLE
	 NokReo+OcGmB+0NcRnfXBlSpuM1yAgIVdWZ3zr0gFJEih16NQTw82jxpAqJU5tkV9I
	 lIi/RpbCez4+Z6WsKEAhzWQ6AT/VK9oSbhrQHayewwdiCt+R48ZOahTzHk2EaHG/fN
	 nE6o6Ruj5ptLGZEY5xwIQlUvId7BDvWO9fWvEiM0fAeobSu7RA3Yw2optKRByDo+xL
	 foTwh8QwdN7Dw==
Date: Wed, 12 Feb 2025 08:17:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 05/17] dt-bindings: iio: adc: ad7768-1: document
 regulator provider property
Message-ID: <20250212-dazzling-glaring-shrimp-9530e6@krzk-bin>
References: <20250211234717.1008325-1-Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211234717.1008325-1-Jonathan.Santos@analog.com>

On Tue, Feb 11, 2025 at 08:47:16PM -0300, Jonathan Santos wrote:
> The AD7768-1 provides a buffered common-mode voltage output
> on the VCM pin that can be used to bias analog input signals.
> 
> Add regulators property to enable the use of the VCM output,
> referenced here as vcm_output, by any other device.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * VCM is now provided as a regulator within the device, instead of a 
>   custom property.
> 
> v2 Changes:
> * New patch in v2.

There is some mess in this posting. Nothing looks threaded and b4 does
not see entire posting.

Sorry, don't make it complicated to us. Send proper submission - see
numorous guides or submitting-patches - so reviewing will be
straightforward.

Best regards,
Krzysztof


