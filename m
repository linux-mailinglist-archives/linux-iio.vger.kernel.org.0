Return-Path: <linux-iio+bounces-13233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB09E86D2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3A518856AD
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3379C18754F;
	Sun,  8 Dec 2024 16:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqWLOjol"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF120323;
	Sun,  8 Dec 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677192; cv=none; b=W9mIdOQZ8izQPEBYfiUoR18nZaQPD1OOzG8HZAl4oNeskxwqtW5hKhZRJg3xVUtRsuIBCZu7/rleXllDi2XZ2Tu/07lNUwoImM1JCQJA1vtWTbTTpjBkZSDVAY/weKjOnrTSfHSOJdS4nierh9dUPzm/SebTPKEDoSgXdHtczv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677192; c=relaxed/simple;
	bh=o5+e4VKhCq8v7S94ioflyoTxDxaWLCbTsckcliIW1kI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSJjeBOJ9IkkZ4rmdXyerQo4n8aAJTCaI4X88VvCKImmf4C5Q+GlU/Xy0glLLzuGF4ZJUSJoIXC0NjFiWPErRGWok3vqwl1BgEfjlbdUDWUPApid2NNdyj3uGdN9SOZrtCKrMhAlgwxQ6Pns0ppBYqdtZVMjHIGlyrJ3/UnzGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqWLOjol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731C0C4CED2;
	Sun,  8 Dec 2024 16:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677191;
	bh=o5+e4VKhCq8v7S94ioflyoTxDxaWLCbTsckcliIW1kI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqWLOjolkrK48OCPgW3J+QmuJ3pwD3uXNseiCQNPA3QtPc3y5/XL5joyja5lrSGXD
	 bOfh6N1CWnIuX8U89uDuSmXavhOZlX0bH3AzLpYcbmoDi2gtyXjaabp+zVW4O8Z/gL
	 UvrugHCW2taNQ5l3+YCFREbR1fqXrMtG7onHNAV1QcPM23fJicxKnJglKHIFe7fK6d
	 F9FX6YmtWzroswGYYVNL4Ny3Ny21U0RbXUdmqb8Pxbw7SWxRZXgT5RAX+dg8Xxqr8i
	 5RWoL+cKjnM87kjjmxtU+hD2Zzcn4uH8923xPzerHkAXwd74XvOwpVD5qA0Mu3yu95
	 PiofOPPxuOXYA==
Date: Sun, 8 Dec 2024 16:59:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <jpaulo.silvagoncalves@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>, =?UTF-8?B?Sm/Do28=?= Paulo
 =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: fix sample size in scan struct
 for triggered buffer
Message-ID: <20241208165944.1ca1d08b@jic23-huawei>
In-Reply-To: <20241202194622.GA70146@francesco-nb>
References: <20241202-ti-ads1119_s16_chan-v1-1-fafe3136dc90@gmail.com>
	<20241202194622.GA70146@francesco-nb>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 20:46:22 +0100
Francesco Dolcini <francesco@dolcini.it> wrote:

> On Mon, Dec 02, 2024 at 08:18:44PM +0100, Javier Carrasco wrote:
> > This device returns signed, 16-bit samples as stated in its datasheet
> > (see 8.5.2 Data Format). That is in line with the scan_type definition
> > for the IIO_VOLTAGE channel, but 'unsigned int' is being used to read
> > and push the data to userspace.
> > 
> > Given that the size of that type depends on the architecture (at least
> > 2 bytes to store values up to 65535, but its actual size is often 4
> > bytes), use the 's16' type to provide the same structure in all cases.
> > 
> > Fixes: a9306887eba4 ("iio: adc: ti-ads1119: Add driver")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: stable@vger.kernel.org
> 
> Thanks,
> Francesco
> 

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

