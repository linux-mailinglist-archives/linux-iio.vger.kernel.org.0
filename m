Return-Path: <linux-iio+bounces-8409-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542694E2AC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF471F21138
	for <lists+linux-iio@lfdr.de>; Sun, 11 Aug 2024 18:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D966E1547D6;
	Sun, 11 Aug 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="i2gnCxTC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6BA2D;
	Sun, 11 Aug 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723400929; cv=none; b=fCn1rpge9POcuJ4DKt3e40Dt2+KYIY8MKmRA95ZTOotGI0HWss6v8pJS188XJ8S+XmVfdltQeD6wdLhH7WG0jVxF4vX66YRbv16AEI2MAMgmW3i4pknlhKTXCjhNf9Z5WSCOzVgDUNT451+EtpoQSqmm1xCpJTN1P3QHi53Rc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723400929; c=relaxed/simple;
	bh=9459fFCIDgQW52rm/W2iGRTKNg9T6soXIRY1SUH8a5s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tP6dhQjgAQ4lnqcM5N8VusJtRSTD2t9asZ+ZEBJokgyvgazqm6hRgi9dA5bU7WPgdJAFSorp43reTLg+8FXW53PVnb+RjLhTChaCxjAoWZc/gG3xn0OAOU9QBPvI/QnmvFL5clp6kRAsWtDjnT1mlHr2YLiIWH6f6Zv7FCWVqts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=i2gnCxTC; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Received: from localhost (docker-mailserver-web-1.docker-mailserver_default [172.22.0.5])
	by mail.mainlining.org (Postfix) with ESMTPSA id D6937E44F4;
	Sun, 11 Aug 2024 18:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mainlining.org;
	s=psm; t=1723400919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPhUZ6Yu4rCpypBQehv8wpi5ZrCpKD6WyjkGv1ZOLr0=;
	b=i2gnCxTCkkyysEqqejz+EBJViGt0AT8zXb+Z54x5O1/gmItfucsjO7eFojNY0eL9bWmSL9
	zvJO9r7IpiAELedjXZfVXF4y909NrMsgDskHsWUrMRh3DYYzBAm4SaEybu5jqmKc1J8L6X
	n+2ViTEDqDgEMSAYGFQMUYphC5800UBWqIMQF9FTFeB2y8umlAeJJGYawagueVNJ5nyDna
	11qgLiN4nUhoMdTmnTQsh8Yh4mRIq6FwosAcD5r8XM4oQ1cTzQ0CXBTbvBt1aiFx6QTQV5
	eRO3zzdXEqRzRV76sePyDmiHZMLoBpAR8boR79d2ocvahJ8DhXH4pAOxR31PDQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 20:28:39 +0200
From: barnabas.czeman@mainlining.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Albrieux
 <jonathan.albrieux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux@mainlining.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: imu: magnetometer: Add ak09118
In-Reply-To: <1568980c-fc35-4445-a10c-8bb7fede2763@kernel.org>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
 <20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
 <1568980c-fc35-4445-a10c-8bb7fede2763@kernel.org>
Message-ID: <45dc7e6de63f5b55f6a3488a82ad5b0d@mainlining.org>
X-Sender: barnabas.czeman@mainlining.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-10 14:15, Krzysztof Kozlowski wrote:
> On 09/08/2024 22:25, Barnabás Czémán wrote:
>> From: Danila Tikhonov <danila@jiaxyga.com>
>> 
>> Document asahi-kasei,ak09918 compatible.
> 
> Not much improved here.
I have removed Reviewed-by because fallback compatible is a different 
approach
and I would not mind second look.
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
> 
> Thank you.
> </form letter>
> 
>> 
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      
>>  | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml 
>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>> index 9790f75fc669..ff93a935363f 100644
>> --- 
>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>> @@ -18,6 +18,9 @@ properties:
>>            - asahi-kasei,ak09911
>>            - asahi-kasei,ak09912
>>            - asahi-kasei,ak09916
>> +      - items:
>> +          - const: asahi-kasei,ak09918
>> +          - const: asahi-kasei,ak09912
> 
> Why? Your driver suggests it might not be compatible... Can device bind
> using ak09912 and operate up to ak09912 extend?
It is register compatible and it can bind on 09112, as I understand 
fallback compatible
was a request from Connor and Jonathan in the previous round.
> 
> Best regards,
> Krzysztof

