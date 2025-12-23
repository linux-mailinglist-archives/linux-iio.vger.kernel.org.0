Return-Path: <linux-iio+bounces-27341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FB7CDA1D1
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE73D3024E40
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576F347BCC;
	Tue, 23 Dec 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PHkNZT//"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B7199237
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766511187; cv=none; b=lejkRMqxBm6+aVq2g8Cs3CvJpwRDmc686+x98jGaTzillUx3tx29LweOn6/UyJwB5BMHtG8PLeNFUf7NfnFttEdg8ksK5zsTqxap1BkCwdI3mothlhHYEZCDXwBVgi8rB98DBSMMuwlu4zfwfC73ZN05RA7RryTKixICL3DXcN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766511187; c=relaxed/simple;
	bh=3eDEZMaS+8DcWuMKuK585qT9nXKWNYurcInLVh5oDQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fh8rT137Mo9Cd2svqLhEf74lDlwMLE+MgcF5j3/uu3yBNga7geUrdOYTl/a4VENnSrTWJjc1CB8jx1opuaUYHB8BtqPz3vim7SSF2Iq2F8Gw984g96hyZ9b+TvzgpCzrZOExSbVNUaR3/HT+/1JlDHGoNRdtwqy9hMXNRVADCZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PHkNZT//; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-3ec5df386acso3850531fac.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766511183; x=1767115983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEWdqOagK1IMdQa9F3rPv/DjldvH3JIrOlYqo01koPI=;
        b=PHkNZT//ETIB7MEIpOmaBfy3e/4iwROHH81umAVNgu0T3nvgotKBj3bX8y94MIxLaJ
         b7OgKXC1ZwvkG0yL7tPt5Nj/HLDPkJwG8U2p9A0Og+fDw3pecz08QRK97OF64aCQyf6C
         XB4fRuFYsyU1Dci/KOPPjUbVCXxba2iLCBgaYSUw/1vVZjvTjI5aSjVLCLMMsPZ3GBcJ
         KaoWO4qWVf4NW+c4koCocdgCnRT2B1nQJaP+MyrhSPSpm/kzYo2lCl3lbXPrUpizUvei
         Ltq074/gzb8l0Xv4SmEau8ZdLryZfLrISQWqmjt+l6i6tmO4av8A281+VtYCKHU+PnSB
         gg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766511183; x=1767115983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEWdqOagK1IMdQa9F3rPv/DjldvH3JIrOlYqo01koPI=;
        b=fkAhKTn5nOJsKlZ4wgMPIWWZ5/uOXGqOlTAyoir2zA0JKFpwTqxmfDNkj9IdRXhzMC
         azJNMIRcQ8N/cZZXKOqNefNmQyZFZ1GbsGC1i6odNrj50tS2u/GetPI1f3ilX/MJjSSV
         o40ntoLI3Mr+4R70s7HoiUb8R3ib0/90KZJpvI8iaJTCRfXpPkoQ+OFbJ2B6KUPNQ+Lu
         V/Rzk+cBAnfNNHcvLbU06r7LQz8p8GHYmFawxiMXT9gxlDZF/UBj2L+Ba26gZxU2111q
         AMoGucEYAv7j4ZTD8tZ7suoSChm/nPgmXLAfsYwqqFtHt+tlJ5/BtyyTublJv3brzLHz
         mDzw==
X-Gm-Message-State: AOJu0YwJuY6thmg+cD04nBXDfj2tHk7KJL+yFQErYFMpSaYMnEG52tO4
	EJhWuC9nWm3v2LZwzPFyjSIqhX1V4rWcihIponqN0yHB1qJqGxJMQ6EKtv3pdbAZZ7Y=
X-Gm-Gg: AY/fxX5e83Po1O4RmqIroJamdpkATTxlRvzDNHTUo9htXyn7hYJNGywL/Q4T5E6kbf2
	OngRSJ2FGzSJpTVRCEiAGi2mdeQRtE2VQdWtMDHYQyHUYrzwf/GC5jw7KoWSrbH9Eb3vpK1Ig9d
	7Kq1jlfuGoLsYvNskOdnZGlopSY1AkOiw45eUoQAFAPJdlxFe0hrVxtI6ADVO3+Yy/IgCYQdTFP
	YFt1LZ2/hoqOzYnbVuxwq0zuMnAb+vFPaPhvaQBvWZY4KNi8CNDwYzZ+9fOnGQWSD9Opw0ZtIjF
	nfmP4OLxVsfQH6Pp/SAp+d1sq2CLNG76F8AC7x+k796Lmkar1RAPLi4pjCB0GcZ13eeQVvsilsQ
	EKnBIUKudN173wVgltDL+Jf44JFNfczDoxlsrxLAgBHF9aP2U5/UuiIC7gEuBF3feeiJyNLcLGc
	BCRgrmaweo6NbXxNJIZzVabFCaxUly65rq6hD1zAcNNxVjRZak/X3T1ZI8ktpz
X-Google-Smtp-Source: AGHT+IGTT0Kqcp0Fv96quSyK8w2Kn84GuPDDhDZJFMMivHiXqrzf5rPDldykdeoIWxcKPUtUQ41veg==
X-Received: by 2002:a05:6870:2428:b0:3e8:970e:d4f7 with SMTP id 586e51a60fabf-3fda51e5abbmr8231088fac.11.1766511183588;
        Tue, 23 Dec 2025 09:33:03 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:fe29:88f1:f763:378b? ([2600:8803:e7e4:500:fe29:88f1:f763:378b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaac0273bsm8895229fac.20.2025.12.23.09.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 09:33:03 -0800 (PST)
Message-ID: <b2ecbe6f-aed3-44de-b094-022e52d3e5a4@baylibre.com>
Date: Tue, 23 Dec 2025 11:33:02 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: add driver for Texas Instruments TLA2528
 adc
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Eason Yang <j2anfernee@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 duje@dujemihanovic.xyz, herve.codina@bootlin.com,
 Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20251223155534.220504-1-maxime.chevallier@bootlin.com>
 <20251223155534.220504-3-maxime.chevallier@bootlin.com>
 <3e9a5df0-c650-46dc-8b64-b8708099262e@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3e9a5df0-c650-46dc-8b64-b8708099262e@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 11:12 AM, Maxime Chevallier wrote:
> Hi again,
> 
> On 23/12/2025 16:55, Maxime Chevallier wrote:
>> This adds a new driver for the TI TLA2528 ADC chip. It ha 8 12-bit
>> channels, that can also be configured as 16-bit averaging channels.
>>
>> Add a very simple driver for it, allowing reading raw values for each
>> channel.
>>
>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> 
> Looking closer at this, Rodolfo hasn't seen this patch prior to me
> sending it, so it should rather be :
> 
> Orginally-by: Rodolfo Giometti <giometti@enneenne.com>

I think the usual way would be to keep the Signed-off-by: and add
Co-developed-by:.

See https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> 
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> I can resend if need be :)

Wait a week for other reviews. :-)

> 
> Maxime
> 


