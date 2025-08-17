Return-Path: <linux-iio+bounces-22858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7FB29146
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D3A7ACA30
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E9347D0;
	Sun, 17 Aug 2025 03:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OZxx+DKc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E0199BC
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755401532; cv=none; b=VgQ3VaWbzE81N6+6Fy3M+yLFFqHLMlPeS9/YyRRBApcJ2+QBPIlmJ9zt2gt3H+dw5xlSHbtf2WqQ2RPgx4F7uVcbEX0XGPXptVRdyl1TsACZyrbZrQgWshE7yPg6hnTCx8alUjxledJv8izHqXzoKLkmpkJqd1OQsZRtmeXxkmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755401532; c=relaxed/simple;
	bh=lXGqbYs4HzXGILPprhb6wkYaRL/O/aJ+yUDi7RGO1QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DyYZI6shi3K17eIuEa14rk6BjjVrQUrSOzxj9IIMKMtfRsV4fTgw5CEsIEkhvPA20Z1wG6KOix+A1EmkGOEbH1j3ze1dY59iFpQOBb2+UmSFRSQNzebtoVbjqpsTuOFjXEPpLulopP+Gfb5/zVeaCHsBLrFumzCpo4hrV+wr39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OZxx+DKc; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-30cce52ba30so2457510fac.0
        for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755401529; x=1756006329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jk4M8A7Sq+oUZNkIfHBISleszXEZHXt8JDjM8/2oa3s=;
        b=OZxx+DKc7X8t5/n4KK8ucRjeDYcQ+7rWGbxnQQwWMgZYy825Tv6CrdiafdW4EG+ht9
         AJxyDaBtfL9GuiPMm9wfYwNwKk0rjvqwW6uia13uQD/2gWIVD+D2d3uNFDbvgbwpWLgu
         IsSdOM0hrQnNp/uB4n8h5p8/axAyGF3Jn6Sea+m2xp8MjZ54vVu4tfoNDACYgem837k7
         yCPXWqAXd9vkraQsWknm/m+ahblxI/dj6CthCB2XSpk7Jyp9TuCv8aeBpYmsNa04tmcU
         e1GO9WWpvJdvcdwMxTzozxbnPe6+wR874poFv3rhaJqss3zWH5U3s9DV2W694Bk7NPZq
         BVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755401529; x=1756006329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jk4M8A7Sq+oUZNkIfHBISleszXEZHXt8JDjM8/2oa3s=;
        b=wTxKoA8BUpFp7Ul+9Tr1cM248BAMZItBd4z4Gn1ivGjlHGsYInHDqgaXyiv3zDcAUF
         4xf8HgmnPAVkA5lx7gufoxSROdDKOmo/XXMHaNN2XaKn2ST5T48UnTzFxTWI5RYOIv1S
         7/8Tk6//U6D86hrq9mxmhFHGd8nmpsmbxsM4xtgSgttOeG6ZC46y8gYugYrVzesg6EUe
         /kxOA+ezCx6DmLKqh0tSVxVKuWqmsCjkUvR1AEji68gtii0wxHsfm3khOR1eXXWPHJ6I
         ZAf0Bnz3wJy2Yu+Ey610viT1QtSKXbvdZXROuRf6Umzt5dY53VwMY9q00bpk5fovWU7k
         KltQ==
X-Forwarded-Encrypted: i=1; AJvYcCXep9q0QxbXckNH3Igwp6TC2byILovZZ9x6vahmJDotg8iQNFnYdIw4ClE8qOqiKQY0MmHhvdDVWiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6XrafC0knsGnzHuIDb8iAPLvBgUxfoJYjPgSY1GNtAIzRLGw
	j6B6Znn3gXXT6IbCMpQrXNHxzD8VK3i+F7hm3Gfe39qU97Ozsb2n28TIuennlkLQ2Z8=
X-Gm-Gg: ASbGncsU6U6jYLGNqfh9eLcf+HteiVO+x42A4kvDwg7s+Un+u8J+Mtgrr3++wfBUouv
	swYJ6Wzh2UiohWjVAwcqzPm3j2BFO46EPJqQVo8WcJKbX8IUATgMUFWZN16Bd16Iy9x8YaL/uLq
	T1pQZ34+PP/mjLmbdc8spcgi8vVA+/fv75xGd3cf6NaUfnqMM2cjr/38YNYuFG3TuAmbj5iVOmA
	ZWELUKdU/1jKK6xP3H4Y8gMKXibpS7ToKz1IccmJu0q/dzZlcnmZ2Pu16JyidP+4fSyD+Hk5t1v
	gEjy6RWjWc0lSWQHKZn9AAawsye2f9/oz0ceqPGXL1d2waeQuZDz4qS9XmZXyZnGRKAe82eCiGs
	jvsgR4NsOyz/QGSGu53eQxF62JX7MKuiq9sKPrZ/+yHafXwdAkQfq4rv+Jl89RjC4lO4fF7Kbn6
	zr8kKoFfA=
X-Google-Smtp-Source: AGHT+IGtnDicEi8JeXTCvIVZIDNNbXd9yYPm529q0KGi/0stnNOfER9iWBc/gi/CqVdyO6UwOjr01w==
X-Received: by 2002:a05:6871:4195:b0:30b:582d:8eed with SMTP id 586e51a60fabf-310aafed812mr4305356fac.39.1755401528993;
        Sat, 16 Aug 2025 20:32:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fcf8:116:11db:fbac? ([2600:8803:e7e4:1d00:fcf8:116:11db:fbac])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-310abbf94dasm1629022fac.34.2025.08.16.20.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 20:32:07 -0700 (PDT)
Message-ID: <0578bf90-49d8-4547-aecb-cdec16b4d6f5@baylibre.com>
Date: Sat, 16 Aug 2025 22:32:05 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
To: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
 <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
 <2025081622-industrious-dragonfly-ed3cba@boujee-and-buff>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2025081622-industrious-dragonfly-ed3cba@boujee-and-buff>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/16/25 9:54 PM, Ben Collins wrote:
> On Sat, Aug 16, 2025 at 01:24:24PM -0500, David Lechner wrote:
>> On 8/15/25 11:46 AM, Ben Collins wrote:
>>> dt-bindings documentation for this driver claims to support
>>> thermocouple-type, but the driver does not actually make use of
>>> the property.
>>>
>>> Implement usage of the property to configure the chip for the
>>> selected thermocouple-type.
>>>
>>> Signed-off-by: Ben Collins <bcollins@watter.com>
>>> ---
>>
>> ...
>>
>>> @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
>>>  	data = iio_priv(indio_dev);
>>>  	data->client = client;
>>>  
>>> +	/* Accept type from dt with default of Type-K. */
>>
>> We still also need a dt-bindings patch to specify the default there as well.
> 
> The existing bindings file for this already states type-k is the
> default. Is there something else it needs?
> 
  default: 3

in the YAML.

