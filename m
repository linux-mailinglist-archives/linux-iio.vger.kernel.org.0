Return-Path: <linux-iio+bounces-7596-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1592930581
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61916281DCC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35312FF8F;
	Sat, 13 Jul 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T33hSnD7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCB11094E;
	Sat, 13 Jul 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720872388; cv=none; b=hPd87bVnOwKQ2KU7QN4eapWmWII7oQI51AiR289T1ipsEeGbncFC++XU8Rq2FsPWmwmvGaxc6WGRru7ccu7H4xCp5OydtkcztCp+0pAj65PBDCV4JrIfx4AXep+/znBHddiqPla3dTZvAsR6T4S3/LJvjpomXbc5LiCkzf+IseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720872388; c=relaxed/simple;
	bh=WsiOnX/Fe7o9D2h2VvZ0SnTaBaTcoi87BK4kfMgS0Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKk3FAl5um2UhkEs5JlrrXxAbRAFDVHaW6JdWLI20Bl8fdvzYnNwVK5zhtJHkVE6EqOh6PeayXL6WT7wqrCkEO88o9U/5Xzt8vZxq9WEocbVUn9xdaNQo29Prdvsv4KBYPa833fCtcvzwMyOOy9UsB8U9SwQKP5pip3bt3b70eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T33hSnD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F50C32781;
	Sat, 13 Jul 2024 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720872388;
	bh=WsiOnX/Fe7o9D2h2VvZ0SnTaBaTcoi87BK4kfMgS0Yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T33hSnD7p+sk/89bGGSLclcl+9mLARljfqS33XLM2wvi1pwbTeoaHSm7KWARXp2Hv
	 anbsgufbwlrLSzrnlZIPyfTU+1KG84oF75dYIk3pDzrFsOlbV3vysay7AIWOfiIqoW
	 VKNldDjl2XEkQPVOKPNigKz2cY8qA67clalYOi7tqocrU7E3/a3IQjWR27aAWY5u7O
	 GfSVSX2iFLNBuB+nhvl1TD2EACphdfbb/4LgnOUzPdEQ60z3WbhBokgs7SApFLbGTe
	 /KJsUZ0GMC+0KqyMdojXuxRqf9LVYzn42/mSCWn4TtmBOJCp5Fg3DeRkkFEVqilij3
	 rcPWg16pOhh+A==
Date: Sat, 13 Jul 2024 13:06:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
Message-ID: <20240713130620.79d47130@jic23-huawei>
In-Reply-To: <20240712152417.97726-3-kauschluss@disroot.org>
References: <20240712152417.97726-1-kauschluss@disroot.org>
	<20240712152417.97726-3-kauschluss@disroot.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 20:54:02 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> Add the compatible string of stk3013 to the existing list.

Should include how this differs from existing devices such that it doesn't
make sense to use a fallback compatible.

> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> index f6e22dc9814a..6003da66a7e6 100644
> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
> @@ -19,6 +19,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - sensortek,stk3013
>        - sensortek,stk3310
>        - sensortek,stk3311
>        - sensortek,stk3335


