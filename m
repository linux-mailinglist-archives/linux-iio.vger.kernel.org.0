Return-Path: <linux-iio+bounces-5144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D08C9E6B
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 15:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A222B21CB2
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B416136673;
	Mon, 20 May 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KPmvrE07"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93661FC0E
	for <linux-iio@vger.kernel.org>; Mon, 20 May 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716213120; cv=none; b=cKgC11UdQLhWYDLV9BqoRoRF9nhppagpYvK0lLjeU1JXNbNt+fKtXMEo5h85s+ikj6hajtXRW0tq2J6lFn611+ZWftI9dUotdO2maMYIxZyi4b4nXNKlDjMrOjquK6tIhQDdahWQbP6GJ9z3TB0tmIQvOgxPdkm2auvtPs8r8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716213120; c=relaxed/simple;
	bh=NTsRMbb5iWNBU8od9S2Jd/KrHPBQGWlCUbGymF1Fw3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLjd80XhZqTWJDaSL6e1We+EdwiLZyGj7Zaohr84J3qHzffEaX+JOxpKKhv6qaexJDh6o9pIo7wvS6EcQxBnw6rXgeLoEU+5QSG9LGaIL+SAlvW+cOEoU4xFW31N0z9AxVukjgidgDmaaaKhJVlP8+7dK7znPVqzhm+cWDNtT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KPmvrE07; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9cc681ee0so1301909b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 20 May 2024 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716213115; x=1716817915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rt+swezO2XoZgidBhPae8eGHxrp7XZ2iue6hZ5iS2g8=;
        b=KPmvrE07fAv9Z9TcPuCIR1KewqCG73z8bimdlgXDrFxlDVFUUVm8o40gAGwaaIUw+f
         kCojKzvf9VEFcpKoXdwfe564jP6SsMXBGinWC/lTC+qkJgCBvKAs/I2bIu5cY28KRD70
         xQorhuNzMAK1KYf3wQDh1s0XirkGyk6izW9C3PlIvCpCI7GozFmu+IOwPjYoW7SeoXsA
         +eOcChZRgSRghVDDuXZjjPO0cBFk/rozicr5cMEFUXKdaT0euy4xxR7c0UwCuYTlWw/F
         +0KNULX8YDtw9tVNU78nlcj0mrfsopkiWw9MHUtpHK1k1JeeR9P0LoKiTc/XwXU/aT/y
         sxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716213115; x=1716817915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt+swezO2XoZgidBhPae8eGHxrp7XZ2iue6hZ5iS2g8=;
        b=nb2gsEgAS4nB5DAeVpQtXMdaJsf8eGeXjvZiy4JleqQXZFbyvhZSUFqD4kAbCRPa49
         xVCBh425t5sRH4Natf0EU7eon7yvHr9Ek8pA2kQ7XshaB6D5pBKTq3JMVTEmOKhDVxHB
         KViWJ5vtPYevv4a94WwWALW569KByeAqHml34+FBXVVe2kTUSew1T5ON61aAQhmAIqOu
         HZBeLg6VvsAz+iYWrmbOyar8kKQneY+TdAQFv3ls+iFohVZcZ8apJoWhDij+FR322KWF
         GdlbT19HXjMEas8mQhhL70UdCDlYKczBGRLZXcWSKFNkjRqfpFMh4C77It4QvaLibP+p
         rzuA==
X-Forwarded-Encrypted: i=1; AJvYcCWE08JriGmqZ/veq1kY2Mp+P0gXliffqp5/E8Jous1JumiA7scL2qUPGmeZQaZdC44t3rJd2tnv7nJvbH98nqLIudZAjqXbqCxH
X-Gm-Message-State: AOJu0YwgX6cPKcoqtFQViOmqAQ13V7ZMffDrtr+qHiFwwZUUx9ktfTtp
	y+Uk0qddHYir2X4Y4CTzNNSaRzQRskiX65hBOxk8iL9v1xe+O8NqQ5Ld6bYRS2Q=
X-Google-Smtp-Source: AGHT+IFU10m32Gb2xWok1B4/mtfFUidep2XTvahd+Xb9OopS6qpAPhoM94gSqMsEhEtiYhFACB28PA==
X-Received: by 2002:a05:6808:150c:b0:3c9:d118:4b4b with SMTP id 5614622812f47-3c9d1184ecbmr9504987b6e.15.1716213114222;
        Mon, 20 May 2024 06:51:54 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9c8260c0esm1349499b6e.58.2024.05.20.06.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:51:53 -0700 (PDT)
Message-ID: <ebf18ed1-a82f-4c0a-9a63-2c428b5aee40@baylibre.com>
Date: Mon, 20 May 2024 08:51:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] iio: add support for multiple scan types per
 channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Julien Stephan <jstephan@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240507-iio-add-support-for-multiple-scan-types-v1-0-95ac33ee51e9@baylibre.com>
 <20240507-iio-add-support-for-multiple-scan-types-v1-3-95ac33ee51e9@baylibre.com>
 <20240519201241.7c60abac@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240519201241.7c60abac@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/19/24 2:12 PM, Jonathan Cameron wrote:
