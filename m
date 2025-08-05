Return-Path: <linux-iio+bounces-22310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD3B1B410
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 15:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B47934E250A
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749026B2AC;
	Tue,  5 Aug 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlCXZQK8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43908231853;
	Tue,  5 Aug 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399202; cv=none; b=b8XuZHgady94G/6ZJoErq3Vev0Syor7j9KNXQtMBqvkifYW3bRajfmtdxSMetWcML3esrdsudaKyyk7SSoSb45O/fCu+hGuyGgHOhUonTuSeS89qUIZiY+Xa2cxTo5/WwHDZQ65iAta94MwhLVkPmC9PeJyyXfqZLenz0zrQh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399202; c=relaxed/simple;
	bh=MAh02TkFyzgFFZr3oxHjXV6dZOI2X7cgUfbU3vh9k5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNfd0GSn+WzajxaewlX8UvGybEtN9EJgdHq5mTQAqJSDT/ANVU4Cq1uNXCvuowYybMFEwPtrFZYfTf3byt3VxCpQwTbkqoUQfgDpLgm5Es7bSshrh5mkKgQOW8JzQUtkr9mzSousCyPFe2FoP14ojQUJrIMMdXJRzUS6ub6W54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlCXZQK8; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-af9618282a5so508369666b.2;
        Tue, 05 Aug 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754399199; x=1755003999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAh02TkFyzgFFZr3oxHjXV6dZOI2X7cgUfbU3vh9k5M=;
        b=RlCXZQK8FKv5xziJPK3zjklobEcAvaDtnnS8YTmhRaJ6gUaVDsJLwGjRO2R/oKgrpX
         BRj1QsGdpoqIOxz5yaK8KXcEkOB5bxVaMveaqiC/6MAbvosonFUIDnBfIehUmV/T600v
         EAZgX9d5RX+XHdghS1AMmDeFBL0OYlhrz+hoN/UCHYEN6tzP7dPcA5vpGQoxfwTsECCh
         6d3WWwSUHUN2Juq92y0VDnwbD8IakHZAIAwf8yEABOwmqhq+0/HYdlPrP6LbwrJU/YTw
         Bz10vYFWbPYg9KsvIeLD/7WNV2m0z7K7gOciJmFX87Yt9cLUCwty/EcdgLKS/gqIDfCR
         FMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754399199; x=1755003999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAh02TkFyzgFFZr3oxHjXV6dZOI2X7cgUfbU3vh9k5M=;
        b=Go7j6u5K/HuXdcgUD/CvXDE/1+LNjoX8mzlMdWR2KhA9U+IG5U5WAt/ke3PLn5mL3y
         iD4XtA+FIYd+y+a9qWJl3ux0lPqiyhoCXMOcE2Lnnea9xK+m+OMena4oufMvohfUQ3cM
         E1qoA1D4zWGK6brYWHjClTxWFnFsM+TKp2FdGRIP1ajYfoppxs6K0U4GW+MguRYULmdF
         zeTRskOxA52uuEPFWq2zYNuf4/nfFjwGscMGN0Fh9KmsbGn/iwqtjZDXhUMJN4rS4g3W
         J2p2EWutPOQ2v+T1L4aZ2b9miseKB82upb4Frs+qz1DEf4ULtDO9UIVYivqkqGcgDCUb
         OINA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJs1Y+CLJ/jtXbXYaP7vgVCiQk5LhcXt21HEbBWszV0P025QhB9cmrS91hQ+1FH3Xchg7PLo28Hc=@vger.kernel.org, AJvYcCUuYi2iDb4kvZ86+OD/WIUFTeCQGqUQ1seT/0E9FNZPJFDHnpmn9sDIzEhPS8w5CEsYF35nfeJgwXbrIIeo@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSQYqCib5JaqxP4xFTIaFMZ68zH3yqCraTfXLryvIBlim9Lq7
	3UB41BV3tyVbh7CnYUHokFEiDXpujbwljSnEos40ItFg5ZXTqCpuV8PMC/PIziy0EYUNsOdN+97
	wUZRoaWShPboc3khBn+7OR7m1FSSrSMQ=
X-Gm-Gg: ASbGnctd4KxqbvsnCIGX4O5XtWVQ0fiA/FjM6jhKRcz7/hs+Qq666HkCIVFsVGmy6wt
	ueRt5Pi5Zyri5UMvaf3PHENDZs7Ow+y5Vlu2nVOBNmp+Xpb25c2/hwg5yr1oEsw11i6x87nC9Bz
	y9LuVFhBe+YaHVeKwUr/Zai+KH/YkUBLqofybgbM5dfLos+K7uJhNHtdOqWZXU9sgJvtZRqxNbD
	A0rOh4RZg==
X-Google-Smtp-Source: AGHT+IG+UhvnR8PgL0a0Zufs5S7y3V5pfr4M4F2QIupH8Wrp93UHwXEqXJVmQMM5LOZynRuY87KMSNBR1QBwOUx0aD8=
X-Received: by 2002:a17:907:6e8f:b0:af9:3a3a:227e with SMTP id
 a640c23a62f3a-af9401bb461mr1278298266b.38.1754399199235; Tue, 05 Aug 2025
 06:06:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pndectqm7te.a.out@axis.com>
In-Reply-To: <pndectqm7te.a.out@axis.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Aug 2025 15:06:02 +0200
X-Gm-Features: Ac12FXzfhgsKY1Z4mDhPlXC5tTUlolIHxAiCVq_7VMItomP-88jysmgI3xJFCTw
Message-ID: <CAHp75VeGvgv6TAYRRtEySmESkjygW79ms-Yd64h08_+7JjJMJw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: Remove error prints for devm_add_action_or_reset()
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matteo Martelli <matteomartelli3@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Mudit Sharma <muditsharma.info@gmail.com>, Gerald Loacker <gerald.loacker@wolfvision.net>, 
	Song Qiang <songqiang1304521@gmail.com>, Crt Mori <cmo@melexis.com>, kernel@axis.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 11:33=E2=80=AFAM Waqar Hameed <waqar.hameed@axis.com=
> wrote:
>
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.

Even more, the devm has tracepoints in case somebody really wants to
investigate failures.

Fully in support of this change.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

