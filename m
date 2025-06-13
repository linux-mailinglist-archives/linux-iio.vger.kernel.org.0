Return-Path: <linux-iio+bounces-20600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A4AAD8F4A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83887AB0DC
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7515689A;
	Fri, 13 Jun 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dq460isC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7638813C9D4
	for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824422; cv=none; b=MAGqkhOx6/7mfyRmgPom2FfqNDvfPXX27rLsjDf5agQgS76dQPx/IgGF9QTP1p5ILk1iIRn8Hvn8pc/jg/2i1MQCCK9NL270/eVS2neaFmf2LKS0/jz0ISMXREaJSmCQd36jNVpLfGGge3pLWIbOBwvrF6wM2rtIr0OFq9FwUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824422; c=relaxed/simple;
	bh=2uFIeI8r05kfQpJw2EctCJW9fBZRFPD2SvqXy7M+oXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elRi+2SPLTXvQ07rsMJPmgWyRDJgNBfhqW3RWWKc/egrj2AWugP9/3KKrSHDCYG3F9Z0kmXUkkCPKlgMjayA71gm+Eqs6XbORJL4tVy93e9gZm4+ivcE+UfHrNqWABb4oAkKooXuGgZbKmU4lOA3fzWdE8RB6w5YW6BPTFtFiQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dq460isC; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-406e31162c6so671609b6e.2
        for <linux-iio@vger.kernel.org>; Fri, 13 Jun 2025 07:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749824419; x=1750429219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kDMCRDo0cthC7kWsPEVosDcgak2W50xC/1nlZdkqQZo=;
        b=dq460isCA9pcd/W6ZqryGaVpT2neAaxbRwU+FzBvHEkiuTC9Bo5GvoOTVQZiwnAqlF
         /ad5H0JKdiGip3w9q/4/eHXHsLlcJhlFQ7Q0k7y7snpCGKLzp5iD7yFtnpMIPs6YCant
         g41HKW38kDs5ixRJKS1yxbB7VwTjssDaMqEwX1zTDTV/ANlFuy48DYh9eB+T9cg2K3Wy
         aXL2rp3huMcv1qtJ5qLHIw/KMud+Bi4Dqz4LbUILa2Unsu+553po5xomidKN4vJsU8Vo
         Trv46lhRe26nzuAIRpR4Vt/m3OGb0/7xNbFNyu4urmuSufeYdCOhgkyu+N3E5053u2we
         tgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749824419; x=1750429219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDMCRDo0cthC7kWsPEVosDcgak2W50xC/1nlZdkqQZo=;
        b=T0jJJkHYv166GUoeYQU/2sgUwMjmPdVLIEfiWxERIPTZ1OB5oRaLoBl4PCDxyESZCB
         YtxTtMBHArohD4xE1Q07pDZ3AM2aCpDt4PAgqSio5fNmEUwcAF42E/rb+/ygAv9aqyyE
         vbRzLeLAqyf4QB1dcEhz3cGdQnAx+om1KhDVWcvgiCJyUYqG+19Is3qrhYpVQUrWBhAG
         ksTlRf1nHJN13tvONB/+tfH6rEQAw/RDE7IuYlLoqsbfPixv0IA2xSukovMGgqcJ9Av2
         xq+ZID2mEivlqG5s2feAChJk8hCOFdDheG60HE/uLUbe7D6+3QrS0x+Op5gneS9SZ+2H
         CRow==
X-Forwarded-Encrypted: i=1; AJvYcCWbpcVRO+432gBX36ZPt3xxKwL5kPtHn4jwkEJFTkFNDtz3Xto+8WUKjaspJMLlIeyAnvbTn/Y97dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfInhEtNI4F5+7ZMuRTD9BzLdzXR9vAswSUM/TyoyQSGkamgUm
	9q6e9sXU5V2+VqG9IO13IRjFnIXA0PrnQ8+m2RBVwleGkQ84oRlJ4netOUG38oxvqOc=
X-Gm-Gg: ASbGnctuvfa+Hv9jtLwDLH6Ztn3XR+0MLYZFVu5tCCGKnc1G4GA9pfoin4vtmR/TXSK
	fXMzSApYRMbnc6Yyh1cBT8E/z9I2tSeHGvp1nh40DCsKrwFtsR0/nsnApdhpdWg7A0PoieWVjwQ
	gme070BzQxlg8NyxiiJCwy8PG0bQ94I26RwZO5S8suqHv45K41Pa1tP0jCI2BSNZwYrblaZwmNu
	L5UqB05MjCOkbK66U1IqvyQRTAupfZiNhMN3V4yeqVQzMvq4y5LSGv5prl2DKRYkdkXgi6sk2/S
	pgFB36NWUO5jErUe9nFWVcIL62fm4H1UkooIMayd45TsBSYgbM/05Sw2YxjmWAdRfpqEgoAPeCA
	VqWJbKZEW4FjWeH0eHIDKnom/bwQbJSfvlVoF
