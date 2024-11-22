Return-Path: <linux-iio+bounces-12478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B89D5A2F
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 08:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24031F228E9
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 07:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991B917333D;
	Fri, 22 Nov 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NHY0JiJ4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4746165EE3
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261597; cv=none; b=FD2aybaezgMfZRr2VxsKq+lsr+smt+hFOauygzmjGX8PPiYM3dxUQdp4dNMYdxjthWP2x9Fqi8LfzHlzVYRNCuPnkHEZ+34bTylhLMzFgipUQxsOiYLfteQMul2dMqlPKmbhBGJc3km2lTjTkEvfs38DM39mmG/XJc8jRbM5x4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261597; c=relaxed/simple;
	bh=ZEt3yoR0cr5/kASiXDyIBRVJ5cVFZ2AeNaZON5w/kHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4Zba9NS5YE35nuxNyiDRk865oXSeY1HjyMj7RYx0aES7HPamYL4J3WzhQNocRPIdWxQYzXtdklSL11cjcTzdKAFFaISIbNp7XGgiBotpOowfAiCL7A0rXSdUrXD9083B20v3wLkel0MzBwVPgC0nSl0z1edvIcTsVf9VsgIZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NHY0JiJ4; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e600ae1664so1021735b6e.2
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732261595; x=1732866395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rV7OUDMMlgxjwFF1dF4a3L3rrV3TIom9pYtmVzZiP3c=;
        b=NHY0JiJ47UMbw2PSNSi5E91lwAY0+okVpjr1MQsq2a0Dl0vFF90frptAE+QOE+YOZa
         HhXlmFBk9cAjnSkU3pkgk/Hvm/1K/JTpyq40w7sqbcdKwWkHCrhwTTTsGxxY6P84SywQ
         Q3jxnbtvLOmlZbAHbl86Z3chjD/IhA4SmWOBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261595; x=1732866395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV7OUDMMlgxjwFF1dF4a3L3rrV3TIom9pYtmVzZiP3c=;
        b=WmshkElZCnrYf0BpBOj6W4fnok33sQc4eIaL8+L7ng+/JePqJe/LltCwKmLX1MjP6H
         y5ZpmklVznlWz33PrgqtNDGu9vxKlGaltfPTxyBqnUoKr2MoAxMN5WBamt/lbeg90fnK
         isU4S9lCmWxJWiItL777JE+ststeKeA0eo81pzvT0STMLLsXpQfFTvHusNhhLoxc6jjz
         rI3BExL83yh9EAWr2rYBb0ctJi3mtMvo9tL1m3kR4zmYW8tkvjOf27OXbdvnShPHAwhJ
         R56Gjt1ig6xWRtMBVRPKKb3r73JJAVPgb2aeLJ7OPu0vDcZfWNPFvC2zMqbCJcDZRgAI
         53lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXPODM9N2JeQ8vVGrOuYYaVHks1sexYFEw+NLJBz6BRvvfFy//Cx8o/ueu6l8wFk0BAd9H4RXrCqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnUlV77PakmEYcR8HHGptMfclrRk4awcQVxkwSY+Df1JSl2Ba
	U05YOLMlSDiSXaJXQqNwJVukBNrkaeH8E0UYhFt3UWM7YzX1CKb4h6xLvKteo9aPZ7hzIdagX2s
	=
X-Gm-Gg: ASbGncvITu2I4Lvh1cEAY0NVGiWtXrinXIDoP0qsfceMRhKviwlflyfSzDqadKtfwfb
	MlnSAz8SIC6B4dn0nQWZJw46SVhSi2/uoIL4RFsTMyzw/4A3BpedBfUvlIXOi3knMI6hJwZ6+bO
	soshSGt2wBWtBksKZ2CxQxshqHNrhLMlrDwKuYmpDevS5Z6Ca+UP04v0URAw7Sjr8BNffkZQlpe
	E7NcUzHziDzmiCIVB6nKmdtglIjaIGysw4n/aCkWeSmnUEo0XUbVZbMh/Q2sDHN57kJKXELpuWh
	9Z7euOo95XbzW7vW
X-Google-Smtp-Source: AGHT+IEDXwnXc2cTK5VaDrgTdOtq1p0oCzT71M5jOd/F7lIJx36WarZ7fOlWbqZyQRLCCzvWD2kK2w==
X-Received: by 2002:a05:6808:244d:b0:3e7:6199:3caa with SMTP id 5614622812f47-3e9157a352fmr2714756b6e.2.1732261594792;
        Thu, 21 Nov 2024 23:46:34 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531315sm1030877b3a.100.2024.11.21.23.46.33
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 23:46:33 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720c2db824eso1805038b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 23:46:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0kEXtaJ8mxZtJhdWzlBh4hegdKouPDXBXRBSxRFFW8hl8nfYa/ijHby7/LO845BDLPag42uF68ks=@vger.kernel.org
X-Received: by 2002:a05:6a20:3949:b0:1dc:2365:a114 with SMTP id
 adf61e73a8af0-1e09e4b19b9mr2861897637.24.1732261593103; Thu, 21 Nov 2024
 23:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org> <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
In-Reply-To: <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 08:46:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
Message-ID: <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Fix invalid read_raw for attention
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 17:44, srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2024-11-21 at 09:16 +0000, Ricardo Ribalda wrote:
> > The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> > IIO_CHAN_INFO_RAW.
> >
> > Modify prox_read_raw() to support it.
> >
> What is the sysfs entry to trigger this IIO_CHAN_INFO_PROCESSED read?
> Don't you have an entry *_raw?

/sys/.../iio:deviceX/in_attention_input

There is no _raw device for it.

>
>
> Thanks,
> Srinivas
>
> > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> > channels")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/iio/light/hid-sensor-prox.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > b/drivers/iio/light/hid-sensor-prox.c
> > index e8e7b2999b4c..8e5d0ad13a5f 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
> >       *val2 = 0;
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > +     case IIO_CHAN_INFO_PROCESSED:
> >               if (chan->scan_index >= prox_state->num_channels)
> >                       return -EINVAL;
> >               address = prox_state->channel2usage[chan-
> > >scan_index];
> > @@ -107,8 +108,7 @@ static int prox_read_raw(struct iio_dev
> > *indio_dev,
> >
> > report_id,
> >
> > SENSOR_HUB_SYNC,
> >                                                          min < 0);
> > -             if (prox_state->channel2usage[chan->scan_index] ==
> > -                 HID_USAGE_SENSOR_HUMAN_ATTENTION)
> > +             if (mask == IIO_CHAN_INFO_PROCESSED)
> >                       *val *= 100;
> >               hid_sensor_power_state(&prox_state-
> > >common_attributes, false);
> >               ret_type = IIO_VAL_INT;
> >
> > ---
> > base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> > change-id: 20241121-fix-processed-ed1a95641e64
> >
> > Best regards,
>


-- 
Ricardo Ribalda

