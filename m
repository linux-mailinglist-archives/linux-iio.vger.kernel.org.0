Return-Path: <linux-iio+bounces-24798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9CBC05D2
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 08:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C134F3AD91C
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 06:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C322D4C3;
	Tue,  7 Oct 2025 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNMMNYk5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6C21FF45
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 06:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819610; cv=none; b=Tlj5iVktfgOzVjAfEvtO6N0VHHrWF5kuDu04zelRhaAWTyIRcpnNw8R/lrOZk8RBlP0eqE3YDckUzOLxCy5D/p08wroFE3RruhWmef/aOBaFdTy3MtIX5goi0CkMJ/RYR+tjBWU6lV78HB427hk0xejj8ZEjmikDxSyfkZQSbA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819610; c=relaxed/simple;
	bh=bdUUcvN2FlIOv+cXCHCzP0ZEOmw5wiYTT5nx3jKR8BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlA8j2iOjq6dsFNd7cDmzBU9h1wvTu56x6xT9GqYLvA1jVth+SCyXrITuNVsUFvAxS1ScbhmAURaY5VyGKYL6H5yPQGEby+kP1golTxVFU3UuAhKHYRMBTd7Fqolc3RQz/PZKPp/cFk99ubM/VCKv9L7HT4WmGTu+7TR5eRTxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNMMNYk5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-361d175c97fso57012851fa.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759819603; x=1760424403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouLTgsP/dL+VYka0KLm9xf7OR4U+ayB9IhKPeIL4RjM=;
        b=FNMMNYk5VnQrUrGzfS5tZ8GCp0R+qiOpiB6tjLyzkZeX0BBHwbtFYjnTcauQsebfeP
         stdkshnDBdrcxxdvsfviB7d22ls8lmCvDrvoFmzneyHZCmRblh7R8LQzs+eQnBGpylOU
         2YEqrQ0SOHtgixlhAfQgcca6RJORUAt3sCCl1hvpHKlJuiplJl0KaBH0118mPpaH/6zy
         ak+lVSirt0msD97TVuecXeiS1VGrBI/EF8Zd6dGtQmWQ6B+7NxQS2RDo5w5dXPFm6iGv
         qLI/Fw8mQ9P/OZcY1da5eZLPYtQ6DgrntjxpHKwfip1/+Vj0hXk1AEdAT/s3ZgvJemr9
         9Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819603; x=1760424403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouLTgsP/dL+VYka0KLm9xf7OR4U+ayB9IhKPeIL4RjM=;
        b=S8w/ocncMdnl+B6fos0JMtUa0M63Fejk/RLnL40tAuRJYpyxkEfnlciBs3Fj8IDO1Y
         6V/BHAIZcvdRu/b03pRK3TxrNJb4hbDTS7M0PIxuLCgk5A4X5yZRhd2xLR7mkFXPkcs+
         aYZVBB84EYEZRxTpf2pHgp3S8zl9+BlkKgl2ivvJcQ0FdKFiJqSelZ4Ou9afzrLRndHw
         McJJax9mzueCLIvpacRSVmFu+uCQp3tx1IcrQxAyeQN4JUnAMaRrj6STCdg6hO4cctoU
         YM3UTL7J7Jgkh2qSaQzj1iBdOJ/VhtS+vRzbsVQ4DfHK+ovUuacFmQxJlyNOqzH1hEN6
         2rcg==
X-Forwarded-Encrypted: i=1; AJvYcCV0z9Jq0XQcdykUNwkXpPO7ChIlbOYPoEkizcbgczS1SNEilPaGavLqzYLC4drave4ItHhpcHWqVfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjOYo+IXvmLNYqTiuO31Ygkbh1rlPfDeWpKjHBoTUgdtk9Ayz
	ryvLD+T0avp2yaSCL7WabHGsDGutqGalcSOZSxqK0mSDwQCKpeRAC+DZ3eCP8K8tHaR0AwSIlvE
	k/rqLnSxGTcPvyuvkxsp3JpnrD9OZzTo=
X-Gm-Gg: ASbGncuuaKtNQ4Ug+1wqvxH7CEbVTSX9CplW6dN1OJJWkQZs8f5s1RoJgKPxiweevSG
	K4FmDNt658yGXKM9ZsyEU+gdsoakejtb6Rx9MLjGQhPohAYRkJ/39tHKtY+R/W4RhrqwJCusPf+
	u5nHBVBdIZvm/DlLaPnFz8RvaWXmMQXljUv8HgPAt6e/SqhZVcvJ1h3t21anPrMchXUAy2+bxSp
	/p/egde6Q7T7hPeycOJIR1hExTi+wk=
