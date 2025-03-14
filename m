Return-Path: <linux-iio+bounces-16856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 517E3A61824
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 18:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E8B880E1D
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B252066F3;
	Fri, 14 Mar 2025 17:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrCiburC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164782063FF;
	Fri, 14 Mar 2025 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973694; cv=none; b=SY9QIq+kAUtKzItMXy341ZN+sEa+IK3jRLn+rn3iHhCpziujn1vgQTpVG9RO6zurLVsR+bxVFK87pZ0N5QcT5Tkfp2DhLNULtl75WVqtwwvgckwJi3+VRqlTwAAfE9h+sqELIJ34tfbgmESYMEsfs+JkXKWT11saqD+FvTh8dtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973694; c=relaxed/simple;
	bh=3dqWiYds4otSifOzUdJHgMUDOfl0bH37/f/mkbsUst8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5oF9JqASJ1aPC7DUmA0oVA2P8ivtUJn1lsZgGDAptle3vh5/wjfgP/oFkzwTj4zRycNsdLnXaCvKzMILbah+xz3q84Gmenubvodigtxnclc+m4rvZqouxWijQrCIc3wad6qKyIdghQvdVqjY7pvjquV/p5IYjbuuhTEkr+CVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrCiburC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso412944466b.2;
        Fri, 14 Mar 2025 10:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741973690; x=1742578490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMKegtIsjHp0vMy8cfsnzA/BzG0rC3QpG6n6TIAdO+0=;
        b=KrCiburCLz6I3TR3U4wInOj9wkXG5g5nH0PTyOzUoglHqIothSvRiKzh/rdrP39kgZ
         mfoVHawU0HOjhlTjqcBwNY7YxPW9qlwcMsnSJxnvHO781x53tzRLrbEypQyYQp5Cn7TX
         HtTGox/1GwMPNQNeMAqfgC0QwHyAwW1DIHDIHdppv8fUmuvAzv9yqnPvzgQvZn9/8JZ1
         K7+MCIrLcxHN/ksVGLEEgcc29tS3Fnl1cgzbqXQY5nVuEBm+ZfFMcYm7qFdCEw8qAuPB
         sFCoJYPgyp3dOt+wgdjtGnjPR7/i5+GXMqoZziSpGUvc1IYJT4VvmYvPmmOmulZbNjO4
         yYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741973690; x=1742578490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMKegtIsjHp0vMy8cfsnzA/BzG0rC3QpG6n6TIAdO+0=;
        b=Fe8c9YXjQe8qwhx0mt9xpc614BzyJIuD6FX1K+Ea6wfyUMmG9s0GnNx3p8nB1wxtiA
         sI9vFDXLDRyctp7KQzmKnVsqx1WRoX2CxRZSMRw7W0F1cKtcFy+krgHI9ZMqwwYkrxhE
         YqSKCRt/B9J0hi3LSW+0y0oBWjOCDSRYGb2abHwgN7X9w9X/W01Mg1WhU0dgHDNEPDSy
         9bk/D4Vd2683oZYvE9bgmUisswKW4T2pYWitbRTgdYHDgWocUcrt8rHDttou9IOdFyKK
         C4ssLAiUyHviz+JjDy7Y7B+CVEpm4kjpSfL8Ip9+iPd0BuDsQFouG5osXFIqcu1LKUSz
         DM+A==
X-Forwarded-Encrypted: i=1; AJvYcCUN/RzS9MjaHXgS4SesrUHz9L3MUe2Dn/MRtSsG1x+T/ZOZCbwe2jT3Mcv1Xb1gyWAKJ+LgHh1xqx1X@vger.kernel.org, AJvYcCVg6281K/+A1X+U0M17ZDlRShcy0XEqnbbOhJRIriD0rVw0u2agANCdjbDsSziQ4cwRYuisn8VrQSku@vger.kernel.org, AJvYcCVhwzwDd47K5cUquDmkS9tizx4Swj7bBMSijpQr/qDCqo8VO5/ZfdG6i2vpiJRaPIhHp9gApsnCYIuYAnbK@vger.kernel.org, AJvYcCWjXoVlZQf55+ZXB1fEc9SzWAr+AOHYxcADkFXEI0TpstcYeM6QGbq9x5wG0+BtELivLIaZKLutuhle@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0s0IAOxFTWsWB21BZ2t8qgWzbNntOPNlKW6JZp8FsATzX9ym
	g3//K9om1ue8ciY/EvoyU66lfCkAcJPuqVYAtBKQzvTXGmKNUFBVBQ14uoEzC1AjhA==
