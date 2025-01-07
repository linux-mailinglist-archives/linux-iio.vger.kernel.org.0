Return-Path: <linux-iio+bounces-14003-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AD2A04DAA
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430143A4CA0
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA51EE7C6;
	Tue,  7 Jan 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ji2tzGm2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12961E493C
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293144; cv=none; b=Ywtf2g28k2JUzuIFfKjsliMTcEgpYB4o7RL4X1BHkMbryYMsPjEu004tRGZ3whcaQqTi8tpCYBsce1l1sLVBFFMtcD/JpGRv1MIHi2zHELavia0UxWU55ImGrFEeTSo9SryUEpAnXjq61i3MiU6QFBxUVnP04vs8orm7axZ2Ko8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293144; c=relaxed/simple;
	bh=DFmn8VSyAUHQzVS5msOVeVe/Mf9jzF9AWH47Vr1havA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uh2V/9oyI8lPRefBl31LhRZiHOKEBBUygwqySm3CHugqCxn3cD35uuVlVfgS1GN+tEj0WU7MtMDwKDmLDlZkG9R4+Ad4lJQ2Ct/y0lY5qmWiD3nv9xkRv9QuZPa0XXyOMzyouPm4m/2tdBnFYcI5LOyKiY5dJKA0KY4cYWZ5Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ji2tzGm2; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71e1597e3b4so4681127a34.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736293142; x=1736897942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBAD6yeWOQzt7479x35xKD5+k6y1LOWMDjtiTVM5/j0=;
        b=Ji2tzGm20AE4bSvh9mLE4EvhLm6jykS/oNtq8ZJoMVxZ/7u/L4UOyjJQvffkxfO5Bh
         WPW9+P8gIUwg8yJQDRT7L/AssEZrdYdtWVQviRhHbZ6ipPBQXfk2U+WY8XyfiAFFbpBW
         VXGuR+latkuxfddnx8ptX4OG1LpR1xwYLdtM6J+iMC+ENxYKHxyslnB35Q8Rz5c4nFFt
         JGrR2PtPBISxPM19Dvn05KdTk50dXRXfv0tN+LmOMsNWBwKrN5i7NOLTe0rjOb93yU0d
         3Hpbou1RZvwRv3P2PQjgUeT2duFqwEhXE8ZXHc0CdNJwi7H8IqAvH47s+mLQLvf7hlzT
         61Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736293142; x=1736897942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBAD6yeWOQzt7479x35xKD5+k6y1LOWMDjtiTVM5/j0=;
        b=GZpVEotnr7P4Q1r3izKvebd/XucLgfRhF0C1BSejD3sDM1KlXpyXQLE4L0Ngd9U+Xh
         EiO1s8OSq2DEUbp1sNOIpdvi1csIwTm+ZwXbUhrOV3tcNJSfh+8BLRceIbEnkpa+1c8K
         W5M3L9aq/OFdmgUFqkaAKT6DocqKB54/ngCJFggKgshFq6OEvNywCs1mOmJkmLIhH1ty
         dDrEZVyRDJh5cMNIEeqkQLJOxlqr54gCXl8XiSQR2VHlV57xST/d21nUgfGkZ4Ypan6W
         JnmG8W4xsVB1IuyHt4emUZhEug0u8e2uHodntmtmjYuUBOoSoSciHaQtOjMEfR8ulBL8
         sU6A==
X-Forwarded-Encrypted: i=1; AJvYcCX5QjyqWe0ryeevp2fgGmyyiVIDFV0Up1JH+/i/2O+REeXbuHSktrm5I7p5BAhueXdsorCXXP3IMB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYVxJNsZ1PjasEfR9jWHOK9PwH5bi/9fz4WvmiJjWpDLQUck8
	0ppRFK/yVT+KuJXpE2aTfJF5Te5OJ3L7XpqCVy8LPIGVSK+YPqvyGOsQSmXBBXI=
X-Gm-Gg: ASbGncv7C3sUELuRXKEOPmbS6fDq4sloLPOeexFT1QVeQ4EwaBt8/F125zNnSJ8IPFq
	SDIu1icJ5ffx4KC8fdIDe89cjTMFlDnw3oNzZIwi/l+9KkBTPandh86qlY982B0ZP6nSN4/jjNw
	UtW/x4ZlVOfhblZwzhtXV+on4WB/g337tG5q848TEfldVD2YbCKPXyvTA0FHpfNmamFQS39qu76
	LDMWPwafEz4vHg30utIAN2vn3vLXxz0d9kqAaIE89nVSPqRIFSkh+3KUe3GJaNdAyu6qbG6fIoQ
	zPLVLHnU3NX0nXnFzA==
X-Google-Smtp-Source: AGHT+IGaz3KfG3mjB1yfjWpHZMsowJ++X1Kyc9cU0l4p7loNNycdbgi6bR57p7hkV2D7F8W3gevfWQ==
X-Received: by 2002:a05:6830:92a:b0:71e:5667:30ce with SMTP id 46e09a7af769-721e2ee4602mr481975a34.28.1736293141856;
        Tue, 07 Jan 2025 15:39:01 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71fc976438fsm10631899a34.10.2025.01.07.15.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 15:39:00 -0800 (PST)
Message-ID: <58ea1899-05be-4743-911b-77a56f08c347@baylibre.com>
Date: Tue, 7 Jan 2025 17:38:59 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/15] Documentation: ABI: testing: ad7768-1: Add
 device specific ABI documentation.
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
 <f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <f78c3dee381b23c17787f1e2bc9c5667741d407b.1736201898.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/25 9:24 AM, Jonathan Santos wrote:
> Add ABI documentation specific to the ad7768-1 device, detailing
> the decimation_rate attribute for better clarity and usability.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad7768-1          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> new file mode 100644
> index 000000000000..065247f07cfb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7768-1
> @@ -0,0 +1,13 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a range of possible decimation rate values.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/decimation_rate
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Sets up the decimation rate for the digital filter. This can
> +		directly impact in the final sampling frequency. Reading returns
> +		the decimation rate. Writing sets the decimation rate.

If this only affects the filter, I would suggest to add `filter_` to the
beginning of the attribute names.

Also, an explanation of how to interpret the numbers would be helpful. It looks
like a unitless number that acts a sort of a multiplier or divider, but that
part isn't so clear to me. 

Or...

Since the decimation rate affects the -3dB point of the filters we could use
the standard IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY instead of introducing
a new attribute.

