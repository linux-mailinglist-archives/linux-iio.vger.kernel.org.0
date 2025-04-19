Return-Path: <linux-iio+bounces-18344-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8AFA944F6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 20:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23247A63B4
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A81E0DCB;
	Sat, 19 Apr 2025 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KhtZkQ5E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A991632DF
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 18:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745085855; cv=none; b=tNInFWaQ1Erkh4tr1Pv/42R1lv8aJD1JRzEDlGsFvsQ4aNcdIe4uBL5X1/8eljQuHLa8cpHxhCvv4iU5zehxXq4oEckaTozOEorg6D7MOitaRVxPaUpwBiv+8I7q//Lk8/fji8ZZZw+ythtslQbVjpLNwM6T5o9l+HlCcrm/xlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745085855; c=relaxed/simple;
	bh=ouOyKoeAngMKojKw8UEXMPbxMa5tsF/a4TIHmRZx0UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbaiCSPrxoT913QU3PjDc2oaQTnIwfK0xfVbEpTvkYh6jvuSZ6HFqGNW3Zy7l8nlB4DPBRwBHsRuP/nJf1TQpVj+lwZZpP0hg9vChZR4L08Yxl8DZ66Ox3PhecvPtuHkIE2GCL3IbqF4+nI/v7xodH1gdotxdV50WSWn/h1qqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KhtZkQ5E; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-604ad0347f5so656509eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 11:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745085851; x=1745690651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnOvqQvY0JTPnC6ngZ5WgpMNFi7FR1LXeifwqpVfw6s=;
        b=KhtZkQ5E38rvRJpRul0zJKUiaKjDrxkNFY2vELP3L2AMoBt4PD4L//kv2jnMw1CeIQ
         RMVkFvG0LpnVQg+Vc66h3TNZSKKCM534Z/Q6iZgsam2b8xh9yR6kotYhxShoi2TlRbRl
         VwxdGfz8+4l7+igOL7Wgbw22usRuFRN1lss1ciDTE6hcw4jo0LQ9Pg4hCcGciTACasg3
         lSAHvphDerJ3zPsRXcGtP5fSZcs8Pex+eLTwRhcQLZ24u93MSXaVrkq+cGr44HsD9Vxq
         RmTwj4ie0vR8gMMgJPSedItouhRyYvxqMxoCw/lTOye8stDEaANejSI3I6l5MvL7FsaJ
         iXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745085851; x=1745690651;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnOvqQvY0JTPnC6ngZ5WgpMNFi7FR1LXeifwqpVfw6s=;
        b=ne9m/ZhV60HoCvmA3LpfKOMwbj8dn6VZZdPRMTXdxy5FfeDHDBUUKFLTJ0uacfXTrF
         J5+gNIBlKFzi5gVlK6U1KMxLAcOC2JmhLHVRCCFM7023BnpjkJgAOmiuFm8grmXNk9Ed
         nT4KLXn+0h3Wu/9h6vmKNhycSb+ldsSbtEKPp7s27iKirIUz+AetHysl6RMXCOQmpnmj
         IQr+Tm8XYIUBP7SpBHHYAv5tAIjUSzi3JqU23CZBeWvidBIRutxLmfUhEr6BtNpRSB5a
         Fk7dEl99pORe1ojl9YNblpx7e3jV36i1UjybdvQUM8+Bj5dW7heDVp/LFVJVodshS0pi
         P/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2eEOFZMn3Ro9glrsNfZbucg1tHG22pvIF6kChvq8EfipvOHgGV0qzXexzhYQNFn/mgbx8F8lpiJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRJALaiPwsDj3+oV2ufnDvP7qXkshOgjy0OHdpdNxLNcy46Vc7
	vs1r6zYJJ7T+NXMYALcuHFUwh3jFO4nOL2+6tlB8cW8OalTqvBJQj1W9i6aZtR0=
X-Gm-Gg: ASbGnctZ+/cXkEspBzOG3lSOa1fJdA2MXJ+s+f6nffGWyAinm5O8sRdUsfrbqJqE5BE
	MA+Ho45LOFeW2VgRFRk7FAjio1049IWp++LDWUI+yNfbcf6cP80512r/xASDb26fmQnBzFzyhXk
	IfJDmHI98RIZEPO5ROyScEljk2ohqNCCI8qsfvtgUL0ElnLsuaDEsj595IL1Vn6hixo8vA6tkNe
	SVF1A539uNkKfCIjxxpnpAbZZk5mLAdOjAzXF2SMHw9eyh/vhXH+hSOWlcc+3UwGE4G6hYtxGuC
	XfiG/JWAtRw/ucL2UReYvJHAQkFKov6tp8Ep14jOcP/I5b11j3SzeDBFqzlaVPrssqcPczaqNRC
	B1rCovrH14ic7
X-Google-Smtp-Source: AGHT+IF3acsObqd4J9HjsEc4P7l1hAE8P9A417ZJtaywx9v5lIYAACZt1S0qi8YyVFXmTZdKQHf1gQ==
X-Received: by 2002:a05:6871:500a:b0:2c2:4f6f:5b59 with SMTP id 586e51a60fabf-2d52681d477mr3307005fac.2.1745085851027;
        Sat, 19 Apr 2025 11:04:11 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:79a:b8ae:edee:ec5? ([2600:8803:e7e4:1d00:79a:b8ae:edee:ec5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d52136181fsm1046907fac.19.2025.04.19.11.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Apr 2025 11:04:09 -0700 (PDT)
Message-ID: <9cdb05b5-299c-472f-a582-13a7d1368f3b@baylibre.com>
Date: Sat, 19 Apr 2025 13:04:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] iio: pressure: bmp280: use IIO_DECLARE_BUFFER_WITH_TS
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
 <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-4-ee0c62a33a0f@baylibre.com>
 <aAPRuUZTWQZr9Y6H@smile.fi.intel.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <aAPRuUZTWQZr9Y6H@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/25 11:39 AM, Andy Shevchenko wrote:
> On Fri, Apr 18, 2025 at 05:58:35PM -0500, David Lechner wrote:
>> Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
>> iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
>> and understand.
>>
>> The data type is changed so that we can drop the casts when the buffer
>> is used.
> 
> This one is good, with the comment to have it DMA aligned.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 

Strictly speaking, this one doesn't need to be DMA-safe. This buffer isn't
passed to SPI or any other bus. It is just used for iio_push_to_buffers_with_ts()
and has data copied to it from elsewhere just before that.

