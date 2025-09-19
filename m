Return-Path: <linux-iio+bounces-24284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787BB89385
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 13:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E290587FDA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Sep 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1482FB61A;
	Fri, 19 Sep 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlK6h8h8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBAD2153D2
	for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280707; cv=none; b=lM1cL5gbqUEmJaNyHBSjUlpG+RnqUN57P7DEtTcO0FdtOFbmNqF4ZzvjP+YAHmjrZPko/FhsB19nkFPH7eSGoXtEFc+3wIj6UhIex9HTQA4/qJ0hWuP2ATUvFl0qM7bBHceDkB+cKr77X0/9YYIMDB5GfUPSpUmVvuqqoe7MI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280707; c=relaxed/simple;
	bh=W8xCClpJap0tn6RAGVm/5k00Ui4PTQ/LYLqDw3mX6FQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZbUk3CeBgnFWKO6RNz+7OLEIIBD3j+FLvNjs5yRMpwQBwJ6Pn4MqkpWI0ctEDmBdUrN5x6fZ0G/OYWMrSN04HLIB523ebNOPU914JCB+qXC29z/W7hSdHMALcDQ+AQsNBazjBIoxqXhQ12mzf+AWSh/jS0RGsx7GMPCjkaxUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlK6h8h8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so17673275e9.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Sep 2025 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758280704; x=1758885504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8xCClpJap0tn6RAGVm/5k00Ui4PTQ/LYLqDw3mX6FQ=;
        b=nlK6h8h8BtS5H54Ks+EUfALtbNBSd80JaCRdi9e0jHlD+GCCAWw+QJqDnfNLbW+4Kn
         1yg/QV3wZyQRAGLfvPxX9xNrLA9iyJVBBFxWkSNfLnPqKm1C+GqRXYi7ExSdOvyAs3qz
         Df7Glyhq4isj4N77ytetm/aGM8TboR4BcImj/hkJYotqBzdFvhrGdk0hO5reRbKpHro8
         ml/PJqhlaHmYNeQ+rAprkTbbxjd/NPUlaEo+VosxICQJS6zOgVSghXIdl33qHV7+wT8r
         cqmcO4PQGDy7fViMDYrrsuweZ/9zD59YO5ZJ3CL4p18YmTY834S92a0hTnmswz05XaY+
         bmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758280704; x=1758885504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8xCClpJap0tn6RAGVm/5k00Ui4PTQ/LYLqDw3mX6FQ=;
        b=To2GPXHscub7a3j1YpsXR6cCicW9Y1/w69EGAC6vrZA3Fmw5B8dtfYGkDPqZv/3Mgm
         26kALJexK3PO/Gz3mwdZk58RBKPijf+G/3IZbTJBkc6TdFviU2rVHpAWTI7Hefi4TlLX
         lxIntN6WUr3pDXKhyAW/M3e7kVbPfFlvQCqbmus0LUKdIwY9b6EOk1J6StBh63ReLUhm
         y3tftfEnAHy3MIMbBX2jHkovPADSKW9JFAyg+RXPtzsDFTlM1UpmfkdsOZ+MYF4dBo2H
         KmqkJnicQNpU/UtummGFX5DrFlnsjpq1qI3kXaY+K0TU7ABPc/5BB2nYNjB4Mc0FpzzZ
         ULng==
X-Forwarded-Encrypted: i=1; AJvYcCWavfMN+bxQIj3vV9Qiyb64D8cHro6jBO/JB5k5caS9veGH7tbx7/nBxkzwzGLeTUtsV0KWNOeBO+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhNfNtZzPPgzmOzBlc9Rc/OfTpIOWnX0oW8AvkaoCeKq6iX1F
	K9XHj6YcUShSudq6cR8rNSv/1ZiVd7IAQ3FF88FwvH+oyUo146s7jjsn
