Return-Path: <linux-iio+bounces-7983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FF293DFEC
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687562814DA
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F116817F4F5;
	Sat, 27 Jul 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwWb6Iok"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3D67D40D;
	Sat, 27 Jul 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722093495; cv=none; b=q9kLGvKORYDU8rbgUJ/p1za37gHLXRxxO89EFc5kfemvQ9Y3bcnRaed8YXa7kPoqi7ouCTIjLFvfKMWu1AlqlKy58P0dyR1TzbfLF+E51rDO5S4mFT7zBakA6Uu63Yp5S2i6CZKaRxt8XzrXehrJenVvLEXXGm8zcye84w23gyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722093495; c=relaxed/simple;
	bh=btTXuTbKagMwME/+aT4QIdnx1STO462E7hNfPKzYr9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqY7Vfq7KM2WHqMi390khrQxekbLTzxD0kyAFx3wp7tEnye4MjCISSS0MhppufDE4h7oEetH1GvPGeJNa3T2+k2tVGd7NaufnSTqR8GtZj4au1ga639ntri3O9EuypqL18Jegov0zbF89kmiABVg0jGUwKf8+vogTa12Qnk2SGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwWb6Iok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020CEC32781;
	Sat, 27 Jul 2024 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722093495;
	bh=btTXuTbKagMwME/+aT4QIdnx1STO462E7hNfPKzYr9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwWb6IokZ6x+KiUdMLBFFzH5bTIgIUOhbHLYmgPtqKqSvjD++YbXyE3mKkTzo1UB0
	 qXHnYbbVQqDdlwwjjsOLDKBDDMbtdv6xVggktIKZumGVCnkrbdIHvIJTdHG6SFWPz9
	 +Z/IgS1ewdY6g4/LEBHXdVCr6LR+uKb0FNYs6yQDHb8OwgB/smDmlXhd6J78bY0a4U
	 IjvRor3eXGNlVkfV0qlpLWkXQwm5AqTu+tlaMKfG6Cg6RBw1x6Fh36gFMe4AuNPs3R
	 oXXm5KLqET20wOyznQeQ+H+2dXGq8k15OcO+b/B0ZN/lSun+IlomL9OA674jX6g9O6
	 ROa0ZiAtwpHJg==
Date: Sat, 27 Jul 2024 16:18:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/9] iio: adc: stm32-dfsdm: adopt generic channels
 bindings
Message-ID: <20240727161806.18286978@jic23-huawei>
In-Reply-To: <20240724153639.803263-8-olivier.moysan@foss.st.com>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
	<20240724153639.803263-8-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 17:36:35 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Move to generic channels binding to ease new backend framework adoption
> and prepare the convergence with MDF IP support on STM32MP2 SoC family.
> 
> Legacy binding:
> DFSDM is an IIO channel consumer.
> SD modulator is an IIO channels provider.
> The channel phandles are provided in DT through io-channels property
> and channel indexes through st,adc-channels property.
> 
> New binding:
> DFSDM is an IIO channel provider.
> The channel indexes are given by reg property in channel child node.
> 
> This new binding is intended to be used with SD modulator IIO backends.
> It does not support SD modulator legacy IIO devices.
> The st,adc-channels property presence is used to discriminate
> between legacy and backend bindings.
> 
> The support of the DFSDM legacy channels and SD modulator IIO devices
> is kept for backward compatibility.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Hi Olivier,

At some point it would be good to use dev_err_probe() though out all the
probe only paths.
It might save you quite a few lines of code and print nicer error messages.

Otherwise LGTM

Thanks,

Jonathan


