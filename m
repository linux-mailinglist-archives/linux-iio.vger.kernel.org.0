Return-Path: <linux-iio+bounces-14386-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE95A13451
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 08:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C386165B0A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5996B193407;
	Thu, 16 Jan 2025 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTf2iHwa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2D142E83;
	Thu, 16 Jan 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013925; cv=none; b=ruQCKgUdwdarqHpqlnrWNQfZdv8R5p/JEj5igdlMjeKBdRzS4zCtJtxgw+Pfi42zA+q1jh4qye66gMny9n2LDytUs0uaBR3ZxCM6cgt34EwwhRTsJCwhLpkexMpZ1kl9NZTvvJlPLNY1K6tl/VapXAzatBGfAdN0auTv8GhCvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013925; c=relaxed/simple;
	bh=JV/ezC4Tbo4xdFbq7pXA+uaT5JltTCvxZIWHU/tVBTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRmAg39aBLiMj4Malhq8nZwBJRb7qQpODAhEuS1NLjdlmQGcx+rRwauhhKYUTUC1uq1e9MtQ5BdbqGdZ0Xocutd83XDOB5MqmYK+4OZuBI+hjlF7TAQip1ptcD/BD4dEplnWTj+mt1GvuX5QROM05nsBb0Prxm5eQNrpU1JEhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTf2iHwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180BCC4CED6;
	Thu, 16 Jan 2025 07:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737013924;
	bh=JV/ezC4Tbo4xdFbq7pXA+uaT5JltTCvxZIWHU/tVBTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tTf2iHwaCWfy4g9zxR8QDa+xIFa9yp721J0y5o4p63iTDBukDKR3NUDnXgfRdMkrq
	 ut9q+FT1JpkeuIzd98WH9vhLL/uewExN/zUt1qYuV+8AgmjsACzdWTgw8m+gMWm7a+
	 GRP2dRWnPG4b65vYikeyq4HwieqWH6Y53KZyWdkDYtuzTLcAjnYbobJhe7/RROCHki
	 Jsz46kC+5JiJcGr9IW/8KEcuUX7wj4PavBYNNN7l3tTt0RrZ8iSpFIHyxon3MkeApd
	 WphaYcRNiUjrIGm5vfskHCH1YrMSlzMJW155KiL/Ot0Wl3n4og7NzSUi2lVfFxTw0r
	 c6rRt9meWblug==
Date: Thu, 16 Jan 2025 08:52:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrej.skvortzov@gmail.com, neil.armstrong@linaro.org, 
	icenowy@aosc.io, megi@xff.cz, danila@jiaxyga.com, javier.carrasco.cruz@gmail.com, 
	andy@kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: magnetometer: add binding for
 Si7210
Message-ID: <iszqibm3gbltio5m6vx5w7ty3ug6qpafghfrnic4ulseh2w23e@ycqybypfheoo>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
 <20250115201622.270130-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115201622.270130-2-apokusinski01@gmail.com>

On Wed, Jan 15, 2025 at 09:16:21PM +0100, Antoni Pokusinski wrote:
> Silicon Labs Si7210 is an I2C Hall effect magnetic position
> and temperature sensor.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  .../iio/magnetometer/silabs,si7210.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/silabs,si7210.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


