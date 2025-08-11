Return-Path: <linux-iio+bounces-22603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA0B215FB
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02628463ECE
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C062C21E5;
	Mon, 11 Aug 2025 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VanafQ32"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1B29BDA7
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942043; cv=none; b=V11N+HlWIkCrgrL3aLAnprXWnTZzjeifh6/w9gf0dZGeaqYx2Ajb1MlV6ePDXuc3ICvBl15grzcMsYgyeTuQBNqPk7B6Lav4RlXilZ4PEHzz6bExgGP4TkuhY+EM15XZuDhI3iPAt1LhAEj9Tnyu9npFpWaySv5BSSYaakKMsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942043; c=relaxed/simple;
	bh=/nstwjjukfkrgOntv1o9MxxzClq9/Ltz2vm8rR6Ldgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+I0zI8g05dc3ek22cRoQb8fHNUqTx57UuuVXqdI6u3J3mNGr6pmsgF/tuKOkxKciM6QZ+wegnnZWbPUwxfWHtLiuvpctdW/9XGhvE85pvxfkM1bW+Ylt6odVcAR/qlAu8SeauUuvS0qDUaRNypB/F4Vb+OeLi3aIOwm1VWdhiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VanafQ32; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-615d0b11621so10059942a12.1
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754942040; x=1755546840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nstwjjukfkrgOntv1o9MxxzClq9/Ltz2vm8rR6Ldgk=;
        b=VanafQ322q3qSwxPH1fQqs+adqsnyptGwEnFX5tqQl9Y+2YdBUVTWA69vvD8U4+Y74
         7I5fxplQbQ+PiwvjhjQngznXsm4YyL/BLKaBJi3C+NIvWIkDBcaV0gC1bv08jBOOweky
         rujNzP2cI9Un61HribLaPtfKRfUWSDN3eLLWqeyGfsJmSwGSkyNSNEjc/yuwqwsj6tSP
         o4k1qJLrJYSKybNlhtaSefk2His2fmXSckNf3pR+R6GAH1/hxvLmKPEEKOmJnYy462tR
         9mDXjVYY6tFKsQDFVVbCV7XOcEg6o1nhKv+bTdTeawkHeyXybS8/a5pnsRPVzkXYtDf0
         1L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754942040; x=1755546840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nstwjjukfkrgOntv1o9MxxzClq9/Ltz2vm8rR6Ldgk=;
        b=Pt0AdOhMux0HL2sZewKAcndDh86SLGSGOYlq7JbSYfjRvgoLLLO9ZzLUUhnqx8Uo2j
         AZwe9c6z0W9vUS+XTu10NnLIZ45IfNTA1u02b7tVGMIRCV+lbIjGInhnGoHEUHi8AnbU
         D9Xg7RiLiasYHELr+DNtQ5SyBnsWzcguhOPlv14Oo6zKXeMrE5Mdz4kLf8bp93HaNkHL
         QltD5ymk58hM3psWnPB9GmN/Lthfg6EeudQ2YlZrwMctnmQZcjyVnAw2vIkIHtWhn/rh
         jNec856KXCIUyo6kuoGm84uC+2zNNBXuopv/RLkj9c+LaQ5VC5TftFTdNx2p1MPVWxkM
         Eviw==
X-Forwarded-Encrypted: i=1; AJvYcCWDo9E95pG6d6c8HJdUPwX0q5jJDk4CMerPYp8qcC6gSMns8kuV1VlCINtsy3WONJJL0caqShNztEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamdXQbHBAphy0NgzVbe0G/ugdilQq5h3o/8qmfZWKuKoH6F6o
	HiT9anQ95j572xkBCGWDDQrWGzLtl6XZi1QVTWScyWJMMC+05F/OKZ3gRyrji+wCMJkl40+S8PA
	Rm2Tm6c2FzPNn7HmPSBGqz1Cp453MP0+zAOT1y6U=
X-Gm-Gg: ASbGncsAmsh2WIvBRjGSwBCgbTu5RZotM/A4YsZIQNWuA0SVOi6wLyIPxFl6WjNkViy
	YXL/qFGJI2jVi2935Tk7rIr8fMpr982hi771ySBcB0A0Gwb1H34L/JKGh4N2kMB/BtMO3wRNYj2
	K6Luq9lQ6zIEX/kbytiURZjkLiB8Wce50p1k47+CqLwK20MP0SYKGAxll/lPjI1CwBUo9oIw/z8
	cjCxkSBWQ==
X-Google-Smtp-Source: AGHT+IGk15wW+DDAnViZceRBydLn1eyzmovSE8//octRDkcI7GjYRCu+NnBWvDHQCxtuWx/+uOn+9zfgy5iIr+Wbcs0=
X-Received: by 2002:a17:906:e94f:b0:ae3:c72f:6383 with SMTP id
 a640c23a62f3a-afa1d6d6e13mr64967166b.17.1754942039578; Mon, 11 Aug 2025
 12:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811155453.31525-1-hansg@kernel.org>
In-Reply-To: <20250811155453.31525-1-hansg@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:53:23 +0200
X-Gm-Features: Ac12FXylxSeI5RDTLT68CSEFDHkKARMJuvZBQOGIXM_DVFgWRlZg4_EkRf_S4pU
Message-ID: <CAHp75Vf2zhYa28QNVFDzMR6_xH=vF8--SuoOT0p1pxYCCbjU=w@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] iio: processed channel handling fixes + Intel
 Dollar Cove TI PMIC ADC driver
To: Hans de Goede <hansg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Matteo Martelli <matteomartelli3@gmail.com>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:55=E2=80=AFPM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Here is v4 of my patch to add an IIO driver for the Intel Dollar Cove TI
> PMIC ADC. This has turned more into a series with fixes / changes
> to iio_convert_raw_to_processed() and iio_read_channel_processed_scale(),
> with the new driver tagged on as the last patch :)

Several nit-picks here and there, but in general I have no objections.
Reviewed-by: Andy Shevchenko <andy@kernel.org>


--=20
With Best Regards,
Andy Shevchenko

