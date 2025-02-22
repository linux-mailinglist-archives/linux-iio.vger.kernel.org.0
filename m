Return-Path: <linux-iio+bounces-15936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9176A4086A
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405A1189A2D6
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FD20A5E8;
	Sat, 22 Feb 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpDb8Ija"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300C2066CC
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228141; cv=none; b=bS7/ESnivTvy45BPOREgAb+CY/bPfnFq68alsHdnW2sXvqCJi62QcYA0v0C3UhlrtTTwZLybDyA3tiXYZvm9jrlm6S84JK3Aul7tlHWuYqgZl5YnTBJYSbQ48ht21PoqDs+iyKVNgnvP7nD9MWGf3vmJkGu8y07zd/hxlAx+qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228141; c=relaxed/simple;
	bh=WjW2YzfILhR6tOe73plvxtRzcS8HSKcfXbn64AFqb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNxcuawKxMX/lPxlE3EIJ2E++Itw6JmeD0pc99yfDfvqkYWjlBd2WZmUSh1WkRBghu549ZlJNa5lw+yz4WnTSDs3lZIaPHbVkeeh67nwN+32Ykf2WiWa/KRd8489e0OYbdUB/GxnZaRntMoX6BHLk+bIorTNzgZDGgnyPO9nGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpDb8Ija; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B38C4CED1;
	Sat, 22 Feb 2025 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740228141;
	bh=WjW2YzfILhR6tOe73plvxtRzcS8HSKcfXbn64AFqb3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hpDb8IjaRAZqfpWpvt4BSJoGdSEKI1HmRgCkTspKvjYoHQkU7n2dPerrTtIB14jOf
	 hb2QZ15JxefcYmlW3TlZqN8bFHy5QsScHEaqPPxAUhfX4IRGr7vjD+l9cPgk7cajqm
	 r/nxwvbnSR7qOSLfRG5XtSd2Te/NdewaroEHXsOdt6z1ZXh2T5lbvxRk61xCB45o1G
	 NXey1YXL18ZIruGmpyuSuRpv3/Vk9CUHbCqQYBf+pcT6QOL7fI7Qe1aMiIEGGAt4hS
	 R/RS+i0KWTEzJYDIUMbOYnPEYdrQypYFebt8+dD17PluaCp7q4ype3+QW30fXEhXN1
	 /Mnh+WaL5WGkw==
Date: Sat, 22 Feb 2025 12:42:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] IIO: Accelerometers: Sparse friendly claim of
 direct mode
Message-ID: <20250222124217.0a1e6582@jic23-huawei>
In-Reply-To: <d3dc38af-189a-4f46-988e-4d99aed34b39@baylibre.com>
References: <20250217140135.896574-1-jic23@kernel.org>
	<d3dc38af-189a-4f46-988e-4d99aed34b39@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 16:21:58 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/17/25 8:01 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Note that a number of the drivers touched in this series have no
> > obvious active maintainer, so it would be much appreciated if anyone
> > has time to take a look!
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Thanks!
 Applied.

