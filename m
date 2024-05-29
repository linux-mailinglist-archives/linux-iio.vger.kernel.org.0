Return-Path: <linux-iio+bounces-5424-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D18D2E02
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 09:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CB21F250BD
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 07:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C371167D81;
	Wed, 29 May 2024 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGl1MK5P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF9916729A;
	Wed, 29 May 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967247; cv=none; b=G2T2AezmQJASi+Q+uPQvwq8+ZP4BQOPjdZZpWtNXTwKR0HpVN5T2Ogm6FJ7gM8YgxmOZjWwuEmqRnuiQYK6k2g03r+NIyK+wz5wScuDG4f5Ld6yxhS1/2zu5qkFmnDNn0TdCZFdB2TOG5YLj1uKZG4eLj5O0zCGeA35UZK26MIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967247; c=relaxed/simple;
	bh=FS8crls/uRvtCmHET4e0Zbibu3jmMutDi9nHUxyq8Ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMFJxJe8nu7hFe+DOWgS4v8B5Np3iZf03Ufuubg27shF4oDG17BrDvSHsgc8PMHY6fAEpogJV1YgslF0BcMODjcn+tWWGX2EzHeaI89FDqAcDliPycaPEIi/+bQJ4zc7ZU9qKR2uXr038PbfBMSthTxDqs55ymCu4SWuTh32mAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGl1MK5P; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59cc765c29so91006566b.3;
        Wed, 29 May 2024 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716967244; x=1717572044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FS8crls/uRvtCmHET4e0Zbibu3jmMutDi9nHUxyq8Ko=;
        b=mGl1MK5PB9yxaMei/Ll9F4GG74dQTqg4uk0KFoIpe+1DiANGdyfgjwPwnQ1VrBtjvA
         iTy5w+589pkMR9tSRhjNTWAjihMjj6MgMAS/JhFjdrpjnX6PaxU7x7A82d1vRiN9FL2p
         NaUELssAWB36WBdMoG7AJopO83KE6TuyPrSF5gPLtv7hgBwKurOeZ7le/kfI1hurNXqk
         HOSrjM5qh4JqP4LW708Tc/4ha7SmUC+8GBUSNEyro0Cdda7nd8BxnIe+7SBTXrh9gKvu
         rAn91n6d0iVtKfbJf9QrttoFg9FSHlOn6ZT9/YjWPoUvOWTe7GkXEtphxitDXi+IXzzb
         AC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967244; x=1717572044;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FS8crls/uRvtCmHET4e0Zbibu3jmMutDi9nHUxyq8Ko=;
        b=gyV9aH8bCNUvqZgHxKbMekzEJUoyyaMRZhEajlzF2aMtjd6qRRdkqZ9vLkIjL/0xSD
         rlFtK7upFeHO9oAhTQ6GVilwZg6O+TxH3GK2wZStHqzb0TjuPe/Kf19SDtt3plY4u9K6
         YstplRatetqiB/rtPjIlG4+OmmvdrBLLVRHWL3Qz1+RSsamrvuOKFijQh4YWQdryklie
         DCLUcOc7lh9vxmaJzNX3qNrxdd9UxBELzwCgufLSUuJ5x3c6LaY9jNbKLJo/Dpom7BNk
         S5yihHbOjbNytotdslpUW+3opdTUYcPih3UYuT7efsPHWWPHgZ7T1wFrTHe4PLTfXHuF
         Py+w==
X-Forwarded-Encrypted: i=1; AJvYcCUjZPZPWvjAt7TxIdIcIEErTxsQccaXU4rmdaB7YW0JFJGDgtGMDiqy2y57v/LLpLfuyMtTJByFKEr+aS/sFmdFOZQ8l8dCNdNGVdyNpDfYHbzULrZ57n/z6YEjaiAYPwC7SlafTGeu
X-Gm-Message-State: AOJu0Yy4HJlhwU0kgKQrUTJdE5dq0OAhPXXXEAq73NeP684ePSY1QI0h
	SIQqFMKvMy/wEkAk61ywWbIXwPd6h3CP50LE1qxkoGjVL4OXF5pq8Gaqa14P
X-Google-Smtp-Source: AGHT+IHE8nNMtwdZez7c1TxoHN97A2pPecKCtvKJTIJ3XDC1TUQPAXrlbgt/62L7zmsHk4y8P0jqug==
X-Received: by 2002:a17:907:9491:b0:a62:e3b2:6676 with SMTP id a640c23a62f3a-a62e3b267a8mr707809066b.73.1716967243324;
        Wed, 29 May 2024 00:20:43 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda46e1sm685467966b.196.2024.05.29.00.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:20:43 -0700 (PDT)
Message-ID: <539a815398a3c991c1bc1a53967fbcba282dfe3b.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: ad9739a: drop COMPILE_TEST option
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>, 
 Nuno Sa <nuno.sa@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Anshul Dalal <anshulusr@gmail.com>, Andrea Collamati
 <andrea.collamati@gmail.com>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 29 May 2024 09:20:42 +0200
In-Reply-To: <20240528121304.3695252-1-arnd@kernel.org>
References: <20240528121304.3695252-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 14:12 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Build testing without SPI results in a warning:
>=20
> WARNING: unmet direct dependencies detected for REGMAP_SPI
> =C2=A0 Depends on [n]: SPI [=3Dn]
> =C2=A0 Selected by [m]:
> =C2=A0 - AD9739A [=3Dm] && IIO [=3Dm] && (SPI [=3Dn] || COMPILE_TEST [=3D=
y])
>=20
> There is no need for this particular COMPILE_TEST option, as allmodconfig
> and randconfig testing can just assume that SPI is enabled separately.
>=20
> Drop it to avoid the warning.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Only for my understanding. When does COMPILE_TEST makes sense to add?

- Nuno S=C3=A1


