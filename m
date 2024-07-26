Return-Path: <linux-iio+bounces-7952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DF193D8D4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 20:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30FE1F22DBA
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19A44C8F;
	Fri, 26 Jul 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="g4r4XUxS"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB6E33997;
	Fri, 26 Jul 2024 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020335; cv=none; b=TQVRDKRJg8kVnX72bgAtrpFIjCvDJ9eiE8Ih5HkMsxcUQN3isFvMCKUVQOwhVRt2ATKIn4Up8WaQzzIhUgP5BKZDpt6/QmM8b2FnrXFtrhscXK4jESUAPWk7+cFX8pydXxjCLRO0ZeL/GoOhC989y67+ucLwcInLvVdRRkEMs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020335; c=relaxed/simple;
	bh=gqsayO2XOZitiHAHcVzYIHoEahFIVT/BGll7ip4lfLU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nvEA1vi/zN8Nol5ooqkCe6cGaoCJpsWkAh1f2HuhYCoO8fC2BJ0R/fN/jFQnnk/9VBsjs0/XNWZU71itgczJIP2yeoTK2VVgeC4+6wH6rA8rNaprOBncyHrr5492tgYsne2rt1nW20/pPM/M8P07SW3p1EL5XJGAyfgBl7JHaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=g4r4XUxS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A99734182D;
	Fri, 26 Jul 2024 20:52:03 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1eoXV5XiET3D; Fri, 26 Jul 2024 20:52:02 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722019922; bh=gqsayO2XOZitiHAHcVzYIHoEahFIVT/BGll7ip4lfLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g4r4XUxSwuRObHfrAmvzMBRB0Z4k7gifc0BOdQscFj4anZ9qAPoFVD26+Mvxx/KU6
	 RsfzArKZa9avV8AxurQvSZpC1uG89JW3kkdELwqCxSE88bLVv0xiliYl9GM5h1c/IR
	 vxSbGC7wt+/yozNqIAwr7wtslcbdg9K8pKadCIdQGU9cq9Ze/2oOffVgg/Qp9RsPnl
	 xWbqL7XlkTUquWWYi1yN157YyQaqnMd721y2hzlJ1H/waBsmIZb/Q0kqndnGTMNPl0
	 onPLW5SxwGSluJRQmhIFm3XD4TZOiIHuXbgMPnVAM99KMmA8It+e2Q7rAYW/Iq2Jp6
	 9O6P5Cr8ybCLQ==
Date: Fri, 26 Jul 2024 18:52:02 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: light: stk33xx: add compatible
 for stk3013
In-Reply-To: <20240722-affection-abstract-57fb331782e3@spud>
References: <20240721-stk3310-v3-0-98fcb6f551a1@disroot.org>
 <20240721-stk3310-v3-3-98fcb6f551a1@disroot.org>
 <20240722-affection-abstract-57fb331782e3@spud>
Message-ID: <bb78822b5a45ec1a1eb6c61af66c5cbc@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-22 17:05, Conor Dooley wrote:
> On Sun, Jul 21, 2024 at 03:44:31PM +0530, Kaustabh Chakraborty wrote:
>> STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
>> being marketed as a proximity sensor, it also appears to have ambient
>> light sensing capabilities.
>> 
>> The part is fully compatible with the existing implementation of the
>> device driver. Add the compatible string of stk3013 to the existing
>> list, with a fallback of stk3310.
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 13 +++++++++----
>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> index f6e22dc9814a..d5f6b622c8da 100644
>> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> @@ -18,10 +18,15 @@ allOf:
>>  
>>  properties:
>>    compatible:
>> -    enum:
>> -      - sensortek,stk3310
>> -      - sensortek,stk3311
>> -      - sensortek,stk3335
>> +    oneOf:
>> +      - enum:
>> +        - sensortek,stk3310
>> +        - sensortek,stk3311
>> +        - sensortek,stk3335
>> +      - items:
>> +        - enum:
>> +          - sensortek,stk3013
>> +        - const: sensortek,stk3310
>>  
> 
> ./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:23:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:27:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/iio/light/stk33xx.yaml:28:11: [warning] wrong indentation: expected 12 but found 10 (indentation)
> 
> From dt_binding_check, please fix.

Will get fixed in v4.
Thanks.

> 
>>    reg:
>>      maxItems: 1
>> 
>> -- 
>> 2.45.2
>>

