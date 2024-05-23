Return-Path: <linux-iio+bounces-5214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B558CD27A
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 14:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58291C20C34
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2BC14A4C5;
	Thu, 23 May 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4aMC9y6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA32E2AD00;
	Thu, 23 May 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716468305; cv=none; b=EoklYVV+IabyDzBcUQg2GGJrSO3Hei6vTVb9foCqH6qNzdYl7ll4Q/IXryed2+MNv4xhGvfguX61WYMaa/29yIr4uKrl0v6wQi2u1tOrOryhGdJDCY0nEa/2DEV1/HKMYIOTAHLsmcSpdhIXiGLqIJBMLzVMQITLnDA3405T7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716468305; c=relaxed/simple;
	bh=q+Inqa6RiwJufQfw8Jn5LPYLy3oolTiQhCLr3UU3LHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rrmhSwafGiUAts2fToBBCEEMyO5k/41k6HB5T0ZiXeMll/cRnX5E5yvs0qUTlBrLRam0q/oBBq37UT39WbpeMfeLUwvmo3nbkbKUXQ/0F8K1WjV6FjoAHjdA/cGFq2t69PmaELWXqF6ADxjgEYHE0FOSXCpG5akkOGK4MWJsnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4aMC9y6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42011507a57so55519935e9.1;
        Thu, 23 May 2024 05:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716468302; x=1717073102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q+Inqa6RiwJufQfw8Jn5LPYLy3oolTiQhCLr3UU3LHc=;
        b=a4aMC9y6i6EA+fPaIXW69UUaSL/q8RE56AQD0P+zZRhWCNxPWwADXiTgH4nVF9kh3H
         B21whQLNsKfeCHKdCtM6bi+kM2Brpu7kmE1qoydJm4QVb3EvXD+XHv9gIfvTq4NuE5Nh
         DUK3IT1Bdks+5R32U3aZte9GlPAs2n8bZY0V9wzh+Ebps9a/wWPTbIFEHrRpnMJYX3HX
         HGHqupKizF5yqb7u24PhK+wrljOKufRcN9+eyxnUo9bpzQtLPMPcEVA1XZQAJdXBzJ5L
         1m7FBeCWPf4c4VSqcaeHsBpi9hrkDbYjUgA8x0AkUkBGc+25yGnycm4teZBIvLxUxb0N
         79bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716468302; x=1717073102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+Inqa6RiwJufQfw8Jn5LPYLy3oolTiQhCLr3UU3LHc=;
        b=I3zOlQEDob1vaKBjujKgSs7G275oPJAw/ESlQT5cAcaSC7Hxg7i3d8ALH23ibp5kpV
         FcssEsYiWazEZ2YvHPORUMVOX0ut/gFvHrIscQuQZHIZVD8AteG+cq3ZQDQ5/+53OMpq
         IrgYnmrUE35q+DG0UgyxegY07taAigIrQadXd+OpFcLUbP9Onz5RkIUAynURcZH2WH7R
         lTUvW84YQH2Aa3cVW3xmntdpgiILVq1mj2rI/js9ovfCfXd7MEHZuBpFKD3zKJXArUTW
         f5BFNChjksMe4Wmr7qHDE6kIxXY7UdLX9+wpH6iKsKmfhnVXV+QwBan8UZLcvTPF+0DE
         b3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWb4CJbI0Ff8bAtTdpkrQBgWBiE2Xa0tLe96owMVvs5I6LrjaCf1vtJvn2MbeOdy5xdkSZHqmXyLL/zQis6mygWCoOX1RYORqnZscebXenjAeqQ44MhRXLVagmZ95NYeES8nEgy3MQBdO0I9NOqP+VTuZ3Tqs4wHfFB6jmR+3da3A7duQ==
X-Gm-Message-State: AOJu0Yzop8OeQHTqC8LAJKi0kIpDNoBUB5ImvlRxINAaP58dlkqNMgRl
	hMiPKE6gjeRRFKpLvjmc60UhvVygdoZX2C+3WJ3Jn/bsl8uQFMyU
X-Google-Smtp-Source: AGHT+IGiIca8Tkg+zrizFLj3/kOBi8DDUuoFXIu7QhVkNMfllhT4WCwzOwze2LB2M2VawVuw4Jkhrg==
X-Received: by 2002:a7b:c84c:0:b0:41b:a8e8:3ff6 with SMTP id 5b1f17b1804b1-420fd303b7fmr42913905e9.11.1716468301861;
        Thu, 23 May 2024 05:45:01 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1f07bsm24556725e9.13.2024.05.23.05.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 05:45:01 -0700 (PDT)
Message-ID: <751faef385f81f8a2dd0dcc2acd2d4519bebebe5.camel@gmail.com>
Subject: Re: [PATCH v2 0/6] minor fixes and improvements
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 May 2024 14:45:01 +0200
In-Reply-To: <20240522150141.1776196-1-adureghello@baylibre.org>
References: <20240522150141.1776196-1-adureghello@baylibre.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 17:01 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> After testing this driver, add some minor fixes and improvements,
> as adding single channel variants support (ad3541r, ad3551r), also as a
> preparatory step to bigger future improvements related to fast-rate mode
> for this DAC family.
>=20
> Previous patches (v1, 3/3)
> https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@ba=
ylibre.org
> https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@ba=
ylibre.org/
> https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@ba=
ylibre.org/
>=20
> Angelo Dureghello (6):
> =C2=A0 dt-bindings: iio: dac: fix ad3552r gain parameter names
> =C2=A0 dt-bindings: iio: dac: add ad35xxr single output variants
> =C2=A0 iio: dac: ad3552r: add model data structure
> =C2=A0 iio: dac: ad3552r: add support for ad3541r and ad3551r
> =C2=A0 iio: dac: ad3552r: change AD3552R_NUM_CH define name
> =C2=A0 iio: dac: ad3552r: uniform structure names
>=20
> =C2=A0.../bindings/iio/dac/adi,ad3552r.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 43 ++++--
> =C2=A0drivers/iio/dac/ad3552r.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 140 ++++++++++++------
> =C2=A02 files changed, 128 insertions(+), 55 deletions(-)
>=20

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


