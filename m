Return-Path: <linux-iio+bounces-26196-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55710C57FA3
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 94F7B3508D7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7C72C21D4;
	Thu, 13 Nov 2025 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0tIzY4O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AD281532
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044746; cv=none; b=OqkIC7G72Ink+fnPEX7YDggXyl2xx+EbM9ixPGyj9paV38Tl0SpmJgZyNEVSvz95HmKlCJecUaoJe8LysWYJ62BTHS1dvNTABvbcQ+CTI+lvp/kw32+b9MS6Bb1/P/Vj2HYKkLpYQmokcyUcu4gcrgH5cWE2/Vch8bQssIScJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044746; c=relaxed/simple;
	bh=2LHPChggk8GI1AbJ9hxVs2N8lvv8FEag0/iJX2XlCyg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJx35YTmWDaNgilAxa/96nNILkVr1fkmPxMqWtQx6Arr4GZnUxtrhY8WGcA7j9hznbHUzueZL+b2+a5uAfF9+puX06F/uTcUPl8wc3j8LGiZbtCxh+Bu2vEev9N4Ncp8FNsUm17tjtfIpl9MZ6k2TaJhMGRq+l/pIt/QZqqvWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0tIzY4O; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso631765f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763044743; x=1763649543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yLNZpnuIgcxTHHM90SiKN3q2bg/DZbAhXAi/tX9Vd+M=;
        b=m0tIzY4Oe8UWhnn1bXL04Pekw9imDwMp42cApWiDCS6gnXJtK0Ml0/1r6SUu6kAiXq
         Qc7wt6sCpSYmlIZVq5MuKzCk2D1UYJm0N0mYenc0QTUCG2cA/Bfhrdn5s3KFgi5SHlug
         UiElXMsit0b+ZPPke909411aG0/Ewn74DyUtQD8MHfF1PRRDsJZCDbRKG/672r8EVX70
         TJczAmOms8fH2Ip/hl1eeyKFAVm2moHgjdgAcBL7naA7mjypPX3ShqWobp7jPjtYKzMh
         y32sH5wG8YuOotZq/wewn5ZebWwJgQHOpkuV8bhaK+Vd9qbZJGk040WKJJhKX2cH9Tsi
         f1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044743; x=1763649543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLNZpnuIgcxTHHM90SiKN3q2bg/DZbAhXAi/tX9Vd+M=;
        b=JqIysFlpZZ7J+nVjuCtuyo7ZnHhaBZZDA16zhJrRSzxQ8CMhp4SyfH8RzEas75LTyn
         4rhevK+M3Y9nN+clhAGDUTZoUDhyn9p6Qj5HPBYqWkmPTGvya5DducTn5x6BOVJNNXsu
         Vq4fw92aw8EhRo1ZUxrS2Bo65SYJU8jpnANdOf6KwFdmOGt25GlS5ube4Fj0uuEQyteE
         cqmKytFVigQLwKYAF8BLj8/sBZfx5OgH+MFJSTJ17QYeNLtawaraX6B6fvDLmt2dPwVF
         8GpC4MFb44Eu62l+9R8wn9+LoumyzEInlY10eD3mHbODlx72qw8a0kje7a0vU0KjxcDi
         zcqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBqkotsqeJrH2xth+J8FaY2lO3zTgRIzoQRsQww/Eo2z6QkEAUO4d1Zx4jSWvUPWpKP3JvFac7vjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU94iy107mJDZ4ePpw6OS3F0dGZr30Kd+suZzzVrAZWM71x83q
	NWa2PiYvQForccX4N71cG3zlpNdv8KOR4h542Y/7rmKLVWVWf/wOonpm
X-Gm-Gg: ASbGncuwQNsAu4pHKm6xdTxdvlIcNkftDWmKW3+KcrJQ8B17qxOfEJhK5iH2eGPt8mL
	BtuN0nn+KBQnCE7zcX4w0RPNoGclitcl1LGDzTfv4TrewO4PSXhtGMSdNmlKhQb0srY5JyduZYe
	e9X4IPGeQAFX8QNAAYfjthbA8Z4XZAHzLj8h2kqE+NI5/xrvaqsCFtA9uKT/f2MD6LLwvbjm6bw
	5W7jcawS13126hpr1Hy27dFc0tFS9Vh9k1EN10lan6BRe+Fz6eeqiYrwMF55mRaS3SlamskSsDH
	Ww+hYUIXOAatvCOR79KeVLdosNDlFq4JH5NOUfvWvh3lJxECzwL40v4FpgvxvDwJBs+PZphFuRL
	TKmJWSgpMbpkEJV96SW2BlUpdH+Znr0UlBcarV6aWKF5PN/Q+I2gcBbK9xERt+DPfMvQ7Z0eE5r
	KaT16nnVjTOk35+5ssMUI=
