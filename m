Return-Path: <linux-iio+bounces-415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4A7F95BA
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 23:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF86280D88
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 22:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D9D1428E;
	Sun, 26 Nov 2023 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EZPuyjMV"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA9F0;
	Sun, 26 Nov 2023 14:17:58 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 98D4186F40;
	Sun, 26 Nov 2023 23:17:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701037076;
	bh=WjKUdUadE75KuCF33+OZs4fr2JhweqKtmUzbN8Hxwnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EZPuyjMVAuDJJzr8z3VXqNjR4AMygf7DOuB6HtFzCBcBLefqzvQU4KkXZet89L/4z
	 dZ1Wtztb2/zp08g6jUbw3uVv0c2vIPU2P3vPeteA0dtFJxDV2pJnnerQhSEP9goBfV
	 6pN/ooLPqlugqyaanzEAx5d6SavwAIIZexVBjuvrHlrpWbhVg9D8nbvgNjDLAzHHH5
	 FOOdc+IqrOuir2ddVIOheoEsvIh7mZrRsvBmXH8FRAU3zkDGUkvZFEsHA7kPUpDaUJ
	 lQBkDGcmLxi6oZptsnxaXf3uuglvEHMFJzPlplUq81MxdGjPNymRB9I7cC+DUn7+P9
	 wT0uOfoFK0M0Q==
Message-ID: <124ca1d8-5569-4c6c-8019-24e58dd8a5fc@denx.de>
Date: Sun, 26 Nov 2023 23:17:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Content-Language: en-US
To: "Dr.-Ing. Andre Werner" <andre.werner@systec-electronic.com>
Cc: linux-iio@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231125222738.97875-1-marex@denx.de>
 <20231125222738.97875-2-marex@denx.de>
 <907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <907048010.848203.1701027206602.JavaMail.zimbra@systec-electronic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/26/23 20:33, Dr.-Ing. Andre Werner wrote:

[...]

> +static int isl76682_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int i;
> +
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> 
> In my understanding, this is not necessary as you use that 'iio_chan_spec' to specify
> the channels available at all. So there will be no other channel types created by the IIO environment, I think.

That's a good point, I think we can drop it in this case and the next one.

Jonathan , is there any reason you can think of why this shouldn't be 
dropped ?

I'll add it into V6, thanks.

