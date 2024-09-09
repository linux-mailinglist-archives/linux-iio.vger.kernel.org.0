Return-Path: <linux-iio+bounces-9413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFF972270
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE6D1C22457
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAB017837D;
	Mon,  9 Sep 2024 19:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwWJEjJm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9112210EC;
	Mon,  9 Sep 2024 19:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909392; cv=none; b=mCS39qeMDHUNcp63+0QVjuOkiXgIuM9QL05qNpYGF47pArwZgSRiEQI0x/hHev9bP8pFWuN5doJ9EqNYN3/DBDZcmSd53UniDvsZuEySxT82VHm+lFbpFq3sjYGitCNCQiq33/FFl3UvhNv4rDaMGN3/6nW18EBviVoDMJBQagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909392; c=relaxed/simple;
	bh=MqYZtOzr+xyINDrpQoCb1CSGseIhFZ2oocZhQDmUqS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPohUY4kTGb045pjSO7mUE/n9ZCDZHrX+REP/n0yGiRlWgn9n5jusmqOdnm2dJ5cKFFJbz1qNh269R8rnE+g8Ae/WCldcKMBlzHIHFZZPCccTzKZuK1FpESug219kGLiDpWD/HF097Kiwso2wMkIyITY0Ba4bXzMZ3oUTXP/u+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwWJEjJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C8CC4CEC5;
	Mon,  9 Sep 2024 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725909390;
	bh=MqYZtOzr+xyINDrpQoCb1CSGseIhFZ2oocZhQDmUqS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FwWJEjJmE+p4Sj9E1d+dv3yYbUyGEx/WBf69zDLj5US3R+6cafx1iU4hq7EEyqu76
	 xxJb+rFFqVhdFTs1E6Wr+l3GpUNk6rw6sqAeiqKS9tx8RMKblMgEWUXl8rjv3Bce3u
	 +l21qvvsHeVqhJD33Uw29E8vK3G/zljhN9ucRAGMwv1SpBo4WeMmQ9UL0xX8OcQNGV
	 1MkK/Kz/kU1E/fTc1an9Hu2A7h+kgWXyYq0q/OtAy8JkjD2zpFRO5kh9JaNoyLdmaI
	 Z+nHGDH0BD45pm22v7O30fvd343YY2KuOd4dAVz+WOKVwHKjyQd16NB/AFLioZgtne
	 wGqULG+T76kiw==
Date: Mon, 9 Sep 2024 20:16:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [PATCH v2 1/9] dt-bindings: iio: dac: ad3552r: add io-backend
 property
Message-ID: <20240909201621.31bdca1a@jic23-huawei>
In-Reply-To: <be279b0f-8337-4d3b-87c2-f426ddb302e3@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-1-87d669674c00@baylibre.com>
	<20240908132925.331c5175@jic23-huawei>
	<be279b0f-8337-4d3b-87c2-f426ddb302e3@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Sep 2024 13:39:26 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> On 08/09/24 2:29 PM, Jonathan Cameron wrote:
> > On Thu, 05 Sep 2024 17:17:31 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >  
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> There is a version AXI DAC IP block (for FPGAs) that provides
> >> a physical bus for AD3552R and similar chips. This can be used
> >> instead of a typical SPI controller to be able to use the chip
> >> in ways that typical SPI controllers are not capable of.
> >>
> >> The binding is modified so that either the device is a SPI
> >> peripheral or it uses an io-backend.
> >>
> >> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >>   
> >>   required:
> >>     - compatible
> >> -  - reg
> >> -  - spi-max-frequency  
> > Sort of feels like both reg and spi-max-frequency
> > are valid things to specify.  
> 
> This specific backend IP generates a fixed non-configurable clock
> frequency, so i don't think the spi-max-frequency is needed.
Ah fair enough.
> 
> 
> > Maybe we have an excellent IP and dodgy wiring so want
> > to clamp the frequency (long term - don't need to support
> > in the driver today).
> >
> > Maybe we have an axi_dac IP that supports multiple
> > front end devices?  So maybe just keep reg?  
> 
> yes, this is what i am wondering now too, i simplified with just one
> frontend node, are multimple frontends (and so reg property) needed ?
It does little harm to have one. So I'd say keep it as required.

Detection of what is required should be based on something more
specific than reg being there or not.

Jonathan

