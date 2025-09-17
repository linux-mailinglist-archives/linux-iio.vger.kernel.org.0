Return-Path: <linux-iio+bounces-24218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D634BB80773
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CC8466188
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2F33592B;
	Wed, 17 Sep 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llj0cr9Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0A2F49FB
	for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122254; cv=none; b=p1eJUSshIKlyck49tix6TeNhiBAhRL01sTK47PYxTp/FkBGB4+VfxotwZ36QCPmauPNwTsJya/BLYCtBxb3xZP3i4nUF5hYGXXxZttM9M8+KguhVkl/2a3yxlQ334iJY1BB0dyZR/RW9x5+dWEz/rRFu7ZMYvqh1P+DAqe/NNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122254; c=relaxed/simple;
	bh=bEyXUHGfChjaKW7D1iCKrZxj0SfOD7seNsJoVOKJnnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2vrA6f78x57K0Ph7BOArqDh2wrbDkPUKMIgx/S13YzlvXS1ZxH5ResSidXiTw5nYjctQtNJhYZob45Hjj947Gp8fvqvGs673eDOVM8Bm92e3KrCO9vo3S+bbWVNDJhgjXxIUuXuxFsoQphwutUpY9OdhP/ab4dEDuiwC0vIBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llj0cr9Q; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dde353b47so41344495e9.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Sep 2025 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122251; x=1758727051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6LiVoSFszZzWGxoTKoX/IVcu7vE/+lNgVzYVOLR2NBE=;
        b=llj0cr9Q36382fnAfhvp2/3WQ5UuhY724h6XWpmq7NvFFsiR8trxH4tUGtThBs5Tyo
         EXO4GgXUIr5qTvtumdLMlXPsTASeKsSBTpKTG25WlWdV5TT30kZvuznW33xjq5IpGLgP
         ZGZFDVW2tE3l6ZYaOV1Kimri3Fcx3KCex78Z/FofDn4nbh+VeDEA5VhUmuxP29XVuDJs
         eEl73+qJYYxazlSRmOcK9ufjOwHf6B778K5tKQatPfALVNm8hzfO9II3UhmQRYUMAnWe
         cb4iPlevupXAhWKKuhAtGj7j+YCTNxlv9ofVIUTBCGDKhzZC0/k4PGFw0p9JGkdvtziV
         owfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122251; x=1758727051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LiVoSFszZzWGxoTKoX/IVcu7vE/+lNgVzYVOLR2NBE=;
        b=O5MXiVsaPR8uRHeTt3/LNlOOIf1QP/15pzh+6ZHLaDUQ1WtbXYq55yGwIcgHcOfgNo
         VanHwUljjpngnB0U7gAaxyFl0gnrKy424R7j+sV27C0MdbFagY95THH1o+AMIgUbrHMO
         VmNhPIW42ZsQnrkDE+owGxtriGz5A0EuoV9mFwDS4bzKJaQWvr9XHImNxa1808BBcC3c
         kjU5e5BRDNwLXJ4RIO7Oxkn1CpWtZpbhNfT69AcQmaZ3tijbkjJVoTI5deW+Js3QNq8M
         kzYM3sMWr7m96IDvBrVwn00A0DZRjJhqXJCLHjDplGjfbxQtn1c8S8V9tfnZfjgzBsaG
         vNow==
X-Gm-Message-State: AOJu0YyM+2JMsONuoy7PEYZFDf7R4GiE7xNDJoAay5M6pozdX+5e67/O
	TnbQxsBkiJeS2omhcD0xbyLJ3ILwOlcVk0XAdWlVJ/x/zwAXXxSPz96y
X-Gm-Gg: ASbGncvDi5bB8IHpExjUbn+GsjRN5u7SvZU4RsaYhVnbMd6sLeJR43rbJpBul/Xas3U
	RzzecCPkBPWlP9zpdCEQUteN9i2hQJdp8t5GRsmW1cn5IH6Fp9wtekA5tRlv5XwIFsBKRr8I0Ze
	BIcIBC7dIU/Ye8sTiD9BlOolHS5spKKmu2mdLgndMxa7UFxUrP/oN27K8OG7WA8eOYb97GzPLDD
	sQ9+HlY0CiZCxwkUyfiqxxYCPFupVMbtu2qEJMMLeP4ZRTTlDYEKgXzD/zDE0+Lt0ENiS5u/+tY
	RKtaS/J+0jT6pMehqKadewx0alCsn4fcrlVqFoTwiwmCv2+JcuTp8RVu/QruQk0hAMS5qcGC/40
	2OMD27kX1ZN0vNv7gC5Yj2yEXjd4nA5U=
X-Google-Smtp-Source: AGHT+IGXiQ+wA7dnLWWohC9yMHk1s20he8pMp2LKEHl6ojec0wQ8QcHJtxsvyOT/9Gpxmj2HMV+okw==
X-Received: by 2002:a05:600c:4448:b0:45d:ddc6:74a9 with SMTP id 5b1f17b1804b1-4620376f653mr25658245e9.12.1758122250486;
        Wed, 17 Sep 2025 08:17:30 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f4f9f339sm58355e9.14.2025.09.17.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:17:30 -0700 (PDT)
Message-ID: <add0b8de5452d9cb293c175c60cbb71b5ccac2d0.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: use AD7124_MAX_CHANNELS
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2025 16:17:56 +0100
In-Reply-To: <20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-17 at 09:17 -0500, David Lechner wrote:
> Use AD7124_MAX_CHANNELS macro instead of hardcoding 16 in
> ad7124_disable_all(). We already have the macro, so we should use it.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7124.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index
> c24f3d5127cb83eeab0cf37882446fc994173274..9ace3e0914f5acab695c0382df758f5=
6f333
> ae72 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -702,7 +702,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *=
sd)
> =C2=A0	int ret;
> =C2=A0	int i;
> =C2=A0
> -	for (i =3D 0; i < 16; i++) {
> +	for (i =3D 0; i < AD7124_MAX_CHANNELS; i++) {
> =C2=A0		ret =3D ad7124_disable_one(sd, i);
> =C2=A0		if (ret < 0)
> =C2=A0			return ret;
>=20
> ---
> base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
> change-id: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446
>=20
> Best regards,

