Return-Path: <linux-iio+bounces-18997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AAEAA756E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C72466E96
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A4F18DB22;
	Fri,  2 May 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmWG5CLd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF62DC77E;
	Fri,  2 May 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746198028; cv=none; b=Isc3Bvv1FFl6aKESZhrKpr5AyBDYC9M94NPSBDMARATlXIb/fjmbxTKkoYaZ7DsVfQfD0h8NzwdTEdB3NvbfCoVB/6hyGDt3xwyaKXy09yM7XnZEs/DSJJf3UL7E5WexBUs12KTCdvvKGA0zTIVj6ehIexsU/mgrOIojhR83I+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746198028; c=relaxed/simple;
	bh=fTcihm8F3AR9dLNLHu3BBcP7PrSwWeJrBnxCABPKK0g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ajlxpIs90D10FG2vD5fbr9g8MbrRmh8tMQ1LuzekZgm2hFqvqVHVPa4A/7EyPp7I6IpwPGSNcCyhnuYJOb9vrNKduv7VMpdc+Aau6twM9ZX40x9fz8+ogWMoaufKdvZJxMVpIss4Mv/1pdO/Y0J8nEWjd19OrzInhyHzkokrs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmWG5CLd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so18494835e9.3;
        Fri, 02 May 2025 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746198025; x=1746802825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wirILAuxHEuuts1x0hrZv7b//qjDz030JZ7th3dBWqw=;
        b=HmWG5CLdAGSbzz1VX9NPnB84kik0JIy5RGDuc3Wq/qi0QPOo/wwoPvJIQxGnZMsGLY
         IqRchXn7NpPOQO0QBmquCxdTQ5X5fmmEEMe9SnUItarSqc8b3ZmI9gCcjiwmrFEzcEAG
         mP6XGToJQ3UT1R6WHvBVUSmIPovCa8BBAfAtBaUQi8AHSDbEFAphpClkyEoMyGxkzUjo
         XDtGdDzTJdkP6YJPooYV3BYqqOmGSmNESSIOHqbb2+UCUrx0EXIygNa/Xq1OEmPclJBJ
         qHXGG5bb0OfuDnaR2LFMfLSQTFYElLJsWk6/EhIg4IjAXOK0a9Ads8VF2WJFZZwcXnG9
         iNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746198025; x=1746802825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wirILAuxHEuuts1x0hrZv7b//qjDz030JZ7th3dBWqw=;
        b=s4b2ailgSgGAr+lZv6ZKNwVqzBYKvxnuQP/cEeGNHvAVSzaU4v9PImGJ8jjQo8U46m
         dveTZ+dmvNHCPZ6KoJcZrVZ4847+c9ZEDZgoB9A7nVSoLzusB8doY8hSTgKRShufg3kH
         6kxyUvAxL5UR+ze/MLnbz9nRl9eK8QfFxWk580tuXczaaFDWc7fSFYlSwGwYsEhPywKE
         ejopuOaqwbekwYNlPQy3qX12QW4tk1eIns1VS4YmBQSvKJYDoRKkwzevmGNdQmjrvjCi
         sbzcaM1cbQIDBEeq5Ok9PET9UZEt7pjrNaC3p4rvBrRxMwCzRDaOpEawqFRWp15Q07jd
         z8cw==
X-Forwarded-Encrypted: i=1; AJvYcCXaSK5cjpXFkOMVnNKBUBoDr42Nm91HoFN3MPJbBR8eTo/0nbU9Ygwet8C15cD+9fWAZ6LJ9NjC7J0=@vger.kernel.org, AJvYcCXaZ/h3do35nsIEq0zGv8NNYE4tHswprg8lAugwMVVO1iz1L7qRd9if49eKld0oIUDRSxlz4ZKma8dCS/7p@vger.kernel.org
X-Gm-Message-State: AOJu0YzuxrnxIMhKWI/plrMWr5i6tITSF8GuaKmO2MGgBB2CPiFv1aCN
	AiynCL1RXr+z58krhViusAwsassG7+48kTd/Tsu5fs+Sjo5NWWF5
X-Gm-Gg: ASbGncvMYBdU1Lq3W/UToY8XZRZtr2MSFUDNYxXhSzMlkACyFPXRWP+6iRsy7eGhDC0
	vLg7IdSOS+h80fNXOeQXPaoIhtN9Zrmse8Bej6CyzgeOtFNW/85759itciccnXFtGq+ekiczkeb
	TfeeV3RIOVwqMSRYfvT8AxUaRIPaR4Rvc8me/piUSrFa9hlBwsthfo9xKCyeghCVHFSevOCjKsr
	tHG/IGeLWNWtj8aeB+jJ6K+5PNbeZZgO5LJXt4KR22U8gaWoSHrk9+Siu+NFHfu1r5+ggp/2Y23
	TTgRcSSPnDE8sDWdJ4KZhO4A+w+OCXKh703jpgDzLLwYuEXfjRRErtTWlYa/0obk749+TKVmd29
	72+yV+/U09meW
X-Google-Smtp-Source: AGHT+IFFWpEh7slZXKySMUTy1NRvBOFAP63y8zNRrlI6Z2VKIitUe0DjpU0kM0b82krGnYabfsODsg==
X-Received: by 2002:a05:600c:4fc9:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-441bbed9ec1mr35278645e9.15.1746198025097;
        Fri, 02 May 2025 08:00:25 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad78f6sm93817095e9.2.2025.05.02.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:00:24 -0700 (PDT)
Message-ID: <00988dab7a90671d637466e4261d7b2248f172b6.camel@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add maintainers for ad4851 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 02 May 2025 16:00:28 +0100
In-Reply-To: <20250502100016.26279-1-antoniu.miclaus@analog.com>
References: <20250502100016.26279-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 13:00 +0300, Antoniu Miclaus wrote:
> Add the ad4851 entry in the MAINTAINERS file.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0MAINTAINERS | 10 ++++++++++
> =C2=A01 file changed, 10 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a0089db6670..d5a985ae62bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1350,6 +1350,16 @@ F:	Documentation/iio/ad4695.rst
> =C2=A0F:	drivers/iio/adc/ad4695.c
> =C2=A0F:	include/dt-bindings/iio/adc/adi,ad4695.h
> =C2=A0
> +ANALOG DEVICES INC AD4851 DRIVER
> +M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +M:	Dragos Bogdan <dragos.bogdan@analog.com>
> +R:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
> +F:	drivers/iio/adc/ad4851.c
> +
> =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> =C2=A0M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> =C2=A0L:	linux-iio@vger.kernel.org

