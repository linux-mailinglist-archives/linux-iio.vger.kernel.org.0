Return-Path: <linux-iio+bounces-14760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38825A24190
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207EB3A8D12
	for <lists+linux-iio@lfdr.de>; Fri, 31 Jan 2025 17:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3FA1EE7AA;
	Fri, 31 Jan 2025 17:08:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C138DF9;
	Fri, 31 Jan 2025 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343329; cv=none; b=V675m2urY6McWg4s7ljM8HXv/s+feqZ5B/BVlWb3nPR1oWB5y/tsNl0il9RDg990RFOKU+KJPA/WaxmJ9En3iuFvlgs7KBxE2MipdsMndBPxmyJAzVWGCf90xC2yvzpTw9jT0YVNY/zren7pxFQxDc21XDx5Jol2r58Tas/4ZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343329; c=relaxed/simple;
	bh=Y8ImXzlCUjlB9AJ/DzPvVM9Gkb1YQs/9eU3B7isU8AI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHJ2kK49kmA0R15kS3fP179/8Dt3xSViqp2mbUbjdMhgOovUQ2o4ryQmCOoubtvxKoY2fS+Pk9QgHdkDuy0RxH3zFtUE6tQj+dERP4fuwfIFCzYbbS8bM7Ln/pg9vjEXfvcp5inznBpJwupGE8vfOhQKAgAt1GgX2dLm3Mo0NW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yl2QT1c7Bz6K8L9;
	Sat,  1 Feb 2025 01:08:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 523981400C8;
	Sat,  1 Feb 2025 01:08:43 +0800 (CST)
Received: from localhost (10.195.244.178) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 31 Jan
 2025 18:08:42 +0100
Date: Fri, 31 Jan 2025 17:08:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lee Jones
	<lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
	<linus.walleij@linaro.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
	<dlechner@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>, "Trevor
 Gamblin" <tgamblin@baylibre.com>, Matteo Martelli
	<matteomartelli3@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Support ROHM BD79124 ADC/GPO
Message-ID: <20250131170840.00002dc8@huawei.com>
In-Reply-To: <cover.1738328714.git.mazziesaccount@gmail.com>
References: <cover.1738328714.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 31 Jan 2025 15:34:43 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BD79124 ADC.
> 
> Quite usual stuff. 12-bit, 8-channel ADC with threshold monitoring.
> 
> Except that:
>  - each ADC input pin can be configured as a general purpose output.
>  - manually starting an ADC conversion and reading the result would
>    require the I2C _master_ to do clock stretching(!) for the duration
>    of the conversion... Let's just say this is not well supported.
>  - IC supports 'autonomous measurement mode' and storing latest results
>    to the result registers. This mode is used by the driver due to the
>    "peculiar" I2C when doing manual reads.
> 
> I sent this as an RFC because I implemented the pin purposing (GPO/ADC)
> using pinmux - which I've never done for upstream stuff before. Hence
> it's better to ask if this makes sense, or if there is better way to go.
> Anyways, resulted drivers spread to 3 subsystems (MFD, pinctrl and IIO)
In principle nothing against pin mux for this.
There are other options though if pin mux ends up being too complex.

- provide ADC channels in the binding channel@x etc.
Anything else is freely available as a GPIO.
Normal GPIO bindings etc for those.

The channel bit is common on SoC ADC anyway where we don't want to
expose channels that aren't wired out.

For combined ADC GPIO chips we normally don't bother with an MFD.
Just host the gpio driver in the ADC one unless there is a strong
reasons someone will put this down for GPIO usage only.

> 
> Furthermore, the GPO functionality has not been (properly) tested. I'll
> do more testing for v2 if this pinmux approach is appropriate.
> 
> Furthermore, because the ADC uses this continuous autonomous measuring,
> and because the IC keeps producing new 'out of window' IRQs if
> measurements are out of window - the driver disables the event when
> sending one. This prevents generating storm of events, but it also
> requires users to reconfigure / re-enable an event if they wish to
> continue monitoring after receiving one. Again I am not sure if this is
> the best way to handle such HW - so better to ask for an opinion than a
> nose bleed, right? Maybe the next version will no longer be a RFC :)

Oddly I thought we had ABI for this but not finding it.
We basically want a thing that lets us say don't allow a repeat event
for X seconds. Then we set a timer and reenable the interrupt after that
time.  I think there are drivers doing this but can't find one right
now :(  It's close to _timeout used for gesture detection.

> 
> ---
> 
> Matti Vaittinen (5):
>   dt-bindings: ROHM BD79124 ADC/GPO
>   mfd: Add ROHM BD79124 ADC/GPO
>   iio: adc: Support ROHM BD79124 ADC
>   pinctrl: Support ROHM BD79124 pinmux / GPO
>   MAINTAINERS: Add ROHM BD79124 ADC/GPO
> 
>  .../devicetree/bindings/mfd/rohm,bd79124.yaml | 111 +++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/rohm-bd79124-adc.c            | 890 ++++++++++++++++++
>  drivers/mfd/Kconfig                           |  12 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/rohm-bd79124.c                    | 165 ++++
>  drivers/pinctrl/Kconfig                       |  11 +
>  drivers/pinctrl/Makefile                      |   1 +
>  drivers/pinctrl/pinctrl-bd79124.c             | 276 ++++++
>  include/linux/mfd/rohm-bd79124.h              |  32 +
>  12 files changed, 1518 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd79124.yaml
>  create mode 100644 drivers/iio/adc/rohm-bd79124-adc.c
>  create mode 100644 drivers/mfd/rohm-bd79124.c
>  create mode 100644 drivers/pinctrl/pinctrl-bd79124.c
>  create mode 100644 include/linux/mfd/rohm-bd79124.h
> 
> 
> base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532


