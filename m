Return-Path: <linux-iio+bounces-17507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3928A77751
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD9407A2E59
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD471EC01C;
	Tue,  1 Apr 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8zJ25d5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981741EC012;
	Tue,  1 Apr 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498704; cv=none; b=QXealfnvfQKKa4PIYE0Vw6H4q7a8dBs+RA9tNRVx1/FFjXtFOJQOIwnW2uB7WzzK7HsThoEhilcNPgN5UN2qWbja8M98MAQotReQDMCPUG5RYMhVm1FnKgumhp1fC0mPbJCcoillMw2LPp5BBQ0F1YWq7HC/mT6XQQNcKfQlRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498704; c=relaxed/simple;
	bh=xlQTJTftXp4QaPEY8zN0yExT+QPdjF04bs/zJdTaPLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QMTUD2l+OY6XyhakExU5oYI5R4bhXaBW1zuozYa9zV7rdXat6rPYGdZvbNmcy2ged6NbFdGnzBxsII0FjaTuIl6nSV0XWkvwiRb1gnbqdTB6XskwIb9FzdztuTzzHJH2PdoCIVrXSOxvRktTHVtJ2zd29lFSjPrH71jJFS/pHTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8zJ25d5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso37065375e9.0;
        Tue, 01 Apr 2025 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743498701; x=1744103501; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nO/vP5TRg5ZLLMCCzxFxqGrkINJ8exJAwuc4SuL41I8=;
        b=B8zJ25d5y19LvL0KkVzE3E7OPeZDuiRRB0+dl6osHG+79wWV2/vU9xQ8ppyc7J8fod
         DHd38XoYu6+R82eFqfhYkdxIMeWh8Mw/JxIBZPHGcPDL/63drAu8gzaLKFBjUyprDGHX
         i1XsIc7JrmWhCxLM7759YEvS+Gp2kISeXP3yMOoiy8uUS6iGbGYBVj8bThhFRQB4etPy
         maSjieI4Z0W4acPW30YOAxYl9SRfz32GuR9T5KOUaqO8Sf9BBK3/EDg6PPjmeeICjAYw
         dP0HQxpgIkEZUeZrgMGSaAFqWNdI6hnFvD/cV/eX+842Q2TFvn7U9NWWiERlMRYLcfn2
         swSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743498701; x=1744103501;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nO/vP5TRg5ZLLMCCzxFxqGrkINJ8exJAwuc4SuL41I8=;
        b=cJPWhe+NQYQENv3tKVjzOU9aIrFJktDSiqXYjHxRnRdwCaa9kINScD2G3iw5iqtKGC
         pYsXupv3vOgFhQBwh/9W6oSGJSfSehTdleu0goZCqF/VsU+yhWz+Ii/c1RgjyX9VzGMb
         GVBesfDkfZoFNv9o6Tbd6WhRcpUcWjKTdddrYuzJTRdcr1Oyju/f8DPc96vrcDTLWt5f
         TpWaO+TodVLw2N9Ov+1kVfj5MMbhTgY9VSaBvOeoCs4WzjmMz9PI2h8RQCtICY1hq4yH
         uo9XQA1KJm7ojFTgTfXXykvZKjyHTbtTwFo6bg/gta5p4oWeX1tkbjU2vefbB1PadTY9
         lVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGAGH5rKwW2wzsrsGriYCzVJck3cZ3lbN5cyEXMciDs6h6j8/P4PKAteyyNhhByQja9rcrKJHVPtg=@vger.kernel.org, AJvYcCVn4efRO6reIYz846t5m3uONcUskUX0AmFUeiqJKabyI5oyP1JaryY0Ln12ooqhg8V8m9CGJPi7+2euPosB@vger.kernel.org
X-Gm-Message-State: AOJu0YwC7ikXejRVPgVckIwzkhikg1TjjzRr0VYvagCEZkbKcFoGQIVF
	NL6WStlQayOSc36Lv/5j5YUQQgB00uurzkr2g/ZiKkk0Zk8ccpc84JHMlBJ5cJc0DA==
