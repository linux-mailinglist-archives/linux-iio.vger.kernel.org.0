Return-Path: <linux-iio+bounces-26274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E329CC669BA
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 00:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EBFF62980A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Nov 2025 23:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B8F32340D;
	Mon, 17 Nov 2025 23:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b+YB1CzV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1C322551
	for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423956; cv=none; b=XX17X97HB6JuECUbnsnUYh5DPh9lNCS0aW9bu1OxlNSKSiizJOcvJqgVEreyB1vZs58QJgq3HLtatGWTilSjXNIaBX2eW4bdOh0/WeuDDEk3h6nf2XuHxzAA91S7/Ha7BZwsj09shqcR0oT/33w6i7Y2Y+1kNEiRoFpa4pRxFiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423956; c=relaxed/simple;
	bh=1+kWPJCTC+8gKyistabB0c2BD+K2MgxptkjcPYa0fLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYdG/DAZ4XeQ9WV2H5OBiKee4iv1ToYnSOgIWQFluK4NIJUuaxqHO0RGWPA9BEOsIPjoSMvi3hCs8DqHikAz89WEguNqR9rfRsB1V6GgDoaXwuutPfgGa9NDqo5a7nJphf/yVFnEr9UqVKVDyWetoRFT3cVujetF4rTtUSHOkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b+YB1CzV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e898ba2a03so1118968fac.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Nov 2025 15:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763423952; x=1764028752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mA/zSuZwlQtj14wbXOMPKoaeHJe4cIIIpnXNyeurS4Q=;
        b=b+YB1CzVVkl+YdJNjrmA/4OAs+OrUbnZlUwDzGblryhQzQAIWN8IFpxez4h1QcqsLJ
         W6cKuuV+AgRU8VAprms+YOI73dCXqEHm3vvH71qJBfh0zwB0oLZ6G3uPc4/VSTzAdTbp
         XjziE9+7TMDiJ83n6Wc3lxbacEJKJ8FWYiYhxVlknXmSzQp2gD7T8r9BXCon/whtVjte
         86Q3SIdxDaO5QKdIG/+C+Pl/lLy76HrvJeurJyP9Z03iZfbxaWfDhuTV7voxjViDo5e4
         hnxwsJgwGJuCuq2d9kW7iQodALg1tN72ngik3b0tr8v/MiGgAmrgWs5sq0wMdnlITeN/
         uaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763423952; x=1764028752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mA/zSuZwlQtj14wbXOMPKoaeHJe4cIIIpnXNyeurS4Q=;
        b=aGAZWdQDxOErJc0HKels42QZc53TGOp4IwR+gurI/h7lSG/XnP5SQw+AHNMFc6leeb
         devIFeNrJ2Qvrn77fTseL2sXazm+xCt6EopbCosUMW52xQrWET/OkpJ5VAykCpg5TMJo
         lK7MQzw+fX048Qkq5Xo8AzECCdZAU6i4OFEh4sl7kbMp6+/bp+2lKnwEjl+x22LIRhPt
         Pb0/yB27aY8NUbvcE7m6BL0Z7VMEA6oWrUjoDVwxl19BOjrbeKuvVAr80ZqYIjKhkmZm
         EfzbnGD5FcC5YOYrJ6QGW1/LJUazIZhTDONHhTnXx11w6Dgghp9VAbuQl4uHzDlfnxib
         efyg==
X-Forwarded-Encrypted: i=1; AJvYcCWLEVpwOp09k608lTUWqgMNbPOgWNWCHozx+wEHkAtjGxPmDlHxUmXRD73TzJNEmHMeQcbSlT6eCpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Vh999rviy8U091uyp+2tNEmWtzFCgWiS8xChvnnpZ4fQNnBe
	C/IQoAzOXUUCAzupdsRVvuWxJqJztPD5TxVxt+0aiohilLB+856ZjBLNPa4E2Ii2Xys=
X-Gm-Gg: ASbGncv9r56qApb9iCab4f1pJptKWoHLCYZHyOO12D1lTBaO1LLiL0Wo/TBtYgQFFaC
	zNYsoiQc2ViBKCGf7FSFOpo5uoDhniUaMDw/pVxHk6uRWLaM1aXMN0xTgkUyn9Fa8g3xjYEgqwf
	0Zw9vq8CbCTxx8Kj+N1iYL+CDU31RXZIBG4f/AYTJAHBzsrWUAvQqLzuYRpXsSucSc70EGAeHt6
	ROVmctTumjTtUNljRhjXeQAyu94GCxaUXi99Kenglk3MvIWBTn6W2ZICjF3Ze8Nim858gES+YBF
	QyKMxayjKdfRxKllXHEgrCVBB6FLdz/q7qhaYv3eOvEXTKuwmargAFQdlTDCMBsnJjFz9SAiein
	gSr1mDeDgEsHZHtqwwCUz2rTiXAF/yJx9g1kYrb4bFkpnyRMrDDvvhvI1Oow3PetiYQ2KxsdLDD
	mn9BvjEvanr3zTqfBWeeAWfFyWsu7+irETrMdOJMPxQyTDnpIBjg==
