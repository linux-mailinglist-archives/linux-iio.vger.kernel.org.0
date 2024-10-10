Return-Path: <linux-iio+bounces-10385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5066499807E
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9AE1F27612
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 08:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324511D2704;
	Thu, 10 Oct 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2/cpdPC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D9F1D07BE;
	Thu, 10 Oct 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548913; cv=none; b=pHcbE+aMOBO7xt5AwVmizMQMA5DzpKVJbDKHSOht18ZnyIRhi5tIv3y+5VsSC5XRI/asILESz5XMHTJY3dP537mhmt0iG5x4Ym3U1YItsRZ3ODQEkHmCA+nFq0rZL+fZBEHizvIkpJRb79lBDEPgkutzYwQq9qc74LpsNUikS3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548913; c=relaxed/simple;
	bh=5SnhgPRUuU5LmlRag8wTkS8N/CC/zWntHpE1bLWhr6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liAAnwe5cU2GvODqxXGlJgqdAB4tYjSbXrBq/lSvLbc4/nIuoccFW2T2ramM6e6PX36oKeUKAxKZEgLQtkL6mCw9EW6SLAOXv+nNjoSk86Gfatst37YBcB+1itQE7IJutPG7s9ESDd8YLNhza1N3uFJXlmqBRHomCK5MP3y1Qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2/cpdPC; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d47b38336so326206f8f.3;
        Thu, 10 Oct 2024 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728548909; x=1729153709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FbBN3yZYUGrr8qODI7yZovjpMzT5/HDa5n+6VJGVpUM=;
        b=h2/cpdPCmlr+04K5CQTOZbs7IKAne/M9LQ+BsChVTOlT6/ILDHxdPMoOfmnx200Cch
         h0NEfx4jX3Rx31rupK+AXL+9Q0gA68UmjG95ShnlUC+HfggUhjfxe9RWGWleZ9za8q2J
         UhgHdrUh2oICScgZnqiEPVVvrTDbRyhtpM0YW4STTbtFQEyjp/ZhIxVr8nSqpnaXbte8
         INc+WqCYOxyd8aeQ4WbVClI0xPR78EehBLRL7YUCIDeeFKYDolXhzXC5Jo0St9Bi7iJA
         P8yjnA9bJLDrwpCs46QJPjCdMWpiAH+ZP8buWnlD9XBb+Bw5A1+qpJmUjzaMrFbGK7oX
         qFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548909; x=1729153709;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbBN3yZYUGrr8qODI7yZovjpMzT5/HDa5n+6VJGVpUM=;
        b=aS6h1F2gZU2wxF4swMvRVfUQBn1CFDsqgg8sH8VUIdetTCbgJRR0+XB324nIY33pr+
         qC7Hqa1u10/ZmKAcqd+DykYG4u7/D5cs893DQxzcLwpPh9oM988UUyH6V8Xgck41j186
         pKABFMUntFif4mhg+kIZbc2TSvb1oq0eNDfujWQ1E7EWFXx+4t9jyp+ViL8J8bM/ZB/Z
         q890piBQmsiFUge6VGMa/VPI6aFbdVvnqC5RmSKnjDvwMQaf00gvVf84ObrPSow/Jz64
         lT8+lp5R4TwoaoXM7Sh+tnjiNOSia6hB/fHDq27fSy4/h/FGy/enOYmwWGOw9zVy6/1m
         kezw==
X-Forwarded-Encrypted: i=1; AJvYcCViSO3yTIZMwiSbvFtTMNSmDgQ873ulKbZRJ898HWugt367CsUCkjQnmH4WX3JhFK4nmFxokT1n9ya0yxtW@vger.kernel.org, AJvYcCWqa8nFx13Jqzp31LD/OU05bQqTZuUrepQc7p+lmZWmhgv9duJPpSVATduuoYdlJvGTSmiWxwGiw+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCz8b7sVAXQY7ejbE4UXBy3aefWjwJ+2X+p6YEEnYEdSjZJcB
	1FrPRQ6PPwFfEU+z5HVAvTeOguh2Btyv0OQuqqyG5Le0guWo7CvbPdlPvRcKEbM=
X-Google-Smtp-Source: AGHT+IGv0xrtHkq6yisyh3etRfRvcNy5X3JAUYEOS4cSzQbRX0+uG9/FRzua21othi4mqgRrHXSfOQ==
X-Received: by 2002:a5d:5c87:0:b0:37d:43ad:14eb with SMTP id ffacd0b85a97d-37d43ad1534mr2513889f8f.14.1728548908512;
        Thu, 10 Oct 2024 01:28:28 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef15:2100:888:d3c6:a442:4910? (p200300f6ef1521000888d3c6a4424910.dip0.t-ipconnect.de. [2003:f6:ef15:2100:888:d3c6:a442:4910])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cfa8fsm832848f8f.49.2024.10.10.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:28:28 -0700 (PDT)
Message-ID: <b5427f9c7fdbd4b93ba7b355aaf44afde23b0026.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: add namespace to T_QUIET_NS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Oct 2024 10:32:44 +0200
In-Reply-To: <20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-v1-1-a216357a065c@baylibre.com>
References: 
	<20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-v1-1-a216357a065c@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 16:26 -0500, David Lechner wrote:
> Add AD7944_ namespace to T_QUIET_NS. This is the preferred style. This
> way the bad style won't be copied when we add more T_ macros.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7944.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index 0f36138a7144..a5aea4e9f1a7 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -80,7 +80,7 @@ struct ad7944_adc {
> =C2=A0};
> =C2=A0
> =C2=A0/* quite time before CNV rising edge */
> -#define T_QUIET_NS	20
> +#define AD7944_T_QUIET_NS	20
> =C2=A0
> =C2=A0static const struct ad7944_timing_spec ad7944_timing_spec =3D {
> =C2=A0	.conv_ns =3D 420,
> @@ -150,7 +150,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct devic=
e
> *dev, struct ad7944_adc *
> =C2=A0	 * CS is tied to CNV and we need a low to high transition to start
> the
> =C2=A0	 * conversion, so place CNV low for t_QUIET to prepare for this.
> =C2=A0	 */
> -	xfers[0].delay.value =3D T_QUIET_NS;
> +	xfers[0].delay.value =3D AD7944_T_QUIET_NS;
> =C2=A0	xfers[0].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> =C2=A0
> =C2=A0	/*
>=20
> ---
> base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
> change-id: 20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-a9ed696927=
18
>=20
> Best regards,


