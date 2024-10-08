Return-Path: <linux-iio+bounces-10321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC19941F3
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 10:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CCC28E010
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8866F21018B;
	Tue,  8 Oct 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPUkkBDt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363D1E47CD;
	Tue,  8 Oct 2024 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374189; cv=none; b=ftcKs4hww8KrzKh+ksHWzyBwl99AeAx4ZoVMX0DTuW2QXTfxWf1iucSFg5kc+Ob/6F/il6GIuTtjR4PdzUOLsLx2Wh3DL+yImDme6qSokHMwuoFGH0hhyM4oh4IAggl1YrzxRQ+7Osetj6r9gu3tSI8y6QGevNDf04Wfk61S2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374189; c=relaxed/simple;
	bh=I+2mFG8Sou6VEBJV1ddZb3liFfbpSk2sOJl65r7dYjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHsgqvot9klnEZHW42ZMSZoNA2HmoUKEQ2lXfgip2qZeLhwTNMzR7n0q9zo8ophudAZsgwSah2bCYlOuKo5N9CHf51VjRnbzPwN2mpEm5/Ada9JsEfpFtJMC2JFXXLGPu5UNcCeBH+kCQAGu5Zs1ZzSMrtWPrwRqZZRcJW3SPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPUkkBDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3BFC4CECF;
	Tue,  8 Oct 2024 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728374188;
	bh=I+2mFG8Sou6VEBJV1ddZb3liFfbpSk2sOJl65r7dYjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPUkkBDtq66j8K5qIsubT+MBM+4C/F8qzb6JlsbwVuuIDThyPr7l/HJGFSrGXKqp4
	 Q/Mw2yxlrcLTyJ5ZlGEYn9Pido0TxQTAycNDuycfMTvEYyRWVJcpOi/7Kr4uhRhHpP
	 rGkQbmiZqMiycgnTBZv2YIdAbBiq/18C6PLI8meV7I19NzEBBciY+3VaoaBHrmVZ2R
	 mF05V7B9NVPa/4inQRZVh839hGqHFAVur72VRqz1Z5Xj36/8OB/u10zTok7WAVxLBy
	 NjHcHangqXCR0XCSt7HAdJ3zzOv14kqW6KKinrC5Iw7P9OzjZ+OU3WgA7whPlzD4JV
	 mxgcrOJyuqB0g==
Date: Tue, 8 Oct 2024 09:56:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: light: veml6030: add veml7700
Message-ID: <4w7vnp56jvo67crvpxufb5nifjlobyohxgpg4kkpzzj553s5rb@z25g7rwcn3av>
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
 <20241007-veml7700-v1-2-fb85dd839d63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007-veml7700-v1-2-fb85dd839d63@gmail.com>

On Mon, Oct 07, 2024 at 10:36:37PM +0200, Javier Carrasco wrote:
> The veml7700 contains the same chip as the veml6030 in a different
> package with no interrupt line and no pin to select the I2C address,
> which makes it suitable to be supported by the same bindings.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,veml6030.yaml   | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> index 6218273b0e86..53b55575efd3 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml

There is no such file in next.

Best regards,
Krzysztof


