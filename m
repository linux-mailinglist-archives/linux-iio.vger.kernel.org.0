Return-Path: <linux-iio+bounces-11887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39F9BAF57
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC945281096
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3086F1AC459;
	Mon,  4 Nov 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6I02Yb8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82E1AD3E1;
	Mon,  4 Nov 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711610; cv=none; b=N2BqE2IYGlOYfp117lvCZynCreMaz7jfa8wjNckeEMVBOZU1biTuKECUZjXVMMfWnGBLwj2DmEWxZvyztGXfxU4YMQgd30pJZQeb0tmgESbvr9sMM8/0/wBgRhoi69LUT5GdmoucZou7XcwXsl+v3EfZvBwFmEAWLpqpqGvCgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711610; c=relaxed/simple;
	bh=hOjkAJ5SCB6kTsK3AmNEPFiSQj/wTUWWKnVCS6ZPCc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PbXJyy+8pm9M1C7HM9yMGtpayV49bnHQZXgi/Qw1RsCnlVO3vbmmKkCyI3hgWVEb9db7haPnaCouYoWH66hf/z2p/gizXmvxjz9hcs3uGWN7ui+vC+F9i52VqBUTRLPptN30RnrUbscNCYZYYSo1QM24HKuUXqFpNuggi2VUZJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6I02Yb8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a628b68a7so633500666b.2;
        Mon, 04 Nov 2024 01:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730711606; x=1731316406; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZsyqYVJ5/bVxaZHofzYlbCWudDklkcbSgz9H2bcDlZk=;
        b=I6I02Yb8xUF4bvtZJee6xeJvGj2MaP5FFo0kazcEFNh8aTBYkQjdwmpXI8Ple7CB29
         oebWQPBCgE5syuOZLzKawToGtKTtip0JgcdNX0/DId6dbYAxFnJupyMzucMwEzXogBbw
         WRNcsBQl4LzFqsiPtorvG9c2uWHX3/BOGj0xqoSQ51PkwjEYB9FX1i1vsXbKtmXNIFuE
         pIkK50rQhjS8Fd1qCLIB9/iu5g+XGAoiMP+ml5VbRqj56yoTkqFmt9Z5wLHlXBooQeVi
         ivUtsR9B6GemAHdUS3LL1EM6Yw7mWJ3AFnGMC5e5N4FxkiMIns06/E0wBzQWe1QhLS5S
         mduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711606; x=1731316406;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZsyqYVJ5/bVxaZHofzYlbCWudDklkcbSgz9H2bcDlZk=;
        b=ApuR4toODZq6YXXnS499IIOQHnRKuc1vbuevKWtLJ4X/MShVsGn3Q8PNAx1UnIjl8d
         b0snMRwogyTswyHhVkJl1Dwz/YM+d3Vul1Wmr97CcoItj2ZOu2tksRq2XghxuziBvKqC
         cz3Vzv1R0qc7j5PYBUDQHdOX8Q3d2A/3nLqYYmZrEZ/LI9/OHDEk749WfSpSGB2qBQ4v
         CSBynRzSyMdl1YzNqBQm7p2jVbdnpros902deQaQI1szpN3wdgsK0H8LpB2jmFf8VbTK
         LExlLIXbkWCMiMRVwxjq0T22c1QWmeCEstrnHdfbtrtOvd/umISS1Z7/jP2F6/tZtzup
         GX/g==
X-Forwarded-Encrypted: i=1; AJvYcCUX1Nf+o5fbfGXzabZUIUNL/7RIvhiXMUokeQTuny2G6Blpw2zWE2UbBiKONc+3lcyVFkmamq0DKBN8TbQ1@vger.kernel.org, AJvYcCV+8Swu1eaYmAhjkXQ6OPTrKfMRzJIt4uYKN6GygsryNJ3uQY2Y04jYylO/nX+09sxKjwr8K+bDYqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2Hl79uADbgOiNCL8OWbl/dPCGCOQap6J7xyEfhs/CZG8zid/
	nNVeaoT9TtX+4UeznJm6RlvfPcA1AB9WqDC41JaVle0AAmfz0L1g
X-Google-Smtp-Source: AGHT+IHKyIxhG50uCvmxgG42SM/8gWqwGCkeMI2XnTBb3rbM0dKMmYxMg6IWDWtFHr32FJpraqjcRQ==
X-Received: by 2002:a17:907:97c6:b0:a99:2ab0:d973 with SMTP id a640c23a62f3a-a9e657fd76dmr1092897966b.55.1730711606239;
        Mon, 04 Nov 2024 01:13:26 -0800 (PST)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564942c8sm527500266b.28.2024.11.04.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 01:13:25 -0800 (PST)
