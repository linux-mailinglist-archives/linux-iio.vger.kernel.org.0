Return-Path: <linux-iio+bounces-15873-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 353C1A3DD69
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5326E189EBC0
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168AB1D54C2;
	Thu, 20 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVRROzhR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED81C6F70;
	Thu, 20 Feb 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063233; cv=none; b=aoIfninOekHnIcD6Xm5otD3Oy3i1Kw16Xz4mu2oM6ZnklG2wUPs9T+cQNP3hkgNw/gnep6r6wGgqEDzbkn/NKGizDPOUlkaW62crdcPIeeXWoBljKN0t0shIyj8BDYUUB9es8Hnb/GtXFIkuhsnwsEJTu8uzkJFejIxWzxjE2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063233; c=relaxed/simple;
	bh=4/pMzWx/e525LbJKFbze/lMI08yLnwEFOH20ty6Rm0w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVk3a61PsJpOELhRmyrJuQ8R1U3mA8eK6TuByXCqg78AuKK+jvfw3+iH4jI71zm7uLgguXeVtoM491JeL4qWRsjxMM/+UBGdy9RTNd2CBjZh34Rs3O7TlkuCpbg0+qZ5Cign32H5Q1hmeyTXhcIj0TX1iu43BzBMrUcfipiMy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVRROzhR; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-439350f1a0bso6713775e9.0;
        Thu, 20 Feb 2025 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740063230; x=1740668030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnF7DjHtaQEH3B1zrO6KsyD/Yfh+zOQ+dj+D2Kr1dck=;
        b=YVRROzhRoCfdxYE8WAsBXBt/gjUOBTqeUKK235EgrHpHJ70SArMYKvACVAOM5QyzRr
         IPJXsqoaAFtGA/MAggTFB+zqFAggFT6czuZuKutWRw7/VHrUTp+QBQNwN/X+EOr7WebA
         hvgRsocIKBn+vatNsUcVEHMrr0vuP3KnJA7sciL2i28iZeb8SbrTv1z+zLtBAPSQKA7l
         ttTAfGKSAmQTIED/7gzQj7wF5ym0oioUut99cj5QB38dL7pbA1XM4PfA3Xqv+j3l1eOs
         DgUoDsMlSYb4HrjJgdiO86PYERSgI5hlb9P07EjDisSBryrOby5r5pi4o/ZWyDbDq3nL
         2EsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740063230; x=1740668030;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnF7DjHtaQEH3B1zrO6KsyD/Yfh+zOQ+dj+D2Kr1dck=;
        b=RMY5/T5pMs0FoBtnWcQqLo8WEfCZI7DPS+bGOLEALINCKIzLztTyuQJGQpRRmsvO82
         y5279f1/vmqH2GwFzphoe6y6dCXT7gzHSPtFgeFTuB8LoJ9GB/Sh7sp9GmURntse5oRS
         X91NVyA6TR0Q3djKbcyAfgyxt1/Ux+u8L2ev2wXsFRK+HvpU1LTOYGMADnxpG8A2TrXJ
         l3V3cqdLKKoFXRVeAYQTpO6UuGKJcqjeak2sIC1SqBQfzbqvdDWISNImiBV6sZ/MqKCw
         Aku90S0/i1kaFnBig5ev6ygzvVknM5P2FBiLJTYYAV9T1nV1kr3rNNie2hp+KEfttoia
         6EWw==
X-Forwarded-Encrypted: i=1; AJvYcCUXfWWSqxeQYZgziwIFz2jRJCNp73e53EqEnNdYm33IVJ+EmdbGM77hVSunU55I2j4wM037Xh5qm7LxfZFy@vger.kernel.org, AJvYcCXSdAlmDCpgbFOlUGNXwZbYiRRLXbKDz5q9orsk1qqkYiI5U+yoa2N9ahcrnZyp0HcC4jGacBD8SP3u@vger.kernel.org, AJvYcCXZ5b1r2gAsAhC2/mWVVduGyJRui+rHor96PqPfR6H3GjTzxvF8xLSqqMCGkfd3bZeQVMBY2NziMH2D@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0snVuqwknPblpOCpoAqwhOEAYGjbj1lbEXxOtbG/AbhFTWPZa
	PJsTkSvE/+/2XG4lKoLjYsAYIbuSNg+38OKEtZ5kMBD7dIZXsfLm
