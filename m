Return-Path: <linux-iio+bounces-14968-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CFAA272B2
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E5A3A6A43
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80106212D70;
	Tue,  4 Feb 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axQdsfKS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12ED20CCD2;
	Tue,  4 Feb 2025 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673962; cv=none; b=W4WBp3MNfuwjeea97bO0hpGkWY1SkMxhMkLVhECLYCVFo7tfC0PWjIqxHsZUlXqBXB/czGLjNMhpfqDquA/pKfHC4zcUexWshwyxODplNffX8EKqHEJ7oC684B/aFLNkoi5Gu929VXxIwoCP4+9W2Ajsya2oTvfrxZ8G44A5Hd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673962; c=relaxed/simple;
	bh=3Hh2XQY/1a4amJk/a1M5JR3lj03KpXSUbkYezYOzE6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6lE96ZLEzhgNpp5+u1eLggeqeJYx+gER8AnqZyEikPAa6KBDyvGWCf8P+vbtXxCcAmCKg4j/WCCZXm6598fVa7osX7kC+iI54ahxF/X4/Oz9gPveHN8M2oS/AshH56K3Pwo6GZP33CnkL81P/EEN90YCpaEawflyjtqtseJh30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axQdsfKS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b1f05caso93121885ad.3;
        Tue, 04 Feb 2025 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673960; x=1739278760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLMswBPWS28FbLa5AdxCx/rsraoYZatSFNO8qcs8OEg=;
        b=axQdsfKSIxcLN1D5GzdMTpfcjwjhMsSSSfJbKJY4PZhVS3i/KiO8BHX5dHqnDnkvzP
         hOhOKt5wOh923HtWGVMPt6e+zd4wSHmBlbqn6uM2dfm5Sf8sYJlIQ7Os4BIDJ/q9WHqe
         KpVdEYal4PneACk3Q1MiD4q1/HNAKdkSwCZ7/bpBYv0SFnutWikz53Kq7d2H8rmrgqBD
         4X3mGNVFfRngYzDZi/tLXTCaJVGPRmVA3CBX8jIqSGaqZ4sWvF4RZfli+myfjst1q0fc
         QyOTIy12FXOPBWGynGEMoZOGDreo9zylZQF2R6T1EUqqsF2qitd4uIvHh0hYd6h+9SPL
         8EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673960; x=1739278760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLMswBPWS28FbLa5AdxCx/rsraoYZatSFNO8qcs8OEg=;
        b=ZA3uCGGnzk4jGZQm9WW9IpcKvt9ZFHNF1brZgItDhKsOIW+rRQ7YXwoCdsGV525uXW
         RZCWaVJhY2+g7OXp4ZYiopLzGIvJZM9cqYmMf40+IMmLLTWoXQTiH9Rm2/IIVf6atH7E
         HYhMW9Uc2MKJNA8LDADdPO5SmxJkxTCrzsvsyjiuWMzW2ym1SWyyR4KyhVeV5C6I5nvL
         RmNXwEtcUE9/ZODng0MRUtC/J/qJfyA3Gc28VGfjG+MuWukIOPMVDDx4vo6GK7Y93RIB
         F7vMZCkFUR0yt91rxVcyt+6t+grTr2ABFcndE0TEp6V97nxy7bfNPF0Dl+W36dKeEugd
         3vEA==
X-Forwarded-Encrypted: i=1; AJvYcCVKM7KL8S5Bug1XCXN4lIgyrCX+3ifUmFSDBZX7p6d2QyrxTzPsWp17JwQ2pgs3Q47d9yO8KWIXoZg=@vger.kernel.org, AJvYcCW0b5Fw7dL1e8l69MHUcdFV+X7p952azwJxm+eFR8tfcBCy47Uhi5mZe6zHk8NZgfma67vUNG4a82l62Lh8@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0p0w4nmISn1XktktCd+C4Z3G6Cp4q15dx/SWcPAz8AKjr77k
	lwFo5B+iafuw9X+Xe20gppkmLBuT6HJwgJdmXHKOortTi2fV0vgS
