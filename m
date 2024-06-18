Return-Path: <linux-iio+bounces-6488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FE90D58B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 16:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53F1FB21D04
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0018A93D;
	Tue, 18 Jun 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vjESDmIY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B8158A11
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718155; cv=none; b=gotRvbyMsTrNvK2P96BWCP09EGxaYRbXcoUrFmQkWqgSemJ1+pd4jo86zzQBlYjUCCn7B7sLBj0fLg/iSSyFmKAERfaUmPrPX2oA2tabang1LY2JaItZvE8ecPZbd/W/FMSWaxDdH/yPDvcWCXU88F4btLXnePV8kRQ66chZzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718155; c=relaxed/simple;
	bh=Hw2rKRrQ/vNk+YVNe/TVwDJWQKj5mGabhKIzMLIBezU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9AfaMBzinosM4AkxEKjKEGz4ybUkGVcZuy0QFyXT1rChQUGNZyuPSiz7dE2K9wdnAoyR44xpP1yiy/PqrLDccAF85FrMlIwdhgFVGjj+4wEZCizceZ1VN3O7jtPMEHxkExgSy/TxUdD/Sny1L4MDiEi/XsKnfCDegbbdU9sNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vjESDmIY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8d0a00a35so4532862a34.2
        for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718718152; x=1719322952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2yaAmgIQdF+jsEnorEZWLhxEmZSW+woyCJvm4XIFQg=;
        b=vjESDmIYKDbrgsnUIvhTS3Qajji9YiT/X6+aoXZyHhN4aZIw0rZxpFXHzSXQdDgPSB
         CGQoLJwRAFB3VR4K2+o2Q52LUQZkjXKbzxcpXc9dGGu5oArS5Ub4Q0WK6lHzvnqfvX3h
         aOIO7+MKgEzASMG6H0rq+acAoK1VGE5M7QV0jvypWP5UBlEIi+ap7NurdTFJ0mJT1sOj
         GmJGE/WBN1oh0il+zCRE40UCjyvWfkhsmYys0swctfYvyOGtG410zVudQBv3+feRQ7vs
         Y7qt4pbMT4qx1v+A2dGOPj4LSntM8jVtaRdZomt99h2pBic762IgkwHhDn4/2YSlQWY1
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718152; x=1719322952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2yaAmgIQdF+jsEnorEZWLhxEmZSW+woyCJvm4XIFQg=;
        b=N27PQ2np8BZvF8CiERFlbJ9CmkeTx/w1eAB48c3yXFFA/I98gXTpeQ1Rqtj4lpUszf
         RjVW5HkFZFa5773WIU8Mtdr5sAYS7M21MsGfwMrpdPPMXAs/RY0qxvEp4EeHwdB7maNO
         /rC/H+CJAJM5sEvahm7bxbF8V1H5U1PK4w0OYD3gi7ZtM1sGGXmyACL3gM3xwNSg0ai0
         gnBUCyEuLsmXMNZorBNEKal9IzbMRaleFcPVyp3XKcU5Lk5fO2gD8v2SjfAymcBnrRAP
         vRpBKSLzPuOIyaaR70/Itbh+1wghZP/mH2U7PEztVhuKJHQFpK50lwiOQcJ8qyxaJ+Qs
         xecA==
X-Forwarded-Encrypted: i=1; AJvYcCVsuhZ1Q0ecPp/GDBGXujn2RFC09W2vDRNv2hNRgyTxMKOQHxKt3KkOmrEJlpLkw4qwZseN2z+9dI9Onpvl16uv3/e2oXhHtew0
X-Gm-Message-State: AOJu0YxH6ZvBjq5xvVkZFlMJBl/hh6lMm7DKzbcLjnRvKf4jcbdK9CkO
	LspUdXQAyMPoZU9/FkoXla7atRVOUXBLTkLWE/Ui1pMigffqj2db28wtxpZgT2E=
X-Google-Smtp-Source: AGHT+IH0XBL+oYGfFfDAABV2lY6rjFGswntrsxIQtwr5eSwP1oqGMYpSQ45XFMtQjvOVFYM82V+h4A==
X-Received: by 2002:a9d:6d92:0:b0:6f9:6e0b:4ac3 with SMTP id 46e09a7af769-6fb939ec9b6mr14767727a34.23.1718718152649;
        Tue, 18 Jun 2024 06:42:32 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afa9ffesm1824394a34.15.2024.06.18.06.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:42:32 -0700 (PDT)
Message-ID: <edc38640-42ee-4bde-bc95-500498b5a461@baylibre.com>
Date: Tue, 18 Jun 2024 08:42:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 kernel test robot <lkp@intel.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
 <20240603012200.16589-6-kimseer.paller@analog.com>
 <408aa030-23df-418d-a04d-a5551119624b@baylibre.com>
 <PH0PR03MB714164FC9335DFBC003E4F57F9CE2@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <PH0PR03MB714164FC9335DFBC003E4F57F9CE2@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 5:32 AM, Paller, Kim Seer wrote:
> 
> 
>>> +}
>>> +
>>> +static int ltc2672_scale_get(const struct ltc2664_state *st, int c)
>>> +{
>>> +	const struct ltc2664_chan *chan = &st->channels[c];
>>> +	int span, fs;
>>> +
>>> +	span = chan->span;
>>> +	if (span < 0)
>>> +		return span;
>>> +
>>> +	fs = 1000 * st->vref / st->rfsadj;
>>> +
>>> +	if (span == LTC2672_MAX_SPAN)
>>> +		return 4800 * fs;
>>> +
>>> +	return LTC2672_SCALE_MULTIPLIER(span) * fs;
>>
>> Are we losing accuracy by multiplying after dividing here as well?
> 
> Hi,
> 
> In the case of max span for ltc2672, I found that performing multiplication
> before division causes an integer overflow during testing. I was wondering
> how the upstream handles this case. Could you provide some advice?
> 
> Thanks,
> Kim
> 
> 

In cases like this, we usually do 64-bit multiplication to avoid the
overflow. There are helper functions for this sort of thing in
linux/math64.h.

For example, if LTC2672_SCALE_MULTIPLIER(span) is unsigned, you
could probably do something like this:

mul_u64_u32_div(LTC2672_SCALE_MULTIPLIER(span), 1000 * st->vref, st->rfsadj);

