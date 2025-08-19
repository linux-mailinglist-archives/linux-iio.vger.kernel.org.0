Return-Path: <linux-iio+bounces-23008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F48B2CBC2
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 20:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA631B689F4
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1F30E0EB;
	Tue, 19 Aug 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7D1lgO2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8322157F;
	Tue, 19 Aug 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627655; cv=none; b=cta6WN8C3JKW+eG/4AdLelwwUg7rnKgtN6sZ/MadhrgNlkPeaVImPgogXkDDoNqPZ/wTg4poDUSJ6o9UEgCAzDI8kk364beHwmusBSghsgFHIjI4eOGxsaDuOpeu3SH5mIvEAB0wreYlAFokydXNcOvCPVTbr1XWpM7rJsnxqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627655; c=relaxed/simple;
	bh=2cSizdNtjP8nEgtp+IapxXa32stuAUieeQxXIGSwPUU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXkDnKhOoa50zijiOBh+rtNbouP/hzxrR2lT7Q3htB6B8iW/aUKwixA17N9APjqSQ7b9OV6uho4eVaL3/Pu3/CImPIZapZFV2eixLRd7ESHm1VHVmwphq45cUWAjO5fU42yThcrVXczf2iLyKkDnyXZIdKGBeBMbIy7RUH8yv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7D1lgO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7900DC4CEF1;
	Tue, 19 Aug 2025 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755627654;
	bh=2cSizdNtjP8nEgtp+IapxXa32stuAUieeQxXIGSwPUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7D1lgO2eg4XrgnMtog+GfhMNIpn9vKbsx3UMCOH8azpQShGLofbiy+EtVcU2jLFr
	 LGWGDd4l2kjIfh+YtTGQj9BujZrpssd14QkF9tySCaxpuxZGIY+ZxNnxTBRzYK0PCj
	 e/TJIJVI43hF0VdTuRBVNjOv/AxIwgrxEuXym1ixXTmkZ5BU6HzVyV4XnICfbq+sms
	 pIm2JrnrUG9snmjoKK+u8CVxSVU8HDmNzbypEzBv6pmC19ry4fXpgwtf+UfExhZRrv
	 8fySciPmKyFrIEzPNFKJSv2vuvwICnnDyBFpSVZoU9MF0I1nHgSI2ZF2+r8MLW5ZK4
	 51nll0JknadmA==
Date: Tue, 19 Aug 2025 19:20:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Salah Triki <salah.triki@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Drop unnecessary
 dev_set_drvdata() call
Message-ID: <20250819192044.5637c96b@jic23-huawei>
In-Reply-To: <f7815955-7e8a-4f67-b699-8b19cb38683a@baylibre.com>
References: <aKSRpTuwA0P-ZaUS@pc>
	<f7815955-7e8a-4f67-b699-8b19cb38683a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 10:05:09 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/19/25 10:00 AM, Salah Triki wrote:
> > Remove the call to `dev_set_drvdata()` and the associated comment
> > since private data is never read.
> > 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---
> > Changes in v2 :  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

Applied, thanks!

This motivated to do my periodic can I drop this driver yet check
against my usual rule of once it's obsolete from the supplier and
no significant work on the driver (staging only I'm less keen to remove
drives in good condition!)
Unfortunately 7817 which it supports is still in production :(
I then checked the other drivers still there and they all cover production
parts as well.

This is a pretty simple device and probably a good target for someone
who wants to try their first driver. It would be a near rewrite as this
code is miles off ABI wise.

Doesn't look like there is a currently available dev board, but it's
available in a TSSOP and will run on wide range of voltages so not
a challenge for someone to give a go on a break out board.

Just thought I'd mention that and see if anyone jumped on it ;)

Jonathan

p.s. One day I'll just decide to delete all the remaining staging drivers.
     Analog folk, they are all yours!  I can't blame any of you though
     as I think the first stuff from Michael was the following year.
  

