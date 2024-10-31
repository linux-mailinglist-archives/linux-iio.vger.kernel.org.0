Return-Path: <linux-iio+bounces-11682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF309B75C0
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 08:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9271BB2445A
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C61914D2BD;
	Thu, 31 Oct 2024 07:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S78jByg5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6A13B592;
	Thu, 31 Oct 2024 07:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361081; cv=none; b=WQFl363ndixdUtQX0eGnyHXd+jJhFKZfffDCTZAfTzgI8+ol5vgEynMH8kM5aOw3d6DTCKTUjj/w5doVACZ4KrAU8UaueK5m/+bn3Lb12chI2TFM/swJ2LbdtGNiJIJl6IvYUo2b8Hywjm0pClkJokjcjw73NZ7sV6KSbrrTf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361081; c=relaxed/simple;
	bh=x1BzacSh2fs8wTqYFGigIsjN1Z2SI3UAs8cxN6+J/hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apKdZH1IrrV5RysIOIdSPmlINrEu3jILyGJZezqaxgCPgqEErSj4aOvkBM3NExXfqqDUceguvc4zQGIfXsKk6DVIe/WzDdJN1zQrF4kQOo2bGeEaRQqZ2cMx3VVnVY/dfEtAVOKOvhBBohsZZEb7Mkm+yGVmsX5Of/yZRmAwMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S78jByg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A21DC4CEC3;
	Thu, 31 Oct 2024 07:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361079;
	bh=x1BzacSh2fs8wTqYFGigIsjN1Z2SI3UAs8cxN6+J/hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S78jByg5mMnqp0hW684rwwOwvY5pG6wFLkg6M8j3dHFiKtkoTquRi1bztc2YBBoI8
	 DW2/RJa/0EIQYfRj5Z2zvmMyKGwVmzxUeDNzbGa9IOFFAxpiV56AYzhISmNU6x0pWe
	 dgHRjOIssxXjr27EvHZiZvTaPbbmoRTdQy8Wva6/ilwBakz9lEi97A3VsxXeEBk2UB
	 2bORJkv4aG7+ZcUYHbDCQukBqhADuCuZlzu5lbJIv7Q9X5W2owU1mWh6LP8z0wTP2H
	 8TVdVrP02sr3njS+48FtAoifpp2Ox/cqMZZz6ltnMzGRsMHPNDDs7c1BUSOotjX5TJ
	 M17GAX/eg25xw==
Date: Thu, 31 Oct 2024 08:51:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: veml6075: document
 vishay,rset-ohms
Message-ID: <nmhbqkuiomarjkxu5zzz4wb4e2ebxsibukrr22sogk57nnfmhy@zsak7sxufuem>
References: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
 <20241031-veml6070-integration-time-v4-1-c66da6788256@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031-veml6070-integration-time-v4-1-c66da6788256@gmail.com>

On Thu, Oct 31, 2024 at 12:09:57AM +0100, Javier Carrasco wrote:
> The veml6070 provides a configurable integration time by means of an
> external resistor (Rset in the datasheet) with values between 75 and
> 1200 kohms.
> 
> Document vishay,rset-ohms to select the integration time.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6075.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


