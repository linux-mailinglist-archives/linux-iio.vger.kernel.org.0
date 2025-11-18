Return-Path: <linux-iio+bounces-26296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 639DEC6A50B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BE381528
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA27C31E0FB;
	Tue, 18 Nov 2025 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfQge2Qu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7523EAA5
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479850; cv=none; b=Myn0Td3UcYbcJDjqMpJ31uMSheA85C9TxYJeH3iQmT6LQDKrJz4iNtxz6jcezDW9p+5tkAOijeXcx0JVQ/NxD8FLD7Ta7alMjJPWDIFi5yLOW/DxYeMxbfbvbSB3VfLgiPHwG1oXUWT+NX23jWgWkMOKUZNca8mE/NJtbjNq/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479850; c=relaxed/simple;
	bh=LD1RNsRdBO+alw1OFuDPZMEsEnycw5QswnLxdj2RvXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkmFSKZSEBN74X32CNEcCldQrxRcxgDX/6mj5ytftHCJTjHV6trqc0UICd4VwFll0MsQkxIF9rOW+JqZura9bcKub5jqqf6Nk9v4jqPefrMH+cAXSrQRqFcSaCFqk8ijMgurI1Ybuggit45shzWxIWgxt1vdWS+QWyohLvDwuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfQge2Qu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7277324054so784492566b.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763479847; x=1764084647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD1RNsRdBO+alw1OFuDPZMEsEnycw5QswnLxdj2RvXY=;
        b=YfQge2Quv9BfKjHcdZSxTy9UaGhg4uv2TsG2b0bm+T+MJZSu7EDpoNk6cT0k+0MTTk
         jfgvBz94DFoRyDbucMDwWIhcigP6DajSFvodbaHFbvKwb8HFLnVQ8NnohRzHLGiskt64
         ppuL0k1GQE9o3G4eHBYOrQmzqrQJD6HAdE1PZ6MyWSd9OFUZmQ8AjkGqNfdBU/vUIQdO
         LAEW904VTRZmU1KgeA5SAEmZNb7xxZ9WkHs6gqCjwPe3OtHI4ot/uqlV/CBBJ+Y29BtA
         q0M4Uj5C/pkS571s1/9ch9u9+/LoFlezx+sjHBIVeU3BaTt9ePe4m+VzcZkG5GgG6/da
         k7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479847; x=1764084647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LD1RNsRdBO+alw1OFuDPZMEsEnycw5QswnLxdj2RvXY=;
        b=lWKawbUAd/IdExZom2EMtJnk1jpsuI78kZVOBkVfZGAxM7agIAe9jp7HYufSOeghgW
         acyjYY8Mg5bYdI+pmOGoIzXko4jy0uKH9GAgh+bloilFsuFbQpDV+Ry0+zIoENwBaNIN
         92YLOE7x0NanM78zL5yZBZJprqMsgCDJR3WSqzjhK4pLqiKLCt8tkDT2CACYiCL5WsXn
         bffnyF0jqOT/i3RBk0oa3Z5ABoy9sneUAUYCpzLkHrzqe2/6GPJOVUh/64PssR5EzZAw
         Jo1rFWkc64YPrpYsxlYf4TyVfHtB+FMqG6Oh/S0C0I1Zj5e4QvQrNTEteRFvx807xWXr
         9RPw==
X-Forwarded-Encrypted: i=1; AJvYcCUKKZvCg2q9n9Z/3bk2AH9eFygzZSFsqsHjiku7JTpeqPp5WK4H9LPomE101I8VKpgUg46jb/J80OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDcNnYuNoo7BsQMmt180PYlOnK88fg24602qCIZpAJLH+NqHi
	lBPJZQYXapSTv5J31ihaGeUCbYK8v/3dy6ZZrEYaYPZ8LIuhavMuk5nWwgRRIzRs3G/VY5RoSAj
	RlDdB1FZ+rWEUW9RsL1I+fo/h7UfbKuw=
X-Gm-Gg: ASbGncsocDNcbqmySECdmav6oYJdnansqWol5XwwSSqhLHIISKQCm75fWFfBbLw4rFh
	bMye0c56iGwhepou2ksqCqqUAjdNxi/ncnw+2/mDvN7lgllA6o0YX4p8m2xYnvKWJDbOCaQU2w+
	Ch/+3SJ26bgkKV3ts9obqYPufMpjnyzR/QAetMFasefG8rtc7mJ0tqFTijZkSLUpBkwGoDd0BZt
	MuI+JlC+Artndf/17hD+wxtQlBCYAB74x+EjFHlv49QSUyPFuCd7wev+BF1zEUVlVekastwQsju
	eYVKQzIl2kvUEXjO0jmLaFRuJ8/pNZsr9Y3vPZK9gl2vdztQJMQ0EpzfmfNjtTVWOsQvQ3s=
X-Google-Smtp-Source: AGHT+IGWpsrb85ZSHDvhqFhXkcNk4LqoFezhAeLbRqOHg6421xZpUNNlQdix/NPAy6sJUWa4lmWm04OMjn/hoN+vbvU=
X-Received: by 2002:a17:907:a44:b0:b73:544d:ba2e with SMTP id
 a640c23a62f3a-b736780d5bamr2009214766b.25.1763479846581; Tue, 18 Nov 2025
 07:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-ltm8054-driver-v3-0-fd1feae0f65a@bootlin.com>
 <20251106-ltm8054-driver-v3-2-fd1feae0f65a@bootlin.com> <aQzHtqFEIA5E0ikO@smile.fi.intel.com>
 <2330439.iZASKD2KPV@fw-rgant>
In-Reply-To: <2330439.iZASKD2KPV@fw-rgant>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 17:30:09 +0200
X-Gm-Features: AWmQ_bnZSB0YEOBpgzP_FKfC7e3gD1rFv6KShtEMJF-pnBY9w3EnieGPUK0dXqI
Message-ID: <CAHp75Vd8x0MydzuEYFM7aaiaO3igF2NjJ_aVTfWVKUoQ-q21Fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] iio: add processed write API
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 5:16=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
> On Thursday, 6 November 2025 17:07:18 CET Andy Shevchenko wrote:
> > On Thu, Nov 06, 2025 at 03:11:47PM +0100, Romain Gantois wrote:

...

> > > +EXPORT_SYMBOL_GPL(iio_write_channel_processed_scale);
> >
> > Can we start using namespaced exports?
>
> Sounds good, but won't it look strange to have only
> iio_write_channel_processed_scale() use a namespaced export?

Nope, somebody needs to start this mission, everybody so far has this
excuse :-) I think now it's time.

--=20
With Best Regards,
Andy Shevchenko

