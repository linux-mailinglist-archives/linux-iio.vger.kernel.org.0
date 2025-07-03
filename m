Return-Path: <linux-iio+bounces-21322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518FAF829B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 23:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFE8585B4B
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AE82BE7A7;
	Thu,  3 Jul 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y3WsPSGt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121628688E
	for <linux-iio@vger.kernel.org>; Thu,  3 Jul 2025 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578023; cv=none; b=n1g/KyS3Twty3oo3GrmeJpDd26xc3kzC0isu0MAkv8djaYiIlkr3XUveN6mFE6kpHkYSj5wfh+Kfo14MTwmVPK9gEYdYraJZ7PieRMuJbRAyjqMzD09X1yC5kw1tZ5r2Usxiiv0OGejCa0A4O082+kStUfySXjQEQbkUKOUT8tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578023; c=relaxed/simple;
	bh=0eZUQlunxZ8ZDJSlGg5YWG682u4zGCezcHWcVBPA8Lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9xODMtiqBELmWRmWCKqaza22coFicWJFhsO9SIDXBrMbQAAj8hDRi3JIsXWmbhhx+Ykyju3+p80igXMOuDPiLWmg86fTqh16Di/HcDjyFijiEvMwE5IK9wvV9StPBkkXmgb1jzOoUhIF3/JMd/KFBD+G35Ky414oUsjTyMjmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y3WsPSGt; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-736f9e352cbso210682a34.2
        for <linux-iio@vger.kernel.org>; Thu, 03 Jul 2025 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751578019; x=1752182819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oJ8ujZlzaPcZCmdOGOROSSXlk7hultXH6uDj8y1p0g=;
        b=y3WsPSGt6KofVFHQ15vJmM3j4/IE3YhCNFJXX/7eoDI9Idfalg08NbQzyTky8YYgb+
         DZboWJZJQCMIzuBFdJMKcmP+uxMC7RCD93/YJi6G74oA4ysjv4lHdwACyHP9Q4jpcf3c
         ktCAFiHdsD+hZHVuFa4V/Lob+dRRCL1BTkn0JeJfXn9IH107Ezg205pGN6P+qs87ei5O
         SWU26vw47OrdvnEtc2HTcLD3oSi1USljWqxIlhN2r6BM+4TUaFuv0EpmU789CH22bqFY
         Dro29edbfugyZgKnkG74Ve9tMdk/oIX7eVlxtYgJWlb1OvR2Bymo/MSCUHAWvRNya3oT
         WLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578019; x=1752182819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oJ8ujZlzaPcZCmdOGOROSSXlk7hultXH6uDj8y1p0g=;
        b=HXPPTFcJEZecsQk35V/0g20HifHpBAnOUjZrl4O9LkpjlwGIiEcqRBJZX/hNUkj0mB
         Q1mNfWflDrU+x6RoschFsYTTcTkd+SmJ8Ne12l+sfx1vE2RpCS599ncNPwzqajr9hCPd
         cVtmd/Axp1LwbIR+9/IuInZHhH0GWGhG7DVHRwGmvnQkW5muWmFg7iqSS5ITuvIz9yL5
         0Xwv5ape0D3w5Wb5HRluHNZtq3ZYlt4C9QeS162U1/4lHvOu4hCwKKdFxsUKB5kUyDWT
         guUeMKFBR1Co4Gz0uUIh6lER0KHA1ioVepFT52/hJQ5r+fBrb51THU+QGOolP9p/OFwc
         7FHA==
X-Forwarded-Encrypted: i=1; AJvYcCW884SvisxRuXYPEZsPQ3oU8gQIa5siSTkTptVXos8B0BP/I+zcT4Z+pTuDRje5nSbSOrrQPOum07g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtISD0Ui4VnD2K/xNR+2c+bTyzhY6vyWI01yuWzJdBdMtUvb/L
	2dtYUyDRCt1TGdv+vxzzxjNEU7cwzO+CS1bqheBzzB+zTN2IKWXiIt1joBy1XbsuvnA=
X-Gm-Gg: ASbGncttmy2NzdEVrFzhNoj8izXvHVuRBIPadDH2JuNrDlRZw6yujYfQR4At1ayWGVW
	fXT+cDivv7inrAbLv48pjKEPmUYvCUCdCAFjzCeUwatdsDj1cY4X9oXdAqWzO5uGAJrF/43QLft
	pBNzH7+fQP8R5AFSMxw6ZALvuwFi1VbMmWdYmT+Xf7jSekQM5rHpUk90zpAkrKmMLFYl1w8/1OK
	WKlUj4f5mPMeiljv+ljK74MhNHaLj0ysVebDEdrEdEzVvIUMykdURdK+hElSaxVIzHGzINRb7vr
	RsFmYjY6Lu/OoLrNj4fFNMlFgcxOXc3PsJFmSD9QPlohuRCdcP8M1fT4l1WQS4uQRmljtnUgW4L
	FW5QGrQNEpWrzTh/ENWkiD3xkm+MzdB2cHb2ZpeY=
X-Google-Smtp-Source: AGHT+IHgAPBq1aur/7S/6mcI4NLp7GN7zcjgxxqJEIA8K08LOieFpkPn8SZoEH61J9kn9BXdbBYAmQ==
X-Received: by 2002:a05:6830:6b0c:b0:727:3439:5bdf with SMTP id 46e09a7af769-73ca12c508cmr453337a34.13.1751578019296;
        Thu, 03 Jul 2025 14:26:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4f2b:5167:10f4:c985? ([2600:8803:e7e4:1d00:4f2b:5167:10f4:c985])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f938346sm126011a34.53.2025.07.03.14.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 14:26:58 -0700 (PDT)
Message-ID: <8f4b72bb-3c5f-4137-a4f9-5ce94631d3c1@baylibre.com>
Date: Thu, 3 Jul 2025 16:26:58 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: trivial-devices: Add Garmin lidar-lite-v3
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701223341.36835-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250701223341.36835-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/25 5:30 PM, Rodrigo Gobbi wrote:
> The compatible grmn,lidar-lite-v3 is managed by the same
> driver of pulsedlight,lidar-lite-v2, which is a trivial device.

As a general rule of thumb, using the driver as justification for
dt-bindings is never a good reason. The bindings describe the hardware,
not the driver.

Assuming I found the correct datasheet [1], I see a power enable pin
and a mode control pin, so I would say that this isn't a trivial device.
Therefore this will need it's own new file. We could at least add
power-gpios and power-supply properties. How to handle the mode pin
isn't so clear to me though, so might omit that for now.

[1]: https://static.garmin.com/pumac/LIDAR_Lite_v3_Operation_Manual_and_Technical_Specifications.pdf

> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> Fixes: b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property")
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 8da408107e55..cd9d7d5eec51 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -107,6 +107,8 @@ properties:
>            - fsl,mpl3115
>              # MPR121: Proximity Capacitive Touch Sensor Controller
>            - fsl,mpr121
> +            # Optical Distance Measurement Sensor
> +          - grmn,lidar-lite-v3
>              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
>            - honeywell,hi6130
>              # IBM Common Form Factor Power Supply Versions (all versions)


