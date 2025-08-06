Return-Path: <linux-iio+bounces-22326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D660AB1C0F1
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 09:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196247AA838
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521A219300;
	Wed,  6 Aug 2025 07:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUz3IkfC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153121773F;
	Wed,  6 Aug 2025 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463851; cv=none; b=Z304kWhwfzOOGUmNL4cwHNdHaU+JA5DHlE6ua6rk0mZUxixoITkhyFYenhoXRMRQqjAkAFvt8Z5fg77yB6JCB1fLvKPW7uKV5H4nXLO2XCiSfW2nf+4vYYruPDgehKUW3bW2fmJ0mOX+oPoruORqDJxmfPGB6poFnYys571lrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463851; c=relaxed/simple;
	bh=8UXkdIj2KKTxghd+Ie/sybWZyOAN/ou5VGvye1L/CQA=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfAw66zdEQT9GnT9IpSSUoC01YWmhPhiqXRxy8/8+DywP91goAJbB0ihWZDK8r4Z0Q9nbNkuto7FqbMg7ivg7UN/P4bop0MYtxDfxk3KsiRB84/8vFqamAndKbVTcveOmLXQBwxMT5gGNUUu1jb+iWD6HuS4pzUoFGbJeu3lr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUz3IkfC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddb41539so10161695e9.2;
        Wed, 06 Aug 2025 00:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754463848; x=1755068648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmZ/6RCWVOtcwdLcrSjqIJKUrn7Zsl9ifaiHRynfve4=;
        b=EUz3IkfCED5pD6CxQBBOT63GmqZHHqYFW7zGwu10Y372QhVLhhCcGrkg7STKIjpKSw
         ObGPOF3n0Ec31hPK+ldGBqPNxFF79NjY6XBB2V69AwFi5guFx0UcguhOJfBtSylk+YJZ
         81wkHI2D8YgWdobtckfakn62jIkirTjUZzSG8Mn+tJFUbAkWGKOl3UNr2iwQbjGtET+q
         vSdYrVWLrxQRDso7FOdYUs1Sce8FHOYZIZ3ja1r64Y9H2zdV4PdNgbZAcE5V1OxifROD
         46HELugDEFnkfKl0HTXjKjMbO8JwGOXgKE42pS1LTrQV/Pw2hbRAGDG7whxZwuagop2+
         t8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463848; x=1755068648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:cc:to:subject:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmZ/6RCWVOtcwdLcrSjqIJKUrn7Zsl9ifaiHRynfve4=;
        b=W09DMUFVH2XTNwZpxcdk+0ml+zQMAA6qr/hJ9P4E21nETznOsiXx0qGO5oBXn9A+nO
         Q8QRMR6tpV8IwRQtgb+iTXQKlCFYzVAa7etPnq5F785EIv5X2LGsb/xBaIOp4oYQJHlp
         FkDvLkCE3U/Aj54OBeruPbGpVRunm0AV135tOvS1kPx/psJXCbviniuk4vaSC99VgozZ
         7Zet5PzV2eQhLu2L0i56RtHYOG8iQdbgFXnXDG5QxjkhhgGEzZI8eG1xxBY8uILy+Mnl
         5rmYOlQyl/KuONkgNW+uHCkYxsedjm47gYixn3gj3gd057KVx3XwBFbHhOnUwSBI4HCq
         7tlw==
X-Forwarded-Encrypted: i=1; AJvYcCVfMS6A0lmrFtcC6y1U1csaW2lPSnkwVQ3q/xEkWaLGtgcaZ1cfDjUFGBQcUIKkr/HHmDG9VwDNg+M=@vger.kernel.org, AJvYcCX0R6mRUGc/n8kFFf8Tmdg8Z2a6k75P1cZbDA7siiPTiYSM3RtN2SshRKInoBrbA821PTlUbOuadj3hwQSh@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMLJY8YkxKy1wNMNnzwxypGC2YbcUmdzYY3sXiLEt27kinHT/
	KZpl9JG0QCcq5mkpXW6SCIVjfL6ogvCn5KSF02qsZ4BB/+uARLwxVLdt
