Return-Path: <linux-iio+bounces-3263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482E86F1FF
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 20:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983191F21C1C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Mar 2024 19:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6AE14010;
	Sat,  2 Mar 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTcEP1pu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9437168
	for <linux-iio@vger.kernel.org>; Sat,  2 Mar 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406367; cv=none; b=KFFBYr/vsaBMPeE7eBa4jY/YfNCk316eBMK6nDE7HcUgdtpT3sYhfMT8K3Y45Qe19WMisJA01UkETNol++PguLDO7Su7+XZGBbmhdATU5ExoFNnd2CxDtsj/erBDGlfkwY5ejHADTUivonOSe8JeMZwoEXiu3TWiwCi8g0NpRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406367; c=relaxed/simple;
	bh=qzAPvVd4lBA7We63R4lMVkJyuy1fhC6EhSt+3x0+GDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwpQA3axUOGxwQTAvd12Vm3RI99PINsaQqLivYrumFlvibkt3mohQAQ2jYrj4cXoWsMiEYwM0tlQIYZOxHF3oJgCJFSInPxfpgioAGHMK69/I61lIhZFKIiJpA00XCdcSCQTZVp1Eac13g26XQ/jysTTEy9PYGXo1DLolBF0Two=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTcEP1pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049A2C433C7;
	Sat,  2 Mar 2024 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709406366;
	bh=qzAPvVd4lBA7We63R4lMVkJyuy1fhC6EhSt+3x0+GDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTcEP1puikw59YqEry+3iGB8cX9nG2qUp/E7BbUpfS14M0cVTKGVhBLOqPmfcFNgd
	 n0vuH+BxTg6qfaVtkvrdMDN+WFNvdD2ldLlnhSAkOlRuJZsXRSU5QK05FsTsmh7rb4
	 dnuheeVAJb8OF2GtxUWbfV5JwuTE0LL9VJcIy0js=
Date: Sat, 2 Mar 2024 20:06:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set for 6.9 - cleanup.h handling of
 fwnode_handle_put() related (not ordered wrt to PULL 2)
Message-ID: <2024030239-gift-cabdriver-266b@gregkh>
References: <20240229202300.3321cc11@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229202300.3321cc11@jic23-huawei>

On Thu, Feb 29, 2024 at 08:23:00PM +0000, Jonathan Cameron wrote:
> The following changes since commit d4551c189d6e6a3fcf7f625bd4b273e770fad35a:
> 
>   Merge tag 'iio-for-6.9a' of http://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-02-25 14:11:41 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.9c
> 
> for you to fetch changes up to 64e19caa5564ecc43edaa7fb818d53de650d9b34:
> 
>   iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped() (2024-02-28 19:15:43 +0000)
> 
> ----------------------------------------------------------------
> IIO: 3rd set for 6.9 - cleanup.h related.
> 
> I have separated this set out from the more normal patches as they can
> go separately and that may simplify the merge window.  Greg, up to you
> how you wish to handle this in the char-misc tree.
> 
> Introduces __free() based handling for fwnode_handle_put() to
> allow scope based release of these handles on early exit from functions.

This should be fine, right?  No one complains about these.

> Also introduced device_for_each_child_node_scoped() to provide a
> a convenient way to process child nodes without the need to explicitly
> handle the fwnode_handle_put() needed on early exits from the loop.
> Typically these early exits are a result of error handling or completion
> of a search and have proven very prone to being missed.

This is trickier, there was a load of different versions floating
around, do you have a link to the "last" version of this patch series
that got applied here?

> One instance of such a leaked resource was found during these conversions
> though review of that patch was too late for this pull request.

I don't understand, does this series fix that found problem?  Or is it
coming?

> A number of drivers are also converted over to generic fwnode handling from
> the device tree specific version.

Deleting code is always good, but:


> 
> ----------------------------------------------------------------
> Jonathan Cameron (16):
>       device property: Move fwnode_handle_put() into property.h
>       device property: Add cleanup.h based fwnode_handle_put() scope based cleanup.
>       device property: Introduce device_for_each_child_node_scoped()
>       iio: adc: max11410: Use device_for_each_child_node_scoped()
>       iio: addac: ad74413r: Use device_for_each_child_node_scoped()
>       iio: dac: ltc2688: Use device_for_each_child_node_scoped()
>       iio: adc: fsl-imx25-gcq: Switch from of specific handing to fwnode based.
>       iio: adc: fsl-imx25-gcq: Use devm_* and dev_err_probe() to simplify probe
>       iio: adc: ad7124: Switch from of specific to fwnode based property handling
>       iio: adc: ad7292: Switch from of specific to fwnode property handling
>       iio: adc: ad7192: Convert from of specific to fwnode property handling
>       iio: accel: mma8452: Switch from of specific to fwnode property handling.
>       iio: accel: fxls8962af: Switch from of specific to fwnode based properties.
>       iio: adc: hx711: Switch from of specific to fwnode property handling.
>       iio: temp: ltc2983: Use __free(fwnode_handle) and device_for_each_node_scoped()
>       iio: adc: rzg2l_adc: Use device_for_each_child_node_scoped()

You are mixing the two different handlers in this series, right?  How
about 2 different ones, one for each?  Or do they start to conflict?

thanks,

greg k-h

