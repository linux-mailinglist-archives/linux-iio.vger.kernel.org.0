Return-Path: <linux-iio+bounces-5701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8F8D8772
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90121289648
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D94313699A;
	Mon,  3 Jun 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHi/e0Oc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCE4A0A;
	Mon,  3 Jun 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717433352; cv=none; b=nA3lQRCJxXNSPZC/7EAfMGYwFS550GSzVMnFNEj7dMwssP+gPLR7FLul4/GgKwWzMzGy3CTzTYoG/d5UBLE9xtBs8LdzYXD5QY0C5dXAVRvpvZ9uk22ix1VQJ7FUZ/Tqn1Jsx9hj8YGjqeL2f4V6c2+3f6Y+WvUUf3LGj7KYYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717433352; c=relaxed/simple;
	bh=c33fDiWFJQT75vUwqaalvIU2B7A6fRgsEaexBd0OkSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNnzL7n6PAY3ohJhFqPuIKcj5FOiljQBQCB5yovHE32/SsLaERAMsc9UUt83aakSMZRTwogVcQOMOl7ek9fZKRf6vaDSxBW2U7xDSG8RGZ56wc58zFP8rbUwSZ5r9cux6tBUIpzJAK52wn4uLJkarH10ZbQFZ8ZZqzLAAgFPa3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHi/e0Oc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so4369515e9.1;
        Mon, 03 Jun 2024 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717433349; x=1718038149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9yNx7cmxLPe/b/+oaDWP8CtyOBubgZufBr1kEUxuYY=;
        b=WHi/e0OcUZYDm7y/yPssBqjWj4KOMq3GM319NKMWqkQ83+Hks/dSSlrUIOIkLN2DGF
         TnOdKGp8Sqj1pWZYESC39OhPDo9AWxyfHnKDlGkNTZH1z4Eu5mSOhn1ngswflh7XD60k
         SjVbW6liBrDLiWSKKPbhP5uNpvZqnHnSXL9F2jaL7CWvrReoR5PXqncvO6Os7N70Re/8
         2b8BY+fPHgaKvTIAgjeT4CemqDM4XHwd8cd/h2Hc9JZTOKMxMrsMXzqsZFAbY8cgikIg
         9BGN/vpmWXYugEvbPiTMzQxK0olVqqWfXtzv84gISaKLwr9qhXVpfz6kluGWnKIyXwL+
         bMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717433349; x=1718038149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9yNx7cmxLPe/b/+oaDWP8CtyOBubgZufBr1kEUxuYY=;
        b=EhX4U3SK+/ZaCes1r2h65lkTffzDzzcytsTyO2e0tODko6cCyqHHXKdov+M3YvHfoL
         7e4F1Y3ZHvWdKeJXvZYNosPVkVr3Ib6fVC1t22w2bz0eQK/MdRyNcmqXRqHHzxlBswtt
         MphsgGnv54yNkNdbWWzQEUbM9UDpUpPnXDKsa0nRHPgUEQYmUAQpZnmpPEI/3VNo9XJw
         mbLqg5SeP3C60lpaepADPMMYVHSnU/9BLNn/2IEnIbN0cV8sNRE6SWXSwNoGvnkzdtjb
         p0MYZZOWrVv1cj5Cj0euie2ttCp31HlN3GN+GFqaJtcmMvgiOjabXnRzTEmS7PgyVh/V
         rDCA==
X-Forwarded-Encrypted: i=1; AJvYcCVqzJ0Gu9BePz2fNsFI/CRAahRYYZrY6rkTmnDlTs4RmKITuVBFapYepDdPl3OO5BzkyUBRaBPiEvG33LoaeIGuSgiTSEikx/MwfADp29VjFgX+NjSTvPsvqH7+2PuGRlWYrrs+2w==
X-Gm-Message-State: AOJu0YzyzvAx/1Pp9TgW4yyOPNjIIEEZ6qbmxn0wSmZ31Qs0cc5+gnic
	NR+DbstZ8eyn/1wap5Wp+e6XQE7veNL19Ww7XH+qSdCrj5mN0OJvdu6aqg==
X-Google-Smtp-Source: AGHT+IF3VvEqdy5EfpNNHKvS//F8kPiFxL2leaLCAoXjeUi5YbkvMclGrXG3oC1gO16lp6r7MQFJdw==
X-Received: by 2002:a05:600c:3c99:b0:41f:cfe6:3648 with SMTP id 5b1f17b1804b1-4212e0453a3mr74001955e9.1.1717433348651;
        Mon, 03 Jun 2024 09:49:08 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42139688d82sm64537745e9.3.2024.06.03.09.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 09:49:08 -0700 (PDT)
Message-ID: <4c6d11d0-5e5e-4fef-b8dc-78f22bf14860@gmail.com>
Date: Mon, 3 Jun 2024 17:49:07 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
To: Mudit Sharma <muditsharma.info@gmail.com>, jic23@kernel.org,
 lars@metafoo.de, krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
 <20240603162122.165943-2-muditsharma.info@gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240603162122.165943-2-muditsharma.info@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 17:21, Mudit Sharma wrote:
> Add support for BH1745, which is an I2C colour sensor with red, green,
> blue and clear channels. It has a programmable active low interrupt pin.
> Interrupt occurs when the signal from the selected interrupt source
> channel crosses set interrupt threshold high or low level.
> 
> This driver includes device attributes to configure the following:
> - Interrupt pin latch: The interrupt pin can be configured to
>    be latched (until interrupt register (0x60) is read or initialized)
>    or update after each measurement.
> - Interrupt source: The colour channel that will cause the interrupt
>    when channel will cross the set threshold high or low level.
> 
> This driver also includes device attributes to present valid
> configuration options/values for:
> - Integration time
> - Interrupt colour source
> - Hardware gain
> 
> Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
> ---

LGTM,

Reviewed-by: Ivan Orlov <ivan.orlov0322@gmail.com>

-- 
Kind regards,
Ivan Orlov


