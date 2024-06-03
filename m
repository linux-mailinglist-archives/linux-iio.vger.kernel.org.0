Return-Path: <linux-iio+bounces-5709-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA148D8A2F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 21:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 363D428D52B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 19:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C87913A252;
	Mon,  3 Jun 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7RReSKb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4791F13C3F0;
	Mon,  3 Jun 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442860; cv=none; b=WkvFLuSyMvncGE/eowTNDTFq1a8l8HyLGyyjWzlsZn0zmTVuFZv9dR6/lol2VrboyKrkbula/X2UzmknmzVYzd2Mp7RFca+6ZvT6OR0JHjkQKd2GZ8h7HjjnWKyaipR/tC2m6vR1rAsi5Z074UT6WBnITRbyDAw1Nb6nJoXenkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442860; c=relaxed/simple;
	bh=3Zln+JEWRzCLjJqeE+QHq6lHIRgWozx2/elNB/ZIlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jgjxf+CQ/MoBKuudocslk5sKFUbT4gKLkFTXWK0hfjVhtA+nbh9qxQVwJrfk0kCvxYsxAK2cQwDmmRLrr7vxM7NKiwRmN+ozyphQpxYHGWszGsGldtZ9/8aRh/SPQNOkoL3Aw0iSwO3OhYEBKd1P7MoM6eU+i18l800LN1OAZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7RReSKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E89C2BD10;
	Mon,  3 Jun 2024 19:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717442860;
	bh=3Zln+JEWRzCLjJqeE+QHq6lHIRgWozx2/elNB/ZIlFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7RReSKb6hSqdk4Y9AmOd5gUqefWdVL9sG8ZD2R22R7OCNldeT9cCEaEC0wL0xF/c
	 z08G5pNFlRrAlWANQv50Vufa5m76dZG14AxuBraihm9Hmk+e/SFAASMmJUpU8Tj0+A
	 NECDm3qLVFc9w6qBQ2tFTovmZBjwaPB9oRKHNxY5iLRlpLGK8Id+G0icCdORmI73Ui
	 pb2QdeccF57XzQe3Ih9PSO20/ka9SKhMemLdj5KHRLJZtNIOwkMLZb5dFnWh6TARBZ
	 Oz8KnbCflo2yVZtD1rRjyLSkjGRowUyI3V+UewMrtEUA7tLKP2Mvd3K9x98zSD5khQ
	 BMn0WxopdXNPg==
Date: Mon, 3 Jun 2024 20:27:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 13/17] iio: chemical: bme680: Add read buffers in DMA
 safe region
Message-ID: <20240603202730.7ce99cbf@jic23-huawei>
In-Reply-To: <20240602193310.GE387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
	<20240527183805.311501-14-vassilisamir@gmail.com>
	<20240602135908.7e4183a2@jic23-huawei>
	<20240602193310.GE387181@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 21:33:10 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sun, Jun 02, 2024 at 01:59:08PM +0100, Jonathan Cameron wrote:
> > On Mon, 27 May 2024 20:38:01 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > Move the buffers that are used in order to read data from the
> > > device in a DMA-safe region. Also create defines for the number
> > > of bytes that are being read from the device and don't use
> > > magic numbers.
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > 
> > Same response as previous.  I don't think it's necessary because
> > of the custom regmap implementation.
> > 
> > My first instinct was the same as yours though!
> > 
> > Jonathan
> > 
> >   
> Well, even if we end up not needing it, I would keep the values inside
> the union just becasue it saves some space, and it keeps all the read
> buffers in the same place. What do you think?
> 
Sure. The union is fine as long as you have made sure there can't be
concurrent access to the different members. It will save space on x86_64
at least as that has very low IIO_DMA_MINALIGN.  Less likely to make
a difference on arm64.