X-Gm-Gg: ASbGncuTbUkFFvqvS+6cWWN1qTuAcLxhcJ6kC7PEMS7K2F9CsKWfBIBtjDWvIqCRySR
	D+I7AD/JJ0tF7aJ9XLWb0JNyf3VdZOQxSfij67n3NezQGM0EOrZRbnV68jJgWxwC4c7uR+0DS7G
	Umg4VqDWoFGJg3drs/LURr9JXU4HcPRiiO/16F7TLYRTJBWEJJnKANW9u7VJxxtLj9N3Av959eA
	gwuxQcSqmI8K6sZzJWfagCjIlttfTGzGqoVb7dwxdQebnFqU9KgmDRQ2N/QFp7dfCMoTYwk8rsH
	BIHSPZ6obDc2EEEhSFp6Dp+ZIA==
X-Google-Smtp-Source: AGHT+IHE8gLhOia4qIQSjZxI3q0IKSbVDFXuuLhSdp/igsnknqxkocybARimRCyDA8YCk3dDP9vJWg==
X-Received: by 2002:a05:6a00:1986:b0:72f:d7ce:4ff8 with SMTP id d2e1a72fcca58-72fd7ce505fmr27940160b3a.22.1738673959764;
        Tue, 04 Feb 2025 04:59:19 -0800 (PST)
Received: from localhost ([2804:30c:4042:6b00:ec80:71ac:dccc:2753])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bec8sm10361101b3a.1.2025.02.04.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:59:19 -0800 (PST)
Date: Tue, 4 Feb 2025 10:00:03 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com,
	jic23@kernel.org, lars@metafoo.de, granquet@baylibre.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 3/3] Documentation: ABI: IIO: Re-add
 sysfs-bus-iio-adc-ad4130
Message-ID: <Z6IPU2rSg7M4lydK@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <0d73303f2bca3312ccf2abfeb2c654c228fa7f60.1738608986.git.marcelo.schmitt@analog.com>
 <322c34f8-a920-41d1-b77c-09537554ad04@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322c34f8-a920-41d1-b77c-09537554ad04@baylibre.com>

On 02/03, David Lechner wrote:
> On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> > The ad4130 driver exports in_voltageY-voltageZ_filter_mode and
> > in_voltage-voltage_filter_mode_available attributes to user space. A
> > previous patch merged the documentation for those attributes with the
> > documentation for filter_type/filter_type_available into sysfs-bus-iio.
> > Filter mode and filter type refer to the same feature which is the digital
> > filter applied over ADC samples. However, since datasheets use the term
> > `filter type` and ad4130 driver is the only one using filter_mode,
> > deprecate the filter_mode ABI in favor of filter_type and keep the docs
> > separate to avoid confusion and intricate attribute descriptions.
> > 
> 
> 
> > The digital filter helps shape the noise rejection bandwidth and is
> > supposed to be adjusted according to the signal of interest. Depending on
> > the particular ADC design, the digital filter configuration may have an
> > impact on the output data rate (ODR) (which is equivalent to the sampling
> > frequency for SAR ADCs - `sampling_frequency` ABI), 3dB cutoff frequency of
> > the filter (`_low_pass_3db_frequency` attributes), or settling time.
> > 
> > Digital filters are a common feature among sigma-delta ADCs and
> > IIO drivers set digital filters according to different attributes.
> > ad4130 and ad7779 filter options are supported through dedicated
> > filter_mode/filter_type attributes in sysfs.
> > ad7768-1 and ad7173 set the sinc filters according to the
> > sampling_frequency attribute. No filter_type attribute.
> > ad7124 sets the digital filter according to a filter_low_pass_3db_frequency
> > attribute so it doesn't export filter type attributes to user space.
> 
> These last two paragraphs seems a bit excessive and could be dropped.
> 
> > 
> > Fixes: 01bb12922b60 ("Documentation: ABI: added filter mode doc in sysfs-bus-iio")
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio       |  1 -
> >  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 20 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 21 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index ff9cc09360dc..e4fd99c92d81 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2277,7 +2277,6 @@ Description:
> >  		representing the sensor unique ID number.
> >  
> >  What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available
> > -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_mode_available
> 
> Instead of removing the line, I think we need to replace it with:
> 
> /sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_filter_type_available
> 
> (change mode to type)
> 
> This attribute is used in the previous patch.

Ah yes, good catch.
Will do. And will also reorder the patches so it gets documented before being used.

Thanks,
Marcelo

> 
> 
> >  KernelVersion:	6.1
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> With those changes...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

