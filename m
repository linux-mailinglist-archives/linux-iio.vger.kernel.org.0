Return-Path: <linux-iio+bounces-15636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED0DA38105
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B320416522A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D8F2163B6;
	Mon, 17 Feb 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+ylKIit"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4B21771B
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789836; cv=none; b=BXUk3MHIBiYFymsUm0afc+dhyycsqfaxbZUd+A1/GnRGt9z1rAuq8+oP0Mr7DIhDd1LpuhgNlKfco3n4w8wKtcjQX4bU+PwGdSbhMGwe6boJaMKoWzMHTKErit7h65+zk0opFTxDwVigPmusPFnM/kcZF3T2jKyifH7/3Lyscbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789836; c=relaxed/simple;
	bh=0MziXaJntjkbmaaVjlHw36tLEef7uCWC3wHJwNWpLdc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r8WauNv6WF+P76bSmw44OKGY/38bVvC+Pcz776vjFquX5M/uiKPNONYfJxUjj/jRnOqes6ba4Z/sF79p23P+a6NmumgQSOhCNu7mKBYOoclNa1ZX13H9HqVy8eepRiXz6z/LIDLSyH/tEKfzZFf4MRa7LYzgQMtpBOVN0fkEDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+ylKIit; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso2565516f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789833; x=1740394633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wd2POrzCNTT4bS4HaEbR94LdTLmEzRWlDpXaA+tawBM=;
        b=X+ylKIith3FzlkfC+ZNTgo0pXSvD2zW49zm/zCN52e3EaWfiNVnWLFiX5A0u1nmV0M
         nJFMNneo6VA0v1d/IT0hkAHQAEZ3f/MvAOhj567aTeByys+hdKiBSFQ9pJM7rnIGGwWE
         lFGNGbq3Uy9HkzquyJM6Nk25aEiNdL0o4/7qiOv8FklqJiXAKwYf7cIE2Zw7YRARVlvV
         RUmcl2r63YJ39HY3ySQYFt0wC1STGEbuQ/5Jnnzt4bNrIdald7dDkvFHDAFsJwMQ4g7r
         1lX6w3Vo4KeZTXljrpI8HzbesJhPNRik5bqWDcbkYSn7QTIBH7ffw4D0YHQkQh4EtNef
         gv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789833; x=1740394633;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wd2POrzCNTT4bS4HaEbR94LdTLmEzRWlDpXaA+tawBM=;
        b=pdsiwobywlZYwrk+XneOilTPS4V6UpfVBnb8mx0nF5/JrLkwyLCX9U5/8eLaJozJqb
         yc2e/Dw4rG1+kxSGwenntsMT65T7IfStJuc3oF4FZrDrkH+sA3oMwGh0zwaC7i3MK4Ff
         SwKqQsh+kub/CFXzyV9dOtxQtuj5Kt7UClfOPPgavzzhHVgrATOXbQ/Utcl9VEIDuBiT
         ap5HbinGcg3/WJQfrTDBaC8zHfGwvmd2Ig3HXx8RPOiIO3xF27FC0XGYcArNv3PG3R22
         ZMxHzeEupHuTvhZpK3Z+VufDi381DgdMpdkYgA23PFB4D6TeHOoPQfJq9QJIV6tuOCti
         TUhw==
X-Forwarded-Encrypted: i=1; AJvYcCWExo+FeIJ0YgLlD6gX26XhhyED0p+W9hS5VgIg1aKokDS+U5iAEIlEAnQXS5EDCIPj9bd2AlgIm5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOvpE6TvrEcUsmxDkRcj59X3prN2TkBRWRdCO8VpO0/vpByQw
	YYW08wfhvoIoGug8KPfK0V7hMzVvySvok7wd+3a+s2zr9tqk0/tk
X-Gm-Gg: ASbGncsZW6j/w5aGbgU2uU5/IQ0MovoPg28n18dYCkVIXhnyHc8BP7jZ34u5Q2mBzId
	Fmfz06GjpXcHk2p19O7tDPcfX5EpO3eOUsYiFBXV2gV1WwgWbZ9t3sgvjPL8j5JCEs5Go/rKWoE
	mcK9V4vvpwdvRSSd/b4uNOm8WtQ5lAa1qbgqPG1kZOvKRw7c9jTAngyOzVNhLihGsx1JLtTpiam
	T5lbfiiiOs+ONlzMHpn0K0GnnZhfKgQj4Oz/gp5pCr8bWDsOvUgThvRzbZPdEwCK30vHLXKK7pj
	EcIvIzV2H0nnuoPV8B0+ezZuqcW47lLSykbsy8z23fn0ZSsMEFUTZK7L7QJauo4=
X-Google-Smtp-Source: AGHT+IHbc7Nng4MT3Ehnz3YkCNvTQN5X5Zmp9IwpApvMW99SYMsl0oHD+QP7xpryskF4hm1CSWHY7g==
X-Received: by 2002:a5d:5f4e:0:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-38f33f4e56emr7289057f8f.50.1739789832982;
        Mon, 17 Feb 2025 02:57:12 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd3bsm11949193f8f.22.2025.02.17.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:57:12 -0800 (PST)
Message-ID: <6f9d472dc49bbfd7f9f06af20814825784225bb3.camel@gmail.com>
Subject: Re: [PATCH v2 27/27] iio: Drop iio_device_claim_direct_scoped() and
 related infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:57:15 +0000
In-Reply-To: <20250209180624.701140-28-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-28-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Scoped conditional automated cleanup turned out to be harder to work
> with than expected. Despite several attempts to find a better solution
> non have surfaced. As such rip it out of the IIO code.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0include/linux/iio/iio.h | 27 ---------------------------
> =C2=A01 file changed, 27 deletions(-)
>=20
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 5ed03e36178f..07a0e8132e88 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -9,7 +9,6 @@
> =C2=A0
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/cdev.h>
> -#include <linux/cleanup.h>
> =C2=A0#include <linux/compiler_types.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/iio/types.h>
> @@ -688,32 +687,6 @@ static inline void iio_device_release_direct(struct
> iio_dev *indio_dev)
> =C2=A0	__release(indio_dev);
> =C2=A0}
> =C2=A0
> -/*
> - * This autocleanup logic is normally used via
> - * iio_device_claim_direct_scoped().
> - */
> -DEFINE_GUARD(iio_claim_direct, struct iio_dev *,
> iio_device_claim_direct_mode(_T),
> -	=C2=A0=C2=A0=C2=A0=C2=A0 iio_device_release_direct_mode(_T))
> -
> -DEFINE_GUARD_COND(iio_claim_direct, _try, ({
> -			struct iio_dev *dev;
> -			int d =3D iio_device_claim_direct_mode(_T);
> -
> -			if (d < 0)
> -				dev =3D NULL;
> -			else
> -				dev =3D _T;
> -			dev;
> -		}))
> -
> -/**
> - * iio_device_claim_direct_scoped() - Scoped call to iio_device_claim_di=
rect.
> - * @fail: What to do on failure to claim device.
> - * @iio_dev: Pointer to the IIO devices structure
> - */
> -#define iio_device_claim_direct_scoped(fail, iio_dev) \
> -	scoped_cond_guard(iio_claim_direct_try, fail, iio_dev)
> -
> =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> =C2=A0


