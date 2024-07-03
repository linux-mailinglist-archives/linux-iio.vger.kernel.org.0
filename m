Return-Path: <linux-iio+bounces-7272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D8A926836
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BD71C24378
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887F1850B2;
	Wed,  3 Jul 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="kd0sLLkP"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED35FEED;
	Wed,  3 Jul 2024 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031480; cv=none; b=h/78wfy9p38e7gD4BhNWW4HDH7l4j7LZMmR5SlUdhpB9QY0Lb6TfuRY7yCHXHg7J+SvF2LJ6x/1STFZAAvKT6J5byME2NQmfG6d72ZsaAkNWkX/6HJKMahKZS+SUMatSvc/kv5GN0XociKwF3qZQD/z5a21i/gJmCTmuyIdThDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031480; c=relaxed/simple;
	bh=DTFp4PcgqMFRoq1iL2ixQ9mdBrofyAtU8p6C7j2MNEA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dOIazkTm44hJXhFCk5jFc2JN8dEkB68srolrQBNWx3+dRYr6wQA99ZEdGvmX1XSbohZLvm3Bt2LSIYFACNKEjZ1O7sWBTIjfDj/nxPdFOd0Ftob+Phi+b0YZMhjpIj+X+Zsyb17EZ1O5MBHKT4cl50aq6iloJIARaGnSRXnfUh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=kd0sLLkP; arc=none smtp.client-ip=178.21.23.139
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
	t=1720031473; bh=DTFp4PcgqMFRoq1iL2ixQ9mdBrofyAtU8p6C7j2MNEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kd0sLLkPeorQFJEvJ8+2Xds73EWrme6G0DMWkPXwjuc42BKXLMF9OsC0J4SgVPCGh
	 plY/hoB4vwhgP2TOdohAssFw8xnhGMDh1PZ9uECbO6EDeAaPT5nHYT4MlthJeH9VVv
	 ssX27iFgL+rGedjzY3ViEQ+PO+1K9a4otuGMavb5X3raF58jRmtWZsPc4VYP5MroC6
	 +g+n90shykiXCqH1yIYvxdJTuQTy7VXJLRYijZxzAtfoJl9mP39jWISGJ7MJKZdZax
	 v8IxExABnDPB7e5KRet8+LJ0LMfOPq3WKKf3hKCbjVbEwxMjju8OA2vglgAxDmuiIo
	 rEheHrnXymlzg==
Date: Wed, 03 Jul 2024 18:31:13 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
In-Reply-To: <20240626-junior-tag-cd3e27c4b140@spud>
References: <20240625165122.231182-1-kauschluss@disroot.org>
 <20240625165122.231182-2-kauschluss@disroot.org>
 <20240626-junior-tag-cd3e27c4b140@spud>
Message-ID: <7f99d77c65bc347bf8b7935220520fdb@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-06-26 16:06, Conor Dooley wrote:
> On Tue, Jun 25, 2024 at 10:21:06PM +0530, Kaustabh Chakraborty wrote:
>> Add the compatible string of stk3013 to the existing list.
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  Documentation/devicetree/bindings/iio/light/stk33xx.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> index f6e22dc9814a..6003da66a7e6 100644
>> --- a/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/stk33xx.yaml
>> @@ -19,6 +19,7 @@ allOf:
>>  properties:
>>    compatible:
>>      enum:
>> +      - sensortek,stk3013
> 
> The driver change suggests that this device is compatible with the
> existing sensors.
> Jonathan, could we relax the warning during init

What does 'relax' mean here? Earlier there used to be a probing error,
and now it's just a warning. Is that not relaxed enough?

> 	ret = stk3310_check_chip_id(chipid);
> 	if (ret < 0)
> 		dev_warn(&client->dev, "unknown chip id: 0x%x\n", chipid);
> and allow fallback compatibles here please?

So, you mean something like this in devicetree?

  compatible = "sensortek,stk3013", "sensortek,stk3310";

I mean that's fine, but we also need to change devicetree sources for
other devices. If that's what we're doing, please let me know how do
I frame the commits.

> 
>>        - sensortek,stk3310
>>        - sensortek,stk3311
>>        - sensortek,stk3335
>> -- 
>> 2.45.2
>>

Thank you.

