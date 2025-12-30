Return-Path: <linux-iio+bounces-27418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C09CE877A
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 02:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB3E13002179
	for <lists+linux-iio@lfdr.de>; Tue, 30 Dec 2025 01:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6E2DE719;
	Tue, 30 Dec 2025 01:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl1hjz9j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD22D9EF3
	for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2025 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767057215; cv=none; b=V7e50GeifKXFKhYf7szEVTDc7yTpTzggR0Xru6vEH3s/Pl+hBI/jRDLFvq3rpQgCATsH9MVVX66ggghSnV4HrulF0clXldE3sW/D+xpGIerO4LtV5D0CFIS6uxr46H2qNFBhqtunB225ln/zPjft07XfIp2uQQptN07LcqwNJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767057215; c=relaxed/simple;
	bh=wt7UDoKY81UPq/wlsT699pMW1pwS4sLyKYlX2Q+XjXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9rgxGTZ4Lc0yIT55W8N5TjZO6BDv6lYnoDBW5KmNbShsP8xjUn7DWp+oSemHMSwQEHh1pGZAzDRq6LHgbH4RhkVIoiDjTPOw2d7vR6kew8VXeqRkWF9IezzkWGEVn4b4+6xFPQKk+Wa1H++FuZJYShYqAAhNv+VKkcmgtLBSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl1hjz9j; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55b265f5122so1906752e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 29 Dec 2025 17:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767057212; x=1767662012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74jYKa9+OupKCj+T37gNUTTsdOJyf+ySCP+SjAOd7eQ=;
        b=Zl1hjz9jKalmhh3xFs5HDzNovsI6txoBxiH3vDc6w0gDyX1Ca2x3gJZl4PknJUUI/J
         VwoaPWBOgxDCiT0j2DlDu7dbsD3RD7bxjI/qKj0GgdoAHtdDRHi1WUTh4PNJZb9jkzAu
         uNmRQYBZ6hMtjbLt385flSY0ts2IoNf7SqLElHt1sZi4Zkf+uwFqj5Cv4tIzy3NRxUBo
         wmRf4VxRcx9xmZbKuuiM09ew0pIv6n2E7ITRavHHBf5fxzkSG4unz//fNXAyTw0Th2wT
         BLkEnact34UEW6TFwe+IyvRf3r7iSsrk9mPx5PL+fUrsqkTGaeNtWblJaho87Yu3BJZe
         YAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767057212; x=1767662012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=74jYKa9+OupKCj+T37gNUTTsdOJyf+ySCP+SjAOd7eQ=;
        b=R4BaMiPNe1ES6KVB4eLuy1Xg02pUwEXCF30Kk+jNtGRnNiRHfjlkzQQ/Ei1AlUthpC
         eANxfE+OoYklnXGKBC9ojOpVNReRLoTd3NvV8K6bCieGNODrP0TixvVrk2Yf0ggZuHtj
         mUf8+vp3IfvRmnfbzpqbPbyTY/dr9PbBsUzvNZLeOk/+IGmKXn+xUKVCo09+LzVbcLLz
         lBZuViG1UAJ5nYjHV5GGTKk/2+5GWxQmfvr95K0sG1PspqPfZfTvzDYnWmUC/CPViaW1
         snLWTwO29L9PaLxZ4exoH32J6Jke98qoFz+LRwRMzDLONo8Shu4hZN5LTGNkMVSf8Qte
         fD9g==
X-Forwarded-Encrypted: i=1; AJvYcCXS4Uzfs5bvO+aqiCmi6e9JGT90W6nIJnhrhZo+HGI5bhM0MOSwNak0GKsPAAJ1v+QvRLGeXKEOnOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwlYtvuXfPru3aw8Nga3yhNkat9nIvX3/TIs2isjXdvLmZ1BL2
	0kXzMsN1hUXeC6SHojwyOl8dIXQMKojkpPQ8aH+9JYr151mNvCDlUpvXKiEWd0FpfsQzLU/tUk5
	9O7+puprO9IUfsTpdbj8Iv6H/Nq7wcM8=
