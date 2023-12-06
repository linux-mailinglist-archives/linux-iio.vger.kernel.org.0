Return-Path: <linux-iio+bounces-679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C762F8076E9
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F911F212AD
	for <lists+linux-iio@lfdr.de>; Wed,  6 Dec 2023 17:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953AD6ABBC;
	Wed,  6 Dec 2023 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPSyVPjn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BC6A004;
	Wed,  6 Dec 2023 17:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C504C433C7;
	Wed,  6 Dec 2023 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701884910;
	bh=b+oE6WsHAnybfoP/OnxbwTMatDU+zF/XLbHsR/CzzPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPSyVPjn+clKvT2z6WZzk3hL6nRgad2xpb/ZK4qhPoA0rRfFFTmK/PwBscyB9/GGI
	 Lk28pcZ5K9zcqfLY+Y6/qbS/y/gnm29uMvwdr+50JMtRK2IMZ/RWSml3ByNiYs4rOV
	 VwU+0vVMKXtKfBYId7Mx/cHkagMcExZrQG2/bn22btiRSo+rgNs8D7IGdkpWFXS35H
	 Nn5FXqfzHolu7igyMSyYCyqXCvQLuz9vLCJ5IdYL7aS/ljsJwwgDKD5r43MEE26Ztk
	 q+9UeKFiy4cLyjlk48+B6lPcARiUN7joF1QuGIdEE2VehctlPiydE9bmwf2XrH6X2u
	 W0SoSDdMpIKhg==
Date: Wed, 6 Dec 2023 17:48:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, linux-gpio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Michael Walle <michael@walle.cc>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Ceclan Dumitru <dumitru.ceclan@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: ad7173: add AD7173 driver
Message-ID: <20231206174817.2bc4f39f@jic23-huawei>
In-Reply-To: <ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
References: <20231205134223.17335-1-mitrutzceclan@gmail.com>
	<20231205134223.17335-2-mitrutzceclan@gmail.com>
	<CAHp75VeKhR5y4AB=L5VVSrm=13Ruw7e86m+K9m9t-LZg5puDow@mail.gmail.com>
	<e72085fd-3203-4166-afab-73707d27d174@gmail.com>
	<ZW9bVDLZl4-QLIbg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Dec 2023 19:18:12 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Dec 05, 2023 at 06:12:18PM +0200, Ceclan Dumitru wrote:
> > On 12/5/23 17:28, Andy Shevchenko wrote:  
> > >> +               ref_label = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_INT_REF];
> > >> +
> > >> +               fwnode_property_read_string(child, "adi,reference-select",
> > >> +                                           &ref_label);
> > >> +               ref_sel = match_string(ad7173_ref_sel_str,
> > >> +                                      ARRAY_SIZE(ad7173_ref_sel_str), ref_label);
> > >> +               if (ref_sel < 0) {  
> > > Can we use fwnode_property_match_property_string()?  
> > 
> > fwnode_property_match_string() searches a given string in a device-tree
> > string array and returns the index. I do not think that this function
> > fits here as the DT attribute is a single string.  
> 
> I'm not talking about that. I mentioned different API call.
> 
> /**
>  * fwnode_property_match_property_string - find a property string value in an array and return index
>  * @fwnode: Firmware node to get the property of
>  * @propname: Name of the property holding the string value
>  * @array: String array to search in
>  * @n: Size of the @array
>  *
>  * Find a property string value in a given @array and if it is found return
>  * the index back.
>  *
>  * Return: index, starting from %0, if the string value was found in the @array (success),
>  *         %-ENOENT when the string value was not found in the @array,
>  *         %-EINVAL if given arguments are not valid,
>  *         %-ENODATA if the property does not have a value,
>  *         %-EPROTO or %-EILSEQ if the property is not a string,
>  *         %-ENXIO if no suitable firmware interface is present.
>  */
> 
Which is in the togreg branch of iio.git (was a patch from Andy that I've queued up)

Jonathan



