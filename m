Return-Path: <linux-iio+bounces-25476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103BC0E63C
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DD0C4FF980
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146113074B4;
	Mon, 27 Oct 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAxgfL+j"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF20C1F5846;
	Mon, 27 Oct 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574625; cv=none; b=QtNWTuTQ8SCuBQA55xAiivtVKSmbWVX622pJslbE3T7BVtznN+F7H5ZM/2lp3G1i3slp2tw9O3ZDwDDWBQAU69i9+I/C93xcww4v/xqz9Md+35fz8V9iiEZLgZZRye0mfyj1MvJrLf3m4CgdP2WLx6u1DeaH67vdTdmyrjWRxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574625; c=relaxed/simple;
	bh=CbZdh3yYU7QF3c8grlrTtkhqHqPJ8zTOF3/pbM6JfaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdvwflgtF2yQvuhQnKkeIVEXlZaj/DxGevWCYEsLF09rT4vR8rM4OaYCMcIb8a9wte3mviiFmosN48bFUHijaAZXt+ae7otBhh/SQaGkPAGsUI9hyz8hX7UqAH2LWrSIbgdOWpyUoYvL9yt2Hyd0qeoYq4M6s6rFF6dJt74Pwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAxgfL+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39330C4CEF1;
	Mon, 27 Oct 2025 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574625;
	bh=CbZdh3yYU7QF3c8grlrTtkhqHqPJ8zTOF3/pbM6JfaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cAxgfL+jZZUZ2xqT/6AGPaa3w7wMOYSFEbS5vWy3JJS7osjt5VD8eA8M3VoAlb/lN
	 iZQqDGorVaQWiKDGFJRczq53g88HdVyipFMaLO/UWU9CziK6BXCtzxql8Li4ArX2HQ
	 ZCNftyt8Z3Z39BvGdi8zbTtRWjr4CRqPePgXNXEVjWTO+XIXGZQsw4YntmpurXdMnR
	 GLnbEyK78OfwBerTxsN7xahw2CXMwBOZ3c5BSOoCM3tQXzuCslnoDFdukUlfovlLJJ
	 T0uaY10p3IKslUedfd4yl7tCuUHaO6QTMA7j996VbecuyD/VAtpsQWmc4RbXQW1INP
	 bL6/0iKgzCLuw==
Date: Mon, 27 Oct 2025 14:16:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: Add rockchip,rk3506-saradc
 variant
Message-ID: <20251027141658.45be4a6e@jic23-huawei>
In-Reply-To: <20251022-grandma-maybe-2a1cef529cf8@spud>
References: <20251021223107.193453-1-heiko@sntech.de>
	<20251022-grandma-maybe-2a1cef529cf8@spud>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 18:57:40 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Oct 22, 2025 at 12:31:07AM +0200, Heiko Stuebner wrote:
> > The SARADC of the RK3506 is similar to the one found in the RK3528
> > in terms of number of channels and the other implementation details.
> > 
> > So add a variant compatible for it, that reflects this fact.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable

Applied.

thanks!

J

