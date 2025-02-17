Return-Path: <linux-iio+bounces-15626-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F26A380AE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F03A9D60
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D431DE2C8;
	Mon, 17 Feb 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYscKCas"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15415C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789361; cv=none; b=lt/BKdlA8gB+rdI90WEzRh4LoEPAx/dIzx9tQo8ioIgWy0MqLkpEuARp77dOfPj/qLg3cI+2hc6cwzYmFZJ8brkJd6KCJlkd9I2s0IWU24ZfTCPUrHxWHABsg4MrAoMZvzLG5HsX99hQEpaCO5NwCQY//U3gWvSWB50UfpCDIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789361; c=relaxed/simple;
	bh=AoQ9L0/d6oBpEfF+pcYH8YfaSk7PZ792AMmfw77QfkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=imd3YA8o9aunrChSCiWPUEqg3yp+Fm9oh6rFZc9b+1ukOw/jJ7/D7YnFzi8sdTCe1eV2X8LuQwgas5s9jloq+0yUY1FCjziKMb4pi+4nXAsAqWddjF1gR+BAqiElYfvW8iIAGS2McKeveScEcu53Fa2OxfwNuqnzGmANuIiwBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYscKCas; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so28488495e9.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789358; x=1740394158; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tRJUhmQ6eYZMty1dZsxhBcKyWVEazI6qe7dy9bXRKqM=;
        b=GYscKCasHmlBWEmuwe+aHpiZ4sZMLNroz45VdiEc+wuGbbylEXIa9nXyjqz2FPPf+8
         m38yaKTl98jmfjOb2qAnWxqk4fF8uCtaomRhcOdqSGcxuCHn4YM6Hi98lVCwWAH6lpxf
         NLWhzicL7KLP+Zqm4LxNtgZO4cmaMwq4AVs950apCwuoY49zXCoOSilFbkBhsWIMw5uA
         F/TZdfi1lexN8oUBLwxhrG41zoZnuAoqK5RLU6BQpiO8CWLRLSy5xjoT7mfHA0ZzbbdQ
         HW6W/MWWCHe1pbqgLMdw3bJonDCfR90/ft1h4hH7uYZVtQtt5S0kxrjdI4uNFf1tv8Mu
         wZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789358; x=1740394158;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRJUhmQ6eYZMty1dZsxhBcKyWVEazI6qe7dy9bXRKqM=;
        b=Eu6z2uGbziuVy+Hz4d8R2VQ1GE9Z8l/nSeMbyvOT6awrC9Mus7ycayhObnGz3pZAEc
         XJzt2UH8wlM54wiXvDCc+qcN7vVNxP2i7UhWiZqK3REoL8s6bbY+VmWgeA/YOi1Dj37e
         6CQ28eSpsEh5SMDbJmKqg9z0SGJEaZkl9F/y8ZqVPRnVQIIa+hj4uX15YCKWSI0BuLqP
         UmQLFRWReMEkmuDWT9vhXCGfdQ+/luu/b7E6Dsp3mxFC4Pvi8GYjKdGnWEkKJqBkB58f
         6OpiCMiz/nVgqECvzNAA22LUoEye9+6CrVE9zLsgSGA3HzndaDWwPB+eKPtYNr91aeM6
         ynUA==
X-Forwarded-Encrypted: i=1; AJvYcCVd3ymNbqYlrRVcqgCZnVeiu2WWoPkeVd1Iiq4y/Y1VGHg4D3sJr3GL+ToWZP4ufmG3SuX6ylVUEC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1POmcZTVFSIPEsTl2dRqfgxrhNRdV7LQUw4nT8p6/Uz2/hoOI
	syswgI0FbbapT5wdvEZJUbw4kkke9VBvW1wpsGl7okpCpLo0G2Sw
X-Gm-Gg: ASbGncuYJDu8P1qKJZJrajJEnpReAcl+KWFlR/jPs7/Pl+doKr5G1rTlUzJhBB6IOgv
	7CVJJ2tjCI6PQYNo6oXL3uIvIFpg4AcXDKtXYZQgK3aa3CeDyV/JXsLgjeXJqQmYKJZpgDmyrur
	JMSrwzM45qhE0+5Th1duYTuxBw6V3+XGzrCR3ZugMFKOmiaSAcCSEbJ/8VGVl0f/OIOtIPFf5S1
	atysOTlNqz4juzYxkBNhYna69eZ3ZGeC38/iWGUGl8EQuxGaDHqP84xRBZDE1tV0GMvoRENwE3g
	0DQ7QYk8y7qlOwd2nVaaxeFwJdyOi3DVD2SWgvrQrpGiu6dGwiQD/zoUcgoQlms=
X-Google-Smtp-Source: AGHT+IHPb96jp4hl/LUfsecgA2ShfW57OnM69isBX0Fkkl2ot1WmWJGC/vBoKHujBjjIM8X+eQMvEQ==
X-Received: by 2002:a05:6000:401f:b0:38f:4531:3989 with SMTP id ffacd0b85a97d-38f45313c69mr2779761f8f.51.1739789357718;
        Mon, 17 Feb 2025 02:49:17 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5ef9sm11877558f8f.76.2025.02.17.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:49:17 -0800 (PST)
Message-ID: <cab076f43b3955d108e37dc324ee2c93762720e5.camel@gmail.com>
Subject: Re: [PATCH v2 12/27] iio: adc: ad7606: Stop using
 iio_device_claim_direct_scoped()
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
Date: Mon, 17 Feb 2025 10:49:20 +0000
In-Reply-To: <20250209180624.701140-13-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-13-jic23@kernel.org>
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
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context.
>=20
> Cc: Guillaume Stols <gstols@baylibre.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7606.c | 14 +++++++-------
> =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index d8e3c7a43678..39b5bf09e46d 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -752,13 +752,13 @@ static int ad7606_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0	switch (m) {
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret =3D ad7606_scan_direct(indio_dev, chan->address,
> val);
> -			if (ret < 0)
> -				return ret;
> -			return IIO_VAL_INT;
> -		}
> -		unreachable();
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +		ret =3D ad7606_scan_direct(indio_dev, chan->address, val);
> +		iio_device_release_direct(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_SCALE:
> =C2=A0		if (st->sw_mode_en)
> =C2=A0			ch =3D chan->address;


