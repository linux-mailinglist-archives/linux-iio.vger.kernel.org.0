Return-Path: <linux-iio+bounces-27451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467BBCEC7A2
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E585300A291
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6DB3064B2;
	Wed, 31 Dec 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFs4fIBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9C2C0F91;
	Wed, 31 Dec 2025 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206246; cv=none; b=dI7HERih9aC3Mq7l+g3LiOp4xhdrwch39x1Q7LM2P3Ibw4rObvb7cPc20fxbmklvfFWCGNjDtFZWRKZI4TClvztXgxSEgb+yccQY0RYfVzz9z0oGDEIDu/jwsCXlueW2PX4suHUMuKeNjmJRTmQaBN3dtHu218lFU/HfNt3oCxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206246; c=relaxed/simple;
	bh=c2K1GWVI6aXv/1sOYiUUB3P0u920WK8ZhX9MIYwbrWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWznMhsTxQYpPiZhWayCyEtU2Xv5EvbSJungU1dOLO1LXwMx5djNvlFB/JL9vus7/7TuKwmJ5x2V2VyH1wf8Hxc33UKOBkO2qBmpR/CD0GzF2gnYFHgOsQOc6b9rm2QibFRxKvoabknc6s7o5rPNYM/Crkkptx1otkvKpLkz50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFs4fIBp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A09C113D0;
	Wed, 31 Dec 2025 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767206245;
	bh=c2K1GWVI6aXv/1sOYiUUB3P0u920WK8ZhX9MIYwbrWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFs4fIBpphVbbuBGpaNgn5rLItGPNsCmZ/PROr0gKyZSinxsuixSctrMGXuWbrgSZ
	 3RvTpkkKTDs3L895s6DeGJD5cLvekgaJI65lwkKpncDp0i4vgmnGiaJaLDJupH2Spz
	 RY85K746YXcjTa9Vah6cxPMRldHUS97WazsdY556QSOp1aKoen2ptwR2TasQisl8Wu
	 DQagCxCYsoh1ILl3IpTve7rDImNW1lB6Yxty7+2D392oxeqCr7i0mLIZfbmIgtgWXN
	 Bc2vDyykVojmmUq1775695B5ywdpnIPqiuAuqIilYdZQV2YRC4ERiK5YWosRDx07nX
	 F5J01+UtNXcuA==
Date: Wed, 31 Dec 2025 18:37:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <20251231183716.32094776@jic23-huawei>
In-Reply-To: <aVKXyQRczcv64jUO@smile.fi.intel.com>
References: <20251207-honeywell_abp2_driver-v4-0-b52a4b96bbf7@subdimension.ro>
	<20251207-honeywell_abp2_driver-v4-2-b52a4b96bbf7@subdimension.ro>
	<aVKXyQRczcv64jUO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Dec 2025 17:01:29 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Dec 07, 2025 at 08:00:48AM +0200, Petre Rodan wrote:
> > Adds driver for digital Honeywell ABP2 series of board mount
> > pressure and temperature sensors.
> > 
> > This driver covers 113 different pressure ranges and units on
> > both i2c and SPI buses.
> > 
> > The communication protocol involves sending two simple commands
> > to the sensor and there is no register access or a memory map.
> > For this reason the regmap API was not used.
> > 
> > The i2c address is hardcoded and depends on the part number.
> > 
> > Optional end of conversion interrupt control is present on the
> > i2c variants of the chips.
> > The EOC can also be defined for the SPI variants if a non-ABP2
> > but compatible chip is to be driven.
> > 
> > Tested on two sensors (ABP2MRRT001PDSA3 and ABP2DANT001BA2A3).  
> 
> LGTM, one minor thing below,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > +		ret = devm_request_irq(dev, irq, abp2_eoc_handler, IRQF_ONESHOT,
> > +				       dev_name(dev), data);
> > +		if (ret)  
> 
> > +			return dev_err_probe(dev, ret, "request irq %d failed\n", data->irq);  
> 
> Just
> 
> 			return ret;
> 
> as above call already prints an error message.
> 
I've had this one queued for a while now, so Petre, if you don't mind
spinning a patch on top to drop that print that would be great.

Jonathan

> > +	}  
> 


