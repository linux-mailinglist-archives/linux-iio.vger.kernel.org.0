Return-Path: <linux-iio+bounces-24797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F97CBC05C6
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 08:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8E294EEE8E
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 06:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F322AE7F;
	Tue,  7 Oct 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6F4DWy3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12721A458
	for <linux-iio@vger.kernel.org>; Tue,  7 Oct 2025 06:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819523; cv=none; b=D3IkBS4T4qLyfJr209ou63lzrrbk2yaw+Ddb9RDgygXQz3z6RjS2uY3G8sC3EIFcW9nNHd7NVcTIhF9RFVQVN2a4v1EUufjoptEM2sMtkUSMuP4q9LbrQGznK22yjVHyPNjmw2Wa9qNcBSReEeGMWrQS1o7xPHnw7gvL/SHGI94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819523; c=relaxed/simple;
	bh=wN04ruwBF8mX2t4ch3708+WvxDoWId3SDn7ja/wo3YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOoMnkoL1YWUQIn7rokmjw/iXCF96GWokxgJRUNvRWkTGearOv+SJorBFJ+NvSG43zUoqotFNpQEgn+a2aY1gqfHsr4GBfr1VRvUEJ/CpO8fc9h6LM9jFVwjXj6vJIaCDGkTgP3+YkmaCmEYvdWUppwzCMhoxRwVjqUujS4xgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6F4DWy3; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-368348d30e0so54406991fa.1
        for <linux-iio@vger.kernel.org>; Mon, 06 Oct 2025 23:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759819520; x=1760424320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uuu2lzkPEMfNDjhll/Vwo57RHAnwsEsvb4MVNUsLQ/8=;
        b=f6F4DWy3VMSNoZMfeuctBnm+8VNRBqAr16MEy5k+nAAxIwovBIEurmj+Ds0+Iv1Uk6
         F6ts7PdBWPii8v4kJ/IU37g+MvQAJ/+8qle3zLKeoUPsYqYt8aKqWy+lbMx9aBGHq9Tm
         V3RAFXwKstdueoRFl3gFt6W1SuPCgTs3TQ+UGPalphPc6+1c1XItXif9piLxzrRuAC65
         r2lpg9lYo9M2KnDU0WjCHgN64AcbOvVu8Fr1FfifjnIvRpXqnAqjbIj7z9jn1OyeIPjB
         W+3E/qyHP3i1R76oLoNBE9Ziz42J7XUS66JlEg7nD+t4G8YNQyE2mxgY6i8++ZQVGuNV
         ntJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759819520; x=1760424320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uuu2lzkPEMfNDjhll/Vwo57RHAnwsEsvb4MVNUsLQ/8=;
        b=izxM6RxeAuZ1WIMDdvmNuvB5CQfwwsT0YBefFSrHO9pA/nGGn0O+S9aGKc+YHfDUGq
         84eduI/it37pfAKI9rKCOnENwYwz3oTZ751a1rn5p0YKxjb0eS92XwU3II9ZnU4Wt1bF
         cpZVxdeUoovv1VqEl2ifo8cb6VBSYhoJyO6cqBjxPDBZuoWtdBq5JDzyq29VdesF3U6B
         Hkv80yh9hzyI/304Guw2lQgjQe7BbYKm3BCA8AeYETNRquIoAxVFmtJRRp52gQZWJDZs
         qhqCAXo1XqNxL/W4ZOW+9U+eT1VQWL0Q2GHEIs4B2BZufUlU8m2DbCZdesxY4c1AzdXu
         +gBg==
X-Forwarded-Encrypted: i=1; AJvYcCWNeZ8b1hOV9lleOUp3LLH017Fr+n86QUrsmAxOz7SYC5Pl/HYXhmPC7Sk+yAb3g3sHahHH68HFSII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdqZR8kniFkSk71uaWhfumoaKXxNRFqvo0aeDt7zMUtTHXGqWs
	/u8AMb43TnPg/eqGipVf1Yy4PnhHfpDFNICRlHm2kw6KJCOkqn38UzARojGaggfdNLqhR/1T0gJ
	DyvwYndcCAuY7jTvRGie8Ua2x41mKcu4=
X-Gm-Gg: ASbGncssCv7kmIHbHzBvXgNvIb1yzktkRQe4tlVcq6EWWHKPiQ+AXT/tpixdGUsYJL6
	nF5eNiWkdXrnLKAyImuxzX1LGHsatpjRiR3mMa2H9iVtfF+sD2X1Cw+Qv7OjdhaFcBBEyUjmCKM
	nQ5PoVffLqVG1vwWXHprJNB8/alRjJ62IWl0ZBzbtMeMPGnNP8V/8+b3XPmSj0rkAu0JJ6EnT2/
	XC/arK9O+8iSvRPy9x1iqq0dHnW0SM=
X-Google-Smtp-Source: AGHT+IFUhuOPjVShvojOkNORDYcfkG57tc9JbnsqTlVqa/OxuLS0gKpps2AF9XTGawbbJ00RZIwVZzT6FP4bEoy5EmM=
X-Received: by 2002:a05:651c:25c3:10b0:375:ff2b:14ca with SMTP id
 38308e7fff4ca-375ff2b3d44mr1356781fa.27.1759819519490; Mon, 06 Oct 2025
 23:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002184120.495193-1-akshayaj.lkd@gmail.com>
 <20251002184120.495193-4-akshayaj.lkd@gmail.com> <20251004140809.5a629545@jic23-huawei>
In-Reply-To: <20251004140809.5a629545@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Tue, 7 Oct 2025 12:15:07 +0530
X-Gm-Features: AS18NWCGzbZGMO__XelRr0HqcxyMv3idbhYrMuheU6eMEKCXIpK12KX-yXcub3s
Message-ID: <CAE3SzaQGb_3a_Q2DFwNT2_Vmxwc+vLvYfZHOwzLtOQ3nV3GoYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] iio: accel: bma400: Use index-based register
 addressing and lookup
To: Jonathan Cameron <jic23@kernel.org>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 6:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> > +enum bma400_generic_intr {
> > +     BMA400_GEN1_INTR =3D 1,
> > +     BMA400_GEN2_INTR,
> Given the values matter, specify them both.
>
done.

Thanks,
Akshay

