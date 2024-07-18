Return-Path: <linux-iio+bounces-7704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077CF934F1F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 16:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE53282BB7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030113E41A;
	Thu, 18 Jul 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldidZZrG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F913D281
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313158; cv=none; b=XDMCMbZFTxXqkssgnr5mjRa26aI80F3enZZbgJjmu8MzMGPJ0vGNmTpYsGHNhvGgRRPbr9ttGaIrZ5mZ31K0WWtl4fu29dLzttuQQN1P7+DckB5Vv/d6nMaCglOCahwIHXeqOo7w+WHd3c6ENLCfsRjDkGZ+8lV4VvN4Ee/Mzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313158; c=relaxed/simple;
	bh=PmcCoDYyfUiipvAqnGv9JCOzfAV6a1m25qJbFsiJZ6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rze9dTdawSH3RgzPvKWb22LYhdOStvIfPzej0ha3lryZrh6Q/wbppnmbiL0UWJWK+Ei33Lpj+WOQ7dSNIBK/+OhactPuMz/emhA3mPUFq/VaEfo9w2lW5KliBnFwV4uXHHpKqxrKFU6un11Gm4rNenCQ1YkSikkRKWSdb8VZMpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldidZZrG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-367940c57ddso460590f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721313155; x=1721917955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmcCoDYyfUiipvAqnGv9JCOzfAV6a1m25qJbFsiJZ6A=;
        b=ldidZZrGKj0GSeAeKiqM4znmGfbMyR1BWh3VZORZ4EByS4ezcQeb1lsfSkKOofIYAW
         NL+3U0GSqYvbr1Ug5CmKRqt66zei2kno6wFaLrHi1z5xw3wMn1+grU+BzOAfcdGa+fGr
         T6nHZ6u8WMsYPRrnXotcyx8s+ERXZ0rmYP3fuuoijmTr2NTOy0jFi9IdtF48+3+dxWi+
         UcoxIY/10Bz4QRU99tqzovO27U+lW2gAhqzpTrJN8IF0paDkUDS3+6WrfycUMLhqy3PO
         Lc2fbzdYQr67WEC0i2mIJnmTFc4pdfT4T5cDf2PFpP7O9grdq/la+oM/2XONuZcvqIXs
         H9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721313155; x=1721917955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmcCoDYyfUiipvAqnGv9JCOzfAV6a1m25qJbFsiJZ6A=;
        b=Z04ZTmJA6FduMykc7vb8BsDLCc8twI6WqC/3NwTJNGTbllTkXwF6Ah38Hcafbr4So/
         Amjch+FF61rhllGgEckg7VZnBo1Qzveh+PZMteeLfGjsHl855OYzfjK9YdOug/kEOaFG
         kzS//a0QI3iWRwp1yY0NOGyQairIiblB6oQeUf7WgCOfZyf+lcQ0SxXQe1oyLhTHil+i
         uUO8eZ0qzJqzBgaJ+nSPlUIgl+qlptL9R3LDKZ4Pifa0kmVm0BomPAHmqKNrRcSWBhc+
         KZ7OeMtvR6V6rCh6ep7DgDmJDb/Go15EB4F9kjj85quqG4WQB0o3mA07iZEYr6xtBjj4
         1lrw==
X-Gm-Message-State: AOJu0YxVnXCx/qlYu7w23R5gvEjFqJVQgSGh0vQ/dqhIvtua13+oNd93
	ecLnGnOH8INqS3fS77EUolUtsdvSijYbHkCT/jFx9XZM1cSg9JY6
X-Google-Smtp-Source: AGHT+IE3Z9yM30gwjYZbaQmr6CRvosZyznNHfpiq1uH7JqbyeBQbzkjFCgQGsWRHsHDR44BH8i3xzA==
X-Received: by 2002:adf:f6c8:0:b0:366:ef25:de51 with SMTP id ffacd0b85a97d-3683171d992mr3889197f8f.49.1721313154575;
        Thu, 18 Jul 2024 07:32:34 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf15dsm14587640f8f.32.2024.07.18.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:32:34 -0700 (PDT)
Message-ID: <5a26783c2167310237936d80affe61b43ea84022.camel@gmail.com>
Subject: Re: [PATCH 3/9] iio: backend: add debugFs interface
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Date: Thu, 18 Jul 2024 16:32:33 +0200
In-Reply-To: <20240716191443.397c1278@jic23-huawei>
References: 
	<20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	 <20240709-dev-iio-backend-add-debugfs-v1-3-fb4b8f2373c7@analog.com>
	 <20240716191443.397c1278@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 19:14 +0100, Jonathan Cameron wrote:
> On Tue, 9 Jul 2024 13:14:30 +0200
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > This adds a basic debugfs interface for backends. Two new ops are being
> > added:
> >=20
> > =C2=A0* debugfs_reg_access: Analogous to the core IIO one but for backe=
nd
> > =C2=A0=C2=A0 devices.
> > =C2=A0* debugfs_print_chan_status: One useful usecase for this one is f=
or
> > =C2=A0=C2=A0 testing test tones in a digital interface and "ask" the ba=
ckend to
> > =C2=A0=C2=A0 dump more details on why a test tone might have errors.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Debugfs deserved docs as well as sysfs.
> Same place in Documentation/ABI/
>=20
> Obviously we've neglected this in the past, but nice to do it right
> nor new stuff.
>=20

I see. So you mean adding debugfs-iio?

There's one thing I'm not sure though... I'm contemplating the case where o=
ne device
may have multiple backends in which case I'm doing:

back->name =3D name;

where name comes from FW (DT usually). That obviously means the interface w=
on't be
always consistent which I guess it's not a real problem for debugfs?

How would the interface look in the file? Something like?

/sys/kernel/debug/iio/iio:deviceX/<backend_name>_direct_reg_access

Or should we think in a more reliable naming? One option that came to mind =
is

/sys/kernel/debug/iio/iio:deviceX/backendY_direct_reg_access

where Y would be the corresponding index in io-backend-names.

One thing not optimal with the above would be identifying the actual backen=
d device.
It would then maybe make sense having a 'backend_name' interface which I th=
ink is
likely too much just for this?

- Nuno S=C3=A1



