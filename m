Return-Path: <linux-iio+bounces-24307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7CB8C4AF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854FB3AFE1E
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 09:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89C288C25;
	Sat, 20 Sep 2025 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHjiYbUG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AB1C84A2;
	Sat, 20 Sep 2025 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360824; cv=none; b=keGlN0F7atmAhsz3rzciFZyXIxDmN97Tem6eoEDqo43ISjPxb3u22SeVWuoz+nOaiGwTrrhDOF57kGFbpun9NmMkh8lwyMWqmudc5FxJmJ94TsWD5FhesHXlSnmvA42o6JEmpDOcJqv6neq7qC1sGGn1nNHnmbBYryutn23YUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360824; c=relaxed/simple;
	bh=jgQnG5NuXon7tNcghlakHeJewk+7Ds+CcT/im/S55mg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbxM2vFfY2aBr93B4jrYvO2QdNr+nVAEPu7Rx1vusTi622zj5SXFdneTf1Mgd4HivFReq1XuM+KLIF0/I9SEwB12AcpeegCAa6L7s0XmSdr7S5oFQaXd+F5VP4eDJAkzbyyGrggKfO7LMqCCWs2c2VTfeg1Iel27aUD8Gx/LjUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHjiYbUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571B7C4CEEB;
	Sat, 20 Sep 2025 09:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758360823;
	bh=jgQnG5NuXon7tNcghlakHeJewk+7Ds+CcT/im/S55mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHjiYbUG92MC0f814pj5xv82sH+tk5AT4fbExxeLw9OzfhhNdIl2cpNXhLJYewL+/
	 /Olh1pxESdnJVhEagdHy56646R+7Www5xJn5DOLUiuoOXjFWBt+GnbgXSSvJECnRkZ
	 8Ue6RRSCFYzjjUP4wRy1IaMZoegtnI0/bSYdZaiZExalsgZwMCY11x25eSs8BtD0rk
	 wWCDvVY+o6QBjP8lZokvQu1bhQGY782Av5xL8kbNwA5T3FfaXhvlyE04NlNXkfVPEz
	 LmdYSPC7FUp1xvNtlL5Yht0lc+9YbhAyzxzxs1Rc97YhCzEAmPQcJ+6VXdVihaJj6H
	 ZWK5MMYbXeLxg==
Date: Sat, 20 Sep 2025 10:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
Message-ID: <20250920103331.40225e2f@jic23-huawei>
In-Reply-To: <aM20pbc2XAYq88BN@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
	<5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
	<f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>
	<20250919-paramount-headstand-c9b5d4d03c58@spud>
	<aM20pbc2XAYq88BN@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 16:53:09 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/19, Conor Dooley wrote:
> > On Thu, Sep 18, 2025 at 02:39:01PM -0500, David Lechner wrote:  
> > > On 9/18/25 12:38 PM, Marcelo Schmitt wrote:  
> > > > AD4030 and similar devices all connect to the system as SPI peripherals.
> > > > Reference spi-peripheral-props so common SPI peripheral can be used from
> > > > ad4030 dt-binding.
> > > > 
> > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++  
> ...
> > > > @@ -20,6 +20,8 @@ description: |
> > > >    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
> > > >    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
> > > >  
> > > > +$ref: /schemas/spi/spi-peripheral-props.yaml#  
> > > 
> > > I think this is already referenced for all child nodes of a SPI
> > > controller because of pattern matching of:
> > > 
> > > patternProperties:
> > >   "^.*@[0-9a-f]+$":
> > >     type: object
> > >     $ref: spi-peripheral-props.yaml
> > > 
> > > in Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > 
> > > So perhaps not strictly necessary?
> > > 
> > > Would be curious to know if there is some difference.  
> > 
> > I think it's good form if you're actually referencing the properties. I
> > don't know if it actually makes a difference in the end result of
> > dtbs_check but it may in terms of making sure properties in this binding
> > are properly typed when it is tested against. In this case, it appears
> > you're only looking at uint32 properties so it mightn't have any impact.
> > Rob would know for sure.
> >   
> 
> There's no difference, at least on dt_binding_check output.
> Initial idea was to allow using properties from spi-peripheral-props.yaml, but
> they are already available through the pattern in spi-controller.yaml.
> If the noise doesn't worth it, I don't mind dropping this patch.
> 
I agree with Conor. Having this here might not be strictly necessary but it
helps a reader of this binding know that those properties are relevant.
So I think keep it.

Jonathan

> Thanks,
> Marcelo


