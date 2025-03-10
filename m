Return-Path: <linux-iio+bounces-16702-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB8BA5A4DE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 21:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC601890EBE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767941DDA31;
	Mon, 10 Mar 2025 20:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ff962vS6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CFEC5;
	Mon, 10 Mar 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638241; cv=none; b=dmFr6ZEktJBXgWgWyF27eOxhkEDcER4PVwy+7yTdEyOTXSl7y+GMdftGzkIt4b0DgIC7iW0bMFU2ATFYHq0t+3EMjYO/nTk5CIu5tn1tGxM1txyrHrZMVd4fefAVS1e7fzJE+DrCcSZeN96YJjg0etoJ24icwfranEEKJ/6DzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638241; c=relaxed/simple;
	bh=sq3tp2C/z+PwR1TZ4bdV2KWewzPYR6PQ99UJocfqnhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPA2M/q/69xsWdPTHM45M+2Nf0S1LiBdUajn36WKfdkMCLa1ysV4kMubhUbJFWrEox5xJA4OqTfnwZ08ZQNe14RtnGEH9KqxiFTqcxm2mjGa+SX+2y+xNigHLTywnp1TNOS0eatjTlbHr3mPZiI7Egg/V4uH8wB5D+6AgnSj0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ff962vS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01D8C4CEE5;
	Mon, 10 Mar 2025 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741638240;
	bh=sq3tp2C/z+PwR1TZ4bdV2KWewzPYR6PQ99UJocfqnhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ff962vS6QLSAGYunnX6sNMVzzr1ezNh9RHM592d2Bjc7ulYjOhc8oA01HDJFZYO2V
	 GIhh8bBhajxZv+CvRx/XyaXuc5qGlIIkPSsev35FKBD5V3B0g2NaVN2Fg1YnPw1wQH
	 uimYPoPykKlP40bykArBTzA3Lla7Mj4iC+emSM+KRUzPZaN0ZVsS4mW5Vj+m4AT0OV
	 xd5BbxBwZ4M4IHxNPUvkrxxEQ98L5zrcmpG41cyQdXdX3939vU6Qbnxy8srLWQTloA
	 45vM3UBGzmp5rJPJlkBwPa14UfTDRGARyEH6dirnwVWzqvLTY0JMOpR9qKQFAyTlgq
	 k3AnZu79BZ25g==
Date: Mon, 10 Mar 2025 20:23:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Javier
 Carrasco <javier.carrasco.cruz@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Guillaume Stols <gstols@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v6 05/10] iio: adc: sun20i-gpadc: Use adc-helpers
Message-ID: <20250310202350.043d1c34@jic23-huawei>
In-Reply-To: <06e8f4f84731df9fc5d6f324e74fbd1bf83a81d5.1741610847.git.mazziesaccount@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
	<06e8f4f84731df9fc5d6f324e74fbd1bf83a81d5.1741610847.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 14:56:35 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
here as well.  I'd have just fixed these up if applying but seeing as
you seem to be heading for a v7, good to tidy these up in that!

