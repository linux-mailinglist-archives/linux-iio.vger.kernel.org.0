Return-Path: <linux-iio+bounces-12925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07EC9DF9B8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 04:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F0F2817D8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 03:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513EE1F8AE9;
	Mon,  2 Dec 2024 03:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMu4JM5p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C962A1D1;
	Mon,  2 Dec 2024 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733111893; cv=none; b=a9VT/EUhszf54g9yv2LKHxSeyTGdmIL3plJ/mDYPBO3UGvw74gD9ZFLskab0udkMhmStVDUpc5ylGAwYypL5tpgutuT5EATldchb93yRn8aHeQ0cybioAGHPB5hjJ21Hd5aZGwEKL2CkgZrrhCk03twEUWtZ6umLFWi+6iNVYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733111893; c=relaxed/simple;
	bh=1WuQ9zhPdvb7aTUSsoeBXQfnvNcWDdKLXzd31oeSilY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv1RX5zLp8jrxBLhretVdXx/pHZicI22pSzvIw8kit0+ZYlxVU9PHPYrsHAAcwg4gTC/D9AMumiWK89XwnFAt1XiWecDW6NGWmo1WkUVxUFk4ZJVSVsUBXgvN4tfgIwA9w1X8jAE2JguxA3nb9Pm/BcrKCTpoG5xsMkP9ZAlWac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMu4JM5p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0cd8a0e91so2272762a12.3;
        Sun, 01 Dec 2024 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733111890; x=1733716690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WuQ9zhPdvb7aTUSsoeBXQfnvNcWDdKLXzd31oeSilY=;
        b=DMu4JM5paNbtOuxcNdTEa2HL7Br1nEwt2KPW5K3iB6O3qAxai6Gdr7LjW0qPYSVW4h
         qo3plqC5n3i6pKK72XVi9FFcfGL4Avv8XPOdu6r0DuBc5uoDQNfxsbQS3NJ1dOcuBnqs
         vFvKcyeHJyEeAzOtp6JszHV34bUoISXMzdOA1+gk00wTx5cyWa9marpm8Ivnntpo6K3r
         UY3vhKSgDDtzHcDABbbcRTGq82gGtg1M5yWTpSjJtPdVe9CFnS7OsJ3i5S0EDDLlDIHO
         YAoBFnSgGZNolNWgJJOEr/AlY0tzW+4RJK7/rxSiXdRQAIVNnB1uQ4NYbl5DbvAIKeTl
         8UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733111890; x=1733716690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WuQ9zhPdvb7aTUSsoeBXQfnvNcWDdKLXzd31oeSilY=;
        b=VQg6QcuRMWhZKpAGJtxzE0oHXgEd0uAjz8iEs0BIjoQEBSanLCLosOcKvxe0PIdKeE
         fcze+619ZXQpET1L54bi1sBMdKyPH8F6yqBkh0Gu0W6aKCw5TJbDew4+cbZGNgQWhcdm
         GdhEuE+3fgdHwULctLcnOCTaZdBx41gygDuXrvLpH7i4aP9VTedPHg9w54HysIUu5Toi
         Q3wK/LqNWtQKFd504OiKf3qtoTi7UBVCwpdYAnfRAS9AvqEhtVGDzDcgRITlGpHBHzVY
         Pf2qSbY+QsNnzToiekHp8bh8E4H0/HTXTH/cbqmDst32H+RThCagMja21t60xYsLqAQa
         +QPw==
