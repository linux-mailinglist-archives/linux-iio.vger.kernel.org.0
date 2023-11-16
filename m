Return-Path: <linux-iio+bounces-133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEFC7EEA1D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Nov 2023 00:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280D11F23E88
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CDF328DD;
	Thu, 16 Nov 2023 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqFWOQPB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D034DB2;
	Thu, 16 Nov 2023 15:52:48 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c34e87b571so1309653b3a.3;
        Thu, 16 Nov 2023 15:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178768; x=1700783568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LzysLjM+LIXnETesayBiVgite5S0U72GSb7DSX3O/pE=;
        b=mqFWOQPBMxMP8PQe74mH65auVlJiAhDIXlwixgz8EVv7c5wC6Y8Ed11GjgdtsGuaV9
         WpJOiUM4VAnWvMlO+TQa+DwBF01tW8h1jRBDzRcW0PUHXXvKxZ0mdENpYSV5cZ7wbOAj
         arits7l8Mq+G2S+xGqLXjAIZBkzXFYNqWdJ47KTfuu+ORcVhWW3dEu4RIFZNUjRyXT+a
         x3n7kkRfbI+H6ny1taeL4QoqIT4OIja1rMHn5hsU+/fbjDbRMNl/JCbntJmT2SZ6F0av
         jouLmNezM7AFdJKpTrRAemSOWJnNcsH0doVT5hV0kuzaRJGUn2ErIAoYK6T7HeXH2kVb
         oirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178768; x=1700783568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzysLjM+LIXnETesayBiVgite5S0U72GSb7DSX3O/pE=;
        b=UAvltgU0r/tkIBht1nqQIgaX+DtmuZ3KYnbMX7GhpIZpqYGKEYrHQSIerwfADNmDUd
         GGwZTOi8siHVNfvYXoCJVmEDzSOg8aVrF2SlR1/x58XzpEdv8wkORF9cAVAgrQWZrys5
         62hFEb5Z2EdmjB8QT8QQNWG124Gnsy/u36bMu64CZtJNZqA1YVxVzWrR4wCPfMgZv7jR
         MTMHlxxu4Cb605G+avC/EnyIAB4M/7ltAYNjPkHRMS3cdsXlTN2eBsQl3+CQTeICkB4g
         H96kqKsAendG6sWKWLL169fyuNtnrX93WMHFT1jfHH5NhxWK48NPwN7MQUKjApBG/qNZ
         XqLw==
X-Gm-Message-State: AOJu0YyW9tOa9HpgHRY4E2hCZFQKa4Fnak5hHSNe1f1pB/17jtQRNeCy
	9DB8I6w9aJcLrd7DaretaGQ=
X-Google-Smtp-Source: AGHT+IHdAwNOGFxm19bcelArpqxBhqpgQypXx/KuMwpuR6MYoqIoMohpEHa8+egi7z7pjXfQSVRDHg==
X-Received: by 2002:a05:6a00:4c8d:b0:690:2ad9:1436 with SMTP id eb13-20020a056a004c8d00b006902ad91436mr15858170pfb.7.1700178768224;
        Thu, 16 Nov 2023 15:52:48 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h16-20020aa786d0000000b006be0b0fc83asm284260pfo.125.2023.11.16.15.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 15:52:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1EE661020711A; Fri, 17 Nov 2023 06:52:44 +0700 (WIB)
Date: Fri, 17 Nov 2023 06:52:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Cixi Geng <cixi.geng@linux.dev>, apw@canonical.com, joe@perches.co,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org, rdunlap@infradead.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Industrial I/O <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
Message-ID: <ZVarTLiczTZ8oCBg@archie.me>
References: <20231116153904.15589-1-cixi.geng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WECtEa2afrZPQzPc"
Content-Disposition: inline
In-Reply-To: <20231116153904.15589-1-cixi.geng@linux.dev>


--WECtEa2afrZPQzPc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 11:39:04PM +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
>=20
> The has_help only counted the  situation which the patch file add
> a help line, when the config was renamed and  modify description,
> the has_help is zero for the "help" line not added.
>=20
> here is one case:
>     the modify file: drivers/iio/adc/Kconfig  line(1047)
>=20
>     -config SC27XX_ADC
>     +config SPRD_ADC
>      	tristate "Spreadtrum SC27xx series PMICs ADC"
>      	depends on MFD_SC27XX_PMIC || COMPILE_TEST
>     +	depends on ARCH_SPRD
>      	help
>     -	  Say yes here to build support for the integrated ADC inside the
>     -	  Spreadtrum SC27xx series PMICs.
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Spreadtrum SC27xx and UMPxx series PMICs.
>=20
>      	  This driver can also be built as a module. If so, the module
>      	  will be called sc27xx_adc.
>=20
> the checkpatch result:
>     WARNING: please write a help paragraph that fully describes the confi=
g symbol
>     #23: FILE: drivers/iio/adc/Kconfig:1050:
>     +config SPRD_ADC
>     +	tristate "Spreadtrum's ADC PMICs driver"
>      	depends on MFD_SC27XX_PMIC || COMPILE_TEST
>     +	depends on ARCH_SPRD
>      	help
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Spreadtrum SC27xx and UMPxx series PMICs.
>=20
>      	  This driver can also be built as a module. If so, the module
>      	  will be called sc27xx_adc.
>=20
>     total: 0 errors, 1 warnings, 17 lines checked

This confuses me. What are you trying to achieve there?

Confused...


--=20
An old man doll... just what I always wanted! - Clara

--WECtEa2afrZPQzPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVarSQAKCRD2uYlJVVFO
owpbAQCulE+2pEgjWKU8EjjX2SAhkLeiL1IkPHM7FxSTnpSCdQEAhdDuPPpxLuDi
KWdIjUerZKIWCj6q2MfUMjKW1va5vAM=
=dxR0
-----END PGP SIGNATURE-----

--WECtEa2afrZPQzPc--

