Return-Path: <linux-iio+bounces-22750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBAB27BA0
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DC017771C
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091FF258CE2;
	Fri, 15 Aug 2025 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpzOLKLT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D19256C8D;
	Fri, 15 Aug 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247616; cv=none; b=OkK1fI/phG4QO8lgWpHQ4EkDgYWu/HLAZn5wDqEd0digbdOcnW5ZdUd72kVrUJjB1pxHheGNctSmGdWBdOJA9gXGLqUAabnun/dtUw4Q3kffwu9FMWP4qmiQ6OL7gLcdWxTQW1FGrdT3WWGt7v5HRAagQp5Yv6NmULlOdWH4EIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247616; c=relaxed/simple;
	bh=DitvXqbCn4HRNIH2tX3SOoO5zH2bUakgWTF+qukZpUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTG85Zkzep/D0tISU+LzDqHs+V+Yau8DFt1RdpMG7vTU9g+E4WV9Oa4xT1UpPM6unFJBhZMutvn9uo1xHaiUmcqf8cEmRoLD6mvqZ0dGgbOv4Rumk2EDThLnfQQHB/H9ONrYPip5HWxUOntJeS316qGy6XtrbzLvK2pWiZPasCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpzOLKLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE54CC4CEF4;
	Fri, 15 Aug 2025 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247616;
	bh=DitvXqbCn4HRNIH2tX3SOoO5zH2bUakgWTF+qukZpUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpzOLKLTK/Nu72Oz0mv29BBjw/BitM15VWrjMdd4BPoT45t+vu8Uq9aZyH0dtSJsJ
	 KlNCD3X2MQU4q9lDki5F4bWBD/XsH2FUzotQlqEwx72loYtXURO1Zfq/lVdHKcurVx
	 hwKrOvBsXf5kpywh0+p7dgKwgcOyyQp0tMW9h2cJddYLLcUe1SnjZxKcuD5D9Cm+eu
	 dla+XyvP2a0Ic4Y1QwujriOyQR1vF4Tr4/2LJJdw/ar304iRHKqkQpVjwqUrJhPp0+
	 FAEnwqG7L4YfiWcP82Jf7LfBUOlXIsyJSO3UP1GKPnEl7hyoWBfcAnbZXbPMWVmXoj
	 1nc7p1kII6knQ==
Date: Fri, 15 Aug 2025 10:46:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Message-ID: <20250815-muscular-rigorous-dugong-55ea26@kuoka>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
 <20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>

On Thu, Aug 14, 2025 at 08:57:15AM +0000, Remi Buisson wrote:
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - INT1
> +        - INT2
> +    description: Choose chip interrupt pin to be used as interrupt input.

NAK

You just keep ignoring all emails and not responding. That's not how the
process works.

Best regards,
Krzysztof


