Return-Path: <linux-iio+bounces-20036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93FAC8D01
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 13:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF5E97A7B79
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342C821D3EC;
	Fri, 30 May 2025 11:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcVOgxdF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4619F10A;
	Fri, 30 May 2025 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604905; cv=none; b=W6x9himcJfJk+Yo9egeXHeqjKME0q8Ouhwls5VL0ZRP+A5pzAaqUzZYluOtuHTSAgvpn6OmdyhK2kq1TMPkFBcd7Q+yPmm64R7b3ZZJveNjH/zOCsguPRVCtlQzk/P4BCWhvRBBfZ9hR8fcN8GPd+WttdvqRN2owPQPyhFrYtDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604905; c=relaxed/simple;
	bh=CG06fp9oxw2A9Hp9lU3htFVmuec+nEGVCdamaunhVZc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oxd7E1f7/II2wrQazwZnyNbUWg+M98ViRUvhw1bV0W+BHHuJi3Mkoj0uqmfiqyI53ZIfcqNw77QPfUsYYyXqSV2ZQhcDbfX2GTdsH5OYiVdhbs3R7hMQFjwf/Z87i3s2OmpSXxhGbt+4j2auIwDs+Bp+AC1tEZbQPuMHOOXINWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcVOgxdF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so1155056f8f.1;
        Fri, 30 May 2025 04:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748604902; x=1749209702; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBpe3PrQUq1ns6R+TSo33OXoWmnCrWav1Gc9aMJzuC0=;
        b=VcVOgxdFueHnOXKCMxv9tddDpSw5rTSHnvlmbNkD0G2o61YZ++955Wa+RiYbxqDUsn
         tFBbxpXhw+LB1pU7TsGDellDe7DmFMtRsoCWXKWfpUbaj82h12lVk9VqZLyuf+4IGpll
         0QzTZ70tOUqMylF74/3HJsfgjduyfsvCZbU4mjU/8xgdYEtczJIbfJQZo0U+k0Xk/BHF
         wFQjEaWtO6Zd9oc4CXjCyUWRaH667aLYlRBdL3j82p6ze4fPOlGc+cgWYy7Y4uTh1IkG
         oD36B+r3QfxLQQMn1o47Lym5QGpBE8smiBJzUxNRf6qW90llwvPPOTrpOF+SkcQsa0Dk
         KTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748604902; x=1749209702;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBpe3PrQUq1ns6R+TSo33OXoWmnCrWav1Gc9aMJzuC0=;
        b=kSJzcbJxgOc0qnrdwW7le6wsIhTozM6Qit216ABB3utVtr/ZZ0QW86V0Asyqg8zgnm
         ImjzSQcsX6pWPclkdmaXSs2XOtbppxD1lfRbnhChWshtBxyrEPeEqgmLmNivqhbbxoIL
         eQzqMLYT1n/KQmldX9gvI8G7Nu5zLmVysIKeE/getHE6uOlBSNvWfaCPtYvzkeul+eSq
         rGGunOgfBiljEhdijwA6yuiZ6bjNnj3llR3hARXkvQT5xZzisHyEPeE9oqWQ7slnrCA6
         bjqxFQLJRchli/UR7k6HkoILSi+ADIXe2YmvNr6wn4sCgA5wx9yAjFj7vTAuAEVlKU2v
         /Vsw==
X-Forwarded-Encrypted: i=1; AJvYcCVQzt19WDqdsyqAcc9iYsavOb/ewxDMAWrJuqGNHhmSXdUwb1INieWnMdrut+hWqOmRlYO92lptkwY=@vger.kernel.org, AJvYcCWJDlHo6pNE3k7LLf52DLtNS+fbORjSoZ2/wUlXrS38750PS9mnLYzznPyZ0MdX8LZYlKSnUbrnbgjrwR5M@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPEvD3A4be4FmEORf0MfeY8lJ8+B73aHZ7VubJMJ9KVHAq8DW
	0gl5iUPQGoI3cIo9V4fbSK8RM51roO5gR+UzhGseZIKzRRJLgBAMWSuBzqWsoIWE
X-Gm-Gg: ASbGncuF/ryZBKXbRojR4Mic80bhlTNj9g4IKDIxm/3t9IeoX/4O7/Q5hyebtVachm+
	1yFUvBCIaQMmFEqiL7vlqJMhaeoOMJnyXwuAc4VnfYVrOHAKNGU7wTw9ndiFEb/Lo2YCYEi68w3
	jnHQMlcY8owFDGKdBOY6rkvcSQvEgi5LIo1xxPK/ioRkbrbM+sKJiNYADcf4EiLc6Rn6birxOd0
	y37m87mhUbEk3uLwIpA7DUWjmvD8I9hlf5MKXP+WkmtlABwx/HQrsoxGyJ5JwT6i85+UiYt8DyI
	Km5HEmzzvRqmqRDeFKto3AyKSUJKL7/Dee4w30jFEgtdNAfmquEotwh/97c=
X-Google-Smtp-Source: AGHT+IEoOAfnaxRfbQwqOjAF0PRksoZIKNnV5NXFbl/T8R/8GbaKzu40Keb71uToE+k8fQVEZ3Pm2w==
X-Received: by 2002:a05:6000:4283:b0:3a4:ddd6:427f with SMTP id ffacd0b85a97d-3a4f7a6e56fmr2382612f8f.35.1748604901469;
        Fri, 30 May 2025 04:35:01 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73eebsm4535990f8f.44.2025.05.30.04.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:35:00 -0700 (PDT)
Message-ID: <9e6d503cc7715e14c5fd6b219c123166d1cf2342.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 May 2025 12:35:05 +0100
In-Reply-To: <dv72cvn7rihavqxg6wnybhedhunabo7bremwb5pkutqljwarcf@eo6zc7vi7fbu>
References: 
	<20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
	 <20250529-wip-bl-ad7606-reference-voltages-v1-2-9b8f16ef0f20@baylibre.com>
	 <521f5868-5836-47d9-9a68-88a9d4e843f6@baylibre.com>
	 <dv72cvn7rihavqxg6wnybhedhunabo7bremwb5pkutqljwarcf@eo6zc7vi7fbu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-30 at 09:39 +0200, Angelo Dureghello wrote:
> On 29.05.2025 12:52, David Lechner wrote:
> > On 5/29/25 4:13 AM, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add optional refin voltage enabling. The property "refin-supply" is
> > > already available and optional in the current fdt dt_schema.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad7606.c | 4 ++++
> > > =C2=A01 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> > > index
> > > 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..21e63260965c32988d0ab3b8bb1=
201aa
> > > 2396f1ba 100644
> > > --- a/drivers/iio/adc/ad7606.c
> > > +++ b/drivers/iio/adc/ad7606.c
> > > @@ -1335,6 +1335,10 @@ int ad7606_probe(struct device *dev, int irq, =
void
> > > __iomem *base_address,
> > > =C2=A0		return dev_err_probe(dev, ret,
> > > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to enable Vdrive supply\n"=
);
> > > =C2=A0
> > > +	ret =3D devm_regulator_get_enable_optional(dev, "refin");
> > > +	if (ret < 0 && ret !=3D -ENODEV)
> >=20
> > < 0 is probably not needed.
> >=20
> The above code looks correct to me. What is the issue ?
> =C2=A0

Not that there's an issue with the code. I think David means that ret > 0 h=
as no
meaning (function on return values <=3D 0) which means that if (ret) is eno=
ugh.=20

- Nuno S=C3=A1

