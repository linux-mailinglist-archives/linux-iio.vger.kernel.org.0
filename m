Return-Path: <linux-iio+bounces-24083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43AB5621F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C167B8092
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A372F0C43;
	Sat, 13 Sep 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/bPDilu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609FE1D2F42
	for <linux-iio@vger.kernel.org>; Sat, 13 Sep 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779105; cv=none; b=pFYU4p0HeAhBQnJCMaL7obq5OZjZAAfLvL/DFLJ3U2KWdvMUC0iglvLGuG7qiheEJ7CkJbcZFYm639Y15bcTB7PDUBg0gn+eLXFQazL8MXlzJtfkbEj/FcdP6D8QC6Oa2KeU2Kcs2OPLCd9HisX7xKYlSi8qbavT6qpPEgkWJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779105; c=relaxed/simple;
	bh=rd5duYH12Xz/FGV8UlCyO33oFNYr0Ad1Xnc44e5ocxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcaiTgiw/h5OU8gqMTj0PYJDbhXNueIN0GvG39OodxW6vHNZ5IO3Z+U/ZOEqO44k+Bbq8UwFu9w/GXDWpmH52wbGW8syrOsfOXDK3v4ecTs7QwSo6XUkBU4Dm7LebxQ1fHL59HnPIS0SfKVrxMFXu8bwLTnY4xhYw8akGLTbt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/bPDilu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336a85b8fc5so24994881fa.3
        for <linux-iio@vger.kernel.org>; Sat, 13 Sep 2025 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757779101; x=1758383901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STPznDHAlzoR8wOYOfYyiUZewXx+IN+gvaJ+ucobHZo=;
        b=C/bPDiluxyc6uf+XoXyeMLCA2mg0eqYtR6K17TMz1VFWqxffw8greKoFMmKvVYkpnT
         wSjGYNfwClT3DusN61wYISyrW8MHj0cCWXP9yQV7OjxfoFgj/Msj9qtxsPURQGFV+oGt
         TJhVhg+8Uw9Cpdm9hZQTdI8cCNH28dS2PHkZ38IGOlvmMQ4R6utzk4Q1FWwsgiVDVJ9B
         lrEm22BhChaPpde8fnGbtq1pOX+wQHwTKzZ2vxO79OzZtL6mOzSHkDb1C3rtoxIbhllY
         Ie+kAL3Wb1w8qItQApMCqWo/1zqR1pU7xnGscphN7ByLPuilnk93J4wRX2onGtSk4VSD
         UjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757779101; x=1758383901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STPznDHAlzoR8wOYOfYyiUZewXx+IN+gvaJ+ucobHZo=;
        b=s/RLtpDSn6IirZCCg4tknKZBeJdIX4xEPDriAcBZS8ym2U+gmCsYJW1jLmDNL5uuls
         37p1BwDV8XKE85mYWxWn58BCPEwlnVquUZUEyI/S/VEbvTUhWLC3nBhTID1S8UKEDdpZ
         wXfdInBHxjDailxpvB5BWqGnfwuFqc3Rrv2nORLgjHUjYlXSLFeGZGH1swaEvdfthpg9
         yiHentjOFT8eAPBj8VKwvx+AIbQHmYb02f5nVEWtXkDPSemZucwaEux9lInRGtB8oAZH
         rIUgw21wLcvdMGDaX4R9LO9zemKRxDseBHo60wFxTiFW6J+6zXV7DQNHAP1bn9EOmKDZ
         Petw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ujavwx1sWDtb5B1AmT8SIFZTJ4bBgYrZlcU4LMySrHQSE+6Z4xwZojUXBXFj/B+ZdCjwZFsZzo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAOMkmzsVBsNoWXJbKk25lltJJF4gUtnr91Z1n+k1oG84bwtY
	jyBuASw4kweZUxoDEw6hcxz5P0LD5sr9n+nIETbYo48JnZg1018O8RNor90tEZ36t5/AfcW+nhZ
	rAAcySXstmLhIcl/5xKEpkhj4QwgwHgU=
