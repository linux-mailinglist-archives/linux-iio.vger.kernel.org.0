Return-Path: <linux-iio+bounces-11896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F193C9BB9DD
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4111C22DFE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061841C0DF3;
	Mon,  4 Nov 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPxIZ3Qw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE601B393D;
	Mon,  4 Nov 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736636; cv=none; b=HEN2n1bVqyYeh+rh9L7IU6PHKyOk71GsgoYm94RxuDfGSMTGJucJjWRkJ0OEFidVBNudTus6T36IGn2K/A8F/ZWrD5bgEPfeuua2DDv/GSZgWlD7947Tlg8REWb7psV0QICz17du+jVHVkYm0AFX8xBvdngrGcLZ117h6hVR8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736636; c=relaxed/simple;
	bh=0qhEJZGgBMV6CikmD2WWDctceX83RuUixIjHqPp7U24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbtyiynPsJwEHNq6u8CMezbvwEWmsfbKGIm2VMJI9ueiyIB5p8IQeeACzXocSGl2pUqj5Yz3JBc8muuMJmjXz7rBnG7+ZitcOn3iYHVTBZ+eX4XLOMObS7D2R/IXBpx0HiAD5vRcs296VgCve5lKRQ8uzm+HGi4xpFzuL8gRzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPxIZ3Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1213AC4CECE;
	Mon,  4 Nov 2024 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730736635;
	bh=0qhEJZGgBMV6CikmD2WWDctceX83RuUixIjHqPp7U24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPxIZ3QwvJh+65TMIwfy4GdFk81DJ9KrimR4ViFDAskoDigd3PRvjcLuYB2jmDq8y
	 xLir3jkJbDkkjSWRmYm2bg4hfoklCgmkkTyoeUcrE84z5XaUMOoqC3kpD//5jgb372
	 8V0+DcSUMbRUx8K1kGSCDYXPtgOwCmS2SIry89FjRcFRigg5OWxg16JS4a+jzHwUXd
	 9sh6znm45Tns6eXRAhF5rWOKXV/upOD9nfCTOJZ2asMqayQ+bBXndUEEY0vqX8jL/p
	 kBkUs8RAcBdPyVN0IBnJ9AO1LFAa23OGahENaBMuT3CEaQwBVaRy8P/bjYvqorHP2f
	 D6gASLB+FuGgg==
Date: Mon, 4 Nov 2024 10:10:33 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
	gustavograzs@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply
 properties
Message-ID: <20241104161033.GA228709-robh@kernel.org>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
 <20241102131311.36210-6-vassilisamir@gmail.com>
 <20241102153315.2175fd5b@jic23-huawei>
 <6sucdv4k5jdovqgtaemeer4cnluvnl3xgyn57mo3elgwdmojrx@phu4gowaqtuv>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6sucdv4k5jdovqgtaemeer4cnluvnl3xgyn57mo3elgwdmojrx@phu4gowaqtuv>

On Sun, Nov 03, 2024 at 10:46:46AM +0100, Krzysztof Kozlowski wrote:
> On Sat, Nov 02, 2024 at 03:33:15PM +0000, Jonathan Cameron wrote:
> > On Sat,  2 Nov 2024 14:13:09 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > 
> > > Extend dt-binding for BME680 gas sensor device. The device incorporates
> > > as well temperature, pressure and relative humidity sensors.
> > This description should make it clear it is moving from trivial-devices.yaml
> > 
> > dt-bindings: iio: bosch,bme680: Move from trivial-bindings and add missing supplies.
> > 
> > Then say a little more on why you are moving it.
> > 
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > There was an open question on the previous version about
> > setting the supplies as required (which I see you've removed).
> > My understanding previously was that it is fine to make that change
> > in a binding if it reflects supplies that are required to be enabled
> > for the device to function at all.  If there were previously missing
> > that's a binding bug we should fix.
> > 
> > I'd like a clarification from the DT binding maintainers on that.
> > Obviously doesn't work for other users of dt bindings but in
> > Linux this would be fine as they were already on for any board
> > that worked and the regulator framework will through us a fake
> > regulator for cases like this.
> > 
> > https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/
> > 
> > Jonathan
> 
> That was Rob's objection so I will leave it to him, but putting my two
> cents in for Linux it is not an ABI break because missing regulator
> supplies are substituted with dummy ones. Unless something changed...

Shrug. I don't think we're entirely consistent on this. If we're saying 
supplies are always required, then every device in trivial-devices.yaml 
is wrong. Since Linux handles them missing, you can also argue that 
supplies are never required.

I'd prefer not to special case regulators as an exception I have to 
remember. I have some rudimentary ABI checking I'm working on that 
checks for things like new required properties. Though it wouldn't catch 
this particular change given it moves the schema.

Rob

