Return-Path: <linux-iio+bounces-22711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9CB25D7B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91E988380C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 07:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6337E26D4D7;
	Thu, 14 Aug 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzcT4JWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9626CE36;
	Thu, 14 Aug 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156362; cv=none; b=e0NP/0n5Npx5KVBoYEhRNiyIQVmYfaKGuRC4F1wC1JUiFSwSRp9n+Bu9dNzgD/thBnM7qTYCmhKShjon043NSSdLjxvUzhzJ6FyJ6TsSdvSAouWaKodAgzimN1TWsk1rXRWSb6BWb10lvdig5FCzN+6gw2ZJpF26sFb868eZipA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156362; c=relaxed/simple;
	bh=bCODuuaMFmNNXeW6jzV9cEYu0VFKOJKB7DKgj/ELYos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkcnN/6tUtHsGkASnufPOybqosXjdzoR4+AvrVj8fle2H33laCI+2wMcT/pdo/aKfoUnwIumiItPfeNZF8On/G7XvvxoqmXmtu1h0ETdhkrZHQgQ+w/le7nQX1MtvB4z7ISuQPXiQd4XIlNcuy4KP8WcSm6M7Ds+bQthiaZitsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzcT4JWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182D1C4CEEF;
	Thu, 14 Aug 2025 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156361;
	bh=bCODuuaMFmNNXeW6jzV9cEYu0VFKOJKB7DKgj/ELYos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzcT4JWHuGjOBbjQSAT1kvFbLihB9CHP4Pz6CKXlFQKshniRyUBIPb5xQ2/Ff2IKY
	 05LQZ217yrCAKXlkEhEM4Y8v+GiBtiLGKuj/OsLjJFhjkTHFWIM8uJhXR1yTE43RiZ
	 hZTKqFv3NlDZO+NeoJhz5w2MKll5M90pEnXe+C2a9Df5dFQohbk4b7Wl5R4/MBgJbj
	 lbvyDROT8813rhPTEltxkHe8yvSkLCb9BqIYD7MnvNp3iew+UVrXsIzrqsNcTxUBgG
	 hZ6VIDb5Ykn2uMun5+0FQazZRQgevqXd4jPtJvp6SUBJK5PuOlXVVD9nHYh7SA0Ng2
	 tE4Xm1Qq07RBw==
Date: Thu, 14 Aug 2025 09:25:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/11] dt-bindings: iio: adc: ad7476: Drop redundant
 prop: true
Message-ID: <20250814-authentic-silky-lyrebird-05cbdd@kuoka>
References: <cover.1754901948.git.mazziesaccount@gmail.com>
 <bee66444bf628ba9a34a02738a1842e2abc14290.1754901948.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bee66444bf628ba9a34a02738a1842e2abc14290.1754901948.git.mazziesaccount@gmail.com>

On Mon, Aug 11, 2025 at 11:51:50AM +0300, Matti Vaittinen wrote:
> The ad7476 supports a few variants with different power-supplies and
> control GPIOs. The binding first unconditionally introduces all the
> properties, and later sets them 'true' or 'false' based on the
> combatible.
> 
> The 'true' seems to be implied by the initial property introduction so
> the 'true' -branches in later conditional handling (based on the
> compatible) can be omitted.
> 
> Drop the redundant true -branches.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


