Return-Path: <linux-iio+bounces-2576-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA15C855E54
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F8F2819E2
	for <lists+linux-iio@lfdr.de>; Thu, 15 Feb 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FF71773A;
	Thu, 15 Feb 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXHz6/S8"
X-Original-To: linux-iio@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAF1BF31
	for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989829; cv=none; b=GC/CaZx25RNLPQTnVudl+H37RRClM9cQiS4jhRpam9ekFO2UOwGjLbGATGcCO7MK7AIkZGkODjSgTRao2tKuRFFVuF5Vmlf4kDA8Z39/c6u8unazqCXCQTRXAcV0VDy3F43W3oX5Lds5kQe2rnrPxutRHWZy/9WHtP/9lqaGmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989829; c=relaxed/simple;
	bh=9I63gROhjngNIeQPdNdM/zV6l5wz5ce7XJJvGYWcq/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7LDrYk3BWrwiUURy8BDo+JDK7R2CJAxraBtYDb3tyiAuf1Y777X8+hZnKp+HcJL4lO/EdE/yDKpCo9a2T/Ki3EoJOxQZuBqyOx2Y6ijoqvd5ZOUrErpsfwAli8n+rNIQ1P0N2bGIsAF2PzZhWzVUVp435YDMR0PnE0G6m+dW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXHz6/S8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707989826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBRLiL+HuGDeDQERSo2kb5PIsu6pFh1p74ggrJ+XVgc=;
	b=DXHz6/S8Q+j0KkWhWfnoyOoYibV6F4hgG7fqIq3QJPmCUsOYYZYJtc6QXAg/UhpFiGcZ3m
	PnXDAkIqSq/S4/GFKqZV1VNCrbtOyj0BUCt/YjiMO9MFMzeJyejnda8sGFMU28kgTjTkRJ
	68QSrbPTFyImSSE/YlXoPvKFe9up/U4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-9gbQJ34HM-er_0FK1XfShQ-1; Thu, 15 Feb 2024 04:37:05 -0500
X-MC-Unique: 9gbQJ34HM-er_0FK1XfShQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5620a2d150fso283692a12.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Feb 2024 01:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989824; x=1708594624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBRLiL+HuGDeDQERSo2kb5PIsu6pFh1p74ggrJ+XVgc=;
        b=adb/Jx40C0ySiyGLdS31tOg6S2U8a9GjKjn+yhv0E+RAd/YsbDZ8Vko/UBS8gODKwE
         pf5VLNfr3qauTABiWBel4FUDHbpYdXAE2Kg/MfyF2+RetfXWCn3DgMavYV8/XEOQ1NS1
         JKmd5qybShp5qtUxIyYI5NnliKqKRXa0wJEj61V2ElWU7tdXP4LvLnog1sS5UZeAzXay
         yOiWhtL8lqvb0HkvTqtz5qUX3U9XNo4KDlWrDBc+A9KEjhs9oa0YJxx/9kjrzPHEMKLR
         gXgHVSmFUJvfP9PlAfJxq15e/09NBwuCM+Ch6oGLrycBmEufmnKF/mpCDK9ErYTe7ARw
         Q5bg==
X-Gm-Message-State: AOJu0YzhNNUJSQahotIGwJF68ncp1Xs9uMEVIvu/FyCrV9jAUkj7il7j
	I/T9NhlksYid/HgYJmHZlju606P841HkqzLId4amV9Ul4Dp/lx6deGC1+RxySbDZX94ALF1qCcw
	P5b1YiL1zZzUbO9jT1P6FQC2eOnGZLaHCwzu1fr191iHJ0nR32SDs4cMJWA==
X-Received: by 2002:aa7:c359:0:b0:560:d9d5:7b0f with SMTP id j25-20020aa7c359000000b00560d9d57b0fmr787699edr.22.1707989823960;
        Thu, 15 Feb 2024 01:37:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjnkuRWcrrNGcF3UGMDvum+hC8hm8IMTuXBBdWcFGKBYScf7Khk3P8sHuIGLXoxaGmhjGtiw==
X-Received: by 2002:aa7:c359:0:b0:560:d9d5:7b0f with SMTP id j25-20020aa7c359000000b00560d9d57b0fmr787675edr.22.1707989823592;
        Thu, 15 Feb 2024 01:37:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id y18-20020a056402441200b0056368be8a58sm370499eda.27.2024.02.15.01.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:37:03 -0800 (PST)
Message-ID: <62861b98-14fa-4f44-b6a1-ac5fd079d66f@redhat.com>
Date: Thu, 15 Feb 2024 10:37:01 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] iio: accel: bmc150: Duplicate ACPI entries
To: Jonathan LoBue <jlobue10@gmail.com>, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
 ilpo.jarvinen@linux.intel.com, jagathjog1996@gmail.com, luke@ljones.dev,
 benato.denis96@gmail.com, lkml@antheas.dev, derekjohn.clark@gmail.com
References: <4563303.LvFx2qVVIh@nobara-ally-pc>
 <20240214225956.25731-1-jlobue10@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240214225956.25731-1-jlobue10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/14/24 23:59, Jonathan LoBue wrote:
> This patch adds a description of the duplicate ACPI identifier issue
> between devices using bmc150 and bmi323.
> 
> With the remarks below,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
> index ee1ba134ad42..df7d48a35e41 100644
> --- a/drivers/iio/accel/bmc150-accel-i2c.c
> +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> @@ -15,6 +15,19 @@
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
> +	/*
> + 	 * The "BOSC0200" identifier used here is not unique to devices using
> + 	 * bmc150. The same "BOSC0200" identifier is found in the ACPI tables of
> + 	 * the ASUS ROG ALLY and Ayaneo AIR Plus which both use a Bosch BMI323
> + 	 * chip. This creates a conflict with duplicate ACPI identifiers which
> + 	 * multiple drivers want to use. Fortunately, when the bmc150 driver
> + 	 * starts to load on the ASUS ROG ALLY, the chip ID check portion fails
> + 	 * (correctly) because the chip IDs received (via i2c) are unique between
> + 	 * bmc150 and bmi323 and a dmesg output similar to this:
> + 	 * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be seen.
> + 	 * This allows the bmi323 driver to take over for ASUS ROG ALLY, and
> + 	 * other devices using the bmi323 chip.
> + 	 */
>  	{"BOSC0200"},
>  	{"DUAL250E"},
>  	{ }

Sorry for not noticing this sooner:

The BOSC0200 ACPI id is listed twice in this file.

The listing you are adding the comment to is for ACPI ids which are known
to be used in yoga-style (360° hinges) 2-in-1s which may have 2 accelerometers
1 in the bottom/keyboard half and 1 in the display half.

The bmc150_acpi_dual_accel_ids list indicates that this might be the case
and enables some extra code for this.

The actual listing of ACPI ids used to determine if the driver should
bind is the bmc150_accel_acpi_match[] list lower in the file and IMHO
that is the list where this comment should go.

Regards,

Hans





