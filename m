Return-Path: <linux-iio+bounces-26277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3933AC682E2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF34E3513B0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23AC30CD88;
	Tue, 18 Nov 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKrRKswX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D530DD21
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763453849; cv=none; b=a7rcDL2p3J+Y+u/H32QdjlB0fIjlMXQsHCi9gtxU3LFtwWKC+dRWFGX+AtMcKRsJGNi0quBL3faL30tP1T89DE7Z8/ZFgX2CuaJwiwmo1R6IxgIN10nTcWZUZj7Oku3apsOMxtvGjq/lgG3ySzPICCESfLToJjjoOfAer//xjDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763453849; c=relaxed/simple;
	bh=Xbkd0OhYK9CGSu7BYStw60Kktb8UPNtSubpkQmtNXQ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UclFcgIWh7L0JntvmswrmLQm0lJFvWjwF6QXKcuxO0PeGfVcasCT7eC9/NSXw7JpBJPRdelslL5UZUZYAHVLcuS5zUHtcHxWsABgW17U0OGcsk4kEWTAzy6acpf6mq59LXwgLTHZXI/AhOdE+jsIHGEK+gGR2ROI1V6NEkzVqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKrRKswX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632d9326so35170075e9.1
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 00:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763453846; x=1764058646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xbkd0OhYK9CGSu7BYStw60Kktb8UPNtSubpkQmtNXQ4=;
        b=kKrRKswXT/RReYMXU+TukCUrXy7yd91kfB1ZOWCq4dpvfSz3s9QVFdZBE/opHn0RES
         IhAiGRiBM2pve7N0gL5agBEiAnpiX04STINS9ITBBQoiRmWvOMli2hqMb9zheQ0NAkJM
         oOQYKNjcokAOIpkkiJzEMZRJG1Zz9reTEv/dQIWbY34EtWBRHzomEzZQMm4hDn7iXE2S
         jBXkqj/ZiBIJMFKuVTADTvC2ZeGjAsX2HSJmmnw0+o6bSKLip+NAZaMP5kjYH1k3eEoM
         axsZwTbjSu9lMXUzuJW00wS/0pGtgquzxM5ZREEcKakI+2Az9tq7xvrflpdLca29Mm80
         9qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763453846; x=1764058646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xbkd0OhYK9CGSu7BYStw60Kktb8UPNtSubpkQmtNXQ4=;
        b=gQXySKu+IgXI+ZBRvV4VIc1XKVPvZx2dyiZ2WmHl3m6xZldba+ed66Sb4hG/vCOmvp
         yQxlWmZ5xpRw/g4B6gimB8FgEY+1nCF0UmrRlshnFJQjpi67wlhb9qIjW9V3zD1sOB/x
         IYafpxUDHchPSsvh8w2LDUOg4KQ8TScVHxn2gwnmUeAjuvrwbXxm5QSxDv2BJBnxgkx3
         8B38B5tzcHHbLPDnjereJFoxWtRyyClJQDiUSpeBSNHIJf7oQVrJAVS3YD4gWeXCVlJP
         q5MnVMQxBqaoanmcSk7aI+CMYFgkxoEXxECtKOvGGPtT60y91GgabH+OLgHqSMQkdvBR
         BizQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPqxxTRnF8UEIcofRaZFzEgB1JKklFk+i03eVD0U39hFTiQinN0drvv9tzRd4zvFrYAKOVt2QDyaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BTgH4UHcI2ZyxaCoqRQXCuhHO18gns8utvJSRe7Yb+Sdhr9F
	HS837AVXT7dVYBJmFubypi51eTxmvNCXU9q0k1o5KA0A4yXaOqeEBxD0m6JwRg==
X-Gm-Gg: ASbGncsHxTl7t65kw61Yur0m4SHLLwt0RfUwExZ6g6WT7B9inxZdNc5rb4wAetP0VEu
	nbkbYLZY4nJClMXhSaqmcsRFnCJkyNFcqMYsEbTY6YRziDfOujyH3KSc6Yr+hEwFxmr5zTGse4o
	Gd7HW4T7SuzRP+VO4l/AfusVZaM1glhNJNFqMMI4oj0RKgHDEmTQfDglV36LOLoO3LZTTtWyKVj
	VV/qenQAtrGB9XGknGnE1Yh51sUt1fIbR3nAl9zhsMuYBxyEA9UX2gNmDpnkV5l89exE//UpmRC
	BeE/6eOcXTooEEF0Y4c2xq83EdhgvAJe10rP4eDLULx4sI7RgNxqT4eF0YgEchphD6C8Do/69ym
	Q6cQeZMl8XI4Ui/vjsxSJjYS+XVfFS1wILiXhJgOv+8cI34wGaH76rr/adXdgOqCnWXbWF0aCzf
	OUBJGlwc1uUBuvxYsraErtP5SBllmIKFqbFCkdWDGQ99fsAuQG
X-Google-Smtp-Source: AGHT+IEQK9M+UEhXUxY/WFeaRZPh0DFjsNVaCKSh+luJ0k+GHsFsMy0/x61VLnd/4XfZ5D3SUwZ4aw==
X-Received: by 2002:a05:600c:a07:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4778fe55101mr136563585e9.4.1763453845879;
        Tue, 18 Nov 2025 00:17:25 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779920f2cdsm200467775e9.10.2025.11.18.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 00:17:25 -0800 (PST)
Message-ID: <34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with
 sysfs_emit()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Shi Hao <i.shihao.999@gmail.com>, Michael.Hennerich@analog.com, 
	lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, 	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 18 Nov 2025 08:18:28 +0000
In-Reply-To: <20251116152800.4c1849cc@jic23-huawei>
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
		<CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
	 <20251116152800.4c1849cc@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-16 at 15:28 +0000, Jonathan Cameron wrote:
> On Sun, 16 Nov 2025 13:08:07 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Sun, Nov 16, 2025 at 12:16=E2=80=AFPM Shi Hao <i.shihao.999@gmail.co=
m> wrote:
> > >=20
> > > Convert several sprintf() calls to sysfs_emit() in the
> > > sysfs show functions, as it is the preferred helper and
> > > prevents potential buffer overruns.
> > >=20
> > > No functional changes intended.=C2=A0=20
> >=20
> > I briefly looked at it and see no issues,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >=20
>=20
> Applied, but I will note that this driver is a long way from suitable
> for moving out of staging and I would be surprised if more than
> one or two of the lines changed in this patch make it through the
> necessary refactors (should anyone actually have another go at
> doing them).=C2=A0 Anyhow, I still think this is worth taking just to
> reduce the noise of remaining instances of this.
>=20
> I'd have deleted this long ago except I actually have one somewhere
> and it one of the supported parts was still listed as suitable for
> new designs when I checked not long ago.

Seems to be now "just" in production. So no longer advised for new designs.=
 I gave a
quick look and this is far from being a simple driver. It would require a f=
air amount
of work to bring it out of staging. So, are there users relying on staging =
drivers?
But I would assume that for staging we are still free to drop support it?

>=20
> ADI folk, I would like to hear if we should just delete this one.

I guess Michael is the best person to answer this question.

- Nuno S=C3=A1

