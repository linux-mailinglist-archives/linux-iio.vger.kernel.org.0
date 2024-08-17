Return-Path: <linux-iio+bounces-8524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2359B95575D
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8F71F2210C
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A50149E0B;
	Sat, 17 Aug 2024 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSx+ivpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004AB143C70;
	Sat, 17 Aug 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723892810; cv=none; b=Dj+Wa2Ktqn58hVhwnl1V5wyKpoMpskZT/Fe6lfVkRy2+AfCg1KyUZGHy41emDA7vkvNob9AXxRhu9QckM9SxLCy+tLugQeb9tcvgtSm307V8lFKqUS9PQZqbUQ/xanV8BpD94rjByjxA4X+ZcWjsbA/R+I0OEZb3UMSshJN67XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723892810; c=relaxed/simple;
	bh=NIW5FpT0Aoona9Wp+eiXAynxGY2pPAXSNybNzENO+LA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpBB6zVnJF0v8M3dEJGF1vtqOtSmcniAOL4smwTQC20u995OA0nEWvyWSyFMSlqYWgP2kKupu4AFjxCr7C2TPtZ2JOhcVHKplkijPWxzq1qNlAo0gwGijOFpEhZ/V4U1391dAR1mEP0wC3v5JoXm3xz5BDqrAgUbsjB4+8RccBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSx+ivpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D872C116B1;
	Sat, 17 Aug 2024 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723892809;
	bh=NIW5FpT0Aoona9Wp+eiXAynxGY2pPAXSNybNzENO+LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KSx+ivpxePhyDiG1BTizUL0ssp2NxmPNUUMIMbR2ylJ5000//vBzm9qeL+ZsohdPQ
	 Azi+qKT50ELWQYb7PvOfiyrDBYzDoe0GzPTv7OanZVjH97vfMklY8JPgWYNjN/GvVt
	 fLS+QUrZYn8T4SrnkMJ87PYn9yKkhl+D6cfJi23457yBy9pCIj/Zau4ZFuTeBFkalQ
	 rKwm9OcU9wzvwhhkadaOAf2L1lU1oucxjl8IB8O2S7x+v7KzdSeVmSVjmwR0eifVFd
	 m/urr+SDmsS2NzuJbF4xMSlp7fcYBEJlHGM2HSfn2I0nUNpR629Er6AgUi2c3H1z+x
	 RGdQ15ExxDOBg==
Date: Sat, 17 Aug 2024 12:06:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V6 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <20240817120610.57b8530f@jic23-huawei>
In-Reply-To: <20240808102851.4024025-3-wangshuaijie@awinic.com>
References: <20240808102851.4024025-1-wangshuaijie@awinic.com>
	<20240808102851.4024025-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 10:28:51 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> AW96103 is a low power consumption capacitive touch and proximity controller.
> Each channel can be independently config as sensor input, shield output.
> 
> Channel Information:
>   aw96103: 3-channel
>   aw96105: 5-channel
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>

For future reference, if you send a new version having received no comments
please reply to your own thread to say so. Otherwise you may get a review
on the non latest version.

