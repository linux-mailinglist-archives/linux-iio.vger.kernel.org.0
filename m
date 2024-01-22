Return-Path: <linux-iio+bounces-1814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DC835CBF
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBFF1F22E4E
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jan 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910602134B;
	Mon, 22 Jan 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXewoDdD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B4210E7;
	Mon, 22 Jan 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912578; cv=none; b=XSzfciXFPHmsP5mC0ET1atH596gPu+FkO9CJorg4j1pefBlkFxHvFhxOHkxt/+QRqotxnD3ULqbrsshrvj9ag2Kg3zWWQ9O+R+cVPi1ipvbBi37cVNd0F/Q0oVCV4PV7LImgV3erQLLx0lSSM3M20EBiFyCSHtL6+wHhMQDgedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912578; c=relaxed/simple;
	bh=8abXrOW9OtCSzgvOHlTfXeL9SEhOUDbJ2S7X6RhtUYE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXAaeyGzWacw1M6oYn4fC7safoVX8gOlOUcXDANVFUz/UEseoXdgZBkqWn9mWJNKUmlHkGHQ8qQoycscFfNJ3JsXdCWLMlhFpC0ybdzoOSjN3ZrxzSqxeQ2ZecOluQd9V17KauOfn7YSTy7grftPdE93uD/YQPDY0ad1Myu2hH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXewoDdD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3046221b0eso56289566b.1;
        Mon, 22 Jan 2024 00:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912575; x=1706517375; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8abXrOW9OtCSzgvOHlTfXeL9SEhOUDbJ2S7X6RhtUYE=;
        b=cXewoDdDujcI0wcL2ezy+1vt9MYc8+DM0jaS3lny6MRXJC8GHTCA7STvEfj/Nx4Ai5
         5m54dI2d4J4tzPB1pcoVI3QSTQMlyNEmNKxl2YUlN0EPcLUjWprZEXolg+cYZ5b3LCOF
         3HNEY/t9i+0pu0DUBXWjGGItDWeaRsqcnROed8Wxu/PGjhj6uwTpUxn6Q25YIkhE0FeG
         tAJ53eghcy67uQrQjqhdQd7Xlm4GgVE58jaUH6mvyJ38upt6zH+SrVb+5VuAiuHgBfsd
         3wUsTbdeApwnfA8Z4VIsU7FDIpqKU0XNtHy1yWPEWbGu+RTeV06tOGTCERV6/vwS40/1
         48QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912575; x=1706517375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8abXrOW9OtCSzgvOHlTfXeL9SEhOUDbJ2S7X6RhtUYE=;
        b=fsdmo+lNBjHKnIPOJDuNRLt03tpv0ahN1RIYlgfK/60NqlMOx/vc1P57kzos6SZBix
         5fozkNPYdHxiYahvvNJWT2IuQcdFu1Zwx0+pY2jDCJ+gy0g82qPxMwlawFVgUmuUBMJ2
         LfXMXlbmrXoeFsv2m4t6bXSwfZIdriA8eDS0uausybXAoQOxxpVg2loI1nzjMmJLmvVW
         +zNgCmJUNot+95Dy2mH9MWzCoY4G3GUNTD/hJtAS4mBjFQpm3lQOEjZ74aLPlHU54WjX
         /xD1TsF48wAJzQuJikbeRYriMvaDv7eDZGRoUBKJaeVTjCI1tdHBY+NkeuLHJYtVinec
         qAiQ==
X-Gm-Message-State: AOJu0Yy75HyatvvNDVHKDaYOiWQGZB5001vPW/DITQI6tNd78+bPYzh/
	3TL/9ki6SBNeIVha6UspqphSwSZMacof4rCJRZQwJhKAZg7t1S/O
X-Google-Smtp-Source: AGHT+IGFZqVoZsfk2AHP2Lxo/G6S8n4W2oDGjqsfk/vGCAJX4a3S7flpYQEdWOnjZOp5InAHqHBhzw==
X-Received: by 2002:a17:907:c088:b0:a2f:c367:7699 with SMTP id st8-20020a170907c08800b00a2fc3677699mr1684771ejc.24.1705912574452;
        Mon, 22 Jan 2024 00:36:14 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090605cf00b00a28aa4871c7sm13004569ejt.205.2024.01.22.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 00:36:14 -0800 (PST)
Message-ID: <a0e01566ef2317ba35931526c4496723839be5c2.camel@gmail.com>
Subject: Re: [PATCH v6 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, Rob
 Herring <robh@kernel.org>
Date: Mon, 22 Jan 2024 09:36:13 +0100
In-Reply-To: <20240121175724.76ff9be3@jic23-huawei>
References: <20240119-iio-backend-v6-0-189536c35a05@analog.com>
	 <20240121175724.76ff9be3@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-21 at 17:57 +0000, Jonathan Cameron wrote:
> On Fri, 19 Jan 2024 17:00:46 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
>=20
> > Changes in v6:
> > =C2=A0- Patch 2
> > =C2=A0 * Add '#io-backends-cells' property to the example dts.
> > =C2=A0- Patch 6
> > =C2=A0 * Improve comment on struct iio_backend_buffer_pair;
> > =C2=A0 * Be consistent with dots in kernel-docs. So dots only exist now=
 in
> > =C2=A0=C2=A0=C2=A0 description and return. Also be consistent on device=
 managed APIs
> > =C2=A0=C2=A0=C2=A0 subject and @dev description;
> > =C2=A0 * Added devm_iio_backend_enable() and hence (and for now)
> > =C2=A0=C2=A0=C2=A0 iio_backend_disable is static;
> > =C2=A0 * Fixed __devm_iio_backend_get_from_fwnode_lookup() kernel-doc;
> > =C2=A0 * Improved english in devm_iio_backend_register() comment;
> > =C2=A0 * Don't make private data mandatory;
> > =C2=A0- Patch 7
> > =C2=A0 * Use local ad9467_chip_info *info variable;
> > =C2=A0 * Improve error handling for optional devm_iio_backend_get();
> > =C2=A0 * Make use of devm_iio_backend_enable().
> > =C2=A0- Patch 8
> > =C2=A0 * Also change string format in version error path.
> Hi Nuno,
>=20
> Other than wanting a few acks (one for 2nd DT patch with the fix and one
> for the device link changes) this looks good to me.
>=20
> Ideally of course I'd like to see the second user if that happens to be
> available in the first few weeks of this cycle, but I don't propose to ho=
ld
> this indefinitely to wait for additional users as the framework seems log=
ical
> and it's all in kernel anyway so we can probably change whatever is neede=
d
> later without too much trouble.
>=20

Alright. I plan to start working on the next user already this week so let'=
s see how
it goes.

- Nuno S=C3=A1

>=20

