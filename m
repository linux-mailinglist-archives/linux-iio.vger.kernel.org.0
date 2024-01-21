Return-Path: <linux-iio+bounces-1804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601783570A
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 18:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCDC281FE2
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jan 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F0F381B2;
	Sun, 21 Jan 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u24JtrOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EF322069;
	Sun, 21 Jan 2024 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705857458; cv=none; b=ZB4Q9swx259/Nc1xmWhvYGF08afiKUYeS54acy9EwXgUNXKcyriey3wOMA/sKHtjwgN1JizBISl/BGyRwFTZ4IBLo056oi2vi4I75tR+rBRnIY123i7YgXP7JpCkKJsn90ep5sF+cRHZBqini1UAEIIQKKmpe8eNNvX3uizId2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705857458; c=relaxed/simple;
	bh=1ckOfy/xrTLyt6SBXvX3gF3hJMl/ZVMneLFvgClH0jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkhRUGQpUNBTzlhywfxCHGcbNDrVDpWmdcNv6hidM76EayFOPnytNoEc3Tmw359cgqsCBZHpGRB1LEGfC2MWQz6bTlzYgIwnIVEBIlmJryQO9ib5BJqP5WPdKIghiqzTpWXc0oRgJpkJFNCLi/+Yc0c+xVP9sBfYvu1g37s1qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u24JtrOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A05CC433C7;
	Sun, 21 Jan 2024 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705857457;
	bh=1ckOfy/xrTLyt6SBXvX3gF3hJMl/ZVMneLFvgClH0jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u24JtrOHG9ILIjKrBJUrPE57CUQgMzdf3SC/hmQ2A7lKMnbJ6MurPSnBLcbeQmml5
	 EUQiB8JVNlVCgXvp3PBE/GhthOo0rQEh132rOOrb3lniXuedHgSfKyU4chFvsXy4DS
	 1iS0HI1Q+wu/9OBBM2ggcbJ6brIAzh29mKAHUxXKsOImSEXHG7teqf2dsjdCNwCD1y
	 AoL/M7sN/yYOLnjJQQbR2CjKyg6iv7T2FZdOfhSWmKi2J3x7Ws9F3U8hywAEcjfZOX
	 S6t/74t55ALisnwFcXVq+tYM/nEwSgWgJp5vcJPuFA8TrKMwQa9F5UZhgX61QD4AkW
	 68J/oJpyCscKQ==
Date: Sun, 21 Jan 2024 17:17:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand
 <frowand.list@gmail.com>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH v6 2/8] dt-bindings: adc: axi-adc: update bindings for
 backend framework
Message-ID: <20240121171720.47b61298@jic23-huawei>
In-Reply-To: <170568455347.599801.4301742729712962299.robh@kernel.org>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	<20240119-iio-backend-v6-2-189536c35a05@analog.com>
	<170568455347.599801.4301742729712962299.robh@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 11:15:56 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, 19 Jan 2024 17:00:48 +0100, Nuno Sa wrote:
> > 'adi,adc-dev' is now deprecated and must not be used anymore. Hence,
> > also remove it from being required.
> > 
> > The reason why it's being deprecated is because the axi-adc CORE is now
> > an IIO service provider hardware (IIO backends) for consumers to make use
> > of. Before, the logic with 'adi,adc-dev' was the opposite (it was kind
> > of consumer referencing other nodes/devices) and that proved to be wrong
> > and to not scale.
> > 
> > Now, IIO consumers of this hardware are expected to reference it using the
> > io-backends property. Hence, the new '#io-backend-cells' is being added
> > so the device is easily identified as a provider.
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >   
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: [error] syntax error: could not find expected ':' (syntax)
If this is all that comes up for v6, I can fix it up whilst applying.


> 
> dtschema/dtc warnings/errors:
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts'
> Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/iio/adc/adi,axi-adc.example.dts] Error 1
> make[2]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml:45:5: could not find expected ':'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml: ignoring, error parsing file
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240119-iio-backend-v6-2-189536c35a05@analog.com
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


