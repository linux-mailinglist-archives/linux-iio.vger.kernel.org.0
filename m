Return-Path: <linux-iio+bounces-5678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F258D8394
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5AB22FC5
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B412C81D;
	Mon,  3 Jun 2024 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRRS/NKH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62B12C550;
	Mon,  3 Jun 2024 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420360; cv=none; b=odXGhT+ye+hftUo82WO3RRv7prB9ZXu8ZMOpjKhpNg6IIDv8N5GypkNzu90djCXluYuhP44qvNqhid56B4diqYJrrOKCGG43wcTkI75xq89QLibYRf0BlF54FnLrRd+BWSci0gXRp7pGWiIoUyG1Ux2V3XvIL7Hc/4+RC9aIcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420360; c=relaxed/simple;
	bh=9vECZuQN9rvTVQ+Bn4+skCJV/m297GeCrufh22rFSi8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EnnZ5iMCs8XVED5go0Oe4AFV2S+y3pCmUfLMBZBN1qCePwEt0eid7Aa2Fwlx1iAGlO4htaqjIsXvxRaErzKbF9Hmb6g1wUZqjJ7A7zESg5XaBAhZa99evf6qra8yeAz+6ETwYb0Fr8isMQjbuuX84PcW+RE6G4riwEBC7psJ7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRRS/NKH; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a692130eb19so82808866b.2;
        Mon, 03 Jun 2024 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717420357; x=1718025157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDFXoPl9QAiD7mft81g/Aw36i+8pqSQZWqXPwJ/7n6I=;
        b=dRRS/NKHsP7CXAhIcsMx4TmiT0F0QfS/+zFVLoPk18VA7uY/ZN8kmczzXRjrFTnN3K
         1O9l/98drdKCqk46vH8BcWa4TShZzpmEYHLSeBN0zwdRDnWVd99ymry2scwz6jGoI/eY
         Na5C5THflRP8xOXF0bYOkOKPL0coUr3p/Ah/rOcG8yGXVKW3ieC88RmwyspEyzmvrXNQ
         5vjMnNer2bZ/rq/YPod8dWCnuFwYT9xx0WizRFbDQrDftBi0g8Ehl5LNy8X3Gap7gRkt
         x7N750nnjB4Pt36C0NxM8VkRYPdq9oiwQZteyAfXVOpIfY8Qq3PeXx0NEZgsy2/2CmH2
         PoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717420357; x=1718025157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDFXoPl9QAiD7mft81g/Aw36i+8pqSQZWqXPwJ/7n6I=;
        b=rVEMfUnZH9PklxM2UOEuIXVshG6gy3ivFf6KC9XawHH1JJJ4MPBEbHREYfSRHJSqqI
         cf65DJc8sXQndbkAyG/hHxlUN/eOUdItVPWjmrAeTa+goOjQm6M4g3ycw7e41j94NCg/
         W12EoLf8RinVf5TJHfYq+Vu2lo4JvQpwAB3ueiFFk1fWe7XAeC8+3+k7Y9LDTFr4QJ4p
         JSSFC8p7nGD/6aI6j5uJEEqfUQiD3GjcBLpmquDoSG7TUPmXZDCbp+zdRnszGxWXB+qU
         ngmHqr5ffNzLL3HM1Sl3GVS8SAv6xTCD/3eWs7HhZhgRLZStHc6Igf4fkbR/yhgcc08K
         1yBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH0nVW5gWBRxgE0gwQeYRnJ8rmc3ZXduCxwD6guVuczIn7w+0foEDLKkBwltiHkx5jbwf0FPLo4Er6zatTuS6UuAUxuI9MB6RY0pw2cEo2efNn85dZu/K/Pwfsa+6UbqNWzIqNAnijEy86kvVw/sc4Jt2Nyk69/WC8QquUo9BcEBJ8oQ==
X-Gm-Message-State: AOJu0Ywz/My7sjW/uL11KiNew4ocx/iX6NM15DE42CwWGZpZM2RiceAP
	Et/9Fd1xsvuusUuni7ORBlMJnNfq0CZ4mwlFRhv4a0OzN9MguIkH
