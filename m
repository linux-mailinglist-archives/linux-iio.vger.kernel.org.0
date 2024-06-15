Return-Path: <linux-iio+bounces-6282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC990977A
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D821C20E21
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4A2110E;
	Sat, 15 Jun 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="FfU28HE/"
X-Original-To: linux-iio@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71310A11;
	Sat, 15 Jun 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718444833; cv=none; b=BLCnw0DX2H7v52FiOE25esjpVJuPdejHgBYxB1sOa4qQ2GTfVMKBRMkCIHMTJANO2M5C8/3wqK28BatR1+07KoNPlFs5SIdJocvMNdhsyqJvlLaCbJg5QECh6y3iWAZQ+rNhXj19DxYFLPWaeGsEy7SyW03P07uIiV9ItFJAdNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718444833; c=relaxed/simple;
	bh=viOTgnhH9sLs8uink14M8hv2p6dbnzZafeKqWltRrHU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dZ1K8AW1+V/N9j1nRmMbhqLMSqQJcolUVpp+TrWhdE36U5pIQJgG0L1km4YSBq3xFLHowXBirFr+OKjMpR7gbKdwKX+1oge+1kzbzo0H+WYTp8qhOxV5N6VI5EM2G/+3iNBTh0fN/pDEeTEuxwT3h59rmoLYkN55kBqFr1456wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=FfU28HE/; arc=none smtp.client-ip=178.21.23.139
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
	t=1718444820; bh=viOTgnhH9sLs8uink14M8hv2p6dbnzZafeKqWltRrHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfU28HE/Ap/9qJfDWU1wKYeYYafRzKHKriVj3rAo1od0YPA6NOIZZqgbTd2qmT/6N
	 fOAt2yS9wGrH81olKJI3az6moiaKBTHmyR6oo4rIq+rF34I+ItXed18DrYPHSHU2bk
	 E4M4QxIn1rCvtb+BEIZaMPofbTNQUmTJqtFUgnQbQyvo2e7XEXmog/R+RGORlZusxe
	 +Co/sXlvU0daj0rKtlNT8kUDiZfk+nv+UjaB3GHTELaRYsFdgU0hPAjmfU3DDyZKjE
	 /gVbjpMLt/qdRPht7vbNT3tJSJR3Y4JyVAmB9QjV8qh0uMzbf4OZHkunkntGJ3KqGK
	 U3WEN3AJM99CQ==
Date: Sat, 15 Jun 2024 09:46:59 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, denis.ciocca@st.com,
 devicetree@vger.kernel.org, linus.walleij@linaro.org, robh+dt@kernel.org,
 kauschluss@disroot.org
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: st-sensors: add LIS2DS12
 accelerometer
In-Reply-To: <20240611-reassign-eliminate-b05e4a302cfb@spud>
References: <20240611160821.13941-1-kauschluss@disroot.org>
 <20240611160821.13941-2-kauschluss@disroot.org>
 <20240611-reassign-eliminate-b05e4a302cfb@spud>
Message-ID: <56ab50d7c542356b7e377023b84a6018@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-06-11 18:17, Conor Dooley wrote:
> On Tue, Jun 11, 2024 at 09:35:53PM +0530, Kaustabh Chakraborty wrote:
>> Add compatible for LIS2DS12 accelerometer by STMicroelectronics.
> 
> I can see that! Your commit message should mention why this device
> is not compatible with existing variants.

Sure, is adding the WhoAmI value enough? Or do I also have to
explain the different registers and sensor settings.

> 
> Thanks,
> Conor.
> 
>> 
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> index fff7e3d83a02..71c1ee33a393 100644
>> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
>> @@ -26,6 +26,7 @@ properties:
>>            - st,lis2dw12
>>            - st,lis2hh12
>>            - st,lis2dh12-accel
>> +          - st,lis2ds12
>>            - st,lis302dl
>>            - st,lis331dl-accel
>>            - st,lis331dlh-accel
>> -- 
>> 2.45.1
>> 
>>

