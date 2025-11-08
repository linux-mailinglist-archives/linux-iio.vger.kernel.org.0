Return-Path: <linux-iio+bounces-26051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9806C4338F
	for <lists+linux-iio@lfdr.de>; Sat, 08 Nov 2025 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64418188CA34
	for <lists+linux-iio@lfdr.de>; Sat,  8 Nov 2025 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77172236F7;
	Sat,  8 Nov 2025 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIOCembX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0E13DBA0
	for <linux-iio@vger.kernel.org>; Sat,  8 Nov 2025 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762628661; cv=none; b=cuUSmhA10IocN2xZhldKSwrMtCsoLIVEUhXmd46oKEi0v6yrj7VmlZGbDfsWbZg698N48ixJuAGCErtWXCQOO48VtnSyu+4rluZWOpB/x5m9EMr5VuJpdmTQNzvqnhNCtdK6+ZjjulmMN7Y0YIbk79ip/rOIga9Ta06qRutARas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762628661; c=relaxed/simple;
	bh=ZnXCe3slB/+La9FFt8FMvzhu8yXnuS6lOiGVsn0Cuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVqkzc4nVhfSGdhCowzrIrRm/QLfiFQMwJQ6+FVS0UDzjvdjxV9HQBvjWpJ5RPpXeKyObiW+Z4Q37LeOxfgy89y9eeGY/xINChkCKwf8iNCVOw+YfW3FQbSO14O2o3KKl70wu2YHBes6zZfETXuc4oMJ9vmqN2HKHnPtfHS4zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIOCembX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29524abfba3so17078285ad.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Nov 2025 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762628659; x=1763233459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzMLE3EYtbU4A3oZ/jZyZMkI9O11eehJl7ny+5w5lfI=;
        b=cIOCembXDk8uM33Klxu8PbQ+FB75frZVCunbWvqXnSwtsdDmmFmuytBm5Jo5OZoa9U
         VhbPPgEOkNIgJgmzqmA83dbkwrQjVMi72KL2U/ZqYQxGT+wm1SwIAlQu9lMGyHvJVerP
         q66U2KBVPhow4dB5VfDmHBFv6UcOR9TXJ9xG92gjAc9ZPhNv3NA6HxmtgsYvwharuoDg
         KKYj1889kUtgoVFlvFDuQoXYPxd5TicozXv1HZz3TiwWLMaYO50ryyAefuZmphGT0GE9
         frLXeeSmHuc+dCreKS66UtLbuDCqRm3KweRWmZWSc5+oXj6MOpu1RcF7iMv5Aov5VVVU
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762628659; x=1763233459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzMLE3EYtbU4A3oZ/jZyZMkI9O11eehJl7ny+5w5lfI=;
        b=Es6x+h5kJf/XSg8W4oteQgAG6PZUECRmcxPO0r4KjKyD9bJvWglWGkeVwLtee0TW8Y
         wyhPrqix5FUpgrauylrSHG6jM9x/djiEyLBN0W6LZdhs5M6/M8o5TBD5Fh49DXBPu5XU
         sv7jVwMrOuPJ76pGL3V6IkPLUK/zIUs/a24uFq0BIrSW+QlJmL8LO5TpSWSEUQAfZr3W
         LqT6qFWSAoYiCIXiWecOgMeJQQ9qj7ZtQAOaMyjza2BX4NL5R02naYJhLo1jEGqGw4bG
         JFucq0zhAu/9y90/go+rZUpA+FMRkQV0FpaAt6VW+gCWHxT/nunyXAFI9pdiDkgIzm7q
         sEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXHv4rzZ/sFHp+IzLZMg7bn+TMdVu7IbkRg22/0BLymAHZ6VQEV6qZ4cqq7PAC+v6gVNcS7Aj9VyTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRK+wlisjlYdvJgntoQV6SJ4WmQJzO03GVUFW623xQnsX/24tW
	Unn6IgkENabgZ1xoghVWXjHI2fNws4ixWiJjHQJC/4yYlzqsYU4yJIDw
X-Gm-Gg: ASbGncvNxGp2gXM79QvphVzb77QSV+awJKlV7bjGfSVJZ+KlmGzMQ/Zt7yZMtWlkHd2
	0QZDMS/jR9y4hpBQwzIJK2I13gc9tVTX7rsyb1sjyTin5VidF+tDeliiDpJvDHA1T+pfdYU/H5X
	y+BttYexKvg5vOQfK6U9MGfZUvLxZ7StDefijiywKC14/A2vzqOF0em+VcVgyOzAeMnmJgG4Uyd
	yW20ZVn46xtjuOi9R0bPuBs8REHKQQ37cp623e5vORO/ZodfZqEXqmeV08iaL77SbuSRcHc/OtD
	SToNwtvJr5RwGeRvur7LM6jOwSMvcVCsP/UFYJafG9h3dziuFq+QbxXppGG5SQNAk4WB1+7gEKy
	+xbA2rUbI3U2j4oo18vXhOPM2QmoXxAlj4MCwiphr3JQ/pHswB3zkYX+yU0jGTCh97x3gjSAJX4
	/tgWpjA05z1+adQfIxyEwZ
X-Google-Smtp-Source: AGHT+IEztg+YPHMPHcH6FjnzLW/Rc12+PWWrybeAs007JujoskqVttmiPI8dUMgJekSCdSs3mWNweA==
X-Received: by 2002:a17:903:2c06:b0:295:62d:503c with SMTP id d9443c01a7336-297e5627aecmr40584265ad.16.1762628659396;
        Sat, 08 Nov 2025 11:04:19 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651c7445dsm95293565ad.62.2025.11.08.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:04:18 -0800 (PST)
Date: Sat, 8 Nov 2025 16:05:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aQ-UfmTkRX75BOfg@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
 <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
 <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>

...
> > > +	switch (chan->type) {
> > > +	case IIO_PRESSURE:
> > > +		val >>= 1;
> > > +
> > > +		if (val < 0 || val > U16_MAX)
> > Alternatively, could use in_range() for the check.
> > 
> > > +			return -EINVAL;
> > > +
> > > +		tmp = cpu_to_be16(val);
> > > +
> > > +		return i2c_smbus_write_i2c_block_data(data->client,
> > > +						      MPL3115_PRESS_TGT,
> > > +						      sizeof(tmp), (u8 *)&tmp);
> > > +	case IIO_TEMP:
> > > +		if (val < S8_MIN || val > S8_MAX)
> > this could also use in_range().
> > 
> > If you opt for the macro,
> > #include <linux/minmax.h>
> >
> I see that the in_range() macro operates only on unsigned values, so
> placing it here would be wrong I guess. In order to keep the style
> consistenc in this function, I'd keep both checks as "val < x || val > y"
> 
Ah, good point. Okay, no objection. 

> > > +			return -EINVAL;
> > > +
> > > +		return i2c_smbus_write_byte_data(data->client,
> > > +						 MPL3115_TEMP_TGT, val);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> Kind regards,
> Antoni Pokusinski
> 

