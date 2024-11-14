Return-Path: <linux-iio+bounces-12256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D29C8C4C
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A906B2CA30
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010117BA6;
	Thu, 14 Nov 2024 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/1kRAH2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E0F9C0;
	Thu, 14 Nov 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591797; cv=none; b=myvorROfiXWkbBAdvZFaQlGdQW05NDZ78B8Dsn4Ww1S/PUnPVvfNK1nIAdelnWr75rj/0hfMKURFKgcgR8v6L+57HrMX5RsUtDBrWPRbPp1J0PdGHEuztzSKcvjGUaMaHUCDdPOKGse5f6L2d9TknXLuG1zqv+sd4sWdykZmEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591797; c=relaxed/simple;
	bh=xiyLG0ECroEKZHad2vkypCUW44S6boFOl8KsXdXcqgw=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=Ya1GHsJqfbvWmZ2MKl9x/Ww7VnG9WT2S6WvsEF+Mp4n+GzMlrXgDckrWvy7oxmVXvGR91MpFA7D03WkxkyDOvW3CowrH3qq1uCV576jrP37EncDa6PFeoaIm+3STR26Q3NeTi91lFi8zm0e+erX5H6bPQRY6g0VGM4oXRVO8ydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/1kRAH2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3821a905dbcso418225f8f.0;
        Thu, 14 Nov 2024 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731591793; x=1732196593; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yeCEUAXknMD9aScgAG2zWF+lXiTH5mTd/RZzyFiyf5A=;
        b=M/1kRAH2OokMsSJcJbnLt9RPGO2KuL+76G842OONjFNHjljtqVh3YYOb94Etq1K1OY
         O3VqRRd7T6bEXiU2DDRgCnJYl0Nln1gd6oGKIdXZSZi259HrPQe+sPQLPYhn9naudUSr
         Cy3RCgS2b5HmwX4FRAmae23ARozo66zw+tm7pbo5907vK9SjnhdYEnSza8NdovF5/g98
         KuCif45rU+kBPSxjQ/7VWJ6dZqzNEspn262bUml0kwwUEHVijOW3PYzbBoLIbDVZonDu
         rKtV1PmH7uCCIOSrWQwB63ZUVsbdl644OkFdv0YAD9q7aF+pLeJpWufBiuvyKGiqhIUu
         aauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591793; x=1732196593;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeCEUAXknMD9aScgAG2zWF+lXiTH5mTd/RZzyFiyf5A=;
        b=Q/zn1N9JAfsUM7WRSKCK4W1nHUSbr8awf2cXoV5+mzg0sVIahbb2yNa+G12w/E37Fj
         Tfc8k0kFS9X8VIjeKMXXlct1yWd+HaT0+UTgTmlq+by8+sB2y9ahQ7s7Rnn5hSy4hhe7
         OAqutVcf+ScpK4B1X68mbYdOIQgXLZeavoA9rC6NOhQbsVqFlN18UvynijA5HAXy2kKI
         p8htm8eWoYcRU/RFcsRQC9c06TqiJpoM+5jq7S7RHS6NM6VAUE2Qn4bzr6oCkn9E/Am5
         tJhcTtfC/dZ4YimcC6tT42qGcVts/QdCuu3KpXuoD666Q0oGGRV5VeGQb3I7GLt8wUI4
         2ThQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoa/M3CfXGIwkUDd5/4Kjkxnzwi2MRzk3fjIHrb2mCbTjYMxRyzTFb6AnI88EOCUXMAGqPMe+uFEk=@vger.kernel.org, AJvYcCVgZsz7qXm/p4bpNtbeB9Bl3sQFmashg3FcaChgOhNeaOdMMXauBPW1CQJzJ41pR00HEjQUfV1j7dVTbKQ3@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3uqeKXI7UyA+pMs07qeCDEwtH5EX5i476YcfX0syT92YWfB6
	VapN2qFlHcWep+HowGGWDa9VHRO/J+7Cz43rg+D7HMqbTNLJ2Q2K
X-Google-Smtp-Source: AGHT+IEdHPDvGyAlTmxeMfbzcd5voQHz6RUMFEDJeW0QTjy11La74kNItnjNU8kiCg5rS7B4r0fe/w==
X-Received: by 2002:a5d:64c5:0:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-381f1883da1mr22111074f8f.44.1731591792706;
        Thu, 14 Nov 2024 05:43:12 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbbc80sm1512804f8f.51.2024.11.14.05.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:43:12 -0800 (PST)
