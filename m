Return-Path: <linux-iio+bounces-7629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E2C931B5F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3BB21C11
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jul 2024 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD9E74409;
	Mon, 15 Jul 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="bEKIgr/P"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77733C5;
	Mon, 15 Jul 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721073789; cv=none; b=taPhBql/D7SdUY1jgDsRA7+SVDfuppbpJda7MqUqK1aETdId9vn/N+BVoo8qSUrCrzQ3ko3O27QEp+Kwx6+ul8uTwWIgIfpCXo0zZdJ7cNW4e7ZZbtVG7UebJ3UunyiwSuqcjz+qSe2qz8NYRUlRjee62qGQAi0LKJZYdqoUDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721073789; c=relaxed/simple;
	bh=GRjMyQwWgV2+YhsXoV6AS5YBs/gY+Epu+knjooe+GcY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=hUMZMsZEtLC1BSD7uucffNSh1vf4FmLx1J509f7JDU9RMP+ce2N1gbg+1My5s1XxnJAlOVY+UyYPSygmOGp3LINV5yye06foC1p6LTN3pYOeGV0QhPUhmmpZwN38OKClt5yjWXy8ztJLupsbuLkZBzNFTpq3DWwVuwrMOe7eXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=bEKIgr/P; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EAC1241335;
	Mon, 15 Jul 2024 22:02:57 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hh6BsPkEHeUO; Mon, 15 Jul 2024 22:02:57 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1721073777; bh=GRjMyQwWgV2+YhsXoV6AS5YBs/gY+Epu+knjooe+GcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bEKIgr/PidKiPHIJYPqs51e42IdroWhXbHEEKuapkswSnmai3p1H983y6g35CKNy/
	 Mozae1QxNGOIfOwt6AbPDwDQEl867k8tL3gCXOQ3lf2blZihNzXqnfS5qEZ5VJn2lO
	 zY28t9goVvIZL7IYnK+BI6GMDrVS0wc8DGsalwg4fOurLcaQTUFWnXPUIDbB8esxC/
	 mF4/A6ymb0HWZ6ugZbRmyq5xPLxKWKRbIxPqahlSo3jmX57Uv6Dupj/P1TLBJu5XxV
	 U9SAQ5CN+6nGSe66V3e3LrcJhH8Pm6fHUQHJuccl3fAyJ+hJi4U5JJ38nQ99SyOOFJ
	 PMEcSCXJotBcA==
Date: Mon, 15 Jul 2024 20:02:57 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, kauschluss@disroot.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: light: stk33xx: add compatible for
 stk3013
In-Reply-To: <20240713130620.79d47130@jic23-huawei>
References: <20240712152417.97726-1-kauschluss@disroot.org>
 <20240712152417.97726-3-kauschluss@disroot.org>
 <20240713130620.79d47130@jic23-huawei>
Message-ID: <be34b0b571ddc33351e9eb123410a210@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-07-13 12:06, Jonathan Cameron wrote:
> On Fri, 12 Jul 2024 20:54:02 +0530
> Kaustabh Chakraborty <kauschluss@disroot.org> wrote:
> 
>> Add the compatible string of stk3013 to the existing list.
> 
> Should include how this differs from existing devices such that it doesn't
> make sense to use a fallback compatible.

STK3013 is a proximity sensor by Sensortek, bearing chipid of 0x31. Despite
being marketed as a proximity sensor, it also appears to have ambient
light sensing capabilities.

Add the compatible string of stk3013 to the existing list, as a part not
compatible with other devices.

I hope this is good enough. I couldn't find anything more convincing.

> 
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
>>        - sensortek,stk3310
>>        - sensortek,stk3311
>>        - sensortek,stk3335

