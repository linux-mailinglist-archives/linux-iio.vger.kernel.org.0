Return-Path: <linux-iio+bounces-3997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D5894CE6
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 09:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19A9282C3F
	for <lists+linux-iio@lfdr.de>; Tue,  2 Apr 2024 07:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED23CF79;
	Tue,  2 Apr 2024 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXQVclWb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F62E648;
	Tue,  2 Apr 2024 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044269; cv=none; b=Ag7gEi8puCTUBB3StJDlWltY2KQVUpjVFOpfG1ypmscQaaYacgqbGC52QK1ihlUC3cl2y1fc7GGEPNRBnAP4uDP9EBD3OEMDTyP5p1vDk3ReqKB7V7eUbai1JxGcaqoxVt2YPgkHL0HxDfjuY0fluZP2YFUxOf9QqVc+EN/Qjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044269; c=relaxed/simple;
	bh=PjToy/peDSg0ufQRYrTRVDIb82Usl2ipW9FsNdt9a38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QY0EMFw/eRh0DvKC7lUZh6v1VGgn6WWwUZnX2HKinGpT3W4Pbg90uXkEBTLZWKm9aS7mFZYVCwxALkjBO1uiWVOH3FoDG7V2vgl6dL83Xf75+7o/zp/V28D9Q0+GGk2iqy344sL9tXPxoMUzUKdZgk66K183/yHqDSaGoJAHyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXQVclWb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34372e3db28so81945f8f.2;
        Tue, 02 Apr 2024 00:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712044267; x=1712649067; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjToy/peDSg0ufQRYrTRVDIb82Usl2ipW9FsNdt9a38=;
        b=VXQVclWbtDgxp7tTfj+cFR324tHz230vzuc7fhqk6jSDAon+0zLzLExhSb8skZ6s+i
         NfU+X6lR1SkpXXwaOLC7tTvEzxmJ0/xOHT052XTVg8im2pYTrRKQkJnS/sxtKdMzu86Z
         LZBB8LaqkDRiLvc1gHNp1sOa7AKd219pkzNydd5Bv7fqSGXreWSpm7KTaJzwOw5daMiI
         KXQn1/Hu4z388rtBwmSuuVwv9fFy7VGMFvRAyGBSQe+8SuGWEzCOuTpbaRvkCPkuCh+g
         Xhh/sExM2yx9w4t73KV7tXQ2KqR9L9iJYHwRCXX7DLFVtwySJ706W+/96RYnJcGMnhz+
         6Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044267; x=1712649067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjToy/peDSg0ufQRYrTRVDIb82Usl2ipW9FsNdt9a38=;
        b=wIqV/xJQGhSya1WYmTfLzFrRbbY4PLJNLXLg7YxX+T01fo/unAh4+uaKR1wK5umreO
         I12fKpDrSfejFcayPdqJpOeRrx8RkCCHkY8Mma7h8z33JEv5BuYrfLfSPMDhIuT/u1Bf
         ZVeh8zcj7JPsa4IPo5zhsUsYAMqkFkZuoMw5S/t8QwgJi780Y/c48IK22D5Rmzwd3Wsn
         P/GyFUfBQVfP8Sf48vI9vJt08vSVks1K3JwCZLBtS6s9qLlDg67+i1JQRBgXPDqQxuid
         82fBQXGYTixuwHl2OtCIharT3cQ9mkZXaVXt+sOotmSfx/1ZAqGRSIUGNi6igI/hxi2w
         yHaA==
X-Forwarded-Encrypted: i=1; AJvYcCVK79eWm9eHK9zWZaHeZN66SEf8swtaz6uHlnALcZdizxi8l1YgVQVK/mAcMpIwMnasks2lcTfuV9mTBcl8eO/84LHm4stL52riKQ==
X-Gm-Message-State: AOJu0Yz6tuo+G6d7amCFRq3DaAJUOc1bw8fGMy4meJ3FX+TGlHr33qt6
	D6kmTItGd2s4Yk8fYFR21/K/MlQnQDPmQ+J6N2220w4jRmfF/Oqa
X-Google-Smtp-Source: AGHT+IESJIP9HsInMHNYfQuTzthYqubwDx/pL4PAbyebw/XxZOjCLXfnN7uq/Ow2aRj/6rTvUM4i2A==
X-Received: by 2002:adf:f704:0:b0:33e:75e4:d410 with SMTP id r4-20020adff704000000b0033e75e4d410mr7129326wrp.22.1712044266444;
        Tue, 02 Apr 2024 00:51:06 -0700 (PDT)
Received: from ?IPv6:2001:a61:343e:8301:d737:22b0:7431:8d01? ([2001:a61:343e:8301:d737:22b0:7431:8d01])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b0034349225fbcsm6217494wrb.114.2024.04.02.00.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:51:06 -0700 (PDT)
Message-ID: <c780ae7c234f07f599335040f61ecef3d6bca1b8.camel@gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: iio: dac: add bindings doc for AXI
 DAC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Tue, 02 Apr 2024 09:51:05 +0200
In-Reply-To: <CAMknhBHKcy9KO=8vuAvF0twY4x14sFq3FLW4ygORMn2G5k7WSg@mail.gmail.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-6-afc808b3fde3@analog.com>
	 <CAMknhBHKcy9KO=8vuAvF0twY4x14sFq3FLW4ygORMn2G5k7WSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-29 at 13:46 -0500, David Lechner wrote:
> On Thu, Mar 28, 2024 at 8:22=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > This adds the bindings documentation for the AXI DAC driver.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0.../devicetree/bindings/iio/dac/adi,axi-dac.yaml=C2=A0=C2=A0 | 62=
 ++++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++
> > =C2=A02 files changed, 69 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > new file mode 100644
> > index 000000000000..1018fd274f04
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > @@ -0,0 +1,62 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,axi-dac.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AXI DAC IP core
> > +
> > +maintainers:
> > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > +
> > +description: |
> > +=C2=A0 Analog Devices Generic AXI DAC IP core for interfacing a DAC de=
vice
> > +=C2=A0 with a high speed serial (JESD204B/C) or source synchronous par=
allel
> > +=C2=A0 interface (LVDS/CMOS).
> > +=C2=A0 Usually, some other interface type (i.e SPI) is used as a contr=
ol
> > +=C2=A0 interface for the actual DAC, while this IP core will interface
> > +=C2=A0 to the data-lines of the DAC and handle the streaming of data i=
nto
> > +=C2=A0 memory via DMA.
>=20
> Isn't it the other way around for DAC, from memory to hardware?

Good catch! Yes, copy paste from the axi-adc and obviously missed this :)

- Nuno S=C3=A1