X-Gm-Gg: ASbGncunGpFVutaeehpOjr3kp/2tczJFEqKWPSOSVDIchoxg/yLEeYhezGlIcYwzisP
	HCSunIaHgl/PPiA5sZS0HslnitNzlD5dsXuEARhGhPJsEfYi/tEYrrCmEd1HPlO0n1xd5r3wJmm
	wyTwGCyLZdw5cqmWVKFaup18ZChyBh9bV646XRS/93RndYSJ1U/N//E54moeTke4Iuz3nFqSseX
	r9/yV8lfgR1t38sT5HDMsuHGXgSLnatU6o3UVYE4TQVMqvurMEvDCtq7L6hQHJKYn2ecx6jJhs3
	B9WQXZw0L3m0JeUa3cQz5kxBp7H0Q3rtDp8GxFkNJeyb4+zdMee0DDFHRPVIv/niCv+QDcrutYG
	f3KvpUl+M9eOU5G9YMx6a2Mw=
X-Google-Smtp-Source: AGHT+IEm9pYsl1pYEPR3lR1UuIm1EJunr5K4Jw6ghdZWgOpFqi18ufSbDRJGoyavc1OQ+xxx1jOjNQ==
X-Received: by 2002:a05:600c:a04:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-467aba7b635mr25265685e9.15.1758280703692;
        Fri, 19 Sep 2025 04:18:23 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm1437901f8f.56.2025.09.19.04.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:18:23 -0700 (PDT)
Message-ID: <eac23482ec25fb44ed4374dcda763235ffbdd3b3.camel@gmail.com>
Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support for
 I3C interface
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>, Jorge Marques
	 <gastmaier@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko	
 <andriy.shevchenko@intel.com>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 "jic23@kernel.org"	 <jic23@kernel.org>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>,  "andy@kernel.org"	 <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>, "Pandey,
 Radhey Shyam"	 <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
 <srinivas.goud@amd.com>,  "manion05gk@gmail.com"	 <manion05gk@gmail.com>
Date: Fri, 19 Sep 2025 12:18:49 +0100
In-Reply-To: <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250721110741.2380963-1-manikanta.guntupalli@amd.com>
	 <aH4mwkh80TUTNXtS@smile.fi.intel.com>
	 <83798680-8e3f-4899-8c58-d7da5587653e@baylibre.com>
	 <DM4PR12MB61095749195041654F6D560D8C5CA@DM4PR12MB6109.namprd12.prod.outlook.com>
	 <3d7w3rczrdics77nt7lig5rsj2bmfubpwzhffarzlxmo5w2g4a@baewpltdovhk>
	 <DM4PR12MB610930805348D91ACAE876A18C25A@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-29 at 12:02 +0000, Guntupalli, Manikanta wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
> Hi @Jorge Marques,
>=20
> > -----Original Message-----
> > From: Jorge Marques <gastmaier@gmail.com>
> > Sent: Tuesday, July 22, 2025 1:27 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: David Lechner <dlechner@baylibre.com>; Andy Shevchenko
> > <andriy.shevchenko@intel.com>; git (AMD-Xilinx) <git@amd.com>; Simek, M=
ichal
> > <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
> > manion05gk@gmail.com
> > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback support f=
or
> > I3C
> > interface
> >=20
> > On Tue, Jul 22, 2025 at 07:32:54AM +0000, Guntupalli, Manikanta wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >=20
> > > Hi @David Lechner,
> > >=20
> > > > -----Original Message-----
> > > > From: David Lechner <dlechner@baylibre.com>
> > > > Sent: Tuesday, July 22, 2025 2:31 AM
> > > > To: Andy Shevchenko <andriy.shevchenko@intel.com>; Guntupalli,
> > > > Manikanta <manikanta.guntupalli@amd.com>
> > > > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > > > <michal.simek@amd.com>; lorenzo@kernel.org; jic23@kernel.org;
> > > > nuno.sa@analog.com; andy@kernel.org; linux-iio@vger.kernel.org;
> > > > linux-kernel@vger.kernel.org; Pandey, Radhey Shyam
> > > > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > > > <srinivas.goud@amd.com>; manion05gk@gmail.com
> > > > Subject: Re: [PATCH] iio: imu: lsm6dsx: Add shutdown callback
> > > > support for I3C interface
> > > >=20
> > > > On 7/21/25 6:38 AM, Andy Shevchenko wrote:
> > > > > On Mon, Jul 21, 2025 at 04:37:41PM +0530, Manikanta Guntupalli wr=
ote:
> > > > > > Add a shutdown handler for the ST LSM6DSx I3C driver to perform=
 a
