Return-Path: <linux-iio+bounces-14266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB69A0B38A
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 10:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BACB1881A8E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812911FDA68;
	Mon, 13 Jan 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xneq+C3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93362235BE1;
	Mon, 13 Jan 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736761703; cv=none; b=eUhg4ME5NZ2p6om/0Tba36MhikR8NySnCoUjc+3XO5IxrobGj1YByELHBP1BP7eqiYDIYWoR0c2jLc0FJpUduVEktb5VBr3dRwd3V4OKAQwzI3qjEtfZ/mft5qsOMWlBuDCJFdok1d8duqUVrQjCrg38vq6+7DL/LGc2XGcXaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736761703; c=relaxed/simple;
	bh=K1BDBCF50o+cf6oIS2bDIVzget03lGHDrSxQPLcWEWo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EadJYJuYqFbS+Sc+7tqNZY6Gl280ARvt2vWqeNSqOY0eFe4iNNQVZx9WwuEoFfAVWc+/jhRXOOY5KuVPAMqC4lNKZ+hqZX3sHmclG0zFvafHF9A8sJCYM5vziETceR9w82crRqsf6LlVjD/eOT9NfpnIdH+jvSNvJtqkOvwKXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xneq+C3T; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385e27c75f4so2861116f8f.2;
        Mon, 13 Jan 2025 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736761700; x=1737366500; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fy5J9GnPTErNI4yJwKHrFSmYyUl9mPrEtPLLIWCLOlo=;
        b=Xneq+C3T9sQPjL3lY/ZsNv3qD4F2JyjyAvxE2LimBOAn7YOEz0wolbvXtsAhkQT/ZI
         5qNNkTcA3RYIAIsvZB4w9POStn/27HFemyqFWUZH1jQayikTc14fV9CUllx3HI1csutX
         rW+u1t4xTovMR+O3oW0IUHSTlShCr1zXr1gG2hcyy/iSYBy9z9vidXKIDrnKkOQyU1Ko
         dqckowXAv5Xn8uFPw/3iLIjhOxnMP0CdqTzbZpP7yk8x/y95V5FshKjLcp5mWBg2wQ2n
         I9dheTw5+yNZ5ftj2TS+s2kmWgmg7/Ap6hiVbq6EglVXBMo8mYPqBaWdBtL+FTx7VQJ8
         XRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736761700; x=1737366500;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fy5J9GnPTErNI4yJwKHrFSmYyUl9mPrEtPLLIWCLOlo=;
        b=mvlXIQhZzPZp6QRLIzHelczrNtvhIzQAd0VKp8FjWhigknYdJFwov9WzZ/gTdn2K/P
         0YY30mZqMjmWMQGCTJB2G6ijVvjMjMfA+tmiguZ4azVMt6/OP1z0ag3OGvErN6BJEpup
         i/Fjwpl0bBr+vsgwaF6TwSe0o/aowcaZo9Qbb+DFzROVnVeimjVflIVL2GYGCDpXTwuw
         +Uu6AlvFTY/l2oMjq5Lu7gvLTR2Pt7NJLXSx+i+CBZS4/EqrGHKNhFGepe7DqrcccrUy
         ZaASUuOWYN+jfIibRKKLnhXirsroKCEda5bHxnQsSm1GcxPnpsgZXDpYk4fgcMIGiPfj
         65Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU+ftGehHqM9mWxuiHHEs5BiOaUZePKix5RAoJkWYD+5cTXX/EFja3yG/sprRL+vCsmzNgB0FUnnlMA@vger.kernel.org, AJvYcCX2Uvbd1ZlL6ZRLEcKwmwiTnsT+SY1XDR4HDLHtd8dDPAmQ4Pj2DA893B/6QmUqhRn3TqWBVnFvBC9hiSe8@vger.kernel.org, AJvYcCXDAySVNgmuxD7BYZACGlDSQV+a+F0CK9Sf9nkbqmLlLBNvz9jDzfmPhQObivNIK3tkk0DmlGIRvhW2@vger.kernel.org, AJvYcCXnB4oExAtUwMQZbIrwFvkgQyCfT2F3Ez+CpsT6vzLqMF/YHamGIxouBAFFVBj9LFKAndE4nme/Y/Lr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Wpom8uSpjSvA5bHTDwFtA42cA1ovVP1Dwpd43ss1ceADIkmC
	IWw6BZ9AKAIV1SB34xcor4f+ZA+YTknX9w6FvKlkJ2IK5y7s/1ov
