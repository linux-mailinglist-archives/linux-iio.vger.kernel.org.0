Return-Path: <linux-iio+bounces-19195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98CAAC448
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC43B2E0A
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32ECB27FB28;
	Tue,  6 May 2025 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fmyBDuK2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A427BF8D
	for <linux-iio@vger.kernel.org>; Tue,  6 May 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534735; cv=none; b=Y2RZYDFDFMWcbOflc2yvlnCebeYHWOggY+iTNKAQKAQRucxLN5QuuszYQRWIaM2vWODSq6uhOfVhUi+1n44T8UzP0I09/7fHXLzNMe4BdXpc9XfJf7lVM2Chesc5nl3CZWk5JIzZqeCl9dTdmB6/KIbHLO/N6kBE306imu4TFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534735; c=relaxed/simple;
	bh=vnuot9w5lgI993RhLU7d8m6iM1bAjQd7o6WFESoCCM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dmNJBkhmx+dP4YO/odBJQQ+R0beE2GuatznACf/JNY+N/onQOF2C3Sn5uMzW5J1CuC6RCiq3spbDM87ICs6HqNDb44ydW2QfWVr0nwoKKNQQPmIsa/cYwn9x5tfY49HO1SByD+Jgozidlkns09+D1qaosqj2VU6vWJy0AB9B5CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fmyBDuK2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso35270255e9.1
        for <linux-iio@vger.kernel.org>; Tue, 06 May 2025 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746534731; x=1747139531; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/voYsvcTN868kMgVPoAbI/LBTXtaMEmPVsFI1hVgpYE=;
        b=fmyBDuK24Bray+xUpSWLGAwZQhWPi1/eIH7SkXKuYreUqGChlsY9i5AdMaOQlJYO6i
         MeUwO7q7GPOSlgtb0vA+rS0g6STfb6CHCEyXWH+soUKGj7kiIWxS1SUcs+QsrpSTBYID
         616vos/XWmNwhMjH1xvcOyd5mL1oFzxr5GlJrAjsH9q+s6UzS3dvUb0U11eX8yFIoRnK
         8MfMOTh5WvoDG+1/rY21PeUvO9xS+MxwGHTd+jjTdGQP/0L1cUDmcXjy+kaWPeOi/Bgm
         d9cjT7HgrtrSldAEoHoM0R1MNL6J51f0F4Jcc6MX6HUUaOvRIhGOQRg2Kco6VA8Rgl/j
         ZgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746534731; x=1747139531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/voYsvcTN868kMgVPoAbI/LBTXtaMEmPVsFI1hVgpYE=;
        b=l2j9aarjgtWTZDKax0H7EfzWmcmyMz1V6lKAiqKsY1LuRJQasakuZM52apg8jk5W5j
         2fFVxJCxZjJFiqnikmElKELMjG0DBuFjbx005P+ttjqGEh4RuQCTWT8gNlYAf/mxAopo
         MMskP7zBjFHxLypqPpeF3m89Y8m2aa9zltrmyFfXZBD44Y0woL5al4EGnjDEMfGPoEQ3
         Gi7OaeKeaBrAt28r6ondc8fDW/uCQGMGx+dCaqIG3I6fbIsvfT7EGfPUyAKthPXRp80v
         BqVaYyRqmI55DyBPwRZvN03jyjkJ7IxTx2NelyEohFqsP4fvs2+2HhEPZ6i/bM6RJ9Gj
         LPVQ==
X-Gm-Message-State: AOJu0Yza6e4elX7UMTI9ooPEXVHWZyIAG8nixpxXPHgyU1mPUqsUmDiO
	Z4+SBxosmvjovH3TdpqhATp1L/hvjeNqZ4iHslbtawh6TSft5hYxotLy9C2mnfK+3HSOKrvGI9U
	d
