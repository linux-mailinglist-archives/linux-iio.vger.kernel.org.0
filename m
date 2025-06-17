Return-Path: <linux-iio+bounces-20737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD09ADC65C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0881216436C
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBB293C6E;
	Tue, 17 Jun 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7KJbSIC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AD293B53;
	Tue, 17 Jun 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152508; cv=none; b=Mrk6WbQjIJe4CIA2ousmkWUIedXcIME+XH8SkK9Jd+NQXPrOLZrRwFHWelL1thelZQeC0tVFFHBt7ramRjJMGRfidH7PPhsOflOz62sZ33Hcx9pCtDqcFGukOiPTLwpXLM+ZOHMIxrqyq2EqmtBcW6WCkLNPDx6sfSTxkNz/lWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152508; c=relaxed/simple;
	bh=Q5fd04hqWSCGDEzHOkzetwrrFZNmS/QF+IyVMo8AaK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SRk8lC2NIe42nZDoQzLTUE2MqcaSIUJMyVwt6huefJ5qFy5dCqQ9K5TrJ/0lWcWK76aAWUSlbbOQhd8CIfINIufbjyRK9Y0NcdgRirKn316O72HlnjlBbAOh4fqoxBWIFzaWLq2yYGEUnqUTMDqN7gBKIw1IqMAOyLAa/TwMVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7KJbSIC; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e81881bdd55so718800276.0;
        Tue, 17 Jun 2025 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750152506; x=1750757306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gALTqNQrj90wQMFVEUTnuyFeDr4GZi/SD5mn5GfukAs=;
        b=P7KJbSICWReIJutj8Q447Uisi/eY9mDBt/rX35mXu/U+mx5uFsQrb2V5w4Zwb4ghJu
         SIR5aUdPWKBHdBGcUsyWTLHJ/VqpTjLa4Z2THi9OHMX34d1EPXg5FhI2mAejE6Z62WDW
         l7u6v/24E7xrQW0w58biKRD8wyiL+JYjg8R7/kTLmRaWogXiAGcKIoaR8rHWPSL2uKLv
         Qc0bIHxGG+bgm7HspunnCIsa0yjfGRBSt0Asuzj/WUQ8xtKXnrSoYbh5BzmPKHCfvFqt
         aZZpdYyVkUU7oGwMKqDPfLkQmmr6bVtSx1P73nwbT0gBDLjjPzB5Jfrq829F2/mBN9Q/
         sg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152506; x=1750757306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gALTqNQrj90wQMFVEUTnuyFeDr4GZi/SD5mn5GfukAs=;
        b=vPXHS3RU6Ee/oerLz7MIEJ+SmOE4Q9ESE1xQ7Suqz0xs7AwPZrZtBotoJA4d7lSpiz
         ERJHTHq/QS1Cv36Lgl+xjKEPSWLZL4CNo5rxyJ0L9WrhB+/LXAZJsQ/ggkGKTgCCe5i1
         bk1LG/KjBGL6Z8lrm+ZhPHWhHcvrs4/fbp8jolguO/j5qn249Z1m71clTdWmR9BMx0ie
         /qWcniGstK9YxblQFJ0TBql1tnij1VFzXfhjJkA2kq8UxrI2BygCivmv/8Vf/PbKTnL+
         ISq7+A7JZELER91n8ksoxq5+mCEzsYrcXwobALwwE2xew3+AtjhzsO7MWxbCYqzw4wlE
         WVaA==
X-Forwarded-Encrypted: i=1; AJvYcCUJAMMcqN+FCK8Q/6qRPU1Q0+BvnHlliUK2GHd1IIs0L8f9eGxjJiEgFp6bBPMtYOLHkfCFqALlc6Ai@vger.kernel.org, AJvYcCVtmQPfvGkHP9u2/B8V11bLVt8A5A0FPyM3duGGn9MysDgF4lyYz+ESQPDQEWN7940akgz3to5PEMA7SJ4d@vger.kernel.org, AJvYcCVwo+E8703cFveWx5fLnwohqzaeR4y1GDapDpv4gKOFEJFNHzcjcs59Q4tvXojbk2OppAuDXOeLFZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf8rV3OwUuH55VPuhlXe5Bsg384EQSMoKicwFsk2T9x3VUmjVh
	d2wIHjX2q6DeqK1s75iwaqwRZI1f+NA22BcfCwGZpUHI/O9Ryg+tUYk9Jr/OP1qJwTTqHI1lC5m
	zSP5EG2ljr/vcM6ELdClIcslLwjStSRs=
