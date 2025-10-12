Return-Path: <linux-iio+bounces-24991-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EFBD08A8
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 19:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20AF7347F6D
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61392ED860;
	Sun, 12 Oct 2025 17:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i10D8LAz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB321767D
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760290651; cv=none; b=KgkCB0nmtnpkJ4KuqA7iSpqsSv9m2ncJt2r3GUiDR5OXglQTUIPubpiyx/ir7IWzGEeHMtCk7AT+oVIhvsG/V1zazzfWdftRrFdGkFewpSbugzGBDZIrL8CCviCNKQzrA4xLiImc4qSTKIDEiayNVO0ngsLKVkxexWvj/DGjpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760290651; c=relaxed/simple;
	bh=wQf6CUx6iYNtn0zMxIL285xU6GTttxgQB+eMaEn+Nqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzWYm62JCEDOHgl3lDTvdulRm50oDs62n72xL5rbcWfM/f9TXgbL71HQ+TPa5Kjq7ZpgHKNs7d/Mh69nvX33jVq/vLLfOIbnTrShEk2X4h9Gopg/BQ+wgijb2q6xhzlZiBmM7HJxWcl3sv0x5J6UQ1Kchqr1t+0ISvQJVdjnnl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i10D8LAz; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b50206773adso834251966b.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760290648; x=1760895448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjN46mR7vmbfRcA2+LhyFdkXLDPT8VQfkzRMb9fR+Rg=;
        b=i10D8LAzgSz5tmgbQycsZnksVhgTLRSff7nDR8WEHKl56VqacKuVViXYgHdLGw7qr6
         +WglBTINupcFWC0WNHYED19lDFMXmaB+X06lxi6u6RHVtSNj8KyNUN891znZsT4CPt7r
         6OJiBZnlZ0G9mb2Rg0GavlyAwlnFKpZByhRKxkKgQ3KeSH1iYH9gKD63n4QCcRp9ZZIX
         WZgc1GdfwIJpjhDur22iGOkrpcG2J6z12LIYodqO+4yAx++Y6pOeDVFIF8Ljg3V4eHLn
         1MwT00JzXl0nctbG2/N23Oqp6W7EWp3tcOQ+9IeJdjGn3n/6oFaevGFb7tbsX6r+fI4J
         STTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760290648; x=1760895448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjN46mR7vmbfRcA2+LhyFdkXLDPT8VQfkzRMb9fR+Rg=;
        b=LvikXrTecGs+F88Zc1gk8bev0THezQHpuJxFIxAEKIMIjHsbggLKUC+6BpqT2g6rTa
         +oRhdYO2zQnGIBa6UK92EWrfzpvsSye6rt1PDKadch6+ovo3/Mz7XcS/HVIkRNAzhp3W
         WvGxLZf4yr/kAjYD4SotsfdSAiEgOiCSEUHRY8uzRiHLj0gsEgf8pJofgC9SN9BsxLJq
         8HBWxH+y6yqEzt1eCRr+m9u9H+2fGAUtvcFv5J+6NRL36FA+bMynRLSDrrZiCGNwYE7v
         aYlLLehtcy9E3O/N57tlG4Mz30nWrhZMfJOjhKsEtve1HZJxSDlnQe4GAvnfaeO+pjIf
         2V0w==
X-Forwarded-Encrypted: i=1; AJvYcCXuFSTNEIiKNK2PQNOHn5lBmQYFP1xxNignWU1nVK67NoP+XmS1vYCQtZMvJdhDqM7WrEQsTXoX4n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKClwPjPgnwdr+wMAEInPnDAggJQ0ICa3NqlFoqSZl6cXpC6Fm
	MxeCjFKb0oSOLNLrDO2mQpoHQSxtB5iT3jDw/Snnr0FpS7hr9Qy2ZcGAszj+goIzSvgwmjaO31j
	vxlyg2XLOlF2bHxPfUCu9JyHJM80TJZE=
X-Gm-Gg: ASbGncvy4dW42mtokHcc0JGiXzKJnvDqRVdkzknuNG/W+Ul2vcNxdk8hjlBnnTLj6rO
	o/2EH/MojRBmUzzo21dyVkWXTkylTAiT6g8pe/d4oaqAh4INe9YaJztzEQPA9J3KKE7/Sn8SIjH
	PANCEM7GSn9hJpUV1KNF52E4i+3HieFY+Pv6jV/NzoG7o1gSMkPoCl9AXLbX9Ct3h8tQ4WeNBX4
	6ZowrimbczCK/sUl+EyMo97GzQolXrHL4Fm
X-Google-Smtp-Source: AGHT+IGFP/EgOGkWxqjUos/OJLXKzFze7OmeAssC7kBZ/7quZxkALgbxBsS2MKonlO9lkxUJo4zvtwxsst0X4NFCXYo=
X-Received: by 2002:a17:906:c143:b0:b40:bdc3:ca04 with SMTP id
 a640c23a62f3a-b50baba84camr2323169866b.0.1760290647947; Sun, 12 Oct 2025
 10:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com> <20251012180644.019616c9@jic23-huawei>
In-Reply-To: <20251012180644.019616c9@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sun, 12 Oct 2025 23:07:16 +0530
X-Gm-Features: AS18NWBpLXveHlQdIhTnFbX7i56JOrqOKowAXbKZ3PnsuA7_QAtU4BLr2PqKRcI
Message-ID: <CAHc1_P4L2oiM09YhewH69GHcVW667b0xW5eeH9+UY0xi2aO28w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 10:36=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Wed,  8 Oct 2025 08:47:36 +0530
> Shrikant Raskar <raskar.shree97@gmail.com> wrote:
>
> > The appropriate LED pulse width for the MAX30100 depends on
> > board-specific optical and mechanical design (lens, enclosure,
> > LED-to-sensor distance) and the trade-off between measurement
> > resolution and power consumption. Encoding it in Device Tree
> > documents these platform choices and ensures consistent behavior.
> >
> > Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> >
> > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> >
> > Changes since v1:
> > Add unit suffix.
> > Drop redundant description.
> >
> > Link to v1:
> > https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.=
com/
> > ---
> >  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max3010=
0.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > index 967778fb0ce8..5c651a0151cc 100644
> > --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> > @@ -27,6 +27,11 @@ properties:
> >        LED current whilst the engine is running. First indexed value is
> >        the configuration for the RED LED, and second value is for the I=
R LED.
> >
> > +  maxim,pulse-width-us:
> > +    maxItems: 1
> > +    description: Pulse width in microseconds
> I continued the discussion on v1 but just to make sure it is not
> missed, add a bit more here briefly touching on factors that govern what
> the right value is here.
I have considered the feedback from v1 and updated the description
with suggested factors. I have shared the v3 patches with updates for your
review.
Thanks and Regards,
Shrikant
>
> > +    enum: [200, 400, 800, 1600]
> > +
> >  additionalProperties: false
> >
> >  required:
> > @@ -44,6 +49,7 @@ examples:
> >              compatible =3D "maxim,max30100";
> >              reg =3D <0x57>;
> >              maxim,led-current-microamp =3D <24000 50000>;
> > +            maxim,pulse-width-us =3D <1600>;
> >              interrupt-parent =3D <&gpio1>;
> >              interrupts =3D <16 2>;
> >          };
>