X-Forwarded-Encrypted: i=1; AJvYcCV4qdB3SbFYMh93d2ZHmU16jeU4m95Eu5T4VkE6U9gi6IkZTSewFbzbWm1c3LLwFgEa65/PidXm/m8EsFUk@vger.kernel.org, AJvYcCVQ+LC47uC2SBToBlUabruoIoKZlq9iTSOD7CxH/V+iYshJC+pzBkrS0ousyJNzoNmSEFtdcsO2S2Yu@vger.kernel.org, AJvYcCW2BMTnNbRPpm3VBuZH5t/prhnWSSV4o2OaAzggMmJlRxmeQTrFmnHbWN0fO5p7t1nZJ77Dmahup2fN@vger.kernel.org
X-Gm-Message-State: AOJu0YytUkVJnIk4sJzoeNs13uGzDvAyMjn3TM3u4BZ+oJq6RIN0eNeS
	ugVNc9fcWNpnDnCEEd5JCOajrKW4e1N8dByTJWR9hl+1qLiXPQ0EJS+pJZbpgXXXoTZCdcZUlJY
	LDxY9HimisFQ2dPFEkaNyDc3UZfI=
X-Gm-Gg: ASbGncuXWcRCwbhsUzlYGLOPZMTHPfA5mxrXQYimFScbwoP56/F4FS924+LGlpeH1Yo
	zcEdtuNBjDIgeJXWfPt30/+znWFW+7gg=
X-Google-Smtp-Source: AGHT+IGwzEMbiiJ13Ofd5itDTOGLOFeo7dgalvpfbhUuXY2tP9DPIIZUXyvTnCRrUzAM/6rxs2ljWo1mX+WoQmAepyI=
X-Received: by 2002:a05:6402:280a:b0:5d0:cea1:931e with SMTP id
 4fb4d7f45d1cf-5d0cea19806mr7075150a12.23.1733111889614; Sun, 01 Dec 2024
 19:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-2-j2anfernee@gmail.com>
 <6c20875c-4145-4c91-b3b5-8f70ecb126f0@amperemail.onmicrosoft.com>
 <CA+4VgcJD74ar9zQCj38M2w8FzGWpq+u5Z7ip9M7a1Lu7u8rojw@mail.gmail.com>
 <20241109134228.4359d803@jic23-huawei> <20241109142943.3d960742@jic23-huawei>
 <CA+4VgcJ=8wDWWnmgEt-UkEUfnfD8kGtHe44G5+dcRYt=KdwNfw@mail.gmail.com>
 <20241123144750.43eaa1c5@jic23-huawei> <CA+4Vgc+rqnxne6saUgUO_kR6chX9+HZcb40_9dpO6p6KuskSAg@mail.gmail.com>
 <6d8e9512-2be8-4337-9791-0d956b0968c5@baylibre.com>
In-Reply-To: <6d8e9512-2be8-4337-9791-0d956b0968c5@baylibre.com>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Mon, 2 Dec 2024 11:57:33 +0800
Message-ID: <CA+4Vgc+vXQYQubVs4eFJj+WuMKEJziZh44J_pXDxrmo_DXiWpg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: Add binding for Nuvoton
 NCT720x ADCs
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, 
	avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nuno.sa@analog.com, javier.carrasco.cruz@gmail.com, andy@kernel.org, 
	marcelo.schmitt@analog.com, olivier.moysan@foss.st.com, 
	mitrutzceclan@gmail.com, matteomartelli3@gmail.com, alisadariana@gmail.com, 
	joao.goncalves@toradex.com, marius.cristea@microchip.com, 
	mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com, 
	yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear David Lechner,

Thank you your comment.

David Lechner <dlechner@baylibre.com> =E6=96=BC 2024=E5=B9=B411=E6=9C=8829=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 11/27/24 8:14 PM, Yu-Hsian Yang wrote:
> > Dear Jonathan Cameron,
> >
> > Thank you for your advice.
> >
> > I would remove the "nvuoton,read-vin-data-size" property.
> >
> > Read VIN info can use word read or byte read, and other registers
> > should use byte read.
> > If I use word read for VIN info and byte read for other registers,
> > I encounter an issue when I use regmap instead of i2c smbus API.
> >
> > I need two regmap configs with val_bits 8/16.
> > After I call devm_regmap_init_i2c these two configs,
> > the error message:
> > "debugfs: Directory '5-001d' with parent 'regmap' already present!"
> >
> > Do you have any suggestions?
> >
> Give each regmap a unique name, like "5-001d-8bit" and "5-001d-16bit".

It worked fine to add each regmap a unique name.

