Return-Path: <linux-iio+bounces-16050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D6AA43C47
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 11:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C501016F64D
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 10:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EA026738F;
	Tue, 25 Feb 2025 10:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLwlHszc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F1266B6A;
	Tue, 25 Feb 2025 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480734; cv=none; b=fe/qHK6M9c3FPv1QibixXBRJiX5YPz7E0CmnUC4Yx58MGf/06MEPbCiYZrdC6hfrHyj6KO+jfm2EtKr6n5MDAEEvdL4FTSIaacybjOinX+kRqnwfEgHQtIyxZIv6UJF1rG10jyguFP2ZEVWXvBIH/IKXCiJ3fMmkAlBCF33wnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480734; c=relaxed/simple;
	bh=uAXx1+xeAFyV+SUI7uXjsB9Thym7OEsMYo16qDBycS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BszqI1TQoLpgLv3zOeg9vyPHyKTmP0EjTyhtfhhV2GXsEa4Dh0Pq5JA/y1GfIhPPOR5niZrLyLMD03TxHngkJqCUGP4wtfMLgxMOqL257EfwjGULccMVg6QYv0oC7iHz+eIlCaOVkwqJlOLtTck1M6lPzI5hVqsmduEmonbVaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLwlHszc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a6bso56879301fa.1;
        Tue, 25 Feb 2025 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740480731; x=1741085531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh6sf/0cKXadcZmQR4PGzWs7fubxPpGtogL6k9WOu9g=;
        b=FLwlHszcR8Qavp0VPqUWRm7Ru8MpsTKbIOWceB5zX5daQxEVC+yoQl0zJJlYQKP4Fv
         6QXhrW36xb5iMGMq5Fm2kszYjpdtcCuIub075DsFijZq7erbf6rwaFt/pppSh3axjISu
         UjyMTUoeB7y0P/XBidExfNF/Qn+R9T+Y0Xa1vp5e9ZM5u/V+edFo/MUAkwW6/WeTFri1
         f6oZu8EeeDL/ZgFpThkYa7pjdqCgjlXwCmhH1JLPI0cHDbvYb9FOIXN5MKMZRcE8C+Sh
         a6NGVs9H4r6pSXfnCJ8LxYItK2G5Ij+9XJCwmIjs1sQ5q0uo0/iq3Si2cTMb6QLi+j0G
         /a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480731; x=1741085531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh6sf/0cKXadcZmQR4PGzWs7fubxPpGtogL6k9WOu9g=;
        b=LSmyq15lXFxn7bc5KEDlo2AfUuNfFJi2SXAdqfhvdRrh0S15onIGuqiFvLvM921KH2
         2ZQlTuO/kLvsoNh21UVbfrdCf/3QtYvR86yer83+EaBXrg2tlr/CxmE3GOvhpnCJnJVy
         YUmORjhRfpHUMO3CeEYf1BK04nLZH9TrPKlUVQ6Yr9ngHKHwi97mzZiJ1I67RuACZZmC
         yMLqObq3dzYBBp+6LC9xmpTPhy70c4MKeIe2z7veXZXDjcOkpYm/SGA2O5GiT9A0mJBo
         evwt4gaYklVaXHfu+YUJ4l7YBw+86ykoftAnVNnLInHX1gH3qsJ0EQ4m0j7/QwV5qP+t
         geXQ==
X-Forwarded-Encrypted: i=1; AJvYcCViPh8xWJQKhxfLUxpALc5ehG88nD+oT/70MZLSK/Vtjwt4frKCercGuELW/vKpsrvi5HpF8uIVO1fp@vger.kernel.org, AJvYcCVzL1OW9V7EXtK1YubsKtMrUC7h5lbT5BAyn3keFL7ETam6Da/I9nf8DYDKtMAlhmMa9QAE3ruJW1wTww==@vger.kernel.org, AJvYcCWUbvcP1+taRi6gYm7WKhX9EY5woVV2AaYXswEA85OHcwPUBVv03vXS/NFTajJqul8xewrkYpZQQKAQwByY7BOYQiw=@vger.kernel.org, AJvYcCWc54GC2Eh6Y61nReGEczn+0SBKV9+dibnrXRWFWgZD7MjfA/dtzgysBKOVB2ofezTF4FxBR6MZimGOmK5w@vger.kernel.org, AJvYcCXU7RI+ZcFsI8kn3NYO6XtxIb4HgYU+/Gzcoor/SgQi1WbVlVRVid5gMAeflL8VrIjFt3exOztfdnJf@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDC5y1YFtQyn+RLQFXFCPQXI3230WA/QADhU/Q/kR/5pGz2vR
	2l6uMWkc7gW+uUwnyQfE1nCGS7ZUSlyD5HhYeABCThGJMxiUCj0e