X-Gm-Gg: ASbGncuhRfiMDWq3zvvUHKbNQGLgRXd0qc4+csSPhtIiV+U7fat6PUCsRrxOUXywMGx
	hNmLCJpylRK22tBsg6PLEv2Rgf5ILykVn6wBJ5aC78XSA0sXswrBFTjUsDThG4D5ZL/d9vwKf2z
	OQ46CeiTivMQ70ah+sXjvVDZN3lIYFXZDPqnr+Eq81HhQ=
X-Google-Smtp-Source: AGHT+IGfEO9KKif1fDX3wWrW5gIl4x+KT/D8NnLSgBbamSDflf/3JpdAOEJzp96RWvwMj+B2D/u2WRFgO85wbi8Vcd8=
X-Received: by 2002:a05:690c:1d:b0:710:ee89:d34e with SMTP id
 00721157ae682-7117551588cmr74852627b3.8.1750152506329; Tue, 17 Jun 2025
 02:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-4-l.rubusch@gmail.com>
 <CAHp75Vf6sLfVrN30divVqPBnJBQsU5b+SY24yC2PJuuTmRQ1LA@mail.gmail.com>
In-Reply-To: <CAHp75Vf6sLfVrN30divVqPBnJBQsU5b+SY24yC2PJuuTmRQ1LA@mail.gmail.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 17 Jun 2025 11:27:50 +0200
X-Gm-Features: AX0GCFtdtyrQdB3K0tsd9fV7juD1I_SYR0hG_EI8QiCnyXtYFHZ8_2mUhT98E2Y
Message-ID: <CAFXKEHan_NnmMUfuy9cyjgBsdFK+C6V7eVxq_V3--afzQYGDDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, Jun 16, 2025 at 11:33=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.c=
om> wrote:
> >
> > Cover the following tasks:
> > =E2=80=93 Add scan_mask and scan_index to the IIO channel configuration=
. The
> > scan_index sets up buffer usage. According to the datasheet, the ADXL31=
3
> > uses a 13-bit wide data field in full-resolution mode. Set the
> > signedness, number of storage bits, and endianness accordingly.
> >
> > =E2=80=93 Parse the devicetree for an optional interrupt line and confi=
gure the
> > interrupt mapping based on its presence. If no interrupt line is
> > specified, keep the FIFO in bypass mode as currently implemented.
> >
> > =E2=80=93 Set up the interrupt handler. Add register access to detect a=
nd
> > evaluate interrupts. Implement functions to clear status registers and
> > reset the FIFO.
> >
> > =E2=80=93 Implement FIFO watermark configuration and handling. Allow th=
e
> > watermark level to be set, evaluate the corresponding interrupt, read
> > the FIFO contents, and push the data to the IIO channel.
>
> ...
>
> > +       int_line =3D ADXL313_INT1;
> > +       irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> > +       if (irq < 0) {
> > +               int_line =3D ADXL313_INT2;
> > +               irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> > +               if (irq < 0)
> > +                       int_line =3D ADXL313_INT_NONE;
> > +       }
> > +
> > +       if (int_line !=3D ADXL313_INT_NONE) {
>
> > +       } else {
>
> > +       }
>
> What I meant is something like this:
>
>
>        int_line =3D ADXL313_INT_NONE;
>        irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
>        if (irq > 0) {
>               int_line =3D ADXL313_INT1;
>        } else {
>                irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
>                if (irq > 0)
>                       int_line =3D ADXL313_INT2;
>        }
>
>        if (int_line =3D=3D ADXL313_INT_NONE) {
>    ...
>        } else {
>    ...
>        }
>

I probably got this wrong. I interpreted Jonathans review [PATCH v3
06/12] in the above way. Anyway, I did not read his second phrase. I
agree, flipping if / else case and going by '=3D=3D' instead of '!=3D'
simplifies it.
   ...
    > +
    > + if (int_line =3D=3D ADXL313_INT1 || int_line =3D=3D ADXL313_INT2) {

    Why not int_line !=3D ADXL313_INT_NONE ?
    Or flip the logic so that you do that case first.
    ...
https://marc.info/?l=3Dlinux-iio&m=3D174817641830144&w=3D2


> Obviously with a helper you can unnest the if-else-if above.
>
> static unsigned int _get_int_type(...)
> {
>     if (irq > 0)
>         return ...
>     return _NONE;
> }
>

Well, indeed. That's definitely the obvious simplification needed
here. Thanks for pointing out.

> --
> With Best Regards,
> Andy Shevchenko

