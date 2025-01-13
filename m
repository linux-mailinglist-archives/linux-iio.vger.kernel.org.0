Return-Path: <linux-iio+bounces-14293-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7ECA0BCB3
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 16:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A55B166278
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9D1C5D60;
	Mon, 13 Jan 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XinaAmOW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00311240225;
	Mon, 13 Jan 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783888; cv=none; b=jM+GaBA2lPsnYfjMbirhWMz7NEBR/Ky0Iuhdh7f1AWO2q+g2lhITCB52UuR9FAgDjjDvcKdwbTwpLm827PF5C7nbzZoJLHlN7ZW6xtZ+0YJmoP0Snv3vjXLJ4URMmJxkjbsVp3wMEbAzZ1XJ8jPb9jqA52PsY8siPM/44DJHrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783888; c=relaxed/simple;
	bh=MKe5Vcmrj+OaSQbXPRuSg8aPYH/9NRqmLinRthrAPJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GRl7qezKniS7Z31aOIeUinOeYKnH5gjqxLuhmuyk0midM6EDwtORzuMj/9BoR66y2ETn5sAnQ+LDToz/ib4jekNEm+X4YovYLA6I6O769OoiSLT+D7i0BTIilkcBZdp50EbagZl/WA7fGqrPdBtaMKkMQdosLEZFSOC7AL7BUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XinaAmOW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43626213fffso33679335e9.1;
        Mon, 13 Jan 2025 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736783885; x=1737388685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IHI7GQVzCFXQpjSpwxXeXecJJsMzkabPzUh0UusATzY=;
        b=XinaAmOWhF9yt4g+aNy0BCpEUMcdl3xaEnkOkCIx1te6h2oDZhogVRZiEFZG+67Bb+
         cE1egb+kXZWw3Huy7R41tixeAvKuUMTNG+AkGCSVcm0Y60X19oMz7JHMqaD8zbg+sWiF
         MqPIJJ4srXUYwxV4tHj8PwHePVe2K6io8+JUqICJ0SnXedFbgWAERuCvqwolIB1g9V6h
         viTk09oQj5PXri8/1MN6L3jN4G1vMntMMrpIynu8XmD4YepdTOV1YlFUQzp0Fuhovdas
         1pWyIWvIiwyAgSWn2JIqmJFU6TCB/LZOsl4CG8X2WNBPltJd3UbfajEgq9ON+yduAaou
         CqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736783885; x=1737388685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHI7GQVzCFXQpjSpwxXeXecJJsMzkabPzUh0UusATzY=;
        b=Ha6ptqZ+tyE+z7s45lNdC3brKe+qZjSLpbqkspMu2pmIT+/dLYKVBX8Gsdfq/XSWAn
         W/pfGGthTOLObmqR/h3H5octDIBny5QH+J/QZ2cxxQBxqJmo8dY1Cm5O5IalP5232csh
         7OJ0D/M2lB3X5GTjSVowtaNUeaNzZpbcDp6/WRothvAVdDeDh/uAn76GxG4IGpyniwg0
         rZ5N5tBKlz0NJQPgDZpQ8xmIbXwa57jMKKp4hQ6J7CUItHpKcLUGC+l4z9Tg7kxDY3ol
         k5bD8YBP7ZrbMBma53R5YwUx0FDEA9Nhi8MkTHCjjkSWZZR0m5vwMHF/zSyl1jQJ2Unx
         Ws9A==
X-Forwarded-Encrypted: i=1; AJvYcCXFmTi3adOW773Qry2wkU5n7kovJfWaZeYy9sKwex5BhZbd1633qGe45T/bnXOyYtcOyPsA3ZCIdh0=@vger.kernel.org, AJvYcCXu2ref508fZWtHeIOEvs+V8jjgL4j98bj8fHyz9bbOc984D8lQ0AJn1OcsS8ZCnfSUQVWZPKpMnoKnNFfA@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmaLIosUQ1bgDjQqUS8b/5EWlERzIGSjEgFe6c8O+zpteg/WC
	KMSq61rMfg2TSLALbqA6pQ8JclXE12BDOczNaSLW/MoXP0JUoVTBhsdpT0UIypo=
X-Gm-Gg: ASbGnctFZHiKwLFBQhd2KifzJa1oXYLa9eonBb8W4M3blPGR2OiUkF6gWWnI3+YkMdZ
	S31GHk8BIeYxST74zJPeGW8pPAkdqnM2tqi60hhgZ9ZeNxtXbS5qn+k2yxKNCG0Y/zKysy8cbRi
	KDIlr3cjnLYx6fcWw3cRrk6+5zG2gOHBlBmTTUuK3Bsj2b9LoW0bTTifcaxo8AHZqn4fO/+e94h
	8A7cfbD241+h9wgc28S0RmgVRatjmq67XZwZEqDODwznA7fNPegAbTX7caECKr59eGRqwr22CWk
	ahjjIRWGGPDe8vxvStedN+zrcI8Q
X-Google-Smtp-Source: AGHT+IFWgpib8LNbZJtEBsiHZExfM3cIGmkqNRbnzEdQkyxzyTLe07x92m57qKrO2Hc4tukh0Xxvzw==
X-Received: by 2002:a05:600c:3ba5:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-436e884a59amr154076735e9.15.1736783883582;
        Mon, 13 Jan 2025 07:58:03 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e62126sm146580285e9.34.2025.01.13.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 07:58:03 -0800 (PST)
Message-ID: <f7bc1af8824b99c1f82d386b71bf238928402743.camel@gmail.com>
Subject: Re: [PATCH v3 2/9] iio: dac: ad3552r-hs: clear reset status flag
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Jan 2025 15:58:02 +0000
In-Reply-To: <20250112150404.6ffb7160@jic23-huawei>
References: 
	<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
		<20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-2-ab42aef0d840@baylibre.com>
	 <20250112150404.6ffb7160@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-12 at 15:04 +0000, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 11:24:14 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > From: Angelo Dureghello <adureghello@baylibre.com>
> >=20
> > Clear reset status flag, to keep error status register
> > clean after reset (ad3552r manual, rev B table 38).
> >=20
> > Reset error flag was left to 1, so debugging registers, the
> > "Error Status Register" was dirty (0x01). It is important
> > to clear this bit, so if there is any reset event over normal
> > working mode, it is possible to detect it.
> >=20
> > Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver=
")
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Ah. I should have checked for newer versions. Anyhow, picked up v2 of pat=
ches
> 1 and 2.

Oh just saw this now. Anyways, just gave my tag for patch 1. If you can sti=
ll
take it, feel free to do so. Same for this one:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

>=20
> > ---
> > =C2=A0drivers/iio/dac/ad3552r-hs.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.=
c
> > index 216c634f3eaf..8974df625670 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_stat=
e
> > *st)
> > =C2=A0		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read
> > 0x%x\n",
> > =C2=A0			 AD3552R_ID, id);
> > =C2=A0
> > +	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> > +	ret =3D st->data->bus_reg_write(st->back,
> > AD3552R_REG_ADDR_ERR_STATUS,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_MASK_RESET_STATUS, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > =C2=A0	ret =3D st->data->bus_reg_write(st->back,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_REG_ADDR_SH_REFERENCE_=
CONFIG,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0, 1);
> >=20
>=20


