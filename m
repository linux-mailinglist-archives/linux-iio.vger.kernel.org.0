Return-Path: <linux-iio+bounces-10507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E899B51F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 15:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4BE1F221C4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD5C1865E5;
	Sat, 12 Oct 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezGRihu4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327A1E511;
	Sat, 12 Oct 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728740600; cv=none; b=IZA8vqqgpeanBGtelueL6a+WkZtjjrnd6RA9VK/bpizhXMYaZI6MjeanHum6N/f6TznnyrcP53cIUJsITCbyref5LXqISwmn+aNGO4jJIWgvD5rq/h8xi69BoUvu/Bm7bh7LtyOcAPCJ+kzaR2sXVT6x1Hf/65MiXn7z7w5dR88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728740600; c=relaxed/simple;
	bh=nfmJPzRyVxzMj82Jti4CDk4VBuGKE5wuLCbuJgq++PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTl98QN8W6mm8qtwos7Kyca0pZKz1euxPTa6MCq9rGDKSVtXmu6XY9+8967CW6yusZwe1NfUJgau6+bLB+BhgVIre9owzEeshLt4UpHCnOWU8NtIGWwgyxd8f68ikb/aQ778Q51Z///+cy4709EWIbIyZewWK4ebFpqeRNoBl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezGRihu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F8C4CEC6;
	Sat, 12 Oct 2024 13:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728740600;
	bh=nfmJPzRyVxzMj82Jti4CDk4VBuGKE5wuLCbuJgq++PY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezGRihu4OT/0yt9dGNC/afbmSNXQDWmLjOXjWfYMVLMjWXsek/qdzxaOBLk+2dNro
	 X35QsmF4OlUmzibghTi9qStcyxTTL8prWSBg1938hOJJ9raVf0SqUhBdTfDZCG43o9
	 Bl5h6L6KUxegstBUPWTABmF5NXfXfJJT6MY6v/MhWjJfDyfrmuYTUjhWYYr5tfiALV
	 QhYV0XGD5TLULm3A4cCmSYCxnWKjC32SLvSzUwZBhxojMFZBbprxwevILRfuGiT7Q8
	 c1PNn53ojzkLZ+qgpUH3/KR/vamPZIflYDUjDPmRShwX1KLIsfx37z9jMjZETrq13/
	 o0dpqEXY++Psw==
Date: Sat, 12 Oct 2024 14:43:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-kernel@vger.kernel.org, Mark Brown
 <broonie@kernel.org>, dletchner@baylibre.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 04/10] dt-bindings: iio: dac: adi-axi-dac: add
 ad3552r axi variant
Message-ID: <20241012144313.2ef2f282@jic23-huawei>
In-Reply-To: <172840812598.1881490.11957892692384833449.robh@kernel.org>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
	<20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com>
	<172840812598.1881490.11957892692384833449.robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2024 12:22:06 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> On Tue, 08 Oct 2024 17:43:36 +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add a new compatible and related bindigns for the fpga-based
> > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > 
> > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > mainly to reach high speed transfer rates using a QSPI DDR
> > (dobule-data-rate) interface.
> > 
> > The ad3552r device is defined as a child of the AXI DAC, that in
> > this case is acting as an SPI controller.
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> >  1 file changed, 53 insertions(+), 3 deletions(-)
> >   
> 
> My bot found errors running 'make dt_binding_check' on your patch:

For the record, this is due to me having already picked up a fix on this
frequency range into the togreg branch of iio.git
So wrong base tree for the test run.

Jonathan

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-4-3d410944a63d@baylibre.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


