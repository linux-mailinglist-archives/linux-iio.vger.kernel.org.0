Return-Path: <linux-iio+bounces-10199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24550991901
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45001F223A6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663C156F54;
	Sat,  5 Oct 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1UXzcfF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0E288B1;
	Sat,  5 Oct 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150528; cv=none; b=TtOKT45bVWuZFN2b0ml/EI/krVX/5ebWKvZC8TJg7CVSXlod7ot95jtHp1H6na24NF0cM3ocvaZb8piRzEY6rVDpJDKaX1M3c2oEKoqDxMX4mFDGXTVsm3k1zUZsiSdPBjUThJTSR9ZJFBWOOAA/0Gs57j5ZLRZpTdfdkIcqeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150528; c=relaxed/simple;
	bh=1LFesxxKyR8BoagOqn3tNd4fxrlCLVYfpC7EXHphq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjN+wq1djmWo7zqgYKE+QC47SIOIvREKrpa9rFCBtk4bWDNA+aiKINC/9sCaQzmegV+6C7ZNileNF34cmPKLfzqXKQOsqCifxfmbsP9+Y3yJl/oRtosNNr6kCwwOi09Z1tlZVAwitJ3yfzau9Xn+fntuBC3r/FCRLxDGrjdTb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1UXzcfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69843C4CEC7;
	Sat,  5 Oct 2024 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728150527;
	bh=1LFesxxKyR8BoagOqn3tNd4fxrlCLVYfpC7EXHphq8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r1UXzcfFZEPsySDZYS/WHN7jBrGd0mGipLL2uZdesPAh4UIgszq8KafqvpaQ0LPFO
	 5BK5TFI0+PXb8IQd7OpgvhAWYEtN9HnDu180j1rtx2Hq2eCNPnbzwoH/stev9qBcg5
	 gLSAms8l5yBQizcUKVFEdag6UwtkGBp6GVDD4tLfqA8Zps7I9+aT9zrvQ7m6f2D8jY
	 LHhrUSnF+LbESN5FRheEUxd3oukUT9iE4RhZ6KC/84rIqt4rIqAw4D2fPqfaBdMdY5
	 viE0Y6nJOoeLRLLCIT+++ghC8rKQwlOZ6rAI/ZY08SeVeRov0lau96FUuqq2Ptq668
	 jgj3o7T9dfLJQ==
Date: Sat, 5 Oct 2024 18:48:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Matti Vaittinen <mazziesaccount@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
 <nuno.sa@analog.com>, Dan Murphy <dmurphy@ti.com>, Sean Nyekjaer
 <sean@geanix.com>, Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
 Mihail Chindris <mihail.chindris@analog.com>, Alexandru Ardelean
 <ardeleanalex@gmail.com>, Gustavo Silva <gustavograzs@gmail.com>, Shoji
 Keita <awaittrot@shjk.jp>, Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Dalton Durst <dalton@ubports.com>, Icenowy Zheng <icenowy@aosc.io>, Andreas
 Klinger <ak@it-klinger.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ondrej Jirman
 <megi@xff.cz>
Subject: Re: [PATCH 02/13] iio: adc: ad7944: add missing select
 IIO_(TRIGGERED_)BUFFER in Kconfig
Message-ID: <20241005184824.1362b4fc@jic23-huawei>
In-Reply-To: <28972c88-e5ee-4cc9-8d66-b69897d45b79@baylibre.com>
References: <20241003-iio-select-v1-0-67c0385197cd@gmail.com>
	<20241003-iio-select-v1-2-67c0385197cd@gmail.com>
	<28972c88-e5ee-4cc9-8d66-b69897d45b79@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 18:00:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/3/24 4:04 PM, Javier Carrasco wrote:
> > This driver makes use of triggered buffers, but does not select the
> > required modules.
> > 
> > Add the missing 'select IIO_BUFFER' and 'select IIO_TRIGGERED_BUFFER'.
> > 
> > Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the fixes-togreg branch of iio.git.

Thanks,

J

