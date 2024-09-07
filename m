Return-Path: <linux-iio+bounces-9282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DC9702BF
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3FF283C96
	for <lists+linux-iio@lfdr.de>; Sat,  7 Sep 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A4E15C133;
	Sat,  7 Sep 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OApkqQ7W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FBDDF53
	for <linux-iio@vger.kernel.org>; Sat,  7 Sep 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725719739; cv=none; b=UJSh71IbdUR/SgtitCsu/7Chx5GekVeYnkL4LwvsR49S7rVu8ENibZXSK63mhKLWOnizyjSr8u6UNBdyrOZm7cKyml2a12BqLAEtsM28e02KM7bQVV/f9tYUhtpqIzpnS0abY5sx1qvdNHIeRJAx6RNdFjFHLMXEZeDtSDAA+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725719739; c=relaxed/simple;
	bh=PKO9WvyKNFHUdowuPc+tlIVPPAMO4oL/RNNLCbPS9TA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fa/UL6G2+yAmty1ye4Y8bRreApV8mjmvU4d1cjYM/FRntNK/e4foliu15MZmPvnUAIgIC4OdRXtsftVFix/R6iZ15etlH4D/G2WGIJi33MiBi6FYr9ATHsbyvD4AS7QMQUFwJ8UqiIsA0olKigJ7XePhEsfo2Oj2Lc2TFppvdao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OApkqQ7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF126C4CEC2;
	Sat,  7 Sep 2024 14:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725719739;
	bh=PKO9WvyKNFHUdowuPc+tlIVPPAMO4oL/RNNLCbPS9TA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OApkqQ7WtMISWt9Az8VfE5ZP7yg1MSkfnyM1e0VZWs7xdRjK8jAw9VYVwGqECLH4t
	 /HiLExiov+DMxGmhRBS5nifMfg4O5aI6F8cnsCvdUkl9/qyz9aFuRJAFxH0PNKo100
	 /xO7hfmbLMKisu/ogmYPTDlMZSuHeCGuvSO8ml2HwXBxouyDflVdHM3HJp7gL8yjRa
	 EZS4qccei2dQieAZz31sSKzXgBjUnH1drgqNCDH4pJ0gRij2YmycTZnQG6aq+te7xa
	 fUr9Jwoe5r/JdA/Hd4RS8IqQ/jch0RdmMVjFo3WDIcHG5kgWx5UdDLZW0WEvIuMk/s
	 /6jTfAoZgbFfg==
Date: Sat, 7 Sep 2024 15:35:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Sean Nyekjaer <sean@geanix.com>, Marek Vasut <marex@denx.de>, Denis Ciocca
 <denis.ciocca@st.com>, Rui Miguel Silva <rui.silva@linaro.org>, Linus
 Walleij <linus.walleij@linaro.org>, Danila Tikhonov <danila@jiaxyga.com>,
 Jagath Jog J <jagathjog1996@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/15] IIO: use irq_get_trigger_type() instead of
 opencoding.
Message-ID: <20240907153532.396d10eb@jic23-huawei>
In-Reply-To: <ZtWmP76X95AWb4Xd@smile.fi.intel.com>
References: <20240901135950.797396-1-jic23@kernel.org>
	<ZtWmP76X95AWb4Xd@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Sep 2024 14:49:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Sep 01, 2024 at 02:59:35PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Andy pointed out in a review that there is an irq_get_trigger_type()
> > helper that first gets the irq data then extracts the type from it.
> > This saves on opencoding those two steps when the irq data isn't used
> > for anything else.
> > 
> > Update all the sites this pattern occurs in IIO to use the helper.
> > In a few cases there will be a slightly different error message is
> > somehow there is a valid irq number passed to this call and it doesn't
> > have the data associated with it.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There are some nit-picks, up to you how to proceed with them (only one seems
> better to address is where the reversed xmas tree ordering is broken).
> 
I made the changes suggested.  Applied to the togreg branch of iio.git.

I think these will probably wait for next cycle now given timing.

Jonathan