X-Gm-Gg: AY/fxX7kuoFW0nPS+o9usCFKWtH9Cd8SUb4+uNF9leDaSM1GmQJ/Gi9mtLOpt8qihGo
	B4Q1l9QhELDqAKyVBNggEsieT5TJ78F31w00Pq3/Be76C37spq7siEg0ER9U+Pof7ny+uBiz4nE
	KO02Jc1RQ/A5ZvxTEUMbhn+XDMctjbYdqsFAnFZ1IldZhweKJiXfRZUznnigl6BysBdMuSkFIqh
	R518yyGZilD8sUYdF/dyMgzJRtiT7fwBOxiqUOFh2gv1/p1SIe++ocsNoxdkHPdi1Rq0v7t
X-Google-Smtp-Source: AGHT+IEo9vxlydYJ4UDGmaiDCnzBqdGUATcD2xzIk1Jy+AqG8YjBq51DC2k8WPzmeI+vqaYGF6acNP+EaD+sr557lIY=
X-Received: by 2002:a05:6122:32c7:b0:559:6d45:9a1c with SMTP id
 71dfb90a1353d-5615bcdadbcmr10197743e0c.3.1767057212557; Mon, 29 Dec 2025
 17:13:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224-add_ltc2305_driver-v2-0-061f78cf45a3@gmail.com>
 <20251224-add_ltc2305_driver-v2-2-061f78cf45a3@gmail.com> <20251227181808.3dbe5b0a@jic23-huawei>
In-Reply-To: <20251227181808.3dbe5b0a@jic23-huawei>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 30 Dec 2025 09:13:20 +0800
X-Gm-Features: AQt7F2ob2iwt40n30LG6yvsqVQ7RHejvs_MQprdo67ifEsy8DuDGnIoEi8qIWXk
Message-ID: <CAF7HswMKGCt_HWMQWxm2G0hxqk6-2GHRDCfYF+vow5srmFQvPw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ltc2309: add support for ltc2305
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025 at 2:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 24 Dec 2025 13:37:15 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
>
> > Add support for the 2-channel LTC2305 ADC in the existing LTC2309 drive=
r.
> > The LTC2305 and LTC2309 share similar features: both are 12-bit,
> > low-noise, low-power SAR ADCs with an I2C interface.
> > The main difference is the number of channels: LTC2305 has 2 channels,
> > while LTC2309 has 8 channels.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> Hi Kyle
>
> This is a fairly small patch, so don't bother doing it this time, but
> for future reference, if you are doing a refactor to enable something new
> split it into a refactor patch (which makes no operational changes) and
> a new stuff patch. Here first of those patches would introduce the chip_i=
nfo
> structure but only for existing supported devices.  That can be reviewed
> easily to make sure there are not functional changes.  The second patch t=
hen
> adds the entries for the new device (which can be checked against the dat=
asheet).
>
> When it is very small, in the interests of expediency we sometimes don't
> worry too much about the ideal formation of patches.
>
> In line I mention that the ltc2301 would be very easy to add as well if y=
ou
> want to do so.  Otherwise looks good to me. I'll leave it on list a littl=
e
> while though before applying.
Hi Jonathan,

Thanks for the review and feedback.
I appreciate the suggestions regarding patch splitting for future submissio=
ns,
and the tip about LTC2301 support.
I will  keep that in mind for future work.

Best regards,
Kyle
>
> > ---
> >  drivers/iio/adc/ltc2309.c | 51 +++++++++++++++++++++++++++++++++++++++=
+++-----
> >  1 file changed, 46 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > index 5f0d947d0615..0cf9bcae36c8 100644
> > --- a/drivers/iio/adc/ltc2309.c
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > + * The LTC2305 is a  2-Channel, 12-Bit SAR ADC with an I2C Interface.
> >   * The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> >   *
> >   * Datasheet:
> > + * https://www.analog.com/media/en/technical-documentation/data-sheets=
/23015fb.pdf
>
> If you wanted to, it should be trivial to also support the 2301 (I looked=
 given the
> odd datasheet file name!)  For families of parts it is common to add supp=
ort based
> on only have access to a small subset.
>
>
> >   * https://www.analog.com/media/en/technical-documentation/data-sheets=
/2309fd.pdf

