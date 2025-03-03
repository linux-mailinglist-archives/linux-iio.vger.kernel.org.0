Return-Path: <linux-iio+bounces-16296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BEA4C3D3
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 15:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E82C3A484E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ECC2139B2;
	Mon,  3 Mar 2025 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="koh+VS9V"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-15.pe-b.jellyfish.systems (out-15.pe-b.jellyfish.systems [198.54.127.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDCC20F07D;
	Mon,  3 Mar 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013347; cv=none; b=ifaxxV8d9UQvDRzXITrPDddLSUYuIsajlf52wFqgoKKxNbb8Y3A66pN63Fw4HIS6jdkYKPVAcdLDStFSFwKyADR6FHgCnbSkI0S9stUdRLRepyfn/WExCj+qVyw+CHEpfuyzUraaBemcdRn05Qds+zzL4eg/2l6x34lgZnIPYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013347; c=relaxed/simple;
	bh=MNjDfqZLSnlJ4xm1Uqst0rrtX/aws1k1MoBULpesUJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFBwtmJUFn7Zv9/hExVqrlqkpD+q1D2R91VQYtnJz417jCFJxl1kURNXCbbF2QYeF0ZRyO9DANZh/AXbh5UuZXFCFYnEd7MnCegl1GjrhjUE5FBPQ9FpKVkGveRiL/jM3ltsBDPf/yUPjk+M9Bwh5ho9si8Lr/9asa+chBf0ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=koh+VS9V; arc=none smtp.client-ip=198.54.127.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z61sk4jcnzDqdL;
	Mon, 03 Mar 2025 14:48:58 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z61sk415dz3hhVZ;
	Mon,  3 Mar 2025 09:48:58 -0500 (EST)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4Z61sk2f4Vz3hhVR;
	Mon,  3 Mar 2025 09:48:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741013338;
	bh=MNjDfqZLSnlJ4xm1Uqst0rrtX/aws1k1MoBULpesUJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koh+VS9VmykpFaBULoB0C+NqkdT4+y+b8faO/4u84hvjEjsCOoxjiJzOCwNaP7BMp
	 fK7EPYV2aiuFmsCZW6esl1kqRLGm5NuPSX5H7FfX8iiZQ8xO/nsMWFPn0BuEP7W8Ra
	 HMoG0l64MLwxFFP8T73zemkcimD1WJ1V2jvHn/UJ9psPMVAlt35rjj5BxIyeMMAP1n
	 MS5sQgXWBXBiabN2zukKls18yQkjMspAnMS8RxuYMuo/+r3mXMJNsZhLh5aXvhADHk
	 ntHjHc+1PuJ3GSvNRhFkurgeE6dWJEbm+5+pjlzh4ZY83ekzr/SrjOUupT3RuMDlpU
	 MdPDbXpkyGOEA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Mon,  3 Mar 2025 09:48:45 -0500 (EST)
Date: Mon, 3 Mar 2025 09:48:46 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z8XBTnNWUh54FxS6@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
 <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
 <Z79K8Ag4SJYtJTtM@65YTFL3.secure.tethers.com>
 <05e56d15-059b-425b-9e55-66993d988f8d@kernel.org>
 <Z7-SojPPx3kOVa4y@65YTFL3.secure.tethers.com>
 <8fef9b19-a1de-4153-a186-1aeee87dea9d@kernel.org>
 <Z8WvKNcCnQI_UYZJ@65YTFL3.secure.tethers.com>
 <b3f98745-39c3-4b1f-a0e6-51e5138d840c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f98745-39c3-4b1f-a0e6-51e5138d840c@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Mar 03, 2025 at 03:16:00PM +0100, Krzysztof Kozlowski wrote:
> On 03/03/2025 14:31, Sam Winchenbach wrote:
> >>> This prevents the situation where your fundamental frequency falls on, or close
> >>> to, a corner frequency which could result in 3dB (half power) loss in your
> >>> signal.
> >>>
> >>> This is all completely indepent of the high-pass filter.
> >>
> >> Description is confusing a bit, because it suggests the value sets the
> >> corner frequency. It explicitly says this - "sets ... corner frequency"
> >> and such meaning for properties we usually associate with the property
> >> doing this. Here however corner frequency will be always set to rf_in
> >> and you just adjust the value.
> >>
> > 
> > How about: "Sets the minimum distance (in Hz) between the fundamental
> > frequency of `rf_in` and the corner frequency of the high-pass, input filter
> > when operatred in 'auto' mode. The selected high-pass corner frequency will
> > be less than, or equal to, `rf_in` - `hpf-margin-hz`. If not setting is found
> > that satisfies this relationship the filter will be put into 'bypass'."
> > 
> > Perhaps that is a bit more clear on the intention of this parameter?
> 
> Yes

I will update with this wording.

> 
> > 
> >>>
> >>>>
> >>>>> them as separate controls but I am happy to put them into an array if that is
> >>>>> the idiomatic approach to situations like this. That said, I am having a
> >>>>> difficult time getting dt_binding_check to pass when I have an array of uint64.
> >>>>>
> >>>>> When listing two items, as in your example below, I get the following:
> >>>>> adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long
> >>>>
> >>>> Tricky to say without seeing your code. Magic crystal ball had
> >>>> malfunction today.
> >>>
> >>> This is the property:
> >>>
> >>>   adi,filter-margins-hz:
> >>>     items:
> >>>       - description: |
> >>>           The minimum distance, in Hz, between rf_in and the low-pass corner
> >>>           frequency when the device is used in "auto" mode. If the sum of
> >>>           rf_in and this value is greater than 18.85 GHz then the low-pass
> >>>           filter will be put into bypass mode, otherwise the closest corner
> >>>           frequency that is greater than or equal to the sum of rf_in plus this
> >>>           value will be used.
> >>>         minimum: 0
> >>>         maximum: 0xFFFFFFFFFFFFFFFF
> >>>         default: 0
> >>>       - description: |
> >>>           The minimum distance, in Hz, between rf_in and the high-pass corner
> >>>           frequency when the device is used in "auto" mode. If the difference
> >>>           between rf_in and this value is less than 1.75 GHz then the high-pass
> >>>           filter will be put into bypass mode, otherwise the closest corner
> >>>           frequency that is less than or equal to the difference of rf_in and
> >>>           this value will be used.
> >>>         minimum: 0
> >>>         maximum: 0xFFFFFFFFFFFFFFFF
> >>>         default: 0
> >>>
> >>> And this is the example:
> >>>
> >>> examples:
> >>>   - |
> >>>     spi {
> >>>       #address-cells = <1>;
> >>>       #size-cells = <0>;
> >>>       admv8818@0 {
> >>>         compatible = "adi,admv8818";
> >>>         reg = <0>;
> >>>         spi-max-frequency = <10000000>;
> >>>         clocks = <&admv8818_rfin>;
> >>>         clock-names = "rf_in";
> >>>         adi,filter-margins-hz = /bits/ 64 <30000000 30000000>;
> >>
> >>
> >> foo-hz is in 32-bit, so basically you have here 4 32-bit numbers which
> >> indeed reported by dtschema - property is too long. Drop 64-bit here.
> >>
> > 
> > I was hoping to keep this 64 bits seeing this is a 18 GHz+ filter. I suppose
> > I could change this to MHz and just lose a bit of resolution. Does that sound
> > like a better approach?
> 
> Does the hardware accept Hz resolution? How many bits do you have in the
> registers per each value?
>

This isn't necessarily abour the hardware accepts, more about the tolerance
of the application. A user could, for example, require that the corner
frequency is at least 500 kHz from the fundamental, or the user could require the
corner be at least 6 GHz from the corner. A lot of it depends on the bandwidth
of the design. Changing this to MHz would be likely be fine. The average user
would likely specify 10's if not 100's of MHz in this field.
 
> Anyway, the value was 32-bit even in your original patch and your DTS
> example was not correct.
>

Was it incorrect because I chose a value less than 2^32? I believe this expands
to 64 bits:
+        adi,lpf-margin-hz = /bits/ 64 <30000000>;
+        adi,hpf-margin-hz = /bits/ 64 <30000000>;

Is it more appropriate to specify it like this?
        adi,lpf-margin-hz = <0 0x1c9c380>;

> 
> > 
> >> Device allows multiple LPF/HPF values to be stored in LUT tables and it
> >> actually has four independent filters. Shouldn't these be included here?
> >> Maybe not LUT tables, but the configuration for all filters?
> >>
> > 
> > There are two filters, the input (high-pass) filter, and the output (low-pass)
> > filter. Each filter has four banks, each with a different range of frequencies.
> > Only one bank can be selected at a time. Each bank has 16 different possible
> > cutoff/corner frequencies. That is a total of 64 distinct values for each of
> > the two filters.
> 
> Hm, datasheet says:
> "four independently controlled high-
> pass filters (HPFs) and four independently controlled low-pass
> filters (LPFs)"
> 
> so four each, not one each, but I guess they wanted to say banks as only
> one filter/bank can be active in given time?
>

Correct. On the first page you can see that each of the 4 filters is selected
by a multiplexer/demultiplexer - the 5 options are: bypass (pass the signal)
band 1, band 2, band 3, band 4. You can see this on p. 30, register 0x20.

Register 0x21 selects which of corner is used on the selected band.

> > 
> > The issue with setting the corner frequency directly is that in certain
> > applications (such as software defined radios) the fundamental frequency
> > is adjustable, necessitating that the corner frequencies of the filter are
> > adjusted accordingly. When the filter is in "auto" mode it is notified via
> > the clock system of frequency changes, so using this information it should be
> > possible to select new corner frequencies if you know the minimum distance
> > between your fundamental frequency and the corner.
> 
> I am not advocating to set the corner frequency directly, but just
> pointing that your current binding seems incomplete.
>

I see. Let's see if we can come to an agreement on this then. I think this
would be a useful feature for others.

Thanks,
-Sam
 
> 
> Best regards,
> Krzysztof

