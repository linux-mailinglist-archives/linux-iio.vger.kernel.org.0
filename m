Return-Path: <linux-iio+bounces-16108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4C1A46E56
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 23:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162B11694A8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 22:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D225BAC8;
	Wed, 26 Feb 2025 22:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="JPBwxd8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-14.pe-b.jellyfish.systems (out-14.pe-b.jellyfish.systems [198.54.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB7F25BAB2;
	Wed, 26 Feb 2025 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608178; cv=none; b=MJozxtU9ulfwAQeMxRKIPugWBC30ao5se9En/oZpc0VkM5Mp+XKvHm+w+6vZQsySg4z8GVZZ6H5k1Or5JiybKaQiHmaymZaosDnRPcMz2XbYmxDBgM6mhqbWEXElKCpuURVIkVwGbxio6g/KiwYuYwm9aHL2A7yAXs40IQUGSMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608178; c=relaxed/simple;
	bh=uUSijLBzxUDMkZHkQcdcmdVTgQGyPSVsyno+xloRIsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMR63+kaGOgywU/GDNRa3abHbVvI+GqgwuBF1DlwfqYopRkCZ8g9SXIrVBCeArVLM5Sl8O5HtKC/btpGCX4lfYsfSevPmAf2BHizH5b9qZtWbBR0TLAUGiCna33ZbxTFLAHeBx2fvJmenA9mxOg33LAml+m7VSajfHMK+bUQsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=JPBwxd8E; arc=none smtp.client-ip=198.54.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01.privateemail.com [198.54.118.220])
	by pe-b.jellyfish.systems (Postfix) with ESMTPA id 4Z38270ss2zDqnn;
	Wed, 26 Feb 2025 22:16:15 +0000 (UTC)
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01.privateemail.com (Postfix) with ESMTPS id 4Z382702ssz3hhVZ;
	Wed, 26 Feb 2025 17:16:15 -0500 (EST)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
	by mta-15.privateemail.com (Postfix) with ESMTP id 4Z38265nrvz3hhV0;
	Wed, 26 Feb 2025 17:16:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1740608174;
	bh=uUSijLBzxUDMkZHkQcdcmdVTgQGyPSVsyno+xloRIsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPBwxd8EJrj6LnOEzK3whKRb5u45RYuZMSsask55Nus5JuT41kFJovzs7py9XlpQy
	 zosB6g+jIdHeQGZM+36D3mu3T7UoPl6xfj0SkhBOgQACCJ6FGEprkCBYHZjuA+r1SX
	 ILe6tdyCmQmLk9Qsg9zIIFATClvmW4PLEcJGC3OLGStbi2ZiisS3XGXQFLz7D1cmtV
	 DrOqR6lcEt+oqh83tF0v/CZDpXdHEnSqX61QIULL0uDzdho+8G6WjuQsPihqo0pAa5
	 gRO7b1ZWwt+SzmnlRBxTHL9B8Tg56yhSZO7DatkfVgkfbISz23urdoB4VhX2n98AfW
	 f1UboBIfr4P8Q==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-15.privateemail.com (Postfix) with ESMTPA;
	Wed, 26 Feb 2025 17:16:02 -0500 (EST)
Date: Wed, 26 Feb 2025 17:16:02 -0500
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <Z7-SojPPx3kOVa4y@65YTFL3.secure.tethers.com>
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
 <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
 <Z79K8Ag4SJYtJTtM@65YTFL3.secure.tethers.com>
 <05e56d15-059b-425b-9e55-66993d988f8d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e56d15-059b-425b-9e55-66993d988f8d@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Wed, Feb 26, 2025 at 10:22:03PM +0100, Krzysztof Kozlowski wrote:
> On 26/02/2025 18:10, Sam Winchenbach wrote:
> > On Wed, Feb 26, 2025 at 09:03:13AM +0100, Krzysztof Kozlowski wrote:
> >> On Tue, Feb 25, 2025 at 08:46:12AM -0500, Sam Winchenbach wrote:
> >>> Adds two properties to add a margin when automatically finding the
> >>> corner frequencies.
> >>>
> >>> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> >>> ---
> >>>  .../bindings/iio/filter/adi,admv8818.yaml          | 14 ++++++++++++++
> >>>  1 file changed, 14 insertions(+)
> >>
> >> Bindings are before users (see DT submitting patches), so this should be
> >> re-ordered.
> >>
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >>> index b77e855bd594..2acdbd8d84cb 100644
> >>> --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >>> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> >>> @@ -44,6 +44,18 @@ properties:
> >>>    '#clock-cells':
> >>>      const: 0
> >>>  
> >>> +  adi,lpf-margin-hz:
> >>> +    description:
> >>> +      Sets minimum low-pass corner frequency to the frequency of rf_in plus
> >>> +      this value when in auto mode.
> >>> +    default: 0
> >>> +
> >>> +  adi,hpf-margin-hz:
> >>> +    description:
> >>> +      Sets maximum high-pass corner frequency to the frequency of rf_in minus
> >>> +      this value when in auto mode.
> >>
> >> IIUC, these are two bounds - lower and upper - in relation to something
> >> else (like rf_in frequency)? If so, make it an array (naming to be
> >> discuss, I assume you know better what's that):
> > 
> > It is true that these are both related to rf_in but both the low and high pass
> > filters can operate independently. Logically, IMO, it makes more sense to have
> 
> 
> You mean you can set only low or high pass and keep other as default?
> But what is the default then - something from reset value or "0" means
> disabled?

This value isn't setting the corner frequency of the filter, but the minimum
distance the corner must be from the fundamental frequency. So, for example,
if rf_in is 3.35 GHz and you set lpf-margin-hz to 0 then the corner frequency
will be set to 3.35 GHz because that is an exact value supported by the device.

If lpf-margin-hz is set to 30 MHz (for example), then corner frequency would be
at least 3.35 GHz + 30 MHz = 3.38 GHz.  3.49 GHz is the closest corner
frequency without going below 3.38 GHz that is supported by the device, so that
is what will be selected.

This prevents the situation where your fundamental frequency falls on, or close
to, a corner frequency which could result in 3dB (half power) loss in your
signal.

This is all completely indepent of the high-pass filter.

> 
> > them as separate controls but I am happy to put them into an array if that is
> > the idiomatic approach to situations like this. That said, I am having a
> > difficult time getting dt_binding_check to pass when I have an array of uint64.
> > 
> > When listing two items, as in your example below, I get the following:
> > adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long
> 
> Tricky to say without seeing your code. Magic crystal ball had
> malfunction today.

This is the property:

  adi,filter-margins-hz:
    items:
      - description: |
          The minimum distance, in Hz, between rf_in and the low-pass corner
          frequency when the device is used in "auto" mode. If the sum of
          rf_in and this value is greater than 18.85 GHz then the low-pass
          filter will be put into bypass mode, otherwise the closest corner
          frequency that is greater than or equal to the sum of rf_in plus this
          value will be used.
        minimum: 0
        maximum: 0xFFFFFFFFFFFFFFFF
        default: 0
      - description: |
          The minimum distance, in Hz, between rf_in and the high-pass corner
          frequency when the device is used in "auto" mode. If the difference
          between rf_in and this value is less than 1.75 GHz then the high-pass
          filter will be put into bypass mode, otherwise the closest corner
          frequency that is less than or equal to the difference of rf_in and
          this value will be used.
        minimum: 0
        maximum: 0xFFFFFFFFFFFFFFFF
        default: 0

And this is the example:

examples:
  - |
    spi {
      #address-cells = <1>;
      #size-cells = <0>;
      admv8818@0 {
        compatible = "adi,admv8818";
        reg = <0>;
        spi-max-frequency = <10000000>;
        clocks = <&admv8818_rfin>;
        clock-names = "rf_in";
        adi,filter-margins-hz = /bits/ 64 <30000000 30000000>;
      };
    };
...

Thank you for taking the time to go through this,
-Sam

> 
> Best regards,
> Krzysztof

