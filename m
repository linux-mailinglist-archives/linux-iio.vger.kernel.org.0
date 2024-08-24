Return-Path: <linux-iio+bounces-8755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E3B95DD72
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F951C2118A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78114F9D7;
	Sat, 24 Aug 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpHf4ecv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790228DB3;
	Sat, 24 Aug 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724497835; cv=none; b=s8Nj6tGjWdwoSAXJ72wHw1LIHRj7Jd0O+S+d2C4wrVWI+W5NbyaDXyT1DdLKk7yzQwj14CWu/I5dv/azdD3YewhWjtQcRdy+KJ6oXVK5Eam3X3IA/Hsu94y03hG4bGfDNKMZq5RqcFdMKvA7oBf0cP0CR4kdGBj+RBNjp6b+HIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724497835; c=relaxed/simple;
	bh=GRtkBEh1GQ1KebyxSrx37OVgwg3OAhWXS4yRFOOJs0o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUbRYqIQ7zjzt7PfygkqxMsZfk+UnXw2RlpaMS4oHUCevbwUnfeR5oQLE6/UIFp7HZUUvDDYn3hcMCuiGYtW0X5Ti0nBkapT5xSUydr9FFobLtjSx76FGvmE1ujmofMY6C6ujD3IscAPVj7Tqh/0irIu5TYropXYBN1vpI+f8/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpHf4ecv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a80eab3945eso305065766b.1;
        Sat, 24 Aug 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724497832; x=1725102632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBV7lmzmCItAAjhoP/3E6SLA86RQw759zDxS0Q8Gwo4=;
        b=EpHf4ecvGURUhe+t9sZl3vJzHtspiVf0C9FS8Mj83PI3hlhbquNb4fU4JeH/JvBX+J
         gOTeeWKOCdw2d+jQNLASXg5Aerzub9ImdSg0Xm9Yr66L3y7YpTBjdcIH76cjp1TEKUuu
         r94oYYqwTycD4GkCfZTW/mL8vd47P2TsyNHNWSmJ2H0fUj2ZjbX3OxGee2ogJ6OQ0D01
         4okvC4+KC8xG56L6zMTJ/8fPRY6e06b//3GcVnqhzwz1uOSEcD2K/0ZJcfva+WJ/lf4A
         blkaKxIeCdzNVvMgG/Zq2kCl+h2a5thg7WlS4lLQcrMCt4n+ZmOyX1n922M4qMiaHAy9
         invQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724497832; x=1725102632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBV7lmzmCItAAjhoP/3E6SLA86RQw759zDxS0Q8Gwo4=;
        b=O5M+GY4F6trtvDyRxVqYiKjTZPiMpKKtqxN5mqtHHFn+GSreJ9WjNdyA5GpRAtITfr
         04zgZuFOE8CbvC4AysjXcpfnfr3MxcrLB0NTiB/qFAYvUGQTaBf2iVRv5Rgg8cs6hJeN
         iSjFcwt717IECpR4RKt78+faEDb5r2Ndz9dSTIzV94drbY96LS+W+6JiSQPL8yKQjKjj
         kpgUbSLQwrAv71NjpEBDpGbHc7ItRIEMPGkxsQdo2631FnH3sTf7SZqLehTbkENtjW2j
         pumMLzGmlXS218iNoQ7X/Rx5Pd0zlnj4Qu/qhb3O/PWDlNPj/eJk2bO40couHgSWNhmR
         KODg==
X-Forwarded-Encrypted: i=1; AJvYcCUMWR3A6uKYPgK01vwwQFRQx+gOchDEcuVEX7YmZaJ5LgX/F0UtmMf4JguDRg3OMIvDateE2sm6EBvfbV0w@vger.kernel.org, AJvYcCV0wyVUNdmZwdaYEYh2oOUDsgU50F34wzNvA46UQgoJ+/82wbo4vHL1U0pYkdBw10/1xnjTU3/F+V4r@vger.kernel.org, AJvYcCXxJJ47molp+zfwrrJBx+3kQU1E3tAP7Az6jFgcqbEBv1s9WsjRyamJFjNLU7MIlkYHHz07aiG9PqVn@vger.kernel.org
X-Gm-Message-State: AOJu0YxFSzplUBoiIxB4eTcgx1/A8ZkvHF3DH8mjkNzPyvSkt5fDvstO
	7zR4+kTESNAcdrauT0CS7YlplECjhsdUBrkkhyRtE6jKMYPCCG3Z
X-Google-Smtp-Source: AGHT+IEfDIExBhfjJy81koGDbe3uxAuYtJixA7sRNMlSDmUVJDs2ZCuUro4SIP8D4SWeA1BgZrmBsQ==
X-Received: by 2002:a17:907:f786:b0:a86:721d:3021 with SMTP id a640c23a62f3a-a86a519ca75mr359264166b.24.1724497831314;
        Sat, 24 Aug 2024 04:10:31 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9aa7:6f8c:e4ad:5d20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f459asm387212366b.198.2024.08.24.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 04:10:30 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sat, 24 Aug 2024 13:10:28 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] iio: pressure: bmp280: Use bulk read for humidity
 calibration data
Message-ID: <20240824111028.GA9644@vamoiridPC>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
 <20240823181714.64545-2-vassilisamir@gmail.com>
 <ZsjZOkglW1lGDNr8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsjZOkglW1lGDNr8@smile.fi.intel.com>

On Fri, Aug 23, 2024 at 09:47:22PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 08:17:08PM +0200, Vasileios Amoiridis wrote:
> > Convert individual reads to a bulk read for the humidity calibration data.
> 
> ...
> 
> > +	calib->H2 = get_unaligned_le16(&data->bme280_humid_cal_buf[H2]);
> > +	calib->H3 = data->bme280_humid_cal_buf[H3];
> 
> > +	h4_upper = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
> > +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, h4_upper);
> 
> This is a bit confusing. I would add a tmp variable and have this as
> 
> 	tmp = FIELD_GET(BME280_COMP_H4_GET_MASK_UP,
> 			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> 	h4_upper = FIELD_PREP(BME280_COMP_H4_PREP_MASK_UP, tmp);
> 
> Also note indentation issues.
> 

Hi Andy,

It's been a long time since you last reviewed code of mine, thanks for
finding the time to do this, I appreciate it a lot!

You are right, it looks confusing, I can do what you proposed. I don't
know how I didn't see it before.

Cheers,
Vasilis

> > +	h4_lower = FIELD_GET(BME280_COMP_H4_MASK_LOW,
> > +			get_unaligned_be16(&data->bme280_humid_cal_buf[H4]));
> > +	calib->H4 = sign_extend32(h4_upper | h4_lower, 11);
> > +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK,
> > +			get_unaligned_le16(&data->bme280_humid_cal_buf[H5])), 11);
> > +	calib->H6 = data->bme280_humid_cal_buf[H6];
> 
> ...
> 
> >  		/* Calibration data buffers */
> >  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> >  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> 
> Side note: I would see rather sizeof(__Xe16) than 2:s in the above definitions.
> 
> > +		u8 bme280_humid_cal_buf[BME280_CONTIGUOUS_CALIB_REGS];
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