X-Gm-Gg: ASbGncvINCUal/nq6HKAYJ7yEV1rIr+dioaJPFVoHX9huWVI4nfDi0XOkAV2A3Xt0W1
	pxsCpvxI5TGPgYqI2IqUid8DpLIHHZ2NVn1LTPCF7xXYH5bL77bGHM95SMFxBRRCcdiYJ1XQXf5
	/emFKMq5Pq7AGeCV98D/hxUhh0jLxPr2+Dn3fHiK/OnxFyeJQ5krGAmcTxmgnk88RqyIBPpv4ni
	6uC/ANMBJWy91o8eubObwgw4oYy24KzllTj3rDudaCdzZJfJ9YO/etKCEObt6JBCnhPyUHAzkxo
	Uyd/0CZ56FaeoC5EZvburBbZfZR0kU7TV8/qZgtb5XH2h8eFzzx0q33oRGRATjU=
X-Google-Smtp-Source: AGHT+IGzcQv6D79Z/HRxMUtj/i5EFZORo6aaJ85Q2wB0UdtwW9sqZZhHpWNotMoI9P55Xbeqiq29YQ==
X-Received: by 2002:a05:600c:1d08:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-439a30d38f4mr32497155e9.13.1740063229620;
        Thu, 20 Feb 2025 06:53:49 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f208sm242976455e9.6.2025.02.20.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:53:49 -0800 (PST)
Message-ID: <8f588f4b88d122815df694660d19672e8ccd3d70.camel@gmail.com>
Subject: Re: [PATCH 14/14] Documentation: ABI: testing: ad4080 docs
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2025 14:53:52 +0000
In-Reply-To: <20250220135429.8615-15-antoniu.miclaus@analog.com>
References: <20250220135429.8615-1-antoniu.miclaus@analog.com>
	 <20250220135429.8615-15-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 15:54 +0200, Antoniu Miclaus wrote:
> Add documentation for the ad4080 attributes.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> =C2=A0.../ABI/testing/sysfs-bus-iio-adc-ad4080=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 55 +++++++++++++++++++
> =C2=A01 file changed, 55 insertions(+)
> =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad40=
80
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> new file mode 100644
> index 000000000000..e37bfba0e989
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4080
> @@ -0,0 +1,55 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/lvds_sync
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute handles the data synchronization
> process.Because the CNV
> +		signal is not taken into account by the FPGA when capturing
> the data, we
> +		need a process that configures the ADC to output pattern
> data, writes the
> +		SYNC bit in the axi_adc register map, waits until the custom
> HDL syncs the
> +		data correctly, and then changes the output mode to analog
> data instead of
> +		the fixed pattern.

I'll comment this one in the driver. I have some questions on how this work=
s...

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/lvds_lvds
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Configures the signal type of the CNV signal. The value can
> be either CMOS
> +		(lvds_cnv=3D0) or LVDS (lvds_cnv=3D1).

The name seems to be wrong with what you have implemented. From this
description, I would think of this as a DT property? Can the signal type re=
ally
change at runtime?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_sel
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute enables the digital filter functionality of
> the AD4080.In
> +		order to capture data correctly, the function must configure
> the ADC
> +		through SPI to select the filter type and enable data capture
> in filter
> +		mode through axi_adc(In this mode, data is gated by a signal
> generated by
> +		the AD4080 (GPIO1 and is not continuous as it is when the
> filter is
> +		disabled).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_sel_available
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Return the available filter modes that can be set.

There's a standard attr for this. I think we settled=20
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter=E2=80=99s decimation rate.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/sinc_dec_rate_available
> +Date:		February 2025
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Return the available filter's decimation rates.
> +
> +

I'm not yet convinced we need the dec_rate custom attr. I'll add more comme=
nts
in the driver.

- Nuno S=C3=A1


