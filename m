Return-Path: <linux-iio+bounces-14237-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D04A0AAD2
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDF03A27F3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0561BD9CF;
	Sun, 12 Jan 2025 16:24:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AC20DF4
	for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736699077; cv=none; b=m22LdR479u5d0LD08E9/WKqKxarbtpCY/+VLMMEnFPxOdi9O8BCCXRGW3OnaJP5QjyfCtMKyxPMWrBMEbQUlqDlYFj0RC1rlcyi2/iLJ/lMbZzos3J1/RPKpQHggt182FiKka/cVP/JisHcrYZ9fMbl6UR+1S11kduJjWzDP+Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736699077; c=relaxed/simple;
	bh=+p4jNxJ8zfT2wA9gPKIik40wwUIwNsHUh6f/py5gT/8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7B0p05nK/ScZEyYZ+eeUpKY5FdrzMg1LqmozkotzyJsN1a9RKOaKxUnX1fN4TsoU+0rU7Kzq7Ks7mUBA2l+rtI5JN+KMvCoiv2qTlrOU8cgWI3shGLGcWnAeUO+aZDBCGAoOw/FsFiNBlTbCnScMNjyHbnyn3AzgJNz9jYZ7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id b358fcd4-d101-11ef-a20f-005056bdfda7;
	Sun, 12 Jan 2025 18:24:30 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 12 Jan 2025 18:24:30 +0200
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
Message-ID: <Z4PsvnP8QTDLXHYf@surfacebook.localdomain>
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
 <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
 <20241208181531.47997ab4@jic23-huawei>
 <97fd092da34bcdcf0a7f79c6079a04ce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97fd092da34bcdcf0a7f79c6079a04ce@gmail.com>

Mon, Dec 09, 2024 at 11:39:55AM +0100, Matteo Martelli kirjoitti:
> On Sun, 8 Dec 2024 18:15:31 +0000, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Mon, 02 Dec 2024 16:11:08 +0100
> > Matteo Martelli <matteomartelli3@gmail.com> wrote:
> > 
> > > During channel configuration, the iio-mux driver allocates a page with
> > > devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> > > buffer points to an offset of the page due to the devres header sitting
> > > at the beginning of the allocated area. This leads to failure in the
> > > provider driver when sysfs_emit* helpers are used to format the ext_info
> > > attributes.
> > > 
> > > Switch to plain kzalloc version. The devres version is not strictly
> > > necessary as the buffer is only accessed during the channel
> > > configuration phase. Rely on __free cleanup to deallocate the buffer.
> > > Also, move the ext_info handling into a new function to have the page
> > > buffer definition and assignment in one statement as suggested by
> > > cleanup documentation.
> > > 
> > > Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> > This seems fine to me, but the diff ended up a bit complex, so I'd like
> > Peter to take a look as well before I apply it.
> 
> For a simpler diff I could go for devm_get_free_pages()+devm_free_pages(),
> but since devres doesn't seem necessary in this case, I think this patch
> provides a cleaner solution at the end.

I am here just to ask why we don't use get_free_page() or analogue to begin
with, but it seems the thread has a remark WRT this.

> > Do you have a board that is hitting this?  If so, a fixes tag is definitely
> > appropriate. I think it is probably appropriate even it not.
> 
> I am not sure if any existing board is affected as I encountered this
> issue while experimenting with consumer drivers, thus using a custom DT
> on top of sun50i-a64-pine64.dts just for testing. The following DT files
> might be affected but only if the iio channel controlled by the iio_mux
> multiplexer owns an ext_info attribute which is also exposed on sysfs.
> 
> $ grep -Rl 'io-channel-mux' arch

Btw, `git grep ...` is _much_ faster.

	git grep -lw io-channel-mux -- arch/

and won't give unrelated lines (e.g., *.dtb).

> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
> arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> arch/arm/boot/dts/microchip/at91-tse850-3.dts
> arch/arm/boot/dts/microchip/at91-natte.dtsi
> arch/arm64/boot/dts/rockchip/rk3566-powkiddy-rk2023.dtsi
> arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg353x.dtsi
> arch/arm64/boot/dts/rockchip/rk3566-anbernic-rg503.dts
> arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
> arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dtb
> arch/arm64/boot/dts/allwinner/sun50i-h700-anbernic-rg35xx-h.dts

-- 
With Best Regards,
Andy Shevchenko



