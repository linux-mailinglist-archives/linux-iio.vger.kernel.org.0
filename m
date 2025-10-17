Return-Path: <linux-iio+bounces-25195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463DBE91F6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BD36235A6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165932C930;
	Fri, 17 Oct 2025 14:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su/2IPOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6032C94D
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710463; cv=none; b=dMxtoGQQv8NMJOwAqW08/WX+4mJ9GDUACmYReXPKfPNagVvZeR6p3o6Z6PycFx1OJt4gkftu6QvewcePQXkLR88IgS4rnAl4BYF7gk6tYRNHcoyOzs9bFFGFIc7je3iNwVavHi+1hGkn7NQSnPlAlWen1YKa72WSPUCHzTxNBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710463; c=relaxed/simple;
	bh=959p6xV6CKeeWXiRtPPtRMLL/TFd0b3Xs25RXyKYag0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMcKzOc/IzzRFuW0b71SeRb/40CVPMVgO0n7wi61yKDBZRlU00ZBu0L/hMyqezQYrfOvL4IIsb/lyMeHqRmgDsLUlyzw06268q1d82RmOllp+nnCtIloGI8ghI7UXPxphlUJVlBC+/gB61UJBmC5KH65pvv0aCPb/SG6VJ4Sfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su/2IPOE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47100eae3e5so19573685e9.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 07:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760710460; x=1761315260; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FTLnHbprIsxNg0GlvOz1rxX1RAjfsFXOqHQiYRq25LI=;
        b=Su/2IPOElTtM+RsiQFMRs14hcKxioX7VfmNMd9Wuywrv8kjPCSJROetHVRUc9PhL2I
         ZjpamG/lE1Ugc0wWzT9ea9ryyVtx17N93Es7t2N2ZupCvSUQQ4BX5UNujWZck9SJoR7q
         W0QntK1fjnEpyAYA8Q34ed3VaoKiA8s4bzr5BES39aOL+4KzAcjAK2GMPPmbdKlJBdee
         grP8XDSLyGfaItUt6ripBXvyaBjV4bLCiV7qeau9gC7AfjJ8zVxxQy6cyQy6OFLeQUFV
         m8fuHnlvJgVRx/g2mdKfuCLgmlOr3OR5ADf1tOZR1OHehThLS7ESA71EksyUqROC8bYa
         buhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710460; x=1761315260;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTLnHbprIsxNg0GlvOz1rxX1RAjfsFXOqHQiYRq25LI=;
        b=Wg5Q3Se0nFbbcJCjAXm/RtGENNunSvh8xZ7+o7O5r7WQ5JTvfO38zjCfoKcXFdxYRZ
         w6OKn03CyoXPGJd5kcuayb/UnXam52FE0VHC7L4G/Eng96BQEGJh5Hi3gqWapqEl8AHT
         /pnc3SUVPESDzXOI1FkMw+smbknT1DAKx6YuOa9whnQsCB2r7HsFajRha2Dfnus4hYaE
         Zh6PS3QH7Yjjfnd9KQrzDin1z5iSh7r6fJRDSHFAJvSfc9wyFJu78S27C0pJDYi+9ZDN
         LG1deFPumqSTcwpDph+HFpTZxvK55sgMu29KCC/J/4tfzRxMowhXgHnvYDTU0ZZ78IHT
         pfRg==
X-Forwarded-Encrypted: i=1; AJvYcCVikpQHFAPisIsxNghMCE2FrdziNmKWj7nE69+ZLcVGGzJEBXjTqTiAuEIQWetCbUhBVSwErjM1b2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbA1IWnA1wCyPxnq3k/H1JDf5P8lT7FvTD7NU9xJGs0oXdOBC
	/PGThLjXXWyJG04nGJhccZ49mfwo16AfS61S6Gl6jdzHhYlNAmbHhfxV
X-Gm-Gg: ASbGnctrnvCDdsRGhTGImLylTVIXfQhmJ48GXn3zh3Qb8gXMX4qP8qGbdPySw2b4nWk
	9nmpvaOusL1N4nUSaAcGATt34NdgvHVfwv73C9PVFTJZfaiF7VBuS5lXD6ym253QZtgONllLQ0A
	EeS73oUpertZTCCjAeXXmaEu88cv6aQUuUU1UPvwJSQER45+Ed4ud4Ca3fVNOBvRAH9H/uFg1zi
	SL6NfywKALYjtV0a6JDU/mY97XSRR/LZps+FDk+w4fs1zZdDrKysHrOxZjnLF1qIMCCEju+YEmI
	+mNs4ZMe12E5JA3yqzekL3eyZPy4xVMUdxpJ5ZZ8LyPMgY44U2ZJ14JYbNUZ0wGD/cxlFJ/xtAj
	40h6eF3fUBe7ei/YKlIfJvd0GpG0UqZJbmHgvRNtdiSu4be0q4BLdPKsGBlHJcxzLe8o3Tv8cyy
	UCXWujL0zIr+cji+pCap4=
X-Google-Smtp-Source: AGHT+IF2EM7mT5D52gnp+VTbfiNcarttRakEXF5/pBTZwv3B+9i+o/ZbwXxFScc6ahCV+wEMQcYNyg==
X-Received: by 2002:a05:600c:821a:b0:46f:b42e:e3a0 with SMTP id 5b1f17b1804b1-4711791dc89mr26441555e9.41.1760710459832;
        Fri, 17 Oct 2025 07:14:19 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47114423862sm87177925e9.1.2025.10.17.07.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:14:19 -0700 (PDT)
Message-ID: <014f2380e9261a1449214907a149f11267acdd11.camel@gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad4030: Use BIT macro to improve code
 readability
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net, 
	marcelo.schmitt1@gmail.com, Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 17 Oct 2025 15:14:52 +0100
In-Reply-To: <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
	 <ec78fd7e4348e2cbc99ae08004c48b7ea238ecf7.1760479760.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-14 at 19:21 -0300, Marcelo Schmitt wrote:
> Use BIT macro to make the list of average modes more readable.
>=20
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Link:
> https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCP=
FxZJnYrvROWQ@mail.gmail.com/
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

I don't find the link particular useful in here. Seems redundant with the
Suggested-by tag. Anyways:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index 4393160c7c77..b2847fd90271 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -233,9 +233,11 @@ struct ad4030_state {
> =C2=A0}
> =C2=A0
> =C2=A0static const int ad4030_average_modes[] =3D {
> -	1, 2, 4, 8, 16, 32, 64, 128,
> -	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> -	65536,
> +	BIT(0),					/* No
> averaging/oversampling */
> +	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
> +	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
> +	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
> +	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
> =C2=A0};
> =C2=A0
> =C2=A0static int ad4030_enter_config_mode(struct ad4030_state *st)

