Return-Path: <linux-iio+bounces-12406-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D59D27B5
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 15:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64D26B27CAA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5B1CCB25;
	Tue, 19 Nov 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Bnor51"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CB1798C;
	Tue, 19 Nov 2024 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025051; cv=none; b=YBHTgQbHLeC2ZeGK0kHgI6dwHbrJ80fHJpgmmCYFqu8s31wOwVvGCXRDHXPLUgvfAu0korT6GNxlS8qsEfjGg+eiN4KZLMySnKZOlYne0ZQ7IW4jKtdhBpS8AhvrhqkiHQbE78IMD4BZ3mKVFlyePEq5pak92oO+5/Hnzfq4rSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025051; c=relaxed/simple;
	bh=Pmwy0jA7PsPKZQWJtbUwBsQN+Sxfpeu4kZ56bbkjML0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsQXk7up+dU9oqN3KhQaQBjqlTEAryQG7Y3J/anFQmDCc8gdyQdFqFQXZHbweg/5E32Ksqd9h6NEDjgVoxH/ZpZMX7nAnAXEvLwqM1hUiP98xAIP9vA9ilVRTAtghiFAhbby5CZes1ylLv+3FvpQArvIIUqlb1T85cgK6qMA46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Bnor51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC12C4CECF;
	Tue, 19 Nov 2024 14:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732025051;
	bh=Pmwy0jA7PsPKZQWJtbUwBsQN+Sxfpeu4kZ56bbkjML0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0Bnor514j21mV9m7EGCI0pbS7npTIyS6XbLVutVQTtBuNttpptK5zKQ62MUDFQ0M
	 nZzoTC4zDsfMu2TzqZEtORVlEnBHN4/EMDj+2GEtyK3rZ+Fladtti44fYg1ziHvmfr
	 uwBKOomy10R2PMTpHTNeTpLPnRz1iSOlGg8Y+AhWI4hSht7qCvTAxK+7LZghyZvWAH
	 KL5W3hejxpB1Ztc6+ggt/U+Bs6lq6eut2phndQ2HT/N9FasEvZQTYTGgtbWriOQecL
	 OvRdgz4L2yS5NbxY/Iu/ocEKbOjMInToOTvQu93tWXJruGdNpK2XmwCZaG3whuzGfe
	 nKPQ1RrfKaDUg==
Date: Tue, 19 Nov 2024 08:04:09 -0600
From: Rob Herring <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com, anshulusr@gmail.com,
	gustavograzs@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply
 properties
Message-ID: <20241119140409.GA1093349-robh@kernel.org>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
 <20241102131311.36210-6-vassilisamir@gmail.com>
 <20241102153315.2175fd5b@jic23-huawei>
 <6sucdv4k5jdovqgtaemeer4cnluvnl3xgyn57mo3elgwdmojrx@phu4gowaqtuv>
 <20241104161033.GA228709-robh@kernel.org>
 <ZzJRkCJcbCFSMcat@vamoirid-laptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzJRkCJcbCFSMcat@vamoirid-laptop>

On Mon, Nov 11, 2024 at 07:48:48PM +0100, Vasileios Amoiridis wrote:
> On Mon, Nov 04, 2024 at 10:10:33AM -0600, Rob Herring wrote:
> > On Sun, Nov 03, 2024 at 10:46:46AM +0100, Krzysztof Kozlowski wrote:
> > > On Sat, Nov 02, 2024 at 03:33:15PM +0000, Jonathan Cameron wrote:
> > > > On Sat,  2 Nov 2024 14:13:09 +0100
> > > > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> > > > 
> > > > > Extend dt-binding for BME680 gas sensor device. The device incorporates
> > > > > as well temperature, pressure and relative humidity sensors.
> > > > This description should make it clear it is moving from trivial-devices.yaml
> > > > 
> > > > dt-bindings: iio: bosch,bme680: Move from trivial-bindings and add missing supplies.
> > > > 
> > > > Then say a little more on why you are moving it.
> > > > 
> > > > > 
> > > > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > > 
> > > > There was an open question on the previous version about
> > > > setting the supplies as required (which I see you've removed).
> > > > My understanding previously was that it is fine to make that change
> > > > in a binding if it reflects supplies that are required to be enabled
> > > > for the device to function at all.  If there were previously missing
> > > > that's a binding bug we should fix.
> > > > 
> > > > I'd like a clarification from the DT binding maintainers on that.
> > > > Obviously doesn't work for other users of dt bindings but in
> > > > Linux this would be fine as they were already on for any board
> > > > that worked and the regulator framework will through us a fake
> > > > regulator for cases like this.
> > > > 
> > > > https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/
> > > > 
> > > > Jonathan
> > > 
> > > That was Rob's objection so I will leave it to him, but putting my two
> > > cents in for Linux it is not an ABI break because missing regulator
> > > supplies are substituted with dummy ones. Unless something changed...
> > 
> > Shrug. I don't think we're entirely consistent on this. If we're saying 
> > supplies are always required, then every device in trivial-devices.yaml 
> > is wrong. Since Linux handles them missing, you can also argue that 
> > supplies are never required.
> > 
> > I'd prefer not to special case regulators as an exception I have to 
> > remember. I have some rudimentary ABI checking I'm working on that 
> > checks for things like new required properties. Though it wouldn't catch 
> > this particular change given it moves the schema.
> > 
> > Rob
> 
> Hi Jonathan,
> 
> According to Rob's answer, do you think that we can move on with the
> last 3 patches as they are or do you want some changes?

Please update the commit message as Jonathan requested and resend 
(though you might as well wait til the end of the merge window now).

Rob

