Return-Path: <linux-iio+bounces-18999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CBAA75C4
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C207BA7A3
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098482571DA;
	Fri,  2 May 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRB9eJLK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FB2571D6;
	Fri,  2 May 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198724; cv=none; b=k2X44g0u6jAorADwAceZ2VImWihEXO0Na5341xMmOcEj2D4j1DX7OFfemGxoEUVmEQc8OZ1CZ/DWArcoez6d8a7IFZRQt/15HPTyoNPE0gOZ9P8NWZt2CQPgURDx7Rkp9SmdLibai3FGqlZGRKGaqfGx3rRLCCul4w6fU0rt/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198724; c=relaxed/simple;
	bh=kZKXI6/uFrFgf0zzHWpzQU9eYJpYBDjFtMV5PFlTKpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSOhHT4AxpuYrHDhfcN6jmI+yGAv4TzJmnBs+nk3+/4lQDVyjFCHfiO65Zl11aA3s7TPvyZabnv6Cgfe60ymw+8G8+jo0hFj8MNt9Q7ZcpzSfT/Nqbxj3il4TMkLG9sjmedxP/9BxH+we7HurXo2xpRz9QOKES2cHTJluy8A1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRB9eJLK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so10909585e9.1;
        Fri, 02 May 2025 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746198721; x=1746803521; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkP+KLHEHGX3dt9RAviT/xgLgWvtY3Nj3l7Y6rhQasI=;
        b=IRB9eJLKKuTm7fXD8YzpDkdvjStCXV+4ktOabKecWPmGZVwr9xqKEakkhnir7clrJ5
         mWoGAd6EW3HO8mAPuzsG6JkK0cJ0Tj9MHo9f71i9QQ9xnIgtlyfvFSvzMGBm4VMVWuju
         rO0OELDp8MlcK1PM2oyg0D6cZcdssEhU1j9fffm8KsgaXwZjU620eO5VxX/HRdmMiGz9
         ht90c/RlqiKk3fg13zsiDTJfSoGWVajkHqPczp83G+qk44fGKPZnp0fn5WQvawbRQ2Fz
         1GfBSLJk0iyJTh+5m47k/u9/QKD1SZc4wSPS15OuwgXIerKNqVZ436v2pZivm7sgfplU
         AGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198721; x=1746803521;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkP+KLHEHGX3dt9RAviT/xgLgWvtY3Nj3l7Y6rhQasI=;
        b=lDtqNRI36dg4/tUC2s8MVOQsHHz4if3f46Vvv7Yv0qqTSVw7FIIKMsSOANDdR79tBP
         OtxFzflcviZL7B5XkR5mzUaSIp7q76XOwK6BF5HQz2arMBWjLnlOuii+nXRANqME2dpv
         E+WY7+yDgZaxOVye19SooTHETDjRiRBEtzrgT2PzAj2P1NQ5oV8VZzExZLlHJyk7Qcva
         66R7c5GNZnpG0MSTyu5v4NUxywzNq5tyy5PtQEzN0FzCBvw5OvIMlrVp1AKaRnUqiXpD
         9tTGe5vXRXjD5KiBoxwVxCJjaD8u/ZK45ZmWYmSqlTAfh5NwHLdmFTtADwJWpSs2XTyw
         hlUw==
X-Forwarded-Encrypted: i=1; AJvYcCV9zYyACQA81s0/K58NPUazhbeog1cF/erESVZzf9qbbWYk5FqvYgPFpaY6M+c4TevCUW9eunnEvnA=@vger.kernel.org, AJvYcCXKvWosvqcL2z7tqyfkVJziiwWbCWlE7qQL7wQGvXq7q5a3oUXVlDcNNe71IG/CZtKIc9iI9oT/B0brmALF@vger.kernel.org
X-Gm-Message-State: AOJu0YwmD4uxksqbKu5Tnab+vBDHxDhCstTBPYPBXyiUAUM2Huuy5AyF
	hDA1FTHxtMimDjl6qzGKrAil4uYkJyVEKxXo+Geygqi9AZljqRWl
X-Gm-Gg: ASbGncu8+i5cMht0OgvokbQakFngkMxQEJjhdTHtFqyRP51IaX9qKjjw3r1yfK95wrj
	7Spb64RW5Klj/b151bNGo/wXqPKMEv3Qix3xg6sNYlQ+dxcQwCeLH3xXVPzt983Ov8BCVdG3q4E
	2cfI1pUU6OJO93w182+gbgild0eVujBxRYDqwv/luZmtn/iVa0n3PdEwlBc+oaszt4cQu8qeUk4
	y99gueYhontfZfO77EqPZVr1TlKmH7o9ElCUf2QRicSeQ0g9HEf+6lECihzIRjxfudqfIDFdHzt
	tA9Tw0/BQmpyZVyq3x+kobErgqcop5cIIGmm86WjIOHhjhDM9DZVyOqPZtUw5eC4gsgBPH9+JYR
	n3N0TL98bP+QL
X-Google-Smtp-Source: AGHT+IEp5bjABLf5PrKWB38QP0IfyOTotnngZj4wN/0BMYkWeiZ9iIddCIgGrgPPB0CGA0rFvWwaUw==
X-Received: by 2002:a05:600c:828e:b0:43b:c5a3:2e1a with SMTP id 5b1f17b1804b1-441bbe98627mr33094745e9.2.1746198721079;
        Fri, 02 May 2025 08:12:01 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2af2a9dsm94013745e9.19.2025.05.02.08.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:11:59 -0700 (PDT)
Message-ID: <c3a792558b7d35f7342a53c94810861cb0eb0b8e.camel@gmail.com>
Subject: Re: [PATCH v1] iio: backend: fix out-of-bound write
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Markus Burri <markus.burri@mt.com>, linux-kernel@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, 	linux-iio@vger.kernel.org, Markus
 Burri <markus.burri@bbv.ch>
Date: Fri, 02 May 2025 16:12:04 +0100
In-Reply-To: <20250501063240.25295-1-markus.burri@mt.com>
References: <20250501063240.25295-1-markus.burri@mt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-01 at 08:32 +0200, Markus Burri wrote:
> The buffer is set to 80 character. If a caller write more characters,
> count is truncated to the max available space in "simple_write_to_buffer"=
.
> But afterwards a string terminator is written to the buffer at offset cou=
nt
> without boundary check. The zero termination is written OUT-OF-BOUND.
>=20
> Add a check that the given buffer is smaller then the buffer to prevent.
>=20
> Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buf=
fer")
> Signed-off-by: Markus Burri <markus.burri@mt.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index a43c8d1bb3d0..3878bd698c98 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -155,6 +155,9 @@ static ssize_t iio_backend_debugfs_write_reg(struct f=
ile
> *file,
> =C2=A0	ssize_t rc;
> =C2=A0	int ret;
> =C2=A0
> +	if (count >=3D sizeof(buf))
> +		return -ENOSPC;
> +

Oh, this can indeed easily lead to an oob access. However, I would likely n=
ot
mind in early returning an error. This is to write registers so 80 should b=
e
more than enough. Meaning that to trigger this, it has to be intentional. T=
hat
said, of course we should not let that happen but I would still truncate th=
ings
and let it fail afterwards (keep the code slightly simpler with one less ch=
eck).

So I would instead do:

buf[rc] =3D '\0';

Thanks for catching this!
- Nuno S=C3=A1


> =C2=A0	rc =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> count);
> =C2=A0	if (rc < 0)
> =C2=A0		return rc;
>=20
> base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e

