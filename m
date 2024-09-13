Return-Path: <linux-iio+bounces-9526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD67978C01
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 01:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E19287D12
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 23:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71F18893D;
	Fri, 13 Sep 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6y+IHnZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9517CA19;
	Fri, 13 Sep 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271927; cv=none; b=GMzAF+mKJ4sBd74pPa+q+PlmZf/dYBR8zlqtXJdmBqd7fMcYNJKAkNqsEsdEIGV0dPv8sK9eJVbBgTZamXBAYo/4tsFmlVMUKMBJb4SnTXccFiQn/nmrnnV8cedY0p4d54KMwdXahHioexLKsY1uRvIBtPcsSZVloZ28UIOHbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271927; c=relaxed/simple;
	bh=t1kBUvvfAyBSEJqy6ISe01TikB0sm7vvU/LfFcfX58s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/RuNpsigwXSlFQXVCkW03j0rf4Qj1w+Fl1431KYgfcYT2TmTK7jrBTXkI1A+L1F9WVrLKUMEihmFuNBCw5g9CHUMN+gSmEBBT220E3fqTN5JuiTUhlepn8H+EIjpDMRx7fYHr7nbRemTTntoJLWV7nj0rtOIWJ6b8UNmXEzfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6y+IHnZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so24808625e9.0;
        Fri, 13 Sep 2024 16:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726271924; x=1726876724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r+Uo9CZ+/vWr76G0BdqpOSgPTj8l9thCWDLiz+ayKMY=;
        b=g6y+IHnZKSJwVOxbs7t2KHamAjfj7MoOaCP4bPBr7m8r85bFznq/BKjgA5d2/JkpbO
         XTcrs8qMj7rN/eDBx6cGjF530g7hoDISjBMkRfW6jGgWSfdjx9J5kUBl/3uVDuXIZxiu
         LwOP3UbSujicE3wgwuQdJuP+Zji5KJz0gEQl00T/wQwGXMCI5w4Vp0jS2dMHlLswuXwf
         5NKw+XoDZC40p1rLRopO76Dj1WfG45fvsUCu8svsUw8Aa/b07eeZmGz4tln1nFbiyX08
         Q46GDhqM2XD72wCR/JZgW2mdPSET1zvc6iYZd8T9XC2DDGCORzN4/a5UMp1MtpTeWeS1
         +JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271924; x=1726876724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+Uo9CZ+/vWr76G0BdqpOSgPTj8l9thCWDLiz+ayKMY=;
        b=S5UEDeL29kH33X6IWamd+q8ZqodFUYjLxP36nf8D/Uh+aa8rW4+NUSd5fHnJ+VfnkR
         cQRdk7wP4tekHIJW8GOzQs2f1RS2VCIucYU9N4nasgSCZVzjhMeCmCKt5YQHaQbYzbM/
         IbJ7UYMerjJyvReHRM0yA9CEAGE0haOiN1tyVoza4k7IUllOCtB+UPFumgwss8eDCQEq
         n5gy187yCtXs4JU1rDAbA4FP27ef99NNPIRWb7bl6zKOGwsZzg3NE0ZcIzMVDxo71J8/
         CIupZfm3DJ/qaZWOkRDq/VzAg7TaLPNSLjl2C5zJWCFN6wHcucvyo+930hRIvhurk92h
         lMLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnxVrnsSaMN9PfNXs1L60sUEs4EO1XRA4uNwagEXGQ1NBUh5amC7MYuOsAnY3LDWOjsO822Kc1LvnD@vger.kernel.org, AJvYcCVBvxsVZXgsO20St812epK5Ikxi1IK5Iif0lfZDOlm/Dmww5Zn0EbMVH7z976KC5SNUUYYewhGhaWBq@vger.kernel.org, AJvYcCW4bmXkO+e5Wq4tyqMkymPYS5N8+u8t3rhqj1Z1EmubGNf6jJC5Y3HY8toeyQWNqTvry3IxfpQiy+3hlXbZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLoByllYpETtqTG4xs/jVEMxQHILDYi75hQ9WFSg+TUQJTSyMn
	Ss931BEzOxf0XwuxZ1GIbCakKvVmd8hhbOnkUAcyidBsWadnK32E
X-Google-Smtp-Source: AGHT+IHTOKPj1k9m5Ti8Vddyk9GlaX0+XkbHG41xc76RPoB6x/CX92bA3gKJiVV+RxQF4FGuXsDOkA==
X-Received: by 2002:a05:600c:3b13:b0:42c:b961:c902 with SMTP id 5b1f17b1804b1-42cdb522ce4mr56954355e9.12.1726271923434;
        Fri, 13 Sep 2024 16:58:43 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:6bd1:9a24:6b02:4a8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b15c1d5sm38293285e9.21.2024.09.13.16.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:58:43 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 14 Sep 2024 01:58:41 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v6 1/4] iio: pressure: bmp280: Use sleep and forced mode
 for oneshot captures
Message-ID: <20240913235841.GB33362@vamoiridPC>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
 <20240912233234.45519-2-vassilisamir@gmail.com>
 <ZuQLOwjQUTjo1nPg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQLOwjQUTjo1nPg@smile.fi.intel.com>

On Fri, Sep 13, 2024 at 12:51:55PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 13, 2024 at 01:32:31AM +0200, Vasileios Amoiridis wrote:
> > Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
> > Sensors BMP18x and BMP085 are old and do not support this feature so
> > their operation is not affected at all.
> > 
> > Essentially, up to now, the rest of the sensors were used in normal mode
> > all the time. This means that they are continuously doing measurements
> > even though these measurements are not used. Even though the sensor does
> > provide PM support, to cover all the possible use cases, the sensor needs
> > to go into sleep mode and wake up whenever necessary.
> > 
> > The idea is that the sensor is by default in sleep mode, wakes up in
> > forced mode when a oneshot capture is requested, or in normal mode
> > when the buffer is enabled. The difference lays in the fact that in
> > forced mode, the sensor does only one conversion and goes back to sleep
> > while in normal mode, the sensor does continuous measurements with the
> > frequency that was set in the ODR registers.
> > 
> > The bmpX_chip_config() functions which are responsible for applying
> > the requested configuration to the sensor, are modified accordingly
> > in order to set the sensor by default in sleep mode.
> > 
> > DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
> > the BMP58x version, are not added.
> 
> ...
> 
> > +	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
> > +	    (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {
> 
> I would add one more space to make the indentation follow the logic.
> 
> (no need to resend until Jonathan asks for it, otherwise I believe
>  he can amend this whilst applying)
> 
> > +		dev_err(data->dev, "Measurement cycle didn't complete.\n");
> > +		return -EBUSY;
> > +	}
> 
> ...
> 
> > +		/*
> > +		 * According to the BMP3 Sensor API, the sensor needs 5000us
> 
> Can we use 5ms...
> 
> > +		 * in order to go to the sleep mode.
> > +		 */
> > +		fsleep(5000);
> 
> ...and 5 * USEC_PER_MSEC here respectively?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 


Hi Andy,

Thanks for the time for the review once again. I think I can manage to
find the time to do it today.

Cheers,
Vasilis

