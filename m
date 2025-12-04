Return-Path: <linux-iio+bounces-26758-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0878CCA4D6F
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 18:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD073069C98
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E67349B1C;
	Thu,  4 Dec 2025 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="npIIKAy0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF060349B1E
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869716; cv=none; b=e99tro5vO4cTOsTxLL803Xs//zdOg0ZmW6sWn9rST0WLp9ud4eqVvkZtdcV8GC3LXEnHc3q5nGMZpDdVyp//rCGnbWSg1K7Z1z22H2z/rOU3W34f0oj7JzAUel4ANK2kWwlKIsFOXz1ZfQSZPdVfEVooUUyBYdRfzibrRFLs9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869716; c=relaxed/simple;
	bh=RJrF6VOS+3BAz5nEB1+TZdimw8zPQxSfnzdvz6TM/0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8Wk/VCgflfcIyBkKCZzsOPAkIU0SxLEeAWMdj/RgsvlDiiTKn2vYvb20WUsmbTdMDsIUCzdLzRMZFwn9POKAIaUbj8ou1r2jekXghkdI/uoXxOJIm8XhTTltwojYoocVDt7KNxQl3CdrN+7q90On9Gzkt6/9XCdYq8ymeTSNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=npIIKAy0; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6597b072cffso367790eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764869714; x=1765474514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgjVXO0RU8Da0XtOb4CV/bXMWFtkfibexst/jI0YgUY=;
        b=npIIKAy0kClV5BGJjG1vg1xh6fWguzsbu5eu6RwWsEO+SAfwANUQq9ENyv1b0EekRt
         QvLoI//I3HGhvmrzgj1s2mDusTdywjlAC2Y5J7tBGu8ONtykoPm8qgAkrnA9jtXAqxq7
         QfG235uF1N+vx1bg2VT/nAUE6YGDJZegXbx7i7h7rHdanCc/UBSdSPDK1Hg0Cv6HGHGR
         niwlGQ24I/QaDTRVEc8n0brKjOGAgCHzKCDnnCCm37h4hhx41jvLRB+W1KiDMftpcFxG
         fZHk6aWwfJADHlIDltFgi4ZwqugFn96d8thiqkVqOxYAPeu2T6NCZq408dRopu0N34o8
         F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869714; x=1765474514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgjVXO0RU8Da0XtOb4CV/bXMWFtkfibexst/jI0YgUY=;
        b=P1DG1Anl5aIe5XqihsY2UUa50J/fELGyKrVqOVNG/VvK1qtOaRIP4IYuYWvEWq389+
         t3GLsysHFrBn6tRTkFV0KAKKrE/WyGH2PfsOfz8Yv6XVVWHWme1yGRpBk+FhDJUmhY6r
         QvcJ0hQBWAVLaNY+8oNwWFo8GnKvbt/XDXlExacc9aOeiFd8Ra1ZJYH/SiOLRe01WO24
         +6dEacW59LpNRGvV6upkEzPk81Hk9N64c6fIf/n6nPgC7ZBtNN5hf0bn7K7wUx6/zwRI
         BnT3b/XtuLkz78+cyVvxEpS2RwodgE6nl6dT2etdxMOz2Q7dYzu2Jzy+VTh0I/jkqY9m
         HNJw==
X-Forwarded-Encrypted: i=1; AJvYcCUP+ihTLyZE9Iko+jXzaYbhkoaXQgsTFO0Mw1uERq5uoas6WbEcgaJta6/66S9udDfCCgdngYhnFcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfnURFMfaTIEqVDzmD8BYUvdvl+3AdLH1NGaCPWZmwaFazzeq
	y5d2SFPKI4g9ENsZoolIho2FduzPn78T0HbYsF8NrY8rnPEJvrqyd3H+FsjLrlQntj4=
X-Gm-Gg: ASbGnctD+JxAzY0jPxlJ2lIRntH4fDapn+5Tt4OTipd29B0aUqKxygS6OUeEKEhcy+c
	tjDzzZ3bK0/w/yvO7CSqJMffZMJ1dXQt0dy40URCbsQkbqfvl8y7uekIKuLqwxXpnQ6m/Tv4lp3
	ve8cD8pKgDp1pV2rtECJE6aa4oDzS5/JJeWwcgmh6DcKUij0/7YV8F80Es1jZHHZ6nYDbjgACCz
	P2kVbfGFMysGLidQpZsx/UJMmuDjJ5wrKFQsWTtwYKzsUjmAxH2hvvUDmVZcPtr8P+4zNQSYJ/w
	0ZelOu3Ry9OSnXZkhESanFKf86a+uXV+8Ik7a2OFL2+Orpz5WAaztsrQPYJiHtQSvZmyahcF8VR
	cQ7PuFYuw+6T+eq6oHiQ8jCUbNVHyMljU21UvVHDdZjRiOc8Dcd7THN/lcegxbqdul/fidOpeXJ
	OtYcq4Jy5UFyE0R43Q2KyNtLvIlfoOASOu4P1oYY93wT56l322fZNQh8/+y2Vr
X-Google-Smtp-Source: AGHT+IG44Sj8rkBnNNJIB4NO4CCMMHVuCGhj2JaWu6l839/BoQuyQjUilc5y4oEUHndmxI0MuGTd7Q==
X-Received: by 2002:a05:6820:818a:b0:657:56ba:7455 with SMTP id 006d021491bc7-65972623614mr3322771eaf.1.1764869713725;
        Thu, 04 Dec 2025 09:35:13 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4? ([2600:8803:e7e4:500:25f4:78dc:7b9e:e7a4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ec5b35csm1037150eaf.7.2025.12.04.09.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 09:35:13 -0800 (PST)
Message-ID: <c9efd563-9d52-4761-a5f1-be0df0222dff@baylibre.com>
Date: Thu, 4 Dec 2025 11:35:11 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] iio: health: max30102: Use cleanup.h for IIO
 locks
To: Kurt Borja <kuurtb@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Gwendal Grignou <gwendal@chromium.org>,
 Shrikant Raskar <raskar.shree97@gmail.com>,
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-5-b4a1fd639423@gmail.com>
 <f96694db-2ad5-46d3-a380-cba3eaa2de2f@baylibre.com>
 <DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DEPLIJFBZQ36.20XX5DCMCJVB3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/25 11:07 AM, Kurt Borja wrote:
> On Wed Dec 3, 2025 at 4:52 PM -05, David Lechner wrote:
>> On 12/3/25 1:18 PM, Kurt Borja wrote:

...

>> I would write the whole function like this:
>>
>> static int max30102_read_raw(struct iio_dev *indio_dev,
>> 			     struct iio_chan_spec const *chan,
>> 			     int *val, int *val2, long mask)
>> {
>> 	struct max30102_data *data = iio_priv(indio_dev);
>> 	int ret;
>>
>> 	switch (mask) {
>> 	case IIO_CHAN_INFO_RAW: {
>> 		/*
>> 		 * Temperature reading can only be acquired when not in
>> 		 * shutdown; leave shutdown briefly when buffer not running
>> 		 */
>> 		guard(iio_device_claim)(indio_dev);
> 
> AFAIK you can't guard() inside switch-case blocks. I don't know the
> exact reason, but it has to be scoped_guard().

You can. You just need the braces like I showed in my suggestion.

The reason is that guard() is declaring local variables and some
compilers like LLVM don't like declaring local variables in a
switch case. By adding the { } scope, the variables are limited
to that scope and the issue goes away.


