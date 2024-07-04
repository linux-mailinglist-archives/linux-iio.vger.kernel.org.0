Return-Path: <linux-iio+bounces-7289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBB92705D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A78B21E5F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 07:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB851A2C00;
	Thu,  4 Jul 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cVzJ21/2"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A51A0AF2;
	Thu,  4 Jul 2024 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077377; cv=none; b=UEqZOE060Rzkn3JCIb/YED5DR/imp1WrEKB+vzrXgBKRuShZNGWoAlJvkctUnaQQudZ/HVfb/cqttxR7iQR2/ZUIXyw20+ZRu8YmX0VwxNli5ISMu+PGNxQjzwS3jUHtTzjfhn9mI9z9/cLWPXGsnVNwuhJfGVOeQ0pfk7pc4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077377; c=relaxed/simple;
	bh=CWG2mqe6OjnzUwtzy0F2KyjhL1LkeMppbbiQNtys+cw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=daMvZRWrB1R9pKF57qGlNCnsmBBUmfKDi8CI36r4fH6ObzUDRYJsohzh76rlRCK+lmyDMF30g+jRpYjaxEFeIra5CmyU2sCqlna9R9mATKyW5eI/72rVhaNQ/ssxlasp0iTO5jePBeyZLk4EWAzPQZgPrWzcogn9YDc0OZAPeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cVzJ21/2; arc=none smtp.client-ip=178.21.23.139
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
	t=1720077370; bh=CWG2mqe6OjnzUwtzy0F2KyjhL1LkeMppbbiQNtys+cw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cVzJ21/26GNT6JrUNH2QmSwLNZ5t5s8/kjSWYhCSwyx7ip7yc4/ABzOqTbGz7JQeV
	 F6hi0Hu7OObNC3I7SPNa8C+NjO6mTWgYNGDwP9wVKuIVSWBitgKT36NuqcX91eqJ5a
	 /0YBykW3zVCAXeJPoFtsmWE5SXMjXFOzwxSCQi6qr3vCSrqbVumHIItKL7FPEay211
	 yn3JdgkxjuaOpmkYOBFnKGkq1o3kAfPcxv4yD+FeJD6VUAHlAinXO7W715Mf9V02fv
	 HRZYIGUkYQcv1NF4Udz+AQoyGgf47miII6gsZutWWQKCLnj1ERPtvm94xWImCPxMax
	 4OeOAEy5a4K6w==
Date: Thu, 04 Jul 2024 07:16:10 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
In-Reply-To: <20240703-velvet-badly-904e7afc7cf8@spud>
References: <20240625165122.231182-1-kauschluss@disroot.org>
 <20240625165122.231182-2-kauschluss@disroot.org>
 <20240626-junior-tag-cd3e27c4b140@spud>
 <7f99d77c65bc347bf8b7935220520fdb@disroot.org>
 <20240703-velvet-badly-904e7afc7cf8@spud>
Message-ID: <9a7f7eb2b5e8841b8c1f1064cccdd86f@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-03 19:30, Conor Dooley wrote:
> On Wed, Jul 03, 2024 at 06:31:13PM +0000, Kaustabh Chakraborty wrote:
>> On 2024-06-26 16:06, Conor Dooley wrote:
>> > On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:
>> >> Add the compatible string of stk3013 to the existing list.
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
>> > 
>> > The driver change suggests that this device is compatible with the
>> > existing sensors.
>> > Jonathan, could we relax the warning during init
>> 
>> What does 'relax' mean here? Earlier there used to be a probing error,
>> and now it's just a warning. Is that not relaxed enough?
> 
> If it is something intentionally, I don't think a warning is suitable.
> It makes the user thing something is wrong.

So, something like:

  dev_info(&client->dev, "chip id: 0x%x\n", chipid);

is suitable in this context?

And doesn't it make stk3310_check_chip_id() obsolete? In all cases chipid
should be printed as it's not an error/warning message.

> 
>> 
>> > 	ret = stk3310_check_chip_id(chipid);
>> > 	if (ret < 0)
>> > 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
>> > and allow fallback compatibles here please?
>> 
>> So, you mean something like this in devicetree?
>> 
>>   compatible = "sensortek,stk3013", "sensortek,stk3310";
>> 
>> I mean that's fine, but we also need to change devicetree sources for
>> other devices. If that's what we're doing, please let me know how do
>> I frame the commits.
> 
> Why would you need to change the dts for other devices to add a fallback
> for this new compatible that is being added?

Okay gotcha, so it's just for stk3013.

> 
>> >>        - sensortek,stk3310
>> >>        - sensortek,stk3311
>> >>        - sensortek,stk3335
>> >> -- 
>> >> 2.45.2
>> >>
>> 
>> Thank you.

