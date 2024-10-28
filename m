Return-Path: <linux-iio+bounces-11483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5C9B34E9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7432E1C22573
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE411DE4C4;
	Mon, 28 Oct 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="jVywxTyH"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A71DE4C5;
	Mon, 28 Oct 2024 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129387; cv=none; b=ambMu5vQeAsbmoz7qIckmztQHDuDX/eiah9XYUwo98sAKpatl4RZQ6qeDRi4GM1KO7r09qezLIa6KCa83Dx/QtWArcrCaaxWV8xPL4r3Lp/7GxXy28Tr24u80urDVBaaQjThR1ysHhfYj8rfsUrX4GtDvuP5TMt3LmA96oq7lOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129387; c=relaxed/simple;
	bh=wifIcVMtJD+gpqhF+iFfePB5DyfuLONbv5qlebYjHGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt6lssRLREkp6nn+CaVK6vy+Rj87zf511gBRTJDL0vAwPXtDhuiR8Vigi/r/wqIwCCFELsINMlBZo+6/e45T23thdUJ7GZfqAoY9FneU4ZWft0+JlhS3QLkZrbEYA5ln/J64qgH+ptudcVrsPOOLPx8hX+CGqJbQieCyqMBGc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=jVywxTyH; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 3538F4C76F;
	Mon, 28 Oct 2024 15:29:43 +0000 (UTC)
Date: Mon, 28 Oct 2024 11:29:35 -0400
From: Aren <aren@peacevolution.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Kaustabh Chakraborty <kauschluss@disroot.org>, =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <trabarni@gmail.com>, 
	Ondrej Jirman <megi@xff.cz>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: light: stk3310: log error if reading the
 chip id fails
Message-ID: <xcavh66uxpl2orehtlzsy4g4udr3p2yqsq5pyhmxdqdmnegsvq@jpomr2uuwspz>
References: <20241028142000.1058149-1-aren@peacevolution.org>
 <20241028142000.1058149-6-aren@peacevolution.org>
 <Zx-jj8FEldW6sG55@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx-jj8FEldW6sG55@smile.fi.intel.com>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730129384;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
	bh=waIkFoDc9o8tfquUd+Jq31IwxgRT/dvr5qXaHNOIhWo=;
	b=jVywxTyHeY6lKYwG8i5PTfRP/7qZwmdlQe7GjZlWL0oBVH5yipYwH0z6jwVEfzm6YjPqk8
	gD+QZ9a2OSgNOTu0Ydxk0hym7qiQlZM7vBDKXI2RHM2VSizmYwd/IrLHHRl+jsFlfB392V
	/MbvO8kGCGYKOPs6UdalfnYcS8tHJYM=

On Mon, Oct 28, 2024 at 04:45:35PM +0200, Andy Shevchenko wrote:
> On Mon, Oct 28, 2024 at 10:19:59AM -0400, Aren Moynihan wrote:
> > If the chip isn't powered, this call is likely to return an error.
> > Without a log here the driver will silently fail to probe. Common errors
> > are ENXIO (when the chip isn't powered) and ETIMEDOUT (when the i2c bus
> > isn't powered).
> 
> The commit message does not explain why dev_err_probe() has been chosen
> and not simple dev_err().

This function is only called from stk3310_probe, and this condition
should propagate it's error, so it fits what dev_err_probe is designed
for. dev_err would be pretty much equivalent just longer, like this:

if (ret < 0) {
	dev_err(&client->dev, "failed to read chip it: %d\n", ret);
	return ret;
}

Regards
 - Aren