X-Gm-Gg: ASbGncscsX2VrRWMo4KRAUj9DxiUrOD+26UFp+sYOl/vJsij247RL6NbGK1d6hhz0x7
	M/eACF5mGU2UjU0iWiFdl3Cwvuz+2k3c9xweqRsaWtAKTsd6r33S4LMbOOka7ERoOlz/MOG94w7
	fh8SqufVCHYPNu4zNp6GpHx+xom1m1xltA41RmFlRwOFYYr4SD7fYO2FzZFLpUDiqvQLBwE0a/H
	TecvqFoPiMBAlNWaMby9D+HNbHJtiUArQuczcC1H9w7E9XYQLcUU2Z8JtRd1c9ApUY5saknt4Ew
	AcWtt5iCk0LL2yLK7hxfB/wvGPpUYl74icQ66S6kmr7MdH15PzOlFeHic95LLZKa
X-Google-Smtp-Source: AGHT+IGb3XQCLdGuMRV9Yf73kXWw73/eQkbBSYamv8cSuoMzz+eghzAI42S6vGENftjgTqAmwmTKTg==
X-Received: by 2002:a17:907:d92:b0:ac2:3ea:c23c with SMTP id a640c23a62f3a-ac330126e15mr442457666b.5.1741973689841;
        Fri, 14 Mar 2025 10:34:49 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb24sm251618766b.9.2025.03.14.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 10:34:49 -0700 (PDT)
Date: Fri, 14 Mar 2025 18:34:46 +0100
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/4] docs: iio: new docs for ad4052 driver
Message-ID: <27kqar3ugxjzwss7hzxil2hz3kxaunnkpaaas3nnzemhssf6mo@65xknov7jh7k>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
 <20250306-iio-driver-ad4052-v1-3-2badad30116c@analog.com>
 <CAMknhBFiZZUtCkTjQ=AVSgwqe=wCkMnqAmaTqvW_X6fm1OKuYA@mail.gmail.com>
 <e3p2r2fet2spkrxv7x76gunlivrp3vng22wktz4fkww5nkckt7@jpgne4uerr3c>
 <6ca1eafd-276d-421b-8d35-bd3e363803d1@baylibre.com>
 <20250310195629.47ca023f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310195629.47ca023f@jic23-huawei>

On Mon, Mar 10, 2025 at 07:56:29PM +0000, Jonathan Cameron wrote:
> On Mon, 10 Mar 2025 09:31:45 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > On 3/9/25 3:49 PM, Jorge Marques wrote:
> > >>> +   * - ``sample_rate``
> > >>> +     - Device internal sample rate used in the burst averaging mode.
> > >>> +   * - ``sample_rate_available``
> > >>> +     - List of available sample rates.  
> > >>
> > >> Why not using the standard sampling_frequency[_available] attributes?  
> > > Because sampling_frequency is the sampling frequency for the pwm trigger
> > > during buffer readings.
> > > sample_rate is the internal device clock used during monitor and burst
> > > averaging modes.  
> > 
> > I haven't done a chips with a monitor mode yet where we aren't reading
> > the samples, so hopefully Jonathan will chime in here on the usual way
> > to handle that.
> > 
> > For the burst averaging mode, I understand the need for a separate attribute
> > now. I would suggest to call this the conversion_frequency rather than
> > sampling_rate since IIO already defines "sampling" to be the data read
> > from the chip to Linux even if it is an averaged value, it still counts
> > as one sample.
> 
> I should have read on.  I'd like this more closely associated with oversampling.
> As per other reply we use sampling_frequency in the events directory for
> the monitoring frequency case.  One of our very first drivers did this
> (max1363) so it's been in the ABI a long time!
> 

I get the idea but maybe the datasheet sample rate as conversion_frequency
and stored as a channel attribute (iio_chan_spec.ext_info) is clear enough.

The datasheet sample rate affects both the burst averaging mode (oversampling) and
monitor mode (threshold events).

The max1363 stores as an event attribute (iio_info.event_attr) and requires iio/sysfs.h include.
A last option is to store as a general purpose device attribute (iio_info.attrs).
As a channel attribute, the driver logic is slightly simpler by using the macros.

Jorge

