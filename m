Return-Path: <linux-iio+bounces-19852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796ECAC3132
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 22:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2337179D20
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239D1DD529;
	Sat, 24 May 2025 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE6Dxzeu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B48367
	for <linux-iio@vger.kernel.org>; Sat, 24 May 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748118317; cv=none; b=WIcAX9kqLQoBkiDq+7OGdu+Pj+SFmh5nOfnOBSQzJlHIMymhRW5WRjg5bzL448DoFJ30zfrzJzzuszJLFrMyRuFbQWZS3NihL51cdu4W9QQtrnQbMefa5555TpXZ4dz38U5QDDfkFDsc8Njoh6c3ryqvanApH15APRC6r1dSCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748118317; c=relaxed/simple;
	bh=35Jg99+9L9nMroxFyxo7u144LI2p14HcaSqgXHGeYa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8s4rQf+QVtM9FX4rGad6aZ8hxYfW1mztPkDOVoHGRecW4OSbdXkLg6VRuIcL5dRIzXvlfmT/JNiH2E9h0jFxKib3oNHgYNIjk1Bd8hbGSAWdlOGUnGkZDqXg9eVkhiI/KuicgSgROO84rjcYO8ddHQJIvddXA540u3qe2AjPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE6Dxzeu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-443a787bd14so14524035e9.1
        for <linux-iio@vger.kernel.org>; Sat, 24 May 2025 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748118314; x=1748723114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqXl3fQCB4R2DJmYhx57JmTlEOPnrVgkNI0fnLFUrtk=;
        b=DE6Dxzeuhy/wBpTPd3YCZSSlcfPiz7Qp/KlwjraRZ3zflDmu1zKGoT1+A3mI7/INCn
         y/P9IDahSpikdtt6Gb2gli1mBTQ2ZCRKAl6nke2Y1C+LeVd5RqAvNWKIHMJuHvxVfbf4
         1bY124I0UWyDllQBSoWiOl1wS1kg8VlKHKCDJ3L0PNF0YqdDFj4iMzOQogN8EFqZHScZ
         9TQMvhKLHgvQi3nsjYyjqjtrdPUUWlvFd9HLuI+MMzJO08jlmw0pj9ymLHGZTGPV3ucx
         XH4Pi1LHUABJzZd7LqazU4TSXvD/AXHlNfd81ljPHBKBxBxsvAqB8Ghfj0MVf+gTjPJD
         j7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748118314; x=1748723114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqXl3fQCB4R2DJmYhx57JmTlEOPnrVgkNI0fnLFUrtk=;
        b=pFx76BJ9oRlfq5E3OpfdORoQTD/NcJ6Sa6QHtPlmfhFGM8sjjuyGaIoAIZrbAdynxp
         96DLzD9RRm89R5k0AgE9TEcmGpONecmZ5EYT9Hx8b7PiUPlOQGGj9eYoR5lNUqj9v+ZA
         ElFMbQWgKvqcUX4D3br/QnST7ZCfjwiy2+Ut+3t0FzVuLDwsG5E0nSjZE/TjbzYu2p2K
         iLaNNans1AopHybihvEkotYUc56Dhj63Fy94hvCMLI0EQU0QeN3H6nkoKzRhT/yG0TBy
         +ZeSDMlKBrCP/t5LhawVr5KlJumSDvSZP/C892ieDJiHnUUMqdI5+dSXIaQ+mJt2PoH6
         H3cw==
X-Forwarded-Encrypted: i=1; AJvYcCXqhCwuXXY3vAKEnrysUOJTbPHZHAXGw4KztoD7n4QjoehQLtPzgp8QXdW99FzR5v4+fe3GWLZ0GXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6MDPjHtiRioUwO01cLvCy2btkGBubb1fd2Gnnb7tjXTTBMa6
	v9jNw/3O5qeMMAhE5aPyAbwVMVMmMRzQRRHK2NfMZw+stzCKoV4KQm7S
