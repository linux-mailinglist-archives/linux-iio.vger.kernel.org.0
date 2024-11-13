Return-Path: <linux-iio+bounces-12222-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5039C7C95
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859931F26D17
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A8205AD0;
	Wed, 13 Nov 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKEANdlh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50F204F66;
	Wed, 13 Nov 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528396; cv=none; b=aDLmSXMgqSkpK8L+nEEZuSRyTNO5MnKrksfk1bTTrAsBD5QKU0Qp2jmLDnFVNG5BAH5sQaoSSFUxdHYKJovwFDqBA/4An2PR2lCjAEV6WBRpGYA7FKeE1qDTFe7JMO+NOhWPWAHQ2l8YU+4WmZ0VZf5k4kwU3lvlkPU2Xgkjtxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528396; c=relaxed/simple;
	bh=HQa731/ZLoyCeGQhzG0hA4Lc2hG47E76VLAEtxnlya4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGxY0Pq/QgsAPwzRvQ+0cS8rzNMNdlIck/X512mBQ9kfa6ejbaQCYI+iNyjENaXG/EbON+pzy/dsGpSCsDDj+eVDDMW0fNTQgz1HwRRa2OHnO3ObdNnscV25syH30JX9htXUVsQyveHvS7GdfGth+dD2lK4+bCLeyBII0GZeLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKEANdlh; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so1237338866b.0;
        Wed, 13 Nov 2024 12:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528393; x=1732133193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfiqwKr6r1SFdFylK6olsTY9Jg8oGIrvq97lnYAbMIA=;
        b=LKEANdlhDr/O/j8ZLq1yakZ4WzNDu3XOq9n6jZM6yeln3M+VGln3XrZcfjAUldhX8E
         RAzi+UEM0W4ZTkZcAEjr/JLA3z1v2+Oin+sG7YSUhB1Jp1s+tES004lGa0KAyOwUsRg8
         2znVCErTNSUnb6tyQSbEtJHzqQMDVv6Cd/dF5esZJxWFIPslIbJkEIvo8UhPV2DJw3GX
         wmphiZq6MJ54HIXsV7Zbkvx51cXNXS7Mf4kMJILiZiSHmez7EYBgf8eUJDcde0PoU5Mv
         LxCgnl7oozoLFHpeZwqBiTIToUBKYprW2BzpjtfaLLgd0Oc3jR8zSVBBObhunfcV4MJh
         5ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528393; x=1732133193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfiqwKr6r1SFdFylK6olsTY9Jg8oGIrvq97lnYAbMIA=;
        b=Me6mTPLkb8qi/SDSopnGcCm74tDQRihX33snf9U2yRQ7ThNj/xmDpnZti6mgRZ12AG
         dRz5Gk51u+/RmHJCc0sBpY0E3g2HCWOPbFoevf5AjDJ67A8oTTkmgdHkND2iTmdlflzB
         yY+M9aHiJ2nCV3AIdoh9yOhmxYWEFLopFxtg8N1oRAvN4yp9cLyN7H7iZCNdWaoJc/RP
         LHV4gMemxKZtDWMFFtJYfiX3wgWyXa086HNtkZGK0ZeXs8qHb78QeK5eqmJz8fHz1u+2
         pgehRkkJsP5m/pchzOy8j+gpcngVszaoNt6LXy8BN8VLIh70aow0y/ET3CPZcaLdApoI
         ifqw==
X-Forwarded-Encrypted: i=1; AJvYcCUVPYOElZ157vych6OJXRAplPXDtP5Ak0Gm0GG9zv+MZfi19njtzGbUf3Mg4HF2hNVzL5NOVjqluNIXRmZA@vger.kernel.org, AJvYcCXmRjQl/GBNQqIkvQLo/jYlP63+DPOtdBRh7+zm8Fh+QlFPgjm3S5K5urzzq9xWR8EXuRIFnv8qBxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlt38zrA2BKWxovw7QycVfZSIAq2qz1+afqolt3kS1RASiTs/
	Lk+0Rl6RetKM80se2pB0MHiDmCxi7ElA21zGi0lKmsGpCLmB05jkRQCyr05MTHIRNU6XlZZAmbX
	S8ucdXAgGV1JRRhynK6VvlRk+FiY=
X-Google-Smtp-Source: AGHT+IFxbCoWBxSdChQkoMmve7hcdaZW27H3+o4Ca5p3TintmJb2KqP5B1CnAyiClgG78ZhkxK1Irpv4qTh5ZENq+pE=
X-Received: by 2002:a17:906:d551:b0:a99:61f7:8413 with SMTP id
 a640c23a62f3a-a9eefee66femr2190969166b.23.1731528392844; Wed, 13 Nov 2024
 12:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113114654.8203-1-victor.duicu@microchip.com>
In-Reply-To: <20241113114654.8203-1-victor.duicu@microchip.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Nov 2024 22:05:55 +0200
Message-ID: <CAHp75Vcj=vX2GNQRGPfB2rGod2VrWby942tpdws4GkObba+1GQ@mail.gmail.com>
Subject: Re: [PATCH v10] iio: adc: pac1921: Add ACPI support to Microchip pac1921
To: victor.duicu@microchip.com
Cc: matteomartelli3@gmail.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marius.cristea@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 1:48=E2=80=AFPM <victor.duicu@microchip.com> wrote:
>
> From: Victor Duicu <victor.duicu@microchip.com>
>
> This patch implements ACPI support to Microchip pac1921.
> The driver can read the shunt resistor value and label from the ACPI tabl=
e.
>
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>

...

> Differences related to previous versions:
> v10:
> - fix coding style mistakes.
> - add UL to PAC1921_MAX_SHUNT_VALUE_uOHMS.
> - edit comment in pac1921_write_shunt_resistor.
> - in pac1921_probe use is_acpi_device_node instead of
>   ACPI_HANDLE.

Any explanation why my tag was not included? Haven't you addressed all
the things I pointed out? If not, care to elaborate why?

--=20
With Best Regards,
Andy Shevchenko

