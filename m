Return-Path: <linux-iio+bounces-13532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7089F2B24
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 08:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AC57A1A6F
	for <lists+linux-iio@lfdr.de>; Mon, 16 Dec 2024 07:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48C1F755A;
	Mon, 16 Dec 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2wpmJIm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65E11F7096;
	Mon, 16 Dec 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335124; cv=none; b=l+cp8jCwuLmFxDV4JO0IkcKJ5Oc3A8pGmwFu1kT46eGtaD+zxBKTtte5nLVebtYdbXuyhdhlMGaWkR/d40jHavdBPGxOpQ08zDZnN6uc+09g8/Z977NwLkgWMxGvZW8/I24iyuFTedt5vnmtExDFWuk77lXQ3mLOdvKVHeTrKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335124; c=relaxed/simple;
	bh=BRd9WrVWrPPypLQFGauJyVbeBzlr4i97fwMDcEAdrhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpTfZmFnNOtCY9OIyxAlAWp3pFZBkzAMGD8rbkfRV379/NM0ZVvIzXtkheEDkgnbiy8BieX6vw/2Pnq5Ej4L1pmq1ll0yBkFIXdZ+/MQYRFS5eO/Ze8I+ezmqDA4Z9PNVTvT8Ani6avzDx0EkjNwdVD654GHup3j5QSkz+0tH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2wpmJIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD38C4CEDD;
	Mon, 16 Dec 2024 07:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734335124;
	bh=BRd9WrVWrPPypLQFGauJyVbeBzlr4i97fwMDcEAdrhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2wpmJImo2AtRz/LiQu6uhWv7vpdfO+wCKQR9bD4jFc/HcxWw51bqMrYFb6u/Q0Il
	 gY0QrntkfbfYzKELJYq822JttXRd1/bqcFW8Mz6wCQa9wy9kMeoPfseHhe2zIoUt1p
	 GwHV1kRshxqO3uZ2SDBn+kR500eAoEgNTjh3h2oYCooAHHrvaKyoZVZT01vtdqU0Gy
	 2Sp8j120OgU3M4JO4myO7GkgpqtMNOgkhe/Vq+Ink+s/j3ctAhBHiUSlyb1qwJYh/I
	 jo/IfWuXAHddpAt5sqtSfuU0UYCMdUnBgLF9BgBjiAdN+YTBYom+ha8FbQW1lfpHYn
	 Az3XMjWsjXPpQ==
Date: Mon, 16 Dec 2024 08:45:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eraretuya@gmail.com
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: accel: adxl345: make interrupts
 not a required property
Message-ID: <opbjiktkrrqwd2gnvmyl7bn2ng2imc7c6vwzhr22yisdg4xns7@5gpr7ggkypw5>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
 <20241213211909.40896-3-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213211909.40896-3-l.rubusch@gmail.com>

On Fri, Dec 13, 2024 at 09:19:04PM +0000, Lothar Rubusch wrote:
> Remove interrupts from the list of required properties. The ADXL345
> does not need interrupts for basic accelerometer functionality. The
> sensor offers optional events which can be indicated on one of two
> interrupt lines.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


