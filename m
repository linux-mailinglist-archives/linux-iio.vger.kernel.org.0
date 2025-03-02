Return-Path: <linux-iio+bounces-16245-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4A9A4B1BB
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 14:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588C51891B39
	for <lists+linux-iio@lfdr.de>; Sun,  2 Mar 2025 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EE1E51E0;
	Sun,  2 Mar 2025 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TREDQvtD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C721BD00C;
	Sun,  2 Mar 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740920814; cv=none; b=OEgb54kVp/C7/JwtKtwPmIovjYogHLPgxgaACUIiYlWQdrm3QN2izghmAxCxmg50jEfQgTCnndlSl+ieIyIWRDeIqD4JqFXr0opwj56dmb63sNzRP6bqFHgCp8Ts9QIfkbRMreehqeywv/T/BIweotvZpQ+BhgTiXgNarVNn2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740920814; c=relaxed/simple;
	bh=Wc63yfyqZGwbD63CYJ3J2dS4oj/xXBruMTdVa0We1vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsIydtUa3d+xCMObLi8jvdwYNBRk0smBqeHEBVOCDXKjywA1F+XKt8+jDHaICtBFOH4bj3y5aqu3qpH2G4O8tca6zpTA68vixUYuHw5yQStWpXAqVvDISA55tohxypiqBw6ToMeFI5lgqWH2pa9VAyMO2DbFdYToroXCL5BDxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TREDQvtD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30761be8fcfso38967281fa.0;
        Sun, 02 Mar 2025 05:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740920810; x=1741525610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+axkLd7tQFz7zR9h7JCTxpVngu93rFLR93Lw7kqAh8=;
        b=TREDQvtDyBA++IJ0gU/v2adRbdo/x0Bj92WMt3Fg/Xz0FWZ+xDqc8jykV4v19+vSIS
         lyucrz663QFp/UkLEs1qU+w7VXzAxemGV6vc/p6zCaskS3GiHGYdlsLmJ8uNfDOlTiKm
         2wYxefbt/QWK4jidBbhklkbTRRk4+6PqqpwjkvmGywBeYjsvrnbHXA9EIeCnJlFQS9zX
         YIRibG+oBXlaMjd9DmXon5GNzZNJNPGoHm6k6wGWPgaQfXu7wmpv2beftY/Qp37wHOy8
         lfBc2SPeDDAVu9YXXL5+9vyxf8daapCJHh68QldF6dV6JQzXxDpNkvhYVrojryxPROIw
         GdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740920810; x=1741525610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+axkLd7tQFz7zR9h7JCTxpVngu93rFLR93Lw7kqAh8=;
        b=TiVDJ9TxV+gEIzFYox2T/iML2/TggqckuTZLnDMtEVmZ2k2IzdJe8WSQRWYz7K3oYx
         ty2Oh3tBRoc5TDI4h9rl3s3S72gIs/QLELjGNQk+YiYuv45hPIklzgfd4hHcu1Dy5kWF
         O5AVeOipwggWiz/B5lsFZAvDS/u98oWQwx7gtQFL4vDhzWIs/f4RaHAPPQXRa5X7mwYI
         RkTNykYcZcFsucWqKn8DRnWc6zMtiZgjMg8s+scfvgyTucFJT0K5fgShPg3D+IbBH72V
         WrY5ETGghOx9YlT4RIjjPUgeBWWot/nkOwxIjmoZqTSw/+F8DJ6/6Lnhwhz1QMo+PF1f
         3H4A==
X-Forwarded-Encrypted: i=1; AJvYcCU7I0CE3+btdwo7dQcSrgxR0M/qm3T6Pvk1S9xVZaW0EyV/ZrAT5SIOASyUaralxRKWGnQtyyq3g2xsGd3NcU/gDvs=@vger.kernel.org, AJvYcCUcCuR6R/j7HrXj6+YHIzBfSqZCZvl8tEi67nb+Y8chxOu82Ui8rjX28g2/ebhEnu0BCSTQ0G/lMH7q@vger.kernel.org, AJvYcCVUAMGJ2SfzLN3O3ulqY6R/Ct1DlTT70djIFCC49Cidtay6+RovglSOm6k4ZpiqN247AtMxO90CTvqBiiBp@vger.kernel.org, AJvYcCWDMN4QN5ldUzsc3PfUMmIbCM0sTsNSltkVrLPfdKDP5/ZxnVwxu18D9amXzevzN1/6PksvsfIAzBUI@vger.kernel.org, AJvYcCWYZYgBsb3H2yBb4XVr5yI8MSCYKy1L+iZevLY60Bcu5Mih/pUjsX9SrZF1vgG9ASlaTfTm20EGwx7Z9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVoziZy/1IqhxRGKqacB03P4ryiqdaxezxV+2xLDHq4fKsr67
	C4EhyBwch1lbTSfpalEDVQjz7/qve4wPQiXr1B66HpwZOs4sl4iV
