Return-Path: <linux-iio+bounces-12039-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328419C210A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 16:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCD3282191
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B921B430;
	Fri,  8 Nov 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU4FQOy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50B21A712;
	Fri,  8 Nov 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081006; cv=none; b=jBgWEGJtCV75YB49eQ767IjkFoe79ZZ5COlnTpudJViiyxHNkH3Nk8w9+25O/VdrfQQ7pXGRh0psG40IoMvJtIwe7cbFc8x6XJpVIZsygzS90KujEiyJ+EdQvAiJhddQz6CWy8o07qmcCbG3G3e9Brwm5JdtWt6HydUghXU/GCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081006; c=relaxed/simple;
	bh=e7TbtfYWPx/GzFrYLarzKUrUITFf+TcwL9eeIcRMtXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWZJT2SyLZ/XNa+o5QcFuljqyIfU4i5mhf8wDrj+1XBLSi5QYzrau4Aas5Yj8a3LHmZnguvsvUo+R5smKm/peqh+NwOVFn+c2p9n3K5s9m6YGfjKWc7H90zlgHlT/mYm8/CUbVg1s+I/aNv/bVcPsSnxEDAAYMhQkfhzwUTlb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU4FQOy0; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso1837121a91.0;
        Fri, 08 Nov 2024 07:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081004; x=1731685804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ+J0uCnaT+x0yIPYmMnG9zvQPdwpvJwn2l27mxNTv8=;
        b=FU4FQOy0wQ4n8A8gSepsBrjXyXPpN1TadUh/cmhw1/i9UgXttF4MNu/FjllFjgrj/M
         HcVLpUlr4mHuqP7EwWthpU5SPp+f2MryESSbWDpPF5bo3rrL3KcYl04YeXjvDYFvFfYh
         6AiDmSCX15VY5tcmNbJy1iw2VCl15BMCR//OcLeHajlyCI/qoeYVPoqEsRmWIvuA8oPI
         RJboiJGqmmcpvPtyFtkgiSLBXNcznDRkGLLMF/4Mu9/GujZ0w6JeAp1jK4aQ8foUOPP4
         ycM7oXjDWZ7hxJ66nrIiFxOnH4C9ARGV6EZYMmLiMGb6Dcl0RYldwc1AsFmXvBVjN3GE
         uk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081004; x=1731685804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ+J0uCnaT+x0yIPYmMnG9zvQPdwpvJwn2l27mxNTv8=;
        b=UWvfs3oJgm95M4ZmXbb+hNGp4YYwcBhl1OUSiT57+faIZ/q9hXsbbVfQ7e7d4LkTL2
         FEGwBTILW/E5Sx70EWAt2r48T+bKbFaTl5iH+0WGnC5OL+VNryelpu7hXsyg/RugqGz2
         Z0rQrBnMNGK6WdtS9bdEvIR7ift85i561StQqOla+b+5uP3beWi2ggm+A+RBl2JKz3lI
         q0h/BIWEBZ6epWsTj/8ZO9qFAaQpYXZUJXAZsb/Dod07NXDcMulc8N35JgW4HQStFw7B
         TRqa99bYg29AIMmF5nBEAbLSEVeSOGDF3o6CD45Omt0babQL2imat/UsQlfySIdTdZxc
         EDFw==
X-Forwarded-Encrypted: i=1; AJvYcCWxX/BY2DGcm5WVDb1aFWF6zKR9DzMI9Y6LrcD2hTmp0nrGybLyYfhn+DAOUUPAPclx5v1xfn6Zc6hwBSIM@vger.kernel.org, AJvYcCXXhi9q2uVIQzN2kFwqlK3F1V95urLmjtDwB4t3/JLgcqhs+WSajBqe0gAI7Wtwf4NgNnEElbx5/cuy@vger.kernel.org, AJvYcCXYo1oQHNC/LGkVFwVv9gI1KRUscnwF08g8Baz9AOTMx9G/SnK1RYeWKto+mFSaLVKqDlUD5N5X5iR7@vger.kernel.org, AJvYcCXyy55PDKibTIscamjVnhTJbdCjLhsukQYy6NLlDd4e/7PyjA5iv1SVfTWfU4I8yypweT+Ymy5LrvcQY3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxinTMnAZhhqxGk8OYkhiB90lrKz9Ab9EkwWwvpXvvodCMeBSvq
	bV5o2fIUVeY+SJzGLZiHAMfdT8O7oBm7VnOxPeUhgR4FNfbc7PVM
X-Google-Smtp-Source: AGHT+IHRoj1cc4ePvYEsz5DmCSDi2av2jJaP53p6RwfYTf1WJ4aBuGYIc1+XeiJWDJWQDrjRxbKCAA==
X-Received: by 2002:a17:90b:1e4c:b0:2e2:e545:82c5 with SMTP id 98e67ed59e1d1-2e9b16f0529mr4094709a91.3.1731081004272;
        Fri, 08 Nov 2024 07:50:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62d6acsm5720627a91.53.2024.11.08.07.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 07:50:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e566ee56-523c-4cfd-999d-1cd9ca8eb7a6@roeck-us.net>
Date: Fri, 8 Nov 2024 07:49:54 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] iio: temperature: Add support for P3T1085
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Carlos Song <carlos.song@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20241107-p3t1085-v1-0-9a76cb85673f@nxp.com>
 <20241108152856.000042ed@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241108152856.000042ed@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 07:28, Jonathan Cameron wrote:
> On Thu, 07 Nov 2024 18:02:26 -0500
> Frank Li <Frank.Li@nxp.com> wrote:
> 
>> Add basic function support for P3T1085 temperature sensor.
>> - Add binding doc trivial.yaml
>> - Add basic read temperature driver
> Hi Frank,
> 
> For a simple temperature sensor the usual question is why IIO rather
> than hwmon?
> 

 From looking into the datasheet, this is a chip which will be typically
used for hardware monitoring.

> Previous reasons have been:
> - Very high performmance / accuracy part (i.e. expensive)

0.25 Hz ... 16 Hz sampling rate. No.

> - Remote temperature so not typically hw monitoring.

Local only.

> - Same silicon with a more complex sensor (typically humidity or similar).
> 
No.

It looks like the I2C part of the chip is is compatible to TMP108, so
another question would be why to implement a new driver in the first place.

Guenter