X-Gm-Gg: ASbGncs5DIgFzotfCen2tWFFPEweUZ4ViGKL5gm3Ti78OV3cJ5A5vou3okX+i7EURq1
	vGAQLMed+uVM1sFs5oxcjj1W7swSlDlP4OmOo5lOSoPhWdFEM9fSTAb//GvbkppRsjdyXcvkS7r
	Nc2OVTRKULRHPS8riBbQPO1KipwiauELHQ9RG3JXbxfz4uwjljtLaclrRp6qsRgMScKALRgIqQc
	XqayqBTAcm70e4e7JQzHXrRlGb6IiXzfA+UMAiUn9fm7pWVFPQKtYfgDRl4NZAZ/yk7/1LtC6cK
	RexzJ/S8xaUWPN0l0J8esqcft3nBJbt31bPWKqVSSzDbP5djblfQgX4DYzVY3PQmok7Hqqc04q5
	Pme3TjMML3t/ReJ/2bHhz8POh47c=
X-Google-Smtp-Source: AGHT+IFhKUxmWPjq3mR46/dotKQ77Y0ztbkas9eS2Wuvvz1Oh2Hj4G9HZScVBvfUF9tSV8Oo9k7PlA==
X-Received: by 2002:a05:600c:3b1b:b0:43d:934:ea97 with SMTP id 5b1f17b1804b1-43db85268aemr92067665e9.27.1743498700421;
        Tue, 01 Apr 2025 02:11:40 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82a041d4sm198124305e9.0.2025.04.01.02.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:11:40 -0700 (PDT)
Message-ID: <1f6116071b20846d07406a613d77fd45e5353690.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7944: drop bits_per_word hack
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, 	linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, linux-kernel@vger.kernel.org
Date: Tue, 01 Apr 2025 10:11:40 +0100
In-Reply-To: <20250331-iio-adc-ad7944-drop-bits_per_word-hack-v1-1-2b952e033340@baylibre.com>
References: 
	<20250331-iio-adc-ad7944-drop-bits_per_word-hack-v1-1-2b952e033340@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-31 at 14:29 -0500, David Lechner wrote:
> Remove setting bits_per_word in SPI xfers without data. The shortcoming
> that this was working around was fixed in the SPI controller driver, so
> it is no longer necessary. And we don't need this to be cargo-culted to
> new drivers.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7944.c | 11 -----------
> =C2=A01 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index
> 2f949fe5587318957f2e423029294ced0a6f803d..70f313545af2393a625ae2ec3c2cff2=
e2915
> 3ffb 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -189,11 +189,6 @@ static int ad7944_3wire_cs_mode_init_msg(struct devi=
ce
> *dev, struct ad7944_adc *
> =C2=A0						=C2=A0=C2=A0 : adc->timing_spec-
> >conv_ns;
> =C2=A0	struct spi_transfer *xfers =3D adc->xfers;
> =C2=A0
> -	/*
> -	 * NB: can get better performance from some SPI controllers if we use
> -	 * the same bits_per_word in every transfer.
> -	 */
> -	xfers[0].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0	/*
> =C2=A0	 * CS is tied to CNV and we need a low to high transition to start
> the
> =C2=A0	 * conversion, so place CNV low for t_QUIET to prepare for this.
> @@ -208,7 +203,6 @@ static int ad7944_3wire_cs_mode_init_msg(struct devic=
e
> *dev, struct ad7944_adc *
> =C2=A0	xfers[1].cs_off =3D 1;
> =C2=A0	xfers[1].delay.value =3D t_conv_ns;
> =C2=A0	xfers[1].delay.unit =3D SPI_DELAY_UNIT_NSECS;
> -	xfers[1].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0
> =C2=A0	/* Then we can read the data during the acquisition phase */
> =C2=A0	xfers[2].rx_buf =3D &adc->sample.raw;
> @@ -227,11 +221,6 @@ static int ad7944_4wire_mode_init_msg(struct device =
*dev,
> struct ad7944_adc *adc
> =C2=A0						=C2=A0=C2=A0 : adc->timing_spec-
> >conv_ns;
> =C2=A0	struct spi_transfer *xfers =3D adc->xfers;
> =C2=A0
> -	/*
> -	 * NB: can get better performance from some SPI controllers if we use
> -	 * the same bits_per_word in every transfer.
> -	 */
> -	xfers[0].bits_per_word =3D chan->scan_type.realbits;
> =C2=A0	/*
> =C2=A0	 * CS has to be high for full conversion time to avoid triggering =
the
> =C2=A0	 * busy indication.
>=20
> ---
> base-commit: f8ffc92ae9052e6615896052f0c5b808bfc17520
> change-id: 20250331-iio-adc-ad7944-drop-bits_per_word-hack-a71b2d51fa3f
>=20
> Best regards,

