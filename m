Return-Path: <linux-iio+bounces-6476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847C090CB8C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81A42823DA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E7B7345C;
	Tue, 18 Jun 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MsY8NYnO"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18CA535A3;
	Tue, 18 Jun 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713290; cv=none; b=pFhlZCFbbrqjeyyE+jhmM0eH/GEpHTyELBw3M3OMdB15NYL5RSSD/CYUIQLqhJTBCT/a7Wu2ZLAmm+GOGkxkHeqqBiMSyPnkMU5tJjL6dLF02flCL1FVOvnDgv09+m/N75ZPfiWr9n5DEYYGrl4+Mdfhqf4kzwJ6MUSKCGQWse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713290; c=relaxed/simple;
	bh=/9ivRop58sTfU8MTI4OZQdW9PNSnfcBVUNMcID6iwps=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DhPw4kx02XtPSC72vhW/z2ZJTSxN/eJSzVyJjDX5ES5nlHFM8aO8RK4SXatEOKBo1W8T8q1jih5OmZ2057yrTW7hAb/9ZkZm21OlafXi76eopefy/RbNMEGnMwrxWuIO2WFGFAVEyJRP14srVj08t+t1aS0Qy2759lzsMW6uDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MsY8NYnO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
X-Virus-Scanned: SPAM Filter at disroot.org
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1718713277; bh=/9ivRop58sTfU8MTI4OZQdW9PNSnfcBVUNMcID6iwps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MsY8NYnOX0HJzBq8WId/amy7DVS5H2LXE4i/UlGJHJERgZw8SzN9cNMxDidjp7ki+
	 +gSOZszJF9M6VUAtmgwGkqLnnXLXZ58DtMP992+sVwNRjyhnSm7/4nCPnYZOkgCg/G
	 RTKaO51poTy2/jZ7jN2ZkEOw2w3AviMu964sRURWAMHjIacK4yAaV9o/JdHxGshEPI
	 fOvyW87PDktro09rKgAhd+1g0PTMNN/PMfOB8KDD7S0GffN8rXVQlfAthbsrN1ptfm
	 H+8mNnThC0aOlS7zuREWbz3eD3Xetr0K4P3m+YG2vsrowlMjfPInBllcZJYXuV8wdm
	 2WKS7vOlwz4YQ==
Date: Tue, 18 Jun 2024 12:21:17 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
In-Reply-To: <20240615144948.61e7f519@jic23-huawei>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
 <56ab50d7c542356b7e377023b84a6018@disroot.org>
 <20240615144948.61e7f519@jic23-huawei>
Message-ID: <157b613ce552e1060e856625d37e927e@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-06-15 13:49, Jonathan Cameron wrote:
> On Sat, 15 Jun 2024 09:46:59 +0000
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
>> On 2024-06-11 18:17, Conor Dooley wrote:
>> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:  
>> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.  
>> > 
>> > I can see that! Your commit message should mention why this device
>> > is not compatible with existing variants.  
>> 
>> Sure, is adding the WhoAmI value enough? Or do I also have to
>> explain the different registers and sensor settings.
>> 
> Who ami is not enough, but a statement along the lines of
> "The register interface is not compatible with existing parts, for
> example addresses and contents of numerous registers are different"
> 
> With whatever the actual differences are.

"LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable by
its WhoAmI value 0x43.

Its register interface is not compatible with existing parts. For example: 

- The full-scale values are present in register 0x20, in bits 2 and 3
  (mask 0x0c).

- The full-scale values 2G, 4G, 8G, and 16G correspond to the register
  values 0x00, 0x02, 0x03, 0x01 respectively.

Add the compatible string without any fallback."

Is this good enough?

> 
>> > 
>> > Thanks,
>> > Conor.
>> >   
>> >> 
>> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> >> ---
>> >>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> >> index fff7e3d83a02..71c1ee33a393 100644
>> >> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> >> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> >> @@ -26,6 +26,7 @@ properties:
>> >>            - st,lis2dw12
>> >>            - st,lis2hh12
>> >>            - st,lis2dh12-accel
>> >> +          - st,lis2ds12
>> >>            - st,lis302dl
>> >>            - st,lis331dl-accel
>> >>            - st,lis331dlh-accel
>> >> -- 
>> >> 2.45.1
>> >> 
>> >>  
>>

