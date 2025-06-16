Return-Path: <linux-iio+bounces-20699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5659FADABFA
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C793AD600
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16C72701AB;
	Mon, 16 Jun 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7I4l9TH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E441DDC0F;
	Mon, 16 Jun 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066394; cv=none; b=q+TyDNb6l4mc+h7CVdMHNz1HvCA1HKV5iZIhdIrMHfZnfaasVJvE6fsaKu47STdbL9oJ6J9AanML2J4q2bJ50uo7jIogXpTBU2jIqUrkBjwlWi8ZghV6l+A1YPG1kR/dNhHF6GeK+PigtuK0Fj9D5h4C1LCWD1jxpQ40XfLb74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066394; c=relaxed/simple;
	bh=R2yIrcXycoCUxxScMy5qcpcr+BhPs/KI8VJ7VrmcLQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjSN8CrqIqH7O2Hv6Ky19UojHcKs2EEy5kATHBjwM5TamHwLspeUNO/e0irHBeE2lFxYKdsJI/ln09OXQgeEYlCJAPfUeeiL9vYIGernIbQy00b/PtOhm41enbIE9ZHQecHoXBykZ2nvwg/aVkDNa78e8cDC3Bu+bZJSbIkACgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7I4l9TH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade4679fba7so786190466b.2;
        Mon, 16 Jun 2025 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750066391; x=1750671191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkGJwp2RoQ+jWjLu1zMRoE5ZwRMf6mY4ff0wI8TjPns=;
        b=K7I4l9THtXQd8LZ4JeIW49uYCEWitfhv6XgmUQ6+QonKMDJpmIJsYPo129vc74XpgP
         HX4IPlJDw+p06VHFe/8fZA7jEwNyb4cAWZYT971lEIFnroY10MJvIf0HcjmiBG3GcFgz
         rwCuQYGm5W9q/02J625zfrC5o7gElThS37Be2ChTzEoOdHh5sHtqu/0vpXQk0IS43fEp
         ys9ri9aZxtUfZNF0JpgVNHRTpcie7aXInGAIqwFQHPMcs4oTjKF1HRe9ZIKrZ/tawsxW
         s/U+xwAH9ur4jdU4l74ph6xe6+VQKkp/oEdjOpusctPvaXoIx8Mw65z8bFW+UzilO5mU
         v4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066391; x=1750671191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkGJwp2RoQ+jWjLu1zMRoE5ZwRMf6mY4ff0wI8TjPns=;
        b=Jo88L8PyPcxP+px68HT/e+6n5CFslSItlaTmd3BeGFs527ORu2cCff+d2TMDRL1Qog
         PK+lBMkle+i8UASEmIeiBURJ7c3d16e4H+tZ0EyPHTpDVyNdVt8PdTNr8/UBpUxzqCED
         3NeDaV1YH3Mpe4lOC4fPROeFH0MHFl3t1wb12o5MHSKxWplbF1cTTo8eNHNaKpg4iZjv
         p1iuymY+muMvv78H2Je1MnNbVif9R3hAHlgh6GsJxhM0Xv9IvWDJ7eQpaJ446Fcmsrr1
         dDV66NEnPu6OT16ncevVl0nazg8WI541pajTC+PXgd//ZxQ1Y10kNap2cEq50KUWulDj
         MB0A==
X-Forwarded-Encrypted: i=1; AJvYcCU8DHSt0IQLu+IPaG/PQWawXejk8aPoB02Ea9acvpF90qJWs6lCWKxvtYeuCokA0052uSySteIFZTA8@vger.kernel.org, AJvYcCWHzkRYLOCyz3fwcl4HGLCiA8hWck7kdHxfM7DBrzP96Jg4KYFXkOCnozlB+vAwMvUQoi4NdqGpn+u3rxzk@vger.kernel.org, AJvYcCXnlndwwZ0KD/AMArdiOMQRWrRYyew0Atd8UoAu2mfgA3BLljc3H0//4Rp6h2g3ifxCzCb+7+0GAjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlc80E/3gxm5bgl3KBkjfLS/du40GP//HrbiH+nqufAM6oMw01
	ftSM1hIvc/TWMSXNT0LVDwjGIOoNoHZT6Bt1GD14cDclZM5H8sv9pwefTDD8+q5J1Qv5r6RDwDf
	m6HaC5mvvosebSP7ZoS/BFJocQusqdGk=
