Return-Path: <linux-iio+bounces-10204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91074991914
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24DD1C212E7
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D4E158A3D;
	Sat,  5 Oct 2024 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0E7f0ys"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46841509A5;
	Sat,  5 Oct 2024 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150934; cv=none; b=PejmkidBSL0oOK+OVtDGWwiYZc2rD9U3kaP8imzpabiXJMc2qP5L+oY7r1a5qSl7aFOyLpcYbQUnk/fuWH4sOKTdOM0AMymm9VTo5itAT2SMCiGn9BQlsRI3pcpiAsct1DUvsYoGYIirmndYRmhOPL4qL7K8TvmVgRpbxUMSK2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150934; c=relaxed/simple;
	bh=/WXx31hwcqZxhppF0dnTXBqbKpKH5Fk6ydOfZoKtnLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7vmAICjGvLTmbcafg/ga/Vhq5MxCBBue1VWm96/S+Sb5uN8UjQLqGxLt9BAAnH7xUe9/xMgvpjAJf2nAcXdwnepT/a8u3Ygt1+2CMKOMtc+8bjZyteaqZLRBjUiPlI5tgY0z/gNKrR4+/ERsANruU258uu0V7Cxc3KKHqwPp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0E7f0ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE5C4CEC2;
	Sat,  5 Oct 2024 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150933;
	bh=/WXx31hwcqZxhppF0dnTXBqbKpKH5Fk6ydOfZoKtnLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O0E7f0ysVhJkaqJQjRID/2ubB4acE/xRhxaIKb4kyFugu2MJAogNOjb7aAMIRecJy
	 JYBrpRzLpOsaOYCzarHN6wW+rHCZFNBdPH4WMh0ezVXP680JrPy0muCSR47JCF/I8D
	 O0p9wfusD5B+2FHfn/+WxCWZ6+zzr8w2JSg3srxQrXuPIpRH7w+cN01gHCj1lWRnk9
	 ejptcubeXCSIVzgL8+fW3ZrSDztgwOZZ2ItfrEr/p7wwph6kY7zVdx5JgFpOEEhP8S
	 zz8wjzFMM5h/J5tnaf85CGWgynF+4V/zN1TjmeVChEBO2CxgqM+ZZO5w8shHe/PoS/
	 2a3sfVtUxB2qw==
Date: Sat, 5 Oct 2024 18:54:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Dan Murphy
 <dmurphy@ti.com>, Sean Nyekjaer <sean@geanix.com>, Leonard =?UTF-8?B?R8O2?=
 =?UTF-8?B?aHJz?= <l.goehrs@pengutronix.de>, Mihail Chindris
 <mihail.chindris@analog.com>, Alexandru Ardelean <ardeleanalex@gmail.com>,
 Shoji Keita <awaittrot@shjk.jp>, Andrey Skvortsov
 <andrej.skvortzov@gmail.com>, Dalton Durst <dalton@ubports.com>, Icenowy
 Zheng <icenowy@aosc.io>, Andreas Klinger <ak@it-klinger.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH 09/13] iio: chemical: ens160: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005185457.182fb76c@jic23-huawei>
In-Reply-To: <xb4kbwrxm3j3mt7mciuzx3r6ilkb4j7sa3djkzcvwrutx3m6em@gp7bc4kq7jmd>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-9-67c0385197cd@gmail.com>
	<xb4kbwrxm3j3mt7mciuzx3r6ilkb4j7sa3djkzcvwrutx3m6em@gp7bc4kq7jmd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Oct 2024 11:27:49 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Thu, Oct 03, 2024 at 11:04:55PM +0200, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: 0fc26596b4b3 ("iio: chemical: ens160: add triggered buffer support")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Gustavo Silva
> <gustavograzs@gmail.com>
Applied



