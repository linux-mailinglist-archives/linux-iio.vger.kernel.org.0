Return-Path: <linux-iio+bounces-18431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DCAA9513E
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C60D3ACB06
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2F264FA6;
	Mon, 21 Apr 2025 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4ammwiN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4813C918;
	Mon, 21 Apr 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240148; cv=none; b=PJPSjdAMgtwbkiWpblxe9cQKpnf2sx2qSeNCJITdJkJ9Mjk3GXlxEkLG21UXTg9DZaH9JsGWLDwJ1FP2IdVRspeC3l4gh/dF/dml9KAwPk/9AJ+6NDqaCKKNZyTW5jICzySnd4HF37QEyZPGNYknfKOtCAcN33EDE+Hyjs4JILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240148; c=relaxed/simple;
	bh=k+pc9LVuTE8fyj/4cVMCmddanuSJQPnt8OKwJy/uQq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVZiZ90ZFACdKYaJ83yboH2l9lhdC+7VRYt7u2ZzpgCZxDfY0SCYrDugB2QT8cgvSGz8fz4j/g9qH4A+IzNbmYWuzTsy8fdRH1KiMwHFrLVGH4/GHNUEjbEquIbxT9gR7wRg51FL1rjX6Q4WuHKNe32IPXK+yG0ni+O3xEX/LFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4ammwiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9331C4CEE4;
	Mon, 21 Apr 2025 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745240147;
	bh=k+pc9LVuTE8fyj/4cVMCmddanuSJQPnt8OKwJy/uQq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D4ammwiNL647ISAcyJI72OgAdza43beGebxGW+WQ7qCu6ppDlrEM7xD/ay1Pr+jak
	 9oAZjmPSllW58bFoTO8eAFhrV8RXTR9fhP0FZB6pKIAj/ikCoNGX3ifoSLAvaN0r4c
	 j/tnIIpkBnNeGHDi1cxACOn7aP49Bt1Vsgz8cUNZAUiEyHAjQ9Tdur/q1/ZCe+dR4r
	 jq/TBI8YtcAsTK5SUVu84EYu81yM26IpH4vypERQ6O5ZhPdSfREUr1My4feD9kikIo
	 vPC0LQcKhtyAP2g6WtPkLGIMzrUZCeja4fsOyJknOXnD7hWVzAf9Wu700Jy8LgC9iE
	 svz3oPp8ZrVOw==
Date: Mon, 21 Apr 2025 13:55:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: bmp280: use
 IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20250421135540.1a667221@jic23-huawei>
In-Reply-To: <9cdb05b5-299c-472f-a582-13a7d1368f3b@baylibre.com>
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
	<20250418-iio-introduce-iio_declare_buffer_with_ts-v1-4-ee0c62a33a0f@baylibre.com>
	<aAPRuUZTWQZr9Y6H@smile.fi.intel.com>
	<9cdb05b5-299c-472f-a582-13a7d1368f3b@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Apr 2025 13:04:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/19/25 11:39 AM, Andy Shevchenko wrote:
> > On Fri, Apr 18, 2025 at 05:58:35PM -0500, David Lechner wrote:  
> >> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
> >> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
> >> and understand.
> >>
> >> The data type is changed so that we can drop the casts when the buffer
> >> is used.  
> > 
> > This one is good, with the comment to have it DMA aligned.
> > 
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >   
> 
> Strictly speaking, this one doesn't need to be DMA-safe. This buffer isn't
> passed to SPI or any other bus. It is just used for iio_push_to_buffers_with_ts()
> and has data copied to it from elsewhere just before that.


Silly question.  Why is it not just locally on the stack?  It's only 16 or 24 bytes...
I think that other than the bme280 we can use structures. (That one has 3 32bit channels)

So we can have the more readable form in all but one place in the driver.

Jonathan


