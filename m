Return-Path: <linux-iio+bounces-792-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5678E80BA9E
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 13:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A96280D53
	for <lists+linux-iio@lfdr.de>; Sun, 10 Dec 2023 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB645C131;
	Sun, 10 Dec 2023 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJlbcfpx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A490BC130
	for <linux-iio@vger.kernel.org>; Sun, 10 Dec 2023 12:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF45EC433C8;
	Sun, 10 Dec 2023 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702210599;
	bh=86Fb/TnZD6UZ4D6D/ON2+9C91eIICKisOjrDG7Nsb38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJlbcfpxB+33Duifi28ytoTIWRIg4aSukwbAMIXaWrASDRlHvATPvQYn3kWGO0251
	 p4eq9KCsXj+4qwLE1p+DKyEf5oB+X3f9fC+JwXVqEy3fvqlg/3mWFjWXSNXQC3hVAN
	 QxVqnAY8wp+2R+LNOyl/8j5iyoRJvqe/L3AZarS4ZMvFKfi1PNJ4BK+mIOEiqvS6zI
	 NhrqqJgXzsjZqERXoJ1nbaPsxQWEpw78rxpvrAXADS9y8ae0jNge/D/xSycJTlqM8W
	 N/NzaK0bNAniXPIDqg5LzUt+mW94CV8H8doZBTYsxThnZfhktgRDHWdSXyJSOh/4Y6
	 yARn9ck4xhnOw==
Date: Sun, 10 Dec 2023 12:16:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Angel
 Iglesias <ang.iglesiasg@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andreas Klinger <ak@it-klinger.de>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231210121632.12ff9640@jic23-huawei>
In-Reply-To: <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
References: <20231207164634.11998-1-petre.rodan@subdimension.ro>
	<20231207164634.11998-2-petre.rodan@subdimension.ro>
	<ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 20:30:42 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Dec 07, 2023 at 06:46:29PM +0200, Petre Rodan wrote:
> > Adds driver for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors.
> > Communication is one way. The sensor only requires 4 bytes worth of
> > clock pulses on both i2c and spi in order to push the data out.
> > The i2c address is hardcoded and depends on the part number.
> > There is no additional GPIO control.
> > code is now based on iio/togreg  
> 
> There is room to improve, but I think it's good enough to be included and
> amended later on if needed.
That's almost always true :)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
Thanks

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it and see if it can find anything we missed.

Thanks,

Jonathan



