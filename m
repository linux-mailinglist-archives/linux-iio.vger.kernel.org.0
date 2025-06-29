Return-Path: <linux-iio+bounces-21136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EECAECF9C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 20:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D75188EA81
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E78238D54;
	Sun, 29 Jun 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLpHLvUo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55A49625;
	Sun, 29 Jun 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751222326; cv=none; b=fb3VP2CC2KWwhrGZ6o8+KgkAg1z1jZPiBl3+q2XOoF4lDQwowvsW/utO7HLt3te8UWUc9y7HzYARv6d0ueDPP0+yPAbUL6ZMBDXMz0Q5iNTye9sbMQK2X0X+FOvtucB7Pi2uyFN5/1Q+An8BMD1hPRf13erFxCllupyLUGSL4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751222326; c=relaxed/simple;
	bh=91ntLfJPx4kOJYYPQGyGGQwYIjtSF5XzrErW6rcx1RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfE8rLIzBI3eJEAHMSUrZRTjC7VmPgIJ3Fwi9UBpTJIXEwXdQB11l/D4pnkfdBsLnuRplauswmhRx8WY/i7dExcuoWW53E0MOc8PQ0JpW1FuRodoqZgxRQhfHimImUA8i3V2wDZfGtpkuOvRMv6BLWwjjVWZovG3otGkAj8XFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLpHLvUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A12C4CEEB;
	Sun, 29 Jun 2025 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751222326;
	bh=91ntLfJPx4kOJYYPQGyGGQwYIjtSF5XzrErW6rcx1RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sLpHLvUouq5Q2t3eTDp4CLadoJkvG/5CNKxlGgrjTVYPHNalzY+fGpVYbaVBJB8n6
	 ZLq6nnl2vWLTp4258D8TYyntOaPKyhvMaKqOxD5NbQDokmNVJCmSuTboHkz5z2wGMb
	 54SmMRzvb3L8e33wFPwdR7Kv+7o1YWXzr/C8yE/fF/JrL9JRIpTuLqvHy+IEWVjUdy
	 L8SJ9QiWZe71GIr4gKKgLhzNf36YbhiV5ZcRIZA503r6BEe99d3QI4uEJLDKN0Mgm9
	 lxBsQR5ELn++eSpJAiw+ErRyu9v1qOKknffQ4C/HdYFw5u0jJd1qLW49Z+3pcioyBm
	 imsFV/F0sePVw==
Date: Sun, 29 Jun 2025 19:38:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7091r8: make ad7091r_init_info const
Message-ID: <20250629193840.7be2e033@jic23-huawei>
In-Reply-To: <aGGDNR0b0TTjSRNN@debian-BULLSEYE-live-builder-AMD64>
References: <20250628-iio-const-data-4-v1-1-4e0f93c9cf83@baylibre.com>
	<aGGDNR0b0TTjSRNN@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 15:17:25 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 06/28, David Lechner wrote:
> > Add const qualifier to struct ad7091r_init_info ad7091r*_init_info. This
> > is read-only data so it can be made const.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---  
> Acked-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Tags added. Thanks!