Message-ID: <4ed54857ed03779ee07d0dce66d6cd9c25c481e6.camel@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7923: Fix buffer overflow for tx_buf and
 ring_xfer
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Zicheng Qu <quzicheng@huawei.com>, nuno.sa@analog.com, lars@metafoo.de, 
 Michael.Hennerich@analog.com, djunho@gmail.com,
 alexandru.ardelean@analog.com,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, tanghui20@huawei.com, 
 zhangqiao22@huawei.com, judy.chenhui@huawei.com
Date: Mon, 04 Nov 2024 10:13:25 +0100
In-Reply-To: <20241031210501.3da82113@jic23-huawei>
References: <20241028142357.1032380-1-quzicheng@huawei.com>
	 <20241029134637.2261336-1-quzicheng@huawei.com>
	 <4760ad42ae34ea53ffb98995d65c5f1d6a6b3f9e.camel@gmail.com>
	 <20241031210501.3da82113@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-31 at 21:05 +0000, Jonathan Cameron wrote:
> On Thu, 31 Oct 2024 15:20:24 +0100
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2024-10-29 at 13:46 +0000, Zicheng Qu wrote:
> > > The AD7923 was updated to support devices with 8 channels, but the si=
ze
> > > of tx_buf and ring_xfer was not increased accordingly, leading to a
> > > potential buffer overflow in ad7923_update_scan_mode().
> > >=20
> > > Fixes: 851644a60d20 ("iio: adc: ad7923: Add support for the
> > > ad7908/ad7918/ad7928")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > > Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> > > ---=C2=A0=20
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
>=20
> Confusing one. I'll fix the authorship up for your analog address
>=20
> Zicheng, usually a Suggested-by after checking with the author if it's
> a patch in a review thread.
>=20
> You can't really give someone elses' SoB without them explicitly sending =
it.
> If Nuno let you know that was fine off the list, then just mention that u=
nder
> ---
>=20
> This time I'm going to take Nuno's RB as fine to indicate no objection
> to the SoB. Nuno, feel free to shout if you want to handle this different=
ly.
>=20

Oh, TBH, I did not realized by SOB tag was there. I'm fine with it even tho=
ugh I
agree a Suggested-by would likely make more sense.

- Nuno S=C3=A1
 =20
> Applied.
>=20
> Jonathan
>=20
>=20
> > > v2:
> > > - Fixed: Addressed buffer overflow in ad7923_update_scan_mode() due t=
o=20
> > > insufficient tx_buf and ring_xfer size for 8-channel devices.
> > > - Issue: Original patch attempted to fix the overflow by limiting the=
=20
> > > length, but did not address the root cause of buffer size mismatch.
> > > - Solution: Increased tx_buf and ring_xfer sizes recommended by Nuno =
to=20
> > > support all 8 channels, ensuring adequate buffer capacity.
> > > - Previous patch link:=20
> > > https://lore.kernel.org/linux-iio/20241028142357.1032380-1-quzicheng@=
huawei.com/T/#u
> > > =C2=A0drivers/iio/adc/ad7923.c | 4 ++--
> > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > > index 09680015a7ab..acc44cb34f82 100644
> > > --- a/drivers/iio/adc/ad7923.c
> > > +++ b/drivers/iio/adc/ad7923.c
> > > @@ -48,7 +48,7 @@
> > > =C2=A0
> > > =C2=A0struct ad7923_state {
> > > =C2=A0	struct spi_device		*spi;
> > > -	struct spi_transfer		ring_xfer[5];
> > > +	struct spi_transfer		ring_xfer[9];
> > > =C2=A0	struct spi_transfer		scan_single_xfer[2];
> > > =C2=A0	struct spi_message		ring_msg;
> > > =C2=A0	struct spi_message		scan_single_msg;
> > > @@ -64,7 +64,7 @@ struct ad7923_state {
> > > =C2=A0	 * Length =3D 8 channels + 4 extra for 8 byte timestamp
> > > =C2=A0	 */
> > > =C2=A0	__be16				rx_buf[12]
> > > __aligned(IIO_DMA_MINALIGN);
> > > -	__be16				tx_buf[4];
> > > +	__be16				tx_buf[8];
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0struct ad7923_chip_info {=C2=A0=20
> >=20
>=20