> > > > > > hardware reset during system shutdown. This ensures the sensor =
is
> > > > > > placed in a well-defined reset state, preventing issues during
> > > > > > subsequent reboots, such as kexec, where the device may fail to
> > > > > > respond correctly during enumeration.
> > > > >=20
> > > > > Do you imply that tons of device drivers missing this? I don't
> > > > > think we have even 5% of the drivers implementing the feature.
> > > > >=20
> > > > In the IIO drivers I've worked on, we always do reset in the probe(=
)
> > > > function. The
> > > > shutdown() function might not run, e.g. if the board loses power, s=
o
> > > > it doesn't fix 100% of the cases.
> > >=20
> > > Thank you for the input.
> > >=20
> > > You're absolutely right =E2=80=94 shutdown() may not cover all cases =
like power
> > > loss.
> > However, in scenarios such as a warm reboot (kexec), the situation is
> > different.
> > >=20
> > > Before the probe is called in the next boot, device enumeration takes
> > > place. During
> > this process, the I3C framework compares the device=E2=80=99s PID, BCR,=
 and DCR
> > values
> > against the ones registered in the driver:
> > >=20
> > > static const struct i3c_device_id st_lsm6dsx_i3c_ids[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I3C_DEVICE(0x0104, 0x006C,=
 (void *)ST_LSM6DSO_ID),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I3C_DEVICE(0x0104, 0x006B,=
 (void *)ST_LSM6DSR_ID),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
> > > };
> > >=20
> > > Only if this matching succeeds, the probe will be invoked.
> > >=20
> > > Since the sensor reset logic is placed inside the probe, the device m=
ust
> > > be in a
> > responsive state during enumeration. In the case of kexec, we observed =
that
> > the
> > sensor does not respond correctly unless it is explicitly reset during
> > shutdown().
> > Hence, adding the reset in shutdown() addresses this specific case wher=
e the
> > probe
> > isn't reached due to failed enumeration.
> > >=20
> > Hi Manikanta,
> >=20
> > During i3c bus init, the CCC RSTDAA is emitted to reset all DAs of all
> > devices in the
> > bus (drivers/i3c/master.c@i3c_master_bus_init -> i3c_master_rstdaa_lock=
ed).
> > Is the
> > LSM6DSX not compliant with that?
> LSM6DSX is compliant with RSTDAA CCC.
>=20
> >=20
> > I get your solution but find odd to use the same method as in the probe=
.
> > In the probe, you would, in general, reset the device logic, but leave =
the
> > i3c
> > peripheral logic intact, because you don't want to undo whatever the
> > controller has
> > set-up for the current bus attached devices (ibi config, da, max device=
s
> > speed, all the
> > good i3c stuff).
> > For this device, the st_lsm6dsx_reset_device seems to flush a FIFO, do =
a
> > software
> > reset, and reload a trimming parameter; which are necessary to solve th=
e bug
> > you
> > are observed?
> Only software reset necessary to solve the bug.
>=20
> >=20
> > If possible, please explain better why the device won't enumerate corre=
ctly
> > after a
> > reboot without the reset. If it is a device bug, explicitly state that =
and
> > that it is not
> > compliant. Also, take a look at fig.100 of the i3c spec basic 1.1.1.
> >=20
> > Thank you for looking into this, this type of corner case is usually
> > overlooked.
> It appears that the sensor device is entering a deep sleep or low-power s=
tate
> and is not responding to CCC commands. However, after a software reset, t=
he
> sensor starts responding to CCCs as expected.
>=20

It seems the device has some PM ops implemented [1]. Can it be that those a=
re
being called somehow? I don't think they should be called during shutdown b=
ut it
would at least explain the low power state.

[1]: https://elixir.bootlin.com/linux/v6.17-rc6/source/drivers/iio/imu/st_l=
sm6dsx/st_lsm6dsx_core.c#L2730

- Nuno S=C3=A1

> Shall we proceed with only the software reset changes along with an impro=
ved
> description, or do you recommend any additional modifications?
>=20
> Thanks,
> Manikanta.

