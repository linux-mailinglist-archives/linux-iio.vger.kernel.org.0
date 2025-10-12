Return-Path: <linux-iio+bounces-25006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142EBD09C7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0775C348380
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDE72F0696;
	Sun, 12 Oct 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy4G4+OC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1292EFDA2;
	Sun, 12 Oct 2025 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760293474; cv=none; b=imHd9OPqi2hEGcJGk80ct1RXVsTKMRPIv4PWyGGr/R/xkyqEsUE/AajLNT+arUQFhqgZGE+i4D7Cj8ROuaxy9UxzjPrmTrHOzJfUVqmAkU6SinzvoedrqKBBJsnjsbbEjuiYheCqJlounoY/0BHdkBEmclySyI8PDUvKbiXx2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760293474; c=relaxed/simple;
	bh=txxPlbpyx3vQKhi9nz3pfg6ck8R1K4SwlLeAQZv2X7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDzjkSxTo71Q7WR8ddH2sqa8MIJA27luqrenJh+iSLUgGlbkgbbAzNYjKUj1ZNMRkTgkRNiBHJ53HUuCvf5+Ea32zkQaDI3uy+LcNIBivb+xQXjA1YWj4KEXpTvZAJ+CshSv0BmdKxWslEbihHjrAlC2DYTDGye2hwj0lkx18oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy4G4+OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED81C4CEE7;
	Sun, 12 Oct 2025 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760293474;
	bh=txxPlbpyx3vQKhi9nz3pfg6ck8R1K4SwlLeAQZv2X7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zy4G4+OCIG/0CdyakHTuZLbFC5q8C1zoD6N1vQKl/4OOToHtevVoYp+TepcMqz5pP
	 HzU+blhg+y7/Y1DeKvV8l2bC4epgP9muK5dnGDQPadfeKmvLrHnZLXT+ZI+AW/Tz+2
	 A0c6Vu+FKUqrmV+1HQjp+LakYH2czp6R6GGbOqQZ58PVhtKvENAdeLfneVeQUIamWg
	 SS75X3zojQIC7ieqk4MVS4eQY4LOhDxYhrDBG5A0YTjezW3Jms+F0H2CF83u0sm+Vs
	 JmlBysNay4kFAWBGvoEHSBL8LP8DIUGYgF1Zkn8qXW0jiicWDIwPWmX+ZEQY+B6d+4
	 Wf3TQ+DbDZWzw==
Date: Sun, 12 Oct 2025 19:24:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Luca Weiss
 <luca.weiss@fairphone.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Jens Reidel <adrian@mainlining.org>, Casey Connolly
 <casey.connolly@linaro.org>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
Message-ID: <20251012192422.46775ad1@jic23-huawei>
In-Reply-To: <0beae4dd-2feb-4891-b7b0-0f63db8f5615@kernel.org>
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
	<c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
	<0beae4dd-2feb-4891-b7b0-0f63db8f5615@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 11:52:43 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi All,
> 
> Luca thank you for Cc-ing me.
> 
> On 10-Oct-25 10:56 PM, David Lechner wrote:
> > On 10/10/25 6:21 AM, Luca Weiss wrote:  
> >> This is an RFC which implements a potential solution to get battery
> >> temperature readings working on for example smartphones with Qualcomm
> >> SoCs.
> >>  
> > 
> > ...
> >   
> >> 3. Add temperature-lookup-table as property to simple-battery
> >>
> >> Since the NTC is a part of the battery pack, adding a
> >> temperature-lookup-table property to simple-battery would make sense
> >> instead of having this lookup table be standalone in the
> >> generic-adc-thermal node. However being able to re-use the existing code
> >> in generic-adc-thermal lead me to the current proposal.
> >>  
> > Did you consider creating a specific compatible string for the battery pack?
> > Then the battery node could have the io-channels property for the ADC
> > connected to the temperature sensor. Then a specific battery driver could
> > handle the conversion as needed rather than filling the devicetree with
> > conversion tables.  
> 
> That will require a driver update, filling the driver (and thus memory)
> with conversion tables each time a new battery model (one model phone
> can have multiple battery revisions) comes out.
> 
> That seems undesirable. To me these conversion tables are very much
> something which belongs in DT rather then being hardcoded in
> the driver.
> 
> Also contrast this to ACPI where there actually is a mechanism defined
> for thermal lookup tables and there all these things typically just
> work when the ACPI tables are written properly. IMHO we want to move
> more towards this direction where things just work without requiring
> kernel code changes for every new model.
> 
> And we already have a mechanism in DT to map an ADC voltage to
> a temperature in the generic-adc-thermal driver.
> 
> So all that is left to do really is to come up with a clean way
> to export the temperature from the generic-adc-thermal driver
> to the generic-adc-battery driver.
> 
> > The simple-battery bindings are already far from simple! So I would not
> > be inclined to add more to it.  
> 
> I think we all agree on this and we also don't want to duplicate
> the generic-adc-thermal bindings + code implementing that functionality.
> 
> IMHO not wanting to duplicate the bindings + functionality applies to
> both: a) directly exporting an IIO temp channel from the ADC driver and
> b) adding volt -> temp mapping functionality to the simple-battery bindings.
> 
> So that basically leaves us with coming up with a way for
> the generic-adc-battery code to consume the temperature coming out of
> the generic-adc-thermal code and there are 2 ways to do this:
> 
> 1. Modify the generic-adc-thermal driver to export an IIO channel

Other than the fact this is embedded in an existing driver, this is just
a case of modelling an analog sensor in IIO. There's an ancient accelerometer
that does this and the analog fronted ends handle things like potential dividers
which are similar but with far simpler DT than this.

So conceptually I have no problem with the approach.

If we were starting from scratch we might have had an explicit representation
of the thermal sensor analog part (like our accelerometer), and then done

Generic temperature device sensor driver is consumer of the ADC channel.
generic-adc-thermal is consumer of the generic temp device sensor.

But retrofitting that split may be a pain (I haven't looked at this though so
maybe not!)



> 2. Modify the thermal-zone core to allow referencing to a thermal-zone
>    with a phandle *and* modify generic-adc-battery to be able to
>    optionally get the temperature from a thermal-zone instead of
>    from an IIO-channel
> 
> Of these two options 1. clear is the most KISS option. SO I agree with
> Luca that 1. as implemented in this series is the best way forward.
> 
> Regards,
> 
> Hans
> 
> 


