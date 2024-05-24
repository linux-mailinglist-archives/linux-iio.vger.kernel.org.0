Return-Path: <linux-iio+bounces-5249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EA8CE202
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AEF1F2282E
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC701292E4;
	Fri, 24 May 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih6yKeUp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAD17578;
	Fri, 24 May 2024 08:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538194; cv=none; b=oJyqApwQyuIQrorMdnxc4iryETqlvYjpgFZAx+Jcq/l+6AlIC6ZwWk5vWsGEMqmFwrXEpfI71LgFNMsljgiUqyUFIYG8JILCWlqe69sbVrZpT8ojIXXBHPc9OCD2j+4e1MPHYuKfpzYo3Fm5tKoyGb14hJjCmHtdLw3Kp7mmbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538194; c=relaxed/simple;
	bh=IYoee1FMSOG0vcSBxpfqmaB1YmFYngFTvOE+LzRYYrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUXie78zLjqAwstWhq2g2wPo1Xp0L32AD5TbnLpQMTW8jBrokCwD1F9hFuZK60+v3EU/H/4Ne1LbwwQ8pDnCRZPUGcMqlXy8+zQ0QOWEtGj7gNvi4gTIjnMZqKf5DSDRQ9JzkT5vSyZdC6PV5dLTu4YOjIRcYqfx5nXaB7mUj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih6yKeUp; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a61b70394c0so627730366b.1;
        Fri, 24 May 2024 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538191; x=1717142991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yIHQCHYwlijZ4SpXyonBPl2dHneQaT20En64+i282k=;
        b=ih6yKeUpPupE+dey+V0DtDmEDYzmZdLlftyuS3m8NWnQmaSLFaJo3QgnUv0By6Anv/
         bawpQq0Jvm1qlVmLFLcI2M374WU8z+Vl+erLS1KUbyCxe6EjSBIlsEwU/gFRwu5qSyce
         HHgrU0ihvWsaYFRX8n46br4MzZU4TsbJ13QkfCtxiWpNtD/OvVBMkIR4VHyGybay62XL
         g8oFE2s1wc6vNH6IIKHu7NDXR7rXt0wabZf10A+Dhm4/sP8b9N50YtCC2YegOA1wRw0x
         8abKkBa5E7zNF5n0bCMhlXphJLc/F/qn+KkNK71p8A/h+CLDyZyff6nz5d8PHWp3s69L
         hrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538191; x=1717142991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yIHQCHYwlijZ4SpXyonBPl2dHneQaT20En64+i282k=;
        b=lzcqOY6liDaUVodxGzh5PvG5j9Gzo5sMlkw60/gviDzecKMBACSnUWLOuRsRvMoJkm
         4u77Poo+tYspqVAWq0XKy0l3qKLVy7RqoCfWPejvECXMivWLwkoxUumkBF1MLCm6Hm5O
         5M1H4k38f5P4eth415Lv1a+7lHAca5SG7dka5qd4qT2fXmVWSENGJ5E+yjImLSz0R1uo
         lXOaxGsbkOdIazlTXa3aO/VisqDMZFD5Gva8/lUyx1m2NIYxaMamXTcnZPx2OhH91G27
         aRa7qpKtpVM8VrQgl1huWuuFAHQNbZyF3ufG+5hi5Lo1QrfhUXWzjYP86xOhh6P06QCU
         Lcjg==
X-Forwarded-Encrypted: i=1; AJvYcCV9cV2F77/TOQ1jcuuDH4HBJSJbVrChghv5X3RELoVJOsXch5+U/Owqcqc2rzLe5s7zlq/61NJ78ilPYc27381Vxl4CEjBXEd1X3RJFraSY/6Z7K4qnrXSQjARt2PuVe1eCTyOCqjet
X-Gm-Message-State: AOJu0YynA6ZJsdkGaUgszbDRvVAM5wafzPJuIJZmkUumt5WeA+MwQOyK
	nv3SJAOMK68vPft4mtq0hOjNh2XepzqUiZ35GGXnXior6WRqEYFf
X-Google-Smtp-Source: AGHT+IEgFSaePBsGjk079z7djjCvU1PWaX4waBvA+zagqtvTUKbIzVsiwpBD6ooLXwpMQBQhRUBVSw==
X-Received: by 2002:a17:906:605:b0:a5a:8b64:df00 with SMTP id a640c23a62f3a-a62641dfde4mr93034666b.28.1716538191130;
        Fri, 24 May 2024 01:09:51 -0700 (PDT)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817b15sm91382266b.40.2024.05.24.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:09:50 -0700 (PDT)
Date: Fri, 24 May 2024 10:09:48 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: fix hysteresis representation
Message-ID: <20240524080948.GA560140@debian>
References: <20240523114336.532428-1-dima.fedrau@gmail.com>
 <cef810ee-bb2c-4588-baec-7edfc74daeea@gmail.com>
 <20240523142849.GA558466@debian>
 <17adc0d0-55c1-4608-a4c0-93f9911296f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17adc0d0-55c1-4608-a4c0-93f9911296f8@gmail.com>

Am Thu, May 23, 2024 at 05:45:34PM +0200 schrieb Javier Carrasco:
> On 23/05/2024 16:28, Dimitri Fedrau wrote:
> > Am Thu, May 23, 2024 at 04:12:37PM +0200 schrieb Javier Carrasco:
> >> Hi Dimitri, a few comments inline.
> >>
> >> On 23/05/2024 13:43, Dimitri Fedrau wrote:
> >>> According to the ABI docs hysteresis values are represented as offsets to
> >>> threshold values. Current implementation represents hysteresis values as
> >>> absolute values which is wrong. Nevertheless the device stores them as
> >>> absolute values and the datasheet refers to them as clear thresholds. Fix
> >>> the reading and writing of hysteresis values by including thresholds into
> >>> calculations.
> >>>
> >>> Fixes: 3ad0e7e5f0cb ("iio: humidity: hdc3020: add threshold events support")
> >>> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> >>> ---
> >>>
> >>> Since absolute values are used on the device, the hysteresis values are
> >>> influenced by setting thresholds. Is this behavior in line with the ABI docs ?
> >>> It can be fixed by readjusting the threshold clear value whenever setting
> >>> thresholds to have the same hysteresis value as before. See some example below:
> >>>
> >>> # echo 25 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> >>> 24.727626459
> >>> # echo 5 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> >>> 5.127031357
> >>> # echo 35 > /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_value
> >>> # cat /sys/bus/iio/devices/iio\:device0/events/in_temp_thresh_rising_hysteresis
> >>> 15.381094071
> >>>
> 
> > Hi Javier,
> > 
> > thanks for reviewing so quickly. Do you think I should correct the clear
> > threshold values once I changed the threshold. I have an example
> > provided where I set the threshold and hysteresis. After setting the
> > threshold again the hysteresis value also changes.
> > 
> > Dimitri
> 
> I am not sure if I got that right. Did the rising hysteresis change its
> value automatically from ~5 to ~15 by just adding 10 to the threshold?
> If we are treating the hysteresis as an offset, then it should not
> change its value i.e. it should keep the configured value.
>
> Best regards,
> Javier Carrasco

You got it right and I also think that the hysteresis value should keep
the configured value. The doc states that the hysteresis is represented
as offset to the threshold, but I didn't find anything related to the
changing hysteresis value. Propably because most devices implement the
hysteresis value as offset !? Would change this behavior in the next
version of the patch if Jonathan agrees.

Thanks again for taking time to review.

Dimitri

