Return-Path: <linux-iio+bounces-16689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC5A5A3C4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C41F17334C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 19:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90981235371;
	Mon, 10 Mar 2025 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfVNPfHo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18D29D0B;
	Mon, 10 Mar 2025 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634831; cv=none; b=Y4+z1WlnYxRbgCLrrROumejqPqQoio7gCwf7heaOcc+ZSvya8YOYeTJ4dddhOwx9xjOSLe6dOvawiViKJcOcVdqA40UDfOZ8zp6oZGf0+57KNuXsxCGlY2gjUsDcWZuyoNiumIiPAt3oEHCzqGfB95zHFJkv7RCwHOTFePonEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634831; c=relaxed/simple;
	bh=u0YsDwdekmEB7s3qvj/8t6Dp0H9FJ7ryD3tXNIIGQJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSBz21R7ImcbovOngrKhyEe8fIzZZOlHdy0k0n/5PaMHvTP5XG+XEQg3Kfwce9XVrBOOQrDTitkB6ABc5NtpW9eZPqv52V52qQEeNCtZ9FGS5NzLDO8EyYWIWv13TQ2jDgX3hWRFilVcPsvSta8N9Jvk1V5aihWxXi/9F6QlIBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfVNPfHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81460C4CEE5;
	Mon, 10 Mar 2025 19:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741634830;
	bh=u0YsDwdekmEB7s3qvj/8t6Dp0H9FJ7ryD3tXNIIGQJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfVNPfHovCu4bJr65HN9fuwoAFJ7aouDJaohhaqkGxEFHq7ifJLinDG7q424ikxnf
	 kNdvMk38T2L1Q+JLMCR80ygoIcPgf+0bo6lCEcltMSzI9lhrfWegUXZzVV/hhqb0DP
	 IE446gzTYw30pG3d2GvCZ5NVgXNljRirSCYPi/0ODTC1UYBR06ehm61p0JQj8EXrI9
	 yzwBKjDVCFrupLBZPqh5omijDuaWLFyEkInq4K8roZPYYQnYNZNoNzoLfk8F/r5xL+
	 /K7WXpHjE0zEHaTKKBXg7ce6jBZCAAhNAwQkpRgx/To9I4uKYBsZYc0NXXIYWoTOJd
	 Q4s+o7lJjE/Vg==
Date: Mon, 10 Mar 2025 19:26:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Guillaume Stols
 <gstols@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, Trevor
 Gamblin <tgamblin@baylibre.com>, Matteo Martelli
 <matteomartelli3@gmail.com>, Alisa-Dariana Roman <alisadariana@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?Sm/Do28=?=
 Paulo =?UTF-8?B?R29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 07/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <20250310192621.6bcf4482@jic23-huawei>
In-Reply-To: <a6fcc1af-5fb8-48bd-8ed8-6fb16b1a5d4c@gmail.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
	<60a55e4027cf9335b37d4affc11d805a1504cab7.1740993491.git.mazziesaccount@gmail.com>
	<20250308164441.00f64ab2@jic23-huawei>
	<a6fcc1af-5fb8-48bd-8ed8-6fb16b1a5d4c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 10:46:45 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 08/03/2025 18:44, Jonathan Cameron wrote:
> > On Mon, 3 Mar 2025 13:33:39 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
> >> an automatic measurement mode, with an alarm interrupt for out-of-window
> >> measurements. The window is configurable for each channel.
> >>
> >> The I2C protocol for manual start of the measurement and data reading is
> >> somewhat peculiar. It requires the master to do clock stretching after
> >> sending the I2C slave-address until the slave has captured the data.
> >> Needless to say this is not well suopported by the I2C controllers.
> >>
> >> Thus the driver does not support the BD79124's manual measurement mode
> >> but implements the measurements using automatic measurement mode relying
> >> on the BD79124's ability of storing latest measurements into register.
> >>
> >> The driver does also support configuring the threshold events for
> >> detecting the out-of-window events.
> >>
> >> The BD79124 keeps asserting IRQ for as long as the measured voltage is
> >> out of the configured window. Thus the driver masks the received event
> >> for a fixed duration (1 second) when an event is handled. This prevents
> >> the user-space from choking on the events
> >>
> >> The ADC input pins can be also configured as general purpose outputs.
> >> Those pins which don't have corresponding ADC channel node in the
> >> device-tree will be controllable as GPO.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > Hi Matti
> > 
> > Just a few really trivial comments.  If all else in the
> > set was resolved I'd probably have applied with a tweak or two
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >>   obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> >> diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
> >> new file mode 100644
> >> index 000000000000..466c7decf8fc
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/rohm-bd79124.c
> >> @@ -0,0 +1,1108 @@  
> > ...
> >   
> >> +
> >> +/* Read-only regs */  
> > 
> > Given naming this is pretty obvious.
>  > I would drop the comment  
> 
> I will drop this, although I am not sure it is as self explatonary as 
> one thinks. I've seen people getting this wrong because the logic of 
> regmap-ranges is kind of reversed. (Eg, read-only is done by adding 
> range to wr_tables and not to rd_tables - as a no-range).
It's obvious in the structure naming + how it is used. I agree
the interface in general is non obvious.

Jonathan

> 
> Thanks for the review, and rest of the comments just agreed with.
> 
> -- Matti


