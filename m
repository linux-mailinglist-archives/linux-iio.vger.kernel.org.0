Return-Path: <linux-iio+bounces-8743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6A95DC43
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 08:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284F71C21848
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4715380B;
	Sat, 24 Aug 2024 06:31:47 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902093A8E4;
	Sat, 24 Aug 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724481107; cv=none; b=FO/8UTtBlOFfvUPbcXX3W8pY/TdZ1F4eXyerq4FQfaNey+lvn9jUkGy7T+VQfvfVCfx04srmOStU1MoMWKuRF4QDhHzi5lBAcfHvwtEj+XZ4U7BFZ0DwcZLdTzWp0rNrg+SjdfdMY0hbF/6+0UE2i+ZkWkwDVQqEcrcJQLOD2IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724481107; c=relaxed/simple;
	bh=2EdA9dYifcGgOE8+tCMyipwrc6qwM59V02r/mYYtTB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFjbI54gXFDexyO+4/9nTyyx5hdjZ0NvoJKBtoK00QL561r8wgmiAegAVB9+xqvXtQ719NJuePmQ6xJ1BiwgAbM9nH6Wj5tRP4VHwPzspGx/26SmAAg9vsdM4zPWrw5fgHH3Elj96HZ5wFzLQbX1eY4d0pq416YFKr5BRxr1qSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79BEC32781;
	Sat, 24 Aug 2024 06:31:31 +0000 (UTC)
Date: Sat, 24 Aug 2024 08:31:28 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Chris Morgan <macromorgan@hotmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, Chukun Pan <amadeus@jmu.edu.cn>, 
	Andy Yan <andyshrk@163.com>, Muhammed Efe Cetin <efectn@protonmail.com>, 
	Jagan Teki <jagan@edgeble.ai>, Dragan Simic <dsimic@manjaro.org>, Ondrej Jirman <megi@xff.cz>, 
	Michael Riesch <michael.riesch@wolfvision.net>, Jimmy Hon <honyuenkwun@gmail.com>, 
	Alexey Charkov <alchark@gmail.com>, Elon Zhang <zhangzj@rock-chips.com>, 
	Elaine Zhang <zhangqing@rock-chips.com>, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
	Finley Xiao <finley.xiao@rock-chips.com>, Liang Chen <cl@rock-chips.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Jamie Iles <jamie@jamieiles.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 04/12] dt-bindings: iio: adc: Add
 rockchip,rk3576-saradc string
Message-ID: <wegeyglbv5xufuvpmf2ye2bu6w5ob753h4hfimxw3ozt2vnfoh@fgvdblizg5hc>
References: <20240823150057.56141-1-detlev.casanova@collabora.com>
 <20240823150057.56141-5-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823150057.56141-5-detlev.casanova@collabora.com>

On Fri, Aug 23, 2024 at 10:52:31AM -0400, Detlev Casanova wrote:
> Add rockchip,rk3576-saradc compatible string.
> The saradc on RK3576 is compatible with the one on RK3588, so they are
> used together in an arm of the oneOf.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> ---

Why do you keep sending the same patch which was already applied?

Best regards,
Krzysztof


