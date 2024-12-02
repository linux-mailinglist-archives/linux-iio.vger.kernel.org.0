Return-Path: <linux-iio+bounces-12951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94689E0897
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 17:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5CABA1E64
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF537205E1A;
	Mon,  2 Dec 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDN0R1dT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18263205E18;
	Mon,  2 Dec 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151404; cv=none; b=s3LaMQLuqmbkCm5rgTwqSgIi8vZrfVhEIbQeNJ0+I43LyMcf0HUW0TV/+gm2dbuhCEmbd6LovuQ9gPYh4pJniQaCT3sb9MEUNCCzrbrdbbkO4zvDWK4rHPBBPg7QILZQvueGhWKk0S+RIlj8twGYpBbj1jhIeXXDt5SjBYUatb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151404; c=relaxed/simple;
	bh=Rdwzy6vHNgihlRT5BPotf+BGfF/xjXHKGqMg9A3o3Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtVfidXRBLUfXt0puKsL8n2LZFuMIB2fiQPRDEhX5/+Ik340GvE4WqLOZBTdTNm9v8NfiYhEfInxJvwKAqYFUY3ZRGOD/QnLuuxcLbauwXNAgq6T9zCYAt7lCgacrobWEotwj2YqwWrJ8w9faRPBnXy/r6QvK9U6Quvlugi36oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDN0R1dT; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d3e506981so1742282a34.1;
        Mon, 02 Dec 2024 06:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151402; x=1733756202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vq812pWWGRQ3G1kkOSCyU4FgoSqNPDkfuDdYU6oqqPg=;
        b=CDN0R1dT3G53uni9m7BLFp5vJNwo08we7WbCBHnUj71Ix7KlJqe1l9kkZlIcI/4s3b
         EV2Zc3EU2yUE6QSuNAogQr9CA84twhUYBl4qKxc4MW3tagJpn1R8eGBHvPVn6AvwIqW9
         21qgBeuINujkpKniXpxlVOG2aIxk6mnTFQc8V2jaM6na1f2AP+c3HjePjalgMAPNq+kr
         m8O41xgJ0aAWM5x25hWm2QHMKWWHQ0x7WzVBv7+MLb5CFWx26ZuH6eru7ZZNn/4VPd9W
         GhK6npM4VHK7xPelXdeilp1oF3Uv5V0SfPbFoMSS3ZkZqcn7sTsWwiltMhz+cv/ak/TC
         njTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151402; x=1733756202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vq812pWWGRQ3G1kkOSCyU4FgoSqNPDkfuDdYU6oqqPg=;
        b=Bo42bPW41J3VGGZmM6o03WWS9oMWyXeTZj0yCirH20aHtXlc8Nne7eBdlwfr3YINM4
         SwC6TeYVGwAi5R4vQUWioAO+mAN4Q1ejLbrr6j345V0vb/Hea64O/pFVPzfWZ8zw7xql
         2t4buENjupg+HpC9KGFdhvHFV2sBd+Yb67V+IhZlUbvr6UsHbuiWzCkGG5vsYzNZaoKh
         WvnSgyvTFrulgJrGOkFjQnOU4A/N91wyvrVju3Ip5O7oTeDbL+0cG9rkAvKQ76KSa0xr
         dLn7FfO1LFH47pEdSLtJXikCI8Km78NDDEr+x+lvfck1Z34HiyktIu4ZkVGWohRg1rS4
         vW9w==
X-Forwarded-Encrypted: i=1; AJvYcCUU9tcWSB9nLCgCenPTKMmQTQG0tBwrm04IOyyvmDz0C4/2OWHEGIfPDCY6QEDjzo0vzWBLEN11f0hF@vger.kernel.org, AJvYcCWdkZuMqqQaYlA4wHi+mPqdV8wAy/hM1IpfzQRii1eiiSBWoNJrgHVg2tB28veMkAXTCYSHLLrCWKittNmE@vger.kernel.org, AJvYcCX9e+JarDQHj3iGI2k4KwwxFnwaT5SLXL/uPKo4MHTCS1lRqEtvKF92QxtRwObEg7SCt88hQghGDBA5@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnc/qEnt6nO7nx8NPCYZjvBYWVV6UlGMXO/ouE1zOWqjd2HjI
	qFNQFO/U4k9E8f+ldH+rSomhNjudWl72cAf5jr/ARLBafNynKmeR
X-Gm-Gg: ASbGncviAJMQ5g51i3E2BhaHi08VieA2yCftIUFkhsXBFOrpIGlBrcNAyZJQxRAq31+
	jF1hQn9M0e1GwwqP4xEKa7k4ucvufrjEtTlbT/i49AHTEQSbaLVCq9Pq6PIlFhg4AFgFeI4MTgF
	2vhny/pM1z2vt+ONzp1VEDOULtyd8jAxLoZYAlayH1Yv3gztPfcTC17vimwVQkoVxa1aVNqgj6Z
	c7/VzyXPayIuMCZUOtzBDNCN1sIAW9K/JlIRCm77MOJlUZRrBQXTumgtGdlWD8=
X-Google-Smtp-Source: AGHT+IHXpSHOGKQ+h5TeoRVyNle86vfvvoWeT8dxmfjolFtZTKCjYhSttXDb+54xLUUhMLEHjkoz7w==
X-Received: by 2002:a05:6830:6516:b0:71d:5b20:8f9a with SMTP id 46e09a7af769-71d65cfb504mr18227782a34.23.1733151402024;
        Mon, 02 Dec 2024 06:56:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c3034c8sm7851560a12.31.2024.12.02.06.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:56:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Dec 2024 06:56:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ming Yu <a0282524688@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, tmyu0@nuvoton.com, lars@metafoo.de,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cmo@melexis.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 0/2] Add Nuvoton NCT7718W IIO driver
Message-ID: <6867cd67-9ab9-4a5c-902a-e2d14b846c51@roeck-us.net>
References: <20241126074005.546447-1-tmyu0@nuvoton.com>
 <20241130202849.13eedb04@jic23-huawei>
 <CAOoeyxUyi_HKLH64Sokd9YU9vDnuizBaP2AOUYqQ8hTvJKo2-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOoeyxUyi_HKLH64Sokd9YU9vDnuizBaP2AOUYqQ8hTvJKo2-g@mail.gmail.com>

On Mon, Dec 02, 2024 at 05:22:52PM +0800, Ming Yu wrote:
> Dear Jonathan,
> 
> Thank you for your reply, I'll move the driver to HWMON.

AFAICS the chip is compatible to lm90, so please add support for
it to the lm90 driver. Note that this also applies to NCT7717, which
looks like an internal-sensor-only version of the same chip.

> Additionally, for conventional ADC, Thermal sensor, and tachometer
> like chips, would it be more appropriate to implement them in HWMON?
> 

Thermal sensor and tachometer, yes. For ADC it depends on the use case.
If the ADC is used for hardware monitoring (which is typically the case
if it has limit and alert support), yes. If it is a pure ADC, IIO
is a better place.

Thanks,
Guenter

