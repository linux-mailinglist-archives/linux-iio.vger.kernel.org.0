Return-Path: <linux-iio+bounces-22660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B3B2478D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A091671DD
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE472F5322;
	Wed, 13 Aug 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFvYouYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A32F4A06;
	Wed, 13 Aug 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081619; cv=none; b=XrEmsaRNje0TNj64qQZklRWb3GiE9zs2b4hlgJ2EFclRcSnKE8z26oCHyi527ivaCUG0ShFPXzoNuV9yZFIEEzq+FnKJtpMLhgCBfBDXwoad0Trxh0nbHHILfS3JOf+umE113sUxf6IHWd0cl/xuypTxr81rCBSW/gJCIG3pA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081619; c=relaxed/simple;
	bh=a2/+XUw6sPl+XPOLRlq6hTjtJxajNbrxlrTBU7hrFCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewGZfEpuSrJ4u/CdGaRvnbyUomvwNFSxP6Y0rlUz6/Yj4VNmfugflQZJyDkEt2uahMRmxOAmXLuof1Ul4G/Y+Rs4BVuKKJof9LlR2M5E/C1Nb843z27+dase2SoW0afKtSZRpgcTrzyjfIFhPERxmr2BxCDuH3YMhW12Eq0N8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFvYouYh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afca41c7d7fso127713466b.1;
        Wed, 13 Aug 2025 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755081616; x=1755686416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXRuzuPTAu44/S+qhx4vyAGUh6p20f8GQhKvY00aZ6U=;
        b=EFvYouYhWGOL4cXp4saSeRt1ocIjoOBJsJGR0zrQTffKknfD05o3VOK3dDkqmjuw6b
         sFuvRudK+37EF/vkWrofvtezMo3hSIwfOqHfMBYHdkk98veF3fG5UQDL3ahUQadLMe2A
         gXrdAFfujUUN1BKNVg+QKuLYdSNgSKj5E5FtXmi58+AuprZG3tZbayYSoj6sTtDhnJJU
         YnGpnXFiuSptScCyvwIhdxWgQxM605UXiZEGN9ZC9ckMMdPJMZNOE3UPURO70Ak2iFDn
         T89ezTJXcZ0x+PyRMaojQWMbuM3xRqPuOfPiIsGVYZ7fLOnnalDhLwMFWFrfJTiT46qb
         jorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081616; x=1755686416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXRuzuPTAu44/S+qhx4vyAGUh6p20f8GQhKvY00aZ6U=;
        b=NdQl45ZsjW8PmAAT00WRVlq13hjXrGg1KxJ7FLgdZ149CWWE7Fo27qWVRINzssVZM2
         zJ5geBFJT8taOc+xjTaJ/Hm673H7MyIqEAjocCfj8AbR8vOf7EsR9bSO4zaVFODgt90t
         rzOE65EFzHa2MOf0Y628EMm4NxXDV6D5FQtPSw88EG+sLhR1+Skcc9Dvc5itfCri+jrR
         EmrQEJFrZqpR2WihgN7tvlzHM5q5h5aQOihTUuuFAQiyTASK4RFQppRFYwrYUJt2Nq/I
         R+mosTE8BbSgIb9ZsWvoWp2JAlE82YIXwwju723qPd6d2lxaz+J6of3+TuJM2zWmOG9O
         aADQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/soe1dzmeKWNFwd8q+4+L4s2wWCVAVa7ZlcJU41SRRuaJ7ijcbcd8mjZh7BCXlv3cIVW6y6FK06Dc@vger.kernel.org, AJvYcCXeWlldkXv1aQaBHBZCbLJVJTjH1u0qY5hSuKEBsVLbsmUinkXticTYXKNrJPDUJEuBzuUnhZlhtEy5Vr7Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkyzim8iSEf3X3XXztxyJR4jmUUACop42BNhXXEcOlJd6VvIMf
	SnsDub8hiAaUwnGi6cc+rta23kRwosPf6msRW0RbDYDeJt2qxIhAAWHzUTtd/F7PUFtbT0o/G7g
	bCr71j0JLWunFYiFkKuwPgkMSNCZBDs4=
X-Gm-Gg: ASbGncvB6vbU5alOnEnz1FYcOvIZerzAGQoX2JYdp0Er9C9W4J/nGoeGflua16U/3Qy
	eV6H4Bq39dxoRHCITgt+HY6ob3xqlKmSUvjKU3EowbpELu7bmlkOSN9pQYdLlGkVjM82BJ22nTp
	YxbNScEQsQT2KSosE6fH6NH2Qj53oC79dmMgIp/SHB8xSykIDWcgWrKYGhbeyMuCa5gR/H6LeeG
	VLWeNQutQ==
X-Google-Smtp-Source: AGHT+IFawQdMTg1Ga+laAHlqcMD+t/ZzOcPIumWu9k471WVXMnMvstE+OmtlK2yPr1JRNDy4TCQTR/nbOpaHihz6D4s=
X-Received: by 2002:a17:907:8686:b0:af9:6c38:c4ff with SMTP id
 a640c23a62f3a-afca848936fmr184373166b.19.1755081615942; Wed, 13 Aug 2025
 03:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754617360.git.Jonathan.Santos@analog.com> <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
In-Reply-To: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:39:39 +0200
X-Gm-Features: Ac12FXwhj16nUfxwoUxJ5iFnfnh13iXw6q2vj1AMo0fdjB_fLELu0L5NNU5R5J8
Message-ID: <CAHp75VdA7hQ41Kf1yEYfnCdNbdhg0BAz0CNsQ5em+hmTwq=jag@mail.gmail.com>
Subject: Re: [PATCH 3/4] iio: adc: ad7768-1: use devm_regulator_get_enable_read_voltage
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 4:49=E2=80=AFAM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:
>
> Use devm_regulator_get_enable_read_voltage function as a standard and

..._voltage()

(Note the parentheses)

> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.

...

>  struct ad7768_state {

>         struct spi_device *spi;
>         struct regmap *regmap;
>         struct regmap *regmap24;
> -       struct regulator *vref;
> +       int vref_uv;
>         struct regulator_dev *vcm_rdev;
>         unsigned int vcm_output_sel;
>         struct clk *mclk;

>  };

Does `pahole` agree with your arrangement?

--=20
With Best Regards,
Andy Shevchenko

