Return-Path: <linux-iio+bounces-21092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B379AECA50
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 22:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560F617AD17
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002F2264AA;
	Sat, 28 Jun 2025 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pgouu8mX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789131ACEA6
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751144263; cv=none; b=eN9mlqWAFPeXPBewJo3C6JHFVg5Ua05uCkJw/khfWccXLUjsKxBe+GeLPYSYHv2Fy0ASNlPo7p3x/8Rc+67uf1TUzlRst71WbROJ/UX+JJjiqunc7V/wZzfwjuLBr9suAJa4iYaRAXrymwdPCVsXvMv6doEBiw11dLWHD1y9MJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751144263; c=relaxed/simple;
	bh=1tIVIotINW9BqG6gxpF/lGBVW8eqCtp9k1Jg907DwXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hajNEt3qAAipxuvceX8LWQhAKRHDxpmT9A7eIh/yLQLnwRo4GKL765iqUunxX0+M4R68zJScSBC9qzSmSQbuIxBxWxR+IDvRNpXXHQjUt+X4CKBF35gtNHr3pnrrWB/tloCjQlUdE5NDOisoaXEOb1y6DN09krPtjRPiEQrP1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pgouu8mX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2e95ab2704fso623237fac.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751144257; x=1751749057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oRSKXsmOI7fubaJSlkAR5RbckHizePnzok9UyZErkTg=;
        b=pgouu8mX8H+7LuV/tblDzDjKLxqt41cdCVFCLRPUklRSEMflpttpX6gf/K2j+IYk45
         EKW6QVdlVHpDDWYH+M79EIx6yGHCoqFj3+70Jea5T+72kk3Oa1ZyeWxL6nlR3GqVxx8T
         0rTQvIIcR8VLcxzPaUjafjznT8DcTkjlfmUTTKOkXq8xtT1gBLu063wXnoO5L5Ahd8Pv
         egOZFOzDv9/O90ch4Wk8LUyT7y8M1omPfBzfAJCLRf7gSAgOYtmRdirG69cXyKvGpiR0
         7SwDzXom3TU6i4iWf80YMlwQB4KBr47qtqVJE3Y9TRNsGhtVyi200DtPY+zYOntDlJM2
         2o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751144257; x=1751749057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRSKXsmOI7fubaJSlkAR5RbckHizePnzok9UyZErkTg=;
        b=DKdGZpFFJjwvN7uh/1OACVq5BggyOdz2yvQEH9Okmf50wSq6KotVH07nO0ahCyqErb
         L60J30uzHelI9jHFwQHsejxafUZKeONliVyp/Z++4nYbTnwy4jpnX3AIqzHC3X8A6BTA
         h3qK/sLlp81kahSxi8Zt0owqfot/yeQJf37hdtPFou6JoQvuOqmrqf86IDyukjJQ338N
         i63qKP48eLAmMvbASv/c3ZsNlqlT9Fid9JCqiVNn5Hd3o3fDQi67AoDp9zjixmHNGDjO
         0EO7QjeUJgLVhcn2/Ci8HSy6H7W/OOoIIEi3UEjXLNCdqFEfmv5u4Iq08Y3sRz1Pj/c5
         2B4g==
X-Forwarded-Encrypted: i=1; AJvYcCVybmrW8jaNRbN447bT8sCaLscNfYZXiIDxzkoJF9dCwZPCJs/RuzYUiea3WPAvSASxGMLbN66FWA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mNq8ze7yYEtxY8cIXdUVp1yJBqGKYhzbF8xtKKyP3CnPPNJb
	q1jTWuGzJW9c1GaA/fBwr8JP8O4AX4FbvzJhTFMCxHNEWcLA8c5KTPo9CtesrqTjmjE=
X-Gm-Gg: ASbGncsJQ0tVXVFgvwnANu54WRkk11oMde30lkOOgJLlxc2bzm7BqsjaHTzE3Nx7Pvs
	yTS6sHKkWMznDC6ARwrAauwYkQXkPKPG6CSfaSbKyRO3KNxhU3CGwPXwbr5ErckNM392sD/I51f
	rs8UaHCiksIeZnUbJFXQajdZ88emiy5l/fM1/u02BaoadTxwxDID0YPQy45D7D9QXegWfQJ1DT1
	wBM6DGCX2MI9Sov0rLlVE7TfenaZPNmUniwzagspX70DCvLJuVejIuBN1+0eOZWVg5HPlk2sEFV
	FcQpFwe3KFDKlWU+GWCZ8U0audobJFruWGJQcHyubAG7HCa/RVYyp9Ca6F0ywuntTO1My+PWYDk
	2tzq0xwh03rbUZGKjVfS5SGGk+l29zSKmP1XLzv8=
X-Google-Smtp-Source: AGHT+IH9PgkgP3Mn0s2143cT7LH6WVO1hxIQIRM62cbxHZ1C7h8UjjMfsjgL01b5EsGUA+q19PP/6w==
X-Received: by 2002:a05:6871:e013:b0:2c2:bd31:cf37 with SMTP id 586e51a60fabf-2efed42ac02mr5417996fac.4.1751144257398;
        Sat, 28 Jun 2025 13:57:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4? ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50b4d84sm1681854fac.23.2025.06.28.13.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 13:57:36 -0700 (PDT)
