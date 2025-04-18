Return-Path: <linux-iio+bounces-18241-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F470A935BA
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 11:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5749719E2939
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 09:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAA26FDB5;
	Fri, 18 Apr 2025 09:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNHG5705"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE226FA5A;
	Fri, 18 Apr 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744970311; cv=none; b=JtKgtSpLKye9DG9hp6rasQfmS2OouKW0jw+hy3BW1rPpiNcDw4K8as5cGlUKOMm8rqZviI5Hg4KX1bDu9JPvTGUQfXYuUyJoEVrTiKrv8Wv2YWHraKOy3xV8R8HwWVmu2V0iQ/ufYwSJOl9sihaNk+eUXELDzFeH1oTNKSaBIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744970311; c=relaxed/simple;
	bh=qU92lDt5XkK5I2Ax0IHy321neGxj0f+l71JsktqUtxI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=suwS+k7+md1CIPtnoYuSw67SZMwVaNhhLzMrSp40CCrGp8wMlp8MPsDMwyN2fVI2hEGSFFcLeXD0MfrZqMw0adj4NAlrud30tPm/NGLgW3JrWkj9Z5UBWKC1SScPwKwgPXBRV1qR2F3rchziffY1OHcoZArSn0TyvXgrWham6hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNHG5705; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso19936885e9.3;
        Fri, 18 Apr 2025 02:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744970308; x=1745575108; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BuylGPJH0FQEuO6ffp6MdCHfZcakh7pCNzkLK5eiPsM=;
        b=kNHG57051D09KLtwYDJ4XmLyi+U01kpoVP4e1KugfjHsG0OtURnhL9L08SszGL8g1D
         tUQ/Hj25xwVaEvoevclvF9WXwUt8lsj2Z5wJFKPUHQj2XSfQqnSbtIoNLhM1hu+CxMvS
         +Pl1XD7wEaoVs9MX4e6kLiqMfOaO73/tz5pJhRVencq7fgS5Ww79k76H6YY3857sn35Z
         gtQeSPbeUybBFirykRfyCZ/edH5H5KcuInjdXjg/0nSkh7h0SS7/Pmya3r0phE+s5DA5
         h+piEy42AC4T38s9TKd6gWhFUNv+Ws05beWV6nyi33ZKOHWMf2B0EHezCX7JXuaOf0Ed
         s8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744970308; x=1745575108;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BuylGPJH0FQEuO6ffp6MdCHfZcakh7pCNzkLK5eiPsM=;
        b=VJadNF2nbqv15gc8ns4d81fs+mLnUiVkusyF8GOKMdtAHMNEQCsKBxC59SKixMm7D+
         QHAifpY7dHoldR7AyOFBMGfrV2qRGhaScIsT/NCwJPQKQ2Jdy1YaW1Bw6gzI+aJBrtjp
         8sAfacJTftNLYJWbK5DAJhOWgJy0e7YZeHUKkXpG/POQh7S6x42a/uPVv77o/EuZd8j/
         aNvQz/90aau8MhTuXmILvMLQO6iyDfVkSWZiuGvnIqEZzDLhdDCM1+DLf2fCz0fU2oZu
         begKVdCeeV1oNHrtmEEQOGEubOp9To3tZMMLldAPG1xpWgVLdpXLir5UJDumoTnt/xiB
         p6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEshJmyaS21MOghJwJm8wYh4nzMcb8sFofryrwOt+m2xhuWroMUACejap7hyIbXYom7/XQhUUGwEXTv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPBy3BMAZXMF8V2ejyKU3swkRrIkDZXhiNymMTDfNc7cNBx3Xt
	e7BX1EJMSGZg7ISPWRIjXObznHKT6vefGxGRC6b9Wbo/hHnAiVE8
X-Gm-Gg: ASbGnctJKHTPiaVTX06HsFEJNdcMB8UNJ2POPcTcevfU1rw6EZMq6gR4If+W5bK9mun
	OLI6w8iFo8W6TPzrDvuBo2gskEnGIS/tVefLZt20pcZEP2WiTiTisz5UEuks5Gb3loO6LaCNj82
	56/owB1cTaMcKM3lkkt/qryaOZVVEffKTFQ170uDO/itrN3KlWZrPduz5ESeB34b5V3QOh+H/uN
	+j/ws+nrb/am7j8kfCDl+8uHMNRBwQVEmW1z6VuRorqKDKQpjQIAkcmAro390OPNC2mwnZ1omU6
	ZfaN16n/Kg/vDo3OiOvvxABiLzX3b4zlAtAX6bv/aaFqnzF5S24C2AjgJKJ5IeZSHr3zju6CeZC
	IH6EQa0IoxinRqzM=
X-Google-Smtp-Source: AGHT+IFFL9Q3YUQ1X3zksYfj9ZDiuJHQL5VFIR5ge5yRFXTRl0FOW98z5ZFqj6TYHynzQ6zvhG2EbQ==
X-Received: by 2002:a05:600c:3d96:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-4406aba6809mr18289345e9.17.1744970307554;
        Fri, 18 Apr 2025 02:58:27 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9e43sm15984235e9.5.2025.04.18.02.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 02:58:27 -0700 (PDT)
Message-ID: <ee8a81f72734851fae6fcb2364cbc280469a25a4.camel@gmail.com>
Subject: Re: [PATCH 5/8] iio: chemical: sps30: use aligned_s64 for timestamp
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>,  Michael Hennerich
 <Michael.Hennerich@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Tomasz Duszynski <tduszyns@gmail.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,  Andreas Klinger
 <ak@it-klinger.de>, Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Date: Fri, 18 Apr 2025 09:58:48 +0100
In-Reply-To: <20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com>
References: 
	<20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	 <20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 11:52 -0500, David Lechner wrote:
> Follow the pattern of other drivers and use aligned_s64 for the
> timestamp. This will ensure that the timestamp is correctly aligned on
> all architectures.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

ditto

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/chemical/sps30.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index
> 6f4f2ba2c09d5e691df13bc11ca9e3a910d98dc8..a7888146188d09ddbf376b398ee24da=
b7f0e2611
> 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, voi=
d *p)
> =C2=A0	int ret;
> =C2=A0	struct {
> =C2=A0		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
> -		s64 ts;
> +		aligned_s64 ts;
> =C2=A0	} scan;
> =C2=A0
> =C2=A0	mutex_lock(&state->lock);
>=20


