Return-Path: <linux-iio+bounces-9334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A24970877
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FC18281FFF
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 15:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39341741C6;
	Sun,  8 Sep 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM4S4/AP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861FEACD;
	Sun,  8 Sep 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810589; cv=none; b=jvaEtjfiPD0T3zcHgTUXc9T18oVaxOiOUTMfap23piJtyAaM/NMLiwRPz6isN0kvNUHCzv0EFqzFoEPpbQrKpfFbJi4kayl/ua1Arx3OAARjT5WeYj1ns16NOTSLJPL1wM6V3tj6RWX4UP2YFDAPv/eSLE6Z0uz2f1r7Jsx/SLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810589; c=relaxed/simple;
	bh=uF5GTxQGmCiuSohan05MCMU7ExDA98etESDDUUWTaAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUcFhTf2wM3RBcVTokKD4N0b1Rm9nJ1gVPAEE00YlK63i7hI+zvD1rX7zFH/9eiZ/pcsQehcd4u9iAd8gFrT9hIB8c9ZpqvEo+YWJl0R7kLXv6X21xSaXFuNaJmw4+Voagti1PZVY11JWRlaVikH3tUvetLilZQ7ARkz4SS2Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM4S4/AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150D3C4CEC3;
	Sun,  8 Sep 2024 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725810589;
	bh=uF5GTxQGmCiuSohan05MCMU7ExDA98etESDDUUWTaAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RM4S4/APJ0V/QTwLTpEvGUO0iNQUw3suzFDiLESMpA0r0Ki95CrdZDxFM6JolR8DX
	 eg9v3T5LOGWndKF1EBC/6zNbngnupzS434DEevOlruKOiKFMZOVS6c+LEA6Erd8tU+
	 vROqKc1XPuWEf0+bUPBIipjbcKtY957I4xpmW+2cRjEkj/xiEzJRDwv+h8KWa6SavY
	 CmxQ3Ud4CF3s0JmZAbhcSPu664ZQ96kRoCZinaXDHBbyGNHZJ9SCZ69Hz2PqWpcbbZ
	 R3TaOHWBinCBfRIAIruaCdBL/WC/jGv8fR+Xy73ym+2G//Gaw/WkOCN3fZxKrclt+j
	 cyY6Mp8zlQA1w==
Date: Sun, 8 Sep 2024 16:49:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] iio: dac: ad3552r: add axi platform driver
Message-ID: <20240908164940.7c4ffb8a@jic23-huawei>
In-Reply-To: <b289a789-0440-4c1f-9f75-6d7e8e04189d@baylibre.com>
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
	<20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-8-87d669674c00@baylibre.com>
	<b289a789-0440-4c1f-9f75-6d7e8e04189d@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Sep 2024 15:40:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> 
> ...
One reply to a comment David made.

Jonathan

> 
> > +		 */
> > +		if (st->single_channel)
> > +			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 4);
> > +		else
> > +			clk_rate = DIV_ROUND_CLOSEST(clk_rate, 8);
> > +  
> 
> Having the sample rate depend on how many channels are enabled in
> the buffer seems a bit odd. Sampling frequency is not strictly
> defined in IIO, so I think it would be fine to always return the
> same value no matter how many channels are enabled.
> 
> We will just need to document that the sampling frequency is the
> rate per sample, not per channel. So if two channels are enabled,
> the effective sampling rate per channel is 1/2 of the sampling
> rate reported by the sysfs attribute. 

There is an oddity around this that we've never cleared up fully.

In my head at least if there is a single sampling_frequency it
applies to 'scans', not individual channel reads (so would change
with the number of channels enabled).  If there
is a per channel attribute we do have documentation:

What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
KernelVersion:	5.20
Contact:	linux-iio@vger.kernel.org
Description:
		Some devices have separate controls of sampling frequency for
		individual channels. If multiple channels are enabled in a scan,
		then the sampling_frequency of the scan may be computed from the
		per channel sampling frequencies.

For many devices the sampling frequency isn't down to each sample taking
N microsecs and them running back to back, it is instead a function of
a periodic sampling start for samples that take the same time whatever
the sampling frequency.  Also for simultaneous sampling ADCs it is never
channel dependent.

So I think if you want to avoid the confusion, make your device fall into
the description above and provide a per channel attribute rather
than shared_by_all.

Or keep it as things stand and have it halve when you double the channels.


> 
> > +		*val = clk_rate;
> > +
> > +		return IIO_VAL_INT;
> > +	}

...

