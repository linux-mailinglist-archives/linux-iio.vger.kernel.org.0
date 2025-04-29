Return-Path: <linux-iio+bounces-18816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EECAAA0562
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 10:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 238847AFEE2
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823DC27CB06;
	Tue, 29 Apr 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/2odkZ8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED7279780;
	Tue, 29 Apr 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914744; cv=none; b=W/KgpcXmmY+fySySZzcW3rC0042kFGYL3YQl31n2Ws7FPrjWDj/NSKA87nNDdsn72oXLnjYP0Z7wiIxuq3rhu8vq9VLgtCl2K/AewvL8Tys3essdWp9x+DCGSK59ksLCEIh1sU8FKr7jSL3H5hhsT1Yy7O4iI/DUY5uRFhCaHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914744; c=relaxed/simple;
	bh=zdQtr5BpDPtn4WyFu7EVp2u6hZD6bKnsxFgAh2z2mkY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxKz531ZIGzL2r4cwuneyU1h0PPZIjt83CHEAfI2Zr+2VX5dODn3ybDUnNSypAiI8gvLxZLhjsQer3MLIABMEXKMf9T/M9ADNGiLRlS3zOOuYx5lxVWbdx+uxmu0QoLqs26zYz+1fofBU2QURGtURa83gRfDeCbwr6NcBpS7Fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/2odkZ8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so47630365e9.1;
        Tue, 29 Apr 2025 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745914741; x=1746519541; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thr7s8KgPtJ22/lvJstaJ+JSkl/4Ybu6j+EVbeRWoxo=;
        b=X/2odkZ8fQ/xa+dGHfc8L4pCEkTpiktXzP6LCPI3B4ystUvP9Vc/5GsIwNKHlLgbAS
         D58myk4ND7G3D5c8DnUOBzXqzUJWyQCFjoxOlvL3/x9NDvZncdKoTy9WiZ3TE4OCyEvE
         u7kib0/tsVg10W2P9eWC0y4YtQ1rDRpEeP2iimEirF0foiLBVL3EEx4HoHQho3RomSaT
         qA04yLVEbs9RClep384NkuAlWew6QF7bvf6ir8+W/UuqT62U/q6S1reqGJX9bWBKl5kn
         o5nCwfPApUdGpiuU/mth016flcNOfRemFApcvF9XAXb1KrbeTIb5v8oV4rwqm0I9vhgr
         9rJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914741; x=1746519541;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thr7s8KgPtJ22/lvJstaJ+JSkl/4Ybu6j+EVbeRWoxo=;
        b=OqtedupjDq/qLSJLY7P+KhKT9+hIwjBVpMJek9uRF9guQ0grJ2h4wZ7YBnf7ynNmHV
         DJVigfrQf2raynay5HTJ4GxVkP5nbo3p+1bxT649gt5DJojhMZR5jwC0wvtzYu9ZTOpk
         df88VzMS01pcFkBOiaiCt0Yt3WbtOZvDn8FfGnBN3AwvGltbjMJQD55UUzQzJvHPna+k
         KeTCCOOtNk385iWuHYBpjgNRXE+LTPPWiAyKqG/oUa6nbz17f/bwzv5ec3r52fyvkZQs
         w1OBw5tJDepzkp2kp5NPbYEHE7rm4/otXcmcGWPMVfgAIAvjABcVdkWMnWJV9ibm/a1s
         IdwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Nt+g6HxekqPbxJhqI6GmDYJ3vGsMhujT0dozXULd8ezkBCbfg9ZGTy/rPGTRU8FIu92ZzZc5ItTK@vger.kernel.org, AJvYcCW3iSP4TobDL2kAZTLuwIWemZe3kx0gLtAXyEJNDP7lZIJK6BPP6AnP89MIZ1Thi+/fJBzfQscJM70H@vger.kernel.org, AJvYcCWgQt7Cl11SyawvRSYWnyZC4qMfVgyUPHIsuAdjWFnDk4ZOubUUwFY1GC8mv2bNF4lBulzGueE6bsL39Odf@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiUUbZiMu3Iliy8/DKnwKRddEMqSGNgxZEPe6KFzghS/6bs69
	yJF6Lp/SKH1VoXT+PAVfwA97rxPKapb+pxshKO0euMI8+gj/+5sh
