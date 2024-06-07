Return-Path: <linux-iio+bounces-6005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6349006BE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B281C21A96
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A9B197501;
	Fri,  7 Jun 2024 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1RNTIOB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE92D200A3;
	Fri,  7 Jun 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770873; cv=none; b=Y/15B7/b9CgmNScgLz5li0ZHjhr6+lhTk06L5p1JJWdEkGq5cPA8v3HIQtqiOKVHvbES/h/5xt6iH/Fq1n5FxRhzZtsD57eVJ5T4NMkopdv1fQLt7NhG8Tn18unXE+VjzFjjf9F7vLy6bokwG8LeXHtOxOJ6NYOg/+A0UiF6BIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770873; c=relaxed/simple;
	bh=cnnYd5m2ArsCycTJj1DxblykVYo1VC6wdp6i45nmPTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaWab3DnjVvzilmbDd0BDe4j8rdy+EhD3nzXsQEdngzaJuUMSFPoQVzJdENzBW7Hosa46J8t+uR6m5FUlmFEcojf+p2TZZjea6rTB5a6zTxLXxaogwLbFObU8arj4VJcylqNsmx29kdDt6cm3pyZyRcPbxp8rQXH37+77YOUkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1RNTIOB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6342c5fa8so20599035ad.1;
        Fri, 07 Jun 2024 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717770871; x=1718375671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwXL8/J+tP0wrT7WvCf0jeJwdoVKz2SX/NBpyyFkrY=;
        b=N1RNTIOB7vBLpqW8dCMkYba+abB8uyQbUTWJbZ2wOuqrG8/rUe4ONRuUns21WGV/iA
         SMrawYVibVWj6EPSKJTAid5a0BwUNor2poJgmK5kK1k0mBmjG0mre07irr5pxo5BskLM
         rAzjpYZ5Y3mFe58UFXvhuFSsiF6LnK+Ihxwl/oVdbnS584LuFuG6P9pu+m8Z3V1PwC3+
         jcn4XuhMVxH5sPtyKLJy6UgQdrxidNbKzrbXELI1BYoVtVD7tuIOqHszHE2C3SxpHWeG
         V42FK73kdN4r5BJe9wi7adSqSbFMQa1uflrD6a+2hkAktVXKcrIjTnVyC/O0UUbK7k/Y
         xIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770871; x=1718375671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwXL8/J+tP0wrT7WvCf0jeJwdoVKz2SX/NBpyyFkrY=;
        b=Zqi1J3aO3I3taqfOAU+cbqV9Mi4kKxyLw9jsJ2mvKRbKdM7YbFYkpelN0vfDbhYp6Y
         Yn4QyA9LRza84rCG7TPXACQvI1ToXPW6V8NeZg4hlH93AoQynZN4W1yiuuOJ9qA7cjYw
         7pCT5oTzLcykmT0o/tqCZa7PPOQZhejv7hSeSoyA0KZnLkiRJoPS/HUGYvnzcE3OJiox
         3e6CUkRs0tPz20H/p05/t9SFaf8WycpU1a0ZyUh1vt/oYXIMd2HicO7EgN8W/27p/Bkj
         ravztiltL94QML8RfoiXFdQvhcfsoutrONblDhkBLvvJ4C0u3PtndmQxBEeWcjGNhjwD
         d1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVWWEGSyexxqbnNuJtBmNquT+wKKXR+iGobNaqyQ+DKFuSmeAl1XwPoLwQ05e8sBr0f72A3AVJ4JHl6988tqXCAENcee/tjrl2Mnr/m7a1u7eBkhS+39oDHVutD/jLffSWptZsJ6LELYcGgHaeru4T757SKT9rfTS5wcpOWnrqAuwHaXPUg9cLxzFKBzV1MlrpnAkxNmycVvE+B4Mb8fQ==
X-Gm-Message-State: AOJu0Yzq4T4XoOWLp+2/Ayyy68e/LEgARWNI5UtamTngsbYNdAttG5ub
	k+G0PT4WJbkbYoeXv9OkrUGlH2wqSKBRnk7sq9z6jXmxC/RJ8hrE
X-Google-Smtp-Source: AGHT+IFBuFNnNoOg5VXkoWL5DDNAFWfRM3PNY/nvnUz6ORM/wkDrb0Pq2N4YdoRWhkN4w/Iufs79Qw==
X-Received: by 2002:a17:903:32cc:b0:1f3:50e7:36db with SMTP id d9443c01a7336-1f6d039d409mr29686475ad.48.1717770870875;
        Fri, 07 Jun 2024 07:34:30 -0700 (PDT)
Received: from localhost ([2804:30c:167a:4100:8407:a7e5:9b87:8081])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f466sm35044735ad.57.2024.06.07.07.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:34:30 -0700 (PDT)
Date: Fri, 7 Jun 2024 11:35:44 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] dt-bindings: iio: adc: Add AD4000
Message-ID: <ZmMawAukzpOcdJqy@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1717539384.git.marcelo.schmitt@analog.com>
 <b8a211e09c17f5a9f0a6aa6e11d6375ff398c918.1717539384.git.marcelo.schmitt@analog.com>
 <20240605-tables-pectin-66d4d4dd12b5@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-tables-pectin-66d4d4dd12b5@spud>

On 06/05, Conor Dooley wrote:
> On Tue, Jun 04, 2024 at 07:43:53PM -0300, Marcelo Schmitt wrote:
> > Add device tree documentation for AD4000 series of ADC devices.
> > 
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > 
> > Suggested-by: David Lechner <dlechner@baylibre.com>
> 
> A suggested-by on a binding? That's unusual...
> 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Even though didn't pick all suggestions to the dt-bindings, I did pick most them
> > so kept David's Suggested-by tag.
> > 
> >  .../bindings/iio/adc/adi,ad4000.yaml          | 207 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  2 files changed, 214 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > new file mode 100644
> > index 000000000000..7470d386906b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> > @@ -0,0 +1,207 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4000.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD4000 and similar Analog to Digital Converters
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  Analog Devices AD4000 family of Analog to Digital Converters with SPI support.
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4000-4004-4008.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4001-4005.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4002-4006-4010.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4003-4007-4011.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad4000
> > +      - adi,ad4001
> > +      - adi,ad4002
> > +      - adi,ad4003
> > +      - adi,ad4004
> > +      - adi,ad4005
> > +      - adi,ad4006
> > +      - adi,ad4007
> > +      - adi,ad4008
> > +      - adi,ad4010
> > +      - adi,ad4011
> > +      - adi,ad4020
> > +      - adi,ad4021
> > +      - adi,ad4022
> > +      - adi,adaq4001
> > +      - adi,adaq4003
> 
> Are all these actually incompatible? I'd like a note in the commit
> message as to why that's the case. A quick look at the driver showed
> that the differences in the driver between the ad402{0,1,2} are limited
> to the "dev_name". Same went for some other devices, like the
> ad40{02,06,10}.

Yes, that's correct. Some chips only vary by name and max sample rate which
boils down to only having a different dev_name in the driver.
Can those have grouped compatible strings?
dt_binding_check fails if curly brackets are used.
properties:
  compatible:
    enum:
      - adi,ad402{0,1,2}

The groups of similar chips are:
AD4020/AD4021/AD4022
AD4003/AD4007/AD4011
AD4002/AD4006/AD4010
AD4001/AD4005
AD4000/AD4004/AD4008

Thanks,
Marcelo

> 
> Thanks,
> Conor.



