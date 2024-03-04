Return-Path: <linux-iio+bounces-3304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A018C86FB1D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 08:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A930281626
	for <lists+linux-iio@lfdr.de>; Mon,  4 Mar 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545AB168BC;
	Mon,  4 Mar 2024 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6/UiYj4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75915AE0;
	Mon,  4 Mar 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538654; cv=none; b=a9IP8Q4sIshLpk7gblgEJI4W6q2HKc3LrmMUGGCjyWDnfnQ4pHdz4nJqFvwdXaThbEr5fCcQiiC0dGfzvGtH4oDM+5p4XkxJiJZdqrfk8InA12dnY4qx20gz7M3ask3mhOTKuiV785WdXA5mCda56+EoJa86NlykqkaRMxlD1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538654; c=relaxed/simple;
	bh=ImYqdxWVGYvMoxeUi9HIn7BB0qcGI0F1OXSfyaBjD7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C/rklWgJhprH4ellccvVMI9oHlUdhLRClLhUz6qedmslXqWNzxYKvDfCCAkRUIHgADcXcmg9mz1NBXPBVwmuKQqpZJlZiv1FWW20HQwjoNLpOxGGACsh04bTQRg2t/2VYqrBFkAp/D5Kk7BXex2pGpMwy/cs3ZK6uiUDSJcbWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6/UiYj4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3566c0309fso521780566b.1;
        Sun, 03 Mar 2024 23:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709538651; x=1710143451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImYqdxWVGYvMoxeUi9HIn7BB0qcGI0F1OXSfyaBjD7E=;
        b=L6/UiYj4ubBobiX9qgsN4UFeRAsK7ymxWHGJk/yopR8amurqWgw3SQlmbYflxVJCnE
         y8CigkqPjHzq/taf9YLgfN0smE/HFesmj873KY447YBRufUNr+YmOYCCKFiCYYxmg2OD
         RUiheTm5OWR7dbUFGHURC/Tw6U8xVveZSaQ2SkJKgKhmfMRnFlup4u2dfpg/RwHYyIfd
         9H6g6YPr2O8rNTr/30BYcwk1n1sIVDg0sIEWuibiA4rkfPK6TOFRhvFGkOaHy+3le3F1
         uIh0EEA1Q7clqn68BnUoynECDlk1xqnAeEW0HI+dkLq5yRcWX4bXx01sNcwMo9PD7579
         vYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709538651; x=1710143451;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImYqdxWVGYvMoxeUi9HIn7BB0qcGI0F1OXSfyaBjD7E=;
        b=KXO/kUv6Senis4OrEHGywgL7adzSrrikkldLpyLsH5p7R/pKOBVC19EDr99jeGyjG0
         qC4F8GDDlsM1YMxIPXsyXbACOJXz14hS8R7p3/sgsl26oKhGHGlM0nmqtGrA8BtUPJU+
         u6gMFFEoQBZ6GV6aQhJDkJ3FaDPAL+XpuCoDHkyVuHLlFhr4YptNMCs1KuMU5iEH5Y9+
         mpajRdORPT0Vm4SdfgCjN30uPn1kfB+BDvpM2W55/iEh7fW00ZWw1lShPImzhu3Ugr66
         Ze2BY0OA2dcqeQuho/4G/mCCikVS/XmSCRzZCyT4juAhrfWncF9sKc5vmqAtC9CDDJuR
         r9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX6r34bYQ+OLtYx3b8Y4fWQ/VgL+wdPHH+PzjdpoaL+IXjtOKz6YvXv4VWKkO/hRYGnfF4jCcNgGkeodqreX0taHbp05qdgimkaPc71x2NKWKHd52pKynudhUNoQb94RntkQsttg==
X-Gm-Message-State: AOJu0YznABuc92D7jZpw9yUD6Z4+gTdklYAThbTIttt4k2UfqEZlViIe
	UoUsN8hH52Gq6lgigLKDUzPzvx6QmcE0j0YmcemIlrqSDOhzQCG9
X-Google-Smtp-Source: AGHT+IF0NVq1f9/xJy8RBVj0v3cRrz80aJ6+K8QkV/fnJ8Rdy5oEyL8uPTB3B+ue7DyC4GX+uDhaaw==
X-Received: by 2002:a17:906:40cf:b0:a44:21db:5f24 with SMTP id a15-20020a17090640cf00b00a4421db5f24mr5861665ejk.66.1709538650544;
        Sun, 03 Mar 2024 23:50:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a42f6d48c72sm4512470eji.145.2024.03.03.23.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:50:50 -0800 (PST)
Message-ID: <77fb1db27c1ad0731fa43852e64e7f9f19c0855e.camel@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Mon, 04 Mar 2024 08:54:14 +0100
In-Reply-To: <20240303121653.22f115c1@jic23-huawei>
References: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
	 <20240301-ltc2983-misc-improv-v3-1-c09516ac0efc@analog.com>
	 <20240303121653.22f115c1@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-03 at 12:16 +0000, Jonathan Cameron wrote:
> On Fri, 01 Mar 2024 18:14:50 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Use dev_err_probe() in the probe() path. While at it, made some simple
> > improvements:
> > =C2=A0* Declare a struct device *dev helper. This also makes the style =
more
> > =C2=A0=C2=A0 consistent (some places the helper was used and not in oth=
er places);
> > =C2=A0* Explicitly included the err.h and errno.h headers;
> > =C2=A0* Removed an useless else if();
> > =C2=A0* Removed some unnecessary line breaks.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
>=20
> I'd rather see a proposal for dev_errp_probe() than a local solution.
> We can fallback to local solution if it doesn't meet with approval!
>=20

I was kind of expecting that already :). I'll propose that for device.h. I =
guess
a simple macro should be enough...

- Nuno S=C3=A1


