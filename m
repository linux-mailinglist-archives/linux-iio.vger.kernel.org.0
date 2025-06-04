Return-Path: <linux-iio+bounces-20197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A17ACD65F
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 05:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7C41887FD3
	for <lists+linux-iio@lfdr.de>; Wed,  4 Jun 2025 03:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF7A149C55;
	Wed,  4 Jun 2025 03:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi16QUQd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4331DA21
	for <linux-iio@vger.kernel.org>; Wed,  4 Jun 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749006949; cv=none; b=jDcYOXwBlYnF9mmohPkUy5tYKy5ZtqRyij5XLFn4Ywtecs3q+d5BkiAGtiKoOLEjGA3Ny9MDECTKEhiyYbbG4hN+cQUePJWMES6bq4ixFQ9xf3ZoK+rb+efoE1jtnYXFLygMTmU36ve0d4vSltSe4qVnk0LFBWCpVvjCvk1S8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749006949; c=relaxed/simple;
	bh=nxdi9SS9GcCqSFClYS6tPEVu1Gestqk4QZ9AkxUgaT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ek01x2ELFaTGkbQ8o31/HI8y1ztFFfp9iOaJLQtYB4NzB96EHOh5SXn9xMPbBlpjUgKuTtzVGDEY6kMat/W55kp5hkkh91NTl01UF6uLh88hRJGEN5RJrrd3rzu2ZWS20JEtB2ha89rJYPYOKI9DdDCU26+VYvTcmh8lZshhGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi16QUQd; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86fbb48fc7fso1281948241.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Jun 2025 20:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749006947; x=1749611747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckhLPjjQIv1cWpVEzsVSuVCC3Z7VHeWtCm5VPy+tsRQ=;
        b=Fi16QUQdDXufr3KgX5e+uXZFiSmifNQ8g0mYPst5qyk/D7Lx8V7xIIXDvVnvrPS1sS
         2XvYVIzR9Pfxkb0Cmbkq/B9vGs/RJTmxVlfgTDboY7QlXay6af/FXBS00iKrHELfuBzi
         sRW3dL5iPBFPyddL8bKfIJERHLZPNjPEebbX2BqgkV0GyywMTOQZel1VVesFo9TlmIMS
         6Eg5xc02q99qCiChh8pqxWOPFa4xvGK135jWmomDQxOSyLFPjrihPyUxkPMSQ0DjRSVd
         DqHmCZAlCZTPDmsfAka5R78lGyeUaukBd9Vhxdz2Qoc9j6l5dnVG08HMJBx5Ip/8WxhC
         i64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749006947; x=1749611747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckhLPjjQIv1cWpVEzsVSuVCC3Z7VHeWtCm5VPy+tsRQ=;
        b=icasbPHzrKIEcQn7zPhyGFURqkgb6cI7CFpuiFZLEY/5i4dqnIKvoioN7xAF7ZQALh
         iF7hamda0A9z2Zoy7v2xnGDyEtCLgUm96h5VB4q2cIWMD00glbWEGkD/8XxgWGjpOxKV
         B9WLZVGKmP5jL8CiNOUe4u/zxP2AzsLtCLZdluG5fdgo/QUMgyPUSy622xFkaGP3yhxm
         RuHI3zXmn7d5PE5BeVLnMs5IwRR2G/xlQojJaqUm3os6CN3mX+krW92yKdzoC3mmrClZ
         IyOmuKSXKWDjm0yI40Vd4tGa9WI7B8dxu5OyjsVcURu/bQECHr4ieO6TawbULfZzdWzb
         p0rg==
X-Forwarded-Encrypted: i=1; AJvYcCW9LRkDuXCdwMSqLPmHlh4mTDJ19lNBLqSb0xGs3nQcsLeWKDI+xzqVu3CneX66r1zWiZ1bf6xC6ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONk3Y8fVwGY8eA0HIgp2cL64tmnlWIn+2myRY8HNepeJ/z2JN
	clC3hi+Ag33m8XYPwofyyF/n30jcy9hbeOA/QMz4uZiznaFivuDUHchJ