> On Tue,  7 May 2024 14:02:07 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> This adds new fields to the iio_channel structure to support multiple
>> scan types per channel. This is useful for devices that support multiple
>> resolution modes or other modes that require different data formats of
>> the raw data.
>>
>> To make use of this, drivers can still use the old scan_type field for
>> the "default" scan type and use the new scan_type_ext field for any
>> additional scan types.
> 
> Comment inline says that you should commit scan_type if scan_type_ext
> is provided.  That makes sense to me rather that a default no one reads.
> 
> The example that follows in patch 4 uses both the scan_type and
> the scan_type_ext which is even more confusing.
> 
>> And they must implement the new callback
>> get_current_scan_type() to return the current scan type based on the
>> current state of the device.
>>
>> The buffer code is the only code in the IIO core code that is using the
>> scan_type field. This patch updates the buffer code to use the new
>> iio_channel_validate_scan_type() function to ensure it is returning the
>> correct scan type for the current state of the device when reading the
>> sysfs attributes. The buffer validation code is also update to validate
>> any additional scan types that are set in the scan_type_ext field. Part
>> of that code is refactored to a new function to avoid duplication.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
> 
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 19de573a944a..66f0b4c68f53 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -205,6 +205,9 @@ struct iio_scan_type {
>>   * @scan_index:		Monotonic index to give ordering in scans when read
>>   *			from a buffer.
>>   * @scan_type:		struct describing the scan type
>> + * @ext_scan_type:	Used in rare cases where there is more than one scan
>> + *			format for a channel. When this is used, omit scan_type.
> 
> Here is the disagreement with the patch description.
> 
>> + * @num_ext_scan_type:	Number of elements in ext_scan_type.
>>   * @info_mask_separate: What information is to be exported that is specific to
>>   *			this channel.
>>   * @info_mask_separate_available: What availability information is to be
>> @@ -256,6 +259,8 @@ struct iio_chan_spec {
>>  	unsigned long		address;
>>  	int			scan_index;
>>  	struct iio_scan_type scan_type;
>> +	const struct iio_scan_type *ext_scan_type;
>> +	unsigned int		num_ext_scan_type;
> 
> Let's make it explicit that you can't do both.
> 
> 	union {
> 		struct iio_scan_type scan_type;
> 		struct {
> 			const struct iio_scan_type *ext_scan_type;
> 			unsigned int num_ext_scan_type;
> 		};
> 	};
> should work for that I think.
> 
> However this is I think only used for validation. If that's the case
> do we care about values not in use?  Can we move the validation to
> be runtime if the get_current_scan_type() callback is used.

I like the suggestion of the union to use one or the other. But I'm not
sure I understand the comments about validation.

If you are referring to iio_channel_validate_scan_type(), it only checks
for programmer error of realbits > storagebits, so it seems better to
keep it where it is to fail as early as possible.

> 
> 
>>  	long			info_mask_separate;
>>  	long			info_mask_separate_available;
>>  	long			info_mask_shared_by_type;
>> @@ -435,6 +440,9 @@ struct iio_trigger; /* forward declaration */
>>   *			for better event identification.
>>   * @validate_trigger:	function to validate the trigger when the
>>   *			current trigger gets changed.
>> + * @get_current_scan_type: must be implemented by drivers that use ext_scan_type
>> + *			in the channel spec to return the currently active scan
>> + *			type based on the current state of the device.
>>   * @update_scan_mode:	function to configure device and scan buffer when
>>   *			channels have changed
>>   * @debugfs_reg_access:	function to read or write register value of device
>> @@ -519,6 +527,9 @@ struct iio_info {
>>  
>>  	int (*validate_trigger)(struct iio_dev *indio_dev,
>>  				struct iio_trigger *trig);
>> +	const struct iio_scan_type *(*get_current_scan_type)(
>> +					const struct iio_dev *indio_dev,
>> +					const struct iio_chan_spec *chan);
>>  	int (*update_scan_mode)(struct iio_dev *indio_dev,
>>  				const unsigned long *scan_mask);
>>  	int (*debugfs_reg_access)(struct iio_dev *indio_dev,
>> @@ -804,6 +815,28 @@ static inline bool iio_read_acpi_mount_matrix(struct device *dev,
>>  }
>>  #endif
>>  
>> +/**
>> + * iio_get_current_scan_type - Get the current scan type for a channel
>> + * @indio_dev:	the IIO device to get the scan type for
>> + * @chan:	the channel to get the scan type for
>> + *
>> + * Most devices only have one scan type per channel and can just access it
>> + * directly without calling this function. Core IIO code and drivers that
>> + * implement ext_scan_type in the channel spec should use this function to
>> + * get the current scan type for a channel.
>> + *
>> + * Returns: the current scan type for the channel
>> + */
>> +static inline const struct iio_scan_type *iio_get_current_scan_type(
>> +					const struct iio_dev *indio_dev,
>> +					const struct iio_chan_spec *chan)
>> +{
>> +	if (indio_dev->info->get_current_scan_type)
>> +		return indio_dev->info->get_current_scan_type(indio_dev, chan);
>> +
>> +	return &chan->scan_type;
>> +}
>> +
>>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals);
>>  
>>  int iio_str_to_fixpoint(const char *str, int fract_mult, int *integer,
>>
> 


