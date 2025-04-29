Return-Path: <linux-iio+bounces-18823-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F87AA08C3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF7F5A6C7E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0392BF3F3;
	Tue, 29 Apr 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAtZMK1J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9E2BE7C0
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923355; cv=none; b=S2vw5PnUfuDmi4khj3+XbYf9P1q7zVDssNM8Yw3mxJ1Jx7kIGsZhZiFJ2Cfr8aq+8xEy3P/6OGYafEFIJeCsIQpt+tSsNjKDWENOfc8vBbbEEPc6lMMFqwTQA2WuPpUgKWVeXXjZpUR0issHtrPfLGcOMuKG/CJlHF9VgRfbJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923355; c=relaxed/simple;
	bh=C1mdFp2exogFCNC0seXIIsAXP/t5byZNIUxxIsqW/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELxxJzpbyrzzbvxfPb2xDOSAJ3GX8xPstC6VSraet0CrxQAsku6h7pDeGCh2bQ1BR6wTfuqOkkRiSzqMGen/E2wTzq3zzNs/JGlK5exK9sKwHUolgAwOd+xAQT3UnzlVybq3bI5vmOBxSIUdnFsYHOM9ZAnOTSiuywq4zb37gIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAtZMK1J; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30dd5a93b49so52336371fa.0
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745923351; x=1746528151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShqQVHZIze18zi/KkNJsulWu7w5abrDU6INRyLTw0mQ=;
        b=EAtZMK1J7EkDQQkfpZjfZrEU4z7TmJxciU6D3FDgJT0hbpM7norED6qK4irf2U+4YB
         G5ec1yKeXh/9n0PA0nTsU4BK3SodS+qpH87UgI2uFwVD0IFFdz39tuVdg6+bDiIV8hV2
         GgOTkUgjMHCvF24AjnDfRmjJ4Ccb+tfuYLwQxsZ4qHKkmj5LK93PM6PNmBpch9EBvo8m
         Ux6go81BSPODxtTMuZWIIvZj6NOaCUm6Atj8lFKpKiN3DFNCbFccJO9ZcfCfakcWST1E
         hZSHayhgCKtbKC/bdVibN9LQRXFxz6/YrW7/cE6DSuSzCBdbOLh4EDwgN3mpJUdXoisa
         wmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745923351; x=1746528151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShqQVHZIze18zi/KkNJsulWu7w5abrDU6INRyLTw0mQ=;
        b=SYNDdcCA898iyWdBV2PQIPdorjLCThuDS5J+3xUAYo/mBwlGQx+46M2j9d03eyqxSX
         FJp62lwrThT+TUPOHd8I0UaL8Ppgy7qP5NmDeyDgY3PYgcRG8l46+xCOKbpmmc7EOuW4
         veKKmLwsm3EYuVgy/JcB4lLFOIXiTEzHg9cAp4R3wjlsVSm27dFU6WpvtJz+F/hwnUxc
         V0K/RkpiQTQwyFfMBb0uav0hfMWXJw9Qmn+yflzoXd1IV0wMbQvDLtKjKMW6G0C3XeWD
         0VHteCoWoznVxpGGVbAsreL2j/pT0HiFflqoWOrwwpF1xVMbUHnvl7WY9dgkiqWUK166
         7hBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGtBQ8bSeOFGulJKkeTnP+d4xLWozYpeWECBkTOKfYqqqztdNHXDPq4RSCf7mdmkakkcRSflx7a0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN35Brt1N0XaZB1oZH+V4WuPuhfihegcoCk6IjS8KNneMoEhw0
	zBeYGLvPitaU0+jggf78+KGRdm8HUhULeDWJzpW9Wprw6oPzYp/GcQlaOfDppTyVdxP9P/0XQ6f
	A59AhqLj59CGbrUSq/KiK1jioY4gO8A==
X-Gm-Gg: ASbGncsMB2w5rFCKWyhr1tdYre16OGzZ4V85dg915Vdls398ikmAXkOkaqfMR0O2Pow
	/9TCgyHzJVwqy9VIGLSPQB0VTEqysOvRxKkZMl6qzsYTIe4uMZM+M1xTM5V/YTTLjqgCYLZEoH4
	j1AwvXQGCinbalgHqo+PspBpQV+GFX0y4YgESG69ogckb9DlVeObopXQ==
X-Google-Smtp-Source: AGHT+IEOURqf85Udyr2JtFJmBiznGFSIglDKFJG92L1+lerRcB1Pmi8Uo6zaNgag1UWMZVGnfOIiASzhifGkNZPhMC8=
X-Received: by 2002:a05:651c:2222:b0:30c:5c6:91e0 with SMTP id
 38308e7fff4ca-319dba4fae3mr41057921fa.2.1745923351172; Tue, 29 Apr 2025
 03:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei> <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
 <20250427112343.207918cd@jic23-huawei> <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
 <CAOMZO5Bzrfu14-mzaF+EbAq=xGKMc-FGwJsx-aZd_RraH2Gscw@mail.gmail.com> <ef215ea2-e283-4c89-9b54-61b84684bfe7@gmail.com>
In-Reply-To: <ef215ea2-e283-4c89-9b54-61b84684bfe7@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Apr 2025 07:42:19 -0300
X-Gm-Features: ATxdqUFH7GDIK-nbJjyaHeGVSAsVTj1MtY5nBxSGbU24ac27Hu7V8XFNgzksVTQ
Message-ID: <CAOMZO5DUATUCTWM645rAE+1Kyov1Lh4Nu8nWxEg_Wzd9Zyiy5A@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, Apr 29, 2025 at 12:59=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> So, majority of these prints seem to be garbage. AFAICS, we should only s=
ee:
>  > [    1.652223] max1363 1-0064: available_scan_mask 8 subset of 7.
> Never used
>
> Or maybe:
> available_scan_mask: mask[8] subset of mask[7]. Never used
>
> Do you think you could send a patch to fix this, or should I take a look
> at it?

Please take a look at it if you have a chance. I will be glad to test a pat=
ch.

Thanks!

