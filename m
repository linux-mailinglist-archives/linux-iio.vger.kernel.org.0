Return-Path: <linux-iio+bounces-23190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67ACB339A8
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB5A16FEA5
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41372C327D;
	Mon, 25 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLq7NgKV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701712C21DB;
	Mon, 25 Aug 2025 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111062; cv=none; b=RM62462gf8B9lMAGOtRz4MSUzhyRxv2Ck5q8GL8kUSF/7Df3oyapVwtG4MES+yv6ajcDmQ82h941pGFSi2muq0Q2Yt9kVcl4OuwUjgNSvnqgvLBwbiUTtfehV3gUIiVTP01KnMpyi1dQjp6Y0JXu0e7lUn5J1fvEu4BBIV9f+H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111062; c=relaxed/simple;
	bh=1YXYNFms31Olpbd3Z9EDaS4mijVWb92scNBLUX5bE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcTERbexwB9Kq9bmeNRZnzdrfKfHojcJdKCQMe3ja99iwmOMOWLQq0xeIuIuCmt25WL0ezonhEZdgIzAF2ZikW6CIVGfQuhAoX/gC6C49zJQamF8cgwbl9gkJl2pDrMAbjQwpxToLs7xLGqCsJ42rgEaHOlJ1gCROmw3cC9Grns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLq7NgKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9114CC4CEED;
	Mon, 25 Aug 2025 08:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756111061;
	bh=1YXYNFms31Olpbd3Z9EDaS4mijVWb92scNBLUX5bE9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZLq7NgKV5ZbjsbKQMDxCwbZ4qHfbVpptjeDqlJ0Q7k19Jn0/RhyrOjo+ZabvB9i0h
	 7SJsGcYNIW3UoDlh6lV6HfeCUMf3ETOqmu7oLmhHMDGXgjyc3mujAsQEchvrD+sH5U
	 NmjCVQkH15MT2vwSjHlslshKBUHpWLlTL+htCzH+7tF1OfrzBvXGacUAHa8reevP//
	 s9jlXsEr2Vqh6bUyK0dtdQhp4L8jh0D7k4R1f0mWOe4fXS/jQi3QZManirXR/bYYJm
	 Ml6qkT5PKzdt77ofMq3MajCUTGuDNDQhPdJKPIZ9tDJwOj9VGoT16c8PIcZyLl9K/U
	 Cu1SE3/TdIsZQ==
Date: Mon, 25 Aug 2025 09:37:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Xichao Zhao <zhao.xichao@vivo.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Tomasz Duszynski
 <tomasz.duszynski@octakon.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] iio: chemical: Remove dev_err_probe() if error is
 -ENOMEM
Message-ID: <20250825093733.789cfc12@jic23-huawei>
In-Reply-To: <y3pmdf6swvsqltu3imitrcietjybbwtmewjmmk326o4oqzadh4@pyxfp3czft2n>
References: <20250821080723.525379-1-zhao.xichao@vivo.com>
	<20250821080723.525379-4-zhao.xichao@vivo.com>
	<y3pmdf6swvsqltu3imitrcietjybbwtmewjmmk326o4oqzadh4@pyxfp3czft2n>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Aug 2025 14:27:55 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 04:06:47PM +0800, Xichao Zhao wrote:
> > The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> > Therefore, remove the useless call to dev_err_probe(), and just
> > return the value instead.
> > 
> > Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> > ---
> >  drivers/iio/chemical/ens160_core.c | 3 +--
> >  drivers/iio/chemical/scd30_core.c  | 2 +-
> >  2 files changed, 2 insertions(+), 3 deletions(-)  
> For ens160:
> Reviewed-by: Gustavo Silva <gustavograzs@gmail.com>

Please use
Reviewed-by: Gustavo Silva <gustavograzs@gmail.com> # for ens160

for commented tags.  Then tooling should pick them up correctly
without me needing to hand edit.

Thanks,

Jonathan