X-Gm-Gg: ASbGncuiGeA/Hd8BI8ubLK8lZH8Q2fcVmIaXSnjOyOIQhAq1jw0O6Ge7yy2cuiL4Nzr
	B2R+u5Bda1MRnfWXaDYJUgqh/3vf8XA0RHPupkdHXnw7KYAr/s3lqL91JS/orzyNZmULUx6rJYJ
	PHcB4ULGovgPAcxZ3FzvPu1xwX48cyHnusywauMvSoS0tC55GocOD17pzDiwoKCaniV2ywqJXcm
	LQCmnSSLXCs4r8XR/iQNZCABSDA4tV/dBjLz8XZfeyanVY2+TJCcRwJ4oyPoabN5nwaAGgufyO9
	ZASuvwoX5DEiCntIXOLe4iXLdtbwtXp4Zi8/VCQYY0/j1Db1e2RyCZ34HnhGEyxoUTqWvQ==
X-Google-Smtp-Source: AGHT+IF5skkCshx6zE2ZYRg9szW4CPvpJqbgvB2kW5BV6JJLSzlye54FRjJaJVaqg59BersdOcPU3A==
X-Received: by 2002:a05:6102:3a08:b0:4df:8259:eaa with SMTP id ada2fe7eead31-4e746ce2a15mr653911137.5.1749006946749;
        Tue, 03 Jun 2025 20:15:46 -0700 (PDT)
Received: from localhost ([2804:30c:406b:9100:2a26:16f5:c81:e61f])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-4e64e9bf7basm9510064137.24.2025.06.03.20.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 20:15:46 -0700 (PDT)
Date: Wed, 4 Jun 2025 00:17:23 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Bianca <biancalvao@gmail.com>
Cc: jic23@kernel.org, juliacalixtorosa@usp.br,
	Bianca Costa =?iso-8859-1?Q?Galv=E3o?= <biancagalvao@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: mmc35240: unify reg-access
 predicates
Message-ID: <aD-6w2Mto5OK187U@debian-BULLSEYE-live-builder-AMD64>
References: <20250526120340.16880-1-biancalvao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526120340.16880-1-biancalvao@gmail.com>

Hello Bianca, Júlia,

Some comments in addition to what Jonathan mentioned.
Though, unless I'm missing anything, I'd say there may be no reason for a v3.
Please, see comments below.

On 05/26, Bianca wrote:
> From: Bianca Costa Galvão <biancalvao@gmail.com>
> 
> Refactor the two complementary helper functions
> `mmc35240_is_volatile_reg()` and
> `mmc35240_is_writeable_reg()` by implementing the volatile predicate
> as the logical negation of the writeable predicate. This removes the
> duplicate bit-mask checks and makes the intent clearer.
> 
> Changes since v1:
> - Removed the obsolete mmc35240_reg_check() helper.
> - Wrapped commit message and body to 75 columns.
> - Fixed indentation in mmc35240_is_writeable_reg() to use tabs.
The change log looks good, but it should come after the "---".
As it is, the change log would appear in the commit logs if the patch is
applied, and we don't want change logs in commit descriptions.

> 
> Signed-off-by: Bianca Costa Galvão <biancagalvao@usp.br>
checkpacth also points a sender/sign-off mismatch. There should be a way
to fix that with some git format-patch or git send-email flag.

> Co-developed-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
> Signed-off-by: Júlia Calixto Rosa <juliacalixtorosa@usp.br>
> ---
This is the place where the change log is expected to be.

>  drivers/iio/magnetometer/mmc35240.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 07f58567e521..6cfb89295802 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -418,14 +418,16 @@ static const struct iio_info mmc35240_info = {
>  	.attrs		= &mmc35240_attribute_group,
>  };
>  
> -static bool mmc35240_reg_check(unsigned int reg)
Couldn't find any mmc35240_reg_check() in current IIO testing branch.
Was that leftover from out of tree commit? Am I missing anything?
Please, avoid such things. This patch just fails to apply to IIO testing.

> -{
> -	return reg == MMC35240_REG_CTRL0 || reg == MMC35240_REG_CTRL1;
> -}
>  
>  static bool mmc35240_is_writeable_reg(struct device *dev, unsigned int reg)
>  {
> -	return mmc35240_reg_check(reg);
> +	switch (reg) {
> +	case MMC35240_REG_CTRL0:
> +	case MMC35240_REG_CTRL1:
> +		return true;
> +	default:
> +    	return false;
> +	}
>  }
>  
>  static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
> @@ -447,7 +449,7 @@ static bool mmc35240_is_readable_reg(struct device *dev, unsigned int reg)
>  
>  static bool mmc35240_is_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -	return !mmc35240_reg_check(reg);
> +	return !mmc35240_is_writeable_reg(dev, reg);
I think this logic doesn't really apply to this sensor.
There is a product ID register (MMC35240_REG_ID) that seems to be read-only and
not volatile. I think this patch doesn't make much sense.

With best regards,
Marcelo

