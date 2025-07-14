Return-Path: <linux-iio+bounces-21638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F216FB03D48
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B6A3B6818
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jul 2025 11:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33DE24679B;
	Mon, 14 Jul 2025 11:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or0BSdYV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B71E47A8;
	Mon, 14 Jul 2025 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492225; cv=none; b=gmVQUkiMZ05DYIBvREWD1RKrB6PtJdmzvm4S5+DcKDUA0e5BohKOCMoqWNsIiM5Qcq/YVnXT12ewCe2bMobphCEAJeED6ZhaYUZuYZOx8y+WqzkEJoz3m6sgIqETGCHjqxYzy/aUGcddHrG7muTRtA2iHsHVKzf+OPCp7+UYjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492225; c=relaxed/simple;
	bh=m3E70ApMJxywn92yP6/ojE3gOo2Vb63rGmxyh3SG3lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oneY7VETAyHRDIeDhJDgu9/0Sbr5zIS8qI48OgxYDuFFUi1z+izqwcHBQxGwk6TC7wLPl2rMxF+08j+1vyru2VzF46kWI5/DY9g6IdSSK+HtDPIIRx2LRvdpJesvCJqj00TX1DFfZFvKWuMF2mjJagR3v8gWreiMxT3xs9JPWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Or0BSdYV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45526dec171so29017015e9.2;
        Mon, 14 Jul 2025 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752492222; x=1753097022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZtasMFa0JRNmoRbnP05IbZgeIoacI2y5DYrNOA36/OE=;
        b=Or0BSdYV8PcSA9SkjhPOJouwdVElUVHEpSIQuLtjlzz/7SElzKm4PF0MsMWZK6w9vE
         ts3TF5b9i+1ksJnQZ4h9NyTjdALBlHTTCWSlFwHFjRwesAE79xNk1ZWm6nBSr7fJZGLY
         dqI2gJ346x5/HalzJn/6mKIyihtP/j7OKEOQGzCByjBO4r1VjFPFX2K5wYMkJ9T9nVX7
         EulSgg6eK74ZbK//oPvu4HAdjZG9A+qiWvk7djjJRpmmXZIoibK+4FqXqpY+TF2RgRfi
         Ozo8cEZOiYGRe/G9gXST5NIdXwzwwjwQHEqX+uJOoVWSvsGEGmxwS/va/zTbyx7/m7wz
         JdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752492222; x=1753097022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZtasMFa0JRNmoRbnP05IbZgeIoacI2y5DYrNOA36/OE=;
        b=nMMMWJIOorvgQ9SV8fn7ZXinkrxx2uNEZTFP5ejwAwY70B+lpbVhpgk6Oz1NWhPL5A
         K3O0ioFVOfpg05+oFkULEEArvJZwPymRT+N8Ug22ItWaaGMZokDwp1fj7mEbvZgA4vVu
         6hXu0a9ZWokMWml9BCVLSSXDiATVed14FImiKX8zQPqlRUTLBxs5XPuWJOwRgwJdlbi9
         XXplj5CLlRma5mm0A3TZ7EuCiV8BxDJKsgYWKbhX00TJ6Dgwbrt/3oq+7UPRX7KtY18u
         fpjWoLt0K9r8VPegWousV7HojAsPsIwCHT3UGcawctQwgqytRVw86hHpS3rtDJLQAHbr
         g69w==
X-Forwarded-Encrypted: i=1; AJvYcCUMnui/g3U4L+QNMfK35wZuZtxYAHfE+87D0ZDN5JLMfSgbRgZpD6jCcAb56A43xV7L6ivzBJN2DcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLayQX2KH/HJPQKJ344OG2FY8Z/CTpn3rY259Ef9urQ52OgRY
	MPIs+pVLEkyw1nnQfTBaSWj+hgHboUVtBtqrw3NAK0fgoo7wZkhmRjKB
