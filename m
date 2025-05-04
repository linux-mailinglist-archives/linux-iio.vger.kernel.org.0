Return-Path: <linux-iio+bounces-19061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D7AA886B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 19:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8526C3B4D47
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198641DED77;
	Sun,  4 May 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OO8czlnt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C983FA32;
	Sun,  4 May 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379337; cv=none; b=Sew36l1epkdvMMAnsaGK1fHQVdo0YOk0mcOFG2Ep5hyEirdWIEo+sn0AIKm/thAfJA8EL+lnUShGul0dNdVBaoIm66DG9PbztFXVuuOE2/W3gkB2cNp+lrTiyRav7jPEjVF12ir5r5B/xw2iYHEPDHyJdGfllaZEEDcpSxgOOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379337; c=relaxed/simple;
	bh=OwvrBnjaTxzXgXfw4YDawAL7+dm0wvIDFuO7EpPK8JY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5wVzRULWY22Kk9dCDNqE2Iog6huPm7o+f1GCP681uJWDvEkpddC20cDEOTcbT06GWrHuZmm8hEXsPPkh2LT+BUXkrwAL7RCX9HkehC9Wczz3+Jh23kBR1LMhh6GF9AEGNKV20Bz9BdthYPkPTBzFTA0ILaGulDedBE4VYjt3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OO8czlnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F62C4CEE7;
	Sun,  4 May 2025 17:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746379337;
	bh=OwvrBnjaTxzXgXfw4YDawAL7+dm0wvIDFuO7EpPK8JY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OO8czlntL2Qmw4cDAdJa/kF0nth0kjjowllgMa57ynDGfPgWh/EB6qbeZ51ylGfgg
	 nhxNRfvcjebb/euGaaaFO/2aJF5oRybPHWAvRigY0pjPOGR2egmhB4+KOPWSo4Jgxx
	 Q6RA5n9JZMU9GVaXd0/jhTRTKDfeQiDb3ZInmdjF/t9MDZeGPO0WNN0G6/s1kg4fBc
	 9YVUGdcNqLG0LFE+czNzRvwM6Vkl3PBK6zxiDIZSm+e0G5BSG9u9DaDOrPe6uRMmh5
	 W+6cTFh3w2CFgC3OuRxwpcjfTcduiXPNjDohLugIfvYnO5+bAmJwvkRUXjbipqQKfK
	 OgoyjSL6pi5Eg==
Date: Sun, 4 May 2025 18:22:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Eugen
 Hristev <eugen.hristev@linaro.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/7] iio: adc: ad4695: rename AD4695_MAX_VIN_CHANNELS
Message-ID: <20250504182207.33ffd560@jic23-huawei>
In-Reply-To: <0082078a-32ef-48cb-a181-c2d598ae29e6@baylibre.com>
References: <20250428-iio-introduce-iio_declare_buffer_with_ts-v4-0-6f7f6126f1cb@baylibre.com>
	<20250428-iio-introduce-iio_declare_buffer_with_ts-v4-4-6f7f6126f1cb@baylibre.com>
	<0082078a-32ef-48cb-a181-c2d598ae29e6@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 16:37:19 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> On 2025-04-28 16:23, David Lechner wrote:
> > Rename AD4695_MAX_CHANNELS to AD4695_MAX_VIN_CHANNELS. It has been a
> > point of confusion that this macro is only the voltage input channels
> > and not all channels.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>  
> Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> 

Drat. I was thinking I could pick up this as well.
Obviously I can't as it was after the one adding the code that is being
changed...

Ah well. I already picked up that other patch so I'll keep that.
If you send the next series with it in as well not a problem.

Thanks,

Jonathan

