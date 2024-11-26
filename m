Return-Path: <linux-iio+bounces-12694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F509D9CF5
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 18:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710C2168E22
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B251DC05F;
	Tue, 26 Nov 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9tP9kc4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE39D299;
	Tue, 26 Nov 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732643759; cv=none; b=VupR/XvGGAJPbH6oxqwEtpE7yMCWlN8mv4l/dZWHxXEkI04eFPcIljk/XaoHbqL0aQAoPZNcecc43nuFq6pP1x2HunwcocQTSgaI4rkMekkJTiBTbYdVMI+2VhXUo+jW0JnE4N4RGk7TCE1E/DKqrcsIYqaPJmnZdvAfEBobg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732643759; c=relaxed/simple;
	bh=sTKoC9YKhu+oFp76F51sgmnd3VaGGAems4jRqoVjgJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIcCIsLioQ30NnaFjY9NO6kZyXtWeqxEkVgqyJlOtS/VB89NwGrkj0CLm9OiJMKx+/HY5dc09P/aA3JTM1m2NRv05HpTrDCKEqTbJvA5MXcGt5J4U4IQm5ld3bd5SPC93vXfbEgK+FX7iBsrXmKtZ3xZxQbp8LynCCfHYbVpczM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9tP9kc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C682BC4CECF;
	Tue, 26 Nov 2024 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732643758;
	bh=sTKoC9YKhu+oFp76F51sgmnd3VaGGAems4jRqoVjgJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P9tP9kc45VwSR3Kgvb34ekHuEUF2+b0X76qO1aHly2FoCCy7OVJHDPjMBGzTEMWYy
	 aZsMhw9IpPtsV/d2IhBeqLlVdjyUREVMCR7nX24UKdaY0eiWh8DPNYtng7hfcWzm4G
	 jmCbGe96AiwD/4FFm66CE6avYG+Xgrsh1NHpvQi+tXFbBWvQG4riFUQ/ioJVTa8dkD
	 9mCWmOzXCM+QiBanfcmnfVY6sS+44M7lD3rf/hwc6VX1hkph/J9/JZrO94/gw3hHdX
	 fUqgk+2NpgZykIBFb5N0rfb3tdHuxSMeHJ+ilRqX9i1DUuZZEUZJJ3HCVqrV+ivP03
	 mjkNcl+SSoqDw==
Date: Tue, 26 Nov 2024 17:55:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <20241126175550.4a8bedf3@jic23-huawei>
In-Reply-To: <bda7eaff-1315-46d0-83b4-a14060c2af1c@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
	<20241123164223.25656985@jic23-huawei>
	<bda7eaff-1315-46d0-83b4-a14060c2af1c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 11:34:36 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hello Jonathan,
> 
> Thanks again!
> 
> On 23/11/2024 18:42, Jonathan Cameron wrote:
> > On Thu, 21 Nov 2024 10:20:23 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> A few functions in KX022A need to use mutex for protecting the
> >> enabling/disabling of the measurement while configurations are being
> >> made. Some of the functions can be slightly simplified by using the
> >> __cleanup based scoped mutexes, which allows dropping the goto based
> >> unlocking at error path.
> >>
> >> Simplify error paths using guard(mutex).
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > Now we have guard(), the main reason (I think) for the
> > combined on + lock and off + unlock paths is gone. So can
> > we just flatten those and do the locking at caller.  
> 
> I did consider this too :)
> 
> Why I decided to keep it as it is, (even though we need the extra 
> mutex_unlock() at certain error path) is because I kind of like the 
> lock+off and unlock+on functions. This locking does not protect data, 
> but really a sequence of operations that needs to be done while sensor 
> is OFF state. It's almost like a doc saying that "please, ensure the 
> sensor is OFF for the following operations" :)

hmm.  I really don't like them because they are 'unusual'  :)

I'd argue they just ensure a sequence of writes go in as an atomic thing.
Two of those writes happen to be turn it off and turn it on.

So the data the are protecting is the device internal state data.

> 
> (Another thing is that we do claim the direct mode in write_raw, and 
> goto is still handy for releasing it. Scoped guards won't play nicely 
> with goto. Yes, we could probably use the __cleanup for direct mode, but 
> I still like the lock+off, unlock+on for the reason above)
There is a nice new cleanup that David did to make the direct mode
handling much cleaner.

	if_not_cond_guard(iio_claim_direct_try, indio_dev)
		return -EBUSY;


> 
> Yours,
> 	-- Matti
> 


