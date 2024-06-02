Return-Path: <linux-iio+bounces-5654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D28D77AA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3A31F21540
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37757745EF;
	Sun,  2 Jun 2024 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACFuN8xF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985B74418;
	Sun,  2 Jun 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717358003; cv=none; b=iGfgY0EABkXbmUjG/6oB8LcDNL7MFNYIx2xRtTDo410kIO+2F310yC/351ctxcPdzRrIAdlpa7ZG8TURlcvBA9YQdsPyXAM7SbHnTybCwYCm5dY28oyiTY2uFQpK1SFBlAdPsmR5yQAOMNPq2f3Fek9MwK8JmMiVOiaNdHnXKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717358003; c=relaxed/simple;
	bh=CYY5A6G/VL2aE4c33pLR5Q4/47P7mhJn6prtJvanTdQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8vdg0BHXYE82vST+u2vMS5YbQHQoeqDLV/hgC2H7wgWm39UG8YKyJ8cpBOJw/IKinIFiECjM64PZ8r7lywFUw5RbLaEYOnBwc3jt86hx6iNBzZAbVCMH67/zizqgrDfV3c4uWkTSeDH/lXbzcVYw2cDB9bZNRCigMTJnDRfWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACFuN8xF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a4ea8058bso1176122a12.1;
        Sun, 02 Jun 2024 12:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717357999; x=1717962799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zywBRIwHMJzG8+KsIh69OEutro3/6BBZ2kza9TwS0IE=;
        b=ACFuN8xF0Lqo7bxqO13+qNUPvvTIMXRz2DuCyT9y7CHiDR9jIsmL4mNVpaWaj0fN6S
         O/parfTlPNxlZFSnWNBIgFk2mya6VesuxpxUeaosQ7U0vNDeHdXQi/aYoo5/aRAHupJl
         dkZSdMmArAuGZ/4UEYp3DsGZ76uQhZ7qd5DCsMHXzj7w8QCuvoRoE6x+a02cwmIBJGsW
         tQvfUu/caVkFPHDJAQOinkT3d23lM12VKDT2qFA21iYo525Nte3Ah6GmNDQ4e4mx5Tsn
         ZwDufO1TDnDxZQnC/q+ana8RsZvgwmTlk6isIBFdjivcRzcu7cFPP57nwkr20WLKrByg
         MvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717357999; x=1717962799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zywBRIwHMJzG8+KsIh69OEutro3/6BBZ2kza9TwS0IE=;
        b=mF5NUK214AxgPns9Dtci10pc2L5KabvK5C6J8IN8+oCOQt+ShpXUC1On5XK6caUofE
         p3hevnBvI7xFIj4Mdf3rWRIbbcqvRbMBGQ7uT0EJDh43BPQX+WLJrLF2nJ9Y7FlHVC6A
         rNQKtI/NHu7gb4rq28uCqX9XdTvLnJQC6bw0YHMGYM0yYnaMYU83IAC/mPpVpQi7QmAe
         CiWOcSRn+fuRXukMT/oF5Gz3hBuM1MjHFVNwM8eNwhK6NBfnaCS787iWrC4mUNfWpDmm
         uGMJnoEY1m0C0ZSMODlIpMEAke9nIv8q9v0UAyt+hrajgZXu6D1RiGW/tcJ8dAs2R1lz
         +bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDx3OMr+QXTnyx5lPv8Z812CzbTL3GSRp5i49Cei+du9VeX05EZ8kM2JPWBYPauz8GmNIgpNzwLV2hHrMGpnpYP6c0HQr3xEjVUkg5oCzhmIWRi+5YHSTM8wl1FdlkkbM6Dv23Oc3k
X-Gm-Message-State: AOJu0YyL2MZkJSGeEDZgQnwaRybGDsh9Sp/hrqfk5nARXCPzw/lIrS6x
	u4DAjD2m0t+L2XPGRUa/TXAvMvmNN0C8CJ/v960zUvixma2FuR6u
X-Google-Smtp-Source: AGHT+IHbDlzUD3w+gowcZ+M0aHXNmsSVRDhE2nSzStxg/VMqtj/sJw15jeedIMZ//DrBOP9ILTdVjw==
X-Received: by 2002:a50:ab03:0:b0:572:4702:2227 with SMTP id 4fb4d7f45d1cf-57a36450a5bmr4741579a12.35.1717357999483;
        Sun, 02 Jun 2024 12:53:19 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:add1:b1ad:7182:3e90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5ef86458sm922814a12.78.2024.06.02.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:53:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 2 Jun 2024 21:53:17 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 17/17] iio: chemical: bme680: Refactorize reading
 functions
Message-ID: <20240602195317.GG387181@vamoiridPC>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
 <20240527183805.311501-18-vassilisamir@gmail.com>
 <20240602140405.7d6a71d0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602140405.7d6a71d0@jic23-huawei>

On Sun, Jun 02, 2024 at 02:04:05PM +0100, Jonathan Cameron wrote:
> On Mon, 27 May 2024 20:38:05 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The reading of the pressure and humidity value, requires an update
> > of the t_fine variable which happens by reading the temperature
> > value.
> > 
> > So the bme680_read_{press/humid}() functions of the above sensors
> > are internally calling the equivalent bme680_read_temp() function
> > in order to update the t_fine value. By just looking at the code
> > this relation is a bit hidden and is not easy to understand why
> > those channels are not independent.
> > 
> > This commit tries to clear these thing a bit by splitting the
> > bme680_{read/compensate}_{temp/press/humid}() to the following:
> > 
> > i. bme680_read_{temp/press/humid}_adc(): read the raw value from
> > the sensor.
> > 
> > ii. bme680_calc_t_fine(): calculate the t_fine variable.
> > 
> > iii. bme680_get_t_fine(): get the t_fine variable.
> > 
> > iv. bme680_compensate_{temp/press/humid}(): compensate the adc
> > values and return the calculated value.
> > 
> > v. bme680_read_{temp/press/humid}(): combine calls of the
> > aforementioned functions to return the requested value.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> This and patches I didn't comment on (1-3, 6-9, 12, 15-17)
> all look good to me. 
> 
> Thanks,
> 
> Jonathan

Hi Jonathan,

Thank you very much for the quick and thorough review, it is
always extremely helpful. I will check a bit more on the
alignment thing internally in the I2C and SPI busses and I
will wait for your answer as well.

Cheers,
Vasilis

