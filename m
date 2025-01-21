Return-Path: <linux-iio+bounces-14521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A22A18784
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 22:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DD8188AD8F
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2025 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F51F8674;
	Tue, 21 Jan 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfBYhOHe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9F1B85C5
	for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 21:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496489; cv=none; b=C5OonRgxmSLZt8a/Emdvwd/ioeKQ5tPl9RTrEORykngYETKGC6YQju1rx81b5Vxs1FW4xfgWERpKwZBUlkVgx+4spZQOQPz72J9RTCAyk74WSzobuHqN+DVkeZtlCfeuVPjLeUrx+eQAhvScpfGUv80Iud9pHPaiIyN3e3bLTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496489; c=relaxed/simple;
	bh=6TNqXFXpHc6RR+LGmK3wv8kG8eNpl3cPWFeTbBXSdsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XDRDVoPM70AJeSeECUO0ZkhzJc0rOuHL+yA3QtT4xrZGtVizFqRatbMvUUC10E3ZqRKwO2E8spa1d0vP5sxauwvoALQDuzYN36jczZRcf2oVfS23SCRxaGz0vWmFEDKhVp7MY/9WYC9guWfD/g1Pn6kFqrFdjkOs8R3PPg6kM+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HfBYhOHe; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51e2dfab53bso91923e0c.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Jan 2025 13:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737496487; x=1738101287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT7Dnwon8ic/aQseS1qJ2EhhKFIOthhQ8v/a18vKVHg=;
        b=HfBYhOHepfQM4rfft/p5kj27NcgTJS6R2kmvnTGejzUhVE9b7OSdhvJXTS45eFlLbd
         Dox5VQCag0A17obv8QrPFz2QyzdYtd/SNSdXTHZ5a7HJOi2I1qv4sqUXTIeL9YYUq1Hq
         75rChHca+aGZLrP6zwe181LwUT9MXr7EYhnP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496487; x=1738101287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT7Dnwon8ic/aQseS1qJ2EhhKFIOthhQ8v/a18vKVHg=;
        b=P+143K85dbDCF6JQES5jIWC5xTlO0mZYXfhl0J0zazH1bb7ODa27/Ikh1944OYDqB2
         +oaLPlx6KXiSj1JRy2DyuTQO83SEAGXmSi89XjmieWErJT4eAwoSWh+CgEj6LmCWdIkb
         1rUTKEZOKLrJ3n0RuMQeC6dAvXNem4LQmDfBAPmjkGw2Odjfuby+TgDAzY1hZk3zSHkP
         Upncb3uRU9POl9och+Cupu0kxlPi33YUd3dqNb2WMesyP536NhEkcEoUIfgSEOQdIMD4
         mJQdOTWFxgshh7l+ijl1gxDd0Xg62lgynrCvmOzMnKe6LKnRk+MtuLoDj2OrDD6AHEyR
         4JxA==
X-Forwarded-Encrypted: i=1; AJvYcCUecTEoa4CNKsElWwrK7U6RBdsM7GvJF89teexGO5pkw6XEWPfnITH8broVQ4AXzeUMNhEhrr1O6C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE9s7hN2h5R6LPC90n1iJAOv/9FCdYeXQqxq3bQMSSpfwyEYro
	wHUpsCiyCkcvGdeF6fPph1yYJ6USgTpgjwhtgt4w4hCbUQn8KO2ctHIVL84jK0PwWo4R0QDQ2SR
	mf4wQWWD7k/Caq/O0IuSXX2oXQea6mDmsPQNb
X-Gm-Gg: ASbGncs+uJztK8i6lCGtg1p/b2Q9VFOshmrv4iq1n6/osSphSTS0xyAQrZAejs7hRf9
	VTvSkgewKpuWKIGiOjo3lUCbl5zWM67BjytumxZCMUSRhwiyOP3tUZnEJ0v2KLCxhGn/8RlXr3o
	Q=
X-Google-Smtp-Source: AGHT+IH3FPMSAPEkL8eouiZXxIgSUumgoOhfPf16T5kb+rzfXpH5YKSUU2Yn9KjyudciHjlPfsm6O+YuslekyWMUFP8=
X-Received: by 2002:a05:6122:3c90:b0:516:1ab2:9955 with SMTP id
 71dfb90a1353d-51d5b2fd549mr15743269e0c.6.1737496486894; Tue, 21 Jan 2025
 13:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117230136.2237346-1-gwendal@chromium.org>
 <20250118162748.6badf0ab@jic23-huawei> <Z44OaSCdFeCygJLQ@google.com>
In-Reply-To: <Z44OaSCdFeCygJLQ@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 21 Jan 2025 13:54:31 -0800
X-Gm-Features: AbW1kvYoqdMUDAXl0Mjkr3TFACjRPAveinuYgENG19TRPCbP8y4R9aM_7bk2P8w
Message-ID: <CAPUE2utb_L0rhjN6BdY2WEOX3i48DiTAkytY=WLgjbymrZc6Tw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec: Trace EC sensors command
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 12:50=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Sat, Jan 18, 2025 at 04:33:52PM +0000, Jonathan Cameron wrote:
> > I briefly applied this, but...
> >
> > [jic23@jic23-huawei iio]$ make LOCALVERSION=3D W=3D1 -j12  C=3D1
> > mkdir -p /home/jic23/src/kernel/iio/tools/objtool && make O=3D/home/jic=
23/src/kernel/iio subdir=3Dtools/objtool --no-print-directory -C objtool
> >   CALL    scripts/checksyscalls.sh
> >   INSTALL libsubcmd_headers
> >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
> >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
> > In file included from drivers/iio/common/cros_ec_sensors/cros_ec_sensor=
s_trace.h:56,
> >                  from drivers/iio/common/cros_ec_sensors/cros_ec_sensor=
s_trace.c:32:
> > ./include/trace/define_trace.h:106:42: fatal error: ./cros_ec_sensors_t=
race.h: No such file or directory
> >   106 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> >       |                                          ^
> >
> > Despite dealing with trace points a lot in the day job
> > I still find them hard to actually add to a subsystem because
> > of fun things like this one.
I reproduced this error on a fresh kernel source tree. I suspect an
issue with sparse, as other trace.c files use __CHECKER__ macros. For
instance `drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c`:

 10 /* sparse doesn't like tracepoint macros */
 11 #ifndef __CHECKER__
...

Will test more and send a V4.
Gwendal.
>
> Weird, I did the same test without seeing the error:
>
> $ make O=3Dbuild_dir W=3D1 allmodconfig \
>         drivers/iio/common/cros_ec_sensors/cros-ec-sensors-core.o
> ...
>   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
>   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
>   LD [M]  drivers/iio/common/cros_ec_sensors/cros-ec-sensors-core.o

