Return-Path: <linux-iio+bounces-1812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3127835C8C
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 09:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5DE28499F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 08:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22620DE9;
	Mon, 22 Jan 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0Iqzx6C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954C210E0
	for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912091; cv=none; b=qdvUtOtbhdugUODehw23f3AAFMpNzARQc596bRJv/36bIQsQOqZkmcE1ZQCqxaqB/OPJgRWWkw6smWThOhEcHn8r3VjZk+8vhp5KzIXfZRiKBZMYb7Qu7isP7VbvldGdNrtMgPRmhqIKZdfi0LHzwSpFq6YSLfHlXWofD0zQBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912091; c=relaxed/simple;
	bh=7zNqROIFQb6WNmlturPGczGFWRN0VVwckMgMvf1xmbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pu1b/uszBxOJqZcRfCzYpDMX+byE/cp2W+fOeOc+nv3ke7jz8sAQde5ABG6lwRzbWVqdrbPqxEqqpIgQMrSon6ftI40VUltY+ogLzKD/DQlQTcSgyeVTTHLW0rtavHsh5v5IdSz6Ek+2IhZ/0CKo+7ObPcCGEBBh5VcK015o3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0Iqzx6C; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a271a28aeb4so291791966b.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jan 2024 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912087; x=1706516887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBSizC4FZ24bmdBvCQ/z4W6HGmLsK50c+jr9mAmn/LI=;
        b=L0Iqzx6CcHr8CYA7jFc8noZVhk94PD73FQ3usWUDOab+SrpEWwxWffWHVGb4q6/lnZ
         lzKcTxn75kn5HhpE+OOzmTIp03o6Xp01mNYGzrZKRBAMtzq2ZFjD+5ZXjphD1xPFQN57
         lK+p8QzLI16lt20JZpxpYHycaWgKig8b22yRVXxvnA1iYaEZPFekvCefY5tl7ooirPxa
         cNgERyMWkMFvQlGI0qG/d9ehPiQleMx1uxDO4cfnz1d+BCAZALguUeU+mW0/0RgmghYi
         u9mYRFxtFQw99KCQJplNyk91fPXgiNObTWNTE7St9h2qjO19fjwqb46KJgp/sHD7MevC
         9TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912087; x=1706516887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBSizC4FZ24bmdBvCQ/z4W6HGmLsK50c+jr9mAmn/LI=;
        b=QwSImh8B+7WL1FOUMueiN6+nj42gqJlTQ7xB/6EKiOYzI2P8KeQC0CfGzLVDtOP/98
         fHrhBi4D2Vq8i8RnpHuXjg4iRRgnMKtSpggZ32lI80kvgGWEP7uX3kswQ4WLJyRqPsba
         51x16J3iWMcRo3rMQYXIs7rr1MoEfrtBO10Y6flYzJSPtwQjebAmY65HIvQKzTZVE3dr
         gRojmH1UZ6vciHvY5yzjDbBmG/EvsfrN7LIVRkwksJk1slbGgj0yH36wGDlkU9yEfLVr
         +gltq0nIyNfbPskQVU+UTub67/jqVMviouWTbxI7Lp/HPHqWY0yy1X38h1hJno+eAtit
         cU4g==
X-Gm-Message-State: AOJu0YxT/Kqsigj/HjFxJbJtf4CnYVuK80Yeb5ehrJdhlJAw7XkNsUyF
	Yg86XM7Jv98tEFo5MtT4VV5l1hfO+WlZOv1/zxT2ofsIwkkYcDuG
X-Google-Smtp-Source: AGHT+IGfc5MyUD3fYyYbofwVYVRz9WAKfu/UXX2/smUHu1F+0N+F7sdUyjk40cSYsEQ/I9zkFhpfGQ==
X-Received: by 2002:a17:906:448b:b0:a2b:6db2:b8da with SMTP id y11-20020a170906448b00b00a2b6db2b8damr1671634ejo.32.1705912087103;
        Mon, 22 Jan 2024 00:28:07 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id c13-20020a170906170d00b00a2c047c6847sm13108363eje.113.2024.01.22.00.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:28:06 -0800 (PST)
Message-ID: <9fe5ab946da1ad2385dc02f5abd8a2fa58c0ac20.camel@gmail.com>
Subject: Re: [PATCH 1/3] iio: imu: adis: ensure proper DMA alignment
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 22 Jan 2024 09:28:06 +0100
In-Reply-To: <20240121161201.1d5c5e7f@jic23-huawei>
References: <20240117-adis-improv-v1-0-7f90e9fad200@analog.com>
	 <20240117-adis-improv-v1-1-7f90e9fad200@analog.com>
	 <20240121161201.1d5c5e7f@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-21 at 16:12 +0000, Jonathan Cameron wrote:
> On Wed, 17 Jan 2024 14:10:49 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Aligning the buffer to the L1 cache is not sufficient in some platforms
> > as they might have larger cacheline sizes for caches after L1 and thus,
> > we can't guarantee DMA safety.
> >=20
> > That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the =
same
> > for the sigma_delta ADCs.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@ke=
rnel.org/
> >=20
> > Fixes: ccd2b52f4ac6 ("staging:iio: Add common ADIS library")
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> Guess I didn't look in the main headers :(
>=20

Not many users anyways. Doing a git grep shows:

git grep "____cacheline_aligned" include/linux/iio/

include/linux/iio/adc/ad_sigma_delta.h:102:     uint8_t                    =
     tx_buf[4] ____cacheline_aligned;
include/linux/iio/common/st_sensors.h:261:      char buffer_data[ST_SENSORS=
_MAX_BUFFER_SIZE] ____cacheline_aligned;
include/linux/iio/imu/adis.h:134:       u8                      tx[10]____c=
acheline_aligned;

So we are only missing the st header. I can send patch for it later today.

- Nuno S=C3=A1



