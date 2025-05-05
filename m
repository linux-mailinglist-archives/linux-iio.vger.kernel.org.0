Return-Path: <linux-iio+bounces-19103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78EAA95A8
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9043D189BD47
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953225B695;
	Mon,  5 May 2025 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juBUJjbO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C5846C;
	Mon,  5 May 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455091; cv=none; b=DLczVGnsgG7ZzQKugfz0FoQVtQQ+uSIWL49+6Y4c9n8L5lRN/rqgyk7Eas9JvswfP9/1IbMjgfGA89/nBUSBzoOxBx4x2ciUOP25DO+PdFfPX2nSeSDaTAYAmF34OJ++21zv+DbedNLgCQoTdBg+Tulgvp6qAI80UYrXjEHg6uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455091; c=relaxed/simple;
	bh=GB7ADHbBJlymyluovD3/Y6mm62xeoJLwTowA203SZvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaST9FlfvwX6fHt38AF3dbWMBYYdvzyaz3eqsJ0rJF5R0QYy3HrPDCZjnM066VMLT+04Y0eQCFT/adbiwqgFfMuAD+SrIjm9r7cop9qirJ+U2nFY2eO78uaosYv+K8ceZHquHmMa7PH0z0IHgjLuvS6s3JQ/a2A4SdufZmRmi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juBUJjbO; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54d98aa5981so5395081e87.0;
        Mon, 05 May 2025 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746455087; x=1747059887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WGFSEkeAZiWksKb018fmfpHyOvjpAP1mkHklWaIOjo=;
        b=juBUJjbOZp/626eUbkj49EopqIHSJANuPxEsGB8HaKKMqbuV0r8mkTDJD609CQjkSv
         IPrgKL2dc1PkOQUHhqdYvH+Fa+crF5LhJuOjbMMHi0r7GAISnSugW6tQBRmXTR0MKB5F
         cd7ZpA9qezNfC1Qxh+AX+3D7zA9l9s2nL8dG/AKa2VSBzwU72OklRyO3hW6qAgjGlD2b
         7tyR97JcHxlaPdf7M5tkq3Id99E+2B/brSS2TQElWh/JYN4WQsuLz++zB6Q78h8Nrh4I
         asI/QGq58Vi5C55icMLOnKvN8mwd1FxnDvtmwH2+CCO/u6AZSz0qznBjOnI1yHmx7gPd
         9oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455087; x=1747059887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WGFSEkeAZiWksKb018fmfpHyOvjpAP1mkHklWaIOjo=;
        b=iu1ugYAMy0XbSWXh6ny/p8Zkx1l/2hWczpTpMqkEdlI9q6xva0gc96MwA2ywjwHDbE
         BDEXoV39XkEC9F/jiRPZMvjKQB1tQyQNs0DuG50AdlatGBNMQRT5cdHEGKCioFD4Gz+a
         99etSxikIba9Ib7jU29IsDL1utrRjwycLbw+yTBdgFEd1LitPmU78tHj9NHoJMLq6Q34
         6Uf/0FVca2u0vC3j6IX+KYsZzLMmysbllJ420UHX9iXb676dl77Z7t2XqAIxGNRU5txk
         OLOGk5gXbQ5sjk1D+Wj5u8PO354YH1085+STnC9dMAgzerLKtrRtuGsnQIRqzKipO5O2
         tnNw==
X-Forwarded-Encrypted: i=1; AJvYcCUXVpjXkJgfrwQY52oFHLmI8tK5PhZryaUPAOIT0hy67tYgZ0/aLTmc4ce25abx3b9rZKZBSfsl@vger.kernel.org, AJvYcCUsjUfU8zla2KUryRUcKI7b+R+LxyFQjmVFuC1x3IdTv/vSUU62FbczHuS9Ndo9rgRuFUI/xq1dkP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+MEfWRbor+MzbDT/ktwBW50aok243369f9a85cvKBkNZjL3M
	8u5peuxlptDLaZEQMEIMDz65+UejHdHRSyEBo0WPsCpTeYBDu9WMjxieNSjCKgSuvPPqpWb0bSG
	aHz6tcD6/I4c0ql6Ou0EcQlECpIM=
X-Gm-Gg: ASbGnctK+m6j7noP5QXlX9G/6dfs1LInF9RTTIY0nzSYfzyMJaMPPOMIiyG2dEX9lgX
	VNMTAjWJ2ku+jKUEHNmFoEQuJQC6R8xFt9H/QveX2DzsyUv1VxRWKcORzyz9/19+i6GONQYGGZN
	DS8XQ8SJQObvO2IT54DPRoIl3SVR3/dmpPSplJ67OpLLZ6Otb+NgDVtdIOYo24NBcl
