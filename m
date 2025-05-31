Return-Path: <linux-iio+bounces-20086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B767AC9C0C
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 19:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF723A8943
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E9193436;
	Sat, 31 May 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMaLHcdN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC1D290F;
	Sat, 31 May 2025 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748712591; cv=none; b=d1EcJSd4EzqwDOQ7WWECIBcY3e8FmncSLrgeqbsdNMciab4JzBOK2q5icx0l4Scp/z9xOv/aEQcyT7fP4DNAyd1ygAyA06EXEuL7SaUc2mhCBg36mXd8CM/epwOWwegMqysXUs60xo6sRm1XEUhHUkm4HSFwYTFCOhAcNrO0kpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748712591; c=relaxed/simple;
	bh=MiJ3W0UWWO3SczXh3w70YfSSrfIeau2mBBSZz1zZRhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eahsqme6Xu1y+kYfH9YhIZNahadgy4qZMuFZEC6CZHw6pI/7WS8l7olPRsWczai91J7RH0a0fEnARKjBQq6iSpswuB8AeyOt8BLzuYGOFk+IBOPy0NdxS8hzySdxRi+0qeWcQ+5Ev89oxYpZJctjG29g0YRbSOqqBZsIsAbvXLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMaLHcdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD99C4CEE3;
	Sat, 31 May 2025 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748712590;
	bh=MiJ3W0UWWO3SczXh3w70YfSSrfIeau2mBBSZz1zZRhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMaLHcdNl4k9nS+dWbaRBK3m7SMoTPw8BylFi/iTZgWDCVUfTm7jDEL+0jN8t9IFd
	 GkylHGZ93UgxAuz9EQOKTwWNBzl5y8IH7vZOMDLv/TF4TNsVNf1TFfdFTypzEGIhMB
	 afhnBHQC9TX/2DPRCmqK0qTt5to0S42Dffuyyn8umrvHUV//oymE+vfVw43sfyN4tn
	 7nEksqAi2peHs7FDdGEjPrXNsX6N8zB459GLUFI1vMnKmzqJc+zx48jNhUqBCeNJcN
	 KKGlBoygd3PWnS61BMvdED0yxb/2rdlJRMSF1NCv2sz/a9mlKEcua+9Ic00h8M37NA
	 nv29ernm9liIA==
Date: Sat, 31 May 2025 18:29:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, linus.walleij@linaro.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: gyro: invensense,mpu3050: change irq
 maxItems
Message-ID: <20250531182941.3d274d5c@jic23-huawei>
In-Reply-To: <ad946c3b-b2b9-4fdd-8b70-6fd493dc5dab@kernel.org>
References: <20250527215818.13000-1-rodrigo.gobbi.7@gmail.com>
	<ad946c3b-b2b9-4fdd-8b70-6fd493dc5dab@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 07:55:40 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 27/05/2025 23:51, Rodrigo Gobbi wrote:
> > The mpu3050 datasheet describes that this IC only supports one INT pin,
> > which means one item with two cells inside binding.
> > Change max to match this description.  
> Fixes: 749787477ae4 ("dt-bindings:iio:gyro:invensense,mpu3050: txt to yaml format conversion.")
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied to the fixes-togreg-for-6.16 branch of iio.git.

> 
> Best regards,
> Krzysztof