X-Gm-Gg: ASbGnctxeBkjqcd0y3mG8KebVhINXqhQ51195KxArdOUhu2yKiypMVOij8CgmOR5PtO
	qjRkpT1vWGchZEB5YLDJuzyXyqXOM5AzdOt4qLu8vAWono4K5632Vx4TYgFiWWhiI3Y5iDLl9mc
	BWVdLgcZE6+2HAho9uIT9QxuHTl80dGne43HXOSgbwAz49c7KLW2/8xy5kMC5IXsrj2ZwjKGuRz
	b0MYMp5b2AbQa+fQ9uFBahTd1zyxq4186knfTV0CpoZxO4eaBx4EUV0iYvcctMTcs0cL/9US0ny
	vSxT/q2VXOHkfcWA3By/+TTrQLRsBoDKAvoIoX3Qdv8ximofdCAZJP1AYn+rMJU3Ov0uVvyFtsA
	A7ezXbtIfrOQ1TRbr5K6CXZCOdA==
X-Google-Smtp-Source: AGHT+IEucaK4C0/jG/28ToSGCMqDTpO1LwC3UB+LxRq0hxN98edyDZiBux7h98Elv5EsCRuxmORCqg==
X-Received: by 2002:a05:651c:1545:b0:30b:8faa:9544 with SMTP id 38308e7fff4ca-30b9320c44amr33012291fa.7.1740920810359;
        Sun, 02 Mar 2025 05:06:50 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30b8dbd1ad9sm9547021fa.76.2025.03.02.05.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 05:06:48 -0800 (PST)
Message-ID: <45c0bf5a-f821-498e-8a9c-99e53bba5307@gmail.com>
Date: Sun, 2 Mar 2025 15:06:46 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] iio: adc: rzg2l_adc: Use adc-helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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
 <5658fbdd886cc7ada278a42c63a140bc14d1277d.1740421248.git.mazziesaccount@gmail.com>
 <20250302034042.59d83f53@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250302034042.59d83f53@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 05:40, Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 20:33:29 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The new devm_iio_adc_device_alloc_chaninfo() -helper is intended to help
>> drivers avoid open-coding the for_each_node -loop for getting the
>> channel IDs. The helper provides standard way to detect the ADC channel
>> nodes (by the node name), and a standard way to convert the "reg",
>> "diff-channels", "single-channel" and the "common-mode-channel" to
>> channel identification numbers used in the struct iio_chan_spec.
> 
> Needs an update to reflecting naming and functionality simplifications.

Thanks! I should've noticed this. I'll re-read and alter all the commits 
for the v5.

> 
>> Furthermore, the helper checks the ID is in range of 0 ... num-channels.
>>
>> The original driver treated all found child nodes as channel nodes. The
>> new helper requires channel nodes to be named channel[@N]. This should
>> help avoid problems with devices which may contain also other but ADC
>> child nodes. Quick grep from arch/* with the rzg2l_adc's compatible
>> string didn't reveal any in-tree .dts with channel nodes named
>> othervice. Also, same grep shows all the .dts seem to have channel IDs
> otherwise
> 
> (othervice does sound cool though ;)

Thanks :D For some reason I always have difficulties spelling it!

...

>> I picked the rzg2l_adc in this series because it has a straightforward
>> approach for populating the struct iio_chan_spec. Only other member
>> in the stuct besides the .channel, which can't use a 'template' -data,
>> is the .datasheet_name. This makes the rzg2l_adc well suited for example
>> user of this new helper. I hope this patch helps to evaluate whether these
>> helpers are worth the hassle.
> This doesn't seem to match driver. It is messing with channel type.

Ah. Yes. It was simple until I rebased to never version. I'll change 
this. Thanks!

Yours,
	-- Matti

