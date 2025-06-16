Return-Path: <linux-iio+bounces-20700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBCADAC04
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 11:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB067A48EE
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B34E272E6D;
	Mon, 16 Jun 2025 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDk62leu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2C1DB92A;
	Mon, 16 Jun 2025 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750066576; cv=none; b=rYAaY54UVEPbMVwB9UUZRe2zVS0cn049ADkYo6K+z9U3ZqT/Pibc0zFytCqZP72A7zxsn0CUcQvP3tK+z1OA5VNs+Cg78xDzZXZsdOj+94pTjseqFqlYucPj49OR1h2EF2h0b03Yn2Ip+KC1KmTFl9V022mxVnVNu8/78wbY8rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750066576; c=relaxed/simple;
	bh=8ZZNaS1EQOzMN3b0pdHsmdCs8AmTvHGhRO2jOKK6SAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKSQXB+wPzSGbCvS6aHa65wtjRdqPSA134tLboqgxIy1ftMbiofwsN4nvOtiH4BFSuV/KUY/23nu8Eh5GK7q6TQvJnK4WZwZjYkhuUozSioGmM2YG896xFZiJtjzpg4wLNHelm9ikN2xecMYn5ABxWcn14h3g+X+YrI+2V/vKeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDk62leu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-adb47e0644dso749490966b.0;
        Mon, 16 Jun 2025 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750066573; x=1750671373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK148dPBVhVoGpVehFIEtiNr6qK0xvYB43T1Ml3zQOk=;
        b=RDk62leukyOGbqpUI7h9n6bxSDobqJi7tMoyOkGYur9HjYTp3PWxCEVCbDKbUF1tAX
         c+NwqJNHLfkXjNihns2b45IVNRhlezJv6ZIq5Gw3Zzn+uIG206KYfukpJVzSrHhAWDg/
         0ox2jexRBVhBXIxPXfOhk5fMoUwbjbum7kmuOdb2tT2rT9cAyRM8EAsozU2mRUlA1VLN
         eESQNWL8jPlUTHWW2O1dSfsGHaqWs46kmtQb/mMFOwfYCyhNhICMWhIsV/YgyXH5iuQm
         w0pSuIGyU8z8X7hXRVNIgDyvecKMpqVqz89OpXNPBJksogbYOU6KcVDYRVoIRKwufsWZ
         y5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750066573; x=1750671373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK148dPBVhVoGpVehFIEtiNr6qK0xvYB43T1Ml3zQOk=;
        b=Mfen3oqG2ph90W8ZyopmDEN6X2XEReZqh0X0LJr1KC4VXtjcT95cOY5buYbo9qeR1f
         0QDZioskNHu/GRZPbZpLBpJVsodMYReMOb6mlmgu0z39cq+XkrBrR1iiYpALcfweXu9r
         SfQL1+JTX7G4gMgmC1wfvYAQ5Twu5B2y45ZHiFCqMQ1maOx26GMeTeUm7/inM1oDWLSc
         ZWjRMiRVwh/YcS6QG+m2rULkemv2/BAWMTD+5E1P+uroxUNsC+U3rDSPh2rKSyllzdnn
         w5c9RxXdzalUy2jUUNdnXCRX1we/N1oefRQ4DQu1DyXwR5ZZLUsRbDy9uE0IGks8YAkI
         xKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8uDSVbtzdCNvyARFNsQSoHRojxMoihir6ms8DY+xQe37O8++tOgnL0wK/+QA2MNeWl1ycje9EMcWl@vger.kernel.org, AJvYcCVoXxfc9/2oKZXaNbIVDAmFCvu7eMTArGczeTMUKnvu8ChLlybkaf2LYcxVuDbfzO/0Milw1bZk6DE=@vger.kernel.org, AJvYcCVtXvKubJVbxT6ciRbZ88cmgHsxQyjNs6aL9+EBb9jbbgClro9s9nrK8UUPEbnZG62chnhg6iLGqx+6Q40u@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TLxF1zYqVpwy5b4k+qN8fFQtcFQhz/3O7Y/QlQQ9rZhxEjfy
	VQS96fQFdpxepEz8232/LB0fxNWlnJlr21iQLIn10K+y2kKQ+3Q/UJvgsYbqvbvTDP6UQ3RPppT
	+sF4XM47PBtjrACPAtbiZznOE5eZG/rU=
X-Gm-Gg: ASbGncuXN0B8MdSUAWrEa1ieWnsLzK9Bdti5IHZ1lXQcVgfIQS+UXoMU+uB5fqqN3gY
	q/rcH+3euw41/th9b/Z0kbCNBquvPd/3oyWgsjN0LLEEg1KiAa1rq4japRPG7rDlj+BGWacpTrI
	MBZlJKVNIE79L8dR5frb6KSLKAbKqbc2iTe3DpW2ycPiaFLQ==
X-Google-Smtp-Source: AGHT+IHS2jVdEw2lFKPrriN00IFvHK0HPmKNab5n4Aj3sgFfyqvoLxbfUMt5O5cFBNEG65or8nvquSAWfJQf2axo7dI=
X-Received: by 2002:a17:907:3d45:b0:ad8:89c2:423f with SMTP id
 a640c23a62f3a-adf4c73201amr987734966b.7.1750066571900; Mon, 16 Jun 2025
 02:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615222258.117771-1-l.rubusch@gmail.com> <20250615222258.117771-5-l.rubusch@gmail.com>
In-Reply-To: <20250615222258.117771-5-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 16 Jun 2025 12:35:35 +0300
X-Gm-Features: AX0GCFuHlPxYSGvUObbMJmIjrtTBb7TtEbQMx7iAhD6LZKz8e4G03Z6dHqiZJWA
Message-ID: <CAHp75VcOFK03k=apXhqyd1-V_wt5WpQR=NXiTAQQ6gYmMGH-yg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] iio: accel: adxl313: add activity sensing
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
> Add support for configuring an activity detection threshold. Extend the
> interrupt handler to process activity-related interrupts, and provide
> functions to set the threshold as well as to enable or disable activity
> sensing. Additionally, introduce a virtual channel that represents the
> logical AND of the x, y, and z axes in the IIO channel.
>
> This patch serves as a preparatory step; some definitions and functions
> introduced here are intended to be extended later to support inactivity
> detection.

...

> +static int adxl313_is_act_inact_en(struct adxl313_data *data,
> +                                  enum adxl313_activity_type type)
> +{
> +       unsigned int axis_ctrl;
> +       unsigned int regval;
> +       int axis_en, ret;
> +
> +       ret =3D regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axi=
s_ctrl);
> +       if (ret)
> +               return ret;
> +
> +       axis_en =3D FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);

> +

Remove this blank line. If needed, can be added later.

> +       if (!axis_en)
> +               return false;
> +
> +       /* Check if specific interrupt is enabled */
> +       ret =3D regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval=
);
> +       if (ret)
> +               return ret;
> +
> +       return adxl313_act_int_reg[type] & regval;
> +}

--=20
With Best Regards,
Andy Shevchenko