X-Gm-Gg: ASbGncvKYPrLyEp8VQe6HIwUsZegfDYhzTL9eskAqU7+pwwtUw8R1hIY2tI8AIKCs+7
	G38m1/1pIqgR50iUYUbcojQYecZeMGtPefmt/dVQxI+vqqfvhEJ1d9B6cY/uoed7b1ez2A3czlE
	bX981NGcL59DKe79DaHrgUX+D7wiZh762QUTcZoyY1qN+t8++yZljMyjAZ3RK+8XhcjckJzyZAX
	erpq062jSsQOCotp6ldnFDQkIbYYtOLvE2kkCMGlaVuXFbdZDS+/3TUL9m0HRHM4ChDpkf17zCT
	X/Fe6USDrnWNBK/LQHOYMs1zj7EC
X-Google-Smtp-Source: AGHT+IFGu8xgHnqA3SbOcsPF1QRNB0WruVSNr3NRE+jXFVca/FLalIOi+c3lwexlaOqMBBn1B/F3+w==
X-Received: by 2002:a05:6000:186b:b0:388:da2a:12fa with SMTP id ffacd0b85a97d-38a8733badamr15583169f8f.52.1736761699522;
        Mon, 13 Jan 2025 01:48:19 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92a50sm170561255e9.36.2025.01.13.01.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:48:19 -0800 (PST)
Message-ID: <604cf5b9c5f2efef4618b9e99bd8d8bf24f999a1.camel@gmail.com>
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Robert Budai
 <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano	
 <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 13 Jan 2025 09:48:18 +0000
In-Reply-To: <20250112161141.563064c2@jic23-huawei>
References: <20250110074254.38966-1-robert.budai@analog.com>
		<20250110074254.38966-6-robert.budai@analog.com>
	 <20250112161141.563064c2@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-12 at 16:11 +0000, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 09:42:53 +0200
> Robert Budai <robert.budai@analog.com> wrote:
>=20
> > The ADIS16550 is a complete inertial system that includes a triaxis
> > gyroscope and a triaxis accelerometer. Each inertial sensor in
> > the ADIS16550 combines industry leading MEMS only technology
> > with signal conditioning that optimizes dynamic performance. The
> > factory calibration characterizes each sensor for sensitivity, bias,
> > and alignment. As a result, each sensor has its own dynamic com-
> > pensation formulas that provide accurate sensor measurements
> >=20
> > Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > ---
> >=20
> > 4:
> > - reorganized channels to match the order in the datasheet
> > - removed extra checks and goto statements
> > - for buffer memory allocation used only kfree, since adis library alre=
ady
> > takes care of freeing the buffer
>=20
> That last bit makes for a mess wrt to who owns the buffer and lifetime
> management. Suggestions inline.
>=20
> Jonathan
>=20
> > diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> > new file mode 100644
> > index 000000000000..49c3ff9ef1e2
> > --- /dev/null
> > +++ b/drivers/iio/imu/adis16550.c
> > @@ -0,0 +1,1202 @@
> ...
>=20
>=20
> > +static int adis16550_set_accl_filter_freq(struct adis16550 *st, int
> > freq_hz)
> > +{
> > +	bool en =3D false;
> > +
> > +	if (freq_hz)
> > +		en =3D true;
> > +
> > +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> > +				=C2=A0 ADIS16550_ACCL_FIR_EN_MASK,
> > +				=C2=A0
> > (u32)FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en));
>=20
> Why is the cast needed? Only bit 3 is set.

Typically this is needed for the cases where we want to write in 2 byte
registers and we want to make sure sizeof(val) (on the macro evaluation) gi=
ves
us the proper size. But yes, for this case as we want 4 bytes, it should no=
t be
needed. Hmm but I think we might get 'unsigned long' from FIELD_PREP() sinc=
e
mask is also of that type?

- Nuno S=C3=A1=20



