Return-Path: <linux-iio+bounces-14130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E13A0A3B8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 14:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678A37A40B8
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8051A4AAA;
	Sat, 11 Jan 2025 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYg6hcIf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AB192D98;
	Sat, 11 Jan 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736600407; cv=none; b=MbfO1leRWDlaDDBSOX2l4HgGJDEBHAoCJnkldRblJQ3eew73MtwaVD1m2CBzPJIoFM8Bov/vRZh92Yh9asdjEDxzvUyS8mwgnkK18SJuHBO1dp95fy5k5xhl+xqluLDyrkYuooS+uX1vBud+Y78UeLR66G3JzDTDONIFBrz9ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736600407; c=relaxed/simple;
	bh=uhgW4pxNgqADt4AOUceOlVdwTIimyMAZeZHRtYxpCn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hglHyhh+ckM0TTVta3lY8yUiSEjlRgvDzJTvsO1iFERisSuKQzw5LmE+Fa5XN5pZgvU+G6rLKzgnEse8RSGeAJA+brSpfXnarU5OfP8q4FzydF9vRfTASN8OBcJzZKgVWMcZWrpxYieSwRTuzAheuCwi2Xpiu3ds9RmIhr1W/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYg6hcIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A6AC4CED2;
	Sat, 11 Jan 2025 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736600406;
	bh=uhgW4pxNgqADt4AOUceOlVdwTIimyMAZeZHRtYxpCn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iYg6hcIfg859hA4bX6k87XTbZGz6aE6v02J9QgJ9kmL3+VzEyw/SNqMjDAt1sy0mC
	 4H9OKuQ0bJAo0luuL1tYbqm3AFFZpXH6AMmjK+0iIUVlOn94kulTTv3wxvdlcS/HDT
	 GYQ+6hVx3nEYzdH/PgB7VyQBE7BTnQw0nuIORItNaVM3nWl2BUGTXE+3qM39qlCUDs
	 bG+jRr6y2EswYHy8omqLrNrQukRDYVsKLZ3mOHnoXnY+yCoBs2far2nYjKzxtvG7be
	 8sz0eWnsAk3lGvNvKdO0liAy7o/W+EDM/E0QIZgAiOZr1Nv11ah8VWMIrU74JyFV3l
	 sVMc32sPA0huA==
Date: Sat, 11 Jan 2025 12:59:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <Nayabbasha.Sayed@microchip.com>
Cc: <devnull+nayabbasha.sayed.microchip.com@kernel.org>,
 <eugen.hristev@linaro.org>, <lars@metafoo.de>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value
Message-ID: <20250111125958.34d2ebdf@jic23-huawei>
In-Reply-To: <fc0547bb-4563-4a76-90df-88ec57407360@microchip.com>
References: <20250103-fix-sama7g5-adc-realbits-v1-1-1732d265c36a@microchip.com>
	<20250104133804.2a3c2ba3@jic23-huawei>
	<2bc88c08-c594-4f76-9873-ca7ca488ea0c@microchip.com>
	<fc0547bb-4563-4a76-90df-88ec57407360@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 05:49:09 +0000
<Nayabbasha.Sayed@microchip.com> wrote:

> On 07/01/25 11:13, Nayabbasha.Sayed@microchip.com wrote:
> > On 04/01/25 19:08, Jonathan Cameron wrote:  
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Fri, 03 Jan 2025 16:50:40 +0530
> >> Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org> wrote:
> >>  
> >>> From: Nayab Sayed <nayabbasha.sayed@microchip.com>
> >>>
> >>> The number of valid bits in SAMA7G5 ADC channel data register are 16.
> >>> Hence changing the realbits value to 16
> >>>
> >>> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>  
> >> Please send an appropriate fixes tag so we know how far to backport.
> >> In reply to this mail is fine (no need to send a v2 for that)  
> > Fixes: 840bf6cb983f: ("iio: adc: at91-sama5d2_adc: add support for
> > sama7g5 device")  
> 
> Small correction:
> 
> Fixes: 840bf6cb983f (iio: adc: at91-sama5d2_adc: add support for sama7g5 
> device)
> 
> Thanks,
> Nayab

Hi Nayab

check Documentation/process/submitting-patches.rst again.
Neither format is correct.

Given the multiple entrees sent mean I can't pick this up automatically with b4,
please send a v2 with the correctly formatted fixed tag.

Thanks,

Jonathan

> 
> >
> > Thanks,
> > Nayab
> >  
> >> Thanks,
> >>
> >> Jonathan
> >>  
> >>> ---
> >>>    drivers/iio/adc/at91-sama5d2_adc.c | 68 ++++++++++++++++++++++----------------
> >>>    1 file changed, 40 insertions(+), 28 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> index 8e5aaf15a921..c3a1dea2aa82 100644
> >>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >>> @@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
> >>>    #define AT91_HWFIFO_MAX_SIZE_STR     "128"
> >>>    #define AT91_HWFIFO_MAX_SIZE         128
> >>>
> >>> -#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)                   \
> >>> +#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)                       \
> >>>         {                                                               \
> >>>                 .type = IIO_VOLTAGE,                                    \
> >>>                 .channel = num,                                         \
> >>> @@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
> >>>                 .scan_index = index,                                    \
> >>>                 .scan_type = {                                          \
> >>>                         .sign = 'u',                                    \
> >>> -                     .realbits = 14,                                 \
> >>> +                     .realbits = rbits,                              \
> >>>                         .storagebits = 16,                              \
> >>>                 },                                                      \
> >>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> >>> @@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
> >>>                 .indexed = 1,                                           \
> >>>         }
> >>>
> >>> -#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)                       \
> >>> +#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)                   \
> >>> +     AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
> >>> +
> >>> +#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)                   \
> >>> +     AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
> >>> +
> >>> +#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)           \
> >>>         {                                                               \
> >>>                 .type = IIO_VOLTAGE,                                    \
> >>>                 .differential = 1,                                      \
> >>> @@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
> >>>                 .scan_index = index,                                    \
> >>>                 .scan_type = {                                          \
> >>>                         .sign = 's',                                    \
> >>> -                     .realbits = 14,                                 \
> >>> +                     .realbits = rbits,                              \
> >>>                         .storagebits = 16,                              \
> >>>                 },                                                      \
> >>>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
> >>> @@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
> >>>                 .indexed = 1,                                           \
> >>>         }
> >>>
> >>> +#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)                       \
> >>> +     AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
> >>> +
> >>> +#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)                       \
> >>> +     AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
> >>> +
> >>>    #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)                              \
> >>>         {                                                               \
> >>>                 .type = IIO_POSITIONRELATIVE,                           \
> >>> @@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
> >>>    };
> >>>
> >>>    static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
> >>> -     AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
> >>> -     AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
> >>> +     AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
> >>> +     AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
> >>>         IIO_CHAN_SOFT_TIMESTAMP(24),
> >>>         AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
> >>>    };
> >>>
> >>> ---
> >>> base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
> >>> change-id: 20250103-fix-sama7g5-adc-realbits-37f62f8925d7
> >>>
> >>> Best regards,  
> >  
> 


