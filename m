Return-Path: <linux-iio+bounces-2059-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAE843860
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 08:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6CF1C209AF
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jan 2024 07:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8985577C;
	Wed, 31 Jan 2024 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q20cM80D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855255C04
	for <linux-iio@vger.kernel.org>; Wed, 31 Jan 2024 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687738; cv=none; b=P87pH2u1vHuopIkBQ/P5CIV+7FJc9mYbz9WbTnqlSjOAf7kymJTZSKnyXoEbqtnm3pTE6w4WZQIUQfNlPCiOCE5PYw6WgY7UgHEEh2c9+phQDgI0yWB8AcluBvRYKyskeyAfzw3B9MG+PVmgmtVP+VllQAfr7lDMewVrygCLbX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687738; c=relaxed/simple;
	bh=eBREAVTcAzD4QhzjalmIwnXp1JHVI0WA2g2+J7AuhDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BZuSFTTsrUODf4VC3TSh/CG/Rh4Ojn8iqzxELTqsQNtZpNM2Ab+R/cjSnGLIXKaQOvoje2GAXxmTS8kki2pJJvsiumhUgczcoiB1STAqiCpsNvE1y6Q+x7KK66djK736WGdhT0ccaSKL0Mzn+Us55k9IqDK3TTevYSSya7QZsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q20cM80D; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fb3e278adso3258335e9.2
        for <linux-iio@vger.kernel.org>; Tue, 30 Jan 2024 23:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706687735; x=1707292535; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zYsaCefEnbXOxwpiHnf1fcE5dkyR+4eiL0KIZTyiQVA=;
        b=Q20cM80DC1Q2Kbl6zOaQ0+KcV75o8LALHiWZaTl+jXbkzKNinafKUA6St7JGk22r+6
         m+oebzqSnIJoPikRQ2/pVyYeBALng5DxchW3ISnIbLw9zhimmA6Px+9LMEVAx54Nk5Gg
         R1KG1jLUg+JwUlNy4ukSdsC1/s0jRQ0FYE1V9I2InSvyL2phH5xxfEKbDIzouX9uhHf/
         KiFdd2TBodO9Vr/ulWYexY+/pTA0s2UGxalIhmnH8S9u4NaDa0VBwclpjvme5JU5gHRP
         o1BUXLHFYsPkWhoerKzbPtOwWZHAQVzYdHSCr+VE+hI64qm0oqn6s7efo16Iuezujs+Z
         bvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706687735; x=1707292535;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYsaCefEnbXOxwpiHnf1fcE5dkyR+4eiL0KIZTyiQVA=;
        b=FAEUOOxp/vjN5zczjvhnIbGSHbOXnjkXv2bvF4N3lFHDuRmu+rajJp6r90o10PKKWY
         mPApehYdUWAhu8SCEoc9MZe2vnc3GY2EmDsQsmPlVjIwMgkve83liol13MAenQp9FYmc
         z8b0cvyBW3BYqDXv9Uum1B+p9uIZZ9TtYeu3CZgqU3XCEOyR8MHg95OlMmZsvOGLboCi
         0CgXJZuSoVLOTiAfHICgTC7h61Kitc0M7xnPQCwsQ1HC1ifWuZsSIQHC1rdLs7YWbGK5
         PuIiYVpumHP3w+VxIzs56rn/RnMNUlijlr2yFMMQP5n4VrejCjDzGe65ItEThy6x9mU9
         9hyw==
X-Gm-Message-State: AOJu0YwZcoBtTRoEMDvLVpNEcaLhJcW4D0QaCrXr4GQUGtnfa8IDl2Hr
	Zo00Duj9hxMTIQTSpuNG3bIxaZCYfhTiM4A+zAwdMOjppl1K3vi/
X-Google-Smtp-Source: AGHT+IEZ28iJg1kXpD8NPR00HqcDmuO6XsjrfAbKZGZX95mLQUdEQEC1JwF6Ddr2zVvUIT54yTMUwg==
X-Received: by 2002:a05:600c:43c5:b0:40f:aabc:d508 with SMTP id f5-20020a05600c43c500b0040faabcd508mr694903wmn.10.1706687734681;
        Tue, 30 Jan 2024 23:55:34 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b0040e89ade84bsm781481wms.4.2024.01.30.23.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 23:55:34 -0800 (PST)
Message-ID: <0b61fa64fe9a3f0569ceb160b1901ca50e24f548.camel@gmail.com>
Subject: Re: [PATCH] iio: commom: st_sensors: ensure proper DMA alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
	 <lars@metafoo.de>, Denis Ciocca <denis.ciocca@st.com>
Date: Wed, 31 Jan 2024 08:58:51 +0100
In-Reply-To: <20240127155655.6495b465@jic23-huawei>
References: <20240122-dev_dma_safety_stm-v1-1-3a021614cbfb@analog.com>
	 <20240127155655.6495b465@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-27 at 15:56 +0000, Jonathan Cameron wrote:
> On Mon, 22 Jan 2024 15:15:41 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Aligning the buffer to the L1 cache is not sufficient in some platforms
> > as they might have larger cacheline sizes for caches after L1 and thus,
> > we can't guarantee DMA safety.
> >=20
> > That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the =
same
> > for st_sensors common buffer.
> >=20
> > [1]:
> > https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.=
org/
> >=20
> > Fixes: e031d5f558f1 ("iio:st_sensors: remove buffer allocation at each
> > buffer enable")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0include/linux/iio/common/st_sensors.h | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/linux/iio/common/st_sensors.h
> > b/include/linux/iio/common/st_sensors.h
> > index 607c3a89a647..a02652cf4862 100644
> > --- a/include/linux/iio/common/st_sensors.h
> > +++ b/include/linux/iio/common/st_sensors.h
> > @@ -258,7 +258,7 @@ struct st_sensor_data {
> > =C2=A0	bool hw_irq_trigger;
> > =C2=A0	s64 hw_timestamp;
> > =C2=A0
> > -	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE] ____cacheline_aligned;
> > +	char buffer_data[ST_SENSORS_MAX_BUFFER_SIZE]
> > __aligned(IIO_DMA_MINALIGN);
> > =C2=A0
> > =C2=A0	struct mutex odr_lock;
> Hi Nuno.
>=20
> This is another problem.=C2=A0 There should be nothing after a DMA safe b=
uffer
> embedded
> in a structure like we do here.=C2=A0 We rely on C structure padding to e=
nsure the
> rest of the __aligned(IIO_DMA_MINALIGN) region is unused and that doesn't=
 work
> if the buffer isn't the last element.
>=20
> My guess is we are safe to just reorder this before the buffer.
> Nuno, do you mind spinning a v2 that does that as well as the size change=
.
>=20

Hi Jonathan,

Somehow I failed to see your reply and was so focused on just having the pr=
oper
alignment that completely forgot the mutex after the buffer is obviously
problematic. Good catch!

Will spin a v2.

- Nuno S=C3=A1



