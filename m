Return-Path: <linux-iio+bounces-6752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5DE913ADD
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FEB1C20C1A
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C39181B88;
	Sun, 23 Jun 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH/CJLvl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31334CE5;
	Sun, 23 Jun 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150229; cv=none; b=flHPA0J6OFo8p0IJIOeaIDmhFjZ5pHeOTvL664/fZ+CF7shYdc1f03adIsEX1JIBn9957jTP98VKiS4G80IrQpz6p3jRHKjGE3MlTs9fO0/ekBdFWf7LLkAizqxxecEaWJdhQKuq89jD92+sT7jQV11vvNG/ogvhDfsSAmwBRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150229; c=relaxed/simple;
	bh=wtKWWKsccCRVH5NfxjqFIUvz4d0pGGPPjt66SY986co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=um7tmXNCZzWm6MRci1Lvg99BLaN3lVwMuOnP6i3vgbjumiM7VZQnfld5Nl6nOLYQtt7rKnrFJza/5MLLLxEzvkrL6bvI67tlwb2m/n+SMObhOJMsn2k6KcN8/mwbozNHXKyjaie7anolHs5HyFXUoOYfh6xEBkGTArykqjEOmIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH/CJLvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B4C2BD10;
	Sun, 23 Jun 2024 13:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150229;
	bh=wtKWWKsccCRVH5NfxjqFIUvz4d0pGGPPjt66SY986co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HH/CJLvlCz8eC9aD3aHrHRJkUzS7BG2H+f9nu/LsrB+mH+mlC5dBbTnGftkl94cPp
	 bpNEzCi1L2ng5hruZsdv7ubAQoNqNBmiYQduSrxGIWkbocneC7DVPWTPc+zhslWnWp
	 pgqE+bUjhRRnStwqUMRZzwnAdV7UMu58X0iMEptVlhKZE8C0mIburRX0z37uU65C2p
	 J3WM4DV8B7ePnjPgjxSyJ/d8K38/1MVMD4+cBTglKS8v4WK6ew2x/p12Zmn5ay1kW+
	 NZWDSC9lBrcQZK+eXeQrvihDU3AjlK5vV4v8bxAE4XTHuhkkTNdfSMWUjepF8VlVym
	 PBNdzQoAXSkeQ==
Date: Sun, 23 Jun 2024 14:43:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: iio: dac: Add adi,ltc2672.yaml
Message-ID: <20240623144339.6a5087cf@jic23-huawei>
In-Reply-To: <20240619-vanity-crowd-24d93dda47b8@spud>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	<20240619064904.73832-5-kimseer.paller@analog.com>
	<20240619-vanity-crowd-24d93dda47b8@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 18:57:59 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Jun 19, 2024 at 02:49:03PM +0800, Kim Seer Paller wrote:
> > +patternProperties:
> > +  "^channel@[0-4]$":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number representing the DAC output channel.
> > +        maximum: 4
> > +
> > +      adi,toggle-mode:
> > +        description:
> > +          Set the channel as a toggle enabled channel. Toggle operation enables
> > +          fast switching of a DAC output between two different DAC codes without
> > +          any SPI transaction.
> > +        type: boolean
> > +
> > +      adi,output-range-microamp:
> > +        description: Specify the channel output full scale range.
> > +        enum: [3125000, 6250000, 12500000, 25000000, 50000000, 100000000,
> > +               200000000, 300000000]  
> 
> IIO folks, is this sort of thing common/likely to exist on other DACs?

Fair point. It is probably time to conclude this is at least moderately common
and generalize it - which will need a dac.yaml similar to the one we have for
ADCs in adc/adc.yaml.  That will need to make this a per channel node
property (same as the adc ones).
 
I'd also expect it to always take 2 values. In many cases the first will be 0
but that is fine.

Jonathan