X-Google-Smtp-Source: AGHT+IFux6nXhUX/K7s04dLBPKVcwKLs4V3tjuFUHYMRRPkkEvOV8Mlsassg4yc/OxzeBLi4urSl+tSPJ64E+AuCRVU=
X-Received: by 2002:a19:6a11:0:b0:54e:8194:9a72 with SMTP id
 2adb3069b0e04-54f9efd96bbmr1550690e87.28.1746455087333; Mon, 05 May 2025
 07:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429150213.2953747-1-festevam@gmail.com> <20250429183301.326eaacf@jic23-huawei>
 <CAOMZO5DBpF+iO4NY4-tn3ar+Ld+c=SA6W-UKN0haWmAK=4g-+g@mail.gmail.com>
 <CAOMZO5B0nxVEW1Q-a05j8f+=waAYijvBq573Ha8DNbOgF0287w@mail.gmail.com>
 <20250430141112.00004bb8@huawei.com> <CAOMZO5CYuv94N_8ZepH04y8ez1CAmOJOq4eim=dLGmMFoStQ3g@mail.gmail.com>
 <20250430182537.00007eab@huawei.com> <CAOMZO5BCLWFJ=83r0saT=NxVP0f9G-P-2QosDNGArYAtX6v5Lw@mail.gmail.com>
 <20250504180420.73b96437@jic23-huawei>
In-Reply-To: <20250504180420.73b96437@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 May 2025 11:24:36 -0300
X-Gm-Features: ATxdqUHAdyZF-dfSxY2aJGVPlzADAxmQQ0f5pvbu7RKFc7H8wpxrQIpF4Fu8qrw
Message-ID: <CAOMZO5DeMNGqpF4T7tuvBBN=i95uReSTXkj-sNW2jZTUO++5ZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: Fix scan mask subset check logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, mazziesaccount@gmail.com, 
	linux-iio@vger.kernel.org, Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, May 4, 2025 at 2:04=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:

> Ah. I was wrong for last two channels above. The scan masks for single ch=
annel for
> differential channels also index a bunch we aren't using in this device.
>
> > +       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),    =
 \
> > +       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),    =
 \
> //gap here as we aren't using 4,5  6,7 8,9, 10,11
>
> > +       MAX1363_CHAN_B(1, 0, d1m0, 14, bits, ev_spec, num_ev_spec),    =
 \
> Should be 18
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/iio/adc/max1363.c=
#L262
> > +       MAX1363_CHAN_B(3, 2, d3m2, 15, bits, ev_spec, num_ev_spec),    =
 \
> and 19 I believe.

This works fine for me, thanks:

--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -504,10 +504,10 @@ static const struct iio_event_spec max1363_events[] =
=3D {
        MAX1363_CHAN_U(1, _s1, 1, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(2, _s2, 2, bits, ev_spec, num_ev_spec),          \
        MAX1363_CHAN_U(3, _s3, 3, bits, ev_spec, num_ev_spec),          \
-       MAX1363_CHAN_B(0, 1, d0m1, 4, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(2, 3, d2m3, 5, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(1, 0, d1m0, 6, bits, ev_spec, num_ev_spec),      \
-       MAX1363_CHAN_B(3, 2, d3m2, 7, bits, ev_spec, num_ev_spec),      \
+       MAX1363_CHAN_B(0, 1, d0m1, 12, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(2, 3, d2m3, 13, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(1, 0, d1m0, 18, bits, ev_spec, num_ev_spec),     \
+       MAX1363_CHAN_B(3, 2, d3m2, 19, bits, ev_spec, num_ev_spec),     \
        IIO_CHAN_SOFT_TIMESTAMP(8)                                      \
        }

> Maybe we can simplify this and make it less error prone. These scan indic=
es
> are always the same as the enum max1363_mode entries in the 2nd or 3rd pa=
rameter.
> We can just reuse those I think.  Only the single channel ones apply here
> but those are the first set of entries in that enum.
>
> Bonus points for just dropping the parameter and using the existing addr
> parameter for the macro as si as well.
>
> That is:
> #define MAX1363_CHAN_U(num, addr, bits, ev_spec, num_ev_spec)   \
>         {                                                               \
>                 .type =3D IIO_VOLTAGE,                                   =
 \
>                 .indexed =3D 1,                                          =
 \
>                 .channel =3D num,                                        =
 \
>                 .address =3D addr,                                       =
 \
>                 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),          =
 \
>                 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),  =
 \
>                 .datasheet_name =3D "AIN"#num,                           =
 \
>                 .scan_type =3D {                                         =
 \
>                         .sign =3D 'u',                                   =
 \
>                         .realbits =3D bits,                              =
 \
>                         .storagebits =3D (bits > 8) ? 16 : 8,            =
 \
>                         .endianness =3D IIO_BE,                          =
 \
>                 },                                                      \
>                 .scan_index =3D (addr),                                  =
 \
> The above changed from si to addr

I tried this change on top of the previous one, and it still works.

How do you think we should proceed? Can you please submit formal patches?

You can add:

Reported-by: Fabio Estevam <festevam@denx.de>
Tested-by: Fabio Estevam <festevam@denx.de>

Thanks