X-Gm-Gg: ASbGnct9LsbjN0B2SQ7wt4TDf3UOKvgGRAHVwN50Z6WO8/7p3dLPBDbmj+bgKPkBWlw
	9Q8XMrMTGbspIl8R7K8izMJocOcL57w/vzat8jbUVvc+73YJYmM88f/qhSrYgAPZNoBneuv6w+Y
	sKVcCkvdDMFc0iFNUyhZ2X9iUU8/8W8jSs8G5BgWBECZ59jiPeKUCt8PMnxfTfFRyXIDTr4GHOh
	nThvpy8VErdodOg3hsOEjf0BW77CuJUgzdMwjf9BsS93Q+vBol1fl6X+L1/r1jqXHTJ3qAutji0
	2xKEstnRVkV+73IV+cgS7+WTqSzaEL8V10NHz4+3FvhJkOQ4Dgrw3Wm5+wAnfLCI6CdAeFw4fod
	jj9AAv3DcrQEaXr3zsZ1+bZJhmznh7g==
X-Google-Smtp-Source: AGHT+IFn8boaaSSg/ljEPLJH57JxYDicIgWuG7EKgxtplBHnbXMEt3BRc1Ogf7H6HI9rSZdy4g8/zQ==
X-Received: by 2002:a05:6000:4025:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3b5f2db1723mr9680632f8f.9.1752492221386;
        Mon, 14 Jul 2025 04:23:41 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4560be645a9sm68611225e9.40.2025.07.14.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:23:41 -0700 (PDT)
Message-ID: <d6364e8cf280acd7d4cce0c084ea3325bb2b7fde.camel@gmail.com>
Subject: Re: [PATCH] iio: ABI: fix correctness of I and Q modifiers
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>,  Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Date: Mon, 14 Jul 2025 12:23:54 +0100
In-Reply-To: <20250711-iio-abi-fix-i-and-q-modifiers-v1-1-35963c9c8c01@baylibre.com>
References: 
	<20250711-iio-abi-fix-i-and-q-modifiers-v1-1-35963c9c8c01@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-11 at 15:44 -0500, David Lechner wrote:
> Update the IIO ABI documentation to reflect the actual usage of channels
> with I and Q modifiers. These are currently only used in a few drivers:
>=20
> frequency/admv1013 (kernel v5.17):
> - in_altvoltageY-altvoltageZ_i_calibphase
> - in_altvoltageY-altvoltageZ_q_calibphase
> - in_altvoltageY_i_calibbias
> - in_altvoltageY_q_calibbias
> frequency/admv1014 (kernel v5.18):
> - in_altvoltageY_i_phase
> - in_altvoltageY_q_phase
> - in_altvoltageY_i_offset
> - in_altvoltageY_q_offset
> - in_altvoltageY_i_calibscale_course
> - in_altvoltageY_i_calibscale_fine
> - in_altvoltageY_q_calibscale_course
> - in_altvoltageY_q_calibscale_fine
> frequency/adrf6780 (kernel v5.16):
> - out_altvoltageY_i_phase
> - out_altvoltageY_q_phase
>=20
> There are no _raw or _scale attributes in use, so those are all removed.
> There are no currentY attributes in use with these modifiers, so those
> are also removed. All of the voltageY are changed to altvoltageY since
> that is how they are actually used. None of these channels are used
> with scan buffers, so all of those attributes are removed as well. And
> the {in,out}_altvoltageY_{i,q}_phase attributes were missing so those
> are added.
>=20
> The differential channel names for admv1013 are fixed.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

