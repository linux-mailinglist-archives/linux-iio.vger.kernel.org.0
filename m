Return-Path: <linux-iio+bounces-1199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6F81BD00
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 18:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10989B23A1A
	for <lists+linux-iio@lfdr.de>; Thu, 21 Dec 2023 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14659933;
	Thu, 21 Dec 2023 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlACiFRo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F459928;
	Thu, 21 Dec 2023 17:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645D4C433CA;
	Thu, 21 Dec 2023 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703179302;
	bh=qBXe5efCj0s4OpnQfdZfUHn2RcjIwJIWq2QgG1JXDXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NlACiFRoVdwGb1IWTtl4s3PPfPAUVB24ny5xUjX/ZVnjgOKhOpef+l7g6AFr51xrt
	 W/LXnLy5kNSwPBIonnupzu9QR50iSdR1an1Zr2H8v8b81OQdvtMHTx476KH028jB3F
	 EfPEzpXJfFzuioPVatgY72RGFJHzQX8hst4aZN7UI6+HSRp27QE/ZNsC5D5yLaqsxQ
	 vtltHgNg65wNYE8sEzCYo9pEY2DNAbSNKTUI/MhEx3WJ5qohfXJ6n83/DRKxQxuCWC
	 42jXXeCWo1Vn4u0xoGuMRbBgTnbcUTx29UpK9b39OKqDQ5jynbjDOb+WAJQrtBeeOF
	 uAHMOLZp+f/2w==
Date: Thu, 21 Dec 2023 17:21:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
Message-ID: <20231221172126.761e580d@jic23-huawei>
In-Reply-To: <170309138435.683144.1812971328993385650.robh@kernel.org>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	<20231220-iio-backend-v4-1-998e9148b692@analog.com>
	<170309138435.683144.1812971328993385650.robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 10:56:24 -0600
Rob Herring <robh@kernel.org> wrote:

> On Wed, 20 Dec 2023 16:34:04 +0100, Nuno Sa wrote:
> > The ad9467 will make use of the new IIO backend framework which is a
> > provider - consumer interface where IIO backends provide services to
> > consumers. As such, and being this device a consumer,  add the new
> > generic io-backend property to the bindings.
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >   
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml: io-backends: missing type definition

For reference this is expected as if this goes ahead that will be a dtschema addition.

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231220-iio-backend-v4-1-998e9148b692@analog.com
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


