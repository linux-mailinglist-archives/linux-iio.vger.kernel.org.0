Return-Path: <linux-iio+bounces-25099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C597BDF21E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9D31889E98
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4EA16F265;
	Wed, 15 Oct 2025 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW4Y56Bc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703029B8C2
	for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539226; cv=none; b=gpmWivHIl26gZPOMcaGxPSp4L0ThqXCc274VoFkDylaiI1EkU1llbURJjBwlto6lMmYIc4yLPoJok0JVJvmbc9VkIhs0Tz8L5DgWlYF3KY/t2qt0h16P5MgdMOtKXfcFMSbJCrsgXRXYVl/GVYDi8BWpoxPUya6buwYxQ/W77aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539226; c=relaxed/simple;
	bh=Kq6pVdZOg7a1WPr8AiMpWEij5BoHEYQsn4tjHgq5LT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/1obw0esTF1kucjelu3kWkR2m6dVXFGaftgK+dc6+j/DFeUS3bKQOE1EsQ6tClPPEH7hQngzPnUmDtuCrvgZDUYdiDW11Ml+euGsdAvg8MbeK6tneID6UFzTGD4rIz6bhR+/T8uzcdHZTo10Ro6dr75bA4YyWS+PwqkuhXYsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW4Y56Bc; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-41174604d88so3105938f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Oct 2025 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539222; x=1761144022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GoqtzN0lWlzu79SStRn0iIZHV2VRS7p0ymwJV3EZvNM=;
        b=DW4Y56Bc8Qr4m82j8gJSZj7eQGWJQoAOjjYQC1BGB4SpIwQk6/yyJXYL4Ob9diL1Bo
         xWFVgcLsw5gEOK3fZNxQSiMnkV97Rzr0RHjsnP5VpaFtli+OUp3C1pP3qTvI8mJ62uzW
         o1OynKGvg6IotejZjy4SviMim5AOxK5bIqlT706K01M6YhjaCCOaSSvXYnF5bOk87ZJ7
         r3C+k1+xzTUmI0XIyBPnRttFdh7fBa5pR+DYYNV8hnp/JheyrvYKRXIq4rHzNVcWSTgn
         HNOcg4zNBIDOCK6Z6TidY/SAHp9FpWc8JVXg4bHXLVyugJxJeWqJ270b7EzXgA16JBpQ
         heHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539222; x=1761144022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoqtzN0lWlzu79SStRn0iIZHV2VRS7p0ymwJV3EZvNM=;
        b=CSbrGc7ttNWmt5auW1sg+7QhT3j37uSL5AN1zj0/3Mj1voumBK6Z/l+B64kUES6+Cb
         6WfMVvb+1GHEI5VZWbE6HRSyzWpe0gBH+LwnTn7zaTI5GGTkVh2IC6pTPHvqMDeuP9AK
         vlhK1APIjQwJx78KKqJXDHb2AouTq9k00wKwTMjWLcVQ3oUwcWGiXsab5KXUea67NmUN
         dwkbcz29qYxv2+9qs1qngIH8rd3DFF6i7VCwtmgkmDIHp1VKz7XRq1DP3TXkl4+1OFKN
         M8QrvXckkdu4M7zaobkgXATZ3uDDBHxOLiGmb+5mU7B+mrG0Lr7NoAzuXaGj2EKqWiZI
         +8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqUQubxXg08ydQAlym8FIwauy9CS8A5SY0sDhv1NJqoILFjQHKYTSEjLnp7MBWPuW5J/aPZFYDKLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdFHEgJJ9yhHHLYrstBkNK3iSRCAK/XFjIvs2hZBc5s2dxuhpn
	ka741B7nAnlfz9rCymEJN7yjcw+t+9NEVs8gXP3Q+7HStPchYU93ogje
X-Gm-Gg: ASbGncujVmInOegdh4lRT4evHL93KJhGY7dhJ+rlw6cW2ubC8lXTpfcMgw5Mae2ZsLR
	zAhV+QAonGisWeyAP3YOhgiUmMaXiN+d01dSDH+4ZxLQNmmeUaLGdG/1MsjwO+qoUarcumUQXcL
	lmKE8925fMv+D1zdZXXnA4OW2oR3byyDycMZ1BzveV8lotEBTP1VVwPdhUCZA/1sRKyYg9eK3dX
	ptwI5gX6OEDHuZcYqI1nkW89k//0yHQ5uXmutGoi4kSgmLRAubR8bBpdm1V2diUF56puN/cb1QP
	O4/OWk5Y7Im/R6NQuDgiAtRSzk9YYzpcmxCx3rMJYdIc8AFwTUQcLCFdeNKSipQTwNcg7EVanya
	nXvWeniC8tOAulz1CMNhkvBSWzlFCRqlEbzspYfulYLsOo6uoqQ==
X-Google-Smtp-Source: AGHT+IFsLDcwGEHyBOoWPYn6JJApXkwvV7WDKIKm6EalFLQUwdrQ6onT+X8Kqzu8TCKG+6Oj9L642Q==
X-Received: by 2002:a05:6000:4313:b0:3e0:c28a:abbb with SMTP id ffacd0b85a97d-42666ac39a2mr18353598f8f.13.1760539221995;
        Wed, 15 Oct 2025 07:40:21 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:605:6300:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470fe96d064sm20404785e9.2.2025.10.15.07.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:40:21 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:40:19 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: dimitri.fedrau@liebherr.com,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Li peiyu <579lpy@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Lesiak <chris.lesiak@licorbio.com>
Subject: Re: [PATCH v3 2/2] iio: humditiy: hdc3020: fix units for thresholds
 and hysteresis