X-Gm-Gg: ASbGncs4sho91M18G8HWXJdAtKImcXeCbeb3hJbLkXhjQ4uA4BexDZWhPWFgsLDpuqs
	Rtkm2fMLD3+8dIEmmR71GWN/wOkxx7ke/D/kqabPJrj++oWvJlkVMRnvi6ie8oYyqcQZMnDoUN0
	vbhJ8z5V8n0IvP6Cx6iYo0PtBYbXnTd/HuejNRotgEhXHz5FH2QjbWeW8WrjY5wa7e7dpuPZYQW
	Ao/c2SL591bWSsk5JwLMkS8OejmBUP2woytZ+LmT8oUJxXs9ukR8o3ZdPwFyznVUIR5uQ7Ll2Qa
	DYWJHeuRJ1nH0MAotfvvPMQ+qj2Ex9FedtSMNL8nUtrlDLuSSwWOALQlWC6Gww8=
X-Google-Smtp-Source: AGHT+IHiJEe5PeegOUqaHO34kVh8pmb6agEgtkk55+MYxEHdcNrosDalr5AXecV5I/w8CFXgzXM4Qw==
X-Received: by 2002:a05:600c:1d95:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-44c7bda06c8mr39334115e9.11.1748118313678;
        Sat, 24 May 2025 13:25:13 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebdc362fsm284843785e9.1.2025.05.24.13.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 13:25:12 -0700 (PDT)
Message-ID: <cddc4a4f-f982-49ec-a03b-3e26038057fe@gmail.com>
Date: Sat, 24 May 2025 22:25:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: bmi270: suspend and resume triggering on
 relevant pm operations
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Justin Weiss <justin@justinweiss.com>
References: <20250509171526.7842-1-benato.denis96@gmail.com>
 <20250509171526.7842-2-benato.denis96@gmail.com>
 <aCG3YRP66cKyzr1B@smile.fi.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aCG3YRP66cKyzr1B@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/12/25 10:54, Andy Shevchenko wrote:
> On Fri, May 09, 2025 at 07:15:25PM +0200, Denis Benato wrote:
>> Prevent triggers from stop working after the device has entered sleep:
>> use iio_device_suspend_triggering and iio_device_resume_triggering helpers.
> The cover letter call it a fix, where is the Fixes tag?
I didn't know if it was okay to use that tag while to root cause is still there and it needs to be fixed for a lot more devices.

I was also attempting to make this patch very similar to accepted one: https://lore.kernel.org/all/20240807185619.7261-3-benato.denis96@gmail.com/

Is fixed tag appropriate?

>
> ...
>
>> +const struct dev_pm_ops bmi270_core_pm_ops = {
>> +	RUNTIME_PM_OPS(bmi270_core_runtime_suspend,
>> +		       bmi270_core_runtime_resume, NULL)
> One line (it's only 85 characters and it's fine in this case).


Okay, will send a new version when I have answer to the above question.


>> +};
> ...
>
>> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
>> @@ -52,6 +52,7 @@ static const struct of_device_id bmi270_of_match[] = {
>>  static struct i2c_driver bmi270_i2c_driver = {
>>  	.driver = {
>>  		.name = "bmi270_i2c",
>> +		.pm = pm_ptr(&bmi270_core_pm_ops),
> Is pm.h included?
I assumed it was not needed since the i2c_driver definition should be enough.


I will include pm.h on the next version, thanks.


>
>>  		.acpi_match_table = bmi270_acpi_match,
>>  		.of_match_table = bmi270_of_match,
>>  	},
>> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
>> index 88a77aba5e4f..b25171413531 100644
>> --- a/drivers/iio/imu/bmi270/bmi270_spi.c
>> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
>> @@ -79,6 +79,7 @@ static const struct of_device_id bmi270_of_match[] = {
>>  static struct spi_driver bmi270_spi_driver = {
>>  	.driver = {
>>  		.name = "bmi270",
>> +		.pm = pm_ptr(&bmi270_core_pm_ops),
> Ditto.
>>  		.of_match_table = bmi270_of_match,
>>  	},
>>  	.probe = bmi270_spi_probe,
I don't know how but your answer was lost in my mail.

Sorry for the late response and thank you for your suggestions,
Denis