X-Gm-Gg: ASbGncvBMxoSlM0Qm2BQGwyCTx1iiVSPMu4QIcTKeMryUOcayYSgR6v6TvgKfeSSLzO
	mNlX3wLXejfWcZEj+G+8GKAwY+HXXx1tso/Ew2ZKJ5XnbXkzXG+enH/qoqG61Y1U5gVNq/7So00
	h6BrdfusnvsHH1xH8H++v9zghPhsd9FOeaqzhSGP6VN1fK0w==
X-Google-Smtp-Source: AGHT+IF/mA/tfJexBE7Au+sfy1uhQXqGryFkvagI7k9KCcNqaZYqAddXRkiouesuvwXzRcCD8Bg/BY7kav9XbiwIOEs=
X-Received: by 2002:a17:907:3e0b:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-adfad54b342mr828310066b.31.1750066390836; Mon, 16 Jun 2025
 02:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-4-l.rubusch@gmail.com>
In-Reply-To: <20250615222258.117771-4-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 12:32:34 +0300
X-Gm-Features: AX0GCFtjpVUjSL5JM2dxqkTAgstR_do_WoAPRkPm6xwllX8Ew4kF3WXVLvk77qs
Message-ID: <CAHp75Vf6sLfVrN30divVqPBnJBQsU5b+SY24yC2PJuuTmRQ1LA@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] iio: accel: adxl313: add buffered FIFO watermark
 with interrupt handling
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:23=E2=80=AFAM Lothar Rubusch <l.rubusch@gmail.com=
> wrote:
>
> Cover the following tasks:
> =E2=80=93 Add scan_mask and scan_index to the IIO channel configuration. =
The
> scan_index sets up buffer usage. According to the datasheet, the ADXL313
> uses a 13-bit wide data field in full-resolution mode. Set the
> signedness, number of storage bits, and endianness accordingly.
>
> =E2=80=93 Parse the devicetree for an optional interrupt line and configu=
re the
> interrupt mapping based on its presence. If no interrupt line is
> specified, keep the FIFO in bypass mode as currently implemented.
>
> =E2=80=93 Set up the interrupt handler. Add register access to detect and
> evaluate interrupts. Implement functions to clear status registers and
> reset the FIFO.
>
> =E2=80=93 Implement FIFO watermark configuration and handling. Allow the
> watermark level to be set, evaluate the corresponding interrupt, read
> the FIFO contents, and push the data to the IIO channel.

...

> +       int_line =3D ADXL313_INT1;
> +       irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +       if (irq < 0) {
> +               int_line =3D ADXL313_INT2;
> +               irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +               if (irq < 0)
> +                       int_line =3D ADXL313_INT_NONE;
> +       }
> +
> +       if (int_line !=3D ADXL313_INT_NONE) {

> +       } else {

> +       }

What I meant is something like this:


       int_line =3D ADXL313_INT_NONE;
       irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
       if (irq > 0) {
              int_line =3D ADXL313_INT1;
       } else {
               irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
               if (irq > 0)
                      int_line =3D ADXL313_INT2;
       }

       if (int_line =3D=3D ADXL313_INT_NONE) {
   ...
       } else {
   ...
       }

Obviously with a helper you can unnest the if-else-if above.

static unsigned int _get_int_type(...)
{
    if (irq > 0)
        return ...
    return _NONE;
}

--=20
With Best Regards,
Andy Shevchenko

