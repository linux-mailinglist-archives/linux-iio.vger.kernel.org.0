Return-Path: <linux-iio+bounces-11551-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD49B4360
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 08:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70F9283920
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B878202F66;
	Tue, 29 Oct 2024 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUzuYE7G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE618FDDF;
	Tue, 29 Oct 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187873; cv=none; b=mTtf33T712z7TboKPm4qYTvsXsgqIYXzvI7BmvkBpAxHu2y9IKrW3/cXNATRdMmqkwhmPfnhAsGA5x/6DMavw5CHE1HA53uDWl+e41xo6khoj/a2dat6Oih/k5IRD5CUOda6M3RJK3Y0eDvGGAznrgy6cOtOhXA/UJhwsKi10Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187873; c=relaxed/simple;
	bh=Ow0Z2H8OIf8QKQdRNJUse7xIsQLu5LMw1RBfto7/LDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIJ0P5x++bxo+6UT2cm04W/OcL/RA1FBvbLTJWmGbigT6JLdXDflIBAxsKe5gP6+A4rPYvkPrghGYbFuFf9wmLZLErsEJmTAurIzodNJG84UlFDuC8G6VeKjhtc3Md8EYcDyWK71+kVKQI2x7RcRrSL7eklFGnJxue4WIlZbolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUzuYE7G; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso47300785e9.3;
        Tue, 29 Oct 2024 00:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730187870; x=1730792670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IzZTViTRuzvh/XGxXwPwAKPNmcWKWyaW4QSWFJA7bs=;
        b=cUzuYE7G/9r1ksFja7Gk2oRebosTznjdEfF93EkC18kVb/QKs0Bc4Lewriecf/etk2
         10cMNB6Ge6V2oHAtzUCVnmSVT0rGV9lzPrSLEN3H6TynGCK3TJLwLBXmQOFb18pvWAGJ
         DTxHo2D77eYhMpWOXIhja37asEsqoN5AgwmQG5LfX9ZYDBqOtWcCicFM2HneFff6oN8G
         axJS0VxygeLTIhRO1XSCZGaSdjZT+WieJlIzIJgEv0C43Lyruvx7bbIDxEswm/upf1LM
         lhoQacZfW0hyQsm6QwXnENCGs6BoIr1YQQmt0sYGAJNW4I8wKRZEcitrkzNc0SnFsejZ
         1mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730187870; x=1730792670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3IzZTViTRuzvh/XGxXwPwAKPNmcWKWyaW4QSWFJA7bs=;
        b=uQN8dARcAQG7s+MqXibTKvItq+v4DB2nlhcLmkfXAJ1cj4c6jsEnp1P+OqHh5fsYXq
         7ifTn4bMiUCkt1EDboouCAg4luU4j/zaiEB++bMc/FEEDytfsTte/sT4lmSBP7b2Bazz
         JM/+wKMr6qKr3Nhb9rFzP+OizIZlZrpDhTZd2r9Cw/hZA2/gMQhNsQdxFyy3LgWEg7/q
         StU10B6bw2OmuVKiR8kX2mpNMXhwZlIBqvR+0kqPfNofIWY+PO0fquFqRMUC+u735gcD
         fuOZxMIA7sd8HrCark+agjBuNueuydZlS5nq6jAzvP749HAZ6HlwI2t3u188QWUEdB4u
         JM+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbanXrAa7e/SmntmeRYiwKF/PTsvIzwYzlh1vwAFf2B92FSqtAbj+XZ0+3TTdFvpGpDFChbi5CsnTl@vger.kernel.org, AJvYcCW2TREJTRpgJgASfoRb8r7F5L0Fn/np6pZtxgJedm7dIZwxhEVZ2n2+JvZJvzvNEtSM8wVEsyWqgb5C0eI3@vger.kernel.org, AJvYcCX5P4MDhBbd3NGY5zRMJJ8PXCsk9mrgMKzuyKb6/j9ObJkHC/hT/ByIUckZq+emjXlqNhlg0xTAoP7D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5TKYQ3xRqldyjuR240VqO0cMuTSSJTt29vXmGoKlOyEbXZHT
	L+Lc04TnV1GL6mAcM/gKCqvckg05xpV9jXiWB2dhw3lMiUcssr1oytQu3uGj
X-Google-Smtp-Source: AGHT+IHLrib7A3Ego7aSJC/MyAU9AOHPz/GF1IiWCH3p5s3lvTsDqDbPyqaKF5XwfeuJImDZtIVagg==
X-Received: by 2002:a05:600c:4510:b0:42c:c401:6d67 with SMTP id 5b1f17b1804b1-4319ac742fcmr76400545e9.6.1730187869508;
        Tue, 29 Oct 2024 00:44:29 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:25be:13a3:48ca:cad0? (2a02-8389-41cf-e200-25be-13a3-48ca-cad0.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:25be:13a3:48ca:cad0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935962acsm133309485e9.19.2024.10.29.00.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 00:44:29 -0700 (PDT)
Message-ID: <efc88c4b-42e0-43fe-9e33-b6c1ca9c2914@gmail.com>
Date: Tue, 29 Oct 2024 08:44:27 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: veml6075: document
 rset-ohms
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241028-veml6070-integration-time-v3-0-dd7ace62f480@gmail.com>
 <20241028-veml6070-integration-time-v3-1-dd7ace62f480@gmail.com>
 <kguuixqw73fjzfdnmwapfm4tpq25c33mmdkifbx4h6taoqmzx4@yp3soq2n5d3n>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <kguuixqw73fjzfdnmwapfm4tpq25c33mmdkifbx4h6taoqmzx4@yp3soq2n5d3n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 08:33, Krzysztof Kozlowski wrote:
> On Mon, Oct 28, 2024 at 06:14:01PM +0100, Javier Carrasco wrote:
>> The veml6070 provides a configurable integration time by means of an
>> external resistor (Rset in the datasheet) with values between 75 and
>> 1200 kohms.
>>
>> Document rset-ohms to select the integration time.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>> ---
>>  .../devicetree/bindings/iio/light/vishay,veml6075.yaml | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
>> index 96c1317541fa..5381a90f7f7e 100644
>> --- a/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
>> +++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6075.yaml
>> @@ -22,6 +22,13 @@ properties:
>>    reg:
>>      maxItems: 1
>>  
>> +  rset-ohms:
> 
> I missed last time this, sorry:
> This looks specific to this device, so missing vendor prefix. Otherwise
> you should use an existing property or make it a generic, IIO property
> in common schema.
> 
> Best regards,
> Krzysztof
> 

This is a device-specific property, so I will rename to

vishay,reset-ohms

Thanks and best regards,
Javier Carrasco