X-Gm-Gg: ASbGnctw+o4HrQDRqsNdFHTo4afbBEo9EcwNJKv6iZV+B0JBFbd9uTCSEoKC+bRHoqg
	9zPUKV9spibEIbv84YLL7g7GB27j95t41Vsxjj44LmcrJxAdicSGPO1HwfV7Jla+yS2/NBjCGSu
	N9iSstm82cLiFxUyrzpfwwp33G/+fljnYK+5D/zr74gK0E2IjHtBKtt0K7QQbzJ/hsLinuDuIgj
	WF+BooPo1yXjmYqMGg7DZGv9/XxKtq1hNQr7sB9vX2kRptvxn6vKTYOvBNcYvbGMNnQvhtJRyAv
	AfdsReC67zJfGfYqwxgt5ZIlV+wUiMIP/UaMC4t6TlpEbLEyy02KHV/kRVDPPpZw82pd6UAMpeT
	5bftBhpZcCz9uDpsU5KKVIn9+XijOTnDONNgGDU1Z6U3cxZW8m74bng4pPhAkoJA=
X-Google-Smtp-Source: AGHT+IE5XexZbuxfSVv6NlHh2TsciIJIhOErVnDMu7opONBWHe8EiMXmL23fwmPcEW/qBEMLyiVLlw==
X-Received: by 2002:a05:600c:1d08:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-459e7450e71mr11984785e9.11.1754463847709;
        Wed, 06 Aug 2025 00:04:07 -0700 (PDT)
Received: from [10.14.5.169] (93-38-186-193.ip71.fastwebnet.it. [93.38.186.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dcb86d6asm93686345e9.5.2025.08.06.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 00:04:07 -0700 (PDT)
Date: Wed, 06 Aug 2025 11:03:45 +0200
From: Stefano Manni <stefano.manni@gmail.com>
Subject: Re: [PATCH] iio: adc: ad799x: add reference supply for ad7994
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9IEK0T.R3JGMPI97ET21@gmail.com>
In-Reply-To: <CAHp75VfCL88GMSRYnJ+wh85Yj_RrBztSLWOvQJTapVdgFerMyg@mail.gmail.com>
References: <20250805142423.17710-1-stefano.manni@gmail.com>
	<CAHp75VfCL88GMSRYnJ+wh85Yj_RrBztSLWOvQJTapVdgFerMyg@mail.gmail.com>
X-Mailer: geary/46.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On mar, ago 5 2025 at 15:13:06 +02:00:00, Andy Shevchenko=20
<andy.shevchenko@gmail.com> wrote:
> On Tue, Aug 5, 2025 at 2:28=E2=80=AFPM Stefano Manni=20
> <stefano.manni@gmail.com> wrote:
>>=20
>>  AD7994 supports the external reference voltage on pin REFIN.
>=20
> ...
>=20
>>  -               if ((st->id =3D=3D ad7991) || (st->id =3D=3D ad7995) ||=
=20
>> (st->id =3D=3D ad7999)) {
>>  +               if ((st->id =3D=3D ad7991) || (st->id =3D=3D ad7995) ||=
=20
>> (st->id =3D=3D ad7999)
>>  +                       (st->id =3D=3D ad7994)) {
>=20
> Instead of making this conditional longer and uglier, it is better to
> add a boolean field to chip_info and just check it instead. This will
> remove the churn when any new chip will require the same change in the
> future.
>=20
> So, please make it two patches:
> - introducing a field in chip_info and use it for the existing cases
> - add this field to be true for the ad7994 case.
>=20
> Is it doable?
>=20

Yes, it is. A patch series is coming.

> --
> With Best Regards,
> Andy Shevchenko



