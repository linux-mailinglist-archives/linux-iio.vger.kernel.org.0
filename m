Return-Path: <linux-iio+bounces-4721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3A8B8ADE
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399FA1F23065
	for <lists+linux-iio@lfdr.de>; Wed,  1 May 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02212D768;
	Wed,  1 May 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vjLf3jiP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535112D1E7;
	Wed,  1 May 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568582; cv=none; b=kKPvFLg5c9gxFIZECqOrNUMlVq4GbP697n8AVWHNvFs4OP7vgPXmlC7+22lt59CTvTBWUpOsW2a0StT90r9DTZjGlh452+/D3O5mSvLCfbQqG9+pK7sk/oftBTbajitOsii8lZ0kPbIFG/+r4NiShmK4KeUlpcwbf12qE5Lu2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568582; c=relaxed/simple;
	bh=lzJp2NXHPzUCkDajnK19TMX5KLpwnWIpKybzM/55eLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyTWFwx9RX5l5JyaNQQQdsgLf7HjIEGwes//7OGaTz1msvXTC3VPp+vToBGllO5J1YTWJTy48hZM0VCA9lSmrl1UHyoQDlEQcya8WbXJVZRtMS21/og7z0FqqaEVf8dXPus1A7SO581L5qkCS2evoyZfTvVXpMk0dzS/p/C6QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vjLf3jiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C4FC113CC;
	Wed,  1 May 2024 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714568582;
	bh=lzJp2NXHPzUCkDajnK19TMX5KLpwnWIpKybzM/55eLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vjLf3jiPEoJiudO8I5DfGewwqN/l/YekhAsFjQU0mC2A0RtH1rayns3ZvauXDJyJP
	 s/725UJU9kuuODNrUbSsGD2I0v8wNc5sIUXS6PAPF/eUZOwie6PTU52fAUQEczJ8WH
	 Ep9yLI0gutNNxTw4UX3NdlQ2k+UtYw7ZChtbkL24=
Date: Wed, 1 May 2024 09:02:57 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Petar Stoykov <pd.pstoykov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Angel Iglesias <ang.iglesiasg@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: Add driver for Sensirion SDP500
Message-ID: <20240501-grinning-rustling-limpet-b3b69a@lemur>
References: <CADFWO8EQUkGcbE=RXjxXbub2tZge9+ss=gB-Q6wngFAvwFygRg@mail.gmail.com>
 <ZjEQ8LBxftcr0Z0t@smile.fi.intel.com>
 <CADFWO8HL_pwEQwYn0K9AkPV=HZyWN3NSOs8k4dRrB40w_1KdCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADFWO8HL_pwEQwYn0K9AkPV=HZyWN3NSOs8k4dRrB40w_1KdCw@mail.gmail.com>

On Wed, May 01, 2024 at 01:48:24PM GMT, Petar Stoykov wrote:
> I finally figured it out. Gmail has a hard word-wrap at 80 characters 
> per line.  At first I thought it was word-wrap on the receiving side 
> but I was wrong. I will try to convince IT to change things so I can 
> use b4 or git send e-mail. If that doesn't work then I guess my code 
> will have shorter lines in next patch.

With b4, you can send via the web submission endpoint:
https://b4.docs.kernel.org/en/stable-0.13.y/contributor/send.html

-K

