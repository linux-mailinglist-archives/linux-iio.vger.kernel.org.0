Return-Path: <linux-iio+bounces-8269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7EB948D06
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87059B23F3D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA261BE23B;
	Tue,  6 Aug 2024 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQSHPzI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0495A161310;
	Tue,  6 Aug 2024 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941110; cv=none; b=j343FR9IbceGfg8Yvkc2DmHON2sQddZnQhuWBrRO9nc/3dbjtU7BeyzDKKjGAFRY38yjTp9W+lDlVQcwL1f4hNP64/W0YTSKvC8LzUEMiuwygdjVhQX+PLQM3l+40LqiTw26BkQeljkIAhnjLDKedXyHCaNAnPYVum3JjX+p6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941110; c=relaxed/simple;
	bh=rOYhd2/EFTCSIXBMVNgLS/L0tQ85DFEsBrVqWQTwj/w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2LeKS0LtUI6uRAfqc/4OuS6XbVZJ+h5IBTak/OfXl8cb5o63qn4Ngwug3oCWqxehaxwnGyYE2Kr3GlmQi3nEHTfPRu5s7H+70wGbJxgSUXAOdcR2mAMTVWr2rZa5r9u+CGHuJT2n/2X4OGTEfHNR/xAFYZldI0h/LU3vhZ689U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQSHPzI6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928fso4542415e9.0;
        Tue, 06 Aug 2024 03:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722941107; x=1723545907; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwKi+niK4mDkuGH1TU8kmdB7gCGRr8kwrsgvY8XWNKI=;
        b=AQSHPzI6DQnQtop6ViJPySjMCVZoKEc+Jt8sshzV/+FQOP8/+TVaJOhjLbN/Kavdnl
         1kLXUrWyuqW7vBFFjYjkfofROWnVF5stQuTkL+j0PwoiRO4kKwkNDxBRSzxLdCBpEMad
         UW3QkMAz2sTjpCc9r79cpFShRKvSKg/ExR2qnQr/DBofzAogPieY9pqGbXotKuaPQ48U
         DURSGfIE4i7Fd3gx3qJ+ruS4OsfcfTiokSNPHf5q+8+mwBV6Dr5CU99f/sCSidyfptwe
         jFmBbAj28sMXsUjvITa8UDQY7qLNRWfcUJ8JeBxMnFMasrP2ea2mgFI8bkg4jOkEVAjk
         4iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722941107; x=1723545907;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwKi+niK4mDkuGH1TU8kmdB7gCGRr8kwrsgvY8XWNKI=;
        b=GVBNPWpdXoxCmKzsupbZIhg2cB1H4ay2dzJsOu9v+HKulW21/9N04xLRl0eJ3to7XC
         czLKVehoL9eYaU5k+VqlG+OeruStKI8jr6rqn6UrDKIR2BOPaHXrw4Zrit1K7UwbUad8
         w3oaJb2YHVIB7Nl3agSuOyreIOm5myBasMW/eZsZvY9q6RB/37AdZMy4zSw2TG5/5p7B
         /RaEmOjhOdvaAJ5sScXAFmogzicgydwGSgOpBeNpaN+TGqsm+frtAXZBQFVwRGrV6A+o
         SV8vRRgaQIf0WY/w34lcaGOEkfX70bNtRqsz9udZZ/W6r1CR89N9Fj9XyFWQ9VpwxFEx
         Z/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCV8gQOvTWB5L0+qKd7jjGqX+7rYcjj9W9N0QM7KQhSMBtBLjO3yoBa7I5CHKwF5jjyDPhnbDQfckmxOMFanbLRhaDoAy8qFw44dUaBp/4UXs6h2uroNT+s5ClO+ojVhwdM7ELSTFxVW
X-Gm-Message-State: AOJu0YzK+W5B5gzyg8y5sMcrCExhte+x4q0HGfmFO+9dN7qpq/pQd+Tz
	RdPUXKsPopwDbOaJH4IKxChkdFl2j1Nz1GHStybpC27DyKHUan5U
X-Google-Smtp-Source: AGHT+IHlDih8wASngLnMl9wG+rTzq76pmtVaIYD7eg8uIZmKmt/fQ5OsOJUSkZrVt4hQSJYgeLt0fA==
X-Received: by 2002:a05:600c:45d5:b0:424:aa35:9fb9 with SMTP id 5b1f17b1804b1-428e6af285cmr132230085e9.2.1722941107000;
        Tue, 06 Aug 2024 03:45:07 -0700 (PDT)
Received: from ?IPv6:2001:a61:359b:e801:d44:32b3:6924:10d1? ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64006sm238256225e9.30.2024.08.06.03.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 03:45:06 -0700 (PDT)
Message-ID: <15304301efe5c23d55984f8a1f2a5016d7be213d.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: fix DT configuration parsing
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: lars@metafoo.de, jic23@kernel.org, alexandru.tachici@analog.com, 
	Jonathan.Cameron@huawei.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dumitru Ceclan <dumitru.ceclan@analog.com>
Date: Tue, 06 Aug 2024 12:45:06 +0200
In-Reply-To: <20240806085133.114547-1-dumitru.ceclan@analog.com>
References: <20240806085133.114547-1-dumitru.ceclan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-06 at 11:51 +0300, Dumitru Ceclan wrote:
> The cfg pointer is set before reading the channel number that the
> configuration should point to. This causes configurations to be shifted
> by one channel.
> For example setting bipolar to the first channel defined in the DT will
> cause bipolar mode to be active on the second defined channel.
>=20
> Fix by moving the cfg pointer setting after reading the channel number.
>=20
> Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 3beed78496c5..672d41bac8ca 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -839,8 +839,6 @@ static int ad7124_parse_channel_config(struct iio_dev
> *indio_dev,
> =C2=A0	st->channels =3D channels;
> =C2=A0
> =C2=A0	device_for_each_child_node_scoped(dev, child) {
> -		cfg =3D &st->channels[channel].cfg;
> -
> =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &channel);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> @@ -858,6 +856,7 @@ static int ad7124_parse_channel_config(struct iio_dev
> *indio_dev,
> =C2=A0		st->channels[channel].ain =3D AD7124_CHANNEL_AINP(ain[0]) |
> =C2=A0						=C2=A0 AD7124_CHANNEL_AINM(ain[1]);
> =C2=A0
> +		cfg =3D &st->channels[channel].cfg;
> =C2=A0		cfg->bipolar =3D fwnode_property_read_bool(child, "bipolar");
> =C2=A0
> =C2=A0		ret =3D fwnode_property_read_u32(child, "adi,reference-select",
> &tmp);


