Return-Path: <linux-iio+bounces-10331-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE5995047
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70981F253AC
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7761DF27C;
	Tue,  8 Oct 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4dNWT9K"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6A1D9A43;
	Tue,  8 Oct 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394599; cv=none; b=D7P8UsGDDm46N98qGDAoucLL3oak2OjvWcSzT9jUXxNG5N7f5+tZ86nQlZPymOBfiT49A8vZ25TNxp4bRsOlPgg/MIFMUjN1PwaZGdFYrRdNEEcIq69wxQK5C3wRNpAYrBRzWvihlFPyqrXpBXq7itavoDdxCGex0AISbJRB9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394599; c=relaxed/simple;
	bh=0+QZzej0Vv4WLSTqV2G2UR2upZ4oeTD+DIr6PW9bQGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMeH9muWyGGb4mPixWSj6cN7ddkl4Hh+zY7IngENUPZQwM6IUSuODamobkTaLbb8LKhSR92bsgwfGjlTprKd5/dl7G0tE36gV1LcQdwq9xjKd58DdFhz3kXD88zYtVEMSp9gojOekHySf4NhbcHZzbkUv7qe+7+whRmuvo8ZUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4dNWT9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66202C4CECF;
	Tue,  8 Oct 2024 13:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728394599;
	bh=0+QZzej0Vv4WLSTqV2G2UR2upZ4oeTD+DIr6PW9bQGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4dNWT9KZiMQoeYFy9MoOPiss1Celn1pEqjzF39bx+jaY1qcQTnpvXgCrN77+gTZA
	 QQVc2//c8vmbixJM8ULrw27HYitryFOIP1iST4dt51Zd4eMm1tYGiG538V2S+L0XxQ
	 K7V6yGkeaJukiDgh3I8rKU1w1wmFE3ggS5cHBw7Y6agd+uuZprY5q1Zw4dX4o4Nnc6
	 bD2/E6V1uOfKjrJkH5Qiywso5ohISmUFoyCI96ucAMamkVPO+YmFepNnBhhbadRqqZ
	 602ewlmAPZvwnSJL0Tmgy52rcST3NWK5aH8rpNlcwKRcYMmxLrk5elQ5IjJC//SM2q
	 f9/3BC7GdMJWg==
Date: Tue, 8 Oct 2024 15:36:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rishi Gupta <gupt21@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: light: veml6030: add veml7700
Message-ID: <yebcvcybwpi4t7as24pc65lrdviwaajael34t6mr23lor7abvs@encmur7gb65i>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


