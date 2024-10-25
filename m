Return-Path: <linux-iio+bounces-11300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB69B0D68
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91B091C22E9E
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DBB20BB28;
	Fri, 25 Oct 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLC9spTf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C531FB899;
	Fri, 25 Oct 2024 18:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729881222; cv=none; b=U5bzucBZMDHMVO99cR9DK9JXN2P8konhwqDmwMS5Z33VIZ+t+Xo6Ac8+vha+qRLDErXJY5nwc75NdalYbSwsNb/znNHeqlk34o3POQVqa4NoGbgL8n1T+OIgoaLFQyOGNlP0ml0/afSGryvt3K10LGyOlKXyKHFGb1eLE89mJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729881222; c=relaxed/simple;
	bh=PFuF2Y9/+ewHm3GZ7MwlHRnV69cbNKKUlmjY2oSyAsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzIoFP408PzsItjv9iobQslZhe5MkbkqcRws4yp8yd6oEQNoRJPLCeszLlKD1aKkjWJYvmzN5SVHDoVHbS7o2p+7Y65eT4jX+XjWJeUFtZHwkbyivVFPHouv+za1bFIgSN96+HLZNpQ6/qFDgL+XINSnzAL01IXALFD3AHfAI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLC9spTf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539983beb19so3026080e87.3;
        Fri, 25 Oct 2024 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729881218; x=1730486018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNHfasfIV5+HJoEc/2e6AI/MHWsXMOc2lwon+csxK/U=;
        b=DLC9spTfvDaqIgTVB6kJ1Rjga/WBcO4Kxbr5k99nWihUjrSq0XaNNFsexktBywxEQx
         JllBovscVKDCkRBZ0uASFzIM85dOTJTFsHjQ3xydv4sDvH3aq5tlEYIHiFeKXmZ4R9+Z
         mgk9UnPEeCQ/5+AJI9LPZj1Wz0/N7RWCUirZF5mW6bCii11ith9aNufLwo3XkweLbkGN
         A0iF/cJMBun80cxAtFeSKa3I6bjv9haWCYtqpSPPRFBIv0UJ074HiR5mXYnzjnY/7CTH
         ipgwLa8TLFSSnnCpmJ7LHJiE80SffslT4Vp68O4RTUUnvoIVr8Kl8Z0irelFi5wee1eS
         ZXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729881218; x=1730486018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNHfasfIV5+HJoEc/2e6AI/MHWsXMOc2lwon+csxK/U=;
        b=QLtSrnl770jlGIdH8KOTzg/Y8kWH1sMnG790V+Xn3MP2CWMvgrLEvYpKbuVJt+wYZJ
         qV2XqYuxB/7WvOZeG5fnRVY9rLp33EYsFYpC0ZLF/+uQUJBy9CLIlHunIgQL883fP5WR
         dzZJeDnh5/jV82/zan0I7Vfg/k7iPHXeIyn4YZxy426BT4k1yPLLNDHM8IoNh0WQPTbC
         LMIkhLxYIebl33MkpSLXvgxE9DdSBq6nk5Nv2xDIQ66kjKIRdd00QhOELt+OVNA9FH3N
         U8FKdFHW0ziblc8Z+KBiCWcKzbUzoIFvr5jJD0CfVIypHjiEI5jzmgbDb/n/Fg4xkL0H
         lPtw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZvQw0Vq0OFiv3ILnNYVxQqRh+L/k2mevMbQzz5/uHm5NBx0ItF6buFuQo65WRiLWKU5zCE426QH2G08g7g==@vger.kernel.org, AJvYcCWDHYhvAObduKgdWQvY2GUayAZWWNxEa3olu3CVphTsW2YprHqTVKO575Knv1cjlWYd7Glq8x2gbNDHDsZ1@vger.kernel.org, AJvYcCXhA88dKMgBXPFW8Onph0JN5MxqD2SBuycbyiW8dhKmB8IHEnevIt/DZv7cPhERyqecXo8O2qVKzK85@vger.kernel.org, AJvYcCXr71Yws29V4S66eqmRr2htK5XGIrgrxqiIrCZNHbRNS+e1AETCYLehzVts1NjvF9fimWJMBT8TQOXY@vger.kernel.org