X-Gm-Gg: ASbGncuTFrrFVFPVabsVKv9+yQqPYb9dZCBaHf9te4KW/m2To0ckCm3IgqWcd29GdNt
	FYkQDR4QCNu3sb8JjxjrhsDNVt1VV7Mbrcu6G7ZCq+mABDu3OoMu4PsMZD/pT6hBF5rtzN/NnGW
	yjMm6MP6tbE8almcmAiKkYWgue7ze6tB0dX4ZG1ox00Jq8cjb+vBvW+raKmD99Dkyspy7TQ5ESi
	xV5xvmXjTF+I5Mg6ydUZ4JrBCKM1EY9Vwq53bhgcM4nqLDQ78Namgjkijy8gXoVV9SL4SPCEv/Z
	CsmM88cLqB8mwGtT9OVTY1q/gn4WtpfSeNoZT+vix/Dh5A==
X-Google-Smtp-Source: AGHT+IFa0FCaI0r4XVGzIQhsUUKsBmbqdhGyHhDMbzEcXT6lA9IJmCIizH7VA4tPVTuhZR+w7ACIZw==
X-Received: by 2002:a05:600c:5010:b0:441:bf4e:89c8 with SMTP id 5b1f17b1804b1-441c48b02e1mr108303855e9.3.1746534731333;
        Tue, 06 May 2025 05:32:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2af2a9dsm215556595e9.19.2025.05.06.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 05:32:10 -0700 (PDT)
Date: Tue, 6 May 2025 15:32:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org
Subject: [bug report] iio: pressure: bmp280: drop sensor_data array
Message-ID: <aBoBR5D1UMjsSUfZ@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Lechner,

Commit 4e6c3c4801a6 ("iio: pressure: bmp280: drop sensor_data array")
from Apr 22, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/iio/pressure/bmp280-core.c:1280 bme280_trigger_handler()
	warn: check that 'buffer' doesn't leak information (struct has a hole after 'comp_humidity')

drivers/iio/pressure/bmp280-core.c
    1225 static irqreturn_t bme280_trigger_handler(int irq, void *p)
    1226 {
    1227         struct iio_poll_func *pf = p;
    1228         struct iio_dev *indio_dev = pf->indio_dev;
    1229         struct bmp280_data *data = iio_priv(indio_dev);
    1230         u32 adc_temp, adc_press, adc_humidity;
    1231         s32 t_fine;
    1232         struct {
    1233                 u32 comp_press;
    1234                 s32 comp_temp;
    1235                 u32 comp_humidity;
    1236                 aligned_s64 timestamp;

There is a 4 byte hole between comp_humidity and timestamp.

    1237         } buffer;
    1238         int ret;
    1239 
    1240         guard(mutex)(&data->lock);
    1241 
    1242         /* Burst read data registers */
    1243         ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
    1244                                data->buf, BME280_BURST_READ_BYTES);
    1245         if (ret) {
    1246                 dev_err(data->dev, "failed to burst read sensor data\n");
    1247                 goto out;
    1248         }
    1249 
    1250         /* Temperature calculations */
    1251         adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]));
    1252         if (adc_temp == BMP280_TEMP_SKIPPED) {
    1253                 dev_err(data->dev, "reading temperature skipped\n");
    1254                 goto out;
    1255         }
    1256 
    1257         buffer.comp_temp = bmp280_compensate_temp(data, adc_temp);
    1258 
    1259         /* Pressure calculations */
    1260         adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
    1261         if (adc_press == BMP280_PRESS_SKIPPED) {
    1262                 dev_err(data->dev, "reading pressure skipped\n");
    1263                 goto out;
    1264         }
    1265 
    1266         t_fine = bmp280_calc_t_fine(data, adc_temp);
    1267         buffer.comp_press = bmp280_compensate_press(data, adc_press, t_fine);
    1268 
    1269         /* Humidity calculations */
    1270         adc_humidity = get_unaligned_be16(&data->buf[6]);
    1271 
    1272         if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
    1273                 dev_err(data->dev, "reading humidity skipped\n");
    1274                 goto out;
    1275         }
    1276 
    1277         buffer.comp_humidity = bme280_compensate_humidity(data, adc_humidity,
    1278                                                           t_fine);
    1279 
--> 1280         iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
                                                        ^^^^^^^^^^^^^^^^^^^^^^^
So I believe it leads to an information leaks here.

    1281                                     iio_get_time_ns(indio_dev));
    1282 
    1283 out:
    1284         iio_trigger_notify_done(indio_dev->trig);
    1285 
    1286         return IRQ_HANDLED;
    1287 }

regards,
dan carpenter

