Return-Path: <linux-iio+bounces-22666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF6B24AAE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 15:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF902A139A
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C42E92A6;
	Wed, 13 Aug 2025 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+c3ns4O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278E2EA156;
	Wed, 13 Aug 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755092122; cv=none; b=PjRtUyfxKt3/II7RD1OQG0cEgLp2yC3Z5iBF+iKUhilKp7yIIv2wTL4yA/s8vVVngzIYqHh1DjrmEBsOFsxIedMuA3ufgdXGeuo3XMqc5+NNEicdgpjwWb7uxYfRaKELQzs3l6On64X2hSDbUUlgmU207vFX2dLzZ1n4DGKqAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755092122; c=relaxed/simple;
	bh=hgcJd3QqysiwCHQpRh0bTK7ORjduiUaVN5l0qmILfsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfgnTqPF+PLiw9AqUb6oH1TeeC42l81vI1N6GlJhOng2BT5sC8fxvtLrsywitnAwsB+B73Zi2EfAMi2V1ZGHx15n4SKsyaiXd6QOHd5Cyw/6IhP6SYyNQDiP28pGUHES9iZEMVorYmE9iHWbi6VVoA7hauaAsPe9E58Obwx3TXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+c3ns4O; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-33250b6be11so53999021fa.1;
        Wed, 13 Aug 2025 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755092117; x=1755696917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EARc6UA4fn2fiJrlmMwodVkJgApjWH0B+m0N76D9p+Q=;
        b=A+c3ns4OcHEIGjeyln4pOMSltfcDspkOI2Y7wes9p5GxNJotRx+sT7xrF9Rox/JOQY
         e6dvKexID+mfPpr3+eBYg5v5dw9h17y5JKIgSfKHa8zCDM+lsVpVBlLVPOYuTwi3gqre
         /dSXqJumU0fyxSpo3M2fWOgT+eJDRYqrpgiB6QhmMAz/8MT6Wsyau2GGvFlGijWB6k6p
         XRJxNWL1R49TOnXbuQ39WXagCzUKza+NEPGsGYP+QQODWBzJESZJj5SS/uhMKSMlxp+W
         8acdexYSSCd2nAd2qeNOA2v8Gn3N0cHGlZkNen5Bl0gF3sTAV+xPtZc3LZpdL+Q9S4/S
         +mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755092117; x=1755696917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EARc6UA4fn2fiJrlmMwodVkJgApjWH0B+m0N76D9p+Q=;
        b=rHDWmR/Q2uoKjOBXQ7b1Npxdwnu9+ypRadVTyHp8v/pB5vEIF1kvEkUTapjU6FFMRh
         7CIVVOSp0hJCXdH6D7qbt5Ay8Wafps5Y0YUPnE4rI7jvo+VkakFmVvS8TUZF/7s01Uvp
         csrV+OIOdNIVBEWLQBag/vMcnGcvgtBAsKG9AU0ilDgEBMQKY9wxWp3PFR4zh+VYWeoh
         ksIrBnJ1eliwp6e/MnmfI63zO8nGYu+0YzJjxbOD+F5pRfJTwbPqCrcDGG0VNpVBbuS2
         exMyEq/nJ+Xr5pvgEcjFzXMJaoD2fiphP5JyW4ZCJOrtaDdJdOvmpWVGPG5hgvL9WEtf
         rV3g==
X-Forwarded-Encrypted: i=1; AJvYcCUUvOpDHZIS3ZRrb7rCRvfMvzM4carVemyMcAoEkYn7pNxzSGC7Ex6vRXXglvJ1B/HldxGazjxX4IU=@vger.kernel.org, AJvYcCXVHpSJ08qm/nyjO9g3aFm5izh3Jyxzll3XbYi/OCAF79cf+UnNx8lkRswAwcT7w5T1YLBTxbrwSRLbBMSL@vger.kernel.org
X-Gm-Message-State: AOJu0YzccceF6FWLm+u/jcJpgT7UnXTVIFC17q4ohuGSpw4hfr96IOIp
	MvJePYaxyK0Fx9uanuTZ4z/o3ooVtkrZTnHCSLLm0ekKqIaU5JVmPJ83EyfWkyenbm+Khd0qTsd
	+SzBvQapCfA1WrLgHnMicmCem4MvZNc4=
X-Gm-Gg: ASbGncs0+HXzc4nQTswMo36Dk7pyRnklkjTarGgxssyxhnZ08D2GQH2vYWbOu/lrLzK
	+FqdLSXlWH/Xqre446z3HTGCobFUXnVCoFCVp9Tf/J3VGcwH8lrvy9LnWxpn/9qbRoWhMBcNp9R
	BgjkrmMiKCaUYvF4M83/jF4lAxBcMXPGaZiCCw1qKre+kWz7nnefsxyQpRYjWAWaB7vfVN+0yDk
	h6CO80Q
X-Google-Smtp-Source: AGHT+IHVKKYCrmhMqanaZuSISqAC5KYT5b+/X/2biC/c3z03uQHmT4DQshvmQZCCLPh48kPWWxT99EOsn2t6Fx7FOdQ=
X-Received: by 2002:a05:651c:41d0:b0:32c:bc69:e954 with SMTP id
 38308e7fff4ca-333e9b60d27mr7762731fa.37.1755092117180; Wed, 13 Aug 2025
 06:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170723.51639-1-akshayaj.lkd@gmail.com> <CAHp75VfPNDzvxu8znHn45iS9Db_=E7A9nf2xmtVnY8cAi1HnfA@mail.gmail.com>
In-Reply-To: <CAHp75VfPNDzvxu8znHn45iS9Db_=E7A9nf2xmtVnY8cAi1HnfA@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 13 Aug 2025 19:05:05 +0530
X-Gm-Features: Ac12FXxSnyBGrDVVHNLuFcBGpBS6spRE0erPSN4mWRuR_XgDbErWWUrwWOtELhU
Message-ID: <CAE3SzaQW0w9Zq57L9Qz9fwcqqARr1funORVr51hpqRBgBOapaQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Add device powerdown functionality
 via devm api
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sent a v3 for review. Acknowledged your comments inline.

On Wed, Aug 13, 2025 at 3:43=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Aug 12, 2025 at 7:07=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> >
> > Use devm_add_action_or_reset to do cleanup when the device is removed.
>
> devm_add_action_or_reset()
>
done

> > +static void ltr390_powerdown(void *client)
> > +{
> > +       struct i2c_client *i2c_clnt =3D client;
> > +       struct iio_dev *indio_dev =3D i2c_get_clientdata(i2c_clnt);
>
> Why? I mean why can't you simply provide a data pointer directly as a
> parameter to this function?
>
yeah that is much better. Done.

>
> > @@ -693,7 +711,7 @@ static int ltr390_probe(struct i2c_client *client)
> >                 return -ENOMEM;
> >
> >         data =3D iio_priv(indio_dev);
> Stray change.
>
> > +       i2c_set_clientdata(client, indio_dev);
>
> I would suggest moving this to be before data =3D ... line above. And
> add a blank line after it. BUT, read above first.
>
Done.