X-Gm-Gg: ASbGncv/gdgCszxaRVY06MjGMSjC3DxWHB655GM03Gar9nFsnjSgKAj89ns+4vtR8ub
	Hqx91VG0q2UxdTJa83XSs2Zb7FasRKUzBa24Lc5/9lFE6svRoz/SdsicTj7fI1YFoaj4sZRDD3o
	kK4QbV0tAONjZmqLBiVarAJla/5dhP6VfDR3GBgEDlDFKVDyqbWauzdqiLwTx1SgKNjcq4q8CK5
	ODU5GignQOlnkRv0Ts=
X-Google-Smtp-Source: AGHT+IHb0L5yNJeTuf/oTzXtv8zuGGmc7dBfuM11RoVbcnaLRU/aOxZEktUzHZvRwj2Sex/XbVKZf9apK360uZW6D8k=
X-Received: by 2002:a2e:a9a8:0:b0:356:25da:89f8 with SMTP id
 38308e7fff4ca-35625da9513mr1295011fa.16.1757779101195; Sat, 13 Sep 2025
 08:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
 <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
 <CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com>
 <20250910201212.5d9f57bc@jic23-huawei> <CAHp75Vf+9PJgR5Eev_Z+QB4cp+VMctFfqpTMWuE3VsnGpZ6dJQ@mail.gmail.com>
 <20250913131724.111fa939@jic23-huawei>
In-Reply-To: <20250913131724.111fa939@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Sat, 13 Sep 2025 21:28:09 +0530
X-Gm-Features: Ac12FXw9OM-XFQW2KmaRQPZ8urr-2VJv9_1ylLjDIVpGRpgCsyl3gwIi_4dXe40
Message-ID: <CAE3SzaRLQZ4=8oPmehL6unR5ESAULN_p=xK-qNouUpFO16szpQ@mail.gmail.com>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, anshulusr@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jonathan and Andy for the support.

Regards,
Akshay.

On Sat, Sep 13, 2025 at 5:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Wed, 10 Sep 2025 23:24:22 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Wed, Sep 10, 2025 at 10:12=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > > On Wed, 10 Sep 2025 18:06:32 +0530
> > > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> >
> > > > Thank you very much for your valuable feedback.
> > > > I do have a small request regarding the review process. Over the pa=
st 3=E2=80=934
> > > > versions,most of the comments have been about fixing indentations a=
nd
> > > > improving code readability. I would kindly request if it would be p=
ossible
> > > > to consolidate such cosmetic comments into a single review round.
> > > >
> > > > I completely understand that incremental feedback makes sense when =
the code
> > > > is actively changing, but if the changes are minimal, spreading out=
 minor
> > > > suggestions over multiple review cycles tends to unnecessarily incr=
ease the
> > > > turnaround time.
> > > >
> > > > Your support in this would help me address the comments more effici=
ently.
> >
> > I can't always see _all_ problems at once, I am not a robot. I will
> > try my best, though.
> >
> > ...
> >
> > > Andy, if you are fine with the explanation I'll tidy up the minor stu=
ff
> > > whilst applying.
> >
> > Yes, I am fine, go with it, thanks!
> >
>
> Applied with this diff;
> diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
> index 2d8449aeab18..a2b804e9089a 100644
> --- a/drivers/iio/light/ltr390.c
> +++ b/drivers/iio/light/ltr390.c
> @@ -284,8 +284,8 @@ static int ltr390_do_read_raw(struct iio_dev *iio_dev=
ice,
>  }
>
>  static int ltr390_read_raw(struct iio_dev *iio_device,
> -                          struct iio_chan_spec const *chan, int *val,
> -                          int *val2, long mask)
> +                          struct iio_chan_spec const *chan,
> +                          int *val, int *val2, long mask)
>  {
>         int ret;
>         struct ltr390_data *data =3D iio_priv(iio_device);
> @@ -749,7 +749,7 @@ static void ltr390_powerdown(void *priv)
>                         dev_err(dev, "failed to disable interrupts\n");
>
>                 data->irq_enabled =3D false;
> -               pm_runtime_put_autosuspend(&data->client->dev);
> +               pm_runtime_put_autosuspend(dev);
>         }
>
>         ret =3D regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_=
SENSOR_ENABLE);
>
> Thanks,
>
> Jonathan

