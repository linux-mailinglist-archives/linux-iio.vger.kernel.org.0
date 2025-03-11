Return-Path: <linux-iio+bounces-16722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B09A5B8A4
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 06:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655C817130E
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 05:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9971EE7AB;
	Tue, 11 Mar 2025 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfchkWX7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D401E7C2F;
	Tue, 11 Mar 2025 05:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741672184; cv=none; b=sK7iN0wewiNTjAWMp5CPfnPmzp/QzaciVJha+1HlWSDFfQXaIi8eDvgmxIT0Z785TKA0/51la2ZMnfX2iqW96g3tS6izImGj9MNCDCRVEmkBiGLulcDTLdj3+bFuftljjLnmbRmYlpxzv7IcofleHkuU14D6tbIhdNK1GzvZoEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741672184; c=relaxed/simple;
	bh=vcLPf/kGXdgNxEvJBEVrEREglMzwjiza70RRocx5oyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRasrrkxIhf0I22n3/A+6NcO/FZN4wXPxsq1vMbaECkx0pjIjP9GM/6GrcB6c4BOakh+wZAXuC7DSSXZ06xTlrojyxEvuhRQZQ9i/lkUmuTEtULRNcDnwNuHJqfYS0iEPgccuYHdWFpzrzJ3+LgSPgOdraKPemdP6eToLtXPiEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfchkWX7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bd21f887aso45484621fa.1;
        Mon, 10 Mar 2025 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741672179; x=1742276979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUlywhCQq4uCWufEMKrFo7MVjuzCwOMvUwcuZVYGs6Q=;
        b=UfchkWX77VxXixzzLXs8+qWHR19kDBid+GpFT8tmFQukx5/kO8IgJlsXgVZyU+VZkT
         qycHt6vH3UrXv9wW0ioorciJ3TiImhPK4rj6GClFTHnrN/dhcdk3CgO5nQBYZZtmggw8
         K4pftWjKok0qfNLHJgzDloVsgcRzWKCONiwkLZrlO43zobEmIvHQeFnmE38mZhYD2l1u
         PGdb2WZvRDu6cAwvVfG4wcdG6pR22jdfN8DiE4XufbSqUDnpnY7mNb3wmwWarIK50Ad8
         9KkR/Ck/BgOO6UlaMKCiws5xvUUkV03ezeX7WaqOayI1aFTX3eH2eG8xEIF6clZl7l12
         7xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741672179; x=1742276979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUlywhCQq4uCWufEMKrFo7MVjuzCwOMvUwcuZVYGs6Q=;
        b=A1KUNQfWTJybvEAy/ORgJnqUaMqYBiLuAKkiq33jjDCGc7N1yY/QFYNW5H2/z7756f
         jytHzd5rAaoPNUU/Kq2dyvURRnagMFh6u6I/KYTZIQVS/f7LtXPxIw8aKvVsRdd/I6oy
         4LNwxGdmPTUia5TFnq/2LaQsbeutkKAbHYRK9wbpvqGlQwXh6hT2SKKfm/9VstEMdi+h
         h4JjFWvbMQW2p3SgBBJEUEmtZ2URQmaXU4j2jhv+VbIMga80BwlUI0WY3g/8EVA1Xibp
         mOAu94I/A/foTnZQZo5FsPX5c0PuIUGR9vNeHDsfwXn5dkMOkTySwG2bw//hg7sfeSvk
         3zGw==
X-Forwarded-Encrypted: i=1; AJvYcCU2LFlsqaAmEApnO3SuatavLwR/NBGBDWi6yuBGHax20KJh23ISFQocp5BE5WdDBRXLVgfiMvK/wR5jaGA=@vger.kernel.org, AJvYcCULtm+QS1sjySKPRJ2XJbhnogA3FVdoxXO3sdcX4H4v4ldha1Bs04ZaRVhZUFPnF4zVopjQz3e8@vger.kernel.org, AJvYcCV91t7WRnm5mpoIBsyXLT8gg1mqeRAG5wT3j1v+Xrq31BHJyTGgbsrxKCaFig9Y7RdBe1MwtvQmqV0h+zZb@vger.kernel.org, AJvYcCVLy68anqHRt+qtQic63qhYFvTM1Hw8MY1siCe1HJjhnr0ghVCgnhj0zidAgWguA3Du6oIbHRthjP9n@vger.kernel.org, AJvYcCVeZoQHm8nqCNox59jErLjiFCPsGakLmM+8X63YjUeRzD5K8ow/X3NpzcsIpqdNIP0kwk1yJte6+BQGyQ==@vger.kernel.org, AJvYcCVk/atbRiT0CC7WS3ujQ7YrDA5np64Q+R77wcTq3V0h5lUw6EpBYfK0LHOSPz7ReMGNOnL7Cw4VVrB6Jc+v1nHwCrs=@vger.kernel.org, AJvYcCXNWt/FWGBtObGxQ6Zgeue3bhGC8DgDkoWppAn13umv9Yy3AWe2xPwdZz02KoKsUjS6uso62eD/0Sw2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wsk8E6HC1pCLAg5n8onBUOfyaB5n07KbF2dZWoL7jcpu6iiE
	wyTm2kpfBRTlYC+EoonmOLfi4qSzPaXii7H/EvRkJjFHy+WG6Cqs
