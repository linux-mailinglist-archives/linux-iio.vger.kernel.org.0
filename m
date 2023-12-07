Return-Path: <linux-iio+bounces-717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4568808B5A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 16:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44679B20C2B
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6755F44388;
	Thu,  7 Dec 2023 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yVIVtczl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D02310D8
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 07:04:31 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso12041821fa.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701961469; x=1702566269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq6beQa8ojXEuYLDpe/2hrknHZvfdgv3wkPh9+V6mnI=;
        b=yVIVtczlPxT7E+yW5kONX6ZAh9nk8Ixbaa/QgA1BFokV7c+V8AVw8Vcmhjc3ud/WyZ
         924mElkazHiGNCn+4PmHwwErPMuxGz+4eLWtLQme7W98MPfVz3zAArJyRcDMRYMfpD9P
         U5Rbpis2i5vmq9acnOcYFyorpZPR2XccVeGSuTbpOrmiY1HckoZBPupi1NK8kKdnCecs
         peoxy4H5w1YVIOCbyGcrlPp2yOSRGMtdxnjoAm9dnPm9Psmb9ccYk0tF8+c/sHH8zKdn
         Aa72IsrugcwBsAM7yjl/R8uEm67ADlaEq+J5luGA774aLgxJ3yfU3wztLXxVznpU1Hwi
         zlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701961469; x=1702566269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qq6beQa8ojXEuYLDpe/2hrknHZvfdgv3wkPh9+V6mnI=;
        b=ZxeQk4pOVfWzBcOgvB4lvdtL/GUnPQ07x93Ty7Mn3e3r1dKb9RKL10PEIos97eP86L
         MoFEb1xXORPM0TAb+z3ETZipPh9u5T4OnrFAnMia/Q1a4qb5agD491An6LwoTXHexplU
         tjiNG0bwmuAck4x3cESvO0byjjQmYobHEHwP3+GC1NneNhesMbYLGL7iOwAhgXoQ3Sss
         YysaO8u1YKBeKYAEtZNT1zZJVjKEsJDs5mPLuayzrKm+oMp/7fGJ9/6CA1CZNeA07SRy
         QPyYqeZY4dbk33D69/LwofdXFFr2Bp8kvF37R4STCeR2MNu9YpR0YE92l0FZTE6aZ2+C
         SefA==
X-Gm-Message-State: AOJu0YwKxblc5b0PXsTt0xA98vGyoj/WGNehQdIB3dzjSWQlg1526IN7
	22TAgiQwlFmso5E6AwSBaXSNh6zR2nyxil2ib4S4VQ==
X-Google-Smtp-Source: AGHT+IHkaGsEaRrW114DbaQ5k9AHBEMRs74+nyQmnaTPvwufxVnUHjMp63VB7v9FozHwdlCLPVH/dqnF4801IhUK+Nc=
X-Received: by 2002:a2e:7d10:0:b0:2c9:ec92:7bc3 with SMTP id
 y16-20020a2e7d10000000b002c9ec927bc3mr1623280ljc.6.1701961469256; Thu, 07 Dec
 2023 07:04:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com> <20231207-iio-backend-prep-v2-3-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-3-a4a33bc4d70e@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 7 Dec 2023 09:04:18 -0600
Message-ID: <CAMknhBG99SurJ_2-tRhJBKpmiu-mR6k4GhGnkQh0Rx4VGEL+ew@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] iio: adc: ad9467: add mutex to struct ad9467_state
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 6:39=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> From: Nuno Sa <nuno.sa@analog.com>
>
> When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> are done which means we need to properly protect the whole operation so
> we are sure we will be in a sane state if two concurrent calls occur.
>
> Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>

