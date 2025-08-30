Return-Path: <linux-iio+bounces-23461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCEB3CB86
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 16:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7805E3375
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39326F2BF;
	Sat, 30 Aug 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzFYkpx9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB538FA3;
	Sat, 30 Aug 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756565605; cv=none; b=PCZhG6FVvIN2C4DFrj8OD50l0mNcvychUNARC14ruiGeEfeP0PVOz8VBX01YvwcLgAY9IX92PFqZ9sQnb40i1V7+1dp4LazaSoKmPctM95t9Y2NxddRe7EL4iLgqWIrcRdQ1JmJ6+tPHuiYZoNDCBgB3Ta4/OYWqiBd98//FF8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756565605; c=relaxed/simple;
	bh=ZGI3ES/mGeo2ukyUPRZDAld2k1FUL/oNk3MSAPoPwNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbhmZETiV8p7SIADQHDFS52DR4xUh60NOrI0aY2CqXz9LLCazrNLlu6TtcymGxYhH5QjtfYR8TSTUSmIy/xkDJvfuMM4WRPKrxd/AXjfKtY3bCwAwr0BRnkCPciGdvapwr7cC/sJO2lwhsE19uM+0FdGhZ/V/ND2hhfHzBa0Z/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzFYkpx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE9C4CEEB;
	Sat, 30 Aug 2025 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756565604;
	bh=ZGI3ES/mGeo2ukyUPRZDAld2k1FUL/oNk3MSAPoPwNw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HzFYkpx9zaD0wi9ITT8yDPS4hXugYhi4suRYRHot2KSEWITtPm4KWvuyvtER1GEl6
	 lCBhy/I31c5tSEtXvEYgfrGlQhrCXUA559vB1VjRSevbawtuxmBQMFRC0Tg9koP1JN
	 lV2sDHWZlLPl3/I+b/EkmDQrD5B9fWeZsf90y2HsUB9FspoHDigsnJ7eBb1NeBcrCD
	 emITPX0DczdJCwXzat6TL9cd1ZlX2mS5yIaT4itHUcyX042pypZ4SKdrfai043nwfY
	 q+t9Dl6bJWeJzcrqnMRUwja2sQslwcwjsMTajoQA+NY41QAEDKz5TTrfCJOKww38Mv
	 KpIM3U8NeuidA==
Date: Sat, 30 Aug 2025 15:53:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250830155314.70ea7d1b@jic23-huawei>
In-Reply-To: <CAFmh=S1KtqOa=4FRojE1ndttv_pFu2aLJwzGFbam1CJxoYtdgw@mail.gmail.com>
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
	<20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
	<aKXW5pGiN18DyIZ7@smile.fi.intel.com>
	<aKaMPMnGRyvKqTny@dixit>
	<CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com>
	<aKfYlP-yWdQi34db@dixit>
	<CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
	<20250825105032.45f33b12@jic23-huawei>
	<CAFmh=S1hdCMnWYzHsvTDb4C1vvinMCeG_=1m-N+psw5tp4nm7A@mail.gmail.com>
	<CAFmh=S1KtqOa=4FRojE1ndttv_pFu2aLJwzGFbam1CJxoYtdgw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Aug 2025 08:32:18 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> Jonathan, Andy,
> One more query, Do I need to update the MAINTAINERS file with this new
> entry as we are adding this new driver in this same patch series?
> 

That would be ideal.  Do it in steps to include only the files in each patch.

I never specifically push people to commit to maintain drivers unless
they are particularly complex (and hence I'd feel out of my depth reviewing
changes), but the ideal is indeed for people to agree to look after their
code and in particular test changes proposed by others.

Mostly people shouldn't be relying on MAINTAINERS for who to +CC anyway
as it will often miss the people most interested in a given driver so
this is more of a statement of intent than something I consider a practical
part of the upstream process!

Jonathan