X-Google-Smtp-Source: AGHT+IGIviz4e5mBL+hQkKKgV2FMlGbrVkUKtfusirhRvbQGt5YWOHprvcfZ8tZZlkWJ7qjlICzlBw==
X-Received: by 2002:a05:6000:2509:b0:42b:3ab7:b8a4 with SMTP id ffacd0b85a97d-42b4bdb0343mr6423452f8f.33.1763044742810;
        Thu, 13 Nov 2025 06:39:02 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b589sm4197053f8f.23.2025.11.13.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:39:02 -0800 (PST)
Message-ID: <cbe4f6071952e0055f4df400b56fd283a1294115.camel@gmail.com>
Subject: Re: [PATCH 1/3] iio: frequency: adf41513: driver implementation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko	
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Date: Thu, 13 Nov 2025 14:39:39 +0000
In-Reply-To: <aRXZlMsPjIGWJ_oc@debian-BULLSEYE-live-builder-AMD64>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
	 <20251110-adf41513-iio-driver-v1-1-2df8be0fdc6e@analog.com>
	 <aRXZlMsPjIGWJ_oc@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 10:13 -0300, Marcelo Schmitt wrote:
> Hi Rodrigo,
>=20
> A couple of comments inline since this is on the mailing list.
> As mentioned in the other thread, we ought to continue the review of this=
 internally.
>=20
> On 11/10, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > - ADF41513: 1 GHz to 26.5 GHz frequency range
> > - ADF41510: 1 GHz to 10 GHz frequency range
> > - Integer-N and fractional-N operation modes
> > - Ultra-low phase noise (-235 dBc/Hz integer-N, -231 dBc/Hz fractional-=
N)
> > - High maximum PFD frequency (250 MHz integer-N, 125 MHz fractional-N)
> > - 25-bit fixed modulus or 49-bit variable modulus fractional modes
> > - Programmable charge pump currents with 16x range
> > - Digital lock detect functionality
> > - Phase resync capability for consistent output phase
> > - Clock framework integration for system clock generation
> >=20
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> ...
> > +
> > +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> > +{
> > +	u64 uhz =3D 0;
> > +	int f_count =3D ADF41513_HZ_DECIMAL_PRECISION;
> > +	bool frac_part =3D false;
> > +
> > +	if (str[0] =3D=3D '+')
> > +		str++;
> > +
> > +	while (*str && f_count > 0) {
> > +		if ('0' <=3D *str && *str <=3D '9') {
> > +			uhz =3D uhz * 10 + *str - '0';
> > +			if (frac_part)
> > +				f_count--;
> > +		} else if (*str =3D=3D '\n') {
> > +			if (*(str + 1) =3D=3D '\0')
> > +				break;
> > +			return -EINVAL;
> > +		} else if (*str =3D=3D '.' && !frac_part) {
> > +			frac_part =3D true;
> > +		} else {
> > +			return -EINVAL;
> > +		}
> > +		str++;
> > +	}
> > +
> > +	for (; f_count > 0; f_count--)
> > +		uhz *=3D 10;
> > +
> > +	*freq_uhz =3D uhz;
> > +
> > +	return 0;
> > +}
> didn't check the details, but can't the sub-Hz resolution be supported wi=
th
> .write_raw_get_fmt()?
> e.g.
>=20
> static int adf41513_write_raw_get_fmt(struct iio_dev *indio_dev,
> 				=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, long mask)
> {
> 	switch (mask) {
> 	case IIO_CHAN_INFO_FREQUENCY:
> 		return IIO_VAL_INT_64;
> 	default:
> 		return IIO_VAL_INT_PLUS_MICRO;

I think the above is already the default anyways... But the key here is tha=
t (I think) the goal
is to be able to do things like:

echo integer.fractional > out_altvoltage0_frequency

where integer can be u64. If I'm not missing anything, we cannot do that th=
rough the standard
interfaces.

- Nuno S=C3=A1

> 	}
> }
>=20
> static const struct iio_info adf41513_info =3D {
> ...
> 	.write_raw_get_fmt =3D adf41513_write_raw_get_fmt(),
> };
>=20
> ...
> > +
> > +static ssize_t adf41513_write(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uintptr_t private,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *buf, size_t len)
> > +{
> > +	struct adf41513_state *st =3D iio_priv(indio_dev);
> > +	unsigned long long readin;
> > +	unsigned long tmp;
> > +	u64 freq_uhz;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch ((u32)private) {
> > +	case ADF41513_FREQ:
> > +		ret =3D adf41513_parse_uhz(buf, &freq_uhz);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D adf41513_set_frequency(st, freq_uhz, ADF41513_SYNC_DIFF);
> > +		break;
> > +	case ADF41513_FREQ_REFIN:
> > +		ret =3D kstrtoull(buf, 10, &readin);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (readin < ADF41513_MIN_REF_FREQ || readin > ADF41513_MAX_REF_FREQ=
) {
> Can, alternatively, this check be made with in_range() macro?
> If so, then
> #include <linux/minmax.h>
>=20
> Same question/suggestion to other similar value bounds checks throughout =
the driver.
>=20
> > +			ret =3D -EINVAL;
> > +			break;
> > +		}
> > +
>=20
> With best regards,
> Marcelo