X-Google-Smtp-Source: AGHT+IG0n4swCSKNULmdBH9IQIpxvLpbVeDw4xR3lEnLl8Z8nC7+yX/idFoGWe7M2wBNA4qpVT2OUg==
X-Received: by 2002:a05:6871:3426:b0:3ec:3ff0:a714 with SMTP id 586e51a60fabf-3ec3ff0abe6mr3097831fac.8.1763423951814;
        Mon, 17 Nov 2025 15:59:11 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e86:179b:44b8:cc2b? ([2600:8803:e7e4:500:8e86:179b:44b8:cc2b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec5962e508sm861602fac.4.2025.11.17.15.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 15:59:10 -0800 (PST)
Message-ID: <aa2808d2-58fd-41a9-a533-86896352a485@baylibre.com>
Date: Mon, 17 Nov 2025 17:59:09 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] Documentation: ABI: adl8113: add documentation
To: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20251114115725.5660-1-antoniu.miclaus@analog.com>
 <20251114115725.5660-4-antoniu.miclaus@analog.com>
 <20251116155013.2b55af25@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251116155013.2b55af25@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/25 9:50 AM, Jonathan Cameron wrote:
> On Fri, 14 Nov 2025 11:57:25 +0000
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> 
>> Add ABI documentation for the ADL8113 Low Noise Amplifier,
>> covering the 4 pin-selectable operating modes.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> +CC all the IIO subsystem reviewers as I'm not sure how to handle
> what this device does, and would like some more opinions.
> 
> Anyone who has expertise or design experience with this sort
> of amplifier with external bypass path: how are these actually used?
> 
> The development board seems to just be suited to measurement of
> device characteristics, not representative of a design using it.
> 
>> ---
>>
>> Changes in v3:
>> - Replace "mode" attribute documentation with "signal_path" attribute
>> - Update descriptions to reflect separation of gain control (hardwaregain) and path control (signal_path)
>> - Add explanation of automatic bypass mode switching when selecting external paths
>> - Update attribute names from mode/mode_available to signal_path/signal_path_available
>> - Clarify that external paths enable connection of external components for filtering or amplification
>> ---
>>  .../testing/sysfs-bus-iio-amplifiers-adl8113  | 30 +++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
>> new file mode 100644
>> index 000000000000..31fb1e6e80fc
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
>> @@ -0,0 +1,30 @@
>> +What:		/sys/bus/iio/devices/iio:deviceX/signal_path
>> +Date:		January 2025
>> +KernelVersion:	6.14
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		This attribute controls the signal routing path for the ADL8113
>> +		Low Noise Amplifier. The supported signal paths are:
>> +
>> +		* internal - Signal passes through internal path. Can be used with
>> +		  either amplifier mode (14dB gain) or bypass mode (0dB gain).
>> +
>> +		* external_a - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
>> +		  (VA=0, VB=1). External components can be connected for filtering or
>> +		  additional amplification. Automatically switches to bypass mode (0dB).
>> +
>> +		* external_b - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
>> +		  (VA=1, VB=0). External components can be connected for filtering or
>> +		  additional amplification. Automatically switches to bypass mode (0dB).
> 
> I'm still not sure how to handle these external paths.  The one thing they won't be
> is truly zero gain (because that would be pointless given the internal bypass path does that).
> 
> So how are these used in practice?

Afraid I don't have any experience with this. But I would assume that the two external
bypasses each have another amplifier (or attenuator) connected to them.

> 
> Do we need to figure out how to describe the real characteristics of those paths?

It sounds like this is just a multiplexer. So a few ideas:

1. We could handle this like iio-mux.c and have 4 channels and just restrict use
   to one channel at a time. Not exactly sure how we would do that. Perhaps an
   enable attribute that is interlocked so that it will fail to enable if another
   channel is already enabled? In this case, the devicetree would need to have an
   io-channels property to get the two bypass amplifier channels and basically pass
   them through.

2. Have the devicetree specify the gain of the two external bypass amplifiers
   so that we can use the hardwaregain attribute to select between the 4 mux
   positions without needing a custom attribute. This works as long as none
   of the amplifiers have the same gain.

I'm envisioning this would be e.g. part of a range selection on some sort of
test equipment. In that case, option 2 seems the right way to go about it.



