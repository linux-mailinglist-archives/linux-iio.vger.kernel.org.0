Return-Path: <linux-iio+bounces-6640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AA911188
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 20:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE61F230EB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439501B3741;
	Thu, 20 Jun 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0EVECT2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F61AAE17
	for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909739; cv=none; b=RPhc/DhYnr39ue93rzDeMFn+1QYOn5SElR2RBksIchRuIWtdH23FAxq2j2NgdHrfRN7leVGPXp2w0F5/KJsS47/M9Q1I4TN/z0oJeEpY0+e77Uh69erZIGltW5gbsSj1yyVMX5R0mwEE7cCgvYsTl2ay5aqhCSpIolfW34yRmt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909739; c=relaxed/simple;
	bh=H/R3HcK7gnjZXGR/Qc/zm33fza7/aCJqu6TNxANcPQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mR01mBEx7osMWSv+AkX0FgbAXMgpzW+X+0y4SQBFVM6KScr1G7qSrnB93AemNS4gmtyxeou9mQPROFYq0PEfWYzrhVS/5Nnhd+xdofgmzdKaoXOyMp8MNtt4Yt89JrD7AsEfDw8FOQH8g5o2LRIlFWfX7GvVvF0fYxFvV1s8R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0EVECT2X; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d21e00d9cfso725586b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Jun 2024 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718909736; x=1719514536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H/R3HcK7gnjZXGR/Qc/zm33fza7/aCJqu6TNxANcPQk=;
        b=0EVECT2XaJC9U234mXYaAVyuzikCIduHjCVWW2HvSwy3pfchbhwSxiC+BvSCogJabr
         Y/C1AhrZws67l4vIowRww6QEPCb1JnZoXMICAmLhcEARdwK1RqAtxupOd2ecM+iODfQ3
         mV4Dv+4PmYJuqGIBvwKghS1cmWx2wgx2bW6tswkoQGZbcwVuDxKb2MNKpgrYOGEibVTK
         qpxogE0VT/T9oEbbbsAfz7oQNww/ou8AEb+rVBO8p2ZbOijpC2czWW9YsLlONnLtO+WO
         zlF0MsVkTg3U+f/RJ1Y7M9xUMvRA/yu4GAXGZqD+CQQjFz7vXTcatctRGmf3r5heyt1M
         mmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909736; x=1719514536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/R3HcK7gnjZXGR/Qc/zm33fza7/aCJqu6TNxANcPQk=;
        b=pauyHSOpLoMXTAqJw7LMK6rbARkZgyLTTM3TXJwYAP5nuyvSNVsOmPBpSTmNtgFNm2
         X1AEZPwGqyx0KlibdhuKFjxzvc/4GoMzLOHnhnSmSDHtXEUSvfhvyltgNxDAU2D2zCWt
         o+++1F+gNR86Doe2V7LAbHXuVeRcC/bZ1QjdWByTFwVjxZOasO5vdEp3p71TA+c401Os
         sl+pkpLI8oDarBOwScHSq9RN7e3NEVqUnLOz3uMxSZGT4jAjnyodvdDlpESQvOjJvMuW
         cZqo/HS0cnx+zbDWCd8sErET7sLWs4JglKGCC1TjfSWPYNShJh4VdCYHSK05BIl1d2KM
         RF5g==
X-Forwarded-Encrypted: i=1; AJvYcCXvzs8AFvx265f3eBA9LERPmVQ0lsq88jrIjubDGW5WeRc16xJTwauF9GiojFTJ8fefbdsz1GXnFm3UtBw3zHmLUek+NMIYO2uh
X-Gm-Message-State: AOJu0YyplUF0ou2421QQGOwaGuHGMgaNdC4k1eIhXpSkzWKCV72lcfN2
	DP3lBCNp+FS7eAisjpHeL4iBcWt9wIVbJzcvJ4j7VB2ohWE8SFEuCdJZxPH700I=