X-Gm-Gg: ASbGncsg5WC9DUmYU341imDtNTTWKaOYgrYaPyfVmngFZDN6ujstgLS7KCPyIAX5sz7
	ORoEtbPM0gAIm3Eve4G3w+7VbBrPW0y62OrWgqeq65rZSb5zVBmIj4WP/QLE6K5JXTLhaH+tF2x
	U/7PWDBU1SwyO8ng+3UNrdhUQAvHE9Xh6EcZaEmb05jIVYnhgu13CuZahhXCiLWrdLmSH34NKaz
	jiK9O24PwqlFnkOcRUU4xHPhJUylFV2plp2rLfEAvl3d4vYCmLAINtzM9t7dRB81Be2d1yPAx2a
	LVL6JvW/0q0xvqI21bENKqub7v2orrqVuLJR3DOhv14ioMagpv3OuYDepELgy7ktkz2VcJw/x5D
	PA9n9j6cMiGxB
X-Google-Smtp-Source: AGHT+IG9xrL2a3oUvPs5IPfumvNNsNytaMGFbF33fTsC07NjkBLJzwQI4qV/tm6k4I2C3MF3ub89aA==
X-Received: by 2002:a7b:cb88:0:b0:43b:baf7:76e4 with SMTP id 5b1f17b1804b1-441acaa8d6amr14442345e9.1.1745914740585;
        Tue, 29 Apr 2025 01:19:00 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2e00e3sm183004705e9.34.2025.04.29.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:19:00 -0700 (PDT)
Message-ID: <dc2a7cd3bff229dc70255ed1d2def98739754a4c.camel@gmail.com>
Subject: Re: [PATCH v3 04/11] iio: backend: add support for number of lanes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2025 09:19:04 +0100
In-Reply-To: <20250425112538.59792-5-antoniu.miclaus@analog.com>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
	 <20250425112538.59792-5-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 14:25 +0300, Antoniu Miclaus wrote:
> Add iio backend support for number of lanes to be enabled.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> no changes in v3.
> =C2=A0drivers/iio/industrialio-backend.c | 17 +++++++++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 3 +++
> =C2=A02 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index f7c8167a248d..1063935cd808 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -833,6 +833,23 @@ int iio_backend_sync_status_get(struct iio_backend *=
back,
> bool *sync_en)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_NS_GPL(iio_backend_sync_status_get, "IIO_BACKEND");
> =C2=A0
> +/**
> + * iio_backend_num_lanes_set - Number of lanes enabled.
> + * @back: Backend device
> + * @num_lanes: Number of lanes.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int
> num_lanes)
> +{
> +	if (!num_lanes)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, num_lanes_set, num_lanes);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_num_lanes_set, "IIO_BACKEND");
> +
> =C2=A0/**
> =C2=A0 * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate)=
 mode
> =C2=A0 * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e93d1a98e066..c8bcfe96c542 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -112,6 +112,7 @@ enum iio_backend_filter_type {
> =C2=A0 * @data_alignment_enable: Enable sync process.
> =C2=A0 * @data_alignment_disable: Disable sync process.
> =C2=A0 * @sync_status_get: Get the syncronization status (enabled/disable=
d).
> + * @num_lanes_set: Set the number of lanes enabled.
> =C2=A0 * @ddr_enable: Enable interface DDR (Double Data Rate) mode.
> =C2=A0 * @ddr_disable: Disable interface DDR (Double Data Rate) mode.
> =C2=A0 * @data_stream_enable: Enable data stream.
> @@ -167,6 +168,7 @@ struct iio_backend_ops {
> =C2=A0	int (*data_alignment_enable)(struct iio_backend *back);
> =C2=A0	int (*data_alignment_disable)(struct iio_backend *back);
> =C2=A0	int (*sync_status_get)(struct iio_backend *back, bool *sync_en);
> +	int (*num_lanes_set)(struct iio_backend *back, unsigned int
> num_lanes);
> =C2=A0	int (*ddr_enable)(struct iio_backend *back);
> =C2=A0	int (*ddr_disable)(struct iio_backend *back);
> =C2=A0	int (*data_stream_enable)(struct iio_backend *back);
> @@ -212,6 +214,7 @@ int iio_backend_filter_type_set(struct iio_backend *b=
ack,
> =C2=A0int iio_backend_data_alignment_enable(struct iio_backend *back);
> =C2=A0int iio_backend_data_alignment_disable(struct iio_backend *back);
> =C2=A0int iio_backend_sync_status_get(struct iio_backend *back, bool *syn=
c_en);
> +int iio_backend_num_lanes_set(struct iio_backend *back, unsigned int
> num_lanes);
> =C2=A0int iio_backend_ddr_enable(struct iio_backend *back);
> =C2=A0int iio_backend_ddr_disable(struct iio_backend *back);
> =C2=A0int iio_backend_data_stream_enable(struct iio_backend *back);

