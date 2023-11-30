Return-Path: <linux-iio+bounces-504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2E7FEBEE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 10:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2483CB20FF0
	for <lists+linux-iio@lfdr.de>; Thu, 30 Nov 2023 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D91238FAC;
	Thu, 30 Nov 2023 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="rVh6koxr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6887D46;
	Thu, 30 Nov 2023 01:36:04 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8410828EE6F;
	Thu, 30 Nov 2023 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701336962;
	bh=ADv50IKOfXpr6wp/YVhaOih73Dk799OpD0y6U8Hi6Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rVh6koxrByAi+QvBVR1jZmkmvB6FJNMZ0hZ7shvhpJXOKz3J0MJAU9kLmI2ILUgtY
	 3dqvJtwV7ryqfIpL8ytSX2SEbdvc/Qq67ZuZpz4Cz1s9HGDBiVUdvsRwXSnr7Z5TGm
	 198MGqLlawTz9WYBgg0lendXE7XL1x9A6txK7r6E=
Date: Thu, 30 Nov 2023 11:36:01 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Message-ID: <ZWhXgTZ-M3Qj7xoS@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <1bda0a63-6fc9-4fc0-953b-7d618f77b268@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bda0a63-6fc9-4fc0-953b-7d618f77b268@linaro.org>


good morning.

On Thu, Nov 30, 2023 at 09:31:45AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 18:04, Petre Rodan wrote:
> > Adds binding for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors.
> > Communication is one way. The sensor only requires 4 bytes worth of
> > clock pulses on both i2c and spi in order to push the data out.
> > The i2c address is hardcoded and depends on the part number.
> > There is no additional GPIO control.
> > 
> > Datasheet:
> > https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf [HSC]
> > Datasheet:
> > https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf [SSC]
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.

thank you for the clarification.
not going to lie, this entire process is overwhelming. I'm trying to generate
the least amount of noise on this very busy list and yet here I am being the
loudest one. who whould have thougth that being prudent and running two
consecutive commands of `git send-email` would produce out-of-thread patches on
your end, or that b4 or whatever you use would not pick up tags already present
for a patch?

I'd like to thank everyone commenting on my stupid patch and rest assured that
most of the mistakes you point out are a learning lesson on the receiving side.
keep them coming and excuse the noise, it will fade away soon.

and regarding the bindings file, there have been no changes to it since the tag.

my very best regards,
peter

> 
> Best regards,
> Krzysztof
> 

-- 
petre rodan

