Return-Path: <linux-iio+bounces-10837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224EF9A5C8E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 09:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19241F221B9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C11D1720;
	Mon, 21 Oct 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l46N3iY0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF4F194A75;
	Mon, 21 Oct 2024 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495138; cv=none; b=DOKmfxE2pbUMA239yVnqcWnalAVCz2aXECWAS9/1Afid+LtlHB36DL6ncXI51aDhD68Yub2i2LdpO3nGugz7y8wz0Bi9d1cFDHQxWf4qUqfQ/FH0oh89SLn/6rhtKs+/wh3RynhKkSwKayABObC8+LyHxKTOt2EH3jAYOhnorjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495138; c=relaxed/simple;
	bh=wMwbyf3jfvZ6aS4LqH9EPTIwoYi/mpbUQ1YWHowEdac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhMyDV/TA7WjKdTj4V3RR7+GwWAee1j7g7WOXq+3Vy2olXqsJSH/2MDWonoV5EtZSyV3xz4EeLJrINWadOrC2L2RBFv8C0rfCZIDyyBKEhXMX9VoMisHKlOpfd6Qov07TRZDGhpSdoiBb2mOpYjN3BLo71Uqghr3IL5kGfi0IDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l46N3iY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EABC4CEC3;
	Mon, 21 Oct 2024 07:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495137;
	bh=wMwbyf3jfvZ6aS4LqH9EPTIwoYi/mpbUQ1YWHowEdac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l46N3iY0lW7euzF8TGcKX/60IWGET0v89e6TOxCzrfj7fnXILwHe9kAc9UqQH4nFn
	 CE1ZMzwahH6dW65ld1jGIVLYOkbtD0WpLVit7I+nO6gfYbvt6OQC6ras2lhCs8Iz/L
	 wMyIQufe3lazT+qZvlvBZ2pFxk9lTgn4pfO0j8VcRPpfg8qfLNQJ0QqPYjYRkT1Jz1
	 morPP0GejdPqYGLo3JlHqWHaoobDcIUW6YcJsPiocm9Ae5Y9gNdIT7QE+4w2QQLGhf
	 MY9moFBaQ7VGR8dfPEZRozslRQAiobXntD9TtnG+yyX/98TQb0kWa/fa8hT7tkHqxK
	 lHLT4yMNu4Rrw==
Date: Mon, 21 Oct 2024 09:18:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: veml6030: add veml3235
Message-ID: <flpbycbwgx3m3wjhatkqdp6vo352sfgsmwstaf4ak5y6zdlu54@y5juyzqccg3r>
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
 <20241020-veml3235-v2-1-4bc7cfad7e0b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241020-veml3235-v2-1-4bc7cfad7e0b@gmail.com>

On Sun, Oct 20, 2024 at 09:12:16PM +0200, Javier Carrasco wrote:
> The veml3235 is another Vishay ambient light sensor that shares similar
> properties with the other sensors covered by this bindings. In this
> case, only the compatible, reg, and vdd-supply properties are required,
> and the device does not have an interrupt line, like the already
> supported veml7700.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