Message-ID: <20251015144019.GA2207492@legfed1>
References: <20251013-hdc3020-units-fix-v3-0-b21fab32b882@liebherr.com>
 <20251013-hdc3020-units-fix-v3-2-b21fab32b882@liebherr.com>
 <CAHp75Vd6g_Nw0U_4NXEQZvLBCP49mXDrmxFj8yYqR7kW7festw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd6g_Nw0U_4NXEQZvLBCP49mXDrmxFj8yYqR7kW7festw@mail.gmail.com>

Am Wed, Oct 15, 2025 at 12:45:31PM +0300 schrieb Andy Shevchenko:
> On Mon, Oct 13, 2025 at 11:12 AM Dimitri Fedrau via B4 Relay
> <devnull+dimitri.fedrau.liebherr.com@kernel.org> wrote:
> >
> > According to the ABI the units after application of scale and offset are
> > milli degree celsius for temperature thresholds and milli percent for
> > relative humidity thresholds. Currently the resulting units are degree
> > celsius for temperature thresholds and hysteresis and percent for relative
> > humidity thresholds and hysteresis. Change scale factor to fix this issue.
> 
> ...
> 
> 
> > -       return -2949075 + (175 * temp);
> > +       return -589815 + (35 * temp);
> 
> I was under the impression that we agreed on the explicit division by 5.
> 
>   return -2949075 / 5 + (175 / 5 * temp);
>

I wanted to scale the formula as it has been done before, but didn't make
it really clear. After thinking about it again, I think you are right,
will add the explicit division by 5.

> ...
> 
> > -       return hum * 100;
> > +       return hum * 20;
> 
> And in a similar way here.
> 

Ok.

> 
> >                         s_clr = max(s_clr, HDC3020_MIN_TEMP_MICRO);
> >                         s_clr = min(s_clr, HDC3020_MAX_TEMP_MICRO);
> > @@ -565,7 +574,8 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> >                         /* Calculate old hysteresis */
> >                         s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
> >                         s_clr = (s64)hdc3020_thresh_get_hum(clr) * 1000000;
> > -                       s_hyst = div_s64(abs(s_thresh - s_clr), 65535);
> > +                       s_hyst = div_s64(abs(s_thresh - s_clr),
> > +                                        HDC3020_THRESH_FRACTION);
> >                         /* Set new threshold */
> >                         thresh = reg_val;
> >                         /* Try to set old hysteresis */
> > @@ -574,15 +584,16 @@ static int hdc3020_write_thresh(struct iio_dev *indio_dev,
> >                 case IIO_EV_INFO_HYSTERESIS:
> >                         /*
> >                          * Function hdc3020_thresh_get_hum returns relative
> > -                        * humidity in percent scaled by 65535. Scale by 1000000
> > -                        * to be able to subtract scaled hysteresis value.
> > +                        * humidity in percent scaled by HDC3020_THRESH_FRACTION.
> > +                        * Scale by 1000000 to be able to subtract scaled
> > +                        * hysteresis value.
> >                          */
> >                         s_thresh = (s64)hdc3020_thresh_get_hum(thresh) * 1000000;
> >                         /*
> > -                        * Units of s_val are in micro percent, scale by 65535
> > -                        * to get same units as s_thresh.
> > +                        * Units of s_val are in micro percent, scale by
> > +                        * HDC3020_THRESH_FRACTION to get same units as s_thresh.
> >                          */
> > -                       s_hyst = (s64)s_val * 65535;
> > +                       s_hyst = (s64)s_val * HDC3020_THRESH_FRACTION;
> >                         s_clr = hdc3020_thresh_clr(s_thresh, s_hyst, dir);
> >                         s_clr = max(s_clr, 0);
> >                         s_clr = min(s_clr, HDC3020_MAX_HUM_MICRO);
> > @@ -630,7 +641,7 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >                 thresh = hdc3020_thresh_get_temp(ret);
> >                 switch (info) {
> >                 case IIO_EV_INFO_VALUE:
> > -                       *val = thresh;
> > +                       *val = thresh * MILLI;
> >                         break;
> >                 case IIO_EV_INFO_HYSTERESIS:
> >                         ret = hdc3020_read_be16(data, reg_clr);
> > @@ -638,18 +649,18 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >                                 return ret;
> >
> >                         clr = hdc3020_thresh_get_temp(ret);
> > -                       *val = abs(thresh - clr);
> > +                       *val = abs(thresh - clr) * MILLI;
> >                         break;
> >                 default:
> >                         return -EOPNOTSUPP;
> >                 }
> > -               *val2 = 65535;
> > +               *val2 = HDC3020_THRESH_FRACTION;
> >                 return IIO_VAL_FRACTIONAL;
> >         case IIO_HUMIDITYRELATIVE:
> >                 thresh = hdc3020_thresh_get_hum(ret);
> >                 switch (info) {
> >                 case IIO_EV_INFO_VALUE:
> > -                       *val = thresh;
> > +                       *val = thresh * MILLI;
> >                         break;
> >                 case IIO_EV_INFO_HYSTERESIS:
> >                         ret = hdc3020_read_be16(data, reg_clr);
> > @@ -657,12 +668,12 @@ static int hdc3020_read_thresh(struct iio_dev *indio_dev,
> >                                 return ret;
> >
> >                         clr = hdc3020_thresh_get_hum(ret);
> > -                       *val = abs(thresh - clr);
> > +                       *val = abs(thresh - clr) * MILLI;
> >                         break;
> >                 default:
> >                         return -EOPNOTSUPP;
> >                 }
> > -               *val2 = 65535;
> > +               *val2 = HDC3020_THRESH_FRACTION;
> >                 return IIO_VAL_FRACTIONAL;
> >         default:
> >                 return -EOPNOTSUPP;
> >
> > --
> > 2.39.5
> >
> >
> 
>
Best regards,
Dimitri Fedrau

