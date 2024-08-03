Return-Path: <linux-iio+bounces-8189-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FB946959
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AAB282445
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5672C14EC52;
	Sat,  3 Aug 2024 11:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYdgGArd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880C13699B;
	Sat,  3 Aug 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682851; cv=none; b=Ez0TZLq/tLquFJaqZfS2jGEzQmHl7l9ym6O2d4IJn+ny+uYeMAfW/GE1h8n9ON0MKRK/9VOqf5a2AfAMP7joca+OnIsdDkDcYmVy/Vmo1rP/PPh1UEBvH4+ggFtmeT90NPChK9zLlMJpQjmhnRNvWZxG2SNu3/SNOOubnk8BJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682851; c=relaxed/simple;
	bh=jWRHY9OFgxkUzSjNicxratgtZtD89ZZxW3vWQiIEkqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzVb5zPnG7xgQFTKXdbiCqldPMh2u1UUWKpO9q5Mti3F/6TAM741B9RaZ3tDRwVvHrRlundngUbt2szDftLbTciu4WiOpWwVn4vx1m3imSIYccYRWdpbe6NfMgT+et5XXvu3waHeCfcIP7lOwmu7nvEo5GvCwnD1qu1hRl720PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYdgGArd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B546DC116B1;
	Sat,  3 Aug 2024 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722682850;
	bh=jWRHY9OFgxkUzSjNicxratgtZtD89ZZxW3vWQiIEkqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jYdgGArdruf9JkqJwBvoNFOwzp9XHH6vFvos0UBjWjjCKej9KYYJblewp9WM4Dsda
	 3qV2YZA9WjXmAev00mFy8+2PC15InsvF72hgBRLvpR6XAOEFPlLZCGCxzsO5Jypwml
	 OcUAac9octvKb6R5csrld57oVFSSTLs6P6+aPvlGFPOVq30w3SasDg55j0zZ6N+SIV
	 rtmV8VDcA+QfuDcR/GDU60SqMPbIq/L7F78s8WSDX+QHk3vrH0JH2YrJ+Uzpy9gE+r
	 bDSfNziNOQvCls18UfS2XmIjRR3wIEic0UHNZzoKWt8WwQV8nhZhAl5/A97SBYWzRK
	 FYrbO9sC65c4g==
Date: Sat, 3 Aug 2024 12:00:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, quentin.schulz@free-electrons.com,
 mripard@kernel.org, tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 12/15] iio: adc: axp20x_adc: add support for AXP717
 ADC
Message-ID: <20240803120041.27cec4e5@jic23-huawei>
In-Reply-To: <20240802192026.446344-13-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
	<20240802192026.446344-13-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 14:20:23 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the AXP717 ADC. The AXP717 differs from other ADCs
> in this series by utilizing a 14 bit ADC for all channels (a full 16
> bits with the first 2 digits reserved). It also differs by lacking a
> battery discharge current channel.
> 
> Note that while the current charge channel itself is included in this
> driver for the AXP717 and listed in the datasheet, no scale or offset
> was given for this channel. For now no scale or offset is provided in
> this driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
This one is dependent on the mfd header changes in the previous patch.
As such, either I need a tag to pull with that patch on it, or Lee
can just pick up this as well through MFD. If he does that.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

