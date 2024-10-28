Return-Path: <linux-iio+bounces-11517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85189B3B29
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 21:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DB11C21518
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 20:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED391E0095;
	Mon, 28 Oct 2024 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvtFQNq9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DA18EFC9;
	Mon, 28 Oct 2024 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146505; cv=none; b=etX/Nb7VP+ti0DaidS9T9LqpcQFYXxGglQ/sV2pJg9HNxB2uPjMEdgmMGqqllECQe/ToLMoKPn+mKxjDgLaJifWmLxXjAux8V4LdVhV7SQz+PrIqzE1U62AdeT1EjwpboYgXKXJ4LlW7F9frzaZLcEghMck1eNzCv0zh/CUNeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146505; c=relaxed/simple;
	bh=whISxXDf5ID2P0Jc0MdITHMQx1esHpJCMds7XrTvxtg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjU7EsG8u79fQsnM8q7MfEnAcGoFs2rJs+9yFw5046X3iX6o1fptLgdm5TscO/FJRR2yVPRiIvdmLuHdhiRqqIbQ3V20M0D7oAiBM1pQ+K0HyFe0cWSeByhwwhYxMyXFxD9qfdyM3hEPjCNPAMRovTSt3rbc2o56Kyf56ceAk60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvtFQNq9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F383C4CEC3;
	Mon, 28 Oct 2024 20:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146504;
	bh=whISxXDf5ID2P0Jc0MdITHMQx1esHpJCMds7XrTvxtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mvtFQNq9qlbmGoEADh/bcgd4NgpUABacZWDHN078zcPBdkD8bZgzz4brM0yB1H0TM
	 5I4Jh55vXzbWgePongy9zhrzf+ojew+WCM7/OjI2ZDS1WJiaXRke7zeDyytRE9RN6H
	 YmP+ZeNvMZUtO01XajYsl1qEealTbBHtBj+5OzxVpBYLHCqkCD2M1ZdECPw191Jkca
	 r4FRcZ+ike4kwseGHhcZklkfjf8uqFh+El5TWBD6UcCSJ3vfjlGP9vU5+5t2hjzNRR
	 kn8x0A4OOHQGx+15EIIlvFDuXrZyuZD/SDZgrOKuvxr2QFlpf0Ux9Qkm+5vwnUue7x
	 E5Rg5fnv/yGkQ==
Date: Mon, 28 Oct 2024 20:14:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Justin Weiss <justin@justinweiss.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxlcg==?=
 <philm@manjaro.org>
Subject: Re: [PATCH v4 2/4] iio: imu: bmi270: Add scale and sampling
 frequency to BMI270 IMU
Message-ID: <20241028201456.0cbfa75b@jic23-huawei>
In-Reply-To: <Zx9aR2h9pjdIMglO@smile.fi.intel.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
	<20241027172029.160134-3-justin@justinweiss.com>
	<Zx9aR2h9pjdIMglO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 11:32:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Oct 27, 2024 at 10:20:23AM -0700, Justin Weiss wrote:
> > Add read and write functions and create _available entries.  
> 
> ...
> 
> > +static int bmi270_set_scale(struct bmi270_data *data,
> > +			    int chan_type, int uscale)  
> 
> There is available space in the previous line, (And I would even join them
> despite being 83 characters long.)
> 
> ...
> 
> > +static int bmi270_get_scale(struct bmi270_data *bmi270_device,
> > +			    int chan_type, int *uscale)  
> 
> Ditto (for chan_type).
> 
> ...
> 
> > +static int bmi270_set_odr(struct bmi270_data *data, int chan_type,
> > +			  int odr, int uodr)  
> 
> Ditto.
> 
> ...
> 
> > +	for (i = 0; i < bmi270_odr_item.num; i++) {
> > +		if (bmi270_odr_item.tbl[i].odr != odr ||
> > +		    bmi270_odr_item.tbl[i].uodr != uodr)
> > +			continue;
> > +
> > +		return regmap_update_bits(data->regmap, reg, mask,
> > +					  bmi270_odr_item.vals[i]);
> > +	}
> > +
> > +	return -EINVAL;  
> 
> Wouldn't be better to use regular patterns, i.e. checking for errors first?

Hmm. This was my suggestion :(. For a simple case of match and do
something if true, this is a reasonably common pattern - particularly
in cases where there is a fallback option. I.e. you'd do something
after the loop only if there is no match.

Anyhow, given I suggested it I feel mean asking Justin to revert
to what he had in the first place.  I don't feel that strongly about it
though so if the two of you agree this is neater, send a follow up patch.

Tweaked the line wraps whilst applying.
> 
> 	for (i = 0; i < bmi270_odr_item.num; i++) {
> 		if (bmi270_odr_item.tbl[i].odr == odr ||
> 		    bmi270_odr_item.tbl[i].uodr == uodr)

That would be a bad idea && is fine though .

> 			break;
> 	}
> 	if (i == bmi270_odr_item.num)
> 		return -EINVAL;
> 
> 	return regmap_update_bits(data->regmap, reg, mask, bmi270_odr_item.vals[i]);
> 
> ...
> 
> > +static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
> > +			  int *odr, int *uodr)  
> 
> As per above.
> 
> > +	for (i = 0; i < bmi270_odr_item.num; i++) {
> > +		if (val != bmi270_odr_item.vals[i])
> > +			continue;
> > +
> > +		*odr = bmi270_odr_item.tbl[i].odr;
> > +		*uodr = bmi270_odr_item.tbl[i].uodr;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;  
> 
> As per above.
> 