X-Google-Smtp-Source: AGHT+IEjbLNYWFvxUGbprjlhgt3Dx7QgrbGK7vK6OHqcSZukBBTza7iDnYbe14RaF0wwGAFzzqN4tA==
X-Received: by 2002:a05:6871:592:b0:24f:ef6b:353e with SMTP id 586e51a60fabf-25c94d106f7mr7009622fac.36.1718909735864;
        Thu, 20 Jun 2024 11:55:35 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd49d9a2bsm7018fac.33.2024.06.20.11.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:55:35 -0700 (PDT)
Message-ID: <bbdd9716-3144-41e6-9558-7fb147cb0774@baylibre.com>
Date: Thu, 20 Jun 2024 13:55:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] spi: Enable controllers to extend the SPI protocol
 with MOSI idle configuration
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <36eefb860f660e2cadb13b00aca04b5a65498993.1718749981.git.marcelo.schmitt@analog.com>
 <63db9349-f453-4a5b-aa09-d1857ddd8b03@baylibre.com>
 <ZnMqOAPc3IXP-eHC@debian-BULLSEYE-live-builder-AMD64>
 <e7a2438a-f6a3-439e-8058-937248dd5b3f@baylibre.com>
 <ZnRG9wgY3WIaYFyQ@debian-BULLSEYE-live-builder-AMD64>
 <08c09a34-af59-4387-8db9-594f30f85b7a@baylibre.com>
 <ZnRzIb-cD_oOFkg-@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ZnRzIb-cD_oOFkg-@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/24 1:21 PM, Marcelo Schmitt wrote:
> On 06/20, David Lechner wrote:
>> On 6/20/24 10:12 AM, Marcelo Schmitt wrote:
>>> On 06/19, David Lechner wrote:
>>>> On 6/19/24 1:58 PM, Marcelo Schmitt wrote:
>>>>> On 06/19, David Lechner wrote:
>>>>>> On 6/18/24 6:10 PM, Marcelo Schmitt wrote:
>>>>>>
>>>>>>
>>>>
>>>> ...
>>>>


>>> I don't know if that would actually work. I have not tested doing something like that.
>>> This also implies the controller will be able to start the next transfer right
>>> after the first preparatory transfer ends and it will meet that inter-transfer
>>> timing requirement (which I still didn't find documented anywhere).
>>> I'm not convinced that would be the best way to support those devices.
>>
>> I did something like this in the ad7944 driver where we needed an up to
>> 500ns delay before asserting CS. On SPI controllers without a hardware
>> sleep or FIFO, the delay will of course be much longer. But the delay
>> is just a minimum delay, so longer doesn't hurt. It just affects the
>> max sample rate that can be reliably achieved.
>>
> In ad7944_3wire_cs_mode_init_msg(), xfers[1] is prepared with spi_transfer.delay
> which is the "delay to be introduced after this transfer before
> (optionally) changing the chipselect status, then starting the next transfer or
> completing this @spi_message." That should work for ad7944 because
> it has ADC SDI physically connected to VIO in that setup.
> For ad4000, we would want to set MOSI high (by writing 1s) such that MOSI
> is high when CS is brought high (if I'm getting what you are suggesting).
> But spi_transfer.delay is introduced after the transfer and before changing CS
> so I think MOSI may return to low if the controller idles MOSI low.
> I can't see how this would work for ad4000.
> Other delays we have for spi_transfer (cs_change_delay, word_delay) don't seem
> to help for this particular case either.

I was actually referring to ad7944_4wire_mode_init_msg().

In the case of ad4000, the SPI controller will be required to support the
new SPI_MOSI_IDLE_HIGH flag. So at the beginning of the message, before any
of the individual xfers, the controller driver will configure SCLK base on
CPOL and MOSI based on SPI_MOSI_IDLE_HIGH. Then it will do whatever the
xfers say.

For most SPI controllers in Linux, this SCLK/MOSI config will happen in
ctlr->prepare_message() which happens before xfers are processed in
ctlr->transfer_one_message(). In the AXI SPI Engine, the SCLK/MOSI config
is in a separate instruction that happens before anything else in the
message.

So if the first xfer is just a delay with no read/write, the delay will
always happen after SCLK and MOSI are configured. We don't have to write
1s because SPI_MOSI_IDLE_HIGH already does the right thing.