X-Google-Smtp-Source: AGHT+IFl7ASvsW2CdtBJYRdyTIxxAl3o0mUNGo3YJ7/40+1WMA2qlDXnf0YcleUYlBiHZ4WCMkw10w==
X-Received: by 2002:a05:6808:11c4:b0:403:3660:4130 with SMTP id 5614622812f47-40a723a0f4dmr2119575b6e.27.1749824419481;
        Fri, 13 Jun 2025 07:20:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4647:c57:a73c:39d8? ([2600:8803:e7e4:1d00:4647:c57:a73c:39d8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a28401fffsm219284a34.15.2025.06.13.07.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 07:20:19 -0700 (PDT)
Message-ID: <4923f49f-273f-4166-94bc-afe39618672c@baylibre.com>
Date: Fri, 13 Jun 2025 09:20:18 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: spi: zynqmp-qspi: Split the bus
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 linux-kernel@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-2-sean.anderson@linux.dev>
 <9f40295b-484a-48e8-b053-ff8550e589d7@baylibre.com>
 <46a7eba6-a705-4543-b967-e83ccc89e7d4@linux.dev>
 <6afc379a-2f9f-4462-ae30-ef6945a83236@baylibre.com>
 <dbe26b36-a10c-4afb-88ad-a6f7f9bff440@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <dbe26b36-a10c-4afb-88ad-a6f7f9bff440@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 6:44 PM, Sean Anderson wrote:
> Hi David,
> 
> I am (finally!) getting around to doing v2 of this series, and I ran
> into a small problem with your proposed solution.
> 
> On 1/23/25 16:59, David Lechner wrote:
>> ---
>> From: David Lechner <dlechner@baylibre.com>
>> Date: Thu, 23 Jan 2025 15:35:19 -0600
>> Subject: [PATCH 2/2] spi: add support for multi-bus controllers
>>
>> Add support for SPI controllers with multiple physical SPI buses.
>>
>> This is common in the type of controller that can be used with parallel
>> flash memories, but can be used for general purpose SPI as well.
>>
>> To indicate support, a controller just needs to set ctlr->num_buses to
>> something greater than 1. Peripherals indicate which bus they are
>> connected to via device tree (ACPI support can be added if needed).
>>
>> In the future, this can be extended to support peripherals that also
>> have multiple SPI buses to use those buses at the same time by adding
>> a similar bus flags field to struct spi_transfer.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/spi/spi.c       | 26 +++++++++++++++++++++++++-
>>  include/linux/spi/spi.h | 13 +++++++++++++
>>  2 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 10c365e9100a..f7722e5e906d 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -2364,7 +2364,7 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
>>  static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>  			   struct device_node *nc)
>>  {
>> -	u32 value, cs[SPI_CS_CNT_MAX];
>> +	u32 value, buses[8], cs[SPI_CS_CNT_MAX];
>>  	int rc, idx;
>>  
>>  	/* Mode (clock phase/polarity/etc.) */
>> @@ -2379,6 +2379,29 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>>  	if (of_property_read_bool(nc, "spi-cs-high"))
>>  		spi->mode |= SPI_CS_HIGH;
>>  
>> +	rc = of_property_read_variable_u32_array(nc, "spi-buses", buses, 1,
>> +						 ARRAY_SIZE(buses));
>> +	if (rc < 0 && rc != -EINVAL) {
>> +		dev_err(&ctlr->dev, "%pOF has invalid 'spi-buses' property (%d)\n",
>> +			nc, rc);
>> +		return rc;
>> +	}
>> +
>> +	if (rc == -EINVAL) {
>> +		/* Default when property is omitted. */
>> +		spi->buses = BIT(0);
> 
> For backwards compatibility, the default bus for CS 1 on gqspi must be 1
> and not 0. Ideally there would be some hook for the master to fix things
> up when the slaves are probed, but that doesn't seem to exist. I was
> thinking about doing this with OF changesets. Do you have any better
> ideas?
> 

Does this work? 

		spi->buses = BIT(cs[0]);

(would have to move all the new code after cs[0] is assigned of course)

