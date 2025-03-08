Return-Path: <linux-iio+bounces-16571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B1CA57BF7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2401890B0A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E311DE4E7;
	Sat,  8 Mar 2025 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIu04DLx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F361C14A8B;
	Sat,  8 Mar 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451615; cv=none; b=XyCsFemgK8hOwQcfb8K3JWFe3ZQA2R9iRuQ7m1Vz8L+7BT8PG+3UoAqq+JojKnwvUchgQ/i7+JSzdvKqMbe25DIb9ot/z6diXzBL8g6kxaBns8oXzzSQBWGzyEppnnXh9OOQE7/f3xCIHHTUKgkBcsW2O9Fw0Fsi34SUGkJ/whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451615; c=relaxed/simple;
	bh=tM7Z1MIuoa/H4YwFnFknjGiGKPNlBmSaJxIzbb0eGDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMRiVSE9afdyidq5wY9Axfy17Y+X0iXOtihOhpiAg1AEAgS83dtqG26sLEYALSO0XO+w/PAP1EJr7o8lQTLEX5o3J6OWBK05exkGnxq+32NWVoOFA+D3YOT5K4y0k2TeH+X86enFbcN7Y0SdmKVJQ6ZYC95ODR59HIIa07pOpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIu04DLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1470CC4CEE7;
	Sat,  8 Mar 2025 16:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741451614;
	bh=tM7Z1MIuoa/H4YwFnFknjGiGKPNlBmSaJxIzbb0eGDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MIu04DLxZwEmwBIzWaHbgfhISn6yiqjivHJe03p3ZKnFn36PELOhRqaddAcbavYqc
	 8M5Z1otxTkuT4q9P8zRv2VFQwnZ8QG8LBBV+QKzgriwyaXHEe6lJ0BfzOjG4fYckid
	 Z8nhQgdPfL3bc3vHutkwuE0uOtojmi1mWMNlViuCmVDsP8+M5vjbfCHZ3AnIVeZi63
	 22SPJbPNZWX81dhjMpifa5ryLTvFs6vz37u3DAKvgw96kl6GGCqYiHGW+6Sk2LLMF0
	 1lJNgha7B6z6S55T5eqNfUPPmyzPojD5NeRnesvnI2Iamha3jFVmliqjFjYBnEdsA7
	 pozWP3Mn3VT4w==
Date: Sat, 8 Mar 2025 16:33:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Guillaume Stols
 <gstols@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru
 Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 04/10] iio: adc: rzg2l_adc: Use adc-helpers
Message-ID: <20250308163322.63d6e053@jic23-huawei>
In-Reply-To: <f8d2e21c7c4948453a42f1edcd3621d2c20871c5.1740993491.git.mazziesaccount@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<f8d2e21c7c4948453a42f1edcd3621d2c20871c5.1740993491.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Mar 2025 13:32:29 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
> drivers avoid open-coding the for_each_node -loop for getting the
> channel IDs. The helper provides standard way to detect the ADC channel
> nodes (by the node name), and a standard way to convert the "reg"
> -propereties to channel identification numbers, used in the struct
spell check: properties

> iio_chan_spec. Furthermore, the helper can optionally check the found
> channel IDs are smaller than given maximum. This is useful for callers
> which later use the IDs for example for indexing a channel data array.
> 
> The original driver treated all found child nodes as channel nodes. The
> new helper requires channel nodes to be named channel[@N]. This should
> help avoid problems with devices which may contain also other but ADC
> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
> string didn't reveal any in-tree .dts with channel nodes named
> otherwise. Also, same grep shows all the .dts seem to have channel IDs
> between 0..num of channels.
> 
> Use the new helper.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Code looks good to me.

J