LGTM

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Note: the admv1013 calibscale_{course,fine} attributes are already
> documented in a device-specific file as they should be since we don't
> want to make those standard attributes.
> ---
> =C2=A0Documentation/ABI/obsolete/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 -------
> =C2=A0Documentation/ABI/testing/sysfs-bus-iio=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 38 ++++-----------------
> -
> =C2=A0.../ABI/testing/sysfs-bus-iio-frequency-admv1013=C2=A0=C2=A0 |=C2=
=A0 4 +--
> =C2=A03 files changed, 8 insertions(+), 46 deletions(-)
>=20
> diff --git a/Documentation/ABI/obsolete/sysfs-bus-iio
> b/Documentation/ABI/obsolete/sysfs-bus-iio
> index
> b64394b0b374f2479bab69218f6ad17c6ac651f2..a13523561958b7faf85ac42d965f78b=
99993
> ffda 100644
> --- a/Documentation/ABI/obsolete/sysfs-bus-iio
> +++ b/Documentation/ABI/obsolete/sysfs-bus-iio
> @@ -48,10 +48,6 @@
> What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY-voltageZ_en
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_en
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_en
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_en
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_incli_x_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_incli_y_en
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_en
> @@ -73,10 +69,6 @@
> What:		/sys/.../iio:deviceX/scan_elements/in_incli_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltage_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_type
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_type
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_type
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_type
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_timestamp_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressureY_type
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_pressure_type
> @@ -110,10 +102,6 @@ Description:
> =C2=A0
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_index
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_supply_index
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_i_index
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltageY_q_index
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_i_index
> -What:		/sys/.../iio:deviceX/scan_elements/in_voltage_q_index
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_x_index
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_y_index
> =C2=A0What:		/sys/.../iio:deviceX/scan_elements/in_accel_z_index
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> b/Documentation/ABI/testing/sysfs-bus-iio
> index
> fcc40d211ddf388ad70f489177ba2fcebdb9f8dc..7e31b8cd49b32ea5b58bd99afc2e810=
5314d
> 7a39 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -141,8 +141,6 @@ Description:
> =C2=A0
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_raw
> =C2=A0KernelVersion:	2.6.35
> =C2=A0Contact:	linux-iio@vger.kernel.org
> =C2=A0Description:
> @@ -417,18 +415,14 @@
> What:		/sys/bus/iio/devices/iio:deviceX/in_accel_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_q_offset
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_i_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_offset
> -What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_temp_offset
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_offset
> @@ -456,21 +450,15 @@ Description:
> =C2=A0		to the _raw output.
> =C2=A0
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage-voltage_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_scale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_current_i_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_current_q_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_scale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_accel_peak_scale
> @@ -603,11 +591,7 @@
> What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
> -What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibsca=
l
> e
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibscale
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibscale
> @@ -829,7 +813,11 @@ Description:
> =C2=A0		all the other channels, since it involves changing the VCO
> =C2=A0		fundamental output frequency.
> =C2=A0
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_phase
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_phase
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_i_phase
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_q_phase
> =C2=A0KernelVersion:	3.4.0
> =C2=A0Contact:	linux-iio@vger.kernel.org
> =C2=A0Description:
> @@ -1458,10 +1446,6 @@
> What:		/sys/.../iio:deviceX/bufferY/in_timestamp_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY-voltageZ_en
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_en
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_en
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_en
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_incli_x_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_incli_y_en
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressureY_en
> @@ -1482,10 +1466,6 @@
> What:		/sys/.../iio:deviceX/bufferY/in_incli_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltage_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_type
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_type
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_type
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_type
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_timestamp_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressureY_type
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_pressure_type
> @@ -1523,10 +1503,6 @@ Description:
> =C2=A0
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_index
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_voltageY_supply_index
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_i_index
> -What:		/sys/.../iio:deviceX/bufferY/in_voltageY_q_index
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_i_index
> -What:		/sys/.../iio:deviceX/bufferY/in_voltage_q_index
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_x_index
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_y_index
> =C2=A0What:		/sys/.../iio:deviceX/bufferY/in_accel_z_index
> @@ -1716,8 +1692,6 @@ Description:
> =C2=A0
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_raw
> =C2=A0What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_supply_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_i_raw
> -What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_q_raw
> =C2=A0KernelVersion:	3.17
> =C2=A0Contact:	linux-iio@vger.kernel.org
> =C2=A0Description:
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> index
> de1e323e5d4741177e58a8c4058fa00271ea3b29..9cf8cd0dd2dfd5b0b67b5dbf28bbdb6=
bb4a4
> ce7f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
> @@ -1,10 +1,10 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> 1_i_calibphase
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> altvoltage1_i_calibphase
> =C2=A0KernelVersion:
> =C2=A0Contact:	linux-iio@vger.kernel.org
> =C2=A0Description:
> =C2=A0		Read/write unscaled value for the Local Oscillatior path
> quadrature I phase shift.
> =C2=A0
> -What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> 1_q_calibphase
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-
> altvoltage1_q_calibphase
> =C2=A0KernelVersion:
> =C2=A0Contact:	linux-iio@vger.kernel.org
> =C2=A0Description:
>=20
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250711-iio-abi-fix-i-and-q-modifiers-b1e46ddd8d67
>=20
> Best regards,