Message-ID: <c894cfda-a775-4598-ac3b-b3d35c6a84b3@baylibre.com>
Date: Sat, 28 Jun 2025 15:57:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
To: ASSI <Stromeko@nexgo.de>, linux-iio@vger.kernel.org,
 Vasileios Amoiridis <vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
 <20241017233022.238250-2-vassilisamir@gmail.com>
 <875xgfg0wz.fsf@Gerda.invalid>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <875xgfg0wz.fsf@Gerda.invalid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 1:45 PM, ASSI wrote:
> Vasileios Amoiridis writes:
>> The idea is that the sensor is by default in sleep mode, wakes up in
>> forced mode when a oneshot capture is requested, or in normal mode
>> when the buffer is enabled. The difference lays in the fact that in
>> forced mode, the sensor does only one conversion and goes back to sleep
>> while in normal mode, the sensor does continuous measurements with the
>> frequency that was set in the ODR registers.
>>
>> The bmpX_chip_config() functions which are responsible for applying
>> the requested configuration to the sensor, are modified accordingly
>> in order to set the sensor by default in sleep mode.
> 
> Since this change went into 6.13, I've been unable to update the kernel
> since it breaks usermode quite badly for me.  I am using sysfs to read a
> BME280 sensor every second (oversampling is set to 1, so there should be
> no trouble at all to read at that rate) and most of the time the
> measurement doesn't complete and I get back an error message instead of
> the expected reading.  The journal is full of these:
> 
> Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.
> Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.
> Jun 28 08:19:16 Otto kernel: bmp280 1-0076: Measurement cycle didn't complete.
> 
> The exact same thing happens if I stop the process that's reading the
> sensor every second and do a manual read at much longer intervals, so
> it's indeed not the read rate, but rather that the driver apparently
> doesn't wait long enough for the measurement to complete.  There is an
> indication that the wait time is just slightly too short as I have a
> somewhat higher success rate at reading every second when the load is
> higher.  Addtionally the read time for all three values from the sensor
> went from ~7ms to ~28ms with much stronger tailing to longer read times
> than before.  This sensor is in daisy-chain with a DS3231M RTC and hangs
> off the DDC of the unsused VGA port provided by an Intel IGP.
> 
> I've not found a way to switch the operations mode via sysfs and/or
> enable the ring buffer, which may or may not solve the problem depending
> on which mode is used when the trigger arrives.  That's mainly because I
> couldn't find a complete example of how to use this facility and I've
> likely done some of the steps in the wrong order or missed one.  I've
> enabled the scan elements, but trying to enable the buffer tells me
> "write error: Invalid argument".  For starters, the system I'm on
> (openSUSE Tumbleweed) doesn't seem to have IIO trigger support enabled
> via either configfs or sysfs.  But in any case I think oneshot capturing
> from userland should still work, I just haven't found out how.
> 
> So is there some description of how to get the sysfs functionality as
> before and/or switch the operations mode to avoid this failure?  The
> easiest would be if the BME280_MEAS_OFFSET value was configurable, but
> it's a #DEFINE at the moment.
> 
> 
> Regards,
> Achim.

If this change broke your code, we need to fix it in the kernel, so
thanks for reporting the regression.

It looks like the wait time calculations in bmp280_wait_conv() don't
match up with the datasheet [1] that I found.

[1]: https://cdn-shop.adafruit.com/datasheets/BST-BMP280-DS001-11.pdf

There, table 13 says that if pressure and temperature oversampling
are bot set to x1, then it could take up to 6.4 ms to complete the
measurement.

However, in the code, we have:

```
#define BMP280_MEAS_OFFSET		1250
#define BMP280_MEAS_DUR			2300
#define BMP280_PRESS_HUMID_MEAS_OFFSET	575
```

and 

```
	/* Check if we are using a BME280 device */
	if (data->oversampling_humid)
		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;

	else
		meas_time_us = 0;

	/* Pressure measurement time */
	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
			BIT(data->oversampling_press) * BMP280_MEAS_DUR;

	/* Temperature measurement time */
	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;

	/* Waiting time according to the BM(P/E)2 Sensor API */
	fsleep(meas_time_us);
```

Assuming BIT(*oversampling*) is 1 for x1 oversampling, we get

meas_time_us = (0) + (575 + 1 * 2300) + (1 * 2300) = 5175
               ^     ^                  ^
               |     |                  |
               |     |                  temperature
               |     pressure
               humidity

5175 microseconds is less than the 6.4 milliseconds max time, so
that would explain the error that is seen since the error is
triggered by the status bit that says the chip is still busy taking
the measurement.

BMP280_MEAS_OFFSET is unused in the code. But 6400 - 5175 is 1225
which is very close to 1250. So I think the intention was to include
that it the calculation like this:

---
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74505c9ec1a0..50c869e3d5c9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1042,14 +1042,13 @@ static int bmp280_wait_conv(struct bmp280_data *data)
 	unsigned int reg, meas_time_us;
 	int ret;
 
+	meas_time_us = BMP280_MEAS_OFFSET;
+
 	/* Check if we are using a BME280 device */
 	if (data->oversampling_humid)
-		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
 
-	else
-		meas_time_us = 0;
-
 	/* Pressure measurement time */
 	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
 			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
---

Hopefully you can compile your own kernel and test this. If that fixes it
we can turn it into a proper patch.


