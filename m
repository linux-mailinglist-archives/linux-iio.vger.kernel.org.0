Return-Path: <linux-iio+bounces-568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5A9803184
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 12:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E93B20A1F
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019D22EFC;
	Mon,  4 Dec 2023 11:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzkV13ib"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B441D68C;
	Mon,  4 Dec 2023 11:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE2FC433C7;
	Mon,  4 Dec 2023 11:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701689392;
	bh=DfNuJgPfPENEAIqUb1gRE0TPB0Y1VtlLKLaXhDQ6j1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bzkV13ibuaNtcWYt3Xai6u1IULy/6JVdFXKVClrrkhVK/pD4aT2gXNmYxdg+RY+GT
	 DLnWeIU7l6ro09cioMZETrMhRvSBBnc/m6OS80Y2+Mts2LUffOIhYCL16G/3SlgLKr
	 aYVoaGPB7DraMgaceGPSZKuGY7RFcByM3XuCCO2z8vaxedq4I2wYZmLuO2mrFVNMWN
	 uhVuo+16zL51beRC/2ZNkWlOTBFCksWgv334pAkgryrwKizfPm37e7gcXfHf3dFD2T
	 bgs7c9/4AcDm1dt4FcDjKjQ+ERa30c5DaUn30SKbtq/qowSTiacTwSjAcvb64brgB7
	 wDCsAA+RsqXEg==
Date: Mon, 4 Dec 2023 11:29:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko
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
Subject: Re: [PATCH v6 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231204112941.770e22cb@jic23-huawei>
In-Reply-To: <20231127212726.77707-2-marex@denx.de>
References: <20231127212726.77707-1-marex@denx.de>
	<20231127212726.77707-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 22:26:53 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Marek Vasut <marex@denx.de>

There is a additional question on what scale means for
an IR channel.  There aren't any well defined units (as it depends
on the sensitivity curve) so in general we avoid providing scale
for intensity readings.

The datasheet has a vague go at working around this problem by
using counts relative to IR measurement in daylight which would
measure 210 LUX.  (via faking that with a 850nm green led??)

That's far from a standard..

We do have precedence of scale applied to intensity channels
so I guess the ship has sailed.

Perhaps we should just add an explicit not to the ABI docs
to cover that changing the scale in these sensors will result
in the counts changing, but multiplying raw by scale isn't going
to give any sensible units.

So probably not a thing to fix in this series, but to address
separately.

Jonathan