X-Google-Smtp-Source: AGHT+IEdlOJ2MrVpBtb7ftpbczU5vSBj6YVyPhzA+Bp8l5exxa/OkACgKSRLpeqUWyWVhFVNu8hlpHdmtirgoemz21Q=
X-Received: by 2002:a05:651c:50d:b0:372:921b:4b7e with SMTP id
 38308e7fff4ca-374c37da0camr56699071fa.27.1759819602473; Mon, 06 Oct 2025
 23:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
 <20251002184120.495193-3-akshayaj.lkd@gmail.com> <20251004135829.531a03e1@jic23-huawei>
In-Reply-To: <20251004135829.531a03e1@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 7 Oct 2025 12:16:29 +0530
X-Gm-Features: AS18NWDj-Dl2DV2f_l8NseuUFP6e5ox0A_Xb4BZUTSeFz8ePOd_VWSN49qYGbfA
Message-ID: <CAE3SzaTaq7QFoRZMTd33e__ORsHiCMqBK0joVEdSt2YnEfhkSw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: accel: bma400: Use macros for generic event
 configuration values
To: Jonathan Cameron <jic23@kernel.org>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Fri,  3 Oct 2025 00:11:03 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
>
> > Add macros and enums for configuration values used in generic event
> > handling for activity and inactivity detection. Replace hard-coded
> > values in activity_event_en() with the new definitions to make the
> > configuration explicit.
> >
> > No functional changes are intended.
> >
> > Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
> > ---
> >  drivers/iio/accel/bma400.h      | 30 ++++++++++++++++++++++++++++++
> >  drivers/iio/accel/bma400_core.c | 14 +++++++++++---
> >  2 files changed, 41 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> > index ae3411c090c9..13fe2e5a3175 100644
> > --- a/drivers/iio/accel/bma400.h
> > +++ b/drivers/iio/accel/bma400.h
> > @@ -106,8 +106,38 @@
> >  #define BMA400_GEN1INT_CONFIG0_REG      0x3f
> >  #define BMA400_GEN2INT_CONFIG0_REG      0x4A
> >  #define BMA400_GENINT_CONFIG0_HYST_MASK              GENMASK(1, 0)
> > +#define BMA400_GENINT_CONFIG0_REF_UPD_MODE_MASK      GENMASK(3, 2)
> > +#define BMA400_GENINT_CONFIG0_DATA_SRC_MASK  BIT(4)
> > +#define BMA400_GENINT_CONFIG0_X_EN_MASK              BIT(5)
> > +#define BMA400_GENINT_CONFIG0_Y_EN_MASK              BIT(6)
> > +#define BMA400_GENINT_CONFIG0_Z_EN_MASK              BIT(7)
> > +
> > +enum bma400_accel_data_src {
> > +     ACCEL_FILT1,
> > +     ACCEL_FILT2,
> > +};
> > +
> > +enum bma400_ref_updt_mode {
> > +     BMA400_REF_MANUAL_UPDT_MODE,
> > +     BMA400_REF_ONETIME_UPDT_MODE,
> > +     BMA400_REF_EVERYTIME_UPDT_MODE,
> > +     BMA400_REF_EVERYTIME_LP_UPDT_MODE,
> > +};
> >
> >  #define BMA400_GEN_CONFIG1_OFF      0x01
> > +#define BMA400_GENINT_CONFIG1_AXES_COMB_MASK BIT(0)
> > +#define BMA400_GENINT_CONFIG1_DETCT_CRIT_MASK        BIT(1)
> > +
> > +enum bma400_genintr_acceleval_axescomb {
> > +     BMA400_EVAL_X_OR_Y_OR_Z,
> > +     BMA400_EVAL_X_AND_Y_AND_Z,
>
> An enum for potential field values only makes sense if you are going to
> use it as a type somewhere.  If not it is simpler to just
> use a define next to the mask for the field.  Also these should be named
> with prefixes that align with that mask.
> If you do use it as a type in future patches that's fine but the naming
> point still remains and you should specify values =3D 0, =3D 1 etc
> as they matter whereas implication of using an enum is that the actual
> values assigned doesn't matter.
>
> Same applies to the other enums introduced in here.
Assigned explicit values to enums in v4 patch series.

Thanks,
Akshay.

