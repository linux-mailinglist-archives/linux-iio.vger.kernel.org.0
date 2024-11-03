Return-Path: <linux-iio+bounces-11863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B99BA4F8
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B006B21A2A
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528C165EE3;
	Sun,  3 Nov 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+T+sFdG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D397A1632D4;
	Sun,  3 Nov 2024 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730627211; cv=none; b=KNWrwU2fsCVxnHGvli1dpwHmYOPPF+DZ6+VFJkfkXOaPwGj2UXiczTmcSt2TrhdS1kgMIvcy2KbCOEa/uJ0nhUAhPLWYjjDq9H1EkNNxd/WlW0pgZFePgqX39tETcsjcplNOs8H+Uedt63H/twAqZD6pwVygxPatDQTztC4ZY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730627211; c=relaxed/simple;
	bh=mnBM43ZNNEFrwyTfSqovAUh0lCbqk6Itz7ehWw9irSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrgTf+n+VFc7H1Xfd6mtN3GdlGdA6BR4nH7JFgTw6Mz51uazpcNBwmwOk31VifSjuLUBADhYpOdmGjHAtaKGZOfJDgozVvDtUOajDJSXwzA+LU00LGLajzfOE6WZYqKSfkYmLVEJfZBX4wRN0st94ZMXsNaYxh4jAIenyOeqpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+T+sFdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759D0C4CECD;
	Sun,  3 Nov 2024 09:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730627210;
	bh=mnBM43ZNNEFrwyTfSqovAUh0lCbqk6Itz7ehWw9irSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+T+sFdGJrzI+6nzpxDgliHwNQuzQ9331ss9n4rhB2LIH5NWNcN9KK881c5WRERBv
	 84wd/ThSc0Hqvf41qFs38zCM64TzaFi0dlKMeXFv4Fo3PxSHkB1y/XgloOP3R+3/SM
	 +yrVr4+tvlAD3XtYQxvP5jVubV+JezKoqFVFANDf8xbQ/gc/89KIW80hOi4mnH/3Vl
	 xSAu2pSEii0WPnZlGerXcx5Wm93EMm8myVx/ol/wGkeqlbZgeBz3TSLp8Ni6X06+sX
	 9ulVOZBYzE8ql6Z8x3BVbp8dLFwf9tnpUcqO3h5orx3JxqiOn7WW4JWe3rgQaVFGOP
	 hLGysHRi+icYA==
Date: Sun, 3 Nov 2024 10:46:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andriy.shevchenko@linux.intel.com, anshulusr@gmail.com, gustavograzs@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply
 properties
Message-ID: <6sucdv4k5jdovqgtaemeer4cnluvnl3xgyn57mo3elgwdmojrx@phu4gowaqtuv>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
 <20241102131311.36210-6-vassilisamir@gmail.com>
 <20241102153315.2175fd5b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241102153315.2175fd5b@jic23-huawei>

On Sat, Nov 02, 2024 at 03:33:15PM +0000, Jonathan Cameron wrote:
> On Sat,  2 Nov 2024 14:13:09 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Extend dt-binding for BME680 gas sensor device. The device incorporates
> > as well temperature, pressure and relative humidity sensors.
> This description should make it clear it is moving from trivial-devices.yaml
> 
> dt-bindings: iio: bosch,bme680: Move from trivial-bindings and add missing supplies.
> 
> Then say a little more on why you are moving it.
> 
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> There was an open question on the previous version about
> setting the supplies as required (which I see you've removed).
> My understanding previously was that it is fine to make that change
> in a binding if it reflects supplies that are required to be enabled
> for the device to function at all.  If there were previously missing
> that's a binding bug we should fix.
> 
> I'd like a clarification from the DT binding maintainers on that.
> Obviously doesn't work for other users of dt bindings but in
> Linux this would be fine as they were already on for any board
> that worked and the regulator framework will through us a fake
> regulator for cases like this.
> 
> https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/
> 
> Jonathan

That was Rob's objection so I will leave it to him, but putting my two
cents in for Linux it is not an ABI break because missing regulator
supplies are substituted with dummy ones. Unless something changed...

Best regards,
Krzysztof


