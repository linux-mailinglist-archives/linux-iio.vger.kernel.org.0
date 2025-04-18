Return-Path: <linux-iio+bounces-18278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF83A93B73
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B0C188996E
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE69217701;
	Fri, 18 Apr 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lr48npnZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0941DED51;
	Fri, 18 Apr 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995399; cv=none; b=XoRQQ/vSYjr5wl+Fxjx9ztcAPkL7+sEtBCsACS0ZRIulmKzf3xfAkddQKQ99JlcW3Zw40Ivb2OaEkWHNJH6NrSnQhkcx8hJdNbVdFxMmuJfhkvssofFvbyBmEpG/PIODoDM4YcewlP7dRgLnZYtd8iXr3tjONduOcKHr5pgK3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995399; c=relaxed/simple;
	bh=O7T/++NqyVHJUCBmNizNFjjdmPvqntc/LpS5w6yPJoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJuo6saOUwe2LemQJSHoEcG4uGmq0dvzB6d6fdocQXDMtCNxoeseoTCdA3Q049xgcCgSmNl/FEjT4fWbfYFMOKhTVrutYJGusGb/5trnd5HdwNC+P6GFgBoZPvEqrBJefEZ4xCCPaaJx0HQslRz01Bf3eNJxvI897NUxFRHzC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lr48npnZ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b89782c3so22965181cf.1;
        Fri, 18 Apr 2025 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995396; x=1745600196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jaGJsH+S8jpQO9hSU9jQZG5RILNp2wtg9XnJDjLa18=;
        b=lr48npnZ04BdmEl7RpgGXU3hz7xENcrm8WFMB4EkG7151FTg3OUe6GRPijU9CLIoMK
         WSTuSdHV4aAa7w7M4mdzzLTchn0VM9STRAxd+hYpMFtIufM45bq7fPtJw6AOOs/EWOFp
         QlhYTOh2GZYi0dAP353OFGtEgtwg35bccl6B5UFXJT8FPodIqn9+3b8lIYBaSkYHQXQS
         1jjiGdhmEpk4iOjvzLyEPDf0BPTKT5WEAd5yXnN+8QGyn39M6AcPh0c4BJIQKq4vcB2I
         6Jk8CGZV20+F4OXOgTP41UmSzSlsn9FXN1tR66iDlmnx7JZNkeEcirS4zBLAO+a4NznN
         ufGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995396; x=1745600196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jaGJsH+S8jpQO9hSU9jQZG5RILNp2wtg9XnJDjLa18=;
        b=dxjmivZQnuOAAq0ThfHbamorkbzMSyF6WLAcMIBxRvWqKG190y3ifTKDrB4npwGuSA
         95UhpQHCZU2c+K/Ye428BQICTR969V1Z4UyX2pzRxERtU/jd4M3CJbKIV0Bdf0K2D9J4
         GOEOmKXs9kkHb/GFRFFZMfGqFwaNcl7oW7nNE2zkpBlUyDk/Y6jU8k+1kiX2wOaTNQ4M
         vH1CFrJ2SeaqUE8LC1pOwwpUQXfGsTM2A7W0FMS6EJlwBgZmWNSRCFTQm7CsCPJ21BNX
         105adeZx5dxBkbU6H8jQSHiBY9UKqotskUrAGgC4V/tq/Yn+4WKBvY8mLnA18ro7bsEt
         axaA==
X-Forwarded-Encrypted: i=1; AJvYcCWHa8ZcuegS735uZCAm+tGxHtikpegmFu4MnnpbTzoVaNw0c9IELURaTWA/Owq3uWY1V8GmxzSJ/e0=@vger.kernel.org, AJvYcCWaD1ewTmQw4zL5hhMCzGbNj1XecnXvTD1d14fI7YiyA1bGR7sHqsMs5EnsG/Y2qr8SLp8wNp3I@vger.kernel.org, AJvYcCXeUoa49iCnq6JTSvvKVoIr08Q0oLeK/RbTxt1jD2cwS4qt0gSw+1GVlYRFrbqF4svF6+ANpcS/Isc6kM7U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2DmZlnBpyiifo8ll5hJR0iXoQyWBIeZhCAMW+cSzcu6r4xp8V
	DOPP3Aj2RzKfY/gPa4qo6fL8Kliynom6vyouGW2DsX3LW5F49h46/FHGrSVFxIZ8E925nQKx6av
	kSTVFcSUs48oxZJGoF02o7xzMArE=
