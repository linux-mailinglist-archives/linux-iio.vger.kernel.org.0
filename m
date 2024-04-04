Return-Path: <linux-iio+bounces-4051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB2E898482
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109E128BB1C
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942F874C0E;
	Thu,  4 Apr 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJmGjTmK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D559B7F;
	Thu,  4 Apr 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224785; cv=none; b=bIPhb4jH8iswp8KZWq4LBM4obguVU8AKj4hqQCATuylhDloLiBupGAuG/11XYJa/3w591t6B/akbCVMYJUcvC2SUV9ZRCHq86x5dcit2HSIShqZsmWLThLfCYieBk0/Vc+lvhG2ovpO8WAMmOnsM5XtkysHtqbnGZUzPe8kfY5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224785; c=relaxed/simple;
	bh=K9jyeAW3b9xiehY1R2atVc4L81XP/EW9P/MrHMwolt8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oungqvleW9mG5FIbUL7zy+jEiv6rCllNcghddWsoTjMY7UKYjk2j/51GFI6wfsBMrs1fF4sLfyDvosfwhMXNBjMa3PrIFV8AxCnUS4yOmWnqvNgA8cgoiOIc0Hvl/kq5zJ+eEICuXh0O4Es+yWZwJuBcbgIpe7wveE2wev6SprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJmGjTmK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e25afabaso1096066e87.2;
        Thu, 04 Apr 2024 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712224782; x=1712829582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K9jyeAW3b9xiehY1R2atVc4L81XP/EW9P/MrHMwolt8=;
        b=PJmGjTmKEHdX7zsY7H1xSEMx/RSuwIY3ngMP+GfuPDOLiqyVktwmkGTNiM6mpUW9BM
         a0AUDHcYHz4BQyg5g+BWVf/uB5u0FtmGNc3ac8rYcMMtnekobvuE/j+LwQy9ZeFcHmQK
         wGnFiupv9BmTVhPbTx3U7X2H1JKNL1stVjI5c/1lqWWXAwdns3rOo2ncrjVbPeTLpwLG
         X+ioJvPGYGZTGW+fW33ToDiZw/LFScz9R4IKtG+rkOFo0QS2DHHunJe7/W0ZX5BggtMw
         GA/s3JvzN1NwA8dKVo1qfVNNuwx0Oh4H94JOleDBDuTecU0YWU7Vi77ZPztM0FhzG0TM
         65MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712224782; x=1712829582;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K9jyeAW3b9xiehY1R2atVc4L81XP/EW9P/MrHMwolt8=;
        b=ePxxubynpI83A8RmUVTqBVTGQ/w+1VY55HOWQccE1xDxD43mK9EtuXl/2md1ZmQoeG
         IXJiCJ6Qo2EU1fN/jNb80ht6RhEACnvyDc7uMcPJMmpyk3VhnuHB7axCP9fVMvUsLpNO
         yNM/R0FblpGVGbpHTS+qIxTdVxEoje7vgaE8Jl7G7jf8UPcf8mSOeQkXyFQ5RmD/oous
         fy7HHw60t9DbyEuk24wljetsb8OwQP6q6VlP0JdRrp4N49rnrnHsqTmrzKONlne//FEX
         51utDFQDfvVguiGJpFrBhfQmkUfrlkroxE4paNSlilAWPa+oj52PPcB5ViPmT4VJd9FF
         597Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGHy8mmDcSnaBYilHlqwbfqXO3dTbrLz/CQf7WbwtmHcxrynClBqyehmaPQOwIokUt05KqpDIpLx/Ugbmwb7qIhllTOSocLa9tVw==
X-Gm-Message-State: AOJu0YzBiaMmOAWdgImglDqGFe6rrkuuxwwi2stpDm/+/ggd70DsKhfB
	ZuoLS0DXse2EoAFMh8iaETnDRH9Qhq+rYrfd23ATqG8UJ4cUVDzT
X-Google-Smtp-Source: AGHT+IFN36OpGXEpf40sX/jBo1J3scSd6dmPFlGB9m5JLDeVagOQuG1BK8CZpTs9DIMJPjcTjgufgg==
X-Received: by 2002:a05:6512:3683:b0:513:c9ca:1333 with SMTP id d3-20020a056512368300b00513c9ca1333mr1364876lfs.22.1712224781472;
        Thu, 04 Apr 2024 02:59:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id qk11-20020a1709077f8b00b00a5189707091sm634063ejc.154.2024.04.04.02.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:59:40 -0700 (PDT)
Message-ID: <04e2a0569953792673319f7fcab3fe03e6670c03.camel@gmail.com>
Subject: Re: [PATCH 06/10] dt-bindings: iio: dac: add bindings doc for AXI
 DAC driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Dragos Bogdan
 <dragos.bogdan@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 04 Apr 2024 12:03:12 +0200
In-Reply-To: <20240401135948.GA349128-robh@kernel.org>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
	 <20240328-iio-backend-axi-dac-v1-6-afc808b3fde3@analog.com>
	 <20240401135948.GA349128-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-01 at 08:59 -0500, Rob Herring wrote:
> On Thu, Mar 28, 2024 at 02:22:30PM +0100, Nuno Sa wrote:
> > This adds the bindings documentation for the AXI DAC driver.
>=20
> Bindings are for h/w blocks, not 'drivers'.
>=20
> Reword the subject to only say 'bindings' once.
>=20
>=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0.../devicetree/bindings/iio/dac/adi,axi-dac.yaml=C2=A0=C2=A0 | 62
> > ++++++++++++++++++++++
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
> > +
> > +=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 dmas:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 dma-names:
> > +=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: tx
>=20
> You don't need *-names if there is only 1 entry.

Looking at the dmaengine code [1], it actually looks like I should have thi=
s
property required, no?

[1]: https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/dma/of-dma.c#=
L270

- Nuno S=C3=A1