X-Google-Smtp-Source: AGHT+IEUVxQ9shjdUvCUFmrhT3joLAoB6rSyyBG57Rf6KbKIeWfvujt8kBwBXijDrUPJI3srZGpdQg==
X-Received: by 2002:a17:906:aa4d:b0:a63:41e4:ee57 with SMTP id a640c23a62f3a-a681f87e62bmr535222566b.15.1717420357249;
        Mon, 03 Jun 2024 06:12:37 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a690e5ee90esm146062166b.117.2024.06.03.06.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 06:12:36 -0700 (PDT)
Message-ID: <f262dd8884e89bb36a72fe8fd5cb75cd9ae6fa08.camel@gmail.com>
Subject: Re: [PATCH v3 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Lars-Peter Clausen <lars@metafoo.de>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dimitri
 Fedrau <dima.fedrau@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Michael
 Hennerich <michael.hennerich@analog.com>, kernel test robot <lkp@intel.com>
Date: Mon, 03 Jun 2024 15:12:36 +0200
In-Reply-To: <20240603012200.16589-6-kimseer.paller@analog.com>
References: <20240603012200.16589-1-kimseer.paller@analog.com>
	 <20240603012200.16589-6-kimseer.paller@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-03 at 09:22 +0800, Kim Seer Paller wrote:
> LTC2664 4 channel, 16 bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 16 bit Current Output Softspan DAC
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405241141.kYcxrSem-lkp@i=
ntel.com/

The above could be dropped. This is still not merged code :)

> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

LGTM... just a couple of minor points/questions that you can maybe take on =
if a re-
spin is needed.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

...

>=20
> +static int ltc2664_scale_get(const struct ltc2664_state *st, int c)
> +{
> +	const struct ltc2664_chan *chan =3D &st->channels[c];
> +	const int (*span_helper)[2] =3D st->chip_info->span_helper;
> +	int span, fs;
> +
> +	span =3D chan->span;
> +	if (span < 0)
> +		return span;
> +
> +	fs =3D span_helper[span][1] - span_helper[span][0];
> +
> +	return (fs / 2500) * st->vref;

no need for ()

...

>=20
> +static int ltc2664_channel_config(struct ltc2664_state *st)
> +{
> +	const struct ltc2664_chip_info *chip_info =3D st->chip_info;
> +	struct device *dev =3D &st->spi->dev;
> +	u32 reg, tmp[2], mspan;
> +	int ret, span =3D 0;
> +
> +	mspan =3D LTC2664_MSPAN_SOFTSPAN;
> +	ret =3D device_property_read_u32(dev, "adi,manual-span-operation-config=
",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mspan);
> +	if (!ret) {
> +		if (!chip_info->manual_span_support)
> +			return dev_err_probe(dev, -EINVAL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "adi,manual-span-operation-confi=
g not
> supported\n");
> +
> +		if (mspan > ARRAY_SIZE(ltc2664_mspan_lut))
> +			return dev_err_probe(dev, -EINVAL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "adi,manual-span-operation-confi=
g not in range\n");
> +	}
> +
> +	st->rfsadj =3D 20000;
> +	ret =3D device_property_read_u32(dev, "adi,rfsadj-ohms", &st->rfsadj);
> +	if (!ret) {
> +		if (!chip_info->rfsadj_support)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "adi,rfsadj-ohms not supported\n");
> +
> +		if (st->rfsadj < 19000 || st->rfsadj > 41000)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "adi,rfsadj-ohms not in range\n");
> +	}
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		struct ltc2664_chan *chan;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get reg property\n");
> +
> +		if (reg >=3D chip_info->num_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "reg bigger than: %d\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 chip_info->num_channels);
> +
> +		chan =3D &st->channels[reg];
> +
> +		if (fwnode_property_read_bool(child, "adi,toggle-mode")) {
> +			chan->toggle_chan =3D true;
> +			/* assume sw toggle ABI */

Do we have any other option :)? For the ltc2668 driver (where this code cam=
e from),
we do have another way (driven by clocks) to toggle between outputs and hen=
ce the
comment.

BTW, there's a fair amount of duplicated code between this and ltc2668. At =
some point
we may see if it makes sense to add some common module. Anyways, fine for n=
ow.

- Nuno S=C3=A1