X-Gm-Gg: ASbGncujbpzOIBgHidPrFY45YQdjDjjj4OsQf8x5Dz0JN/MXcPgXOiq0YiPnRpr4eds
	sLgGwMaseHTDl7XNgxppyd8hflRYIY87B2pm3rNQKI9iSsDM9gdp2EszEcJ/laFi3lvNloD/1dM
	g7NTLAeyDFXwHei8JoFbfcrf6AUYIodj3WHZDMrlrcZir49bn3gfqsPQuwc6SlI0xnDU+lsxvj5
	R9qSDzMm6h79a3DSkQI0gkmcAOtX0M1DR070b29EegqH21TbVs+zeJgjTp3f60Z96YnUvXR8uTV
	zrYWoiMfPCfkQbwcq/sU2U4Hr5PdC+unInQE2mY=
X-Google-Smtp-Source: AGHT+IHos/L3fbLnhOLot3czcjTdpc0kSS3ue5NjEpFQm5GfsKczAy1WAOw0rIcb+pgC1rLfhfv55g==
X-Received: by 2002:a2e:98da:0:b0:300:de99:fcc7 with SMTP id 38308e7fff4ca-30a80cb8079mr9573441fa.36.1740480730280;
        Tue, 25 Feb 2025 02:52:10 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a81ac3190sm1936591fa.80.2025.02.25.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:52:09 -0800 (PST)
Message-ID: <f92724d5-e9b9-4cdd-8443-4866946d4568@gmail.com>
Date: Tue, 25 Feb 2025 12:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] property: Add
 device_get_child_node_count_named()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Daniel Scally <djrscally@gmail.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
References: <cover.1740421248.git.mazziesaccount@gmail.com>
 <29ec24f1498392cafbecc0e0c0e23e1ce3289565.1740421248.git.mazziesaccount@gmail.com>
 <Z72QAOA9xXbP16K-@kuha.fi.intel.com> <Z72Zp8tpnvlFGdQ_@smile.fi.intel.com>
 <ad39b453-7e5b-49bd-a4fd-6a4988636130@gmail.com>
 <Z72d7TzZ21WITW3f@smile.fi.intel.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <Z72d7TzZ21WITW3f@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 12:39, Andy Shevchenko wrote:
> On Tue, Feb 25, 2025 at 12:29:31PM +0200, Matti Vaittinen wrote:
>> On 25/02/2025 12:21, Andy Shevchenko wrote:
>>> On Tue, Feb 25, 2025 at 11:40:16AM +0200, Heikki Krogerus wrote:
>>>>> +/**
>>>>> + * device_get_child_node_count_named - number of child nodes with given name
>>>>> + *
>>>>> + * Scan device's child nodes and find all the nodes with a specific name and
>>>>> + * return the number of found nodes. Potential '@number' -ending for scanned
>>>>> + * names is ignored. Eg,
>>>>> + * device_get_child_node_count(dev, "channel");
>>>>> + * would match all the nodes:
>>>>> + * channel { }, channel@0 {}, channel@0xabba {}...
>>>>> + *
>>>>> + * @dev: Device to count the child nodes for

...

>>>> I did not check how many users are you proposing for this, but if
>>>> there's only one, then IMO this should not be a global function yet.
>>>> It just feels to special case to me. But let's see what the others
>>>> think.
>>>
>>> The problem is that if somebody hides it, we might potentially see
>>> a duplication in the future. So I _slightly_ prefer to publish and
>>> then drop that after a few cycles if no users appear.
>>
>> After taking a very quick grep I spotted one other existing place where we
>> might be able to do direct conversion to use this function.
>>
>> drivers/net/ethernet/freescale/gianfar.c
>>
>> That'd be 2 users.
> 
> I haven't checked myself, I believe your judgement, but can you add a (rfc?)
> patch at the end of this series to show that? With the luckily event of acking
> by the network people we may have it already done.

Sure. I can add a patch to gianfar when sending the v5 - if this new 
function is not completely NACK'd before that :)

Yours,
	-- Matti

