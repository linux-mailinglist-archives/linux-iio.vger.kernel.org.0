Return-Path: <linux-iio+bounces-16376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC7EA4EA3B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 18:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD38C177B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B976238D45;
	Tue,  4 Mar 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="BC8YDrCe"
X-Original-To: linux-iio@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91802C1555
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108960; cv=pass; b=aQ8Wvya1hmtpXQvlZLmz20aOIzRR981izkRecAZWxWcEGa3BViC88XNxGXTj7gYrNXSg0ENB09YBlOD2muV6l6d5gbARAIbdRsVWQ/jKDe2EyAQkypr5pkilAYhSbgpXnu1RCmOlNJL22RaNfwVq5QagzIKuoLJOXPO/ypxPkmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108960; c=relaxed/simple;
	bh=UnlZRIn1+XWnSfw2pYOSnNaYsdX5WURIf+Hn25tK/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKzsBk+ON+lWpDJrIJYdxa/JajGxf14kUhCYG/wjSdmuzTlBSrotkRrgurhbDkOFkZeXDewWe2pwpQ+oob2Wazd+Bh37KyKftuGrFWR0FM+3iFvGXl/jRWdkBPdRzWMSe2rC8o6bCl5yEJN1d4qc0D3wYLDOF+Qyc7VbMsiUl5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=BC8YDrCe; arc=none smtp.client-ip=198.54.127.93; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 1C54A408B65B
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 20:22:37 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h9N45wRzG3k1
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 19:34:48 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 824234272E; Tue,  4 Mar 2025 19:34:43 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=BC8YDrCe
X-Envelope-From: <linux-kernel+bounces-541822-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=BC8YDrCe
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DEDCC41E8B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:36:53 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 733973064C0E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:36:53 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848DC3AF605
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86002116F3;
	Mon,  3 Mar 2025 13:31:46 +0000 (UTC)
