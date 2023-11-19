Return-Path: <linux-iio+bounces-172-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF997F083F
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EAAB209AE
	for <lists+linux-iio@lfdr.de>; Sun, 19 Nov 2023 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D2318033;
	Sun, 19 Nov 2023 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="c0GQfUdL"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B3B5;
	Sun, 19 Nov 2023 10:08:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5C06D870AF;
	Sun, 19 Nov 2023 19:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700417333;
	bh=7T621AP9byF0WND9U9DAm4UlLtfk5UP5T6gptgnAur4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c0GQfUdLHhW43WhcTLZ1fHekwm+w67ItovMNsdiK7/8/2bD0ZTOGkrx2WqtQ8VRZJ
	 WOkin9a8vKtAF+mhImWpgTalVZ6FI4N243qhqgLWuG3SgyKc2divaOsTz65fjZhMQK
	 To2U9ijUNcN+D26Nim+X0ig6H7opkKUq0hUyEDt3EN9gzMy/TSfzILRlwj+G1a2U2L
	 QDcgH+egybkcdc3PMaP31RpBrXSGLu2yzYddEjuNIJqHaLz7YySdW2Y9RDDVijzBZg
	 gvk9R68zaStCY38Kf5uNc0Jzy/Bz6NCOaTtyvD+0WU+HcriajyBW9T/5upHLlsDL3A
	 lx1KknSjyzhbA==
Message-ID: <4fe94f10-ff06-417b-a6d5-433bfeeac641@denx.de>
Date: Sun, 19 Nov 2023 19:08:45 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: isl76682: Document
 ISL76682
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Andre Werner <andre.werner@systec-electronic.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Naresh Solanki <naresh.solanki@9elements.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Rob Herring <robh+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 Vincent Tremblay <vincent@vtremblay.dev>, devicetree@vger.kernel.org
References: <20231118000614.186558-1-marex@denx.de>
 <20231119150756.20a023b5@jic23-huawei>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231119150756.20a023b5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 11/19/23 16:07, Jonathan Cameron wrote:
> On Sat, 18 Nov 2023 01:06:09 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> The ISL76682 is very basic ALS which only supports ALS or IR mode
>> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
>> other fancy functionality. Document it as trivial device.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> I'm always a bit in 2 minds about trivial-devices as it doesn't
> include a basic power supply.  In this case vdd which I'd prefer
> to see documented even on such a simple device as this.
> Not everyone is going to leave it powered up all the time!
> 
> Still I'm not that fussed. Maybe it's worth allowing vdd-supply in
> trivial-devices.yaml?

The hardware I have is powered all the time, so I'd be adding completely 
untested code which is no less useless for me (at least right now). Lets 
postpone this until there is a need for it, can we ?

I addressed all the other comments in 2/2.

