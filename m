Return-Path: <linux-iio+bounces-15070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D6A2A586
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 11:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374D63A6D72
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 10:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F440226549;
	Thu,  6 Feb 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMZYJT4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2BE213240;
	Thu,  6 Feb 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738836336; cv=none; b=FFzruj+GtGw2YviiPeVDbBijKDXOOxeg9NONdqTfKhq+7qm1nhL8PzzouwhdU17Y2o3yZ0qAylrA6hyuPdMzljb+YlFp18GawQb04XsJP2xHL6vNROPiKEo0ZmJget9mvfh2sHLXsAqN+LGt/+LHrRfJoEIiw3/ON6dPbWRm67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738836336; c=relaxed/simple;
	bh=0xrkmKKCIh/hLhu9vbvKOnwbrR9FaaokDbiLZ/MWetw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMh0uAxHyXhXN8PX9J75AU/+tONSL6bgkY5q8DbpVU76g5V4D+VWHaaboGuR8mcz/BahidWDi2ygxOKlUsw8FS/5dU4WX3I1CJFdhphsFIdWYaAp/isD0EK4eYOoQWeTGfXEJu1oKfkxD8DQi801RsC39h2XWonP0KK8ZHlAkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMZYJT4E; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a04so7182621fa.2;
        Thu, 06 Feb 2025 02:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738836333; x=1739441133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0virtW8kjtxzjH07RQqH53vaPJF5r5H3sxuVvOKAlHs=;
        b=iMZYJT4E5hmBYg8tfq5wvmvxEfS3qLdYvNvlZgj6KbB68WbcWxXYZbCCX3uZ80Vshz
         jI1aLdLih0UYnfrEugFDK7owLS9ypstA5C7Hd+YYC6GYNoKwsd0/SBd8wNH/63kCgDJe
         APoGSSor2QCGqEgP71I6XarhVUsYnwZWFyWIrr6Scscv12cuJhxtG8piKZO+LjuzvRyl
         e93oikjZdCQus5QjgbtdLNIolFXSGvxtxbJVnExMRRGcxxx8TQmL7pKqr6jeTIJ3QKid
         QL4RFcdi1eLoOtOf7ojQ+NLvuPq8nPhXpjiPzVhii3d6XfsKkcRKxrFbFD0km8qTbzLe
         RFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738836333; x=1739441133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0virtW8kjtxzjH07RQqH53vaPJF5r5H3sxuVvOKAlHs=;
        b=fqZja1FOBo+XdHnn2lklFpdaaUdDGWWU5B4/MkJPh1JXnutULk+TmhFL7aqZ8c+6O/
         9okSqubVqZy/7Jp0EfDPPXK7bwkAfUdJ6FnqO9ilE0VasVAjBgxd9za74a9p4oXBg4qo
         7hEU5L/1AxY1O5OaB52GNCKV3+pqvkHw6uAM5T394/zZrCT/HORJ2BiJ6UOGbc/xvLoM
         1ezhSqeNL3+HUyLzzTWcpNAMWaBpvXo+lFpR/Z30EtaVUgR1Dkc4rh0BvgeJjiOwlp6u
         bnBHoqM9DanpPFcwHxTkbWDxLJh/iJJ+T0Y4nre/JA+h4NLZmZ94fskgnzf062fKrfxx
         xDJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKOWsC056dDe0Cj0OTq+KVBhk3Hso/zMmt0RCnbdfQ1meMjDpMpnQd9G3WoNsBiFWIX+XuJNVXuIuV@vger.kernel.org, AJvYcCVTW2DpQlpR3hCwDd5nGU4F4UMtYXgUo5b95bhO3muSGtVud258CRV4N3JoMjMFyAaWvdvbtLhH1vetIz9g@vger.kernel.org, AJvYcCW/yPBGFummUcHT4s8vufoAC6jNl5r/e+3WEmuQXsQL1WjUD5JPGkjrN3d1Ysxd4jqNMjfYnvrZkhj8@vger.kernel.org, AJvYcCXFsejE0E97A18uexrEPDKvPw9PBSt3huifOZwciynTA88Qm2g1SWDgB6tUBBcytgp/cHTLK9nOv/jamQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIw7t8oIYCVvSDzFtwcN+dkF1TOmW+aErXD1QoN3+qbNW0s5DS
	hkuK7PVT875K0Fn5s+KM28r583YDiiKB+2F/BL5O/9FIhfERhRQz
X-Gm-Gg: ASbGncs0G98k5eB4e54K2gIv3Wbp5dFskZJmMGmFIf8N/VNYBeAWa/UhzKgwaYZ8pyq
	tQRHkLrdZm7jFQpgUOsUaLAH4XNst3JshO0+87eUHXQxagDx5DrhTCnfjdd4vma8rfFdYZVSjos
	4mOIZfsgAc+cz1+7SCdx9dJKtmbXDXiumOzU/4Gj+dXMUfQALCnBn+MOhOdEV9L1+H00mZA79G1
	3u8j9AkTA2ifVfhqFbqck2CE+Wd5n2WQDXHWgSOIWVspLRApPziaOeT7T4iedg1cnOKfYHv1J70
	+YPXuC4x2dBn4UNAwX+v8CiCu9Uv
X-Google-Smtp-Source: AGHT+IG7xwkZ7DFUUTF2/ENv3MgBlQuaw/xM+8bfmpcHcjjYDrBy1rYTVka2WIebmc7Znq+Fi5LalQ==
X-Received: by 2002:a05:651c:1555:b0:2ff:d3c6:9cf4 with SMTP id 38308e7fff4ca-307cf2e8331mr19706751fa.1.1738836332920;
        Thu, 06 Feb 2025 02:05:32 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-307de178201sm883971fa.16.2025.02.06.02.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 02:05:32 -0800 (PST)
Message-ID: <7d13f5e1-174e-46e9-9c1d-7bd2c72d0d0e@gmail.com>
Date: Thu, 6 Feb 2025 12:05:31 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] pinctrl: Support ROHM BD79124 pinmux / GPO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org
References: <cover.1738328714.git.mazziesaccount@gmail.com>
 <3d85fe979fca352bed4d9841e3233c055dfaf154.1738328714.git.mazziesaccount@gmail.com>
 <6867812e-7269-4686-9fc2-55afd9fa91bf@gmail.com>
 <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CACRpkdaP6biD8ueeezBDw1P3LP6ARoJw0zfkmxC-QKK0fw79YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Linus,

On 06/02/2025 11:39, Linus Walleij wrote:
> On Wed, Feb 5, 2025 at 2:40 PM Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>> On 31/01/2025 15:38, Matti Vaittinen wrote:
>>> The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The AIN pins can be
>>> used as ADC inputs, or as general purpose outputs.
>>>
>>> Support changing pin function (GPO / ADC) and the gpo output control.
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>> ---
>>>
>>> NOTE: This patch is not properly tested. More thorough testing is to be
>>> done prior v2 if this pinmux approach makes sense.
>>
>> Just a note to reviewers - I dropped the pinmux from v2. No need to
>> review this any further.
> 
> Why? Gave up on the idea or want to pursue it later?

I took the (simpler) approach suggested by Jonathan. Eg, I just required 
all the ADC pins (channels) to be presented in the device-tree - and 
then treat rest of the pins as GPO. Hence, the pinmux driver is not 
really needed as the mux registers are initialized at the ADC driver 
probe when the DT is parsed. (I did also drop the MFD and bundled the 
GPO control in ADC driver).

Yours,
	-- Matti

