Return-Path: <linux-iio+bounces-17828-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F5A8117D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 18:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7D1BC20BF
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE73C2550B1;
	Tue,  8 Apr 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0L/9ORG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DA254B09
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127789; cv=none; b=W6iWzSp/qPfU+oVK7ImYvgYB6pu4HNfD12J+3J7vmNJSfvZ9saWgh0gZUPl0rK6yTle3wd6LK1jF/g5/DI5pWV/mmGv8rJVR4yyWrvzR7k8+hgbUlZdJ/F6RYwfOi3FwDCmTIu7YPbyrWubTCf8cpKfihiHv2YKBAgMZ7XTtJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127789; c=relaxed/simple;
	bh=SsbsF7KGX/EryEglMhWGujq9L4z4osJUyCBu6RILvQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvSq4oA9QkQO17ydTn7bZ9yYzKdbkUbSbnin8gzVN8X+LcH83A155pXolXvvBKJQjRFNmcMG41/Rvi0yrhghuaV4p4oncuA+4Rv6Za32dZR2omJyzldBloIGadvqZdGREfSn6t+V27XtAhbmlpQ6bsUDaGNkPiOnzNKmYP1KRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0L/9ORG; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-524125f6cadso5402312e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 08:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744127786; x=1744732586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AM/+ze0roZREPn6ppfFn1kwGBymFDwlbRv56FB2XFog=;
        b=h0L/9ORGhBLMvxzdZ4yQ0jCCVw4tXKDYs/nsNjEO9eJXbIM+xotriHomzMXEOMywPs
         +mOO4OlcgCOZr+2W990kC+Qwj7dKrANmAz+UxI7f8V3NgwSSNEd+HSmIPZhaKMmBAN9a
         ooqzUSV0o4qh4tWxbRT4zlpdotPSMgthdSOX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127786; x=1744732586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AM/+ze0roZREPn6ppfFn1kwGBymFDwlbRv56FB2XFog=;
        b=p70CDFX9QeTDF117GXFP4R3mDew82VrV6p94jpnAzHOKO91cB337UjnQOF1pAEBU7F
         bKldBusclOeLaPXEPzjeDNZA729vWRwoccSAq+qNKNmLrDu+dmD8ngkpR1rk068TJx1R
         DYCywS+6yTB0DBx0z0YRDCkM4fhKQE6v4XMoSwDJQeTrkUPoX9E1EFlnQksZpDLHXOCz
         KR/FOqEcgYB2E0FkFZokyDFdF5WpKdIudcQw5qIIvPlYHS2EQsGhGzLhtU0SJ5Xdnmvv
         ZNoEpbwHpihBKbc3Z8H1KylvYvAbvlD9udjh+85R88GwEy5A059d1AAVcSneQzlfJj+c
         bu7w==
X-Forwarded-Encrypted: i=1; AJvYcCU8nZYh6fCH6GCGG8gtgg0Jo7HNWUWGKwaYmeq4oP+ambhoO0itFQMAwdEbNgi8aBGviSAcBU3BqW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTVTWwuJkAYoIFdOC5dyP/5r01VXELaA2xXz66KR+xENkyx1i
	/nBzkhWSmakl+rT3UOVX7XSRfOEkaUbhQB3cUwQmAiEK6H/6wN77fohQv7e1313BZoyAHAj3y59
	pNYL+0w1+Avsae+SRyCwJo0nm0fBoiMl43zWv
X-Gm-Gg: ASbGncsXfHqeh6bjxxdnNV/+MTPFqWs4g8SPyC55P7ynzi9JO5h50R5xVaXntQcJidh
	AxaAuifviwAbtI5OnkNa+HV8w4WAKfKWJYlZVBsVY9ggXLAMo914PZ1Ptxqjb6seNpWBvf700Xz
	4MxvHcaRzxqBoxIa5DOVb0TNZEExgksjSt5bWBBzmfxMvsAd6vd9ao
X-Google-Smtp-Source: AGHT+IFYyAoCweRNfVg0Eb4XcmWkknHyVugsHXwiVWQe/fbO2tHXGAdvyfXp4bwwisjC4UC8IqhtPCRhfCDCo+/RJAI=
X-Received: by 2002:a05:6122:828d:b0:516:1ab2:9955 with SMTP id
 71dfb90a1353d-52765d2d52amr13537968e0c.6.1744127786500; Tue, 08 Apr 2025
 08:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPUE2uuY=BaPFro5cQSmQg4JS1Z5J5aBL7XvqqAo-X=LR4be3Q@mail.gmail.com>
 <20250408055412.1623257-1-gwendal@chromium.org> <Z_TXZT3SPEpTm6tc@google.com>
In-Reply-To: <Z_TXZT3SPEpTm6tc@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 8 Apr 2025 08:56:14 -0700
X-Gm-Features: ATxdqUEZN_bemcGEIflJoObVScAUucOJdbwr9cZYFcOZt1ojv8QO1Xx95dJLyFs
Message-ID: <CAPUE2us3WRVVLeqLs-wZgo7g3DspuAyJUMmBMjDvdegaQ+9aFw@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros_ec_sensors: Flush when changing the FIFO timeout
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:59=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Mon, Apr 07, 2025 at 10:54:11PM -0700, Gwendal Grignou wrote:
> > @@ -853,6 +859,16 @@ int cros_ec_sensors_core_write(struct cros_ec_sens=
ors_core_state *st,
> >               st->param.sensor_odr.roundup =3D 1;
> >
> >               ret =3D cros_ec_motion_send_host_cmd(st, 0);
> > +
> > +             /* Flush the FIFO in case we are stopping a sensor.
> > +              * If the FIFO has just been emptied, pending samples wil=
l be
> > +              * stuck until new samples are available. It will not hap=
pen
> > +              * when all the sensors are stopped.
> > +              */
> > +             if (ret >=3D 0 && frequency =3D=3D 0) {
>
> To disambiguate, `ret =3D=3D 0` or `!ret`[1].
Fixed in V3.
>
> [1]: https://elixir.bootlin.com/linux/v6.13/source/drivers/iio/common/cro=
s_ec_sensors/cros_ec_sensors_core.c#L411