Date: Thu, 14 Nov 2024 14:43:11 +0100
Message-ID: <c67cd8be57b54b792430fd56a57a3ee1@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v11] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
To: Victor.Duicu@microchip.com, andy.shevchenko@gmail.com, jic23@kernel.org,
	lars@metafoo.de
Cc: Marius.Cristea@microchip.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
In-Reply-To: <faed3b586e1af2d946d3f9b185a94b6ebf0f6f32.camel@microchip.com>
References: <20241114084702.3499-1-victor.duicu@microchip.com>
	<c1b30741bec25e25c6e57389bf45d04f@gmail.com>
	<faed3b586e1af2d946d3f9b185a94b6ebf0f6f32.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Thu, 14 Nov 2024 12:52:12 +0000, <Victor.Duicu@microchip.com> wrote:
> On Thu, 2024-11-14 at 12:00 +0100, Matteo Martelli wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> 
> Hi Matteo,
> 
> > On Thu, 14 Nov 2024 10:47:02 +0200, <victor.duicu@microchip.com>
> > wrote:
> > > From: Victor Duicu <victor.duicu@microchip.com>
> > > 
> > > This patch implements ACPI support to Microchip pac1921.
> > > The driver can read the shunt resistor value and label from the
> > > ACPI table.
> > > 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> > > ---
> > > 
> 
> ....
> 
> > > 
> > > 
> > > +#define PAC1921_ACPI_GET_uOHMS_VALS             0
> > > +#define PAC1921_ACPI_GET_LABEL                       1
> > > +/*
> > > + * The maximum acceptable shunt value is 2146.999999 OHM.
> > > + * This value, which is below INT_MAX, was chosen in order to
> > > + * allow the readings from dt and ACPI to share the same range
> > > + * and to simplify the checks.
> > > + * With this value the maximum current that can be read is
> > > + * 0.1V / 2146.999999OHM = 46.576 uA
> > > + * If we use INT_MAX the maximum current that can be read is
> > > + * 0.1V / 2147.483647OHM = 46.566 uA
> > > + * The relative error between the two values is
> > > + * |(46.566 - 46.576) / 46.566| * 100 = 0.0214
> > > + */
> > > +#define PAC1921_MAX_SHUNT_VALUE_uOHMS                2146999999UL
> > > +
> > 
> > Just a minor point about this: if I understand correctly that value
> > comes from (INT_MAX / MICRO - 1) * MICRO + MAX_MICRO. This was to
> > simplify the check in a single statement in
> > pac1921_write_shunt_resistor()
> > which is called when the shunt resistor is set from *sysfs* (neither
> > from DT nor ACPI). I'm fine with this value and the new check but I
> > find
> > the explanation comment a bit confusing. If you could come up with a
> > bit
> > more clear explanation about the reason of such value I think it
> > would be
> > better otherwise I am fine with it as it is. Also, maybe use the full
> > room
> > for 80 characters per line and UOHMS instead of uOHMS to avoid mixed
> > case if
> > you are going with a new version.
> 
> We could completely remove the need to use a constant below INT_MAX
> with this check in pac1921_write_shunt_resistor:
> 
> if ((!val && !val_fract) || 
> ((val >= INT_MAX / MICRO) && (val_fract > INT_MAX % MICRO)))
> 	return -EINVAL;
> 
> Do you agree with this approach?

Yes, something like this would be clearer to me.

Anyway, I think you also need to check for val > INT_MAX / MICRO when
val_fract is < INT_MAX % MICRO, right?

Also, I think you can remove a couple of parenthesis.

So something like the following maybe (but please double check it):

	if ((!val && !val_fract) || val > INT_MAX / MICRO ||
	   (val == INT_MAX / MICRO && val_fract > INT_MAX % MICRO))

I think that usually it would be better to use pre-computed constants
instead of run-time divisions for efficiency but since the shunt
resistor is likely going to be set rarely, I would go for this code for
better clarity.


> Also, the use of mixed case was suggested by Andy to increase
> readability.

Ah, sorry for missing Andy's comment. I am fine with it if you also find
it more readable.

> 
> ...
> 
> > 
> > 
> > Best regards,
> > Matteo Martelli
> 
> With Best Regards,
> Duicu Victor

Thanks,
Matteo Martelli

