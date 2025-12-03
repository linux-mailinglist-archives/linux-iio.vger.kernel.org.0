Return-Path: <linux-iio+bounces-26667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B120BC9E7D1
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 10:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 583E4347EA2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12D2DC79C;
	Wed,  3 Dec 2025 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8pI7XdY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F02D8798
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764754327; cv=none; b=brgW664W7JfWNpJrAJCbbnFasl4dj0eANNh17+V/4JQWwHOf7DSgOfGi8pkn8X1JiL1pDE2cGlBLek58B5Sadj99ms6aFFNtSQrzc7J04NAhsSQz4M2iVgTZy/6yY2Md5I44BzV0uVRCeFR4aNVYZIpwPoUxyKzrZx6FHLnnLW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764754327; c=relaxed/simple;
	bh=Ov9lBTahHZ8DCY2tULUkVLOZ4MMfY+oKwrCCt1yPykQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVp5a7eEK1DFeM3WdP3H2IDigdB5xfg78OHWm6zJ2A4uNdqc2KN3rtT+saFY7fKwSt0d5S5WnFz1kBI3i72F11i1LNPsScHp9njWgjoiy6V+N3kK6QR+qT6fyjhVsxAuUpBUXJKe4iefYqJMaphhi7aWC3/k6pEDr7t6msaocj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8pI7XdY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so4231719a12.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764754324; x=1765359124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov9lBTahHZ8DCY2tULUkVLOZ4MMfY+oKwrCCt1yPykQ=;
        b=P8pI7XdYJFU7ro9VygIVllD22PMkfxqVoURK/FlaGO/4oZ9tdkvPW3xXoViG8FGa48
         s3n3CjjQbN4aYDGfc+Z0nmGkBoA7jro2LFqulZ9xguUuNcIUAznVvpB4hd1+fMdKyHkG
         03BNozg/RcIzJP2d52ZtZooUgJhGJJCGZfG/k9Vt7gRcKp8Ca/sdfoxivCoVbwVewpUd
         dzdnP7DhYwGTME7LTF90N13SQMyE5sa711duLaw/s+7ESahTAEsjNqoU3oKONyry3820
         WhNJ+YcJsEgiyAdWHrIIiCf0gX4knVjbutMdqM5XYe0CWI28mhxw4ywQMy55fWKM4emj
         PnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764754324; x=1765359124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ov9lBTahHZ8DCY2tULUkVLOZ4MMfY+oKwrCCt1yPykQ=;
        b=fQmjo5bdS5USSz59NKpmMzVuvLiw+OwKkJ4uXkBLlEShAen5HDaMofHeB5DzkQeiWw
         0JFUFq84P0gbp9rG4XHJjsI/jlQRccqCcM6pGHXa5D1pDL+YeKwkFeoK2zAH6V02jO9g
         C6h+1+mzdEk+1A91OvATDb7DtqdZHlvZCXW2t+54YsdJBf0tbeMcSLk8VPMeJcWCH7t4
         YQrGkM1sYoKfFQj+7ZYfcQwvhytzeSE39AtlmjaYPdYGeZ/hXP5YlPsD5Uwoob5Lq270
         7YvnINponn66IsgbYY50cVuj2vECLMPiW/b4w+enQNEoi45jgYkHIWkdLMrl4MT3TgXV
         1Cjw==
X-Forwarded-Encrypted: i=1; AJvYcCXwuB3HQd4mAOhfDBRoe1d98xw26kg6aXERtm9LPRn/6MlK20ZxZDkwQ5EixqsLQqGgBtlocnZymGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5Fe0L4gvEybVJC7FmZQxCT2fIS7hG5gQtfaqsl+RREQ+J68A
	HKPVUbQ4lWqLoeP7sDu0qn1KqzqcD1o3uo1XL8F9QJaYiwMMhprJKrlfAJLtxWMJg4Cu+x0ahrp
	iKyXqKYQAmJzMbG0PKWG/YMWzdRkzZUg=
X-Gm-Gg: ASbGncvvN1Ubh8wqx5GvM09MgD+36H5lwWXqaXih1x/gtx+PnVGVxQtws2H5Ba9Yu7T
	qgHtc+yQbdxWOcPsHx884+G3hSKgIN5YgGr1qpFfmTja/iXXXVGePCMAdiSjeLqumntVlZdXadB
	vaqHC6/OxK5puy+zWnIvkNqLJhzoilO2VroOB0J7EQsZKUA0PGrLX/rRd18fV0JK5dlVOFnOvWg
	DCbIYnz2Wxs541lT833wbH+P02+wkcTqZHd41Ym7Eh6BRBniC/9NY4PdXGgoANrK7aCYg2koW4z
	U4nfSQ/kVDf6cyO+gBaD9SwwQVKGCXpGT4MAG/0mDw+KC/45CfItpbnkRl5vg8K28lNkAh0=
X-Google-Smtp-Source: AGHT+IHIH+h/UtRQPvhrgefbFBvEES88JRWs4WFtry+I+1btEm2+wVTsXIkcRyrS5uEhIJ+M14D8MywSNMuHV420wDU=
X-Received: by 2002:a17:907:d94:b0:b71:1420:334b with SMTP id
 a640c23a62f3a-b79dbe48fa2mr131150766b.8.1764754323573; Wed, 03 Dec 2025
 01:32:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-ad9434-fixes-v3-0-38d14f28456f@vaisala.com> <20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
In-Reply-To: <20251203-ad9434-fixes-v3-2-38d14f28456f@vaisala.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Dec 2025 11:31:26 +0200
X-Gm-Features: AWmQ_blZHwmgoCim-f1ubD__YxATrAsBy3KM4zThMkyMtWptf8Sx72YwMbEW9Wg
Message-ID: <CAHp75Vf4e4tpDiq9tygnqKztXHTx4H2pYosODgm-02fsHhc61Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad9467: support write/read offset
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:28=E2=80=AFAM Tomas Melin <tomas.melin@vaisala.co=
m> wrote:
>
> Support configuring output calibration value. Among the devices
> currently supported by this driver, this setting is specific to
> ad9434. The offset can be used to calibrate the output against
> a known input. The register is called offset, but the procedure
> is best mapped internally with calibbias operation.

This version LGTM,

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

