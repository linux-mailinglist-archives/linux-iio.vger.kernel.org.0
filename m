Return-Path: <linux-iio+bounces-565-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8AE803152
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA04F1F20F16
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2007722EE7;
	Mon,  4 Dec 2023 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLM5rjvN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000E1F958;
	Mon,  4 Dec 2023 11:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF42C433C7;
	Mon,  4 Dec 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701688411;
	bh=2XwAfycpniLMpRRkj1AgYd2OQFR+IEoJXGRydmgWEi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YLM5rjvN1jPGsWFMxXxmje2pnLmddvDWNL6ATspD1unuAomA9abDtfaqjvT6qmAcM
	 EPHHtHaSq50ecLXorduQaxF8XHDYdIZR7FF4z4mNGXe794BjxhwwbqyCumx2G5Kgba
	 BZjTgV/JX5aR0LztCWkDttofFGGpPGRDh34RxjhAL5ac8a82DbvkgWY2hG6jCUT+ld
	 Zh3l0AJwIjcAH7ymezzVabhjcHGebkwEJvtpQWeU/AAay3YJUoRr1zRDAtYAFVPBlx
	 5C7alsiZntbDpHB3CRKoWcpikSYTyj7RYJ3WZRavmND4RNh9wj5fnvRrzH+BNBCHYW
	 ZAND8adsPKi2Q==
Date: Mon, 4 Dec 2023 11:13:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-iio@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231204111317.22c679ed@jic23-huawei>
In-Reply-To: <00a21ed4-18b5-4aca-8dd6-628d475664e7@denx.de>
References: <20231125222738.97875-1-marex@denx.de>
	<20231125222738.97875-2-marex@denx.de>
	<20231126181655.4e1040f9@jic23-huawei>
	<9e73c450-2380-459a-9b41-a1b88f89548c@denx.de>
	<20231201181721.0000445c@Huawei.com>
	<00a21ed4-18b5-4aca-8dd6-628d475664e7@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Dec 2023 07:48:12 +0100
Marek Vasut <marex@denx.de> wrote:

> On 12/1/23 19:17, Jonathan Cameron wrote:
> > On Sun, 26 Nov 2023 23:09:36 +0100
> > Marek Vasut <marex@denx.de> wrote:
> >   
> >> On 11/26/23 19:16, Jonathan Cameron wrote:  
> >>> On Sat, 25 Nov 2023 23:26:23 +0100
> >>> Marek Vasut <marex@denx.de> wrote:
> >>>      
> >>>> The ISL76682 is very basic ALS which only supports ALS or IR mode
> >>>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> >>>> other fancy functionality.
> >>>>
> >>>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>  
> >>>
> >>> Hi Marek,
> >>>
> >>> One last question + a comment in general. Act on that if you like.
> >>>
> >>> Thanks,
> >>>
> >>> Jonathan
> >>>
> >>>      
> >>>> +static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };  
> >>>
> >>> Why have an available attribute for a single value. Is it useful for anything?  
> >>
> >> To report it to userspace, iio-sensor-proxy uses that to control the ALS
> >> poll interval .  
> > 
> > It should use integration_time, not the associated available attribute.  
> 
> So, what should I do with this feedback ?
> 
> I did send the V6 already, so shall I change anything in V7 ?

I'll reply there.  Just noticed some other oddities around available.

