Return-Path: <linux-iio+bounces-8008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D993E8A2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 18:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C2B216B7
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49F53804;
	Sun, 28 Jul 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFfN+Uz9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E955A35;
	Sun, 28 Jul 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722184655; cv=none; b=MlbcwEcOEgxvagR4g+J8UJn8l20WW43zaZGl79Ooy4RqfZxGxdUpSCibbGlFDQFJvBAsb4FafC8rWWkKkUXib6O3ZXutFFRfy7r7QA8x2wkAwKYDaeU1+Gm7AsMi1NECmoqLL6kPbFZj2uuvwCpQ/m3nyY3sbN6LUzEwuVdBM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722184655; c=relaxed/simple;
	bh=ZIIHf+HwBIHRbom7T8jcOcH7zIjW/YploDXNxkI/jxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHmtiJ2Xd7DLAt6jG+dMdfU6lPujUIJcE1KoCgpTWdw6JnKdpHQJ1NsuO0XpcB08vxsqWEtEtp3xAgyYQ7AY7y9j4Dtd/ZEiLEjRCVe+gJKJGk08UC9/yTiJQeog3sjAFZ6OlB61YylO/vUn//2ulxzyXqbaCupefkFhvK0MsI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFfN+Uz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B25CC116B1;
	Sun, 28 Jul 2024 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722184654;
	bh=ZIIHf+HwBIHRbom7T8jcOcH7zIjW/YploDXNxkI/jxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lFfN+Uz90m/oAmvHUgbe5h8IlyqbbrDPC39jgTE3wmO2Xqpsw1AYiD0+AKLiBi5Rx
	 RSTCrPHgMxOl8tQAN7cFk9c24t6J0ESXojkVAmsdO2yI8ANDVKIL6y7+i5WPy++9b4
	 NJQUgr7mSDOCSiqVvau46e8GxDa/mb3OIeesawUb1IQ/EIEzqlTOIxhB2d3ufbl7qE
	 ub4XclWf/2oTPqubnf9cNbAkIKJvEGplu0z39SGx6+NXnHBQnj+vEkNtbdoYqzkYtQ
	 cDOh0QW2rERW2mqaKmG3Bshn86Fstm2jEsZCfHbXj3KORaWUfSC89b1RoP14y3IF9X
	 METthFbf2KV3w==
Date: Sun, 28 Jul 2024 17:37:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/5] docs: iio: ad7380: add support for single-ended
 parts
Message-ID: <20240728173725.45043f11@jic23-huawei>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-5-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
	<20240726-ad7380-add-single-ended-chips-v1-5-2d628b60ccd1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jul 2024 17:20:10 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> The AD7380 family has some compatible single-ended chips: AD7386/7/8(-4).
> These single-ended chips have a  2:1 multiplexer in front of each ADC.
> They also include additional configuration registers that allow for either
> manual selection or automatic switching (sequencer mode), of the
> multiplexer inputs. Add a section to describe this.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Just one trivial missing space.

Nice patch set. Thanks,

Jonathan


> ---
>  Documentation/iio/ad7380.rst | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
> index 061cd632b5df..81dfa39519fb 100644
> --- a/Documentation/iio/ad7380.rst
> +++ b/Documentation/iio/ad7380.rst
> @@ -17,10 +17,16 @@ The following chips are supported by this driver:
>  * `AD7381 <https://www.analog.com/en/products/ad7381.html>`_
>  * `AD7383 <https://www.analog.com/en/products/ad7383.html>`_
>  * `AD7384 <https://www.analog.com/en/products/ad7384.html>`_
> +* `AD7386 <https://www.analog.com/en/products/ad7386.html>`_
> +* `AD7387 <https://www.analog.com/en/products/ad7387.html>`_
> +* `AD7388 <https://www.analog.com/en/products/ad7388.html>`_
>  * `AD7380-4 <https://www.analog.com/en/products/ad7380-4.html>`_
>  * `AD7381-4 <https://www.analog.com/en/products/ad7381-4.html>`_
>  * `AD7383-4 <https://www.analog.com/en/products/ad7383-4.html>`_
>  * `AD7384-4 <https://www.analog.com/en/products/ad7384-4.html>`_
> +* `AD7386-4 <https://www.analog.com/en/products/ad7386-4.html>`_
> +* `AD7387-4 <https://www.analog.com/en/products/ad7387-4.html>`_
> +* `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
>  
>  
>  Supported features
> @@ -69,6 +75,42 @@ must restart iiod using the following command:
>  
>  	root:~# systemctl restart iiod
>  
> +Channel selection and sequencer (single-end chips only)
> +-------------------------------------------------------
> +
> +Single-ended chips of this family (ad7386/7/8(-4)) have a 2:1 multiplexer in
> +front of each ADC. They also include additional configuration registers that
allow for either manual selection or automatic switching (sequencer mode),of the
space after ,
plus adjust the wrap as that'll make it 81 chars I think.

> +multiplexer inputs.
> +
> +From an IIO point of view, all inputs are exported, i.e ad7386/7/8
> +export 4 channels and ad7386-4/7-4/8-4 export 8 channels.
> +
> +Inputs ``AinX0`` of multiplexers correspond to the first half of IIO channels (i.e
> +0-1 or 0-3) and inputs ``AinX1`` correspond to second half (i.e 2-3 or 4-7).
> +Example for AD7386/7/8 (2 channels parts):
> +
> +.. code-block::
> +
> +	   IIO   | AD7386/7/8
> +	         |         +----------------------------
> +	         |         |     _____        ______
> +	         |         |    |     |      |      |
> +	voltage0 | AinA0 --|--->|     |      |      |
> +	         |         |    | mux |----->| ADCA |---
> +	voltage2 | AinA1 --|--->|     |      |      |
> +	         |         |    |_____|      |_____ |
> +	         |         |     _____        ______
> +	         |         |    |     |      |      |
> +	voltage1 | AinB0 --|--->|     |      |      |
> +	         |         |    | mux |----->| ADCB |---
> +	voltage3 | AinB1 --|--->|     |      |      |
> +	         |         |    |_____|      |______|
> +	         |         |
> +	         |         +----------------------------
> +
> +
> +When enabling sequencer mode, the effective sampling rate is divided by two.
>  
>  Unimplemented features
>  ----------------------
> 


