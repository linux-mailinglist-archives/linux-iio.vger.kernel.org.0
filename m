Return-Path: <linux-iio+bounces-14245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B467AA0AAEF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A19188647E
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC41BE23E;
	Sun, 12 Jan 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ88gTcp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1421BBBEB;
	Sun, 12 Jan 2025 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699767; cv=none; b=ptOQdRgjdoqPneLAJy7KLoNyBcHhuz1PRGFJ6OLYdp+fIx8gWD8PeRamEpMWGvHue5n9eLz6yzLSvKbHIa7m7SLy3KurWdwAPJuuA+3xtQYEcv/D1aUhcdE5nk2HS69jAHr+0GUfP9QFUNPF9nk177CeNGVFL1cVSfmO0ZODCSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699767; c=relaxed/simple;
	bh=kXRiNh/HGnx3bdLgmlw2FpmET53uVMo04AeuA+mpw5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C13JbUCD8QgEv80HygFsjQ54xoiewk0Siacrs0HgcZ+NV9VcTSqry7VhEZDA0cdvyHVHlAd8NZu0cDpuJ88ldmQUTCung53pRH+ETsJMPYgQFcHdBDNVuUq69AalVUKgBAyRPb9nSMngEWODr/m20RtT2JLjbn1rMZYQ/BArxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ88gTcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621ABC4CEDF;
	Sun, 12 Jan 2025 16:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736699767;
	bh=kXRiNh/HGnx3bdLgmlw2FpmET53uVMo04AeuA+mpw5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQ88gTcpVFdDxsem1k66eF9I0OD7Zt1CRlg9D8Xcl1k+/B27z8l75IQv/pTrHcjnA
	 +T7eGeqxmj9M08hjv16iZZrt/I9r0oLkfQSVaBrfjmJ9INo0a2KsE9IYxzLCxIYiMA
	 3vaqY+RKSv4W020zeoK+2xS6YMio6dLWJyFhPyaicPvgA5yPFSdQjlX+X57oJF3aHs
	 4rK/xWFhwiHUBwLxtSok6+UZ130j0KF1ZsPEX5pNlJ0iPowQrfkc/wQOGhRxNx0SBk
	 GGWkRzgjf16mqW9J1hPJ1jvO47CDjYLc5Wg3nwIlhmYhUg8GxxHtrw+o6BbIYnKJA9
	 zH9L6tKqke1hA==
Date: Sun, 12 Jan 2025 16:35:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Matteo Martelli <matteomartelli3@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
Message-ID: <20250112163559.741eba67@jic23-huawei>
In-Reply-To: <Z4PsvnP8QTDLXHYf@surfacebook.localdomain>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
	<20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
	<20241208181531.47997ab4@jic23-huawei>
	<97fd092da34bcdcf0a7f79c6079a04ce@gmail.com>
	<Z4PsvnP8QTDLXHYf@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Jan 2025 18:24:30 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Mon, Dec 09, 2024 at 11:39:55AM +0100, Matteo Martelli kirjoitti:
> > On Sun, 8 Dec 2024 18:15:31 +0000, Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Mon, 02 Dec 2024 16:11:08 +0100
> > > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > >   
> > > > During channel configuration, the iio-mux driver allocates a page with
> > > > devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> > > > buffer points to an offset of the page due to the devres header sitting
> > > > at the beginning of the allocated area. This leads to failure in the
> > > > provider driver when sysfs_emit* helpers are used to format the ext_info
> > > > attributes.
> > > > 
> > > > Switch to plain kzalloc version. The devres version is not strictly
> > > > necessary as the buffer is only accessed during the channel
> > > > configuration phase. Rely on __free cleanup to deallocate the buffer.
> > > > Also, move the ext_info handling into a new function to have the page
> > > > buffer definition and assignment in one statement as suggested by
> > > > cleanup documentation.
> > > > 
> > > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>  
> > > This seems fine to me, but the diff ended up a bit complex, so I'd like
> > > Peter to take a look as well before I apply it.  
> > 
> > For a simpler diff I could go for devm_get_free_pages()+devm_free_pages(),
> > but since devres doesn't seem necessary in this case, I think this patch
> > provides a cleaner solution at the end.  
> 
> I am here just to ask why we don't use get_free_page() or analogue to begin
> with, but it seems the thread has a remark WRT this.
This patch has now gone upstream, but a follow up to switch to
get_free_page() would be fine as a cleanup.

I just wanted to land the fix reasonably quickly rather than waiting
for the perfect answer.

Jonathan

> 
> > > Do you have a board that is hitting this?  If so, a fixes tag is definitely
> > > appropriate. I think it is probably appropriate even it not.  
> > 
> > I am not sure if any existing board is affected as I encountered this
> > issue while experimenting with consumer drivers, thus using a custom DT
> > on top of sun50i-a64-pine64.dts just for testing. The following DT files
> > might be affected but only if the iio channel controlled by the iio_mux
> > multiplexer owns an ext_info attribute which is also exposed on sysfs.
> > 
> > $ grep -Rl 'io-channel-mux' arch  
> 
> Btw, `git grep ...` is _much_ faster.
> 
> 	git grep -lw io-channel-mux -- arch/
> 
> and won't give unrelated lines (e.g., *.dtb).
> 
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> > arch/arm/boot/dts/microchip/at91-tse850-3.dts
> > arch/arm/boot/dts/microchip/at91-natte.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rk2023.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353x.dtsi
> > arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dts
> > arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
> > arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dtb
> > arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts  
> 


