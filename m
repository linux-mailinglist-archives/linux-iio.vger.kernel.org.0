Return-Path: <linux-iio+bounces-14500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC2A16E2B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 15:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4433A4815
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5EF1E2844;
	Mon, 20 Jan 2025 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Kug8KMqp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA81E0DE6
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382320; cv=none; b=KUn9vrjoQk8XT3A2U5I97LAO1050dk2hXYKYOfHEms6fCCfkqNjqOoegQT+6fAa7w3IkG0JG7PA8NbC9WrERjZ8eTwFkR6Km7Ca/zp5Jt06ksoG6UjPHLnyFDK+yC89k9rleoSUjinFRsWMrUIuuY1AaeJ5CT0mdijaTrUVp7YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382320; c=relaxed/simple;
	bh=YAuffjJ/hOF4tWtkCBthiKjc7h46t4U8Y7L5WfbatGI=;
	h=From:References:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHAZzx3ZSkk+Bt28lQ0AqE7pkTWAu459AvGi/06PpBJl4nHhGBI6wxHXNP8ypw8WIcR/Bkwrcno4l+f4ahUsb0rnX/r+avsqRtq8qObdZasrB+9WuNFmM+uoGGcA6Y8F9T1+kx9s5UGs2G4D7KLT9hqhw5YrPqCG8LwlrphWSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Kug8KMqp; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1295028fac.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737382317; x=1737987117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lBJHX/leRySwogU3LLXcsMAyho9zlRkLcfDGwEAvoMo=;
        b=Kug8KMqpvdoHzdF/9FocFoPQ7ktuDlQFoQ0ObXfeOHNT6UJBGjlOT3g9VcW/LoF4pT
         9kgcK0CGZnk+5OMOLcUzyFSfjTFNIOW9uBehPU/3nm3YpUuuc7PSf1B0A81nI/lv+Au2
         jrDSL7I+7DrZzm61h20ImidQy+jKQpf0JqrGhNbyNhvdAUIq4TqDOry/Lj3fOEMOtSo7
         MxKjD/CbpT7vTlq8Emo5U0UVHSsU0yz90HhfvQ5sOa+adchqO+qklpwDF4W0sJ2sjsAa
         V5adbFqrrh1IskKvCGaUoPDYctMQbNCLms5qAtgXZY5vUahbgHJUfTDZJF4BN/R6NlJO
         xY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382317; x=1737987117;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBJHX/leRySwogU3LLXcsMAyho9zlRkLcfDGwEAvoMo=;
        b=laDVQY5tZNFzFGB/kYdZRLoo5RDjc1lJiVWIM1mS8tDPVG+n6MG0PKKPQvSx33kWSj
         0kSEzn+qRNXCoj4p+Mq+4F41ROpdNbJKhWCDmNSkVbeYLMIqSq5mF+wJSpfSwiU/GELi
         d6gEbxfbv783bKxCREbrckPCfCaubfIPqPq5OvnYWdN6KGPJO9cZsm753JIEXTIhLPZW
         ga1C2Nak/kQLZW1JeMbd6QpLbwn9ZegR+s8Bag8x9QZ0IAlXkwXTRDuA41yHeHEu4K/U
         2My0JFqLgGQ0hdHWnpWQIBg1TaiUEtnLsFbuHyIWDW7cSheVLWzTtb1vfY/s2LZGhHIK
         zdNQ==
X-Gm-Message-State: AOJu0YwCexpnXons5qBXB9/iRtleIgj6vxHKTaEXgkUHNEPOuTVsp7/Y
	8o58phW/r+l4cE/MeRdmO56DPn+BWxgEGn2/c05S1+k90ud7k+Hop2gSDTq+4ug9n2Xqudq9sWC
	In5a1dMpKl4gF24A0pGZFz682FP87kgFQSo0p+76C0V1fpukH
X-Gm-Gg: ASbGncs1gCVd8+FHbx7DH8fdDXvJq9vLl7prB4F1N4rmHVLIQ29riLSZRohYY47FVZY
	O0IDO2JYxtSNrJzknzg3V7DQ0l02Wl4Qog280JmenxLlqeN/nwA==
X-Google-Smtp-Source: AGHT+IFEaN/jIStERVW9M7MqjWWQmEG7EGXJjwG/0jHGRfV3YLI14NXWSvnS/+3IVRcAneOQV9Jpe7BKqXrsIBisxVE=
X-Received: by 2002:a05:6871:7b81:b0:296:e481:8b4d with SMTP id
 586e51a60fabf-2b1c0c541f4mr7256165fac.28.1737382317489; Mon, 20 Jan 2025
 06:11:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 09:11:56 -0500
From: Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.8.10
References: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
 <20250116-ad4111_openwire-v3-2-ea9ebf29bd1d@baylibre.com> <658b7ff2-7019-4a7e-bd0a-58467032978a@baylibre.com>
In-Reply-To: <658b7ff2-7019-4a7e-bd0a-58467032978a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 09:11:56 -0500
X-Gm-Features: AbW1kvbwkCGwWjx6RdJLj1yv68xqbIyEtUTAFNxUfzfMJaUDlVxd4N1gm5rs2CU
Message-ID: <CABnWg9s3G9sWs+2gOJ_-g2ys-EKuL6OoZHg6EAQOTkMRx+2-hA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] iio: adc: ad7173: add openwire detection
 support for single conversions
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Jan 2025 18:25, David Lechner <dlechner@baylibre.com> wrote:
>On 1/16/25 9:01 AM, Guillaume Ranquet wrote:
>> Some chips of the ad7173 family supports open wire detection.
>>
>> Generate a level fault event whenever an external source is disconnected
>> from the system input on single conversions.
>>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>
>...
>
>> @@ -1375,6 +1523,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  		chan_st_priv->cfg.bipolar = false;
>>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>>  		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>> +		chan_st_priv->cfg.openwire_comp_chan = -1;
>
>		^
>
>>  		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>>  		if (st->info->data_reg_only_16bit)
>>  			chan_arr[chan_index].scan_type = ad4113_scan_type;
>> @@ -1442,6 +1591,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>>  		chan_st_priv->chan_reg = chan_index;
>>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>>  		chan_st_priv->cfg.odr = 0;
>> +		chan_st_priv->cfg.openwire_comp_chan = -1;
>
>		^
>
>Looks like the same line added twice in the same function.

Indeed, but the first one is for the temperature channel which the
parse_channel_config function handles separately than the rests of the
input that are into the `device_for_each_child_node_scoped()`

Thx,
Guillaume.
>
>>
>>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
>>  		if (chan_st_priv->cfg.bipolar)

