Return-Path: <linux-iio+bounces-6634-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB569910D5D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 18:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F91285D62
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8591B14FF;
	Thu, 20 Jun 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SmRAv2Kw"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA91AD4B9;
	Thu, 20 Jun 2024 16:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901771; cv=none; b=OkwplNOMp3lBFHKRWWzLGQR56QkCgDrsml1VNs9NyTx4szZsmMUl+EWJ3YJOKWvtCN1LeD2IemeQUeSImL7beYvKeikrEXUQBd/2IwKc+DyVIM5BvvF9YYacvLthEl7FvXv5knaH5PaCczwefnmx1p0QMlEN2qBzC0lFe/SbwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901771; c=relaxed/simple;
	bh=QkcLsZ2MjRI7sIZhQbMvw6r2n0xsgwT6WigvIR4S+os=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Qpfdv3gwL9YOE9qq/+IJVStd+NSHiuSsYl2UNzTiPpODaWqLWqkN3M+e+zG0D1bjpq2QEvyzcvHJjf6c5oY0YwMwxqR/d9uzQFFaZJpvKyzt6AfiOnqMuo9eLJue2qGAtX3D6zX7EJdow93IfcMPElC305HHskE/cpVB9Ow+K+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SmRAv2Kw; arc=none smtp.client-ip=178.21.23.139
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
	t=1718901759; bh=QkcLsZ2MjRI7sIZhQbMvw6r2n0xsgwT6WigvIR4S+os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SmRAv2Kw5LKdjzHqji91l5nDgLSv8ugTz+TlFXTHeXnNYaA3NokVxNpZwAafmaVn9
	 wdNu8cwbyZ7nkjZhVna2nslXYNS5onSTqiAwYSaa4TGhQ56xBiEP0Ua3abzHtomOO3
	 oCFDQFlbphSLGQlIeeh+xPx5kbcb3gjYoCmbT0aQwKck3P/Xq2xY4aXe61ueNaGCsA
	 lz0UzxDRd9bRIGmLpVCQIsUmQVKnmSeejt7O2W3OBnAlwESv3ai7Kf9YjojjGPk/x3
	 Xr0yCVhHwtw6k7+cmwWpqehzXgTwXUar8c7FhhDzjCyoUV8Mguej7gHFtC1BAoBb3T
	 7qP7DqJc7y0zw==
Date: Thu, 20 Jun 2024 16:42:39 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 denis.ciocca@st.com, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 robh+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
In-Reply-To: <20240618-jockstrap-gains-de25ff6a969b@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
 <56ab50d7c542356b7e377023b84a6018@disroot.org>
 <20240615144948.61e7f519@jic23-huawei>
 <157b613ce552e1060e856625d37e927e@disroot.org>
 <20240618-jockstrap-gains-de25ff6a969b@spud>
Message-ID: <c4c7532b6b2ba08e24043b432431303b@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-06-18 17:38, Conor Dooley wrote:
> On Tue, Jun 18, 2024 at 12:21:17PM +0000, Kaustabh Chakraborty wrote:
>> On 2024-06-15 13:49, Jonathan Cameron wrote:
>> > On Sat, 15 Jun 2024 09:46:59 +0000
>> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>> > 
>> >> On 2024-06-11 18:17, Conor Dooley wrote:
>> >> > On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:  
>> >> >> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.  
>> >> > 
>> >> > I can see that! Your commit message should mention why this device
>> >> > is not compatible with existing variants.  
>> >> 
>> >> Sure, is adding the WhoAmI value enough? Or do I also have to
>> >> explain the different registers and sensor settings.
>> >> 
>> > Who ami is not enough, but a statement along the lines of
>> > "The register interface is not compatible with existing parts, for
>> > example addresses and contents of numerous registers are different"
>> > 
>> > With whatever the actual differences are.
>> 
>> "LIS2DS12 is an accelerometer by STMicroelectronics. It is identifiable by
>> its WhoAmI value 0x43.
>> 
>> Its register interface is not compatible with existing parts. For example: 
>> 
>> - The full-scale values are present in register 0x20, in bits 2 and 3
>>   (mask 0x0c).
>> 
>> - The full-scale values 2G, 4G, 8G, and 16G correspond to the register
>>   values 0x00, 0x02, 0x03, 0x01 respectively.
>> 
>> Add the compatible string without any fallback."
>> 
>> Is this good enough?
> 
> I don't know the other devices, so please highlight how the examples you
> give here are different to the existing ones please.

Are these acceptable?

- The full-scale values are present in register 0x20, in bits 2 and 3
  (mask 0x0c).
  Most other supported sensors have the register address set to 0x21,
  0x23, 0x24, or 0x25.
  There is one sensor setting though (bearing WhoAmI 0x3b) which has
  it's address set to 0x20, but the mask is set to 0x20, not 0x0c.

- The full-scale values 2G, 4G, 8G, and 16G correspond to the register
  values 0x00, 0x02, 0x03, 0x01 respectively.
  None of the sensor settings have the value 0x01 associated with 16G.

