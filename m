Return-Path: <linux-iio+bounces-23513-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F130AB3D198
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCED3BED00
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FEF2522A7;
	Sun, 31 Aug 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCVHsTPL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82854C79
	for <linux-iio@vger.kernel.org>; Sun, 31 Aug 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631930; cv=none; b=UDf5r6y0mSSCkh6OxQ1KGrFykLKWMN3m340+Pbv2EHTVL80A9ascyECENcq7hkR+54YAY/rEqSujLwmDue81JexpZcqfXeM2PnvvewgkzDrEDnNsquJ1vRT7gHWlfzAl8qptbDJvUkVwS/iEbbvo3fJnZgahjRHizvJfo9FdKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631930; c=relaxed/simple;
	bh=zeP7v7PvH3I59PkjU+yEpd1kCf+EPT2yJwPUGhoEPt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suKv0uP1WyLNj+6PdpLPbLFle14f+nECQPGM1KuX+ep12dgr0GZ++UIVlM2/DfrovAnc+toKei6BMqmaH3L7R2Q+IVLt6+XSaA1qdP9HCgLzbDc/fA8WwsyPDCQ3PwPGFzuzhnthyDC4kp3WUQid9cHkYej4gyvUP0fxN4wDS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCVHsTPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250B1C4CEF5;
	Sun, 31 Aug 2025 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756631929;
	bh=zeP7v7PvH3I59PkjU+yEpd1kCf+EPT2yJwPUGhoEPt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cCVHsTPLmrSCzg3wPsDQVVJpYLFp13K0jo7PHmHGQL2Ly1gprLzFh4/FOXFo3TyHu
	 ehjL4QSUnuo92+jb7UIn4Bet/zdjdCu0JbwFiKpezvRUdIrKsYrjTfRU2AYCKMktQI
	 lhJjpueg31cu5byX4e181SPSJ0FxxCQRzhT4Nz7cVRG856gHCZ2m7w/B5nsc+5j1HD
	 x02UANcuv9Ve6i15+ZH5fgGMKD47/tvzjEXzO9McaJciR6U0XVqTBxlh/bcNGw+9oB
	 V1xU0I1K0fJMfT2uCe7o2JQV/OrOoLxHV1mdSKNT14oOtysHhM6yvS53sAsIEFnkv0
	 wFV20Vn9JjbqQ==
Message-ID: <ac53c02d-45d5-4ca8-9a2c-15a097e627a0@kernel.org>
Date: Sun, 31 Aug 2025 11:18:45 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
References: <20250811155453.31525-1-hansg@kernel.org>
 <20250811155453.31525-7-hansg@kernel.org>
 <CAHp75VcozYvcAbWZ6Yvudzu6jj39fNbGD-8T=F=v+6QxEGxiKA@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHp75VcozYvcAbWZ6Yvudzu6jj39fNbGD-8T=F=v+6QxEGxiKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 11-Aug-25 9:52 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 5:55 PM Hans de Goede <hansg@kernel.org> wrote:
>>
>> Intel has 2 completely different "Dollar Cove" PMICs for its Bay Trail /
>> Cherry Trail SoCs. One is made by X-Powers and is called the AXP288.
>> The AXP288's GPADC is already supported by the X-Powers AXP288 ADC driver.
>>
>> The other "Dollar Cove" PMIC is made by TI and does not have any clear TI
>> denomination, its MFD driver calls it the "Intel Dollar Cove TI PMIC".
>>
>> Add a driver for the Intel Dollar Cove TI PMIC's general purpose ADC,
>> binding to the "chtdc_ti_adc" MFD cell of the MFD driver.
>>
>> The "cht" in the cell name comes from Cherry Trail, but it turns out that
>> just like the AXP288 the Intel Dollar Cove TI PMIC is also used with both
>> Intel Bay Trail and Intel Cherry Trail SoCs, so this new ADC driver does
>> not include the cht part in its name.
>>
>> This is loosely based on kernel/drivers/iio/adc/iio_dc_ti_gpadc.c
>> from the Acer A1-840 Android kernel source-code archive named:
>> "App. Guide_Acer_20151221_A_A.zip"
>> which is distributed by Acer from the Acer A1-840 support page:
>> https://www.acer.com/us-en/support/product-support/A1-840/downloads

Thank you for the review. I've addressed all your remarks for v5.

...

>> +MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
> 
> Wondering if the address is still alive. In this case perhaps even ask
> for SoB/Co-developed-by? Otherwise if you still wish to have this
> credit make it in the form of "First Last (Intel)".

Good point, I asked about co-maintaining and got a bounce so I'll replace
this with "First Last (Intel)".

Regards,

Hans



