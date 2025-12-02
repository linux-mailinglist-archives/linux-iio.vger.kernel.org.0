Return-Path: <linux-iio+bounces-26643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE51C9C4AC
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617593A6428
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511B2BD00C;
	Tue,  2 Dec 2025 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9/Wzv9F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD429D281
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694385; cv=none; b=oaD1+Hst/KYUscR4UOQrNBfez/AMXt7iiICFa64BhDm5doBnTWgLj8VeVbAowL9RYozpo3Ih6XqcK8wg1nCj0ovX9nyXcApJmDTgI5hQcnqkUz880PHw3YNBBz5gq/qO++M4fFJXkoWZarv8Ls1JpTjcpIEzbQY/zLMK/DQLCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694385; c=relaxed/simple;
	bh=mJ1vqZveqVD6FTtyhaVHSkhjadzx9EmB1m/qDyNlDWE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VRpeIA7MwuXd5n4N8G8F7wUsBzpebuWB81eAZhGBC3ZrUn5jW7cut1b3HLnive39jG3BfZrzrMsztgPtC0ocT3n1L/X6mGSc9y1XzZZSzcgpV2l/mMjqI4jutHWc40Z3U/1somjV7sxi7sbeKyK5trOS7ALQTyoj6HVh3yx4w2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9/Wzv9F; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-55b4dafb425so5314e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 08:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764694382; x=1765299182; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpPLuo53I6h3V+PicS332QHjcrzteQ8XBzR6dVBP4mY=;
        b=W9/Wzv9FO0eyLl5N8mLyF2g5i5xtopbABgAm02yQAERJWGgya0Z/k0uAZsMhE61MqF
         S3XMNdITGUlfR0PFHXyswPdIZT6Pb5fIHQkVh42jezPEkhETTGQivc31Abt0OwqLjjRi
         47YhEapWJKG3+idR/j5vF/8wmuT4xzv2qIREAgM/CRy82Bnlq3iWLNzRD5HffrDFRSSB
         /yhM2TNyvpN+9cubZ+5+XJyXzUQ40+U/ROJITM7URMN6qktCRt2FexZWGhHlLGRadRG+
         3nNQiX8F8+o6zpY46N9bGhuzFy4WUd14XrLZQATnPEqXkz9b+1Bn2ZESYlemh1m7Ozqd
         9Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694382; x=1765299182;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lpPLuo53I6h3V+PicS332QHjcrzteQ8XBzR6dVBP4mY=;
        b=VV9woQ+nNfMWKTN5+PU/bMSpCEGYHgqe79jH7ekY4TzP37K9iPUAiDwpV+DUdM9f0n
         Cf5pd+OIkBHhEIritTUIA5lM/R4ijYmKitt2JqmzpLWsVxAKPA18BW1kKoC5s/6VnwS0
         VQ4u66o8FyDbYgfg5TsfbysCd9og4MvHaj9tlzlRUzdKSWLrVtEIckHrhrNCtipRSrgG
         VhLjkFBfItilKBiPl1NijZMWMaFkP0OSfgz2jExs6Fl+wOXX/2gXYaczQBCLo3bYR2IT
         1F+wD1xLZGRAsdy0hPOMIJ5TOr/qNd5nVL+LKqjC9r06CIhWacDHQtuADmFZIi/LeLz9
         b1ig==
X-Forwarded-Encrypted: i=1; AJvYcCUXfWanjVZloqVKzvwwgYBHoqwDFHiQjelsYBsXPKGCUQqPBK7rkvMMWExzCQYRwZKaEwpGYXNSfWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OPHmvii0q0zuqDDn3uD98x/g/7+pVoyolreXLGUJChKbrpKO
	XMmJLJBU1PgTW3BjCDAM6U+UwBPnaa0MLuCXNPUA/2IqM+ElEwcHsVdh
X-Gm-Gg: ASbGncv7xR1PELBh/Rdgl0SIB44dqGfsO1y94qcewbF5XcKuEyAfCMXTarz0kV+ArrI
	3kvWnBAfWz+4GNwBt+HJt02BUrQ275D+GjWRWvnn9oyFg8wSk/03J32M9xyZcu0IBCOu137zFoJ
	/Yc2W7mfcsn2dEAsrRzGbkhXQO6TXtb/XiLw/soB9PGGtQQxNs2g4rsDZHHbI/XoMKyPufFpD2V
	csUL/uCmsOA/Z364ON4N77wTaIC9DvUjht4Jp2g3TORm/XcIaGxOPXJ7lkX5eyNqEvzGWLDIOcs
	/sAtPOvfzgIE4x00YbNCk5W+u1CTKSzYpFhisWcTbbMbObUvUbNh8eCt8ohtwJzpai2GMZMb7bf
	LzvF3EIyjGMeASTVLmsDTDkFUo2v07fsZYj/zFGnEiUZO16vsDMfc37agnocYswMDFJymwJVEtB
	Hq2Poz6g==
X-Google-Smtp-Source: AGHT+IGeCeEIS2GLEDxIvZQM2NjmRQm29Rl9y4xLMUI1F06FQ+qddMpe26cG8KXEZ0UKAHEhHxLGOw==
X-Received: by 2002:a05:6102:3a10:b0:5d5:f6ae:3914 with SMTP id ada2fe7eead31-5e40c7cb8d0mr1892111137.22.1764694382563;
        Tue, 02 Dec 2025 08:53:02 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5e24d91777csm6283432137.1.2025.12.02.08.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 08:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Dec 2025 11:52:59 -0500
Message-Id: <DENVY6GZ4XZB.16W16KKSN1KXT@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>
In-Reply-To: <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com>

On Mon Dec 1, 2025 at 6:09 PM -05, David Lechner wrote:

...

>> +static int ads1018_buffer_preenable(struct iio_dev *indio_dev)
>> +{
>> +	struct ads1018 *ads1018 =3D iio_priv(indio_dev);
>> +	const struct ads1018_chip_info *chip_info =3D ads1018->chip_info;
>> +	unsigned int pga, drate, addr;
>> +	u16 cfg;
>> +
>> +	addr =3D find_first_bit(indio_dev->active_scan_mask, iio_get_masklengt=
h(indio_dev));
>> +	pga =3D ads1018_get_pga_mode(ads1018, addr);
>> +	drate =3D ads1018_get_data_rate_mode(ads1018, addr);
>> +
>> +	cfg =3D ADS1018_CFG_VALID;
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
>> +	cfg |=3D FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);
>> +
>> +	if (chip_info->channels[addr].type =3D=3D IIO_TEMP)
>> +		cfg |=3D ADS1018_CFG_TS_MODE_EN;
>> +
>> +	ads1018->tx_buf[0] =3D cpu_to_be16(cfg);
>> +	ads1018->tx_buf[1] =3D 0;
>
> Seems like we could use 16-bit cycles here too?
>

Just realized, we can't use it here because we would need a CS de-assert
in between (16-bit) words and also keep it asserted after that for drdy
IRQ. The 32-bit cycle simplifies things a lot in buffer mode.


--=20
 ~ Kurt


