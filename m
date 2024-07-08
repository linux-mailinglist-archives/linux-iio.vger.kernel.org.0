Return-Path: <linux-iio+bounces-7451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243E92A95B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E86B21A3B
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB9C14B95B;
	Mon,  8 Jul 2024 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TlpzN3EA"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E0314B07B;
	Mon,  8 Jul 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464992; cv=none; b=WOEJ5K77y0HZ2WcIvbLQgCoDokzMuBg/9uWoXKbxf4j4isR30xFIsTYcULhpiMB+h4EYvX76eWmuM1ycLIv3J0X3ib0NY6dOkUZRJJtveTcLjw2W2m7j6Lj7Ylj43bixGDRt61nOChcPgjQzdytb3Mc+PerkfgIt/UWLALugk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464992; c=relaxed/simple;
	bh=gM0Y/RgU44s/WF55oq92oWg/kZnsd1CfJuaY7BInVSY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=uTqRmnQ9KtqSVmt8ry6IVSi4XMf59oTMrASdUga86CjXZZysB/fESM/QwCYgw9cgJeMdTVgMGbhjG5LXJS4HwVQRApiJdFOkSGtNK4crITRJ3drUoOD9OQKQDdrh//WLuImHNoY2Ip+4Pr4cRHeCK/bM1rOXUu4uGYtQTStbYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TlpzN3EA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 83F4840F00;
	Mon,  8 Jul 2024 20:56:26 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6plcH9AA_KY5; Mon,  8 Jul 2024 20:56:25 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720464985; bh=gM0Y/RgU44s/WF55oq92oWg/kZnsd1CfJuaY7BInVSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TlpzN3EAM2KnAfqBw0xaGkjPRz/EGSBA8G16nvq1hgOLZRT8H6Tg+JEBHcWTzVxy5
	 OQcx+YBs804nxdOkpQ8z9uRPn/4lhUG4Qg+/EZ5uAmfN85HwLc6Dhnvs1hrFESerKv
	 S8JYTPqIPAD4Zgk3n2OqhVsehT8aU4coK+1GFnm0nGARkeXwExHjDNyh+8fUwngPR7
	 e49PD52ZdrZogh8lnjMs7iRsQpKVOH8XGctTyxgAmxMGsg6rCfPNaoWfkHyUO+uVDW
	 fNsk6pCP85I8tRChmr7wj5EN2y69fDWZ3veAEGAAMYJ9Y0isGGt4VJ5ExIi090t5B8
	 gJnDzCL8wS3Mw==
Date: Mon, 08 Jul 2024 18:56:25 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, kauschluss
 <kauschluss@disroot.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
In-Reply-To: <20240707174910.156b3e3c@jic23-huawei>
References: <20240625165122.231182-1-kauschluss@disroot.org>
 <20240625165122.231182-2-kauschluss@disroot.org>
 <20240626-junior-tag-cd3e27c4b140@spud>
 <7f99d77c65bc347bf8b7935220520fdb@disroot.org>
 <20240703-velvet-badly-904e7afc7cf8@spud>
 <9a7f7eb2b5e8841b8c1f1064cccdd86f@disroot.org>
 <20240707174910.156b3e3c@jic23-huawei>
Message-ID: <dd623c35ca67b1574b2f84074ca68b8a@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-07 16:49, Jonathan Cameron wrote:
> On Thu, 04 Jul 2024 07:16:10 +0000
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
>> On 2024-07-03 19:30, Conor Dooley wrote:
>> > On Wed, Jul 03, 2024 at 06:31:13PM +0000, Kaustabh Chakraborty wrote:  
>> >> On 2024-06-26 16:06, Conor Dooley wrote:  
>> >> > On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:  
>> >> >> Add the compatible string of stk3013 to the existing list.
>> >> >> 
>> >> >> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> >> >> ---
>> >> >>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>> >> >>  1 file changed, 1 insertion(+)
>> >> >> 
>> >> >> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> >> index f6e22dc9814a..6003da66a7e6 100644
>> >> >> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> >> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> >> >> @@ -19,6 +19,7 @@ allOf:
>> >> >>  properties:
>> >> >>    compatible:
>> >> >>      enum:
>> >> >> +      - sensortek,stk3013  
>> >> > 
>> >> > The driver change suggests that this device is compatible with the
>> >> > existing sensors.
>> >> > Jonathan, could we relax the warning during init  
>> >> 
>> >> What does 'relax' mean here? Earlier there used to be a probing error,
>> >> and now it's just a warning. Is that not relaxed enough?  
>> > 
>> > If it is something intentionally, I don't think a warning is suitable.
>> > It makes the user thing something is wrong.  
>> 
>> So, something like:
>> 
>>   dev_info(&client->dev, "chip id: 0x%x\n", chipid);
>> 
>> is suitable in this context?
> 
> Key is to indicate in a 'friendly' fashion that we don't recognise the part
> but we are treating it as what DT says.
> 
> dev_info(&client->dev, "New unknown chip id: 0x%x\n", chip_id);
> only in the path where we don't have a match
> 
>> 
>> And doesn't it make stk3310_check_chip_id() obsolete? In all cases chipid
>> should be printed as it's not an error/warning message.
> 
> No. Printing it when we know what it is counts as annoying noise.
> We want the print to indicate we don't know what it is.
> 
> There have been too many instances of manufacturers switching to
> a part that is compatible with some non-mainline driver (because they
> match on a whoami and handle it appropriately) that doesn't work
> in Linux.  Hence we want to print a warning so that when we get such
> a report we can ask for more info on what the device actually is.
> 
> If device manufacturers would actually update their DT when they changed
> a sensor for an incompatible one we'd not need this.  Unfortunately
> some of them don't :(

I see. Sure, I'll modify it accordingly and send a v2.

> 
> Jonathan
> 
> 
> 
>> 
>> >   
>> >>   
>> >> > 	ret = stk3310_check_chip_id(chipid);
>> >> > 	if (ret < 0)
>> >> > 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
>> >> > and allow fallback compatibles here please?  
>> >> 
>> >> So, you mean something like this in devicetree?
>> >> 
>> >>   compatible = "sensortek,stk3013", "sensortek,stk3310";
>> >> 
>> >> I mean that's fine, but we also need to change devicetree sources for
>> >> other devices. If that's what we're doing, please let me know how do
>> >> I frame the commits.  
>> > 
>> > Why would you need to change the dts for other devices to add a fallback
>> > for this new compatible that is being added?  
>> 
>> Okay gotcha, so it's just for stk3013.
>> 
>> >   
>> >> >>        - sensortek,stk3310
>> >> >>        - sensortek,stk3311
>> >> >>        - sensortek,stk3335
>> >> >> -- 
>> >> >> 2.45.2
>> >> >>  
>> >> 
>> >> Thank you.