X-Gm-Message-State: AOJu0YytztOZgDnxqr4kFzIm9H5GmenFkAGnIGUOajoISB3HTljO1Jt+
	OR/JUo9gMZK761KQryI/95kIziNvPcY6aOcaGYO3nrqMjBWpI3IbqwXjTjqvCIdJDCiBuA4y4J4
	sD13TqWi8pI8GlUvd7Uw+3x13aO7P8gMA
X-Google-Smtp-Source: AGHT+IESY941DMsos/v9jY/70rLdmFnnc61/VqhA8KDMnRbz+S6+o57bGRLKhxNrPoktyz1hscuRItPt5KURAyt3OKg=
X-Received: by 2002:a05:6512:3baa:b0:53a:a26:5690 with SMTP id
 2adb3069b0e04-53b348e57d1mr97390e87.34.1729881218147; Fri, 25 Oct 2024
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714173431.54332-1-rayyan@ansari.sh> <20240714173431.54332-3-rayyan@ansari.sh>
 <823ce598-dffd-4983-bffa-32559558235d@redhat.com> <ZxpZfgsf-KldiX4w@black.fi.intel.com>
 <20241024173454.00006240@Huawei.com>
In-Reply-To: <20241024173454.00006240@Huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 25 Oct 2024 21:33:01 +0300
Message-ID: <CAHp75VegkzEgbZhFxQpW=hi6foRvRtoe_rs47kimxGOCXwGPRA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: Add support for KX022-1020
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Yang <decatf@gmail.com>, Rob Herring <robh@kernel.org>, 
	Sean Rhodes <sean@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:34=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Thu, 24 Oct 2024 17:28:14 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jul 15, 2024 at 10:30:46AM +0200, Hans de Goede wrote:
> > > On 7/14/24 7:33 PM, Rayyan Ansari wrote:
> > > > Add compatible for the KX022-1020 accelerometer [1] using the
> > > > KX022-1023 [2] register map as both have an identical i2c interface=
.
> > > >
> > > > [1]: https://kionixfs.azureedge.net/en/datasheet/KX022-1020%20Speci=
fications%20Rev%2012.0.pdf
> > > > [2]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Speci=
fications%20Rev%2012.0.pdf
> > > >
> > > > Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> > >
> > > Thanks, patch looks good to me:
> > >
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Note, this patch broke kx231025 case...
> >
> > > >   KXCJ91008,
> > > >   KXTJ21009,
> > > >   KXTF9,
> > > > + KX0221020,
> > > >   KX0231025,
> > > >   KX_MAX_CHIPS /* this must be last */
> > > >  };
> >
> > ...because this enum is used of ODR startup timeout settings which
> > are all moved now to be 0 and new ID inherited the timeouts from
> > the KX0231025 case.
> >
> > Since I have been looking into the driver, and I have a few patches
> > coming, I propose to do the following (as it's still ODR data being
> > missed) to:
> > 1) revert this one
> > 2) apply my set;
> > 3) re-apply this with the fixed data.
>
> > Another approach can be done (but probably not by me) is to move the ID
> > to the proper location, add ODR startup timeouts or explain why it's no=
t
> > needed and then apply my patch.
> >
> > But, taking into account that we are almost at -rc5 and I want my stuff
> > not to be postponed, I tend to follow the first approach.
> >
> > Opinions, comments?
> >
> > P.S. FWIW, my set will include switching this driver to use chip_info
> > structure so the similar mistakes won't happen again, that's also why
> > I prefer the first approach I listed above.
>
> Hmm. Either I want the revert in before the release, or your series
> to make the merge window (and hence probably hit in first couple of stabl=
e
> releases).

I have sent the v3 (out of 24 patches) that includes revert and a fix
in the I2C ID table. Those two can be backported.

> Ideal would be revert very soon and chase it in to togreg so your series
> can go on top, but that would rely on some lucky timing of pull requests
> and merges that is probably too optimistic.

Up to you how to proceed, the patches are available in the mailing list :-)

--=20
With Best Regards,
Andy Shevchenko

