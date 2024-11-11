Return-Path: <linux-iio+bounces-12130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1DC9C40E3
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72BD9282009
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4A1A0AFA;
	Mon, 11 Nov 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICoL0Pka"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD61A072C;
	Mon, 11 Nov 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335263; cv=none; b=D/QRkiU2vao+C2drVB8b9F23Eqy+RvqcBK4OixuLGmmcKhAC8/P5pS9LHzG1Q4BIGGHaN2VOw0u5C1EpKEDA8jx3Nxno1zx14dH6Ad8qUCDxF5Mbmr2imyVi57OEqSt1nfpLdsQEX9ssdXbQA+BZMm1Wth5VjQXZ0Rpd3Z03uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335263; c=relaxed/simple;
	bh=eEGsvudAjV8uZyQQuqVW5H7XqcOLtd4GyJbvDDtWL0w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3b4OLH9euhfN4utEBdEtTg43HmWqYLBvTZBJcSfGlnGVItX8D7P8l5LW52NIYZJfFX2FlnWNLZZ2i/2meXuTc8faHtR9zeIXRbsUggmaZHWNT+MX36cSiWEkqXXgD6BgXyvOx1jnZXvh6ULOfjoAyrMlFHtNC7zJGC+L8XikgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICoL0Pka; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43163667f0eso38700655e9.0;
        Mon, 11 Nov 2024 06:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731335260; x=1731940060; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FA4fg8EgE5Jo/jAak5kGvpK2VccHufoFw14P8z0rcr4=;
        b=ICoL0PkaM3eWTBAdA2rAJS+deQk7KCZEPC6aHDmdgwLuKTmtaxPkBHd2j757MLPA+h
         F0OskppX4qBwsbSzl2LdKSH6XSOFR5J3by4zZjzQDo3tnaVi2ylYdcQWZr1m6FLRw8El
         GncTMxXLnAITzP5f+aRrkvZ4oDLzS4xfd3JpctgKEgK63iVtas0w9BcdvfqPOwkryJzl
         TWjJrLI4t2qRGm1WyfbzQWJdzABFw4uVOozaPoFkd7qZXe+jMI+8vZnVTpJW/cKIA8jV
         WYWVniw4vcB9/IuytXBnrQHVPog18kcVp+9X4JYNXBeoVh6O1lC1e98zbxxN9Iw/Okhz
         a/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335260; x=1731940060;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FA4fg8EgE5Jo/jAak5kGvpK2VccHufoFw14P8z0rcr4=;
        b=rSLvRu+lAML3iSl/1aXAlNLMFsC/1wQ5S52SMHtHtnHluyYjrHodVpJZ396DjmtuR+
         2J1fts3j0enmic2pc3G8POj/CmvFJuu6KwUaR6+SYkFgJ3I/bg7YG+scmB6nk/BJ34Dd
         RBFS6mc0oyx2SOvSzOUW75uHiw3TTToQNV4Njt/8NMKgFHm3uRNBGjymEfzNvME3tddt
         kHSz4CV0RAgR4TWiFMb9S7wSbILIvOzptiHZAFOgYdh8KAguzMfpkEJ+hLC43MIexsPX
         c7VT5B6VBZOGNOs5WCKA/0E9I4z6mUCNALVhKikge6GWpSjEZqRd8XfKG66r/g+baR8K
         OSjw==
X-Forwarded-Encrypted: i=1; AJvYcCVLiGSPfsr3LmiW0psTyhGhwsI++TPfElfOIMPrc2ivL2SVjj6iz6JY9v2VAeO/eKGN3A5/AegXOeM=@vger.kernel.org, AJvYcCWS1ZOP1UvxX2qBl4+bKre09cucgFXiEtbPJGubuKwHTe4MeXsw7TuWHzyl5+Lnvf+sy56bPUBrpMec4EFZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/GRRg5Wa8o9FD3+y0d3poTj8cAGtnzc1s0WCGRcYw+qRkdijr
	MCHk27PZuyhvAXBojAdG6Y9LXoRyMXk7mDJlFpDimxyMnYpdtT6a
X-Google-Smtp-Source: AGHT+IHA61Lhd6SeLe/RS4BP+0gz/JrzXEkrgiRp7GGGzy5Q6CMihwllVa4BlSuO3I4saDkm7V4pvA==
X-Received: by 2002:a05:600c:3b05:b0:431:3b53:105e with SMTP id 5b1f17b1804b1-432b7503f43mr112079135e9.9.1731335259280;
        Mon, 11 Nov 2024 06:27:39 -0800 (PST)
Received: from ?IPv6:2003:f6:ef02:f400:a23c:697f:16fb:11c5? (p200300f6ef02f400a23c697f16fb11c5.dip0.t-ipconnect.de. [2003:f6:ef02:f400:a23c:697f:16fb:11c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5b96sm184012785e9.41.2024.11.11.06.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:27:38 -0800 (PST)
Message-ID: <5e0e305f8a3fc234f207683c2e6e9a5a3315b43d.camel@gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ad7124: Don't create more channels than
 the hardware is capable of
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Mircea
 Caprioru <mircea.caprioru@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 15:32:01 +0100
In-Reply-To: <25w34mtjiy2t6t44xa4sewan6qrqettsfrcxjv7cnfhoxfnbnp@mcwrqo2hikrc>
References: <20241108181813.272593-4-u.kleine-koenig@baylibre.com>
	 <20241108181813.272593-5-u.kleine-koenig@baylibre.com>
	 <b91ccaa161b962336324af31cd507fd1255e5c5c.camel@gmail.com>
	 <25w34mtjiy2t6t44xa4sewan6qrqettsfrcxjv7cnfhoxfnbnp@mcwrqo2hikrc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-11 at 12:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nuno,
>=20
> On Mon, Nov 11, 2024 at 11:37:46AM +0100, Nuno S=C3=A1 wrote:
> > On Fri, 2024-11-08 at 19:18 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > @@ -821,6 +822,11 @@ static int ad7124_parse_channel_config(struct ii=
o_dev
> > > *indio_dev,
> > > =C2=A0	if (!st->num_channels)
> > > =C2=A0		return dev_err_probe(dev, -ENODEV, "no channel
> > > children\n");
> > > =C2=A0
> > > +	if (st->num_channels > AD7124_MAX_CHANNELS) {
> > > +		dev_warn(dev, "Limit number of channels to "
> > > __stringify(AD7124_MAX_CHANNELS) "\n");
> > > +		st->num_channels =3D AD7124_MAX_CHANNELS;
> > > +	}
> >=20
> > Hmmm, I would treat it as an error...
>=20
> Well, it probably results in an error further below when the first child
> is hit that uses a too high reg property. I considered erroring out

Assuming no one points two different nodes to the same reg :)

> here, but thought this might not be justified if some children are not
> logical channels. I'm not sure either way, but can rework accordingly if
> all other concerns are resolved.
>=20

Anyways, I'm not totally sure about the logical channels you and David are
discussing (did not went through it), but FWIW, I agree that we should stop
probe if something is not supported rather than proceed just to get non obv=
ious,
subtle bugs.

- Nuno S=C3=A1


