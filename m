Return-Path: <linux-iio+bounces-18937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C734AA5F7F
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040883A8826
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2101B4240;
	Thu,  1 May 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vgnU+EcW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F121199934
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107460; cv=none; b=aI6RbERW+Sqy88f8n1GgqwZo+qVLc6H/94hMH/UeoDZGGMbdtKuHvhzuos2Tsd937ji4uE1IMI08PvwfOQhuuuHnbrubfcv5mq0RLVt378szRffYzzV9fbpKhDBOTVRZenqmkyIio6J43cOaMQu30IapNcjNl/CZqgt9M6x69l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107460; c=relaxed/simple;
	bh=3S2ZpOURBmPgdkON47FakSSexpUR54q6fL0CBQ8Af3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQgDaDJm1tMFIMDuL1KB2yMbwg0y79TlL6zX1pdGR2MzHkqCesKrddEQV4VFRU1LQ3U/HMuXiyMSsryumRPJbAA5gihcKIK9S07yo0YAh2zSMS8Tf/iUyvf3t7KFMewkMSZcFfxbaR4ldxA+rN7zKAnrXr5R9NimbjigF8rqXf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vgnU+EcW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43edb40f357so4314425e9.0
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746107456; x=1746712256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zruKVRDRscyVarFUye9F0wOJCzPUiyyhJYtA+dpYCeQ=;
        b=vgnU+EcW5tJK8ImxTmCLn3xRp9ZKyW1CpdkXojWMYnrCILvRhitmJYOOTW5iPw1Cw1
         qkW8BUwAwQpOPK0wdlTiCefJd2ntpe4ilWDXDD9HTKbcZavyJqEPazltzpqdzp68xH2I
         Fqd9SnFS8EOCSeR+/1VUKz+QTFBje2aAJfu6601D3lZSDYfS0nw6vligl87G+bs6cAIO
         Q2mpBf4sAdivzTHn8lFBCafLzH+vJWOlxBcrGpw86sNc/1w6AaI8+ieS1y5btPKBWd/O
         0Lw/FUZCqLkmDwXmj4T3aXN+Rn9O7QvTYBa8WWOdBOKfANAKPqRbAa2AjgNeZQUrgin7
         TFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746107456; x=1746712256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zruKVRDRscyVarFUye9F0wOJCzPUiyyhJYtA+dpYCeQ=;
        b=KaiDZrsVXtCYirtQuF0YMjfHLBjpLfLbMhkwz470/Kl9K71tEOo0CdyRPGMWSvWLw/
         dJpVJNVrYaClSCMAf7WouJGxEX3GGFnzNcZaNvgDOs/Fy/65BvfKbUaGFpvI8Mnh8vSf
         Q6LanL6l1g32lJ6rNACoSgKZSDHdX42u9I/AcsXqquWvEj5o0WSC0WGYSwroCB1eJomW
         rIW4vFlpz12cUJ15gkwFGuEbxgV2aAx+x5rSQkB733ir1tVfyzFZLQKrEmHfSuuf9UB+
         qqBqeNFL88hygNFy/lEDGMJon2ar15ZvrBfG58h0MbE+sPUUqFpRF2G2Bh7WzYXbd0mB
         qaAA==
X-Forwarded-Encrypted: i=1; AJvYcCUztUbTmtBpgsZp1jaxJ+aFpIX5jI+DiTG7OPRbsAm8KrOUBxtajnSvtlzbZfEaFarFSnMuXXD3zX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxK9LbM58hgIezWOatTAvvN03aM67jP9hDTPnESatZKxGJoIEo
	MpLfxDJGdsB1XUsHXXc3gH6RJPIz5PGX1asx0gNcd48TTPbqdb+DzcnSrID1UQQ=
X-Gm-Gg: ASbGncvQRi7MVNaE5X++k35aXlJZv8DtYHDYIoxPC4mAj5bzxyrwplWHs6YproBe9ND
	AZwnKWoI7gJiWMO4q/B5E+UegvO1ARuXSbaZ7ERz0wj4tBSmVKmLpnwpMSFHfr8h6k8Nk4nGp15
	bIv041R2CWoXUAZt04XuCyQuxtje1fZJXH9eg48sLzJIu6mFz8WVegJTxAiV5/bsOHgNfCB2+4l
	bMwTI4sLUHovHyLrOqRzrO7lmdcxwraYKevgLq7OpDaW56VCPy7hE5xH2Kd/SQvVsN1QG43bhwh
	Kd08PSwkRfGAtE6vqDTem65WkHNJnV6hyC8pEZ8p4R0pKS8GiczmFMqcgfrjmtmcaGo6prmQ9yJ
	4x1jfKG0=
X-Google-Smtp-Source: AGHT+IHupedOPMOM0/qcAF0IPZeZXqgUOFSKpReFgbOJMXAFwMjiMXlEwXf+hlUk6b7Aa4h8TEFLmQ==
X-Received: by 2002:a05:600c:502a:b0:43d:609:b305 with SMTP id 5b1f17b1804b1-441b6500698mr29167515e9.17.1746107456371;
        Thu, 01 May 2025 06:50:56 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441ad8149afsm48670895e9.0.2025.05.01.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 06:50:54 -0700 (PDT)
Date: Thu, 1 May 2025 15:49:44 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: adc: ad7606: add gain calibration support
Message-ID: <okavvmsyg6jpdleye5e5oxg2cwwgkr42f6wlq2dlsswrzxkpnq@66apz7uva5eg>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-5-eb4d4821b172@baylibre.com>
 <CAHp75VfBrodRH0gW8teULNSt3f_uJA0Ze+P+YOTKLhtec84-3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfBrodRH0gW8teULNSt3f_uJA0Ze+P+YOTKLhtec84-3Q@mail.gmail.com>

On 30.04.2025 01:34, Andy Shevchenko wrote:
> On Tue, Apr 29, 2025 at 4:08 PM Angelo Dureghello
> <adureghello@baylibre.com> wrote:
> >
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >
> > Add gain calibration support, using resistor values set on devicetree,
> > values to be set accordingly with ADC external RFilter, as explained in
> > the ad7606c-16 datasheet, rev0, page 37.
> >
> > Usage example in the fdt yaml documentation.
> 
> ...
> 
> > +#define AD7606_CALIB_GAIN_MIN  0
> > +#define AD7606_CALIB_GAIN_STEP 1024
> > +#define AD7606_CALIB_GAIN_MAX  65536
>
Hi Andy,
 
> Are those values in decimal in the datasheet?
> It looks to me something like
> 
> _MAX = (64 * _STEP)
> 
> but is it for real? Usually values are limited by the amount of bits
> in the HW, here it spans over 65 steps, i.e. 7 bits would be needed...
> Confusing.
>

true, thanks,
there must be a typo in the datasheet that says 0 to 65536 with a
step of 1024 with 6 bits. Only 0 to 63 are possbile here.

step 0 = 0
step 63 = 64512
 
Will fix that.

Regards,
angelo

> -- 
> With Best Regards,
> Andy Shevchenko

