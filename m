Return-Path: <linux-iio+bounces-9470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F6976D9F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E3D1C23D3B
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E10919C554;
	Thu, 12 Sep 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOGbvgFh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9829548E0;
	Thu, 12 Sep 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154458; cv=none; b=ZSKb0PubygadscUimu5h8owZAp9QXJFP33rs0E89zaMKEPA+9oHnG30DUGmRcevRn/3aHhteDSq8V1GPBxybeEui8OdlDmbv5k3oFZvnMCFQp7TYDPR6GYMkAhdgXeiaQeOhv42y5SGwscTtWY9cJxsA9lOCu+VVpr25JGeEKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154458; c=relaxed/simple;
	bh=Pa+luGAf3a2+eoxTNfhzvSyF/opw87hXVNCHeiOEuaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2d6KGJ0OhAok0POpdblrGtTKDwvJSO0g4bm1GJlA1X2JFzv0W3v9AbMFfYD8w75ChOFXNjwY+HJ3gXX39waO3XpxNw3AR2ZmrdGKSd9fJB8EYmU6zxTk5APK+Hvp6+Q9x7TcfqAWvlEFVhODHNMlEPa5GyrEECWEvpu50SeBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOGbvgFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C636AC4CEC3;
	Thu, 12 Sep 2024 15:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726154458;
	bh=Pa+luGAf3a2+eoxTNfhzvSyF/opw87hXVNCHeiOEuaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOGbvgFhBiN3gmugusqjyoH4Qm263rbj3lHiO880GffhWgfKoMyX+6a0HZwaoQBAQ
	 RMvj94yx7P53bFpRHaI7bLN2Cm32LlPpTDnNvrO8//9xUj1YShtBglimmK926iRbaN
	 xROwRStggfYwQf/YZygPWvAIrJ6qR06pLzO0PrT2TbXDxulCkAsVbhOh/Is/rRn4X6
	 CXDmCO8DEbafTGm/NJ1owvRYVBqKxtBraGH0sKWIo5XXj6XEUhIqgWeli2Cf1OexOS
	 ii1ec5bYiK0h3fr0sCAS3DrNW/JSd8U+m3/9vXr+5DO+VZLolMeifiofxQNkRQO+L+
	 IU5OnZdwBJLAw==
Date: Thu, 12 Sep 2024 16:20:50 +0100
From: Lee Jones <lee@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, andy@kernel.org,
	nuno.sa@analog.com, bigunclemax@gmail.com, dlechner@baylibre.com,
	marius.cristea@microchip.com, marcelo.schmitt@analog.com,
	fr0st61te@gmail.com, mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com,
	kernel@collabora.com, jic23@kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: mfd: mediatek,mt6357: Describe
 Auxiliary ADC subdev
Message-ID: <20240912152050.GF24460@google.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
 <20240604123008.327424-3-angelogioacchino.delregno@collabora.com>
 <01020191e56f3f66-1afb592c-a676-4871-b75a-bc38d896ae03-000000@eu-west-1.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01020191e56f3f66-1afb592c-a676-4871-b75a-bc38d896ae03-000000@eu-west-1.amazonses.com>

On Thu, 12 Sep 2024, AngeloGioacchino Del Regno wrote:

> Il 04/06/24 14:30, AngeloGioacchino Del Regno ha scritto:
> > Describe the PMIC-integrated Auxiliary Analog to Digital Converter
> > subdevice node.
> > Full description is available in the mediatek,mt6359-auxadc.yaml
> > binding relative to that hardware.
> > 
> 
> Hello,
> 
> I just realized (indeed too late) that while all of the other commits of this
> series are upstream, this patch was not picked, causing dts validation warnings.
> 
> Should I resend or can you just simply pick it?

It's lacking a DT review.

-- 
Lee Jones [李琼斯]

