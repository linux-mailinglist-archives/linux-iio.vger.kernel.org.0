Return-Path: <linux-iio+bounces-9412-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE09972268
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 21:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470391F24733
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B5A189BA3;
	Mon,  9 Sep 2024 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkjecQqo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56C189906;
	Mon,  9 Sep 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909235; cv=none; b=pASxIYsCQ4VE+F2t9zGjOXYC1B6gXPXzqPQWN2E4elShO72is2cVmhSGMHBOFlXC9uWHjdGoxN7ltMAnHc7gb0WUA6vDqA39Ka7zQeIb3vHhbD1UID3WZ30w9lO/IQSKJzO0wiFgutxVyQs6ompbOsLQCMxkNlgYQGfaHpz90Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909235; c=relaxed/simple;
	bh=9Ke2ArOo2gr90QqZY9uppJ7gtlkgzGFnT4r0ZiA+MGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5hbr5rMT7KoXm1sow89Y8K+Xsi2cBMnxWVutRv8DIpZW4SBTfKyb7cxOUk4jVJdJbeMgPMWzKMNhWWrHGdjBgW8TFr5+TYcV2q3aHfTMwYxSyPt9VHTOU9TjVTMTOrj7WUySxXNMI9QCgO6gUPxN8xSp3HJrNhnEtbw7Lk1cjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkjecQqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317AC4CEC5;
	Mon,  9 Sep 2024 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725909235;
	bh=9Ke2ArOo2gr90QqZY9uppJ7gtlkgzGFnT4r0ZiA+MGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PkjecQqoRQk5+VmUT7iAlfyyI9qCnw0zW6vh3u0RX60GhKGQ0BsYvly3rH0mekAdn
	 Peu5SVVO3wWs9HOhf7WgK3YMaVOSKyPlg8m6Zt/TWtM0egnfS5EA0IKwPRPdIzIpxc
	 gZrLAbPuN5bKQKlK7Ihj/HDXsSktLnHX5ByN0AbfwjsrPPmcj0xJM+zuX0MnT48qsh
	 FUQChlbLt9usMRDqp+DLsZdJb0DLieutPK3lUmk1qnfWyMeb7C5gzEhhZW1owV6DHY
	 neNn8X9Arrgba7ildmX5D7an/NaKMhcctm4xGZ+xSPA+Dfubw/G/KEHKNjvqVwbKkS
	 ynKIluCEK8RjQ==
Date: Mon, 9 Sep 2024 20:13:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Emil Gedenryd <Emil.Gedenryd@axis.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "dannenberg@ti.com" <dannenberg@ti.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
 <lars@metafoo.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel
 <Kernel@axis.com>
Subject: Re: [PATCH 2/3] iio: light: opt3001: add support for TI's opt3002
 light sensor
Message-ID: <20240909201346.5ee793d2@jic23-huawei>
In-Reply-To: <8361d77321d503b9690c40bb4f4293782c7ca5b4.camel@axis.com>
References: <20240905-add_opt3002-v1-0-a5ae21b924fb@axis.com>
	<20240905-add_opt3002-v1-2-a5ae21b924fb@axis.com>
	<20240907183518.1e8ee0bf@jic23-huawei>
	<8361d77321d503b9690c40bb4f4293782c7ca5b4.camel@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Emil,

> > > diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> > > index 176e54bb48c3..e6098f88dd04 100644
> > > --- a/drivers/iio/light/opt3001.c
> > > +++ b/drivers/iio/light/opt3001.c
> > > @@ -70,6 +70,19 @@
> > >  #define OPT3001_RESULT_READY_SHORT	150
> > >  #define OPT3001_RESULT_READY_LONG	1000
> > >  
> > > +/* The opt3002 doesn't have a device id register, predefine value instead */
> > > +#define OPT3002_DEVICE_ID_VALUE		3002  
> > 
> > Why?  Just make the code not care about the value for this
> > device.  Add a flag to the chip info structure to say it doesn't have
> > one and check that before using it.  
> 
> The device id is used to log the model. Should I not log the
> model for the opt3002 then or should I have the callback just return
> 3002? I thought it would be cleaner to have the id value as a defined
> constant instead of a "magic" number in the code. Is there a preferred
> way of doing it?

Given the lack of register means you can't check the model, don't
report one at all. So don't print that message for this
device.

For future replies crop out anything that doesn't need a reply.
Saves a reader having to scroll and potentially miss something
important!

Thanks,

Jonathan

