Return-Path: <linux-iio+bounces-6405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D1D90B8E7
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2B91C23F3D
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14091990AA;
	Mon, 17 Jun 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I22R8FkN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFE198E8C;
	Mon, 17 Jun 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647328; cv=none; b=cGnafcWw/gMx4k93EpMK62ZMyh7n7Q/jgNqoT+vjpm7xGm0zYXYK359858bnxckXSdNT7NFZyKnl3a9gt+fu59gW50oUgwcJlrshmAg6O2wK/dgg+U/3uFuNZi6xh9rx6rosLQ86OhzG9QcYHbG/J6HhJ9yxfNqydZV4K8ScKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647328; c=relaxed/simple;
	bh=M3co0EInn47sdoKGm4tMK0K3C1uhfyTbKrXGz4Is+Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/dIczGepe8ueKnPqcPeCDXJQvokv5EcOU9EG+DM2pEdYl3fSlP6Ee7B5H4d3pzcKnTy9FGJ4AUAJv31EOEBAaQ1gI69cM9UG7D2sGKVd5xGqZAWyHy6XpQ/LOh3ide/iIdrv7UhIH28Q57dteXxP7t7Cn4ToW9dmPuTNwOpd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I22R8FkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853D4C2BD10;
	Mon, 17 Jun 2024 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718647328;
	bh=M3co0EInn47sdoKGm4tMK0K3C1uhfyTbKrXGz4Is+Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I22R8FkNp7vS20SyGPDdyyagwlwFbf0jFEz+zcjPkvD7uURwponuqmfN9KICyRYg9
	 5V0XGU+9KL/rfRolCJYN6iUWuSmB0+PV4lpycd8YaxxNwWdl2HVHQZIN4Kb3A49tzR
	 7JObdzn84rwIZbEQGm7yGRlEPP4c8UFREJLjskbb5TXJS1hus0biXRzspLFdm4gKop
	 RnQhQNaxAteCcRFE1MEbjsGCc5h36SGwD71x0ehIaQ+7Ni/a0ihGqnIMJGypBAtJXz
	 SxyGpYECGEFnB3VCnCevYrJ6V2TOlg78vq4SWNb8icZA4Hk30H3VLgun3mSI4zQqBj
	 tt8/z7qvPIbrw==
Date: Mon, 17 Jun 2024 19:02:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 0/9] Add support for AD411x
Message-ID: <20240617190200.3123ac50@jic23-huawei>
In-Reply-To: <20240613193056.3fa3804c@jic23-huawei>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
	<20240608173720.29ee4aee@jic23-huawei>
	<20240613193056.3fa3804c@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 19:30:56 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 8 Jun 2024 17:37:20 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 07 Jun 2024 17:53:06 +0300
> > Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:
> >   
> > > This patch series adds support for the Analog Devices AD4111, AD4112,
> > >  AD4114, AD4115, AD4116 within the existing AD7173 driver.    
> > 
> > Looks good to me.  However given you had lots of good review and
> > it was a Friday afternoon posting, I'm not going to pick it up until
> > Nuno and David have had a day or two to take a look if they want to
> > (and hopefully add a few more tags! :)
> > 
> > If I seem to have lost it (rarely happens now I use patchwork to track
> > things) feel free to give me a poke.
> > 
> > Thanks,  
> Ah - I forgot we have a dependency on a fix that went the quick path.
> As a result I'll have to hold this until after a 1st pull request.
> 
> Whilst the merge resolution is trivial i need to do a pull anyway
> to resolve a more complex one.  Hence let's take the easy but
> slightly slower path for this as well.
> 
Now all sorted, so applied to the togreg branch of iio.git.

I'm not sure if I'll rebase that tree or not as I have one more
set of dependent fixes for another driver that didn't quite
make it yet, so don't base on it for now!

Jonathan

> Jonathan
> > 
> > Jonathan
> >   
> 
> 