X-Gm-Gg: ASbGncuzDYy6XV0mqSaOBJBj0AQAmflrXxE0iL/nCY4BVficj1F/GS9bLcwzLSNEzo7
	yr4CQ1knmRLpLXMd0fWlH6GC6QwF+ohviR0CT1e6EjabLPOF+AtSekT9qm3QXybIXn6vZBTh/Cu
	HoRtUaTWgZyrySE6iOhZ16r+C1NQgnZ8mVaj4ncxhecnotrnDLVrqYBsCYjn6tLYNtoVe4MaZ4T
	i4yH5sCnZZU6C9n9D4rwcx3TfZu0SOLQPStTqQbmruHm/gcpOwxecDq6uc7/Kai5mUubhXCQcIY
	wtHhQBToTIme014NqM5IHqh304wo8/mDZ8XrUBtEvC4ChCX1QnVsC7zYvYbSHmLmd/BUL1A5yYQ
	qg0UhRanezsrE3npcCDVgN9XeIg==
X-Google-Smtp-Source: AGHT+IFm0afzcaF8TIv4cXHtJLsVwhvjYD4qt27mTceOLe/iKEGhGrdN2AEjY+GxRz1y2ryUkV4/gA==
X-Received: by 2002:a05:6512:2309:b0:549:7145:5d25 with SMTP id 2adb3069b0e04-549910b6189mr5273956e87.34.1741672178594;
        Mon, 10 Mar 2025 22:49:38 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae5904esm1651369e87.76.2025.03.10.22.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 22:49:36 -0700 (PDT)
Message-ID: <e685d31c-8cdc-4732-b3a8-8e70a6f82578@gmail.com>
Date: Tue, 11 Mar 2025 07:49:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] Support ROHM BD79124 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Samuel Holland <samuel@sholland.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Nuno Sa <nuno.sa@analog.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
 devicetree@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-acpi@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-iio@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-sunxi@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Ramona Alexandra Nechita <ramona.nechita@analog.com>,
 Paul Elder <paul.elder@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, David Lechner <dlechner@baylibre.com>,
 Chen-Yu Tsai <wens@csie.org>, Daniel Scally <djrscally@gmail.com>
References: <cover.1741610847.git.mazziesaccount@gmail.com>
 <20250310202738.13301548@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250310202738.13301548@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/03/2025 22:27, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 14:53:50 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Support ROHM BD79124 ADC.
>>
>> This series adds also couple of IIO ADC helper functions for parsing the
>> channel information from the device tree. There are also new helpers
>> included for iterating and counting firmware child nodes with a specific
>> name.
>>
>> Series does also convert couple of drivers to use these helpers. The
>> rzg2l_adc and the sun20i-gpadc are converted to use the new ADC helper.
>>
>> The gianfar driver under net and the thp7312 under media/i2c are added as
>> first users of the newly added "named child node" -helpers.
>>
>> There has been some discussion about how useful these ADC helpers are,
>> and whether they should support also differential and single ended channel
>> configurations. This version does not include support for those - with the
>> benefit of reduced complexity and easier to use API.
>>
>> NOTE: Patches 4,5,9 and 10 are untested as I lack of relevant HW.
>> They have been compile tested only.
> This probably wants an update.  Also, 00/10? There are only 8 that I can see.

That's odd.
There should be 10 in total. And the 4, 5, 9 and 10 was updated.

9/10:
https://lore.kernel.org/all/1c4b9b4ceb1995bce76a0ddef0e04ad0d1d81190.1741610847.git.mazziesaccount@gmail.com/

10/10:
https://lore.kernel.org/all/ab79cf4415d21ff2854fee4f4189fac555c30b7a.1741610847.git.mazziesaccount@gmail.com/

Perhaps it's because of the "net-next" in subject?

Yours,
	-- Matti

