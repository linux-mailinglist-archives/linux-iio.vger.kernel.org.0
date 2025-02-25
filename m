Return-Path: <linux-iio+bounces-16070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9FFA44E7B
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 22:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB52165849
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2025 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6324E20E6F0;
	Tue, 25 Feb 2025 21:13:02 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C37B1A2392;
	Tue, 25 Feb 2025 21:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517982; cv=none; b=A58dLhdj2R1Wyc+ZOdRhUtPAELkIKQuzxXFDKu1htofSsIgtZi5tL6ZRVSn2HZOYq+MP1FTDQRcdZp2gIz6+Sb+r7ALLC1d6t8DagsAmmFlGgfLxXwY8US8FZl6Y9v7xMetnZ5V2D+UG+XQ43u6n44S63ys2Nu/qvDW9XgwWNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517982; c=relaxed/simple;
	bh=sVVkhpICspFxR0YyUJyrPKfBpCWrQ+yeJh0RhrguVTs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jCjL03IiZt8pkajUMv3k+FhTz3dfcgdnp3AWybS/r3GbbNWL/ils6zYr3ExKKasf6jrowl0RS3MS1MSySjzWD+7J8ytxn0zNOCdqJ3KepKVFfC/oZH4lfztfXGQ87kn4DgPn8tZve5ogP6V5QdvIM4/1yiQ00Ibu1VQ/ysx4vXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af513.dynamic.kabel-deutschland.de [95.90.245.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9487361E646F9;
	Tue, 25 Feb 2025 22:11:55 +0100 (CET)
Message-ID: <a4066857-01e7-4172-b141-4c5f8bb3540b@molgen.mpg.de>
Date: Tue, 25 Feb 2025 22:11:54 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v4 2/2] iio: adc: add support for Nuvoton NCT7201
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 javier.carrasco.cruz@gmail.com, andriy.shevchenko@linux.intel.com,
 gstols@baylibre.com, olivier.moysan@foss.st.com, mitrutzceclan@gmail.com,
 tgamblin@baylibre.com, matteomartelli3@gmail.com,
 marcelo.schmitt@analog.com, alisadariana@gmail.com,
 joao.goncalves@toradex.com, thomas.bonnefille@bootlin.com,
 ramona.nechita@analog.com, herve.codina@bootlin.com,
 chanh@os.amperecomputing.com, kwliu@nuvoton.com, yhyang2@nuvoton.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
 <20250221090918.1487689-3-j2anfernee@gmail.com>
Content-Language: en-US
In-Reply-To: <20250221090918.1487689-3-j2anfernee@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Eason,


Thank you for your patch.

Am 21.02.25 um 10:09 schrieb Eason Yang:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for

… and all the threshold values …

> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.

… are supported.

It’d be great if you added a datasheet name and revision, and, if 
publicly available, a URL.

> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
> ---
>   MAINTAINERS               |   1 +
>   drivers/iio/adc/Kconfig   |  11 +
>   drivers/iio/adc/Makefile  |   1 +
>   drivers/iio/adc/nct7201.c | 487 ++++++++++++++++++++++++++++++++++++++
>   4 files changed, 500 insertions(+)
>   create mode 100644 drivers/iio/adc/nct7201.c

[…]


Kind regards,

Paul

