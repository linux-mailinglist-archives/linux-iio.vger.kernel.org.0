Return-Path: <linux-iio+bounces-7657-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29598934017
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA74C1F22C0B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jul 2024 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3679180A94;
	Wed, 17 Jul 2024 15:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="EH1lBSBg"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D932374C2;
	Wed, 17 Jul 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231945; cv=none; b=cj5j/qejpHcusZMoU2C+LG4H2tj1Pogu6nYaGHN/IxoT1FjsR+Z0HR9y3TmOGecQ87pzJcvG/LwgyA70snJHzlYar9Pj93okax2MfPAX77B+NZgCN2EbQO7p3EnwYhRM8EugwZefKPYTY1p9a2NG6OiwzX6GcF4qnYw3Rw/VRvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231945; c=relaxed/simple;
	bh=fGk1j3Cz1xeirYpJ5JSjgioZYbeESwFu3JdqzQ/1WZA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=WIAO9CArLc8uLrhx/YJP0/jC+L6o/0WWW4uVPz36Jb3K8A4BnjqPK7eGRGZMlBGQJAi/rfgZRZ1QXgDG7eXRQlANe8Pg4jkghJLpiFKDvioBf7UzluP8iugwc2IqOBpmjECRyAkWhnAEh29MFY9Xan5PrKrMA5wLcukhGu31nrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=EH1lBSBg; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 709F64129C;
	Wed, 17 Jul 2024 17:58:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8Cy-O1lgd83; Wed, 17 Jul 2024 17:58:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721231930; bh=fGk1j3Cz1xeirYpJ5JSjgioZYbeESwFu3JdqzQ/1WZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EH1lBSBg1OY0DhqdRIqWluNS+3v7pXHDKPTwz3hZqZzer7JYhTzuEd8yOgyLRgIgL
	 9v0C7612gEV4l4JNjgRHElv9ptQOKOtqrwAUi8ZYUht8g3wKNvqNnKwdHTFena/5vw
	 aiynR4OPPlh5h38c4eFSojNDb45Yx3ovU8Jj4XmJYjUvheIs9QOnTN/ShPBTLWfy3L
	 qqdh9E/SKIP/5NQ0y0R6ARR4gsxAApRdmeIJiQ9z5dlhZIOqywU6LVeoI8dxjoe1MW
	 4ZhmqBXP0z8wIzjlouzYFlaykRG0C/f2THmHZbYAJqgWcAVb/X3g20zlbzIuRKa2P9
	 OLhlJZTzlC1sQ==
Date: Wed, 17 Jul 2024 15:58:50 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
In-Reply-To: <20240716174328.15c250a9@jic23-huawei>
References: <20240712152417.97726-1-kauschluss@disroot.org>
 <20240712152417.97726-3-kauschluss@disroot.org>
 <20240713130620.79d47130@jic23-huawei>
 <be34b0b571ddc33351e9eb123410a210@disroot.org>
 <20240716174328.15c250a9@jic23-huawei>
Message-ID: <2554b98ddbe3098fa974b651f555a791@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-16 16:43, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 20:02:57 +0000
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
>> On 2024-07-13 12:06, Jonathan Cameron wrote:
>> > On Fri, 12 Jul 2024 20:54:02 +0530
>> > Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
>> >   
>> >> Add the compatible string of stk3013 to the existing list.  
>> > 
>> > Should include how this differs from existing devices such that it doesn't
>> > make sense to use a fallback compatible.  
>> 
>> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
>> being marketed as a proximity sensor, it also appears to have ambient
>> light sensing capabilities.
>> 
>> Add the compatible string of stk3013 to the existing list, as a part not
>> compatible with other devices.
> 
> That would be fine, but I'm not seeing any driver code changes, so when
> you say not compatible, in what way? If it's register changes in features
> we don't support yet or something like that, just add some examples.
> 
> A different whoami register value isn't sufficient as after the fix
> you have as patch 1 that will only result in a message print.

I understand that a whoami is not enough to justify not having a fallback
compatible. That's why I mentioned it's the most "convincing" argument I
could come up with, which is admittedly, isn't enough.

And there really isn't anything feature-wise which sets STK3013 apart from
other devices. All register addresses and functions are fully compatible
with the current driver.

> 
> Obviously doesn't help much for this addition as you are adding the
> bypass of the whoami and the new ID in the same series, but we want
> to set a precedence for future devices to use fallback compatibles
> now that path works.

I'll add stk3310 as a fallback compatible and change the commit message
appropriately. Conor did mention it in the last revision, but I totally
missed that. Apologies.

Ending the description with something along the lines of:

The part is fully compatible with the existing implementation of the
device driver. Add the compatible string of stk3013 to the existing list,
with a fallback of stk3310.

...would be alright?

> 
> Jonathan
> 
>> 
>> I hope this is good enough. I couldn't find anything more convincing.
>> 
>> >   
>> >> 
>> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> >> ---
>> >>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >> 
>> >> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> index f6e22dc9814a..6003da66a7e6 100644
>> >> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> @@ -19,6 +19,7 @@ allOf:
>> >>  properties:
>> >>    compatible:
>> >>      enum:
>> >> +      - sensortek,stk3013
>> >>        - sensortek,stk3310
>> >>        - sensortek,stk3311
>> >>        - sensortek,stk3335