Received: from out-16.pe-b.jellyfish.systems (out-16.pe-b.jellyfish.systems [198.54.127.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42881EFFB4;
	Mon,  3 Mar 2025 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008702; cv=none; b=o6hsK9YYy11DnD97wF4NFW8mrXTkvnqDoLkIjGms5BUK4y4qCO7DNJ31AAj6nGjlzmGT9AA9aAoxZKKuEVDMU5BQLQHekcY/vjt2CpNPfVBtyqE+hi1r2ctbJvFFAxYBWpq4OIrsGfR5oK2nkeOWO0bJ7qLt6PVNyw59eee6VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008702; c=relaxed/simple;
	bh=UnlZRIn1+XWnSfw2pYOSnNaYsdX5WURIf+Hn25tK/2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6RhhgY0UqBUoyD4OEUpT+/tap51H+AczqOQzJbamC62qJlJjg7Awa+K8dAk4dX5EhVNoUIovBNtXLDr2mvUqNFUZLjVBi6iCI6joDXTsbazOxlrhtL5lpXhWHAxpVgXX4zZUEar9e/I4Cq9V5lnjmhzwgdV/HeKw4aotruZ4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=BC8YDrCe; arc=none smtp.client-ip=198.54.127.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z608P5BGyzGpYK;
	Mon, 03 Mar 2025 13:31:33 +0000 (UTC)
Received: from MTA-07.privateemail.com (unknown [10.50.14.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z608P4NQBz3hhVZ;
	Mon,  3 Mar 2025 08:31:33 -0500 (EST)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 4Z608P32p7z3hhV0;
	Mon,  3 Mar 2025 08:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1741008693;
	bh=UnlZRIn1+XWnSfw2pYOSnNaYsdX5WURIf+Hn25tK/2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BC8YDrCeBCA/KChWY4EPrqKy7A8fAYwy+Odi1ANXa/vnIoSfJ86AKOezwBHBlU/46
	 gffQinnck9bZMc20Me2sACxi5KJZSUKoeY5xRqVbofOYv+xPK1EQtg8fA+6ytJlrvG
	 N+educh4GpHUNmLKFpEHqQBRAXm7Nd8/aleKHc18EJnrvz2pkXzMhhwC+gxU8yPHqF
	 C5Z6EFIyQBntvKoEPbXztVuQgrdjkrqf6LHsb5UkUaD5BYvQ3jwEbhG5cbPc8ZJFw2
	 ky9QsmK4nWX4VTQ5gkTzjytiLFL0VDnM0Rvk4gUby1LYO+JQE7U4YfTQ5znWPO6pE8
	 PaHrEAKa20zZw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Mon,  3 Mar 2025 08:31:20 -0500 (EST)
Date: Mon, 3 Mar 2025 08:31:20 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z8WvKNcCnQI_UYZJ@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
 <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
 <Z79K8Ag4SJYtJTtM@65YTFL3.secure.tethers.com>
 <05e56d15-059b-425b-9e55-66993d988f8d@kernel.org>
 <Z7-SojPPx3kOVa4y@65YTFL3.secure.tethers.com>
 <8fef9b19-a1de-4153-a186-1aeee87dea9d@kernel.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fef9b19-a1de-4153-a186-1aeee87dea9d@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h9N45wRzG3k1
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713644.55012@ZezFI5HxBaXe7sievDh4uw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 09:13:00AM +0100, Krzysztof Kozlowski wrote:
> On 26/02/2025 23:16, Sam Winchenbach wrote:
> >>>>> +  adi,hpf-margin-hz:
> >>>>> +    description:
> >>>>> +      Sets maximum high-pass corner frequency to the frequency of rf_in minus
> >>>>> +      this value when in auto mode.
> >>>>
> >>>> IIUC, these are two bounds - lower and upper - in relation to something
> >>>> else (like rf_in frequency)? If so, make it an array (naming to be
> >>>> discuss, I assume you know better what's that):
> >>>
> >>> It is true that these are both related to rf_in but both the low and high pass
> >>> filters can operate independently. Logically, IMO, it makes more sense to have
> >>
> >>
> >> You mean you can set only low or high pass and keep other as default?
> >> But what is the default then - something from reset value or "0" means
> >> disabled?
> > 
> > This value isn't setting the corner frequency of the filter, but the minimum
> > distance the corner must be from the fundamental frequency. So, for example,
> > if rf_in is 3.35 GHz and you set lpf-margin-hz to 0 then the corner frequency
> > will be set to 3.35 GHz because that is an exact value supported by the device.
> > 
> > If lpf-margin-hz is set to 30 MHz (for example), then corner frequency would be
> > at least 3.35 GHz + 30 MHz = 3.38 GHz.  3.49 GHz is the closest corner
> > frequency without going below 3.38 GHz that is supported by the device, so that
> > is what will be selected.
> > 
> > This prevents the situation where your fundamental frequency falls on, or close
> > to, a corner frequency which could result in 3dB (half power) loss in your
> > signal.
> > 
> > This is all completely indepent of the high-pass filter.
> 
> Description is confusing a bit, because it suggests the value sets the
> corner frequency. It explicitly says this - "sets ... corner frequency"
> and such meaning for properties we usually associate with the property
> doing this. Here however corner frequency will be always set to rf_in
> and you just adjust the value.
>

How about: "Sets the minimum distance (in Hz) between the fundamental
frequency of `rf_in` and the corner frequency of the high-pass, input filter
when operatred in 'auto' mode. The selected high-pass corner frequency will
be less than, or equal to, `rf_in` - `hpf-margin-hz`. If not setting is found
that satisfies this relationship the filter will be put into 'bypass'."

Perhaps that is a bit more clear on the intention of this parameter?

> > 
> >>
> >>> them as separate controls but I am happy to put them into an array if that is
> >>> the idiomatic approach to situations like this. That said, I am having a
> >>> difficult time getting dt_binding_check to pass when I have an array of uint64.
> >>>
> >>> When listing two items, as in your example below, I get the following:
> >>> adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long
> >>
> >> Tricky to say without seeing your code. Magic crystal ball had
> >> malfunction today.
> > 
> > This is the property:
> > 
> >   adi,filter-margins-hz:
> >     items:
> >       - description: |
> >           The minimum distance, in Hz, between rf_in and the low-pass corner
> >           frequency when the device is used in "auto" mode. If the sum of
> >           rf_in and this value is greater than 18.85 GHz then the low-pass
> >           filter will be put into bypass mode, otherwise the closest corner
> >           frequency that is greater than or equal to the sum of rf_in plus this
> >           value will be used.
> >         minimum: 0
> >         maximum: 0xFFFFFFFFFFFFFFFF
> >         default: 0
> >       - description: |
> >           The minimum distance, in Hz, between rf_in and the high-pass corner
> >           frequency when the device is used in "auto" mode. If the difference
> >           between rf_in and this value is less than 1.75 GHz then the high-pass
> >           filter will be put into bypass mode, otherwise the closest corner
> >           frequency that is less than or equal to the difference of rf_in and
> >           this value will be used.
> >         minimum: 0
> >         maximum: 0xFFFFFFFFFFFFFFFF
> >         default: 0
> > 
> > And this is the example:
> > 
> > examples:
> >   - |
> >     spi {
> >       #address-cells = <1>;
> >       #size-cells = <0>;
> >       admv8818@0 {
> >         compatible = "adi,admv8818";
> >         reg = <0>;
> >         spi-max-frequency = <10000000>;
> >         clocks = <&admv8818_rfin>;
> >         clock-names = "rf_in";
> >         adi,filter-margins-hz = /bits/ 64 <30000000 30000000>;
> 
> 
> foo-hz is in 32-bit, so basically you have here 4 32-bit numbers which
> indeed reported by dtschema - property is too long. Drop 64-bit here.
> 

I was hoping to keep this 64 bits seeing this is a 18 GHz+ filter. I suppose
I could change this to MHz and just lose a bit of resolution. Does that sound
like a better approach?

> Device allows multiple LPF/HPF values to be stored in LUT tables and it
> actually has four independent filters. Shouldn't these be included here?
> Maybe not LUT tables, but the configuration for all filters?
>

There are two filters, the input (high-pass) filter, and the output (low-pass)
filter. Each filter has four banks, each with a different range of frequencies.
Only one bank can be selected at a time. Each bank has 16 different possible
cutoff/corner frequencies. That is a total of 64 distinct values for each of
the two filters.

The issue with setting the corner frequency directly is that in certain
applications (such as software defined radios) the fundamental frequency
is adjustable, necessitating that the corner frequencies of the filter are
adjusted accordingly. When the filter is in "auto" mode it is notified via
the clock system of frequency changes, so using this information it should be
possible to select new corner frequencies if you know the minimum distance
between your fundamental frequency and the corner.


It is possible there is either not enough call for this feature, or it goes
against the designs of the maintainters. If that is the case we should decline
this patch and we will maintain it in our fork of the kernel.

Thanks,
-Sam
 
> Best regards,
> Krzysztof


