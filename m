Return-Path: <linux-iio+bounces-6066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307C9012DA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D72CEB2206D
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6B17B50A;
	Sat,  8 Jun 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqNLbxpN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B917B40C;
	Sat,  8 Jun 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865464; cv=none; b=Sg+6YwFynF7CXk3EgonE3Pjn8h4DyEpWw+1sL5b8NciaTazS3BYjzMNYPFbco3qG4TAUDSucF0GML6WygmWb0D3XnGXvZGVhh5/sB0yIc6aGqphDI6oSrkiwpDRCFQd4CNzFgn+rdL7HN6PGRbdTp4dNUyg5W5ndLSh5esdgAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865464; c=relaxed/simple;
	bh=IQ90R2FuFOLtL9zURwpn4VJSVHRr+OodPaTn8siTP2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eqHloIFpdVf/L/rDuR6A3jeRQZoTUs6tubOtCQ/Au6ojd2V5QYWFOb29LGvtIlJIjdy+7ozrq/Vby9dIvToy6nLsTw2bAqbQmTyIJyzAExIuLMd3UW6oYamhD9kIbepX62MPzOKGF11WC9FLTmXvWpioJ9ITLA7PLaEKYhlM3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqNLbxpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019B3C2BD11;
	Sat,  8 Jun 2024 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865463;
	bh=IQ90R2FuFOLtL9zURwpn4VJSVHRr+OodPaTn8siTP2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LqNLbxpNyiivJAreM2nEUIoquuXv5sjatX+kYef9Crz8YapA7pk3FH1VY5wIeQleq
	 rejPvZsPW0vaYtmKi+lDV12vFEPHt09oxGhdiiQADSZojfYS24slGNT71hybzjLvzF
	 AEB/YTYWb4c0H6mYRzcUnK/ORKZltpCy2BBjciRPVRs2uen0ujHRDAF824QceEbISZ
	 HGiFhBgcijNFV3fyamb+/famUWgQMaJZxbaa7Szrsr7oLPYCtLEbMm2jgEx+nvgbNt
	 j8Gh4aje0oiMDBJkoa4Ru2ez5sKO7fK1QUJgTul76HSCb/fYFhSnh2f0etvrgqGNYT
	 /SudlxK0SaYGw==
Date: Sat, 8 Jun 2024 17:50:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v4 0/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <20240608175055.3d089acb@jic23-huawei>
In-Reply-To: <SN7PR12MB8101204CE811B8E88A2464CCA4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <SN7PR12MB8101204CE811B8E88A2464CCA4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 19:41:36 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
> v4:
> - Removed hardware-irrelevant properties from dt-bindings, retaining only channel configuration
>   related `channel-positive` and `channel-negative`. Grouped by channel. 
>   Retained `channel-in-use` as it is hardware-related.
> - Removed redundant register definitions.
> - Reorganized `struct hx9023s_data`, extracting channel-related attributes 
>   into a new `struct hx9023s_ch_data`.
> - Optimized bit operation related code.
> - Replaced `of_` versions with generic firmware parsing functions.
> - Fixed other issues mentioned in the email feedback.
> 
> Link: https://lore.kernel.org/linux-iio/20240602152638.2c674930@jic23-huawei/

Hi Yasin,

Please fix your patch threading if possible. If it's corporate email getting in
the way, take a look at the b4 tool. It has a nice trick of being able to use
a web gateway and that tends to get out of almost all company networks.

Jonathan

> 
> Yasin Lee (2):
>   dt-bindings:iio:proximity: Add hx9023s binding
>   iio:proximity:hx9023s: Add TYHX HX9023S sensor driver
> 
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml  |  103 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  drivers/iio/proximity/Kconfig                 |   14 +
>  drivers/iio/proximity/Makefile                |    1 +
>  drivers/iio/proximity/hx9023s.c               | 1162 +++++++++++++++++
>  5 files changed, 1282 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>  create mode 100644 drivers/iio/proximity/hx9023s.c
> 


