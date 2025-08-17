Return-Path: <linux-iio+bounces-22860-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C8B2937C
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D193C4E7899
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96222E54AC;
	Sun, 17 Aug 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4pBjttH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A73242D6D;
	Sun, 17 Aug 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441042; cv=none; b=gr9MosvvfAfXngnD79pQckyO+3neVdLnJDzo1dEV85aigcYb/BxKYpBvijfdaVu1NcqJhArEDnfEC4BVcLDJjomirIzJWDZM16rBAHFjvz2ImCtJV+lWTqXTcoNYpxlWT6iYCQp/dJYL3brRtW5CxPJI3oF+6Fc4jUMno0TEs8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441042; c=relaxed/simple;
	bh=+qZIHhn+udYMdDbnyljd27a3aeI8U31V+FqAr2BsT8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZc6iMyPziVbGa1PG2CDH55mzv7Aa6xKjUcMvBLDlWcw8qQh6QRuxwQpMYLQWfD1rZ31LD95XSbaW00xnO8Z8XYU9pB/3xL43U2KxqfnBA0eKhV5Q56KDZYxYX5RV4PTuv6w7Dwl9c5VE8+GbVHxTbb/RNDhCOL+0cknCCIH/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4pBjttH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D003C4CEF1;
	Sun, 17 Aug 2025 14:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755441042;
	bh=+qZIHhn+udYMdDbnyljd27a3aeI8U31V+FqAr2BsT8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a4pBjttHjhv+fB529UmNGLrOUzXKrIBAOJABZnmkLWp8w/EVkvCzuQ+sEieKz70ZI
	 zskre+Ffx3wepCYS23kgF56E08+2T1oxsYOS7yuikNba3cytB/koFcub/7QbwEWpVQ
	 qh8xVPX6MvPKWnSXpXPhAFZg8HzOJfK39FudvK7QEHpC0gJjID17u/inaQxZrC0Oc6
	 Cmf95G14SMvOuBU7JwoqFtMcZwIHxnFzcgD4zr9r/gwQX2ylV593pIPqs4tnPg8gE/
	 CD/Ti/qi8Ur7/yKI9cSusumJPDWVE1XgqOzIuNqkQYUqDFvFmKwdCV/57hRKkG94kT
	 j2SfoBlFuSzOg==
Date: Sun, 17 Aug 2025 15:30:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Qianfeng Rong <rongqianfeng@vivo.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: use min() to improve code
Message-ID: <20250817153035.1ed54fbf@jic23-huawei>
In-Reply-To: <f089d2fe-562f-46bf-aef2-f19302d3196e@baylibre.com>
References: <20250816120510.355835-1-rongqianfeng@vivo.com>
	<f089d2fe-562f-46bf-aef2-f19302d3196e@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 11:56:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/16/25 7:05 AM, Qianfeng Rong wrote:
> > Use min() to reduce code in inv_icm42600_buffer_update_fifo_period()
> > and inv_icm42600_buffer_update_watermark(), and improve readability.
> > 
> > Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> > ---  
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Applied with tweak to patch title to include inv_icm42600.
When people are deciding whether to look at a patch or not
having info on what driver it applies to is always useful.

Jonathan