X-Gm-Gg: ASbGncte5XpAJPsPdJUUatsX8DI/vehyi2kg3P0hlvwmurvNKMWiLyLVU6fQqHYqT7G
	ih3nZPVEtC7RmWvc2Fa8aWIR/yDk6aWjwjcHKq94/+kZjS54xTZQm/V92SpC4TwxWp/OJcrST+d
	BXpSRye3c7UznrRS93WSbruNp/gR5xugsbBhPQVDeFQvelNOgs0nbn
X-Google-Smtp-Source: AGHT+IG2QUATXIP2+rB45u1mzURWs/cHRUxQnEqv+a0uOxz+PDpzzpxSpuZBbAQBnMkO/jkpMnF7kVt3ZbL257up+2A=
X-Received: by 2002:a05:622a:1a96:b0:477:6ee2:18ce with SMTP id
 d75a77b69052e-47aec3543c7mr63069171cf.3.1744995396324; Fri, 18 Apr 2025
 09:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414154050.469482-1-gshahrouzi@gmail.com> <1fb5f1c5e61ce386cb431d48296e952bdd560a6c.camel@gmail.com>
 <CAKUZ0zLiP_w-4xOXfBDdZbm+M8yVYvd+A=M73fnRT_kMyWwk7Q@mail.gmail.com> <20250418161841.4ba1d05e@jic23-huawei>
In-Reply-To: <20250418161841.4ba1d05e@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Fri, 18 Apr 2025 12:56:25 -0400
X-Gm-Features: ATxdqUFg7My0cJl2r_WyXXpWhu1eFcrdLyqNpZBk2FWlOi3nyhGlEBznApakYhU
Message-ID: <CAKUZ0zLW-X9oNxEhh++65y1cjX5c77v=kqqvGTaATaBXCs-Neg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: adc: Correct conditional logic for store mode
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, kernelmentees@lists.linuxfoundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 11:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 15 Apr 2025 09:54:00 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > On Tue, Apr 15, 2025 at 5:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> > >
> > > On Mon, 2025-04-14 at 11:40 -0400, Gabriel Shahrouzi wrote:
> > > > The mode setting logic in ad7816_store_mode was reversed due to
> > > > incorrect handling of the strcmp return value. strcmp returns 0 on
> > > > match, so the `if (strcmp(buf, "full"))` block executed when the
> > > > input was not "full".
> > > >
> > > > This resulted in "full" setting the mode to AD7816_PD (power-down) =
and
> > > > other inputs setting it to AD7816_FULL.
> > > >
> > > > Fix this by checking it against 0 to correctly check for "full" and
> > > > "power-down", mapping them to AD7816_FULL and AD7816_PD respectivel=
y.
> > > >
> > > > Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devi=
ces")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > > ---
> > >
> > > LGTM, do you happen to have this device? It would more interesting to=
 move this
> > > driver out of staging :)
> > Unfortunately, I do not have this device. However, I would still be
> > interested in contributing if possible. I was looking over
> > https://lore.kernel.org/all/20230716144024.30ded663@jic23-huawei/T/
> > where the goal seemed to be to modernize it by replacing the sysfs
> > interface with the iio channel. I also looked through the datasheet
> > and it seemed to be missing some stuff like a channel that can be
> > selected.
> > >
> > > Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Applied to the fixes-togreg branch of iio.git but amended the patch title
> to start wit
> staging: iio: adc: ad7816:
>
> so people looking at a short log can see what it is touching.
That makes sense =E2=80=94 it's clearer for anyone skimming the short log t=
o
see what it's touching. Appreciate the correction.
>
> Thanks,
>
> Jonathan
>
> > >
> > > > Changes since v3:
> > > >       - Tag stable@vger.kernel.org instead of an email CC
> > > >       - Use the correct version for patch
> > > > Changes since v2:
> > > >       - Add fixes tag that references commit that introduced the bu=
g.
> > > >         - Replace sysfs_streq with strcmp.
> > > > ---
> > > >  drivers/staging/iio/adc/ad7816.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/iio/adc/ad7816.c
> > > > b/drivers/staging/iio/adc/ad7816.c
> > > > index 6c14d7bcdd675..081b17f498638 100644
> > > > --- a/drivers/staging/iio/adc/ad7816.c
> > > > +++ b/drivers/staging/iio/adc/ad7816.c
> > > > @@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device =
*dev,
> > > >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > > >       struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > > >
> > > > -     if (strcmp(buf, "full")) {
> > > > +     if (strcmp(buf, "full") =3D=3D 0) {
> > > >               gpiod_set_value(chip->rdwr_pin, 1);
> > > >               chip->mode =3D AD7816_FULL;
> > > >       } else {
> >
>

